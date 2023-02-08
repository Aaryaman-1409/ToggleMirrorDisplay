//
//  Toggle_Mirror_DisplayApp.swift
//  Toggle Mirror Display
//
//  Created by Aaryaman Sharma on 08/02/2023.
//

import SwiftUI
import Foundation

func shell(_ command: String) -> String {
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/zsh"
    task.standardInput = nil
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    return output
}

func getMirrorPath() -> String {
    let bundle = Bundle.main
    let pathToExecutable = bundle.url(forResource: "mirror", withExtension: "")!.path()
    return "'"+pathToExecutable.replacingOccurrences(of: "%20", with: " ")+"'"
}

@main
struct swiftui_menu_barApp: App {
    var mirrorPath = getMirrorPath()
    
    var body: some Scene {

        MenuBarExtra("Toggle Display Mirroring", systemImage: "display.2") {
  
            Button("Disable Mirroring") {
                print(shell(mirrorPath + " -off"))
            }
            Button("Mirror Built-in Display to External Display") {
                print(shell(mirrorPath + " -l 1 0"))
            }
            Button("Mirror External Display to Built-in Display") {
                print(shell(mirrorPath + " -on"))
            }
            Divider()

            Button("Quit") {

                NSApplication.shared.terminate(nil)

            }.keyboardShortcut("q")

        }
    }
}
