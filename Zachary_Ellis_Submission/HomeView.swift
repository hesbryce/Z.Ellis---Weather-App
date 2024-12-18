//
//  HomeView.swift
//  Zachary_Ellis_Submission
//
//  Created by Bryce Ellis on 12/18/24.
//


import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var searchText: String = ""  // Search bar input
    @State private var navigateToSearch = false // Trigger navigation to SearchResultsView
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomSearchBar(searchText: $searchText) {
                                    if !searchText.isEmpty {
                                        navigateToSearch = true
                                    }
                                }
                                

                Spacer()
                
                if let weather = viewModel.weather {
                    // Weather Display
                    VStack(spacing: 16) {
                        Text(weather.location.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        
                        Text("\(weather.current.tempC, specifier: "%.1f")°")
                            .font(.system(size: 64, weight: .bold))
                        
                        HStack(spacing: 20) {
                            WeatherDetailsRow(details: [
                                (title: "Humidity", value: "\(weather.current.humidity)%"),
                                (title: "UV", value: "\(weather.current.uv)"),
                                (title: "Feels Like", value: String(format: "%.0f°", weather.current.feelslikeC))
                            ])
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                } else {
                    // Empty State
                    VStack {
                        Text("No City Selected")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        
                        Text("Please Search For A City")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                }

                Spacer()

                // Navigation to SearchResultsView
                NavigationLink(
                    destination: SearchResultsView(viewModel: viewModel, cityName: searchText),
                    isActive: $navigateToSearch
                ) {
                    EmptyView()
                }
            }
            .navigationTitle("Weather App")
            .onAppear {
                viewModel.loadSavedCity() // Reload persisted city
            }
        }
    }
}
