//
//  AppDelegate.swift
//  macOS小助手
//
//  Created by mac on 2023/1/1.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
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
        */
        let container = NSPersistentContainer(name: "macOS___")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                // 用代码替换此实现以正确处理错误。
                //fatalError（）导致应用程序生成崩溃日志并终止。您不应该在运输应用程序中使用此功能，尽管它在开发过程中可能很有用。
                 
                /*
                 此处出现错误的典型原因包括：
                 * 父目录不存在、无法创建或不允许写入。
                 * 由于设备锁定时的权限或数据保护，永久存储不可访问。
                 * 设备空间不足。
                 * 无法将存储迁移到当前模型版本。
                 检查错误消息以确定实际问题是什么。
                 */
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving and Undo support

    @IBAction func saveAction(_ sender: AnyObject?) {
        // 执行应用程序的保存操作，将save:消息发送到应用程序的托管对象上下文。任何遇到的错误都会显示给用户。
        let context = persistentContainer.viewContext

        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // 自定义此代码块以包括特定于应用程序的恢复步骤。
                let nserror = error as NSError
                NSApplication.shared.presentError(nserror)
            }
        }
    }

    func windowWillReturnUndoManager(window: NSWindow) -> UndoManager? {
        // 返回应用程序的NSUndoManager。在这种情况下，返回的管理器是应用程序的托管对象上下文的管理器。
        return persistentContainer.viewContext.undoManager
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
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
        return .terminateNow
    }

}

