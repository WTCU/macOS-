//
//  AppDelegate.swift
//  macOS小助手
//
//  Created by mac on 2023/1/1.
//  由mac于2023/1/1创建。
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        //在此处插入代码以初始化应用程序
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        //在此处插入代码以删除应用程序
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         应用程序的持久容器。此实施方式
         创建并返回一个容器，该容器已为
         此属性是可选的，因为存在合法的
         可能导致存储创建失败的错误条件。
         
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "macOS___")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                // 用代码替换此实现以正确处理错误。
                //fatalError（）导致应用程序生成崩溃日志并终止。您不应该在运输应用程序中使用此功能，尽管它在开发过程中可能很有用。
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 此处出现错误的典型原因包括：
                 * 父目录不存在、无法创建或不允许写入。
                 * 由于设备锁定时的权限或数据保护，永久存储不可访问。
                 * 设备空间不足。
                 * 无法将存储迁移到当前模型版本。
                 检查错误消息以确定实际问题是什么。
                 */
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving and Undo support
    //标记：-核心数据保存和撤消支持

    @IBAction func saveAction(_ sender: AnyObject?) {
        // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
        // 执行应用程序的保存操作，将save:消息发送到应用程序的托管对象上下文。任何遇到的错误都会显示给用户。
        let context = persistentContainer.viewContext

        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Customize this code block to include application-specific recovery steps.
                // 自定义此代码块以包括特定于应用程序的恢复步骤。
                let nserror = error as NSError
                NSApplication.shared.presentError(nserror)
            }
        }
    }

    func windowWillReturnUndoManager(window: NSWindow) -> UndoManager? {
        // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
        // 返回应用程序的NSUndoManager。在这种情况下，返回的管理器是应用程序的托管对象上下文的管理器。
        return persistentContainer.viewContext.undoManager
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        // Save changes in the application's managed object context before the application terminates.
        // 在应用程序终止之前，在应用程序的托管对象上下文中保存更改。
        let context = persistentContainer.viewContext
        
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing to terminate")
            return .terminateCancel
        }
        
        if !context.hasChanges {
            return .terminateNow
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError

            // 自定义此代码块以包括特定于应用程序的恢复步骤。
            // Customize this code block to include application-specific recovery steps.
            let result = sender.presentError(nserror)
            if (result) {
                return .terminateCancel
            }
            
            let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButton(withTitle: quitButton)
            alert.addButton(withTitle: cancelButton)
            
            let answer = alert.runModal()
            if answer == .alertSecondButtonReturn {
                return .terminateCancel
            }
        }
        // 如果我们到了这里，是时候退出了。
        // If we got here, it is time to quit.
        return .terminateNow
    }

}

