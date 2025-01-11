import Foundation

public class TileSheet{

	private var textureByTileID: [Int:Int] = [:]
	private var textureByRC: [RC: Int] = [:]
	//private let sheetByIndex: [Int:Int] = [:]
	public init(sheetName: String, rows: Int, columns: Int, renderer: MetalRenderer){
		let textureSheet = Textures.shared.loadSpriteSheet(named: sheetName, rows: rows, columns: columns, renderer: renderer)
		textureSheet.forEach(){ key, value in
			let tileID: Int = key.row  * columns + key.column
			textureByTileID.updateValue(value, forKey: tileID)
			textureByRC.updateValue(value, forKey: key)
		}
	}
	public func textureID(row: Int, col: Int)->Int{
		let rc: RC = RC(row: row, column: col)
		return textureID(rc: rc)
	}
	public func textureID(rc: RC)->Int{
		textureByRC[rc] ?? 0
	}

	public func textureID(tileID: Int)-> Int{
		textureByTileID[tileID] ?? 0
	}
}
