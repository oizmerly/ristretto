enum AppStatus {
    case stopped, active
}

let appIconStopped = "cup.and.saucer"
let appIconActive = "cup.and.saucer.fill"

// The intervals used in the app
// TODO: i18n
let predefinedIntervals = [
    "15 minutes": 15 * 60,
    "30 minutes": 30 * 60,
    "1 hour":     1 * 60 * 60,
    "2 hours":    2 * 60 * 60,
    "4 hours":    4 * 60 * 60,
    "6 hours":    6 * 60 * 60,
    "8 hours":    8 * 60 * 60,
    "10 hours":   10 * 60 * 60,
    "12 hours":   12 * 60 * 60
]
