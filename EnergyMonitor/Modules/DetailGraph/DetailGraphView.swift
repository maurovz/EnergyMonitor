import SwiftUI
import Charts
import EnergyDataFeature

struct DetailGraphView: View {
  private let historicData: [HistoricDataViewModel]

  init(historicData: [HistoricDataViewModel]) {
    self.historicData = historicData
  }

  var body: some View {
    VStack {
      Chart {
        ForEach(historicData) {  data in
          LineMark(
            x: .value(Constants.time, data.timeStamp),
            y: .value(Constants.power, data.buildingPower),
            series: .value("", "A")
          )
          .foregroundStyle(.green)
        }

        ForEach(historicData) {  data in
          LineMark(
            x: .value(Constants.time, data.timeStamp),
            y: .value(Constants.power, data.gridPower),
            series: .value("", "B")
          )
          .foregroundStyle(.red)
        }

        ForEach(historicData) {  data in
          LineMark(
            x: .value(Constants.time, data.timeStamp),
            y: .value(Constants.power, data.pvPower),
            series: .value("", "C")
          )
          .foregroundStyle(.blue)
        }

        ForEach(historicData) {  data in
          LineMark(
            x: .value(Constants.time, data.timeStamp),
            y: .value(Constants.power, data.quasarsPower),
            series: .value("", "D")
          )
          .foregroundStyle(.yellow)
        }
      }
      .padding()
    }
  }
}

struct DetailGraphView_Previews: PreviewProvider {
  static var previews: some View {
    DetailGraphView(historicData: [
      HistoricDataViewModel(
        historicData: History(
          buildingPower: 100,
          gridPower: 300,
          pvPower: 200,
          quasarsPower: 100,
          timeStamp: Date()))
    ])
  }
}
