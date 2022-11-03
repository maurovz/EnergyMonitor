import CoreData

public struct CoreDataServices {
  public init() { }

  public func saveHistoricDataToCache(data: [History]) {
    let context = CoreDataStack.persistentContainer.viewContext

    for history in data {
      let entity = HistoryEntity(context: context)
      entity.buildingPower = NSDecimalNumber(decimal: history.buildingPower)
      entity.gridPower = NSDecimalNumber(decimal: history.gridPower)
      entity.pvPower = NSDecimalNumber(decimal: history.pvPower)
      entity.quasarsPower = NSDecimalNumber(decimal: history.quasarsPower)
      entity.timeStamp = history.timeStamp
      CoreDataStack.saveContext()
    }
  }

  public func loadHistoricDataFromCoreData() -> [History] {
    let entities = fetchHistoricDataEntity()
    var historicData: [History] = []

    for entity in entities {
      guard
        let buildingPower = entity.buildingPower,
        let gridPower = entity.gridPower,
        let pvPower = entity.pvPower,
        let quasarsPower = entity.quasarsPower,
        let timeStamp = entity.timeStamp
      else {
        continue
      }

      historicData.append(History(
        buildingPower: buildingPower as Decimal,
        gridPower: gridPower as Decimal,
        pvPower: pvPower as Decimal,
        quasarsPower: quasarsPower as Decimal,
        timeStamp: timeStamp))
    }

    return historicData
  }

  public func deleteHistoryEntityFromCoreData() {
    _ = deleteEntityFromCoreData(entity: "HistoryEntity")
  }

  public func deleteEntityFromCoreData(entity: String) -> Bool {
    let context = CoreDataStack.persistentContainer.viewContext
    do {
      let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
      let request = NSBatchDeleteRequest(fetchRequest: fetch)
      try context.execute(request)
      return true
    } catch {
      return false
    }
  }

  private func fetchHistoricDataEntity() -> [HistoryEntity] {
    let context = CoreDataStack.persistentContainer.viewContext
    do {
      return try context.fetch(HistoryEntity.fetchRequest())
    } catch {
      return []
    }
  }
}
