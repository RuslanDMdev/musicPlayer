//
//  ViewController.swift
//  musicPlayer
//
//  Created by Ruslan Dalgatov on 03.10.2022.
//

import UIKit
import SnapKit
import MediaPlayer

class ViewController: UIViewController {

    var player: AVPlayer!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var buttonPlay: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verstka()
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!))
        
        slider.maximumValue = Float(player.currentItem?.asset.duration.seconds ?? 0)
        
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: DispatchQueue.main) { time in
            self.label.text = "\(time.seconds)"
            self.slider.value = Float(time.seconds)
            
        }
        
    }
    
    func verstka(){
        
        buttonPlay.backgroundColor = .gray
        buttonPlay.setTitle("Play", for: .normal)
        buttonPlay.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
    }
    
    @IBAction func playAction(_ sender: Any) {
        if player.timeControlStatus == .playing {
        player.pause()
            buttonPlay.setTitle("Play", for: .normal)
        } else {
            player.play()
            buttonPlay.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func sliderAction(_ sender: Any) {
        player.seek(to: CMTime(seconds: Double(slider.value), preferredTimescale: 1000))
        self.label.text = "\(slider.value)"
    }
    
}

