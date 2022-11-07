import SwiftUI

struct RectangleWidgetView: View {
  struct DisplayValue: Hashable {
    let title: String
    let amount: String
  }

  let values: [DisplayValue]
  let background: Color

  var body: some View {
    VStack {
      HStack(alignment: .top) {
        ForEach(values, id: \.self) { value in
          VStack {
            Text(value.title)
              .font(.system(size: 14, weight: .medium))
              .foregroundColor(.white)

            HStack {
              Text(value.amount)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
            }
          }
          .padding([.top, .leading, .bottom])
        }
      }
    }
    .frame(maxWidth: .infinity, minHeight: 100)
    .padding()
    .background(background)
    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
  }
}

struct RectangleWidgetView_Previews: PreviewProvider {
    static var previews: some View {
      RectangleWidgetView(
        values: [.init(title: "Title", amount: "500")],
        background: .blue)
    }
}
