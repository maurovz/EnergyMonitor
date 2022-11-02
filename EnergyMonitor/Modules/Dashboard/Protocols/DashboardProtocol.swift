import Foundation

protocol DashboardProtocol: AnyObject {
  func showError(message: String)
  func didLoadData()
}
