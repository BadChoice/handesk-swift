import Foundation

protocol Resolvable{
    init()
}

func app<T:Resolvable>(_ type:T.Type) -> T? {
    Container.shared.resolve(type)
}

class Container {
    
    static var shared = Container()
    
    var resolvers:[String:Any] = [:]
    
    func register<T:Resolvable, Z:Resolvable>(_ type:T.Type, _ resolver:Z.Type) {
        resolvers[String(describing: type)] = resolver
    }
    
    @discardableResult
    func register<T:Resolvable>(_ type:T.Type, _ resolver:T) -> T {
        resolvers[String(describing: type)] = resolver
        return resolver
    }
        
    func resolve<T:Resolvable>(_ type:T.Type) -> T? {
        if let resolver = resolvers[String(describing: type)] {
            if let resolvable = resolver as? Resolvable.Type {
                return resolvable.init() as? T
            }
            return resolver as? T
        }
        return type.init()
    }
}

@propertyWrapper
struct Inject<Value:Resolvable>{
    var wrappedValue: Value?
    
    init() {
        wrappedValue = app(Value.self)
    }
}

