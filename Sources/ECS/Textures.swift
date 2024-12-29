import MetalKit
import simd
import CoreImage
import CoreGraphics


internal struct TextureData:Identifiable{
	private static var lastID: Int = 0
	public var id:Int  = {
		TextureData.lastID += 1
		return TextureData.lastID
	}()
	var texture: MTLTexture
	var name: String
	var refCount: Int = 1
}

public struct Textures{
	static public var shared: Textures = Textures()

	public func getTexture(id: Int)->MTLTexture?{
		textures[id]?.texture
	}

	private var textures: [Int:TextureData] = [:]

	private init(){}

	public mutating func loadTexture<R:MetalRenderer>(named: String, renderer: R) -> Int? {
		guard let device = renderer.device else { return nil}
		if let t = textures.first(where: {$0.value.name == named}){
			textures[t.key]?.refCount += 1
			return t.key
		}
		let loader = MTKTextureLoader(device: device)
		guard let url: URL = Bundle.main.url(forResource: named, withExtension: nil) else {
			print("no file found")
			return nil
		}
		 if let texture = try? loader.newTexture(URL: url, options: nil){
			 let textureData = TextureData(texture: texture, name: named)
			 textures.updateValue(textureData, forKey: textureData.id)
			 return textureData.id
		 }
		return nil
	}
	
	public mutating func  loadSpriteSheet<R:MetalRenderer>(named: String, tiles: SIMD2<Int>, renderer: R)->[SIMD2<Int>:Int]{
		var result: [SIMD2<Int>:Int] = [:]
		let loader = MTKTextureLoader(device: renderer.device!)
		guard let url: URL =  getUrl(named) else { return result }
		guard let texture = loadTexture(at: url, loader: loader) else { return result }
		guard let cimage = CIImage(mtlTexture: texture) else { return result }
		let extant = cimage.extent
		let tileWidth: CGFloat = extant.width / CGFloat(tiles.x)
		let tileHeight: CGFloat = extant.height / CGFloat(tiles.y)
		let context = CIContext(mtlDevice: renderer.device!)

		for row: Int in 0..<tiles.y{
			for col: Int in 0..<tiles.x{
				let tileRect = CGRect(
					x: CGFloat(col) * tileWidth,
					y: CGFloat(row) * tileHeight,
					width: tileWidth,
					height: tileHeight)
				if let tile = cropTexture(image: cimage, cropRect: tileRect, context: context, loader: loader){
					let textureData = TextureData(texture: tile, name: named + "_\(row),\(col)")
					textures.updateValue(textureData, forKey: textureData.id)
					result.updateValue(textureData.id, forKey: SIMD2(col, row))
				}
			}
		}
		return result
	}

	private func getUrl(_ name: String) -> URL? {
		Bundle.main.url(forResource: name, withExtension: nil)
	}

	private func loadTexture(at url: URL, loader: MTKTextureLoader)->MTLTexture? {
		return try? loader.newTexture(URL: url, options: nil)
	}

	private func cropTexture(image: CIImage, cropRect: CGRect, context: CIContext, loader: MTKTextureLoader)->MTLTexture?{
		let ciTile = image.cropped(to: cropRect).oriented(.downMirrored)
		if let tile = context.createCGImage(ciTile, from: ciTile.extent){
			return try? loader.newTexture(cgImage: tile)
		} else { return nil}
	}
}

