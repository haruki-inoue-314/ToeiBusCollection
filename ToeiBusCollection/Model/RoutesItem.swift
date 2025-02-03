import Foundation
import SwiftData

@Model
final class RoutesItem {
  var routeId: String
  var routeShortName: String
  var routeUrl: String
  var routeColor: String
  var routeTextColor: String
  var isCompleted: Bool = false

  init(routeId: String, routeShortName: String, routeUrl: String, routeColor: String, routeTextColor: String) {
    self.routeId = routeId
    self.routeShortName = routeShortName
    self.routeUrl = routeUrl
    self.routeColor = routeColor
    self.routeTextColor = routeTextColor
  }
}

