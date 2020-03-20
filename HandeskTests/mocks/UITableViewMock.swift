import UIKit

class UITableViewMock : UITableView {
    var didReloadDataCallCount = 0
    var dequeuedIdentifiers:[String] = []
    
    override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
        dequeuedIdentifiers.append(identifier)
        return super.dequeueReusableCell(withIdentifier: identifier)
    }
    
    override func reloadData() {
       didReloadDataCallCount += 1
       super.reloadData()
    }
}
