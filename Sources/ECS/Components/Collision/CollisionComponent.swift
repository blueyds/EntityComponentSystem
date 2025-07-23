public class CollisionComponent: Component{
    public var entity: (any Entity)!
    public var col: CollisionRect = CollisionRect()
    public let tag: String
    public var offset: SIMD2<Float>
	public var entityID: Int = 0
    static public var typeID: Int = Manager.getNewComponentTypeID()
    public init(tag: String, offset: SIMD2<Float> = .zero, bounds: SIMD2<Float> = .one){
        self.tag = tag
        self.offset = offset
        col.height = bounds.y
        col.width = bounds.x
    }

    public func update() {
        if let transform: TransformComponent = getComponent(inEntity: entity){
            col.x = transform.position.x + offset.x
            col.y = transform.position.y  + offset.y
        }
		entityID = entity?.id ?? 0
    }
    
    
}
