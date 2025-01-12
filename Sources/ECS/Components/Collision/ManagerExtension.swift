extension Manager{
	public typealias CollisionTestFn = (CollisionTuple)->Bool
	public enum collisionTestEnum{
		case AABB
		
		public var function: CollisionTestFn{
			switch self{
			case AABB: 
				Collision.AABB(test:against:)
			}
		}
	}
	public typealias CollisionTuple = (A:CollisionComponent,B:CollisionComponent)
	
	private func testCollision(colA: CollisionComponent, entityB: Entity, test: collisionTestEnum)->[CollisionTuple]{
		var result: [CollisionTuple] = []
		guard let colB = entityB.getComponent(ofType: CollisionComponent.self) else { return result}
		guard let _ = colA.entity?.id == entityB.id else { return result } 
		var hit: Bool
		switch test{
			case AABB:
				hit = Collision.AABB(test: colA, against: colB)
		}
		if hit{
			var collision: CollisionTuple = (A: colA, B: colB)
			result.append(collision)
		}
		return result
	}
	private func findCollisions(for entity: Entity, using tester: collisionTestEnum )->[CollisionTuple]{
		var result: [CollisionTuple] = []
		var testFn = tester.function
		guard let colA = entity.getComponent(ofType: CollisionComponent.self) else { return result }
		self.forEachEntity( ){
			let collisions = testCollision(colA: colA, entityB: $0, test: tester)
			result.append(collision)
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
