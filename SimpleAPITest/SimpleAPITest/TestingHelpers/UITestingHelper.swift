#if DEBUG

import Foundation

struct UITestingHelper {
    static var isUITesting: Bool {
        ProcessInfo.processInfo.arguments.contains("ui-testing")
    }
    
    static var shouldPostsResponseFail: Bool {
        ProcessInfo.processInfo.environment["network-response-fail"] == "1"
    }
}

#endif
