import SwiftUI
import Combine

struct RootRouter: View {

    enum ScreenType {
        case alert(title: String, message: String)
        case descriptionImage(image: UIImage)
    }

    let screen: PassthroughSubject<ScreenType, Never>

    @State private var screenType: ScreenType? = nil
    @State private var isVisibleScreen = false

    var body: some View {
        displayView().onReceive(screen, perform: { type in
            self.screenType = type
            self.isVisibleScreen = true
        })
    }
}

private extension RootRouter {

    private func displayView() -> some View {
        switch screenType {
        // Alert
        case .alert(let title, let message):
            return Spacer().alert(isPresented: $isVisibleScreen, content: {
                Alert(title: Text(title), message: Text(message))
            }).toAnyView()

        // DescriptionImage
        case .descriptionImage(let image):
            return Spacer().sheet(isPresented: $isVisibleScreen, onDismiss: {
                self.screenType = nil
            }, content: {
                DescriptionImageView.build(image: image, action: { _ in
                    // code
                })
            }).toAnyView()

        default:
            return EmptyView().toAnyView()
        }
    }
}
