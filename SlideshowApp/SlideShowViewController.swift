//
//  SlideShowViewController.swift
//  SlideshowApp
//
//  Created by Daisuke Suzuki on 2017/10/27.
//  Copyright © 2017 Daisuke Suzuki. All rights reserved.
//

import UIKit

// スライドショーの基本画面
class SlideShowViewController: UIViewController {
    // 画像を表示する
    @IBOutlet weak var imageView: UIImageView!

    // 戻るボタン
    @IBOutlet weak var rewindButton: UIButton!
    
    // 進むボタン
    @IBOutlet weak var forwardButton: UIButton!

    // 持っている画像の数 持っている画像の情報は本来 programmatically に取得したいが、リソースを操作するやり方が難しそう
    let countOfImages: Int = 5
    
    // 現在表示している画像のインデックス番号 - これは持っている画像のインデックスを採番しているのでこれでよいが、実際は画像名などで指定したい
    var currentIndex: Int = 0
    
    // タイマー
    var timer: Timer!
    var timer_sec: Float = 0
    let slideShowInterval: Float = 2

    override func viewDidLoad() {
        super.viewDidLoad()

        initImageView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 戻るボタン
    @IBAction func rewindButton(_ sender: Any) {
        rewindImage()
    }
    
    // 進むボタン
    @IBAction func forwardButton(_ sender: Any) {
        forwardImage()
    }
    
    // 再生・停止ボタン
    @IBAction func playButton(_ sender: Any) {
        controlSlideShow()
    }
    
    // 画像がタップされた時のイベントハンドラ
    @IBAction func uiImageViewTap(_ sender: Any) {
        performSegue(withIdentifier: "ShowPictureView", sender: nil)
    }
    
    // 拡大表示から戻ってきた時に呼ばれるハンドラ
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        resumeTimer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 画像を拡大表示するビューに情報を渡す
        let pictureViewController:PictureViewController = segue.destination as! PictureViewController
        pictureViewController.image = imageView.image
        // スライドショーのタイマーを一時停止する
        pauseTimer()
    }
    
    // 初期化
    func initImageView() {
        loadImage(index: currentIndex)
    }
    
    // スライドショーを操作する
    func controlSlideShow() {
        var isSlideShow = false
        
        if (timer != nil) {
            if (self.timer.isValid) {
                isSlideShow = true
            }
        }
        
        if (!isSlideShow) {
            startTimer()
        } else {
            stopTimer()
        }
        
        setButtonsAvailability(isEnabled: isSlideShow)
    }
    
    // スライドショーのタイマーを開始する
    func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer(timer:)), userInfo: nil, repeats: true)
    }
    
    // タイマーを一時停止する。カウンターはリセットしない
    func pauseTimer() {
        if (self.timer != nil) {
            self.timer.invalidate()
        }
    }
    
    // タイマーを再開する。タイマーが一時停止中かどうかはカウンターが 0 かどうかで判断する（※）
    func resumeTimer() {
        if (self.timer != nil && self.timer_sec > 0) {
            startTimer()
        }
    }
    // （※） カウンターが 0 になった瞬間に pauseTimer() が呼ばれた時は、一時停止中が正しく判定できない
    
    // タイマーを止めてカウンターをリセットする
    func stopTimer() {
        self.timer.invalidate()
        self.timer_sec = 0
    }
    
    func updateTimer(timer: Timer) {
        self.timer_sec += 0.1
        if (self.timer_sec > self.slideShowInterval) {
            self.timer_sec = 0
            forwardImage()
        }
    }
    
    func setButtonsAvailability(isEnabled: Bool) {
        rewindButton.isEnabled = isEnabled
        forwardButton.isEnabled = isEnabled
    }
    
    // 一つ先の画像を表示する
    func forwardImage() {
        if (currentIndex < countOfImages - 1) {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        loadImage(index: currentIndex)
    }
    
    // 一つ前の画像を表示する
    func rewindImage() {
        if (currentIndex > 0) {
            currentIndex -= 1
        } else {
            currentIndex = countOfImages - 1
        }
        loadImage(index: currentIndex)
    }
    
    // 指定した画像を表示する
    func loadImage(index: Int) {
        let imageName = "IMG_00\(index)"
        print ("load \(imageName)")
        imageView.image = UIImage(named: imageName)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
