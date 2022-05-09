//
//  NetworkManager.swift
//  Assignment4
//
//  Created by Kapil Ganesh Shanbhag on 09/05/22.
//

import Foundation
import UIKit
class NetworkManager{
    func getImagefromURL(link:String,num:Int)->UIImage{
        let url = URL(string: link)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let imaged = UIImage(data: imageData)!
            return imaged
        }
        return UIImage(named: "invisible")!
    }
}
