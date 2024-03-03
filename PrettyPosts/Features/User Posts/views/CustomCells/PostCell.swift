//
//  PostCell.swift
//  PrettyPosts
//
//  Created by Xander Schoeman on 2024/03/03.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    func configure(with post: Post) {
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.cornerRadius = 8
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 3.0
        containerView.layer.shadowOpacity = 0.5
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        bodyLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        titleLabel.textColor = .black
        bodyLabel.textColor = .darkGray
    }
    
}
