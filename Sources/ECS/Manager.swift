public class Manager{
	
	public init(){}
	
	static internal var lastComponentTypeID: Int = 0
	
	static public func getNewComponentTypeID() -> Int {
		Manager.lastComponentTypeID += 1
		return Manager.lastComponentTypeID
	}
	
	private var entities: [Entity] = []
	
	public func update(){
		entities.forEach(){ $0.update()}
	}
	
	public func draw(renderer: any Renderer){
		entities.forEach(){ $0.draw(renderer: renderer)}
	}
	
	public func refresh(){}
	
	public func remove(entity: Entity){
		entities.removeAll(where: {$0.id == entity.id})
	}
	
	public func addNewEntity()->Entity{
		let e: Entity = Entity()
		entities.append(e)
		return e
	}
}
