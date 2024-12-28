import GameColor
import Sizeable

extension Int8{
	static var true: Int8 { 1 }
	static var false: Int8 { 0 }
}

public struct Material{
	private var _color: GameColor = .black
	private var _options: SIMD2<Int8> = SIMD2(0,0)
	public init() {}
	public var color: GameColor? {
		get { _color }
		set{
			
			if newValue != nil{
				_color = newValue
				_useMaterialColor = .true
				_useTexture = .false
			} else { 
				_useMaterialColor = .false
			}
		}
	}
	
	public var useMaterialColor: Bool{
		get { _useMaterialColor == .true}
	}
	private var _useMaterialColor: Int8{
		_options.x
	}
	private var _useTexture: Int8 {
		_options.y
	}
	
	public var useTexture: Bool {
		get { _useTexture == .true}
		set{
			_useMaterialColor = .false
			_useTexture = .true
		}
	}
}

extension Material: sizeable {}