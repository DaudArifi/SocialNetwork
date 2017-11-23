//
//  CircleView.swift
//  SocialNetwork
//
//  Created by Daud Arifi on 17.11.17.
//  Copyright © 2017 Daud Arifi. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
}
