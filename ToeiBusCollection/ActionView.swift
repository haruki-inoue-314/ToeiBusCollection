import SwiftUI

struct ActionView: View {
  let item: RoutesItem
  let action: (RoutesItem) -> Void

  var body: some View {
    VStack(spacing: 16) {
      Text(item.routeShortName)
        .font(.title)
        .fontWeight(.bold)


      if let destinationURL = URL(string: item.routeUrl) {
        Link(destination: destinationURL) {
          Label("経路の情報を見る", systemImage: "safari")
        }
      }

      Button(action: {
        action(item)
      }, label: {
        Text(item.isCompleted ? "乗車を取り消す" : "乗車記録に追加")
          .foregroundStyle(.white)
      })
      .buttonStyle(.bordered)
      .background(.blue)
      .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    .frame(maxWidth: .infinity, maxHeight: 180)

  }
}

#Preview {
  ActionView(
    item: RoutesItem(
      routeId: "test001",
      routeShortName: "都01",
      routeUrl: "https://www.google.com",
      routeColor: "#000000",
      routeTextColor: "#FFFFFF"
    ),
    action: { item in
      print(item.routeShortName)
    }
  )
}
