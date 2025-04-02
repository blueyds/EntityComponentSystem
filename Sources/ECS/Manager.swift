// Code inside modules can be shared between pages and other source files.
public class Manager{
    
    public init(){}
    
    static internal var lastComponentTypeID: Int = 0
    
    static public func getNewComponentTypeID() -> Int {
        Manager.lastComponentTypeID += 1
        return Manager.lastComponentTypeID
    }
    
    fileprivate var entities: [Int:any Entity] = [:]
    fileprivate var groups: [Int:[Int]] = [:]
    fileprivate var maxGroupID: Int = 0
    internal var collisionTestEntities: [any Entity] = []
    
    public func update(){
        forEachEntityByGroup(){ $0.update()}
    }
    
    public func draw(renderer: any Renderer){
        forEachEntityByGroup(){ $0.draw(renderer: renderer)}
    }
    
    public func refresh(){
        let inactive = entities.filter({$0.value.isActive == false})
        inactive.forEach(){ entities.removeValue(forKey: $0.key)}
        collisionTestEntities.removeAll(where: {$0.isActive == false})
    }
    
    public func remove(entity: any Entity){
        entities.removeValue(forKey: entity.id)

    }
    private func removeEntityFromAllGroups(_ entity: any Entity){
        groups.forEach(){ (id,group) in
            if group.contains(entity.id){
                var newGroup: [Int] = group
                newGroup.removeAll(where: {$0 == entity.id})
                groups.updateValue(newGroup, forKey: id)
            }
        }
    }
    public func getEntityWith(id: Int)->(any Entity)?{
        entities[id]
    }
    
    public func add(entity: any Entity, toGroup groupID: Int = 0){
        entities.updateValue(entity, forKey: entity.id)
        if groups[groupID] != nil{
            var newGroup = groups[groupID]!
            newGroup.append(entity.id)
            groups.updateValue(newGroup, forKey: groupID)
        } else {
            groups.updateValue([entity.id], forKey: groupID)
        }
        maxGroupID = max(maxGroupID, groupID)
        if let collision: CollisionComponent = getComponentIn(entity: entity){
            addToCollisionTests(entity: entity)
        }
    }
    public func addToCollisionTests(entity: any Entity){
        collisionTestEntities.append(entity)
    }
    public func forEachEntityByGroup(do closure: (any Entity)->()){
        for id in 0...maxGroupID{
            forEachEntityIn(group: id, do: closure)
        }
    }
    public func forEachEntityIn(group groupID: Int, do closure: (any Entity)->()){
        groups[groupID]?.forEach{
            if let entity = entities[$0]{
                closure(entity)
            }
        }
    }
    public func forEachEntity(do closure: (any Entity)->()){
        entities.forEach(){ closure($0.value)}
    }
}
