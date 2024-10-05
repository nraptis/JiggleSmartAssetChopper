//
//  TooOOooL.swift
//  JiggleSmartAssetChopper
//
//  Created by Nicky Taylor on 10/3/24.
//

import Cocoa

struct Tool {
    
    static func generateAll(names: [ImportName], scaled: Bool) {
        
        let scaleNames = ["1_0", "2_0", "3_0"]
        let scaleDivisions = [6, 3, 2]
        
        for name in names {
            
            let importNameLight = name.partial + "_light.png"
            let importNameLightDisabled = name.partial + "_light_disabled.png"
            
            let importNameDark = name.partial + "_dark.png"
            let importNameDarkDisabled = name.partial + "_dark_disabled.png"
            
            
            let filePathLight = FileUtils.shared.getMainBundleFilePath(fileName: importNameLight)
            let filePathLightDisabled = FileUtils.shared.getMainBundleFilePath(fileName: importNameLightDisabled)
            
            let filePathDark = FileUtils.shared.getMainBundleFilePath(fileName: importNameDark)
            let filePathDarkDisabled = FileUtils.shared.getMainBundleFilePath(fileName: importNameDarkDisabled)
            
            
            guard let imageLight = FileUtils.shared.loadImage(filePathLight)?.cgImage(forProposedRect: nil,
                                                                                      context: nil,
                                                                                      hints: nil) else {
                print("Image not found: \(filePathLight)")
                return
            }
            
            guard let imageLightDisabled = FileUtils.shared.loadImage(filePathLightDisabled)?.cgImage(forProposedRect: nil,
                                                                                                      context: nil,
                                                                                                      hints: nil) else {
                print("Image not found: \(filePathLightDisabled)")
                return
            }
            
            guard let imageDark = FileUtils.shared.loadImage(filePathDark)?.cgImage(forProposedRect: nil,
                                                                                    context: nil,
                                                                                    hints: nil) else {
                print("Image not found: \(filePathDark)")
                return
            }
            
            guard let imageDarkDisabled = FileUtils.shared.loadImage(filePathDarkDisabled)?.cgImage(forProposedRect: nil,
                                                                                                    context: nil,
                                                                                                    hints: nil) else {
                print("Image not found: \(filePathDarkDisabled)")
                return
            }
            
            let bitmapLight = Bitmap(cgImage: imageLight)
            
            let frameLight = bitmapLight.findEdges()
            
            if frameLight.width <= 6 || frameLight.height <= 6 {
                print("Invalid Dimension (Light)")
                return
            }
            
            if let croppedLight = crop(cgImage: imageLight, frame: frameLight, padding: 1) {
                
                if scaled {
                    exportScaled(image: croppedLight,
                                 name: name.replace,
                                 isDark: false,
                                 isDisabled: false,
                                 type: name.type,
                                 scaleNames: scaleNames,
                                 scaleDivisions: scaleDivisions)
                } else {
                    export(image: croppedLight,
                           name: name.replace,
                           isDark: false,
                           isDisabled: false,
                           type: name.type)
                }
            } else {
                print("Invalid Crop (Light)")
                return
            }
            
            if let croppedLightDisabled = crop(cgImage: imageLightDisabled, frame: frameLight, padding: 1) {
                
                if scaled {
                    exportScaled(image: croppedLightDisabled,
                                 name: name.replace,
                                 isDark: false,
                                 isDisabled: true,
                                 type: name.type,
                                 scaleNames: scaleNames,
                                 scaleDivisions: scaleDivisions)
                } else {
                    export(image: croppedLightDisabled,
                           name: name.replace,
                           isDark: false,
                           isDisabled: true,
                           type: name.type)
                }
            } else {
                print("Invalid Crop (Light Disabled)")
                return
            }
            
            if let croppedDark = crop(cgImage: imageDark, frame: frameLight, padding: 1) {
                if scaled {
                    exportScaled(image: croppedDark,
                                 name: name.replace,
                                 isDark: true,
                                 isDisabled: false,
                                 type: name.type,
                                 scaleNames: scaleNames,
                                 scaleDivisions: scaleDivisions)
                } else {
                    export(image: croppedDark,
                           name: name.replace,
                           isDark: true,
                           isDisabled: false,
                           type: name.type)
                }
                
            } else {
                print("Invalid Crop (Dark)")
                return
            }
            
            if let croppedDarkDisabled = crop(cgImage: imageDarkDisabled, frame: frameLight, padding: 1) {
                if scaled {
                    exportScaled(image: croppedDarkDisabled,
                                 name: name.replace,
                                 isDark: true,
                                 isDisabled: true,
                                 type: name.type,
                                 scaleNames: scaleNames,
                                 scaleDivisions: scaleDivisions)
                } else {
                    export(image: croppedDarkDisabled,
                           name: name.replace,
                           isDark: true,
                           isDisabled: true,
                           type: name.type)
                }
                
            } else {
                print("Invalid Crop (Dark Disabled)")
                return
            }
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
    
    
    static func makeImages(image: CGImage, name: String, isDark: Bool, isDisabled: Bool, type: ImportType) -> [(CGImage, String)] {
        
        var result = [(CGImage, String)]()
        for sizeCategory in SizeCategory.allCases {
            var fileName = ""
            
            fileName += name + "_" + sizeCategory.getPosfix()
            if isDark {
                if isDisabled {
                    fileName += "_dark_disabled"
                } else {
                    fileName += "_dark"
                }
                
            } else {
                if isDisabled {
                    fileName += "_light_disabled"
                } else {
                    fileName += "_light"
                }
            }
            
            let height = sizeCategory.getHeight(type: type)
            
            guard image.width > 4 && image.height > 4 else {
                print("[Make Images] Invalid Image Size: \(fileName)")
                continue
            }
            
            guard height > 4 else {
                print("[Make Images] Invalid Height: \(height)")
                continue
            }
            
            let percent = Double(height) / Double(image.height)
            
            var exportWidth = Int(Double(image.width) * percent + 0.5)
            let exportHeight = height - 2
            
            guard exportWidth > 4 && exportHeight > 4 else {
                print("[Make Images] Invalid Export Size: \(fileName), \(exportWidth) x \(exportHeight)")
                continue
            }
            
            var boxWidth = exportWidth + 2
            while true {
                if ((boxWidth % 6) == 0) { break }
                boxWidth += 1
            }
            let boxHeight = exportHeight + 2
            
            let shiftX = (boxWidth - exportWidth) / 2
            
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bytesPerPixel = 4
            let bytesPerRow = bytesPerPixel * boxWidth
            let bitsPerComponent = 8
            let bitmapData = UnsafeMutablePointer<UInt8>.allocate(capacity: boxWidth * boxHeight * bytesPerPixel)
            defer {
                bitmapData.deallocate()
            }
            
            if let context = CGContext(data: bitmapData,
                                    width: boxWidth,
                                    height: boxHeight,
                                    bitsPerComponent: bitsPerComponent,
                                    bytesPerRow: bytesPerRow,
                                    space: colorSpace,
                                       bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
                context.clear(CGRect(x: 0, y: 0, width: boxWidth, height: boxHeight))
                context.draw(image, in: CGRect(x: shiftX,
                                               y: 1,
                                               width: exportWidth,
                                               height: exportHeight))
                
                if let resultImage = context.makeImage() {
                    result.append((resultImage, fileName))
                } else {
                    print("[Make Images] Graphics Error! \(fileName)")
                }
            }
        }
        return result
    }
    
    static func exportScaled(image: CGImage,
                             name: String,
                             isDark: Bool,
                             isDisabled: Bool,
                             type: ImportType,
                             scaleNames: [String],
                             scaleDivisions: [Int]) {
        
        
        let makeResult = makeImages(image: image, name: name, isDark: isDark, isDisabled: isDisabled, type: type)
        
        
        for pair in makeResult {
            
            let imageOriginal = pair.0
            let nameOriginal = pair.1
            
            for scaleIndex in 0..<scaleNames.count {
                let scaleName = scaleNames[scaleIndex]
                let scaleDivision = scaleDivisions[scaleIndex]
                let fileName = nameOriginal + "_\(scaleName).png"
                if scaleDivision > 0 {
                    
                    let resizeWidth = imageOriginal.width / scaleDivision
                    let resizeHeight = imageOriginal.height / scaleDivision
                    
                    let colorSpace = CGColorSpaceCreateDeviceRGB()
                    let bytesPerPixel = 4
                    let bytesPerRow = bytesPerPixel * resizeWidth
                    let bitsPerComponent = 8
                    let bitmapData = UnsafeMutablePointer<UInt8>.allocate(capacity: resizeWidth * resizeHeight * bytesPerPixel)
                    defer {
                        bitmapData.deallocate()
                    }
                    
                    if let context = CGContext(data: bitmapData,
                                            width: resizeWidth,
                                            height: resizeHeight,
                                            bitsPerComponent: bitsPerComponent,
                                            bytesPerRow: bytesPerRow,
                                            space: colorSpace,
                                               bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
                        context.clear(CGRect(x: 0, y: 0, width: resizeWidth, height: resizeHeight))
                        context.draw(image, in: CGRect(x: 0,
                                                       y: 0,
                                                       width: resizeWidth,
                                                       height: resizeHeight))
                        
                        if let resultImage = context.makeImage() {
                            
                            
                            let filePath = FileUtils.shared.getDocumentPath(fileName: fileName)
                            if FileUtils.shared.saveImagePNG(cgImage: resultImage, filePath: filePath) {
                                print("Success (Scaled)! \(fileName)")
                            } else {
                                print("[Export Scaled] Fail Save PNG! \(fileName)")
                            }
                            
                        } else {
                            print("[Export Scaled] Graphics Error! \(fileName)")
                        }
                    }
                    
                    
                    
                }
                
                
                
            }
            
            
            
        }
    }
    
    static func export(image: CGImage, name: String, isDark: Bool, isDisabled: Bool, type: ImportType) {
    
        
        let makeResult = makeImages(image: image, name: name, isDark: isDark, isDisabled: isDisabled, type: type)
        
        
        for pair in makeResult {
            let fileName = pair.1 + ".png"
            let image = pair.0

            let filePath = FileUtils.shared.getDocumentPath(fileName: fileName)
            if FileUtils.shared.saveImagePNG(cgImage: image, filePath: filePath) {
                print("[Export] Success! \(fileName)")
            } else {
                print("[Export] Fail Save PNG! \(fileName)")
            }
            
        }
        
        /*
        for sizeCategory in SizeCategory.allCases {
            var fileName = ""
            
            fileName += name + "_" + sizeCategory.getPosfix()
            if isDark {
                if isDisabled {
                    fileName += "_dark_disabled.png"
                } else {
                    fileName += "_dark.png"
                }
                
            } else {
                if isDisabled {
                    fileName += "_light_disabled.png"
                } else {
                    fileName += "_light.png"
                }
            }
            
            let height = sizeCategory.getHeight(type: type)
            
            guard image.width > 4 && image.height > 4 else {
                print("Invalid Image Size: \(fileName)")
                continue
            }
            
            guard height > 4 else {
                print("Invalid Height: \(height)")
                continue
            }
            
            let percent = Double(height) / Double(image.height)
            
            var exportWidth = Int(Double(image.width) * percent + 0.5)
            let exportHeight = height - 2
            
            guard exportWidth > 4 && exportHeight > 4 else {
                print("Invalid Export Size: \(fileName), \(exportWidth) x \(exportHeight)")
                continue
            }
            
            var boxWidth = exportWidth + 2
            while true {
                if ((boxWidth % 6) == 0) { break }
                boxWidth += 1
            }
            let boxHeight = exportHeight + 2
            
            let shiftX = (boxWidth - exportWidth) / 2
            
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bytesPerPixel = 4
            let bytesPerRow = bytesPerPixel * boxWidth
            let bitsPerComponent = 8
            let bitmapData = UnsafeMutablePointer<UInt8>.allocate(capacity: boxWidth * boxHeight * bytesPerPixel)
            defer {
                bitmapData.deallocate()
            }
            
            if let context = CGContext(data: bitmapData,
                                    width: boxWidth,
                                    height: boxHeight,
                                    bitsPerComponent: bitsPerComponent,
                                    bytesPerRow: bytesPerRow,
                                    space: colorSpace,
                                       bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
                context.clear(CGRect(x: 0, y: 0, width: boxWidth, height: boxHeight))
                context.draw(image, in: CGRect(x: shiftX,
                                               y: 1,
                                               width: exportWidth,
                                               height: exportHeight))
                
                if let resultImage = context.makeImage() {
                    
                    let filePath = FileUtils.shared.getDocumentPath(fileName: fileName)
                    if FileUtils.shared.saveImagePNG(cgImage: resultImage, filePath: filePath) {
                        print("Success! \(fileName) @ box:[\(boxWidth) x \(boxHeight)] img:[\(exportWidth) x \(exportHeight)] from[\(image.width) x \(image.height)]")
                    } else {
                        print("Fail (B)! \(fileName)")
                    }
                    
                } else {
                    print("Fail (A)! \(fileName)")
                }
            }
        }
        */
    }
}
