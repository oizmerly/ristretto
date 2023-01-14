import SwiftUI

@main
struct TheApp: App {
    var body: some Scene {        
        MenuBarExtra("Ristretto", systemImage: "cup.and.saucer") {
            Button("Start") {
            }
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            Image(systemName: "cup.and.saucer.fill")
        }
        .menuBarExtraStyle(.window)
    }
}
