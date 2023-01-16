import IOKit.pwr_mgt

// power managment, disable and enable sleep

private var noSleepAssertionID: IOPMAssertionID = 0
private var noSleepReturn: IOReturn?

public func disableScreenSleep(reason: String = "Disabled by the User") -> Bool? {
    guard noSleepReturn == nil else { return nil }
    noSleepReturn = IOPMAssertionCreateWithName(kIOPMAssertionTypeNoDisplaySleep as CFString,
                                            IOPMAssertionLevel(kIOPMAssertionLevelOn),
                                            reason as CFString,
                                            &noSleepAssertionID)
    return noSleepReturn == kIOReturnSuccess
}

public func enableScreenSleep() -> Bool {
    if noSleepReturn != nil {
        _ = IOPMAssertionRelease(noSleepAssertionID) == kIOReturnSuccess
        noSleepReturn = nil
        return true
    }
    return false
}

