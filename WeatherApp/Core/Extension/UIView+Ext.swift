//
//  UIView+Ext.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 02/01/26.
//

import UIKit

extension UIView {
    static func loadFromNib<T: UIView>() -> T {
        let bundle = Bundle(for: T.self)
        let nibName = String(describing: T.self)

        guard let view = bundle
            .loadNibNamed(nibName, owner: nil, options: nil)?
            .first as? T else {
            fatalError("Could not load nib \(nibName)")
        }

        return view
    }
}
