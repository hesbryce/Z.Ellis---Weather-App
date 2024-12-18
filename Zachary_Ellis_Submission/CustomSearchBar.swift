//
//  CustomSearchBar.swift
//  Zachary_Ellis_Submission
//
//  Created by Bryce Ellis on 12/18/24.
//


import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchText: String
    var onSearch: () -> Void
    
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.systemGray6))
                .frame(height: 50)

            // TextField with Placeholder
            HStack {
                TextField("Search Location", text: $searchText)
                    .foregroundColor(.gray)
                    .padding(.leading, 12)
                
                Spacer()
                
                // Magnifying Glass Icon
                Button(action: {
                    onSearch()
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.trailing, 12)
                }
            }
            .font(.system(size: 16))
        }
        .padding(.horizontal)
    }
}
