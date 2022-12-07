import SwiftUI

@main
struct SimpleAPITestApp: App {
    var flowViewModel = FlowViewModel()
    
    var body: some Scene {
        WindowGroup {
            FlowView(viewModel: flowViewModel)
        }
    }
}
