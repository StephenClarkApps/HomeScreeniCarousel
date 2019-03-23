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
        // Ensure cells are refreshed ??
        self.images = NSMutableArray()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.carousel.dataSource = self
        self.carousel.delegate = self
        
        self.carousel.decelerationRate = 1.5
        self.carousel.bounces = false
        self.carousel.stopAtItemBoundary = true
        
        self.images = NSMutableArray(array: ["4268.jpg",
                                        "4270.jpg",
                                        "4272.jpg",
                                        "4275.jpg",
                                        "4277.jpg"])
        
        self.carousel.type = iCarouselType.rotary
        self.carousel.reloadData()
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
        self.pageControl.currentPage = carousel.currentItemIndex
    }

}
