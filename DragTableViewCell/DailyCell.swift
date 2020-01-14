//
//  DailyCell.swift
//  DragTableViewCell
//
//  Created by xuyazhong on 2020/1/14.
//  Copyright © 2020 xyz. All rights reserved.
//

import UIKit

protocol SortDragCellDelegate {

    func dragCellWithTap(tap: UILongPressGestureRecognizer ) -> Void
    
}

class DailyCell: UITableViewCell {
    
    var delegate: SortDragCellDelegate?
    
    var isMoving = false
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

        bgView.round(radius: 4, bgColor: .white, borderColor: .gray)
        titleLbl.textColor = .black
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        imageV.isUserInteractionEnabled = true
        imageV.image = UIImage(named: "drag")
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(dragTapClicked))
        imageV.addGestureRecognizer(longPress)
        self.addGestureRecognizer(longPress)
    }

    @objc func dragTapClicked(_ ges: UILongPressGestureRecognizer) {
        if let del = delegate {
            del.dragCellWithTap(tap: ges)
        }
    }
    
    func refresh(_ v1: String?) {
        titleLbl.text = v1 ?? ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
