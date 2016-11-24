//
//  ViewController.swift
//  imagedownload
/*
 * Copyright (c) 2016 Aberger Software GmbH. All Rights Reserved.
 *               http://www.aberger.at
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you
 * may not use this file except in compliance with the License. You may
 * obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let downloads = [
            "https://spin.atomicobject.com/wp-content/uploads/dining-philosophers.jpg": imageView1,
            "https://raw.githubusercontent.com/wiki/angrave/SystemProgramming/5DiningPhilosophers.png": imageView2
        ]
        
        var currentImageIndex = 0
        let group = DispatchGroup()
        
        downloads.forEach { (url, imageView) in
            currentImageIndex += 1
            let queue = DispatchQueue(label: "imagequeue\(currentImageIndex)")
            group.enter() // tell the group we start something...
            queue.async {
                self.downloadImage(imageurl: url, imageview: imageView!)
                group.leave() // ... now, a long time later we tell the group we are done
            }
        }
        group.notify(queue: DispatchQueue.main) {
            print("back in main thread")
        }
    }
    
    func downloadImage(imageurl: String, imageview: UIImageView){
        if let url = URL(string:imageurl) {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        print("downloaded image \(url)")
                        imageview.image = image
                    }
                }
            }
        }
    }
    func syncDownloadImage(imageurl: String, imageview: UIImageView){
        if let url = URL(string:imageurl) {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    print("downloaded image \(url)")
                    imageview.image = image
                }
            }
        }
    }
}

