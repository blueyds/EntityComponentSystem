extension Manager{
	public typealias CollisionTestFn = (CollisionTuple)->Bool
	public enum collisionTestEnum{
		case AABB
	}
	public typealias CollisionTuple = (A:CollisionComponent,B:CollisionComponent)
	
	private func testCollision(colA: CollisionComponent, entityB: any Entity, test: collisionTestEnum)->[CollisionTuple]{
		var result: [CollisionTuple] = []
		guard let colB: CollisionComponent = getComponentIn(entity: entityB) else { return result}
		if colA.entity.id == entityB.id { return result } 
		var hit: Bool
		switch test{
			case .AABB:
				hit = Collision.AABB(test: colA, against: colB)
		}
		if hit{
			var collision: CollisionTuple = (A: colA, B: colB)
			result.append(collision)
		}
		return result
	}
	private func findCollisions(for entity: any Entity, using tester: collisionTestEnum )->[CollisionTuple]{
		var result: [CollisionTuple] = []
		guard let colA: CollisionComponent = getComponentIn(entity: entity) else { return result}
		self.forEachEntity( ){
			let collisions = testCollision(colA: colA, entityB: $0, test: tester)
			result.append(contentsOf: collisions)
		}
		return result
	}
	
	public func testCollisions(using test: collisionTestEnum)->[CollisionTuple]{
		var collisions: [CollisionTuple] = []
		collisionTestEntities.forEach(){
			let newCollisions = findCollisions(for: $0, using: test)
			collisions.append(contentsOf: newCollisions)
		}
		return collisions
	}
	
}
