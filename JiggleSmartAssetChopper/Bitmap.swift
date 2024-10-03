//
//  Bitmap.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 6/6/24.
//

import Foundation
import Cocoa

class Bitmap {

    var rgba: [[RGBA]]
    var width: Int
    var height: Int
    
    struct RGBA {
        let r: UInt8
        let g: UInt8
        let b: UInt8
        let a: UInt8
    }
    
    init() {
        rgba = [[RGBA]]()
        width = 0
        height = 0
    }
    
    init(cgImage: CGImage?) {
        guard let cgImage = cgImage else {
            rgba = [[RGBA]]()
            width = 0
            height = 0
            return
        }
        
        width = cgImage.width
        height = cgImage.height
        if width <= 0 || height <= 0 {
            rgba = [[RGBA]]()
            self.width = 0
            self.height = 0
            return
        }
        
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
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
            
        }
        var _rgba: [[RGBA]] = Array(repeating: Array(repeating: RGBA(r: 0, g: 0, b: 0, a: 0), count: height), count: width)
        for y in 0..<height {
            for x in 0..<width {
                let offset = (y * width + x) * bytesPerPixel
                let r = bitmapData[offset]
                let g = bitmapData[offset + 1]
                let b = bitmapData[offset + 2]
                let a = bitmapData[offset + 3]
                _rgba[x][y] = RGBA(r: r, g: g, b: b, a: a)
            }
        }
        self.rgba = _rgba
    }
    
    func printData() {
        
        print("@@ Start ==> Bitmap [\(width) x \(height)]")
        
        for y in 0..<height {
            
            var rowString = String(y)
            if rowString.count < 4 {
                rowString.insert(contentsOf: [Character](repeating: "0", count: (4 - rowString.count)), at: rowString.startIndex)
            }
            
            var dataString = ""
            for x in 0..<width {
                let chunk = rgba[x][y]
                var chunkString = "[" + String(chunk.r) + ", " + String(chunk.g) + ", " + String(chunk.b) + ", " + String(chunk.a) + "]"
                
                if (x == (width - 1)) {
                    dataString += chunkString
                } else {
                    dataString += chunkString + ", "
                }
            }
            var string = "@ \(rowString) => \(dataString)"
            print(string)
        }
        print("@@ End ==> Bitmap [\(width) x \(height)]")
    }
    
    struct BitmapFrame {
        let x: Int
        let y: Int
        let width: Int
        let height: Int
    }
    func findEdges(threshold: Int = 16) -> BitmapFrame {
        
        var minX = width
        var maxX = 0
        var minY = height
        var maxY = 0
        
        for i in 0..<width {
            for n in 0..<height {
                if rgba[i][n].a > threshold {
                    if i < minX { minX = i }
                    if i > maxX { maxX = i }
                    
                    if n < minY { minY = n }
                    if n > maxY { maxY = n }
                    
                }
            }
        }
        
        return BitmapFrame(x: minX,
                           y: minY,
                           width: maxX - minX + 1,
                           height: maxY - minY + 1)
    }
}
