extension Int{
    static private var lastIDUsed: Int = 0
    static public func NextID() -> Int {
        lastIDUsed += 1
        return lastIDUsed
    }
}
