import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {}

class WindowController: NSWindowController {
    override func windowDidLoad() {
        self.window?.standardWindowButton(.closeButton)?.superview?.isHidden = true
        self.window?.level = .floating
    }
}
