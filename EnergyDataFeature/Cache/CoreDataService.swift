import CoreData

public struct CoreDataServices {
  public init() { }

  public func saveHistoricDataToCache(data: [History]) {
    let context = CoreDataStack.persistentContainer.viewContext

    for history in data {
      let entity = HistoryEntity(context: context)
      entity.buildingPower = history.buildingPower
      entity.gridPower = history.gridPower
      entity.pvPower = history.pvPower
      entity.quasarsPower = history.quasarsPower
      entity.timeStamp = history.timeStamp
      CoreDataStack.saveContext()
    }
  }

  public func loadHistoricDataFromCoreData() -> [History] {
    let entities = fetchHistoricDataEntity()
    var historicData: [History] = []

    for entity in entities {
      historicData.append(History(
        buildingPower: entity.buildingPower,
        gridPower: entity.gridPower,
        pvPower: entity.pvPower,
        quasarsPower: entity.quasarsPower,
        timeStamp: entity.timeStamp ?? Date()))
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
