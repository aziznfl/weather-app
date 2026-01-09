//
//  ErrorView.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 04/01/26.
//

import UIKit

final class ErrorView: UIView {
    
    @IBOutlet private weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isHidden = true
    }

    func setup(label: String) {
        self.label.text = label
    }
}
