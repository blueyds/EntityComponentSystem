import Foundation


public protocol AnimationOverTime: Component{
    var duration: Duration { get }
    var startTime: SuspendingClock.Instant { get }
    func animate(progress: Float)
}

extension AnimationOverTime{
    public func update(){
        let y = Float(startTime.duration(to: SuspendingClock.now) / duration) 
       // print(progress)
        if y <= 1.0{ animate(progress: y)}
        else {entity?.removeComponent(ofType: Self.self)}
    }
}
