import SwiftUI
import Charts
import EnergyDataFeature

struct DetailGraphView: View {
  let historicData: [HistoricDataViewModel]

  init(historicData: [HistoricDataViewModel]) {
    self.historicData = historicData
  }

  var body: some View {
    VStack {
      Text("Detail Data")
      Chart {
        ForEach(historicData) {  data in
          LineMark(
            x: .value("Time", data.timeStamp),
            y: .value("Building Power", data.buildingPower),
            series: .value("Company", "A")
          )
          .foregroundStyle(.green)
        }

        ForEach(historicData) {  data in
          LineMark(
            x: .value("Time", data.timeStamp),
            y: .value("Grid Power", data.gridPower),
            series: .value("Company", "B")
          )
          .foregroundStyle(.red)
        }

        ForEach(historicData) {  data in
          LineMark(
            x: .value("Time", data.timeStamp),
            y: .value("Total Count", data.pvPower),
            series: .value("Company", "C")
          )
          .foregroundStyle(.blue)
        }

        ForEach(historicData) {  data in
          LineMark(
            x: .value("Shape Type", data.timeStamp),
            y: .value("Total Count", data.quasarsPower),
            series: .value("Company", "D")
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
