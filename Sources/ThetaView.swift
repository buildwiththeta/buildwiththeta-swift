import Foundation
import SwiftUI
import Flutter

struct ThetaView: UIViewControllerRepresentable {
    let theta: Theta
    
    func makeUIViewController(context: Context) -> FlutterViewController {
        return theta.createFlutterViewController()
    }
    
    func updateUIViewController(_ uiViewController: FlutterViewController, context: Context) {
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ThetaView(theta: Theta(anonKey: "", name: ""))
    }
}
