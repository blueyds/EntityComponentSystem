import Foundation
import simd



public class ScaleAnimation:AnimationOverTime{
    public var entity: (any Entity)!
    public static var typeID: Int = Manager.getNewComponentTypeID()
    
   // private var repeatTimes: Float
    public let duration: Duration
    public let startTime = SuspendingClock.now
    private var restoreScale: SIMD3<Float> = .one
    public init(duration: Duration){
        self.duration = duration        
    }
    public func setup() {
        guard let transform: TransformComponent = getComponent(inEntity: entity) else {return} 
        restoreScale =  transform.scale
    }
    public func animate(progress: Float) {
        guard let transform: TransformComponent = getComponent(inEntity: entity) else {return}
        var y = progress
        if y > 0.50 { y = 0.5 - (y  - 0.5)}
        transform.scale = SIMD3(1, 1 - y, 1)
    }
    
    public func destroy() {
        guard let transform: TransformComponent = getComponent(inEntity: entity) else {return}
        transform.scale = restoreScale
    }
    
}
