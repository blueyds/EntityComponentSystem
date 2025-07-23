import AVFoundation

public class SoundComponent: Component{
    public var entity: (any Entity)!
    public static let typeID: Int = Manager.getNewComponentTypeID()
    private let file: String
    private var sound: AVAudioPlayer? = nil
    public init(named: String){
        file = named
    }
    public func setup() {
        let path = Bundle.main.path(forResource: file, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
       do {
           sound = try AVAudioPlayer(contentsOf: url)
           sound?.play()
        } catch {
            // couldn't load file :(
        }
    } 
    public func destroy() {
        sound?.stop()
    }
    
}

