//
//  ContatosCell.swift
//  Promobit-Contatos
//
//  Created by Monitora on 19/04/21.
//

import UIKit

class ContatosCell: UITableViewCell {

    @IBOutlet weak var lbCompany: UILabel?
    @IBOutlet weak var lbName: UILabel?
    @IBOutlet weak var imgAvatar: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgAvatar?.layer.borderWidth = 0.5
        imgAvatar?.layer.masksToBounds = false
        imgAvatar?.layer.borderColor = UIColor.black.cgColor
        imgAvatar?.layer.cornerRadius = (imgAvatar?.frame.height)!/2
        imgAvatar?.clipsToBounds = true
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
