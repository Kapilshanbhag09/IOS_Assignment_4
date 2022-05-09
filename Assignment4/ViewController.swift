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
    @IBOutlet weak var loadingVar:UILabel!
    var imagesArr:[String] = []
    var imagesURLArr:[String]=[]
    var replayButtonClickedVar=false
    let ViewControllerModelInstance=ViewControllerModel()
    let NetworkManagerInstance=NetworkManager()
    @IBOutlet weak var collView: UICollectionView!
    var seconds = 5
    var timer = Timer()
    var score=7
    var isTimerRunning = false
    
        override func viewDidLoad() {
        super.viewDidLoad()
        title="Memorise the images"
            loadingVar.isHidden=false
            collView.isHidden=true
        replayButton.addTarget(self, action: #selector(replayButtonClicked), for: .touchUpInside)
            collView.translatesAutoresizingMaskIntoConstraints=false
            collView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0).isActive = true
            collView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0).isActive = true
            collView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100).isActive = true
            collView.heightAnchor.constraint(equalTo: collView.widthAnchor,multiplier: 1).isActive=true
        
            collView.delegate=self
            collView.dataSource=self
            collView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"imagescollviewcell")
            setCollView()

    }
    func setCollView(){
        timeLabel.text="Loading Image"
        collView.isHidden=false
        loadingVar.isHidden=true
        imagesURLArr = ViewControllerModelInstance.setImagesFromAPIFfunc()
        loadingVar.isHidden=true
        self.collView.reloadData()
        collView.isHidden=false
        self.runTimer()
        
    }
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
        seconds -= 1
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
        imagesURLArr = ViewControllerModelInstance.setImagesFromAPIFfunc()
        self.collView.reloadData()
        loadingVar.isHidden=false
        runTimer()
        
    }


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
        let heightvar=(view.frame.width/3.0)-10.0
        let widthvar=(view.frame.width/3.0)-7.0
        let image = NetworkManagerInstance.getImagefromURL(link: imagesURLArr[indexPath.row], num: 0)
        cell.setupCell(image, width: widthvar, height: heightvar)
        
        return cell
    }
    
    
}

