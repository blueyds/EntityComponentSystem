import GameColor
import Sizeable

public struct Material{
	private var _color: GameColor? = nil
	private var _useMaterialColor: Bool = false
	private var _useTexture: Bool = false
	public var color: GameColor? {
		get { _color }
		set{
			_color = newValue
			if newValue != nil{
				_useMaterialColor = true
				_useTexture = false
			} else { 
				_useMaterialColor = false
			}
		}
	}
	
	public var useMaterialColor: Bool{
		get { _useMaterialColor }
	}
	public var textureID: Int? {
		get{	_textureID }
		set{
			_textureID = newValue
			if newValue != nil{
				_useMaterialColor = false
				_useTexture = true
			} else {
				_useTexture = false
			}
		}
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