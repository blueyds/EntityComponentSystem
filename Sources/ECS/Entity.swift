
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
        updateAllComponents()
    }
    public func updateAllComponents(){
        components.forEach{ _, component in 
            component.update()
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

public func add<T: Component>(component:  T, toEntity entity: any Entity){
    component.entity = entity
    component.setup()
    entity.components.updateValue(component, forKey: T.typeID)
}
    
public func removeComponentFrom<T: Component>(entity: any Entity, ofType: T.Type){
    if let component:T = getComponentIn(entity: entity){
        component.destroy()
        entity.components.removeValue(forKey: T.typeID)
    }
}
    
public func does<T: Component>(entity: any Entity, haveComponentOfType: T.Type) -> Bool{
    if entity.components[T.typeID] != nil { return true}
    else {return false}
}
    
public func getComponentIn<T:Component>(entity: any Entity)->T?{
    entity.components[T.typeID] as? T
}
public func getComponentIn<T:Component>(entity: any Entity, ofType: T.Type)->T?{
    entity.components[T.typeID] as? T
}

public func forComponentsIn<T:Component>(entity: any Entity, ofType: T.Type, do action: (T)->T){
    guard let c:T = getComponentIn(entity: entity) else {  return }
    let result = action(c)
    entity.components.updateValue(result, forKey: T.typeID)
    }
