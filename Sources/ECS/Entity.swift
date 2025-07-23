
import Foundation
public protocol Entity:AnyObject, Identifiable{
    var components: [Int: any Component] { get set}
    var  isActive: Bool {get set}
    var id: Int { get }
    func update()
    func draw(renderer: any Renderer)
}
extension Entity{
    public func update(){
        components.forEach{ _, component in 
            component.update( )
        }
    }

    public func draw(renderer: any Renderer){
        drawAllComponents(renderer: renderer)
    }
    public func drawAllComponents(renderer: any Renderer){
        components.forEach{_, component in
            component.draw(renderer: renderer)    
        }
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


public class BasicEntity: Entity, Identifiable{
    public var components: [Int: any Component] = [:]
    public var isActive: Bool = true
    public var id: Int = .NextID()
    public init(){} 
}

public func addComponent<T: Component>(_ component:  T, toEntity entity: any Entity){
    component.entity = entity
    component.setup()
    entity.components.updateValue(component, forKey: T.typeID)
}
/*
public func add<T: Component>(component:  T, toEntity entity: any Entity){
    component.entity = entity
    component.setup()
    entity.components.updateValue(component, forKey: T.typeID)
}
*/  
public func removeComponent<T: Component>(ofType: T.Type, fromEntity entity: any Entity){
    if let component:T = getComponent(inEntity: entity){
        component.destroy()
        entity.components.removeValue(forKey: T.typeID)
    }
}
/*
public func removeComponentFrom<T: Component>(entity: any Entity, ofType: T.Type){
    if let component:T = getComponent(inEntity: entity){
        component.destroy()
        entity.components.removeValue(forKey: T.typeID)
    }
}
*/
    
public func doesEntity<T: Component>(_ entity: any Entity, haveComponentOfType: T.Type) -> Bool{
    if entity.components[T.typeID] != nil { return true}
    else {return false}
}
    
public func getComponent<T:Component>(inEntity entity: any Entity)->T?{
    entity.components[T.typeID] as? T
}

public func getComponent<T:Component>(ofType: T.Type, inEntity entity: any Entity)->T?{
    entity.components[T.typeID] as? T
}
public func forComponents<T:Component>(ofType: T.Type, inEntity entity: any Entity, do action: (T)->T){
    guard let c:T = getComponent(inEntity: entity) else {  return }
    let result = action(c)
    entity.components.updateValue(result, forKey: T.typeID)
}
