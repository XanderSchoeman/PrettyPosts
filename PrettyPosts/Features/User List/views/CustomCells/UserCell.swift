//
//  UserCellTableViewCell.swift
//  PrettyPosts
//
//  Created by Xander Schoeman on 2024/03/03.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.cornerRadius = 8
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 3.0
        containerView.layer.shadowOpacity = 0.5
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        usernameLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        emailLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        addressLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        nameLabel.textColor = .black
        usernameLabel.textColor = .darkGray
        emailLabel.textColor = .gray
        addressLabel.textColor = .lightGray
    }
    
    func configure(with user: User) {
        nameLabel.text = user.name
        usernameLabel.text = user.username
        emailLabel.text = user.email
        addressLabel.text = "\(user.address.street), \(user.address.suite), \(user.address.city), \(user.address.zipcode)"
    }
}
