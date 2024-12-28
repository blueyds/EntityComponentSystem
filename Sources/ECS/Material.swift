import GameColor
import Sizeable

extension Int8{
	static var isTrue: Int8 { 1 }
	static var isFalse: Int8 { 0 }
}

public struct Material{
	private var _color: GameColor = .black
	private var _options: SIMD2<Int8> = SIMD2(0,0)
	public init() {}
	public var color: GameColor? {
		get { _color }
		set{
			
			if newValue != nil{
				_color = newValue!
				_options.x = .isTrue
				_options.y = .isFalse
			} else { 
				_options.x = .isFalse
			}
		}
	}
	
	public var useMaterialColor: Bool{
		get { _useMaterialColor == .isTrue}
	}
	private var _useMaterialColor: Int8{
		_options.x
	}
	private var _useTexture: Int8 {
		_options.y
	}
	
	public var useTexture: Bool {
		get { _useTexture == .isTrue}
		set{
			_options.x = .isFalse
			_options.y = .isTrue
		}
	}
}

extension Material: sizeable {}