public class Manager{

	public init(){}
	
	static internal var lastComponentTypeID: Int = 0
	
	static public func getNewComponentTypeID() -> Int {
		Manager.lastComponentTypeID += 1
		return Manager.lastComponentTypeID
	}
	
	private var entities: [Int:Entity] = [:]
	private var groups: [Int:[Int]] = [:]
	private var maxGroupID: Int = 0
	private var collisionTestEntities: [Entity] = []
	
	public func update(){
		forEachEntityByGroup(){ $0.update()}
	}
	
	public func draw(renderer: any Renderer){
		forEachEntityByGroup(){ $0.draw(renderer: renderer)}
	}
	
	public func refresh(){
		let inactive = entities.filter({$0.value.isActive == false})
		inactive.forEach(){ remove(entity: $0.value)}
		collisionTestEntities.removeAll(where: {$0.isActive == false})
	}
	
	public func remove(entity: Entity){
		entities.removeValue(forKey: entity.id)

	}
	private func removeEntityFromAllGroups(_ entity: Entity){
		groups.forEach(){ (id,group) in
			if group.contains(entity.id){
				var newGroup: [Int] = group
				newGroup.removeAll(where: {$0 == entity.id})
				groups.updateValue(newGroup, forKey: id)
			}
		}
	}
	public func getEntityWith(id: Int)->Entity?{
		entities[id]
	}
	
	public func addNewEntity(toGroup groupID: Int = 0)->Entity{
		let e: Entity = Entity()
		entities.updateValue(e, forKey: e.id)
		if groups[groupID] != nil{
			var newGroup = groups[groupID]!
			newGroup.append(e.id)
			groups.updateValue(newGroup, forKey: groupID)
		} else {
			groups.updateValue([e.id], forKey: groupID)
		}
		maxGroupID = max(maxGroupID, groupID)
		return e
	}
	public func addToCollisionTests(entity: Entity){
		collisionTestEntities.append(entity)
	}
	public func forEachEntityByGroup(closure: (Entity)->()){
		for id in 0...maxGroupID{
			forEachEntityIn(group: id, closure: closure)
		}
	}
	public func forEachEntityIn(group groupID: Int, closure: (Entity)->()){
		groups[groupID]?.forEach{
			if let entity = entities[$0]{
				closure(entity)
			}
		}
	}
	public func forEachEntity(closure: (Entity)->()){
		entities.forEach(){ closure($0.value)}
	}
	
	public func testAllCollisions(action: (CollisionComponent, CollisionComponent)->Void){
		collisionTestEntities.forEach(){
		if let colA = $0.getComponent(ofType: CollisionComponent.self){
			let collisions = manager.findCollisions(for: $0, using: Collision.AABB(test:against:))
			collisions.forEach(){ colB in
				if colA.entity!.id != colB.entity!.id{
					print("Collision \(colA.tag) and \(colB.tag)")
					action(colA, colB)
				}
			}
		}
	}
}
