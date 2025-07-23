import MetalKit

class GameMetalRenderer:MetalRenderer{
    //static var shared: GameRenderer 
    let device: (any MTLDevice)?
    var rCE: (any MTLRenderCommandEncoder)? = nil
    let pixelFormat: MTLPixelFormat
    let depthPixelFormat: MTLPixelFormat?
    var defaultDepthStencilState: (any MTLDepthStencilState)? = nil
    var defaultRenderPipeline: (any MTLRenderPipelineState)? = nil
    var defaultSamplerState: (any MTLSamplerState)? = nil
    var shaderSrc: String?
    init(pixelFormat: MTLPixelFormat = .bgra8Unorm, depthPixelFormat: MTLPixelFormat = .depth32Float,depthCompareFn: MTLCompareFunction = .less, vertexFn: String = "basic_vertex_shader" , fragmentFn: String = "basic_fragment_shader", shaderSrc: String? = nil){
        device = MTLCreateSystemDefaultDevice()
        self.pixelFormat = pixelFormat
        self.depthPixelFormat = depthPixelFormat
        defaultDepthStencilState = createDepthStencilState(compareFn: depthCompareFn)
        defaultRenderPipeline = createRenderPipeline(vertexFn: vertexFn, fragmentFn: fragmentFn, useAlphaBlending: true)
        defaultSamplerState = createSamplerState(minFilter: .linear, magFilter: .linear, mipFilter: .linear)
        self.shaderSrc = shaderSrc
    }
    
    func makeLibrary() -> (any MTLLibrary)? {
        if shaderSrc != nil {
            return try? device?.makeLibrary(source: shaderSrc!, options: nil)
        } else {
            return device?.makeDefaultLibrary()
        }
    }
    
    
}