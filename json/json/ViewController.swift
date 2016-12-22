
import UIKit
/** Demo View Controller that downloads a .json File and parsed it.
 Upload a test.json sample file to your server and change the location below.
 */
class ViewController: UIViewController {
    let location = "http://www.example.com/test.json"
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson()
    }
    func downloadJson() {
        if let url = URL(string: location) {
            let queue = DispatchQueue(label: "aqueue")
            queue.async {
                if let binaryData = try? Data(contentsOf: url) {
                    if let obj = try? JSONSerialization.jsonObject(with: binaryData) {
                        if let dict = obj as? [String:String] {
                            DispatchQueue.main.async {
                                dict.forEach({ (key, value) in
                                    print("\(key)=>\(value)")
                                })
                            }
                        }
                    }
                }
            }
        }
    }
}

