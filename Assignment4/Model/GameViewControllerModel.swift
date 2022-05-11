import Foundation
import UIKit
class GameViewControllerModel{
    func setImagesURLOrder(imagesURLArr:[String])->[String]{
        var imagesURLOrder:[String]=[]
        var count=0
        while(count<9){
            let randomNumber=Int.random(in:0...8)
            var flag=0
            for name in imagesURLOrder{
                if(name == imagesURLArr[randomNumber]){
                    flag=1
                }
            }
            if(flag==0){
                imagesURLOrder.append(imagesURLArr[randomNumber])
                count=count+1
            }
        }
       return imagesURLOrder
    }
    func setVisibilityArr(imagesURLArr:[String])->[Bool]{
        var visibilityArr:[Bool]=[]
        for i in 0..<imagesURLArr.count{
            visibilityArr.append(false)
        }
          return visibilityArr
    }
}
