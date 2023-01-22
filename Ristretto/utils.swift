// convert seconds to a human readable string
func secondsToString(s: Int) -> String {
    let hours = s / 3600
    let minutes = (s % 3600) / 60
    return hours > 0 ? String(format: "%dh:%02dm", arguments: [hours, minutes]) : String(format: "%dm", arguments: [minutes])
//    let seconds = (s % 3600) % 60
//    return String(format: "%dh:%02dm:%02ds", arguments: [hours, minutes, seconds])
}
