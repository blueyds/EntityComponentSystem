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
	
	private func findCollisions(for entity: Entity, using tester: collisionTestEnum )->[CollisionTuple]{
		var result: [CollisionTuple] = []
		var testFn: = tester.function
		guard let colA = entity.getComponent(ofType: CollisionComponent.self) else { return result }
		self.forEachEntity( ){
			if let colB = $0.getComponent(ofType: CollisionComponent.self),
			testFn(colA, colB), 
			colA.entity?.id != colB.entity?.id{
				result.append((A:colA,B:colB))
			}
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
