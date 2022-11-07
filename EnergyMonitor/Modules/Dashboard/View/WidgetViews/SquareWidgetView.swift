import SwiftUI

struct SquareWidgetView: View {
  let title: String
  let value: String
  let background: Color

  var body: some View {
    VStack {
      HStack {
        Text(title)
          .font(.system(size: 18, weight: .medium))
          .foregroundColor(.white)
        Spacer()
      }
      .padding()

      Text(value)
        .font(.system(size: 20, weight: .bold))
        .foregroundColor(.white)
      Spacer()
    }
    .frame(maxWidth: .infinity, minHeight: 150)
    .padding()
    .background(background)
    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
  }
}

struct SquareWidgetView_Previews: PreviewProvider {
    static var previews: some View {
      SquareWidgetView(
        title: "Title",
        value: "300",
        background: .blue)
    }
}
