import SwiftUI

struct DashboardView: View {
  @ObservedObject var viewModel: DashboardViewModel

  init(viewModel: DashboardViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    NavigationView {
      ScrollView {
        Text("Energy Dashboard")
          .foregroundColor(.white)
          .font(.system(size: 30, weight: .semibold))
          .padding()
        VStack {
          HStack {
            SquareWidgetView(
              title: "Discharged Energy",
              value: "\(String(format: "%.2f", viewModel.totalDischargedPower)) KW",
              background: .blue)
              .padding([.top, .leading])
            SquareWidgetView(
              title: "Charged Energy",
              value: "\(String(format: "%.2f", viewModel.totalChargedPower)) KW",
              background: .red)
              .padding([.top, .trailing])
          }

          RectangleWidgetView(values: [
            RectangleWidgetView.DisplayValue(
              title: "Solar Power", amount: viewModel.liveDataViewModel.solarPower),
            RectangleWidgetView.DisplayValue(
              title: "Quasar Power", amount: viewModel.liveDataViewModel.quasarPower),
            RectangleWidgetView.DisplayValue(
              title: "Building Demand", amount: viewModel.liveDataViewModel.buildingDemand),
            RectangleWidgetView.DisplayValue(
              title: "System Soc", amount: viewModel.liveDataViewModel.systemSoc)
          ], background: .purple)
            .padding([.top, .leading, .trailing])

          NavigationLink(destination: DetailGraphComposer.createModule(historicData: viewModel.historicData)) {
            RectangleWidgetView(values: [
              RectangleWidgetView.DisplayValue(title: "Solar Power", amount: viewModel.liveDataViewModel.solarPower),
              RectangleWidgetView.DisplayValue(title: "QuasarPower", amount: viewModel.liveDataViewModel.quasarPower),
              RectangleWidgetView.DisplayValue(title: "Building Demand", amount: viewModel.liveDataViewModel.buildingDemand),
              RectangleWidgetView.DisplayValue(title: "System Soc", amount: viewModel.liveDataViewModel.systemSoc)
            ], background: .orange)
              .padding()
          }
        }
      }
    }
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
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            }
          }
          .padding([.top, .leading, .bottom])
        }
      }
    }
    .frame(maxWidth: .infinity, minHeight: 150)
    .padding()
    .background(background)
    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
  }
}
