import simd

public class SpriteComponent: CustomMeshComponent{
    public var vertices: [Vertex] = []
    
    public var entity: Entity? = nil
        
    public static var typeID: Int = Manager.getNewComponentTypeID()

    public  var texture: Int? = nil
	public let textureSheetArray: [SIMD2<Int>:Int]
    public var material: Material = Material()
    
	public init(named name: String, renderer: MetalRenderer){
		if let textureID = Textures.shared.loadTexture(named:  name, renderer: renderer){
			texture = textureID
			textureSheetArray = [.zero:textureID]
			material.useTexture = true
		} else {
			textureSheetArray = [:]
		}
    }
	public init(spriteSheetNamed name: String, tiles: SIMD2<Int>, defaultSprite: SIMD2<Int> = .zero, renderer: MetalRenderer){
		textureSheetArray = Textures.shared.loadSpriteSheet(
			named: name, tiles: tiles, renderer: renderer)
		texture = textureSheetArray[defaultSprite]
		material.useTexture = true
	}

}

extension SpriteComponent{
	public func changeTexture(loc: SIMD2<Int>){
			texture = textureSheetArray[loc]
		}

    public func buildVertices(){
		add(vertex: Vertex(x: -0.5, y:  0.5, u: 0, v: 0, color: SIMD4(0, 0, 0, 1))) // TL
        add(vertex: Vertex(x:  0.5, y:  0.5, u: 1, v: 0, color: SIMD4(0, 0, 0, 1))) // TR
        add(vertex: Vertex(x: -0.5, y: -0.5, u: 0, v: 1, color: SIMD4(0, 0, 0, 1))) // BL
        add(vertex: Vertex(x: -0.5, y: -0.5, u: 0, v: 1, color: SIMD4(0, 0, 0, 1))) // BL
        add(vertex: Vertex(x:  0.5, y:  0.5, u: 1, v: 0, color: SIMD4(0, 0, 0, 1))) // TR
        add(vertex: Vertex(x:  0.5, y: -0.5, u: 1, v: 1, color: SIMD4(0, 0, 0, 1))) // BR
    }
    public func draw(renderer: any Renderer) {
        renderer.pushDebug("TypeID \(Self.typeID)")
        let transform: TransformComponent? = entity?.getComponent()
        renderer.setModel(matrix: transform?.modelMatrix  ?? .identity)
        renderer.setVertex(vertices)
        renderer.setMaterial(constants: material)
        
		if texture != nil{
			renderer.setTexture(id: texture!)

        }
        renderer.drawPrimitives(count: vertices.count)
        renderer.popDebug()
    }
    
}


