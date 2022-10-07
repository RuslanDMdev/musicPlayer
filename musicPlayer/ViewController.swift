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
    @IBOutlet weak var buttonNextSong: UIButton!
    @IBOutlet weak var buttonLastSong: UIButton!
    let image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(image)
        view.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1647058824, blue: 0.1882352941, alpha: 1)
        
        verstka()
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!))
        
        slider.maximumValue = Float(player.currentItem?.asset.duration.seconds ?? 0)
        
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: DispatchQueue.main) { [self] time in
                   self.slider.value = Float(time.seconds)
                   
                   let time = self.secondsToMinutesAndSeconds(seconds: slider.value)
                   let timeString = makeTimeString(minutes: time.0, seconds: time.1)
                   self.label.text = timeString
                   
               }
  
    }
    
    func verstka(){
        
        slider.snp.makeConstraints { make in
            make.bottom.equalTo(image).inset(-50)
            make.left.right.equalToSuperview().inset(40)
        }
        
        label.text = "00 : 00"
        label.snp.makeConstraints { make in
            make.top.equalTo(slider).inset(40)
            make.centerX.equalToSuperview()
        }
        
        buttonPlay.setImage(UIImage(systemName: "play"), for: .normal)
        buttonPlay.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1333333333, blue: 0.1411764706, alpha: 1)
        buttonPlay.layer.cornerRadius = 50
        buttonPlay.setTitle("", for: .normal)
        buttonPlay.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        buttonNextSong.setImage(UIImage(systemName: "forward.end"), for: .normal)
        buttonNextSong.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1333333333, blue: 0.1411764706, alpha: 1)
        buttonNextSong.layer.cornerRadius = 25
        buttonNextSong.setTitle("", for: .normal)
        buttonNextSong.snp.makeConstraints { make in
            make.left.equalTo(buttonPlay).inset(100)
            make.bottom.equalToSuperview().inset(75)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        buttonLastSong.setImage(UIImage(systemName: "backward.end"), for: .normal)
        buttonLastSong.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1333333333, blue: 0.1411764706, alpha: 1)
        buttonLastSong.layer.cornerRadius = 25
        buttonLastSong.setTitle("", for: .normal)
        buttonLastSong.snp.makeConstraints { make in
            make.right.equalTo(buttonPlay).inset(100)
            make.bottom.equalToSuperview().inset(75)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        image.image = UIImage(named: "image")
        image.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(300)
            make.top.equalTo(100)
        }
        
    }
    
    @IBAction func playAction(_ sender: Any) {
        if player.timeControlStatus == .playing {
        player.pause()
            buttonPlay.setImage(UIImage(systemName: "play"), for: .normal)
        } else {
            player.play()
            buttonPlay.setImage(UIImage(systemName: "pause"), for: .normal)
        }
    }
    
    @IBAction func sliderAction(_ sender: Any) {
            player.seek(to: CMTime(seconds: Double(slider.value), preferredTimescale: 1000))
            
            let time = secondsToMinutesAndSeconds(seconds: slider.value)
            let timeString = makeTimeString(minutes: time.0, seconds: time.1)
            self.label.text = timeString
        }
       
       
    
    func secondsToMinutesAndSeconds(seconds: Float) -> (Int, Int) {
        return ((Int(seconds) % 3600) / 60, ((Int(seconds) % 3600) % 60 ))
    }

    func makeTimeString(minutes: Int, seconds: Int) -> String {

        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)

        return timeString
    }

}
