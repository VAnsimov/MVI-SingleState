import SwiftUI
import Combine

struct RootRouter: View {

    enum ScreenType {
        case alert(title: String, message: String)
        case descriptionImage(image: UIImage)
    }

    let screen: PassthroughSubject<ScreenType, Never>

    @State private var screenType: ScreenType? = nil

    var body: some View {
        displayView().onReceive(screen) { self.screenType = $0 }
    }
}

private extension RootRouter {

    private func displayView() -> some View {
        let isVisibleScreen = Binding<Bool> {
            screenType != nil
        } set: {
            if !$0 { screenType = nil }
        }

        // Screens
        switch screenType {
        case .alert(let title, let message):
            return Spacer().alert(isPresented: isVisibleScreen, content: {
                Alert(title: Text(title), message: Text(message))
            }).toAnyView()

        case .descriptionImage(let image):
            return Spacer().sheet(isPresented: isVisibleScreen, content: {
                DescriptionImageView.build(image: image, action: { _ in
                    // code
                })
            }).toAnyView()

        default:
            return EmptyView().toAnyView()
        }
    }
}
