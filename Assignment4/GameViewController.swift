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
    var imagesArr:[String]=[]
    var imagesOrder:[String]=[]
    var visibilityArr:[Bool]=[]
    var imageDisplayNumber=0
    var correctScore=0
    var attemptScore=0
    var GameViewControllerModelInstance=GameViewControllerModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesOrder = GameViewControllerModelInstance.getImagesOrder(iArr: imagesArr)
        visibilityArr=GameViewControllerModelInstance.getVisibilityArr(iArrLength: imagesArr.count)
        restartButton.addTarget(self,action: #selector(restartButtonClicked), for: .touchUpInside)
        title="Memorize the title"
        displayImage.image=UIImage(named: imagesOrder[imageDisplayNumber])
        gameCollView.translatesAutoresizingMaskIntoConstraints=false
        gameCollView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0).isActive = true
        gameCollView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0).isActive = true
        gameCollView.heightAnchor.constraint(equalTo: gameCollView.widthAnchor,multiplier: 1).isActive=true
        gameCollView.delegate=self
        gameCollView.dataSource=self
        gameCollView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"imagescollviewcell")
    }
    
    @objc func restartButtonClicked(){
        dismiss(animated: true)
    }

}
extension GameViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
// MARK: - Game Logic
        if(imageDisplayNumber>7){
            dismiss(animated: true)
        }
        else{
            if(imagesOrder[imageDisplayNumber]==imagesArr[indexPath.row]){
                visibilityArr[indexPath.row] = true
                print("\(imagesOrder[imageDisplayNumber]) and \(imagesArr[indexPath.row])")
                print(visibilityArr)
                gameCollView.reloadData()
                imageDisplayNumber=imageDisplayNumber+1
                displayImage.image = UIImage(named: imagesOrder[imageDisplayNumber])
                correctScore=correctScore+1
            }
            attemptScore=attemptScore+1
            scoreLabel.text="Score : \(correctScore) / \(attemptScore)"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/3.0)-7.0, height: (view.frame.width/3.0)-10.0)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "imagescollviewcell", for: indexPath) as!ImagesCollectionViewCell
        let heightvar=(view.frame.width/3.0)-10.0
        let widthvar=(view.frame.width/3.0)-7.0
        let imageViewg = UIImageView(frame: CGRect(x: 0, y: 0, width: widthvar, height: heightvar))
        if(visibilityArr[indexPath.row]==true){
        let imageg=UIImage(named: self.imagesArr[indexPath.row])
            imageViewg.image=imageg
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

