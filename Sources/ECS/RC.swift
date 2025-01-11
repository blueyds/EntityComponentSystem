
public struct RC: Equatable{
	public var row: Int
	public var column: Int
	public init(row: Int, column: Int) {
		self.row = row
		self.column = column
	}
}
extension RC: Hashable{}

extension RC{
	public static var zero: RC { RC(row: 0, column: 0)}
	public static var one: RC { RC(row: 1, column: 1)}
}

