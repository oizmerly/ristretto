import SwiftUI
import IOKit.pwr_mgt

@main
struct TheApp: App {
    @AppStorage("interval") private var interval:String = "1h"
    private let intervals: Dictionary = [
        "15 minutes": 15 * 60,
        "30 minutes": 30 * 60,
        "1 hour":     1 * 60 * 60,
        "2 hours":    2 * 60 * 60,
        "4 hours":    4 * 60 * 60,
        "6 hours":    6 * 60 * 60,
        "8 hours":    8 * 60 * 60,
        "12 hours":   12 * 60 * 60
    ]
    enum Status { case stopped, running }
    @State var status: Status = Status.stopped
    
    // the timer
    @State private var timer: Timer?
    @State private var timeRemaining = 0
    
    var body: some Scene {
        MenuBarExtra("Ristretto", systemImage: status == Status.stopped ? "cup.and.saucer" : "cup.and.saucer.fill") {
            VStack {
                if status == Status.stopped {
                    Text("☕ Ristretto (stopped)")
                } else {
                    Text("☕ Ristretto (\(secondsToString(s: timeRemaining)) left)")
                }
                
                Divider()
                
                if status == Status.stopped {
                    Picker(selection: $interval, label: Text("Enable for:")) {
                        ForEach(intervals.sorted{ $0.value < $1.value }.map { $0.key }, id: \.self) {
                            Text($0).tag($0)
                        }
                    }.pickerStyle(.menu)
                }
                
                Button(action: {
                    toggleSleep()
                }, label: {
                    if status == Status.stopped {
                        Label("Start for \(interval)", systemImage: "play.fill")
                            .labelStyle(.titleAndIcon)
                            .frame(maxWidth: .infinity)
                    } else {
                        Label("Stop", systemImage: "stop.fill")
                            .labelStyle(.titleAndIcon)
                            .frame(maxWidth: .infinity)
                    }
                }).frame(maxWidth: .infinity)
                
                Divider()
                
                Button(action: {
                    _ = enableScreenSleep()
                    NSApplication.shared.terminate(nil)
                }, label: {
                    Label("Quit", systemImage: "xmark.circle.fill")
                        .labelStyle(.titleAndIcon)
                        .frame(maxWidth: .infinity)
                }).frame(maxWidth: .infinity)
    
            }.padding(.top, 10)
        }
    }
    
    func toggleSleep() {
        if status == Status.running {
            enableSleep()
        } else {
            disableSleep()
        }
    }
    
    func disableSleep() {
        status = Status.running
        timeRemaining = intervals[interval]!
        _ = disableScreenSleep()
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { time in
            timeRemaining -= 60
            if timeRemaining <= 0 {
                enableSleep()
            }
        }
    }
    
    func enableSleep() {
        status = Status.stopped
        _ = enableScreenSleep()
        timer?.invalidate()
    }
}
