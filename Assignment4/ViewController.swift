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
       runTimer()
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
        print(seconds)
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
            GameVC.imagesArr=self.imagesArr
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
    //--------------


}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/3.0)-7.0, height: (view.frame.width/3.0)-10.0)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
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
        if let image = UIImage(named: imagesArr[indexPath.row]) {
            cell.setupCell(image, width: widthvar, height: heightvar)
        }
        return cell
    }
    
    
}

