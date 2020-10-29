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
        displayView().onReceive(screen, perform: {
            self.screenType = $0
        })
    }
}

private extension RootRouter {

    private func displayView() -> some View {
        let isVisibleScreen = Binding<Bool> {
            screenType != nil
        } set: {
            if !$0 { screenType = nil }
        }

        switch screenType {
        // Alert
        case .alert(let title, let message):
            return Spacer().alert(isPresented: isVisibleScreen, content: {
                Alert(title: Text(title), message: Text(message))
            }).toAnyView()

        // DescriptionImage Screen
        case .descriptionImage(let image):
            return NavigationLink("", destination: DescriptionImageView.build(image: image),
                                  isActive: isVisibleScreen).toAnyView()

        case .none:
            return EmptyView().toAnyView()
        }
    }
}

#if DEBUG
struct RootRouter_Previews: PreviewProvider {
    static let routeSubject = PassthroughSubject<RootRouter.ScreenType, Never>()

    static var previews: some View {
        ZStack {
            Color.white

            Button(action: {
                self.routeSubject.send(.alert(title: "Error", message: "Something went wrong"))
            }, label: { Text("Display Screen") })
        }
        .overlay(RootRouter(screen: routeSubject))
    }
}
#endif
