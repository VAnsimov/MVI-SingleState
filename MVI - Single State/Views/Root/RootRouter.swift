import SwiftUI
import Combine

struct RootRouter: View {

    enum ScreenType {
        case alert(title: String, message: String)
        case descriptionImage(image: UIImage)
    }

    let screen: PassthroughSubject<ScreenType, Never>

    @State private var screenType: ScreenType? = nil
    @State private var isFullImageVisible = false
    @State private var isAlertVisible = false

    var body: some View {
        Group {
            alertView()
            descriptionImageView()
        }.onReceive(screen, perform: { type in
            self.screenType = type
            switch type {
            case .alert:
                self.isAlertVisible = true

            case .descriptionImage:
                self.isFullImageVisible = true
            }
        })
    }
}

private extension RootRouter {

    private func alertView() -> some View {
        guard let type = screenType, case .alert(let title, let message) = type else {
            return EmptyView().toAnyView()
        }
        return Spacer().alert(isPresented: $isAlertVisible, content: {
            Alert(title: Text(title), message: Text(message))
        }).toAnyView()
    }

    private func descriptionImageView() -> some View {
        guard let type = screenType, case .descriptionImage(let image) = type else {
            return EmptyView().toAnyView()
        }
        return Spacer().sheet(isPresented: $isFullImageVisible, onDismiss: {
            self.screenType = nil
        }, content: {
            DescriptionImageView.build(image: image, action: { _ in
                // code
            })
        }).toAnyView()
    }
}
