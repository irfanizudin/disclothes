//
//  ContentView.swift
//  disclothes
//
//  Created by Irfan Izudin on 04/12/22.
//

import SwiftUI

struct ContentView: View {
    
    let normalPrice: Int = 320_000_000
    let finalPrice: Int = 31_000
    @State private var discount1 = ""
    @State private var discount2 = ""
    @State private var image: UIImage?
    @State private var showCameraPicker: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(Palette.Background.rawValue)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        
                        HStack {
                            Text("Normal Price")
                                .font(.title2)
                                .foregroundColor(Color(Palette.TextPrimary.rawValue))
                                .bold()
                            Spacer()
                        }
                        .padding(.top, 15)
                        
                        VStack {
                            if image == nil {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                                    .foregroundColor(Color(Palette.TextSecondary.rawValue))
                            } else {
                                Image(uiImage: image!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                                    .foregroundColor(Color(Palette.TextSecondary.rawValue))
                            }
                            
                            Text("Rp \(normalPrice)")
                                .font(.title3)
                                .bold()
                                .foregroundColor(Color(Palette.TextPrimary.rawValue))
                                .padding(.top, 15)
                            
                        }
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .background(Color(Palette.Card.rawValue))
                        .cornerRadius(20)
                        .padding(.top, -5)
                        
                        HStack {
                            Text("Final Price")
                                .font(.title2)
                                .foregroundColor(Color(Palette.TextPrimary.rawValue))
                                .bold()
                            Spacer()
                        }
                        .padding(.top, 15)

                        VStack {
                            Text("Rp \(finalPrice)")
                                .font(.title3)
                                .bold()
                                .foregroundColor(Color(Palette.TextPrimary.rawValue))
                            Text("\(discount1)% + \(discount2)% off from normal price")
                                .font(.callout)
                                .foregroundColor(Color(Palette.TextSecondary.rawValue))
                                .padding(.top, -8)
                        }
                        .foregroundColor(Color(Palette.TextPrimary.rawValue))
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .background(Color(Palette.Card.rawValue))
                        .cornerRadius(20)
                        .padding(.top, -5)

                        
                        HStack {
                            Text("Calculation")
                                .font(.title2)
                                .foregroundColor(Color(Palette.TextPrimary.rawValue))
                                .bold()
                            Spacer()
                        }
                        .padding(.top, 15)
                        
                        VStack {
                            HStack(spacing: 20) {
                                VStack {
                                    Text("Discount 1 (%)")
                                        .font(.body)
                                        .foregroundColor(Color(Palette.TextSecondary.rawValue))
                                    TextField("Enter discount 1...", text: $discount1)
                                        .keyboardType(.decimalPad)
                                        .padding()
                                        .background(Color(Palette.TextField.rawValue))
                                        .cornerRadius(20)
                                }
                                
                                VStack {
                                    Text("Discount 2 (%)")
                                        .font(.body)
                                        .foregroundColor(Color(Palette.TextSecondary.rawValue))
                                    TextField("Enter discount 2...", text: $discount2)
                                        .keyboardType(.decimalPad)
                                        .padding()
                                        .background(Color(Palette.TextField.rawValue))
                                        .cornerRadius(20)
                                }
                            }
                            
                            Button {
                                print("scan price")
                                showCameraPicker.toggle()
                            } label: {
                                Text("Scan Price")
                                    .font(.headline)
                                    .foregroundColor(Color(Palette.TextButton.rawValue))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(Palette.Button.rawValue))
                                    .cornerRadius(20)
                            }
                            .padding(.top, 10)

                        }
                        .foregroundColor(Color(Palette.TextPrimary.rawValue))
                        .padding(.vertical, 30)
                        .padding(.horizontal, 25)
                        .frame(maxWidth: .infinity)
                        .background(Color(Palette.Card.rawValue))
                        .cornerRadius(20)
                        .padding(.top, -5)

                        
                        Spacer()
                    }
                    .padding(.horizontal, 25)
                }
                .scrollDismissesKeyboard(.interactively)
            }
            .onTapGesture {
                hideKeyboard()
            }
            .fullScreenCover(isPresented: $showCameraPicker, content: {
                CameraPicker(image: $image, showCameraPicker: $showCameraPicker)
                    .ignoresSafeArea()
            })
            .navigationTitle("Disclothes")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
