//
//  image.swift
//  Minilight
//
//  Created by James Tauber on 6/14/14.
//  Copyright (c) 2014 James Tauber. See LICENSE.
//

import Foundation
import AppKit

let RGB_LUMINANCE = Vector(x: 0.2126, y: 0.7152, z: 0.0722)

let DISPLAY_LUMINANCE_MAX = 200.0
let SCALEFACTOR_NUMERATOR = 1.219 + pow((DISPLAY_LUMINANCE_MAX * 0.25), 0.4)

let GAMMA_ENCODE = 0.45


class Image {
    let width: Int
    let height: Int
    
    var data: [Vector]
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        data = [Vector](count: width * height, repeatedValue: Vector())
    }
    
    func addRadiance(#x: Int, y: Int, radiance: Vector) {
        data[x + y * width] = data[x + y * width] + radiance
    }
    
    func generateImage(iterations: Int) {

        var sumOfLogs = 0.0
        
        for x in 0..<width {
            for y in 0..<height {
                var lum = (1.0 / Double(iterations)) * data[x + y * width].dot(RGB_LUMINANCE)
                sumOfLogs += log10(max(lum, 0.0001))
            }
        }
        
        let logMeanLuminance = pow(10.0, (sumOfLogs / Double(height * width)))

        let scalefactor = (pow((SCALEFACTOR_NUMERATOR / (1.219 + pow(logMeanLuminance, 0.4))), 2.5)) / DISPLAY_LUMINANCE_MAX
        
        let scaleFactorPerIteration = scalefactor / Double(iterations)

        let imageRep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: width, pixelsHigh: height, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: NSDeviceRGBColorSpace, bytesPerRow: 0, bitsPerPixel: 32)

        for x in 0..<width {
            for y in 0..<height {
                let r = max(0.0, min(1.0, pow(max(data[x + y * width].x * scaleFactorPerIteration, 0), GAMMA_ENCODE)))
                let g = max(0.0, min(1.0, pow(max(data[x + y * width].y * scaleFactorPerIteration, 0), GAMMA_ENCODE)))
                let b = max(0.0, min(1.0, pow(max(data[x + y * width].z * scaleFactorPerIteration, 0), GAMMA_ENCODE)))
                
                imageRep.setColor(NSColor(deviceRed: r, green: g, blue: b, alpha: 1.0), atX: x, y: height - y)
            }
        }
        
        let filename = "minilight_\(iterations).tiff"
        imageRep.TIFFRepresentation.writeToFile(filename, atomically: true)
        
        println("output \(filename)")
    }
}
