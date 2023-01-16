import SwiftUI

@main
struct TheApp: App {
    @State private var status = AppStatus.stopped
    
    public func activate() {
        status = .active
        _ = disableScreenSleep()
    }
    
    public func stop() {
        status = .stopped
        _ = enableScreenSleep()
    }
    
    var body: some Scene {
        MenuBarExtra("Ristretto", systemImage: status == .active ? appIconActive : appIconStopped) {
            AppMenu(app: self)
        }.menuBarExtraStyle(.window).windowResizability(.contentMinSize)
    }
}

struct AppMenu: View {
    private let theApp: TheApp
    @AppStorage("interval") private var interval:String = "1h"
    @State private var status = AppStatus.stopped
    @State private var timeRemaining = 0
    @State private var timer: Timer?
    private let timerStep = 60
    
    init(app: TheApp) {
        theApp = app
    }
    
    private func toggle() {
        if status == .active {
            status = .stopped
            theApp.stop()
            timer?.invalidate()
        } else {
            status = .active
            theApp.activate()
            // start the timer
            timeRemaining = predefinedIntervals[interval]!
            timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(timerStep), repeats: true) { _ in
                timeRemaining -= timerStep
                if timeRemaining <= 0 {
                    toggle()
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            // the title
            let titleStatus = (status == .active ? "(\(secondsToString(s: timeRemaining)) left)" : "(stopped)")
            Text("☕ Ristretto " + titleStatus)

            Divider()
        
            if status == .stopped {
                Picker(selection: $interval, label: Text("Enable for:")) {
                    ForEach(predefinedIntervals.sorted{ $0.value < $1.value }.map { $0.key }, id: \.self) {
                        Text($0).tag($0)
                    }
                }.pickerStyle(.radioGroup)
            }
            Button(action: {
                toggle()
            }, label: {
                if status == .stopped {
                    Label("Start for \(interval)", systemImage: "play.fill").labelStyle(.titleAndIcon).padding(10)
                } else {
                    Label("Stop", systemImage: "stop.fill").labelStyle(.titleAndIcon).padding(10)
                }
            })
            .frame(maxWidth: .infinity)
            
            Divider()
            
            Button(action: {
                theApp.stop()
                NSApplication.shared.terminate(nil)
            }, label: {
                Label("Quit", systemImage: "xmark.circle.fill")
                    .labelStyle(.titleAndIcon).frame(maxWidth: .infinity)
            }).frame(maxWidth: .infinity).padding(.leading, 5).padding(.trailing, 5).padding(.bottom, 5)
        }.padding(.top, 10)
    }
}
