//
//  ContentView.swift
//  BeforeAfterView
//
//  Created by Sean Kent on 2/2/21.
//

import SwiftUI

private let previewImage = UIImage(imageLiteralResourceName: "preview_01")

struct ContentView: View {
    private let images = ImageProcessor(previewImage)
    
    var body: some View {
        VStack(spacing: 16.0) {
            Text("Image Split Preview")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(.bold)
            
            HStack {
                Spacer()
                Text("Before".uppercased())
                Spacer()
                Spacer()
                Text("After".uppercased())
                Spacer()
            }
            .font(.system(size: 14, weight: Font.Weight.bold))
            .foregroundColor(.secondary)
            
            ImageSplitPreview(beforeImage: images.before, afterImage: images.after)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
