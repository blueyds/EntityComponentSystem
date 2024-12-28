import Foundation
import simd



public class ScaleAnimation:AnimationOverTime{
    public var entity: Entity? = nil
    public static var typeID: Int = Manager.getNewComponentTypeID()
    
   // private var repeatTimes: Float
    public let duration: Duration
    public let startTime = SuspendingClock.now
    private var restoreScale: SIMD3<Float> = .one
    public init(duration: Duration){
        self.duration = duration        
    }
    public func setup() {
        restoreScale =  entity?.getComponent(ofType: TransformComponent.self)?.scale ?? .one
    }
    public func animate(progress: Float) {
        var y = progress
        if y > 0.50 { y = 0.5 - (y  - 0.5)}
        entity?.getComponent(ofType: TransformComponent.self)?.scale = SIMD3(1, 1 - y, 1)
    }
    
    public func destroy() {
        entity?.getComponent(ofType: TransformComponent.self)?.scale = restoreScale
    }
    
}
