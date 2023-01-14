import SwiftUI

@main
struct TheApp: App {
    @State var currentNumber: String = "1"
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        MenuBarExtra(currentNumber, systemImage: "\(currentNumber).square") {
            Button("Start") {
            }
            Button("Quit") {
            }
        }
    }
}
