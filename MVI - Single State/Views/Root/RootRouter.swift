import SwiftUI
import Combine

struct RootRouter: View {

    enum ScreenType {
        case alert(title: String, message: String)
        case descriptionImage(image: UIImage)
        case exit
    }
    enum ActionType {
        case dissmissed(screen: ScreenType)
    }

    // MARK: API
    var action: (ActionType) -> Void
    let screen: PassthroughSubject<ScreenType, Never>

    // MARK: Private
    @Environment(\.presentationMode) private var presentationMode
    @State private var screenType: ScreenType? = nil

    // MARK: Live cycle
    var body: some View {
        displayView().onReceive(screen) { self.screenType = $0 }
    }
}

private extension RootRouter {

    private func displayView() -> some View {
        let isVisible = Binding<Bool>(get: { screenType != nil }, set: {
            guard !$0 else { return }
            if let type = screenType {
                self.action(.dissmissed(screen: type))
            }
            screenType = nil
        })
        /* OR
        let isVisible = Binding<Bool>(get: { screenType != nil },
                                      set: { if !$0 { screenType = nil } })
        */

        switch screenType {
        case .alert(let title, let message):
            return Spacer().alert(isPresented: isVisible, content: {
                Alert(title: Text(title), message: Text(message))
            }).toAnyView()

        case .descriptionImage(let image):
            return NavigationLink("", destination: DescriptionImageView.build(image: image),
                                  isActive: isVisible).toAnyView()

        case .exit:
            presentationMode.wrappedValue.dismiss()
            return EmptyView().toAnyView()

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
        .overlay(RootRouter(action: { _ in }, screen: routeSubject))
    }
}
#endif
