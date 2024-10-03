//
//  TooOOooL.swift
//  JiggleSmartAssetChopper
//
//  Created by Nicky Taylor on 10/3/24.
//

import Cocoa

struct Tool {
    
    static func generateAll(names: [ImportName]) {
        
        for name in names {
            
            let importNameLight = name.partial + "_light.png"
            let importNameDark = name.partial + "_dark.png"
            
            let filePathLight = FileUtils.shared.getMainBundleFilePath(fileName: importNameLight)
            let filePathDark = FileUtils.shared.getMainBundleFilePath(fileName: importNameDark)
            
            print("filePathLight = \(filePathLight)")
            
            guard let imageLight = FileUtils.shared.loadImage(filePathLight)?.cgImage(forProposedRect: nil,
                                                                                      context: nil,
                                                                                      hints: nil) else {
                print("Image not found: \(filePathLight)")
                return
            }
            
            guard let imageDark = FileUtils.shared.loadImage(filePathDark)?.cgImage(forProposedRect: nil,
                                                                                    context: nil,
                                                                                    hints: nil) else {
                print("Image not found: \(filePathDark)")
                return
            }
            
            print("Loaded [\(imageLight.width) x \(imageLight.height)] @ \(importNameLight)")
            print("Loaded [\(imageDark.width) x \(imageDark.height)] @ \(importNameDark)")
            
            let bitmapLight = Bitmap(cgImage: imageLight)
            let bitmapDark = Bitmap(cgImage: imageDark)
            
            let frameLight = bitmapLight.findEdges()
            let frameDark = bitmapDark.findEdges()
            
            if frameLight.width <= 6 || frameLight.height <= 6 {
                print("Invalid Dimension (Light)")
                return
            }
            
            if frameDark.width <= 6 || frameDark.height <= 6 {
                print("Invalid Dimension (Dark)")
                return
            }
            
            guard let croppedLight = crop(cgImage: imageLight, frame: frameLight, padding: 1) else {
                print("Invalid Crop (Light)")
                return
            }
            
            guard let croppedDark = crop(cgImage: imageDark, frame: frameLight, padding: 1) else {
                print("Invalid Crop (Dark)")
                return
            }
            
            print("frameLight = \(frameLight)")
            print("frameDark = \(frameDark)")
            
            /*
            guard let croppedLight = crop(cgImage: imageLight, frame: frameLight, padding: 1) {
                let oop = name.replace + "_light.png"
                let ppap = FileUtils.shared.getDocumentPath(fileName: oop)
                
                _ = FileUtils.shared.saveImagePNG(cgImage: croppedLight, filePath: ppap)
                
            }
            */
            
        }
    }
    
    
    static func crop(cgImage: CGImage,
                     frame: Bitmap.BitmapFrame,
                     padding: Int) -> CGImage? {
        let width = frame.width + (padding + padding)
        let height = frame.height + (padding + padding)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        let bitmapData = UnsafeMutablePointer<UInt8>.allocate(capacity: width * height * bytesPerPixel)
        defer {
            bitmapData.deallocate()
        }
        
        if let context = CGContext(data: bitmapData,
                                width: width,
                                height: height,
                                bitsPerComponent: bitsPerComponent,
                                bytesPerRow: bytesPerRow,
                                space: colorSpace,
                                   bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
            context.clear(CGRect(x: 0, y: 0, width: width, height: height))
            context.draw(cgImage, in: CGRect(x: -frame.x + padding,
                                             y: -frame.y + padding,
                                             width: cgImage.width,
                                             height: cgImage.height))
            
            return context.makeImage()
            
        }
        
        return nil
    }
    
}


