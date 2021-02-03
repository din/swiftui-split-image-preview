//
//  ImageSplitPreview.swift
//  BeforeAfterView
//
//  Created by Sean Kent on 2/2/21.
//

import SwiftUI

private struct ImageDivider: View {
    let containerWidth: CGFloat
    let dividerPosition: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 2, height: nil)
                .overlay(
                    Circle()
                        .fill(Color.white)
                        .frame(width: 32, height: 32)
                        .shadow(radius: 16, y: 8)
                )
                .offset(
                    x: (containerWidth - 2) * dividerPosition,
                    y: 0
                )
            
            
        }
    }
}

private struct ImageMask: View {
    let containerWidth: CGFloat
    let dividerPosition: CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle().opacity(0)
            Rectangle()
                .frame(width: containerWidth * dividerPosition, height: nil)
        }
    }
}

struct ImageSplitPreview: View {
    let beforeImage: UIImage
    let afterImage: UIImage
    
    @State private var dividerPosition: CGFloat = 0.5
    
    func clamp(_ n: CGFloat, min: CGFloat = 0.0, max: CGFloat = 1.0) -> CGFloat {
        return CGFloat.minimum(max, CGFloat.maximum(n, min))
    }
    
    var body: some View {
        ZStack {
            Image(uiImage: afterImage)
                .resizable()
                .scaledToFit()
                .overlay(
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Image(uiImage: beforeImage)
                                .resizable()
                                .scaledToFit()
                                .mask(
                                    ImageMask(containerWidth: geometry.size.width, dividerPosition: dividerPosition)
                                )
                            
                            ImageDivider(containerWidth: geometry.size.width, dividerPosition: dividerPosition)
                                .gesture(DragGesture()
                                    .onChanged({ value in
                                        self.dividerPosition = clamp(value.location.x / geometry.size.width)
                                    })
                                )
                            
                        }
                    }
                )
            
        }
    }
}
