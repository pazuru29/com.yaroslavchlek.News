//
//  CountryView.swift
//  News
//
//  Created by Yaroslav Chlek on 28.12.2023.
//

import SwiftUI

struct CountryView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) private var scheme
    @AppConfiguration(\.country) var country
    
    @EnvironmentObject var countryNewsViewModel: CountryNewsViewModel
    @EnvironmentObject var userNewsViewModel: UserNewsViewModel
    @EnvironmentObject var searchViewModel: SearchViewModel
    
    @State var selectedCountry: Country?
    
    var body: some View {
        VStack{
            Text("Select country")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
            ZStack {
                ScrollView {
                    ForEach(Country.allCases, id: \.self) { country in
                        CountryCard(scheme: scheme, country: country, isSelected: selectedCountry == country, onPressed: {
                            if selectedCountry == country {
                                selectedCountry = nil
                            } else {
                                selectedCountry = country
                            }
                        })
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    }
                    .padding(.bottom, 72)
                    .padding(.top, 16)
                }
                VStack {
                    Spacer()
                    Button("Save") {
                        if country != selectedCountry! {
                            userNewsViewModel.clearList()
                            countryNewsViewModel.clearList()
                            searchViewModel.clearList()
                            
                            country = selectedCountry!
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                    .buttonStyle(MainButtonStyle())
                    .padding(.horizontal, 16)
                    .disabled(selectedCountry == nil)
                }
            }
            .onAppear {
                selectedCountry = country
            }
        }
    }
}

#Preview {
    CountryView()
}
