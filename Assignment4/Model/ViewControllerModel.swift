//
//  ViewControllerModel.swift
//  Assignment4
//
//  Created by Kapil Ganesh Shanbhag on 09/05/22.
//

import Foundation
class ViewControllerModel{
    init(){
        
    }
    func getImagesArr()->[String]{
        var imagesArr:[String] = []
        var count=0
        while(count<9){
            let randomNum=Int.random(in: 1...19)
            var flag=0;
            for name in imagesArr{
                if(name==String(randomNum)){
                    flag=1
                }
            }
            if(flag==0){
                imagesArr.append(
                String(randomNum))
                count=count+1
            }
            
        }
        return imagesArr
    }
}
