extension Manager{
	public typealias CollisionTestFn = (CollisionComponent,CollisionComponent)->Bool
	public func findCollisions(for entity: Entity, using testFn: CollisionTestFn )->[CollisionComponent]{
		var result: [CollisionComponent] = []
		guard let colA = entity.getComponent(ofType: CollisionComponent.self) else { return result }
		self.forEach(){
			testCollision(colA: colA, entityB: $0, using: testFn(::))
		}
		return result
	}
	private func testCollision(colA: CollisionComponent, entityB: Entity, using testFn: CollisionTestFn-> CollisionComponent?{
		var result: CollisionComponent? = nil
		if let colB = entityB.getComponent(ofType: CollisionComponent.self),
			testFn(colA, colB){
			if colA.id != colB.id{
				result = colB
			}
		}
		return result
	}
}