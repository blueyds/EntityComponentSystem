import MetalKit

public class GameMetalRenderer:MetalRenderer{
    //static var shared: GameRenderer 
    public let device: (any MTLDevice)?
    public var rCE: (any MTLRenderCommandEncoder)? = nil
    public let pixelFormat: MTLPixelFormat
    public let depthPixelFormat: MTLPixelFormat?
    public var defaultDepthStencilState: (any MTLDepthStencilState)? = nil
    public var defaultRenderPipeline: (any MTLRenderPipelineState)? = nil
    public var defaultSamplerState: (any MTLSamplerState)? = nil
    public var shaderSrc: String?
    public init(pixelFormat: MTLPixelFormat = .bgra8Unorm, depthPixelFormat: MTLPixelFormat = .depth32Float,depthCompareFn: MTLCompareFunction = .less, vertexFn: String = "basic_vertex_shader" , fragmentFn: String = "basic_fragment_shader", shaderSrc: String? = nil){
        device = MTLCreateSystemDefaultDevice()
        self.pixelFormat = pixelFormat
        self.depthPixelFormat = depthPixelFormat
        defaultDepthStencilState = createDepthStencilState(compareFn: depthCompareFn)
        defaultRenderPipeline = createRenderPipeline(vertexFn: vertexFn, fragmentFn: fragmentFn, useAlphaBlending: true)
        defaultSamplerState = createSamplerState(minFilter: .linear, magFilter: .linear, mipFilter: .linear)
        self.shaderSrc = shaderSrc
    }
    
    public func makeLibrary() -> (any MTLLibrary)? {
        if shaderSrc != nil {
            return try? device?.makeLibrary(source: shaderSrc!, options: nil)
        } else {
            return device?.makeDefaultLibrary()
        }
    }
    
    
}