import CoreData

public struct CoreDataServices {
  public init() { }

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
}

// MARK: - Historic Data Service
extension CoreDataServices {
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

  private func fetchHistoricDataEntity() -> [HistoryEntity] {
    let context = CoreDataStack.persistentContainer.viewContext
    do {
      return try context.fetch(HistoryEntity.fetchRequest())
    } catch {
      return []
    }
  }
}

// MARK: - Live Data Service
extension CoreDataServices {
  public func saveLiveDataToCache(data: LiveData) {
    let context = CoreDataStack.persistentContainer.viewContext

    let entity = LiveDataEntity(context: context)
    entity.solarPower = data.solarPower
    entity.quasarPower = data.quasarPower
    entity.gridPower = data.gridPower
    entity.buildingDemand = data.buildingDemand
    entity.systemSoc = data.systemSoc
    entity.totalEnergy = data.totalEnergy
    entity.currentEnergy = data.currentEnergy
    CoreDataStack.saveContext()
  }

  public func loadLiveDataFromCoreData() -> LiveData? {
    guard let entity = fetchLiveDataEntity() else { return nil }

    let liveData = LiveData(
      solarPower: entity.solarPower,
      quasarPower: entity.quasarPower,
      gridPower: entity.gridPower,
      buildingDemand: entity.buildingDemand,
      systemSoc: entity.systemSoc,
      totalEnergy: entity.totalEnergy,
      currentEnergy: entity.currentEnergy)

    return liveData
  }

  public func deleteLiveDataEntityFromCoreData() {
    _ = deleteEntityFromCoreData(entity: "LiveDataEntity")
  }

  private func fetchLiveDataEntity() -> LiveDataEntity? {
    let context = CoreDataStack.persistentContainer.viewContext
    do {
      let request = LiveDataEntity.fetchRequest()
      let liveData = try context.fetch(request)
      return liveData.first
    } catch {
      return nil
    }
  }
}
