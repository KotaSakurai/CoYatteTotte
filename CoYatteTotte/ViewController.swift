//
//  ViewController.swift
//  CoYatteTotte
//
//  Created by 桜井広大 on 2020/02/13.
//  Copyright © 2020 KotaSakurai. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseAnalytics

class ViewController: UIViewController {
    enum Status {
        case none
        case preview
        case saving
    }
    
    let context = CIContext()
    let CrystallizeFilter = CIFilter(name: "CIPhotoEffectInstant")
    
    var captureSession = AVCaptureSession()
    var mainCamera: AVCaptureDevice?
    // インカメの管理オブジェクトの作成
    var innerCamera: AVCaptureDevice?
    // 現在使用しているカメラデバイスの管理オブジェクトの作成
    var currentDevice: AVCaptureDevice?

    // キャプチャーの出力データを受け付けるオブジェクト
    var photoOutput : AVCapturePhotoOutput?
    @IBOutlet weak var cameraButton: UIButton!
    // プレビュー表示用のレイヤ
    let cameraPreviewLayer : AVCaptureVideoPreviewLayer = .init()

    var previewImage =  UIImageView()
    
    let headerView: HeaderView = .init()
 
    let previewImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let cameraImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var status: Status = .none
        
    let slider: UISlider = {
        let view = UISlider.init()
        view.maximumValue = 1
        view.minimumValue = 0
        view.value = 0.5
        view.minimumTrackTintColor = .brandColor
        view.maximumTrackTintColor = UIColor.white
        view.thumbTintColor = .brandColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let resetButton: UIButton = {
        let view = UIButton.init()
        view.setTitle("Reset", for: .normal)
        view.setTitleColor(.brandColor, for: .normal)
        view.titleLabel?.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    @IBOutlet weak var Policy: UITextView!

    @objc func sliderValue(_ sender: UISlider) {
//        let sliderValue:Int = Int(sender.value)
//        alpha.text = String(sender.value)
        previewImageView.alpha = CGFloat(sender.value)
    }
    
    @objc func deleteView(_ sender: Any) {
        previewImageView.isHidden = true
        status = .none
        slider.isHidden = true
    }
    
    @objc func openSettings() {
        let settings = SettingsViewController.init()
        
        present(settings, animated: true, completion: nil)
    }
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // preview
        self.view.addSubview(cameraImageView)
        self.view.addSubview(previewImageView)
        self.view.addSubview(slider)
        self.view.addSubview(resetButton)
        self.view.addSubview(headerView)

        // Settings
        self.slider.addTarget(self, action: #selector(sliderValue), for: .valueChanged)
        self.resetButton.addTarget(self, action: #selector(deleteView), for: .touchDown)
        self.headerView.menuButton.addTarget(self, action: #selector(openSettings), for: .touchDown)

        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        captureSession.startRunning()
        styleCaptureButton()

        let height: CGFloat = view.bounds.width * (4 / 3)
        self.cameraPreviewLayer.frame = CGRect.init(origin: .zero, size: CGSize.init(width: view.bounds.width, height: height))
//        self.cameraImageView.layer.insertSublayer(self.cameraPreviewLayer, at: 0)

        NSLayoutConstraint.activate([
            previewImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            previewImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            previewImageView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            previewImageView.heightAnchor.constraint(equalToConstant: height),
            cameraImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            cameraImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            cameraImageView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            cameraImageView.heightAnchor.constraint(equalToConstant: height),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            slider.topAnchor.constraint(equalTo: cameraImageView.bottomAnchor, constant: 10),
            cameraButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            cameraButton.widthAnchor.constraint(equalToConstant: 60),
            cameraButton.heightAnchor.constraint(equalToConstant: 60),
            resetButton.leadingAnchor.constraint(equalTo: cameraButton.trailingAnchor, constant: 10),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            resetButton.centerYAnchor.constraint(equalTo: cameraButton.centerYAnchor, constant: 0),
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
        ])
    }
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    
    
    @IBAction func cameraButton_TouchUpInside(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        // フラッシュの設定
//        settings.flashMode = .auto
        // カメラの手ぶれ補正
        // settings.isAutoStillImageStabilizationEnabled = true
        // 撮影された画像をdelegateメソッドで処理
        self.photoOutput?.capturePhoto(with: settings, delegate: self)
    }
}

//MARK: AVCapturePhotoCaptureDelegateデリゲートメソッド
extension ViewController: AVCapturePhotoCaptureDelegate{

    // 撮影した画像データが生成されたときに呼び出されるデリゲートメソッド
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(), let uiImage = UIImage(data: imageData) {
            
            let filterdImage = CIImage(image: uiImage)!
            
            CrystallizeFilter!.setValue(filterdImage, forKey: kCIInputImageKey)
            
            let cgImage = self.context.createCGImage(CrystallizeFilter!.outputImage!, from: filterdImage.extent)!

            let uiImageFilteredImage = UIImage(cgImage: cgImage, scale: 0,orientation: uiImage.imageOrientation)
            
            if status == .none {
                previewImageView.image = uiImageFilteredImage
                previewImageView.alpha = 0.5
                previewImageView.isHidden = false
                self.status = .preview
                self.slider.isHidden = false
                
                Analytics.logEvent("Preview", parameters: [
                  "type": "ShotPreviewButton" as NSObject,
                ])
                
                return
            }

            // 写真ライブラリに画像を保存
            UIImageWriteToSavedPhotosAlbum(uiImageFilteredImage, nil,nil,nil)
            
            Analytics.logEvent("Save", parameters: [
              "type": "ShotSaveButton" as NSObject,
            ])
        }
    }
}
    
//MARK: カメラ設定メソッド
extension ViewController{

    // カメラの画質の設定
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    // デバイスの設定
    func setupDevice() {
        // カメラデバイスのプロパティ設定
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        // プロパティの条件を満たしたカメラデバイスの取得
        let devices = deviceDiscoverySession.devices

        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                mainCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                innerCamera = device
            }
        }
        // 起動時のカメラを設定
        currentDevice = mainCamera
    }
    
    
    // 入出力データの設定
    func setupInputOutput() {
        do {
            // 指定したデバイスを使用するために入力を初期化
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
            // 指定した入力をセッションに追加
            captureSession.addInput(captureDeviceInput)
            // 出力データを受け取るオブジェクトの作成
            photoOutput = AVCapturePhotoOutput()
            
            // 出力ファイルのフォーマットを指定
            photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
            
            let videoOutput: AVCaptureVideoDataOutput = .init()
            captureSession.addOutput(videoOutput)
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
            captureSession.addOutput(photoOutput!)
            if let connection = videoOutput.connection(with: .video) {
                connection.videoOrientation = .portrait
            }
        } catch {
            print(error)
        }
    }
    
    
    // カメラのプレビューを表示するレイヤの設定
    func setupPreviewLayer() {
        // 指定したAVCaptureSessionでプレビューレイヤを初期化
        self.cameraPreviewLayer.session = captureSession
        // プレビューレイヤが、カメラのキャプチャーを縦横比を維持した状態で、表示するように設定
        self.cameraPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        // プレビューレイヤの表示の向きを設定
        self.cameraPreviewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
    }


    // ボタンのスタイルを設定
    func styleCaptureButton() {
        cameraButton.layer.borderColor = UIColor.brandColor.cgColor
        cameraButton.layer.backgroundColor = UIColor.brandColor.cgColor
        cameraButton.layer.borderWidth = 5
        cameraButton.clipsToBounds = true
        cameraButton.layer.cornerRadius = min(cameraButton.frame.width, cameraButton.frame.height) / 2
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let cameraImage = CIImage(cvImageBuffer: imageBuffer!)
        
        CrystallizeFilter!.setValue(cameraImage, forKey: kCIInputImageKey)

        let cgImage = self.context.createCGImage(CrystallizeFilter!.outputImage!, from: cameraImage.extent)!

        DispatchQueue.main.async {
            let filteredImage = UIImage(cgImage: cgImage)
            self.cameraImageView.image = filteredImage
        }
    }
}
