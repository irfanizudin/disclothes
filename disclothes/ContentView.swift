//
//  ContentView.swift
//  disclothes
//
//  Created by Irfan Izudin on 04/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ContentViewModel()
    @State private var image: UIImage?
    @State private var showCameraPicker: Bool = false
    @State private var showAlert: Bool = false
    @FocusState private var fieldFocus: Bool
    
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
                            
                            Text(Variable.normalPrice == 0 ? "Price not detected" : "Rp \(Int(Variable.normalPrice))")
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
                            VStack {
                                if Variable.finalPrice < 0 {
                                    Text("Your Item is Free")
                                } else {
                                    Text("Rp \(Int(Variable.finalPrice))")
                                }
                            }
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color(Palette.TextPrimary.rawValue))
                            
                            if Variable.finalPrice != 0 {
                                Text("\(Int(Variable.discount1))% + \(Int(Variable.discount2))% off from normal price")
                                    .font(.callout)
                                    .foregroundColor(Color(Palette.TextSecondary.rawValue))
                                    .padding(.top, -8)
                            }

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
                                    TextField("Enter discount 1...", text: $vm.discount1)
                                        .keyboardType(.numberPad)
                                        .padding()
                                        .background(Color(Palette.TextField.rawValue))
                                        .cornerRadius(20)
                                        .focused($fieldFocus)
                                }
                                
                                VStack {
                                    Text("Discount 2 (%)")
                                        .font(.body)
                                        .foregroundColor(Color(Palette.TextSecondary.rawValue))
                                        .opacity(vm.discount1.isEmpty || Int(vm.discount1) == 0 ? 0.3 : 1)

                                    TextField("Enter discount 2...", text: $vm.discount2)
                                        .keyboardType(.numberPad)
                                        .padding()
                                        .background(Color(Palette.TextField.rawValue))
                                        .cornerRadius(20)
                                        .disabled(vm.discount1.isEmpty || Int(vm.discount1) == 0 ? true : false)
                                        .opacity(vm.discount1.isEmpty || Int(vm.discount1) == 0 ? 0.3 : 1)
                                }
                            }
                            
                            Button {
                                print("scan price")
                                showCameraPicker.toggle()
                                Variable.discount1 = Double(vm.discount1) ?? 0
                                Variable.discount2 = Double(vm.discount2) ?? 0
                                
                                if vm.discount1.isEmpty || Int(vm.discount1) == 0 {
                                    showAlert.toggle()
                                }
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
            .alert("Please enter the first discount!", isPresented: $showAlert, actions: {
                Button("Ok", role: .cancel) {
                    fieldFocus = true
                }
            })
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
