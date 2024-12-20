import Foundation
public class Entity:Identifiable{
	private static var lastID: Int = 0
	private var components: [Int: any Component] = [:]
	internal let manager: Manager

	public init(manager: Manager){
		self.manager = manager
	}
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
	
	public func removeComponent<T: Component>(ofType: T.Type){
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
        entities.updateValue(result, forKey: T.typeID)
    }
}
