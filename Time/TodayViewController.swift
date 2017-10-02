import Cocoa
import NotificationCenter

public class TodayViewController: NSViewController, NCWidgetProviding {
    
    private lazy var timer: DispatchSourceTimer = {
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer.schedule(wallDeadline: .now() + Date().nearestMinute().timeIntervalSinceNow,
                                 repeating: 60.0, leeway: .seconds(3))
        timer.setEventHandler { [weak self] in
            self?.tick()
        }
        return timer
    }()
    
    @IBOutlet var clock: NSTextField!
    @IBOutlet var aux: NSTextField!
    
    public override var nibName: NSNib.Name? {
        return NSNib.Name(rawValue: "TodayViewController")
    }
    
    public var widgetAllowsEditing: Bool {
        return false
    }
    
    public override func viewDidAppear() {
        super.viewDidAppear()
        self.timer.resume()
        tick()
    }
    
    public func widgetPerformUpdate(completionHandler: @escaping (NCUpdateResult) -> Void) {
        tick()
        completionHandler(.newData)
    }
    
    @objc func tick() {
        self.clock.stringValue = DateFormatter.localizedString(from: Date(),
                                                               dateStyle: .none, timeStyle: .short)
        self.aux.stringValue = TimeZone.current.abbreviation()!
    }
}

public extension Date {
    public func nearestMinute() -> Date {
        let c = Calendar.current
        var next = c.dateComponents(Set<Calendar.Component>([.minute]), from: self)
        next.minute = (next.minute ?? -1) + 1
        return c.nextDate(after: self, matching: next, matchingPolicy: .strict) ?? self
    }
}
