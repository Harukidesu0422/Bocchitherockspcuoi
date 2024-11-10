//
//  ViewController.swift
//  Bocchitherock!
//
//  Created by Nguyen Haruki on 10/11/24.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var huohuo: UIImageView!
    var imageIndex = 1
    func updateImage () {
        huohuo.image = UIImage(named: "huohuo\(imageIndex)")
        print ("huohuo\(imageIndex)")}
        //update ảnh
    @IBAction func nextImage (_ sender: Any){
        if (imageIndex) <= 5 {
            imageIndex += 1
        }
        else if imageIndex == 6 {
            imageIndex = 1
        }
        else if imageIndex >= 7 && imageIndex < 37 {
            imageIndex += 1
        }
        else if imageIndex == 37 {
            imageIndex = 7
        }
        else if imageIndex >= 38 && imageIndex < 132  {
            imageIndex += 1
        }
        else if imageIndex == 132 {
            imageIndex = 38
        }
        else if imageIndex  >= 133 && imageIndex < 151 {
            imageIndex += 1
        }
        else if imageIndex == 151 {
            imageIndex = 133
        }
        updateImage()
    }
    // Chuyển màn hình
    @IBAction func btnNext(_ sender: Any) {
    }
    // PLay and Pause
    @IBOutlet weak var btnToggle: UIButton!
    var isAnimating:Bool = false
    @IBOutlet weak var btnNextImage: UIButton!
    @IBAction func btnToggleAnimation(_ sender: Any) {
        // đang phát, bấm để dừng
        if (isAnimating) {
            isAnimating = false
            btnToggle.setTitle("Pause", for: .normal)
            btnToggle.tintColor = .systemGray
            startAnimation()
        }
        // đang dừng , bấm để phát
        else{
            isAnimating = true
            btnToggle.setTitle("Play!", for: .normal)
            btnToggle.tintColor = .systemBlue
            pauseAnimation()
        }
    }
    func startAnimation () {
        startTimer()
        if isSoundOn {
            audioPlayer?.play()
        }
        updateImage()
    }
    func pauseAnimation () {
        stopTimer()
        audioPlayer?.stop()
    }
    // khai báo timer
    var timer: Timer?
    func startTimer () {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {[weak self] timer in
            guard let self = self else { return }
            self.nextImage (self.btnNextImage!)
        }
    }
    func stopTimer () {
        timer?.invalidate()
        timer = nil
    }

    
    // unwind, truyền thông tin
    
    @IBOutlet weak var musicNotifi: UILabel!
    @IBAction func unwindtoVCAnimate (_ unwindSergue: UIStoryboardSegue){
        if let sourceViewController = unwindSergue.source as? VCSoundTable {
            if let selectedSound = sourceViewController.selectedSound {
                musicNotifi.text = "Sound selected: \(selectedSound)"
                soundName = selectedSound
                prepareAudioPlayer()
                if swToggleSound.isOn {
                    audioPlayer?.play()
                }
                if selectedSound == "Gió đưa Jing Bố về trời" {
                 imageIndex = 1
                }
                else if  selectedSound == "Ichiban kagayaku hoshi"{
                    imageIndex = 7
                }
                else if selectedSound == "Haru" {
                    imageIndex = 38
                }
                else if selectedSound == "There is a reason" {
                    imageIndex = 133
                }
            }
        }
        
    }
    // audio
   var audioPlayer: AVAudioPlayer!
    var soundName: String = "Gió đưa Jing Bố về trời"
    var isSoundOn: Bool = false
    @IBOutlet weak var swToggleSound: UISwitch!
    @IBAction func toggleSound(_ sender: Any) {
        if isSoundOn {
            isSoundOn = false
            audioPlayer?.stop()
        }
        else {
            isSoundOn = true
            audioPlayer?.play()
        }
        swToggleSound.isOn = isSoundOn
    }
    func prepareAudioPlayer() {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        else {
            print("Music file is not found!")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
            print("\(soundName) will be played!")
        } catch {
            print("Error initializing AVAudioPlayer: \(error.localizedDescription)")
        }
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageIndex = 1
        updateImage()
        isAnimating = true
        btnToggle.setTitle("Play!", for: .normal)
        btnToggle.tintColor = .systemBlue
        isSoundOn = true 
        //startTimer ()
        swToggleSound?.isOn = isSoundOn
    }
}

