public enum Collision{
    static public func AABB(test colA: CollisionComponent, against colB: CollisionComponent)-> Bool{
        let a = colA.col
        let b = colB.col
        if a.widthExtant >= b.x && b.widthExtant >= a.x && a.heightExtant >= b.y && b.heightExtant >= a.y{
            return true
        } else {
            return false
        }
    }
    static public func hitTest(point: SIMD2<Float>, against colA: CollisionComponent)->Bool{
        let a = colA.col
        if point.x >= a.x && a.widthExtant >= point.x && point.y >= a.y && a.heightExtant >= point.y {
            return true
        } else { return false } 
    }
}
