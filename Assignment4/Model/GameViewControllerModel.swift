//
//  GameViewControllerModel.swift
//  Assignment4
//
//  Created by Kapil Ganesh Shanbhag on 09/05/22.
//

import Foundation
import OpenGLES
class GameViewControllerModel{
    
    func getVisibilityArr(iArrLength:Int)->[Bool]{
        var visibilityArr:[Bool]=[]
        for i in 0..<iArrLength{
            visibilityArr.append(false)
        }
        return visibilityArr
    }
    
    
    func getImagesOrder(iArr:[String])->[String]{
        var imagesOrder:[String]=[]
        var count=0
        while(count<9){
            let randomNumber=Int.random(in:0...8)
            var flag=0
            for name in imagesOrder{
                if(name == iArr[randomNumber]){
                    flag=1
                }
            }
            if(flag==0){
                imagesOrder.append(iArr[randomNumber])
                count=count+1
            }
        }
        return imagesOrder
    }

}
