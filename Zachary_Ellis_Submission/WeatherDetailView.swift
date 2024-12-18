//
//  WeatherDetailView.swift
//  Zachary_Ellis_Submission
//
//  Created by Bryce Ellis on 12/18/24.
//


import SwiftUI

struct WeatherDetailView: View {
    let title: String
    let value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)

            Text(value)
                .font(.title2)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}
