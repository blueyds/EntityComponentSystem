import Foundation

public class FollowerComponent: Component{
    public var entity: Entity? = nil
    public static var typeID: Int = Manager.getNewComponentTypeID()
    private var follow: Entity
    private let ignoreZ: Bool
    public init(follow: Entity, ignoreZ: Bool = false){
        self.follow = follow
        self.ignoreZ = ignoreZ
    }
    
    public func update() {
        guard let followTransforms = follow.getComponent(ofType: TransformComponent.self) 
            else { return}
        guard let myTransfroms = entity?.getComponent(ofType: TransformComponent.self)
            else { return }
        var pos: SIMD3<Float> = followTransforms.position
        if ignoreZ{
            pos.z = myTransfroms.position.z
        }
        myTransfroms.position = pos
    }
}
