import Foundation

func on_ui(_ closure:@escaping()->Void){
    DispatchQueue.main.async { closure() }
}
