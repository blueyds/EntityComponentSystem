//import GameColor
import Sizeable
i,port simd

public struct Material{
	private var _color: SIMD4<Float> = SIMD4(0,0,0,1)
	private var _useMaterialColor: Bool = false
	private var _useTexture: Bool = false
	public init() {}
	public var color: SIMD4<Float>? {
		get { _color }
		set{
			
			if newValue != nil{
				_color = newValue!
				_useMaterialColor = true
				_useTexture = false
			} else { 
				_useMaterialColor = false
			}
		}
	}
	
	public var useMaterialColor: Bool{
		get { _useMaterialColor}
	}
	
	public var useTexture: Bool {
		get { _useTexture }
		set{
			_useMaterialColor = false
			_useTexture = true
		}
	}
}

extension Material: sizeable {}