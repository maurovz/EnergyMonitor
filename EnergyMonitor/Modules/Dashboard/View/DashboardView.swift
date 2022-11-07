import SwiftUI

struct DashboardView: View {
  @ObservedObject var viewModel: DashboardViewModel

  init(viewModel: DashboardViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    NavigationView {
      ScrollView {
        Image("banner")
          .resizable()
          .frame(maxWidth: .infinity, maxHeight: 300)
          .aspectRatio(contentMode: .fit)
          .cornerRadius(20)
          .padding([.leading, .trailing], 20)

        VStack {
          HStack {
            SquareWidgetView(
              title: "Discharged Energy",
              value: "\(String(format: "%.2f", viewModel.totalDischargedPower)) \(Constants.kilowattHour)",
              background: .blue)
            .padding([.top, .leading])
            SquareWidgetView(
              title: "Charged Energy",
              value: "\(String(format: "%.2f", viewModel.totalChargedPower)) \(Constants.kilowattHour)",
              background: .red)
            .padding([.top, .trailing])
          }

          RectangleWidgetView(values: [
            RectangleWidgetView.DisplayValue(
              title: Constants.solarPower,
              amount: "\(viewModel.liveDataViewModel.solarPower) \(Constants.kilowatt)"),
            RectangleWidgetView.DisplayValue(
              title: Constants.quasarPower,
              amount: "\(viewModel.liveDataViewModel.quasarPower) \(Constants.kilowatt)"),
            RectangleWidgetView.DisplayValue(
              title: Constants.gridPower,
              amount: "\(viewModel.liveDataViewModel.gridPower) \(Constants.kilowatt)")
          ], background: .purple)
          .padding([.top, .leading, .trailing])

          NavigationLink(destination: DetailGraphComposer.createModule(historicData: viewModel.historicData)) {
            RectangleWidgetView(values: [
              RectangleWidgetView.DisplayValue(
                title: Constants.solarPower,
                amount: "\(viewModel.liveDataViewModel.solarPowerPercent) \(Constants.percentageString)"),

              RectangleWidgetView.DisplayValue(
                title: Constants.quasarPower,
                amount: "\(viewModel.liveDataViewModel.quasarPowerPercent) \(Constants.percentageString)"),

              RectangleWidgetView.DisplayValue(
                title: Constants.gridPower,
                amount: "\(viewModel.liveDataViewModel.gridPowerPercent) \(Constants.percentageString)")
            ], background: .orange)
            .padding()
          }
        }
        .alert(isPresented: $viewModel.showError) {
          Alert(
            title: Text("Error"),
            message: Text(viewModel.appError?.errorDescription ?? ""),
            dismissButton: .default(Text("Aceptar")))
        }
      }
      .background(Color.black)
    }

  }
}
