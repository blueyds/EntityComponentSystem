import Foundation

public class ManagerComponent: Component{
    public var entity: (any Entity)!
    public static var typeID: Int = Manager.getNewComponentTypeID()
    public var manager: Manager
    
    public init(_ manager: Manager){
        self.manager = manager
    }
}