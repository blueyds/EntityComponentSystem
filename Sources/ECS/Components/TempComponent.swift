import Foundation


public class TempComponent: AnimationOverTime{
    public var entity: (any Entity)!
    public static let typeID: Int = Manager.getNewComponentTypeID()
    
    public var duration: Duration
    public let startTime: SuspendingClock.Instant = SuspendingClock.now
    public init(duration: Duration){
        self.duration = duration
    }
    public func animate(progress: Float) {}
    
    public func destroy() {
        entity?.isActive = false
    }
}
