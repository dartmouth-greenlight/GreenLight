//
//  CameraViewController.swift
//  GreenLight
//
//  Created by Jack Desmond on 5/11/22.
//  Authored by Tucker Simpson and Jack Desmond
//

import UIKit
import AVFoundation
import Vision
import OrderedCollections

class CameraViewController: UIViewController {
    // MARK: - UI objects
    var previewView: PreviewView!
    var cutoutView: UIView!
    var idView: UILabel!     //pretty sure this is the box that comes w ID
    var maskLayer = CAShapeLayer()
    // Device orientation. Updated whenever the orientation changes to a
    // different supported orientation.
    var currentOrientation = UIDeviceOrientation.portrait
    
    // MARK: - Capture related objects
    private let captureSession = AVCaptureSession()
    let captureSessionQueue = DispatchQueue(label: "com.example.apple-samplecode.CaptureSessionQueue")
    
    var captureDevice: AVCaptureDevice?
    
    var videoDataOutput = AVCaptureVideoDataOutput()
    let videoDataOutputQueue = DispatchQueue(label: "com.example.apple-samplecode.VideoDataOutputQueue")
    
    // MARK: - Region of interest (ROI) and text orientation
    // Region of video data output buffer that recognition should be run on.
    // Gets recalculated once the bounds of the preview layer are known.
    var regionOfInterest = CGRect(x: 0, y: 0, width: 1, height: 1)
    // Orientation of text to search for in the region of interest.
    var textOrientation = CGImagePropertyOrientation.up
    
