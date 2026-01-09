//
//  CurrentWeatherCardView.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 06/01/26.
//

import SwiftUI

struct CurrentWeatherCardView: View {
    let item: WeatherCardItem
    let backgroundImage: UIImage?
    let isWidget: Bool
    
    var body: some View {
        content
            .applyWidgetBackground(background, isWidget: isWidget)
    }
    
    private var content: some View {
        VStack(alignment: item.size.alignment, spacing: item.size.paddingBetween) {
            Image(item.type.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)

            Text(item.location)
                .font(item.size.font)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black)
        }
        .padding()
        .frame(width: item.size.size.width, height: item.size.size.height)
    }
    
    private var background: some View {
        Group {
            if let image = backgroundImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.white
            }
        }
    }
}
