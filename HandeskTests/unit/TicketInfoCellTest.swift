import XCTest
@testable import Handesk


class TicketInfoCellTest: XCTestCase {

    func test_cell_can_display_ticket_info() {
        let team      = Team(name: "Support team")
        let agent     = Agent(name: "Bruce wayne", email: "bruce@wayne.com")
        let ticket    = Ticket(title: "The Ticket",  status:.new, priority:.high, team:team, agent:agent)
        let cell      = makeTicketInfoCell()

        cell.setup(ticket)

        XCTAssertEqual("Support team",  cell.teamLabel.text)
        XCTAssertEqual("Bruce wayne",   cell.assigneLabel.text)
        XCTAssertEqual("new",           cell.statusLabel.text)
        XCTAssertEqual("high",          cell.priorityLabel.text)
    }

}
