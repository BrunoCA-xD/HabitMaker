//
//  UIImage+Extensions.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 26/04/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

extension UIImage {
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        UIImage().resizeImage(targetSize: targetSize)
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let image = self
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
