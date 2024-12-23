public struct CollisionRect{
    var x: Float = .zero
    var y: Float = .zero
    var width: Float = .zero
    var height: Float = .zero
    var widthExtant: Float {
        x + width
    }
    var heightExtant: Float {
        y + height
    }
}
