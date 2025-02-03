import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \RoutesItem.routeId) private var routesItems: [RoutesItem]

  var body: some View {
    NavigationStack {
      List {
        ForEach(routesItems) { item in
          Button {
            item.isCompleted.toggle()
          } label: {
            itemCell(name: item.routeShortName, isCompleted: item.isCompleted)
          }

        }
      }
      .navigationTitle("都営バス乗車記録")
    }
    .onAppear {
      addRouteItem()
    }
  }

  private func itemCell(name: String, isCompleted: Bool) -> some View {
    HStack {
      Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
      Text(name)
        .foregroundStyle(.black)
    }
  }


  private func addRouteItem() {
    // すでにデータがある場合は処理をしない
    if !routesItems.isEmpty {
      return
    }

    // csvファイルのパスを取得
    guard
      let path = Bundle.main.path(forResource: "routes", ofType: "csv"),
      let csvString = try? String(contentsOfFile: path, encoding: .utf8)
    else {
      return
    }

    let lines = csvString.components(separatedBy: .newlines).dropFirst().dropLast()

    for line in lines {
      let columns = line.components(separatedBy: ",")
      let routeId = columns[0]
      let routeShortName = columns[2]
      let routeUrl = columns[6]
      let routeColor = columns[7]
      let routeTextColor = columns[8]

      let routesItem = RoutesItem(routeId: routeId, routeShortName: routeShortName, routeUrl: routeUrl, routeColor: routeColor, routeTextColor: routeTextColor)

      modelContext.insert(routesItem)
    }
  }
}


#Preview {
  ContentView()
    .modelContainer(for: RoutesItem.self, inMemory: true)
}
