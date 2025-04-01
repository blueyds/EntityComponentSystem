import simd

public class SpriteComponent: CustomMeshComponent{
    public var vertices: [Vertex] = []
    
    public var entity: (any Entity)? = nil
        
    public static var typeID: Int = Manager.getNewComponentTypeID()

    public  var texture: Int? = nil
	public let tileSheet: TileSheet?
    public var material: Material = Material()
    
	public init(named name: String, renderer: MetalRenderer){
		self.tileSheet = nil
		if let textureID = Textures.shared.loadTexture(named:  name, renderer: renderer){
			texture = textureID
			material.useTexture = true
		}
    }
	public init(spriteSheetNamed name: String, rows: Int, columns: Int, defaultSprite: RC = .zero, renderer: MetalRenderer){
		tileSheet = TileSheet(sheetName: name, rows: rows, columns: columns, renderer: renderer)
		texture = tileSheet?.textureID(rc: defaultSprite)
		material.useTexture = true
	}
	public init(spriteSheet: TileSheet, rcRef: RC){
		tileSheet = spriteSheet
		texture = tileSheet?.textureID(rc: rcRef)
		material.useTexture = true
	}

}

extension SpriteComponent{
	public func changeTexture(rcRef: RC){
		texture = tileSheet?.textureID(rc: rcRef)
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
        guard let transform: TransformComponent = getComponentIn(entity: entity) else { return }

        renderer.pushDebug("TypeID \(Self.typeID)")
        renderer.setModel(matrix: transform?.modelMatrix)
        renderer.setVertex(vertices)
        renderer.setMaterial(constants: material)
        
		if texture != nil{
			renderer.setTexture(id: texture!)

        }
        renderer.drawPrimitives(count: vertices.count)
        renderer.popDebug()
    }
    
}


