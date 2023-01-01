//___FILEHEADER___
//___文件头___
//判断：Xcode测试进程，目前不需要修改——庞玺桐2022.1.1

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
        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
