import Foundation

public class FollowerComponent: Component{
    public var entity: (any Entity)!
    public static var typeID: Int = Manager.getNewComponentTypeID()
    private var follow: any Entity
    private let ignoreZ: Bool
    public init(follow: any Entity, ignoreZ: Bool = false){
        self.follow = follow
        self.ignoreZ = ignoreZ
    }
    
    public func update() {
        guard let followTransforms:TransformComponent = getComponentIn(entity: follow) 
            else { return}
        guard let myTransfroms: TransformComponent = getComponentIn(entity: entity)
            else { return }
        var pos: SIMD3<Float> = followTransforms.position
        if ignoreZ{
            pos.z = myTransfroms.position.z
        }
        myTransfroms.position = pos
    }
}
