//
//  GameViewController.swift
//  Assignment4
//
//  Created by Kapil Ganesh Shanbhag on 22/04/22.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var scoreLabel:UILabel!
    @IBOutlet weak var restartButton:UIButton!
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var gameCollView: UICollectionView!
    var imagesURLArr:[String]=[]
    var imagesURLOrder:[String]=[]
    var imagesOrderArr:[UIImage]=[]
    var visibilityArr:[Bool]=[]
    var imageDisplayNumber=0
    var correctScore=0
    var attemptScore=0
    let GameViewControllerInstance=GameViewControllerModel()
    let NetworkManagerInstance=NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesURLOrder = GameViewControllerInstance.setImagesURLOrder(imagesURLArr: imagesURLArr)
        visibilityArr=GameViewControllerInstance.setVisibilityArr(imagesURLArr: imagesURLArr)
        setImagesOrder()
        restartButton.addTarget(self,action: #selector(restartButtonClicked), for: .touchUpInside)
        
        
        title="Memorize the title"
      
      
            
        displayImage.image=NetworkManagerInstance.getImagefromURL(link: imagesURLOrder[imageDisplayNumber],num:0)
      
        
        //displayImage.image=UIImage(named: imagesURLArr[imageDisplayNumber])
        gameCollView.translatesAutoresizingMaskIntoConstraints=false
        gameCollView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0).isActive = true
        gameCollView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0).isActive = true
        gameCollView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100).isActive = true
        gameCollView.heightAnchor.constraint(equalTo: gameCollView.widthAnchor,multiplier: 1).isActive=true
    
        gameCollView.delegate=self
        gameCollView.dataSource=self
        gameCollView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"imagescollviewcell")

        
    }
    func setImagesOrder(){
        for i in 0..<9{
            imagesOrderArr.append(UIImage())
        }
        for i in 0..<9{
            imagesOrderArr[i]=NetworkManagerInstance.getImagefromURL(link: imagesURLArr[i],num: i)
        }
    }
//    func getImagefromURL(link:String,num:Int)->UIImage{
//        let url = URL(string: link)
//        let data = try? Data(contentsOf: url!)
//        if let imageData = data {
//            let imaged = UIImage(data: imageData)!
//            return imaged
//        }
//        return UIImage(named: "invisible")!
//    }
    @objc func restartButtonClicked(){
        dismiss(animated: true)
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Extension

}
extension GameViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
// MARK: - Game Logic
        if(imageDisplayNumber>7){
            dismiss(animated: true)
        }
        else{
            if(imagesURLOrder[imageDisplayNumber] == imagesURLArr[indexPath.row]){
                visibilityArr[indexPath.row] = true
                gameCollView.reloadData()
                imageDisplayNumber=imageDisplayNumber+1
                displayImage.image = NetworkManagerInstance.getImagefromURL(link:imagesURLOrder[imageDisplayNumber],num: 0)
                //displayImage.image = imagesURLOrder[imageDisplayNumber]
                correctScore=correctScore+1
                gameCollView.reloadData()
            }
            attemptScore=attemptScore+1
            scoreLabel.text="Score : \(correctScore) / \(attemptScore)"
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/3.0)-7.0, height: (view.frame.width/3.0)-10.0)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesURLArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "imagescollviewcell", for: indexPath) as!ImagesCollectionViewCell
        //cell.collcellimage.image=UIImage(named: imageNames[indexPath.row])
        
        let heightvar=(view.frame.width/3.0)-10.0
        let widthvar=(view.frame.width/3.0)-7.0

        let imageViewg = UIImageView(frame: CGRect(x: 0, y: 0, width: widthvar, height: heightvar))
        if(visibilityArr[indexPath.row]==true){
            imageViewg.image=imagesOrderArr[indexPath.row]
        cell.collcellimage.image = imageViewg.image
            
        }
        else{
            let imageg=UIImage(named: "invisible")
            imageViewg.image=imageg
            cell.collcellimage.image = imageViewg.image
        }
        
        
        return cell
    }
    
    
}

