import Foundation

public class RotationAnimation: AnimationOverTime{
    public var entity: Entity? = nil
    public static let typeID: Int = Manager.getNewComponentTypeID()
    public let duration: Duration
    private let direction: Float
    public let startTime = SuspendingClock.now
    private var restoredRotate: SIMD3<Float> = .zero
    public init(duration: Duration, direction: Float){
        self.duration = duration
        self.direction = direction
    }
    public func setup() {
        restoredRotate = entity?.getComponent(ofType: TransformComponent.self)?.rotation ?? .zero
    }
    public func animate(progress: Float) {
        var y = progress * 2 
        if y > 1 { y = 1 - (y - 1)}
        entity?.getComponent(ofType: TransformComponent.self)?.rotation = SIMD3(0, 0, y * direction)
    }
    
    public func destroy() {
        entity?.getComponent(ofType: TransformComponent.self)?.rotation = restoredRotate
    }
    
}
