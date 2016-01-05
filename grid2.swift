    // MARK: UICollectionViewDataSource
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

        if photoIndex.indexOf(indexPath.item) != nil {
//            cell.addSelectedIndicator(indexPath.item)
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = UIColor(red: 253/255, green: 112/255, blue: 55/255, alpha: 1.0).CGColor
        } else if self.photoIndex.indexOf(indexPath.item) == nil {
            cell.layer.borderWidth = 0.0
            cell.layer.borderColor = nil
            if let selectedIndicatorTag = cell.viewWithTag(indexPath.item){
                selectedIndicatorTag.removeFromSuperview()
            }
        }

        return cell
    }
    
    var photoIndex: [Int] = []
    var photosToProcess: [UIImage] = []

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if self.photoIndex.indexOf(indexPath.item) == nil {
            self.photoIndex.append(indexPath.item)
        } else if self.photoIndex.indexOf(indexPath.item) != nil {
            let newIndex = self.photoIndex.filter() {$0 != indexPath.item}
            self.photoIndex = newIndex
        }
        
        self.setNumberItemSelected()
        self.customPhotoArray()
        collectionView.reloadData()
    }
