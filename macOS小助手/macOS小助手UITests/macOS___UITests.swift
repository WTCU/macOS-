//___FILEHEADER___

import XCTest

final class ___FILEBASENAMEASIDENTIFIER___: XCTestCase {

    override func setUpWithError() throws {
        // 在此处输入设置代码。在调用类中的每个测试方法之前调用该方法。

        // 在UI测试中，通常最好在出现故障时立即停止。
        continueAfterFailure = false

        // 在UI测试中，在测试运行之前设置测试所需的初始状态（如界面方向）非常重要。setUp方法是一个很好的方法。
    }

    override func tearDownWithError() throws {
        // 在这里输入拆卸代码。该方法在调用类中的每个测试方法后调用。
    }

    func testExample() throws {
        // UI测试必须启动它们测试的应用程序。
        let app = XCUIApplication()
        app.launch()

        // 使用XCTAssert和相关函数验证测试是否产生正确的结果。
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // 这衡量启动应用程序所需的时间。
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
