//
//  UIViewController.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 01/01/26.
//

import UIKit

extension UIViewController {
    static func instantiate(from storyboard: String) -> Self {
        func instantiateVC<T: UIViewController>() -> T {
            let storyboard = UIStoryboard(name: storyboard, bundle: nil)
            return storyboard.instantiateViewController(
                withIdentifier: String(describing: T.self)
            ) as! T
        }
        return instantiateVC()
    }
}
