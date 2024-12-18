//
//  WeatherDetailsRow.swift
//  Zachary_Ellis_Submission
//
//  Created by Bryce Ellis on 12/18/24.
//


import SwiftUI

struct WeatherDetailsRow: View {
    let details: [(title: String, value: String)]

    var body: some View {
        HStack(spacing: 30) {
            ForEach(details, id: \.title) { detail in
                VStack {
                    Text(detail.title)
                        .font(.headline)
                        .foregroundColor(Color.gray.opacity(0.7)) // Light gray
                        .padding(.bottom, 2)

                    Text(detail.value)
                        .font(.system(size: 22, weight: .semibold)) // Larger value font
                        .foregroundColor(Color.gray) // Slightly darker gray
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(20) // Rounded corners
    }
}
