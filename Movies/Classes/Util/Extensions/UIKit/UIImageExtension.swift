//
//  UIImageExtension.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/16/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static func applyGradient(to image: UIImage) -> UIImage? {
        UIGraphicsBeginImageContext(image.size)
        image.draw(at: CGPoint(x: 0, y: 0))

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0.5, 1.0]
        let topColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let bottomColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        let colors = [topColor, bottomColor] as CFArray
        let startPoint = CGPoint(x: image.size.width/2, y: 0)
        let endPoint = CGPoint(x: image.size.width/2, y: image.size.height)

        guard let context = UIGraphicsGetCurrentContext(),
            let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations) else {
            return nil
        }

        context.drawLinearGradient(gradient,
                                    start: startPoint,
                                    end: endPoint,
                                    options: CGGradientDrawingOptions(rawValue: UInt32(0)))

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
