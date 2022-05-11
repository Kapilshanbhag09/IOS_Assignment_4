import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collcellimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(_ img: UIImage,width: CGFloat, height: CGFloat) {
        collcellimage.frame.size = CGSize(width: width, height: height)
        collcellimage.image = img
        collcellimage.translatesAutoresizingMaskIntoConstraints = true
    }
}
