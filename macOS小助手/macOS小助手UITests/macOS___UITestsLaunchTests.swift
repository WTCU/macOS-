//___FILEHEADER___

import XCTest

final class ___FILEBASENAMEASIDENTIFIER___: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // 在这里插入步骤，在应用程序启动后但在截图之前执行，
        // 例如登录到测试帐户或在应用程序中的某个位置导航

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