    // MARK: - Coordinate transforms
    var bufferAspectRatio: Double!
    // Transform from UI orientation to buffer orientation.
    var uiRotationTransform = CGAffineTransform.identity
    // Transform bottom-left coordinates to top-left.
    var bottomToTopTransform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)
    // Transform coordinates in ROI to global coordinates (still normalized).
    var roiToGlobalTransform = CGAffineTransform.identity
    
    // Vision -> AVF coordinate transform.
    var visionToAVFTransform = CGAffineTransform.identity
    
    // MARK: - View controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Creat and add tap gesture listener
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        // Set up preview view.
        previewView = PreviewView()
        view.addSubview(previewView)
        previewView.translatesAutoresizingMaskIntoConstraints = false
        previewView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        previewView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        previewView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        previewView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        previewView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        previewView.session = captureSession
        previewView.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        
        // Set up cutout view.
        cutoutView = UIView()
        view.addSubview(cutoutView)
        cutoutView.translatesAutoresizingMaskIntoConstraints = false
        cutoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        cutoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        cutoutView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        cutoutView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        cutoutView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        cutoutView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        cutoutView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.fillRule = .evenOdd
        cutoutView.layer.mask = maskLayer
        
        // Set up id view.
        idView = UILabel()
        view.addSubview(idView)
        idView.translatesAutoresizingMaskIntoConstraints = false
        idView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        idView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        idView.textAlignment = .center
        idView.layer.cornerRadius = 50
        idView.layer.masksToBounds = true
        
        // Starting the capture session is a blocking call. Perform setup using
        // a dedicated serial dispatch queue to prevent blocking the main thread.
        captureSessionQueue.async {
            self.setupCamera()
            self.toggleFlash()
            
            // Calculate region of interest now that the camera is setup.
            DispatchQueue.main.async {
                // Figure out initial ROI.
                self.calculateRegionOfInterest()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        // Only change the current orientation if the new one is landscape or
        // portrait. You can't really do anything about flat or unknown.
        let deviceOrientation = UIDevice.current.orientation
        if deviceOrientation.isPortrait || deviceOrientation.isLandscape {
            currentOrientation = deviceOrientation
        }
        
        // Handle device orientation in the preview layer.
        if let videoPreviewLayerConnection = previewView.videoPreviewLayer.connection {
            if let newVideoOrientation = AVCaptureVideoOrientation(deviceOrientation: deviceOrientation) {
                videoPreviewLayerConnection.videoOrientation = newVideoOrientation
            }
        }
        
        // Orientation changed: figure out new region of interest (ROI).
        calculateRegionOfInterest()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCutout()
    }
    
    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }

        do {
            try device.lockForConfiguration()

            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }

            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    
    // MARK: - Setup
    
    func calculateRegionOfInterest() {
        // In landscape orientation the desired ROI is specified as the ratio of
        // buffer width to height. When the UI is rotated to portrait, keep the
        // vertical size the same (in buffer pixels). Also try to keep the
        // horizontal size the same up to a maximum ratio.
        let desiredHeightRatio = 0.5398
        let desiredWidthRatio = 0.856
        let maxPortraitWidth = 0.8
        
        // Figure out size of ROI.
        let size: CGSize
        if currentOrientation.isPortrait || currentOrientation == .unknown {
            size = CGSize(width: min(desiredWidthRatio * bufferAspectRatio, maxPortraitWidth), height: desiredHeightRatio / bufferAspectRatio)
        } else {
            size = CGSize(width: desiredWidthRatio, height: desiredHeightRatio)
        }
        // Make it centered.
        regionOfInterest.origin = CGPoint(x: (1 - size.width) / 2, y: (1 - size.height) / 2)
        regionOfInterest.size = size
                
        // ROI changed, update transform.
        setupOrientationAndTransform()
        
        // Update the cutout to match the new ROI.
        DispatchQueue.main.async {
            // Wait for the next run cycle before updating the cutout. This
            // ensures that the preview layer already has its new orientation.
            self.updateCutout()
        }
    }
    
    func updateCutout() {
        // Figure out where the cutout ends up in layer coordinates.
        let roiRectTransform = bottomToTopTransform.concatenating(uiRotationTransform)
        
        let cutout = previewView.videoPreviewLayer.layerRectConverted(fromMetadataOutputRect: regionOfInterest.applying(roiRectTransform))
        
        // Create the mask.
        let path = UIBezierPath(roundedRect: cutoutView.frame, cornerRadius:10)
        path.append(UIBezierPath(roundedRect: cutout, cornerRadius:10))
        maskLayer.path = path.cgPath
        
        // Move the ID view down to under cutout.
        //TODO: Change Properties of idFrame to change idView
        var idFrame = cutout
        idFrame.origin.y += idFrame.size.height
        idView.frame = CGRect(x: cutout.midX-150, y: cutout.origin.y + cutout.size.height + 50, width: 300, height: 100);
    }
    
    func setupOrientationAndTransform() {
        // Recalculate the affine transform between Vision coordinates and AVF coordinates.
        
        // Compensate for region of interest.
        let roi = regionOfInterest
        roiToGlobalTransform = CGAffineTransform(translationX: roi.origin.x, y: roi.origin.y).scaledBy(x: roi.width, y: roi.height)
        
        // Compensate for orientation (buffers always come in the same orientation).
        switch currentOrientation {
        case .landscapeLeft:
            textOrientation = CGImagePropertyOrientation.up
            uiRotationTransform = CGAffineTransform.identity
        case .landscapeRight:
            textOrientation = CGImagePropertyOrientation.down
            uiRotationTransform = CGAffineTransform(translationX: 1, y: 1).rotated(by: CGFloat.pi)
        case .portraitUpsideDown:
            textOrientation = CGImagePropertyOrientation.left
            uiRotationTransform = CGAffineTransform(translationX: 1, y: 0).rotated(by: CGFloat.pi / 2)
        default: // We default everything else to .portraitUp
            textOrientation = CGImagePropertyOrientation.right
            uiRotationTransform = CGAffineTransform(translationX: 0, y: 1).rotated(by: -CGFloat.pi / 2)
        }
        
        // Full Vision ROI to AVF transform.
        visionToAVFTransform = roiToGlobalTransform.concatenating(bottomToTopTransform).concatenating(uiRotationTransform)
    }
    
    func setupCamera() {
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) else {
            print("Could not create capture device.")
            return
        }
        self.captureDevice = captureDevice
        
        // NOTE:
        // Requesting 4k buffers allows recognition of smaller text but will
        // consume more power. Use the smallest buffer size necessary to keep
        // down battery usage.
        if captureDevice.supportsSessionPreset(.hd4K3840x2160) {
            captureSession.sessionPreset = AVCaptureSession.Preset.hd4K3840x2160
            bufferAspectRatio = 3840.0 / 2160.0
        } else {
            captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080
            bufferAspectRatio = 1920.0 / 1080.0
        }
        
        guard let deviceInput = try? AVCaptureDeviceInput(device: captureDevice) else {
            print("Could not create device input.")
            return
        }
        if captureSession.canAddInput(deviceInput) {
            captureSession.addInput(deviceInput)
        }
        
        // Configure video data output.
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]
        if captureSession.canAddOutput(videoDataOutput) {
            captureSession.addOutput(videoDataOutput)
            // NOTE:
            // There is a trade-off to be made here. Enabling stabilization will
            // give temporally more stable results and should help the recognizer
            // converge. But if it's enabled the VideoDataOutput buffers don't
            // match what's displayed on screen, which makes drawing bounding
            // boxes very hard. Disable it in this app to allow drawing detected
            // bounding boxes on screen.
            videoDataOutput.connection(with: AVMediaType.video)?.preferredVideoStabilizationMode = .off
        } else {
            print("Could not add VDO output")
            return
        }
        
        // Set zoom and autofocus to help focus on very small text.
        do {
            try captureDevice.lockForConfiguration()
            captureDevice.videoZoomFactor = 2
            captureDevice.autoFocusRangeRestriction = .near
            captureDevice.unlockForConfiguration()
        } catch {
            print("Could not set zoom level due to error: \(error)")
            return
        }
        
        captureSession.startRunning()
    }
    
    // MARK: - UI drawing and interaction --> where we check green vs. yellow vs. red
    
    func showString(string: String) {
        // Found a definite ID.
        // Stop the camera synchronously to ensure that no further buffers are
        // received. Then update the ID view asynchronously.
        captureSessionQueue.sync {
            self.captureSession.stopRunning()
            DispatchQueue.main.async {
                // Green case:
                if(socialDict[string] != nil){
                    print("here")
                    self.cutoutView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
                    self.idView.backgroundColor = UIColor.green.withAlphaComponent((0.5))
                    self.idView.text = socialDict[string]
                }
                // Red case:
                else if(blackDict[string] != nil){
                    self.cutoutView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
                    self.idView.backgroundColor = UIColor.red.withAlphaComponent((0.5))
                    self.idView.text = blackDict[string]
                }
                // Yellow case:
                else{
                    self.cutoutView.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
                    self.idView.backgroundColor = UIColor.yellow.withAlphaComponent((0.5))
                    self.idView.text = getName(id: string)
                }
                
               // self.idView.text = string
                self.idView.isHidden = false
            }
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        captureSessionQueue.async {
            if !self.captureSession.isRunning {
                self.captureSession.startRunning()
            }
            DispatchQueue.main.async {
                self.idView.isHidden = true
                self.cutoutView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
            }
        }
    }
}



// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // This is implemented in VisionViewController.
    }
}

// MARK: - Utility extensions

extension AVCaptureVideoOrientation {
    init?(deviceOrientation: UIDeviceOrientation) {
        switch deviceOrientation {
        case .portrait: self = .portrait
        case .portraitUpsideDown: self = .portraitUpsideDown
        case .landscapeLeft: self = .landscapeRight
        case .landscapeRight: self = .landscapeLeft
        default: return nil
        }
    }
}


