//
//  View+Ext.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 06/01/26.
//

import SwiftUI
import WidgetKit

extension View {
    @ViewBuilder
    func applyWidgetBackground<Background: View>(
        _ background: Background,
        isWidget: Bool
    ) -> some View {
        if #available(iOS 17.0, *), isWidget {
            self.containerBackground(for: .widget) {
                background
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            }
        } else {
            self.background(background)
                .clipShape(RoundedRectangle(cornerRadius: 22))
        }
    }
}
