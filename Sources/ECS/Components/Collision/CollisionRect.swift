public struct CollisionRect{
    public var x: Float = .zero
    public var y: Float = .zero
    public var width: Float = .zero
    public var height: Float = .zero
    public var widthExtant: Float {
        x + width
    }
    public var heightExtant: Float {
        y + height
    }
}
