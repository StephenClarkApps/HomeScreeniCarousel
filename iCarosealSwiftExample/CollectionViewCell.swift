//
//  CollectionViewCell.swift
//  iCarosealSwiftExample
//
//  Created by Stephen Clark on 14/03/2019.
//  Copyright © 2019 TheAppGuruz-New-6. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell, iCarouselDataSource, iCarouselDelegate {
    var images: NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var carousel: iCarousel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func prepareForReuse() {
        // Refresh
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        carousel.dataSource = self
        carousel.delegate = self
        
        carousel.decelerationRate = 1.5
        carousel.bounces = false
        carousel.stopAtItemBoundary = true
        
        images = NSMutableArray(array: ["4268.jpg",
                                        "4270.jpg",
                                        "4272.jpg",
                                        "4275.jpg",
                                        "4277.jpg"])
        
        //vwCarousel.type = iCarouselType.coverFlow2
        self.carousel.type = iCarouselType.rotary
        //self.carousel.type = iCarouselType.invertedCylinder
        self.carousel .reloadData()
        // Do any additional setup after loading the view, typically from a nib.
        
        let timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
            print("Timer fired!")
            self.carousel.scroll(byNumberOfItems: 1, duration: 0.6)
        }
        // Timer add to runloop
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
    //MARK: icarousel delegate methods
    func numberOfItems(in carousel: iCarousel) -> Int {
        return images.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView: UIImageView
        let image = UIImage(named: "\(images.object(at: index))")
        let screenSize = UIScreen.main.bounds
        if (view == nil) {
            itemView = UIImageView(frame:CGRect(x: self.frame.midX,
                                                y: self.frame.midY,
                                                width: screenSize.width,
                                                height: screenSize.width + 100))
            itemView.contentMode = .scaleAspectFit
            //itemView.backgroundColor = UIColor.black
        } else {
            itemView = view as! UIImageView;
        }
        itemView.image = image
        
        
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        let selectedIndex = index
        print ("The user tapped the image at index \(selectedIndex)")
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        print ("carouselCurrentItemIndexDidChange to \(carousel.currentItemIndex)")
        pageControl.currentPage = carousel.currentItemIndex
    }

}
