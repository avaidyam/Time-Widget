import Cocoa
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding {
    
    var timer = NSTimer()
    
    @IBOutlet var clock: NSTextField!
    @IBOutlet var aux: NSTextField!
    
    override var nibName: String? {
        return "TodayViewController"
    }
    
    var widgetAllowsEditing: Bool {
        return false
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        tick()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self,
            selector: Selector("tick"), userInfo: nil, repeats: true)
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        tick();
        completionHandler(.NewData)
    }
    
    @objc func tick() {
        clock.stringValue = NSDateFormatter.localizedStringFromDate(NSDate(),
                            dateStyle: .NoStyle, timeStyle: .ShortStyle)
        aux.stringValue = NSTimeZone.localTimeZone().abbreviation!
    }
}
