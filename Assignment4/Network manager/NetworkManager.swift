import Foundation
import UIKit
class NetworkManager{
    func getImagefromURL(link:String)->UIImage{
        let url = URL(string: link)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let imaged = UIImage(data: imageData)!
            return imaged
        }
        return UIImage(named: "invisible")!
    }
}
