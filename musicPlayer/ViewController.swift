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
    let image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(image)
        view.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1647058824, blue: 0.1882352941, alpha: 1)
        
        verstka()
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!))
        
        slider.maximumValue = Float(player.currentItem?.asset.duration.seconds ?? 0)
        
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: DispatchQueue.main) { time in
            self.label.text = "\(time.seconds)"
            self.slider.value = Float(time.seconds)
            
        }
        
    }
    
    func verstka(){
        
        slider.snp.makeConstraints { make in
            make.bottom.equalTo(image).inset(-50)
            make.left.right.equalToSuperview().inset(40)
        }
        
        buttonPlay.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1333333333, blue: 0.1411764706, alpha: 1)
        buttonPlay.layer.cornerRadius = 50
        buttonPlay.setTitle("Play", for: .normal)
        buttonPlay.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(100)
            make.width.equalTo(100)
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
