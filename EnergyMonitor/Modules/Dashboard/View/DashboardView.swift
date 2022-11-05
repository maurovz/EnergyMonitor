import SwiftUI

enum AppError: Error, LocalizedError {
  case decodeError
  case networkError
  case databaseError

  var errorDescription: String? {
    switch self {
    case .decodeError:
      return NSLocalizedString("Decoding Error", comment: "")
    case .networkError:
      return NSLocalizedString("Network Error", comment: "")
    case .databaseError:
      return NSLocalizedString("Database Error", comment: "")
    }
  }
}

struct ErrorType: Identifiable {
  let id = UUID()
  let error: AppError
}

struct DashboardView: View {
  private static let energyUnit = "kW"
  private static let percentageString = "%"

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
              value: "\(String(format: "%.2f", viewModel.totalDischargedPower)) \(Self.energyUnit)",
              background: .blue)
            .padding([.top, .leading])
            SquareWidgetView(
              title: "Charged Energy",
              value: "\(String(format: "%.2f", viewModel.totalChargedPower)) \(Self.energyUnit)",
              background: .red)
            .padding([.top, .trailing])
          }

          RectangleWidgetView(values: [
            RectangleWidgetView.DisplayValue(
              title: "Solar Power",
              amount: "\(viewModel.liveDataViewModel.solarPower) \(Self.energyUnit)"),
            RectangleWidgetView.DisplayValue(
              title: "Quasar Power",
              amount: "\(viewModel.liveDataViewModel.quasarPower) \(Self.energyUnit)"),
            RectangleWidgetView.DisplayValue(
              title: "Grid Power",
              amount: "\(viewModel.liveDataViewModel.gridPower) \(Self.energyUnit)")
          ], background: .purple)
          .padding([.top, .leading, .trailing])

          NavigationLink(destination: DetailGraphComposer.createModule(historicData: viewModel.historicData)) {
            RectangleWidgetView(values: [
              RectangleWidgetView.DisplayValue(
                title: "Solar Power",
                amount: "\(viewModel.liveDataViewModel.solarPowerPercent) \(Self.percentageString)"),

              RectangleWidgetView.DisplayValue(
                title: "Quasar Power",
                amount: "\(viewModel.liveDataViewModel.quasarPowerPercent) \(Self.percentageString)"),

              RectangleWidgetView.DisplayValue(
                title: "Grid Power",
                amount: "\(viewModel.liveDataViewModel.gridPowerPercent) \(Self.percentageString)")
            ], background: .orange)
            .padding()
          }
        }
        .alert(isPresented: $viewModel.showError) {
          Alert(
            title: Text("Error"),
            message: Text(viewModel.appError?.error.errorDescription ?? ""),
            dismissButton: .default(Text("Aceptar")))
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
                .font(.system(size: 16, weight: .bold))
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
