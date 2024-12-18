//
//  SearchResultsView.swift
//  Zachary_Ellis_Submission
//
//  Created by Bryce Ellis on 12/18/24.
//


import SwiftUI

struct SearchResultsView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @State private var searchText: String
    @Environment(\.presentationMode) var presentationMode

    init(viewModel: WeatherViewModel, cityName: String) {
        self.viewModel = viewModel
        self._searchText = State(initialValue: cityName)
    }

    var body: some View {
        VStack {
            // Search Bar
            HStack {
                TextField("Search location", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)

                Button(action: {
                    if !searchText.isEmpty {
                        viewModel.searchWeather(for: searchText)
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .padding()

            if viewModel.isSearching { // Access isSearching directly
                ProgressView("Searching for \(searchText)...")
            } else if let searchResult = viewModel.searchResult {
                // Search Result Card
                Button(action: {
                    viewModel.confirmSearchResult()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(searchResult.location.name)
                                .font(.title2)
                                .fontWeight(.bold)

                            Text("\(searchResult.current.tempC, specifier: "%.1f")°")
                                .font(.title)
                        }
                        Spacer()
                        AsyncImage(url: URL(string: "https:\(searchResult.current.condition.icon)")) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
                .padding()
            } else {
                Text("No results found for '\(searchText)'.")
                    .foregroundColor(.red)
                    .padding()
            }

            Spacer()
        }
        .navigationTitle("Search Results")
        .onAppear {
            viewModel.searchWeather(for: searchText) // Trigger initial search
        }
    }
}

