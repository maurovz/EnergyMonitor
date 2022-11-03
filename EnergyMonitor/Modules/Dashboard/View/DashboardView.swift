import SwiftUI

struct DashboardView: View {
  @ObservedObject var viewModel: DashboardViewModel

  init(viewModel: DashboardViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    ScrollView {
      Text("Energy Dashboard")
        .foregroundColor(.white)
        .font(.system(size: 30, weight: .semibold))
        .padding()
      VStack {
        HStack {
          SquareWidgetView(title: "Building Energy", value: "\($viewModel.historicData.count)", background: .blue)
            .padding([.top, .leading])
          SquareWidgetView(title: "Charged Energy", value: "300 KW", background: .red)
            .padding([.top, .trailing])
        }

        RectangleWidgetView(title: "Solar", value: "320", background: .purple)
          .padding([.top, .leading, .trailing])
        RectangleWidgetView(title: "Solar", value: "320", background: .orange)
          .padding()
      }
    }
    .background(Color.black)
  }
}

// struct DashboardView_Previews: PreviewProvider {
//  static var previews: some View {
//    DashboardView()
//  }
// }

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
        .font(.system(size: 25, weight: .bold))
        .foregroundColor(.white)
      Spacer()
    }
    .frame(maxWidth: .infinity, minHeight: 150)
    .padding()
    .background(background)
    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
  }
}

struct RectangleWidgetView: View {
  let title: String
  let value: String
  let background: Color

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        VStack {
          Text(title)
            .font(.system(size: 18, weight: .medium))
          .foregroundColor(.white)

          HStack {
            Text(value)
              .font(.system(size: 25, weight: .bold))
              .foregroundColor(.white)
          }
        }
        .padding([.top, .leading, .bottom])

        VStack {
          Text(title)
            .font(.system(size: 18, weight: .medium))
          .foregroundColor(.white)

          Text(value)
            .font(.system(size: 25, weight: .bold))
            .foregroundColor(.white)
        }
        .padding([.top, .leading, .bottom])

        Spacer()
        VStack {
          Text(title)
            .font(.system(size: 18, weight: .medium))
          .foregroundColor(.white)

          Text(value)
            .font(.system(size: 25, weight: .bold))
            .foregroundColor(.white)
        }
        .padding()

        VStack {
          Text(title)
            .font(.system(size: 18, weight: .medium))
          .foregroundColor(.white)

          Text(value)
            .font(.system(size: 25, weight: .bold))
            .foregroundColor(.white)
        }
        .padding()
      }

    }
    .frame(maxWidth: .infinity, minHeight: 150)
    .padding()
    .background(background)
    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
  }
}
