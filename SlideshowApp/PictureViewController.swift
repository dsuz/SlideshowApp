//
//  PictureViewController.swift
//  SlideshowApp
//
//  Created by Daisuke Suzuki on 2017/10/27.
//  Copyright © 2017 Daisuke Suzuki. All rights reserved.
//

import UIKit

// 拡大画像を表示する画面
class PictureViewController: UIViewController {
    // 拡大画像を表示するビュー
    @IBOutlet weak var imageView: UIImageView!

    // 表示する画像
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 画像を表示する
    func loadImage() {
        imageView.image = image
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
