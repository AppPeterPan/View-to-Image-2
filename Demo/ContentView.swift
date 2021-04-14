//
//  ContentView.swift
//  Demo
//
//  Created by SHIH-YING PAN on 2021/4/10.
//

import SwiftUI


// https://www.hackingwithswift.com/quick-start/swiftui/how-to-convert-a-swiftui-view-to-an-image

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

struct ContentView: View {
    @State private var uiImage: UIImage?
    @State private var name = "peter0"
    
    var demoView: some View {
        HStack {
            Image(name)
                .resizable()
                .frame(width: 300, height: 300)
                .scaledToFill()
                .clipShape(Circle())
            Text(name)
                .font(.largeTitle)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
        }
        .background(Color.pink)
    }
    
    var body: some View {
        VStack {
            Button(action: {
                name = ["peter0", "peter1"].randomElement()!
                uiImage = demoView.snapshot()
                UIImageWriteToSavedPhotosAlbum(uiImage!, nil, nil, nil)
            }, label: {
                Text("Button")
            })
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
