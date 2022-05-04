//
//  ViewController.swift
//  Assignment4
//
//  Created by Kapil Ganesh Shanbhag on 22/04/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel:UILabel!
    @IBOutlet weak var replayButton:UIButton!
    var imagesArr:[String] = []
    var imagesURLArr:[String]=[]
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
  
    var replayButtonClickedVar=false
    @IBOutlet weak var collView: UICollectionView!
    var imageNames:[String]=["1","2","3","4","5","6","7","8","9"]
    var seconds = 15
    var timer = Timer()
    var score=7
    var isTimerRunning = false
    
        override func viewDidLoad() {
        super.viewDidLoad()
            setImageArr()
        // Do any additional setup after loading the view.
        title="Memorise the images"
            setImagesFromAPIFfunc()
            print(imagesURLArr)
       //runTimer()
        replayButton.addTarget(self, action: #selector(replayButtonClicked), for: .touchUpInside)
            collView.translatesAutoresizingMaskIntoConstraints=false
            collView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0).isActive = true
            (
                collView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0).isActive = true
            )
            collView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100).isActive = true
            collView.heightAnchor.constraint(equalTo: collView.widthAnchor,multiplier: 1).isActive=true
        
            collView.delegate=self
            collView.dataSource=self
            collView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"imagescollviewcell")

    }
    
    
    
    
    
    //Timer--------------
    func runTimer(){
        seconds=15
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        if(replayButtonClickedVar){
            timer.invalidate()
            replayButtonClickedVar=false
        }
        seconds -= 1     //This will decrement(count down)the seconds.
        //timerLabel.text = “\(seconds)” //This will update the label.
        //print(seconds)
        if(seconds/10>=1){
            timeLabel.text="0:\(seconds)"
        }
        else{
        timeLabel.text="0:0\(seconds)"
        }
        if(seconds==0){
            timer.invalidate()
            let GameVC=GameViewController()
            GameVC.modalPresentationStyle = .fullScreen
            GameVC.imagesURLArr=self.imagesURLArr
            present(GameVC, animated: true)
            
        }
    }

    @objc func replayButtonClicked(){
        //if(seconds<0){
            //timer.invalidate()
        //}
        runTimer()
        setImageArr()
    }
    func setImageArr(){
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
        
    }
    func setImagesFromAPIFfunc(){
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&lang=en-us&nojsoncallback=1")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            guard let data = data else { return }
            let strdate=String(data: data, encoding: .utf8)
        
            do{
                let response=try JSONDecoder().decode(responseStruct.self, from:Data(strdate!.utf8))
                //print(tproduct[0])
            DispatchQueue.main.async {
                var imagesURLS:[String]=[]
                for i in 0..<response.items.count{
                    imagesURLS.append(response.items[i].media.m)
                }
                var count=0
                while(count<9){
                    let randomNum=Int.random(in: 0...imagesURLS.count-1)
                    var flag=0;
                    for name in self.imagesURLArr{
                        if(name==imagesURLS[randomNum]){
                            flag=1
                        }
                    }
                    if(flag==0){
                        self.imagesURLArr.append(imagesURLS[randomNum])
                        count=count+1
                    }
                    
                }
                self.collView.reloadData()
                self.runTimer()
                 }
            }
            catch{
                print(error)
            }
            
        }
        task.resume()
    }
    //--------------


}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/3.0)-7.0, height: (view.frame.width/3.0)-10.0)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesURLArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "imagescollviewcell", for: indexPath) as!ImagesCollectionViewCell
        //cell.collcellimage.image=UIImage(named: imageNames[indexPath.row])
        
        let heightvar=(view.frame.width/3.0)-10.0
        let widthvar=(view.frame.width/3.0)-7.0

        /*let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: widthvar, height: heightvar))
        let image=UIImage(named: imagesArr[indexPath.row])
        imageView.image=image
        cell.collcellimage.image = image*/
        let url = URL(string: imagesURLArr[indexPath.row])
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            let image = UIImage(data: imageData)
            cell.setupCell(image!, width: widthvar, height: heightvar)
        }
        return cell
    }
    
    
}

