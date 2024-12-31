import Foundation
public class Entity:Identifiable{
	private static var lastID: Int = 0
	private var components: [Int: any Component] = [:]
	public var  isActive: Bool = true
	public let id: Int

	public init(){
		Entity.lastID += 1
		id = Entity.lastID
	}

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
	
	public func removeComponent<T: Component>(ofType: T.Type){
		getComponent(ofType: T.self)?.destroy()
		components.removeValue(forKey: T.typeID)
	}
	
	public func hasComponent<T: Component>(ofType: T.Type) -> Bool{
		if components[T.typeID] != nil { return true}
		else {return false}
	}
	
	public func getComponent<T:Component>()->T?{
		components[T.typeID] as? T
	}
	public func getComponent<T:Component>(ofType: T.Type)->T?{
		components[T.typeID] as? T
	}
	public func forComponent<T:Component>(ofType: T.Type, _ action: (T)->T){
        guard let c:T = getComponent() else {  return }
        let result = action(c)
        components.updateValue(result, forKey: T.typeID)
    }

	public func deactivate(){
		isActive = false
	}
	public func destroy(){
		components.forEach(){component in
			component.value.destroy()
		}
	}
}
