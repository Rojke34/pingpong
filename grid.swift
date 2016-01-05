
let reuseIdentifierIdPhoto = "idPhoto"  

class Gallery2CollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.preparePhotoGrid()
        
    }
    
    func preparePhotoGrid(){
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (view.bounds.size.width - 2) / 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        layout.footerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height: 60.0)
        collectionView!.collectionViewLayout = layout
        collectionView!.registerClass(GalleryCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: reuseIdentifierIdPhoto)
    }


    // MARK: UICollectionView
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosBox.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: GalleryCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifierIdPhoto, forIndexPath: indexPath) as! GalleryCollectionViewCell
        let image = self.photosBox[indexPath.row]
        cell.imageView.image = image
        return cell
    }
    
    var photoIndex: [Int] = []
    var photosToProcess: [UIImage] = []
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var label: UILabel!
        let dimension = (view.bounds.size.width - 2) / 3
        label = UILabel(frame: CGRectMake(0, 0, 20, 20))
        label.center = CGPointMake(dimension - 20, 20)
        label.backgroundColor = UIColor(red: 253/255, green: 112/255, blue: 55/255, alpha: 1.0)
        label.textAlignment = NSTextAlignment.Center
        label.roundCorners([.AllCorners], radius: 10)
        label.textColor = UIColor.whiteColor()
        label.font = font
        label.text = "✔︎"
        label.adjustsFontSizeToFitWidth = true
        label.tag = 22
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        if photoIndex.indexOf(indexPath.item) == nil { // add index to array and add border and label
            photoIndex.append(indexPath.item)
            cell!.addSubview(label)
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor(red: 253/255, green: 112/255, blue: 55/255, alpha: 1.0).CGColor
        } else if photoIndex.indexOf(indexPath.item) != nil { // here I remove from array and border & label
            let newIndex = photoIndex.filter() {$0 != indexPath.item}
            photoIndex = []
            photoIndex = newIndex
            
            if let viewSelected = cell?.viewWithTag(22){
                viewSelected.removeFromSuperview()
            }
            cell?.layer.borderWidth = 0.0
            cell?.layer.borderColor = nil
            
            setNumberItemSelected()
        }

        self.setNumberItemSelected() // Change title nav bar 

    }
    
}

class GalleryCollectionViewCell: UICollectionViewCell {
    var imageView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        imageView.frame = bounds
        addSubview(imageView)
    }
}
