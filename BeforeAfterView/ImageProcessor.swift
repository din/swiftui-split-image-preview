//
//  ImageProcessor.swift
//  BeforeAfterView
//
//  Created by Sean Kent on 2/2/21.
//
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class ImageProcessor: ObservableObject {
    @Published var before: UIImage?
    @Published var after: UIImage?
    
    fileprivate var ciContext: CIContext?

    fileprivate func filterImageMono(_ inputImage: CIImage?) -> CIImage? {
        let filter = CIFilter.photoEffectMono()
        filter.inputImage = inputImage
        return filter.outputImage
    }
    
    fileprivate func filterImageScale(_ inputImage: CIImage?, aspectRatio: Float = 1.0, scale: Float) -> CIImage? {
        let filter = CIFilter.lanczosScaleTransform()
        filter.inputImage = inputImage
        filter.scale = scale
        filter.aspectRatio = aspectRatio
        return filter.outputImage
    }

    fileprivate func loadFilteredImage(_ filteredImage: CIImage?) -> UIImage? {
        guard let image = filteredImage else { return nil }
        guard let cgimg = ciContext?.createCGImage(image, from: image.extent) else { return nil }

        return UIImage(cgImage: cgimg)
    }
    
    init(_ originalImage: UIImage) {
        let queue = OperationQueue()
        
        queue.addOperation {
            self.ciContext = CIContext()
            let ciImage = CIImage(image: originalImage)
            
            // Scale image to fit screen
            let screenWidth = UIScreen.main.bounds.size.width * UIScreen.main.scale
            let screenHeight = UIScreen.main.bounds.size.height * UIScreen.main.scale
            let scale = CGFloat.minimum(screenWidth / originalImage.size.width, screenHeight / originalImage.size.height)
            
            let resizedImage = self.filterImageScale(ciImage, scale: Float(scale))
            let filteredImage = self.filterImageMono(resizedImage)
            
            DispatchQueue.main.async {
                self.before = self.loadFilteredImage(resizedImage)
                self.after = self.loadFilteredImage(filteredImage)
            }
        }
    }
}
