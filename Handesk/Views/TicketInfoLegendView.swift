import UIKit

class TicketInfoLegendView : UIStackView {

    func setup(_ ticket:Ticket){

        arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        addArrangedSubview(createPriorityLabel(ticket.priority))
        
        if ticket.isBug {
            addArrangedSubview(createImageView("bug"))
        }
        
        if ticket.isEscalated {
            addArrangedSubview(createImageView("flag"))
        }
    }
    
    private func createPriorityLabel(_ priority:Ticket.Priority) -> UILabel{
        let label             = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        label.text            = priority.initial
        label.backgroundColor = priority.color
        return label
    }
    
    private func createImageView(_ name:String) -> UIImageView {
        let imageView       = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.image     = UIImage(named: name)
        imageView.tintColor = UIColor.white
        return imageView
    }
}
