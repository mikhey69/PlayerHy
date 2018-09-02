//
//  ViewController.swift
//  playerHW
//
//  Created by Vladislav Mikheenko on 21.05.2018.
//  Copyright © 2018 Vladislav Mikheenko. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation


class ViewController: UIViewController {
    
    @IBOutlet weak var labelOfTime: UILabel!
    @IBOutlet weak var labelOfEndTime: UILabel!
    @IBOutlet weak var labelOfName: UILabel!
    
    var player = AVAudioPlayer()
    var currentSong = 1
    
    //imeges
    
    var imegePlay = UIImage(named: "play-1")
    var imegePause = UIImage(named: "pause-1")
    var imegenext = UIImage(named: "next")
    var imegeBack = UIImage(named: "back")
    var imegeStop = UIImage(named: "stop-2")
    var imegeRePlay = UIImage(named: "rec")
    
    //labels
    var startTimerLabel = UILabel()
    var endTimerLabel = UILabel()
    
    //variables
    
    var playPauseButton = UIButton()
    var stopButton = UIButton()
    var nextButton = UIButton()
    var backButton = UIButton()
    var restartButton = UIButton()
    var trackSlider = UISlider()
    
    var timer1 = Timer()
    var timer2 = Timer()
    var isPlaying = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Method
        
        
        
        //background
        
        let topColor = UIColor(red: 204/255, green: 231/255, blue: 249/255, alpha: 1.0 )
        
        let bottomColor = UIColor(red: 1/255, green: 70/255, blue: 119/255, alpha: 1.0)
        
        let gradientColors : [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations : [Float] = [0.0, 1.0]
        
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        
        //MARK: - player
        
        
        do {
            if let audioPath = Bundle.main.path(forResource: String(currentSong) + "track", ofType: "mp3") {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                print("I need this job")

            }
        } catch  {
            print("problem with song")
            }
             self.player.play()

    
        //track slider
        trackSlider.frame = CGRect(x: 45, y: 390, width: 340, height: 30)
        trackSlider.center = view.center
        trackSlider.maximumValue = Float(player.duration)
        trackSlider.minimumValue = 0.0
        trackSlider.addTarget(self, action: #selector(trackSliderChenge(sender:)), for: .valueChanged)
        trackSlider.tintColor = UIColor.purple
        
        self.view.addSubview(trackSlider)
        
        
        //play button
        
        playPauseButton.frame = CGRect(x: 155, y: 570, width: 60, height: 60)
        if player.isPlaying {
            playPauseButton.setImage(#imageLiteral(resourceName: "pause-1.png"), for: .normal)
        } else {
            playPauseButton.setImage(#imageLiteral(resourceName: "play-1.png"), for: .normal)
        }
        playPauseButton.addTarget(self, action: #selector(play(sender:)), for: .touchDown)
        
        self.view.addSubview(playPauseButton)
        
        //next buttom
        nextButton.frame = CGRect(x: 235, y: 575, width: 50, height: 50)
        nextButton.setImage(#imageLiteral(resourceName: "next.png"), for: .normal)
        nextButton.addTarget(self, action: #selector(next(sender:)), for: .touchDown)
        self.view.addSubview(nextButton)
        
        //back buttom
        
        backButton.frame = CGRect(x: 85, y: 575, width: 50, height: 50)
        backButton.setImage(#imageLiteral(resourceName: "back.png"), for: .normal)
        backButton.addTarget(self, action: #selector(back(sender:)), for: .touchDown)
        self.view.addSubview(backButton)
        
        
        
        //stop button
        stopButton.frame = CGRect(x: 160, y: 650, width: 50, height: 50)
        stopButton.setImage(#imageLiteral(resourceName: "stop-2.png"), for: .normal)
        stopButton.addTarget(self, action: #selector(stop(sender:)), for: .touchDown)
        self.view.addSubview(stopButton)
        
        //restart button
        restartButton.frame = CGRect(x: 160, y: 500, width: 50, height: 50)
        restartButton.setImage(#imageLiteral(resourceName: "rec.png"), for: .normal)
        restartButton.addTarget(self, action: #selector(restart(sender:)), for: .touchDown)
        
        self.view.addSubview(restartButton)
        
        //MARK: - Labels
       
            //start (var)
            startTimerLabel.frame = CGRect(x: 0, y: 390, width: 100, height: 100)
            startTimerLabel.textColor = UIColor.purple
            startTimerLabel.textAlignment = .center
            self.view.addSubview(startTimerLabel)
            
            //all track
            endTimerLabel.frame = CGRect(x: 288, y: 390, width: 100, height: 100)
            
            let currentTime = Int(player.duration)
            let minutes = currentTime / 60
            let seconds = currentTime - minutes * 60
            endTimerLabel.text = NSString(format: "%02d:%02d", minutes, seconds) as String
            
            endTimerLabel.textColor = UIColor.green
            endTimerLabel.textAlignment = .center
            self.view.addSubview(endTimerLabel)
        
        
        // timer
        
        timer1 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTrackSlider), userInfo: nil, repeats: true)
    
        
        
    } //- viewDidLoad
        
    func playSong() {
        do {
            if let audioPath = Bundle.main.path(forResource: String(currentSong) + "track", ofType: "mp3") {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            }
        } catch  {
            print("problem with song")
        }
    self.player.play()
    }
    
    @objc func next(sender: UIButton) {
        if currentSong < 4 {
            currentSong += 1
            playSong()
        } else {
            print("wrong way+")
        }
    }
    
    @objc func back(sender: UIButton) {
        if currentSong > 1 {
            currentSong -= 1
            playSong()
        } else {
            print("wrong way-")
        }
    }
    
    @objc func trackSliderChenge(sender: UISlider) {
        if sender == trackSlider {
            player.currentTime = TimeInterval(trackSlider.value)
        }
    }
    
    @objc func play(sender: UIButton) {
        if !player.isPlaying {
            playPauseButton.setImage(#imageLiteral(resourceName: "pause-1.png"), for: .normal)
            player.play()
        } else {
            playPauseButton.setImage(#imageLiteral(resourceName: "play-1.png"), for: .normal)
            player.stop()
        }
        if isPlaying {
            timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateTrackSlider() {
        trackSlider.value = Float(player.currentTime)
    }
    
    @objc func stop(sender: UIButton) {
        player.stop()
        player.currentTime = 0
        trackSlider.value = 0.0
        playPauseButton.setImage(#imageLiteral(resourceName: "play-1.png"), for: .normal)
    }
    
    
    
    
    @objc func updateTimer() {
        trackSlider.value = Float(player.currentTime)
        
        let time = Int(player.currentTime)
        let minutes = time / 60
        let second = time - minutes*60
        startTimerLabel.text = NSString(format: "%02d:%02d", minutes, second) as String
        self.trackSlider.value = Float(player.currentTime)
    }
    
    @objc func restart(sender: UIButton) {
        player.currentTime = 0
        trackSlider.value = 0.0
    }
    
}
