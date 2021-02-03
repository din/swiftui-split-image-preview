//
//  ImageProcessor.swift
//  BeforeAfterView
//
//  Created by Sean Kent on 2/2/21.
//
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

let ciContext = CIContext()

func filterImageMono(_ inputImage: CIImage?) -> CIImage? {
    let filter = CIFilter.photoEffectMono()
    filter.inputImage = inputImage
    return filter.outputImage
}

func loadFilteredImage(_ filteredImage: CIImage?) -> UIImage? {
    guard let image = filteredImage else { return nil }
    guard let cgimg = ciContext.createCGImage(image, from: image.extent) else { return nil }

    return UIImage(cgImage: cgimg)
}

class ImageProcessor {
    let before: UIImage
    let after: UIImage
    
    init(_ originalImage: UIImage) {
        let ciImage = CIImage(image: originalImage)
        let filteredImage = filterImageMono(ciImage)
        
        before = originalImage
        after = loadFilteredImage(filteredImage) ?? originalImage
    }
}
