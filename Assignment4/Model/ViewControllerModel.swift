import Foundation
import UIKit
struct mStruct:Decodable{
    var m:String
}
struct itemsStruct:Decodable{
    var title:String
    var link:String
    var media:mStruct
    var date_taken:String
    var description:String
    var published:String
    var author:String
    var tags:String
}
struct responseStruct:Decodable{
    var title:String
    var link:String
    var description:String
    var generator:String
    var items:[itemsStruct]
}
class ViewControllerModel{
    var viewControllerDelegate:ViewControllerDelegate?
    func setImagesFromAPIFfunc()->[String]{
        var imagesURLArr:[String]=[]
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&lang=en-us&nojsoncallback=1")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let strdate=String(data: data, encoding: .utf8)
        
            do{
                let response=try JSONDecoder().decode(responseStruct.self, from:Data(strdate!.utf8))
           
                var imagesURLS:[String]=[]
                for i in 0..<response.items.count{
                    imagesURLS.append(response.items[i].media.m)
                }
                var count=0
                while(count<9){
                    let randomNum=Int.random(in: 0...imagesURLS.count-1)
                    var flag=0;
                    for name in imagesURLArr{
                        if(name==imagesURLS[randomNum]){
                            flag=1
                        }
                    }
                    if(flag==0){
                        imagesURLArr.append(imagesURLS[randomNum])
                        count=count+1
                    }
                    
                }
                self.viewControllerDelegate?.responseRecieved(imagesURLArrFromDelegate: imagesURLS)
                 
            }
            catch{
                print(error)
            }
           
            
        }
        task.resume()
        return imagesURLArr
    }
}
