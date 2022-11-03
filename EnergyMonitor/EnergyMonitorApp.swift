import SwiftUI

@main
struct EnergyMonitorApp: App {
  var body: some Scene {
    WindowGroup {
      DashboardComposer.createModule()
    }
  }
}
