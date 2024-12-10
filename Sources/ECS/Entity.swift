import Foundation
public class Entity:Identifiable{
	private static var lastID: Int = 0
	private var components: [Int: any Component] = [:]
	public var id:Int  = {
		Entity.lastID += 1
		return Entity.lastID
	}()
	
	public func update(){ 
		components.forEach{ _, component in 
			component.update()
		}
	}
	
	public func draw(renderer: any Renderer){
		components.forEach{_, component in
			component.draw(renderer: renderer)    
		}
	}
	
	public func add<T: Component>(component:  T)-> T{
		component.entity = self
		component.setup()
		components.updateValue(component, forKey: T.typeID)
		return component
	}
	
	public func remove<T: Component>(componentOfType: T.Type){
		components.removeValue(forKey: T.typeID)
	}
	
	public func has<T: Component>(componentOfType: T.Type) -> Bool{
		if components[T.typeID] != nil { return true}
		else {return false}
	}
	
	public func get<T:Component>()->T?{
		components[T.typeID] as? T
	}
}
