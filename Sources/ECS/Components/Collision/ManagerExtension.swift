extension Manager{
	public typealias CollisionTestFn = (CollisionComponent,CollisionComponent)->Bool
	public func findCollisions(for entity: Entity, using testFn: CollisionTestFn )->[CollisionComponent]{
		var result: [CollisionComponent] = []
		guard let colA = entity.getComponent(ofType: CollisionComponent.self) else { return result }
		self.forEach(){
			if let colB = $0.getComponent(ofType: CollisionComponent.self),
				testFn(colA, colB){
				if colA.entity?.id != colB.entity?.id{
					result.append(colB)
				}
			}
		}
		return result
	}
	
}