extension Manager{
	
	public func findCollisions(for entity: Entity, using testFn: (CollisionComponent,CollisionComponent)->Bool)->[CollisionComponent]{
		var result: [CollisionComponent] = []
		guard let colA = entity.getComponent(ofType: CollisionComponent.self) else { return result }
		self.forEach(){
			if let col = $0.getComponent(ofType: CollisionComponent.self),
				testFn(colA, col){
				result.append(col)
			}
		}
		return result
	}
}