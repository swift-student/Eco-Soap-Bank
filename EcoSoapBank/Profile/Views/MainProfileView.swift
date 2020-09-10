//
//  MainProfileView.swift
//  EcoSoapBank
//
//  Created by Jon Bash on 2020-08-31.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import SwiftUI


struct MainProfileView: View {
    @ObservedObject var viewModel: MainProfileViewModel

    @State var iconWidth: CGFloat = 15

    init(viewModel: MainProfileViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            Form {
                if !viewModel.propertyOptions.isEmpty {
                    Section(header: Text("User".uppercased())) {
                        NavigationLink(
                            destination: EditProfileView(viewModel: viewModel)
                        ) {
                            HStack {
                                Image.personSquareFill()
                                    .foregroundColor(Color(red: 0.8, green: 0.5, blue: 0.1))
                                    .readingGeometry(key: IconWidth.self, valuePath: \.size.width) {
                                        self.iconWidth = $0
                                }
                                Text("Edit Profile")
                            }
                        }

                        Picker(
                            selection: $viewModel.selectedProperty,
                            label: HStack {
                                Color.green.clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 2,
                                        style: .circular))
                                    .inverseMask(ZStack(alignment: .center) {
                                        Image.property()
                                            .resizable()
                                            .aspectRatio(CGSize(width: 1, height: 1),
                                                         contentMode: .fit)
                                            .padding(EdgeInsets(top: 3.5, leading: 2, bottom: 1, trailing: 2))
                                    }).frame(width: iconWidth, height: iconWidth)
                                Text("Current Property")
                            }
                        ) {
                            ForEach(viewModel.propertyOptions, id: \.display) {
                                Text($0.display).tag($0)
                            }
                        }
                    }

                    Section(header: Text("Edit Property Info".uppercased())) {
                        ForEach(viewModel.properties) { property in
                            NavigationLink(
                                destination: EditPropertyView(
                                    viewModel: EditPropertyViewModel(property))
                            ) {
                                Text(property.name)
                            }
                        }
                    }
                } else {
                    Text("User account has no associated properties. Please contact Eco-Soap Bank for more info.")
                }

                Section {
                    Button(action: viewModel.logOut) {
                        HStack {
                            Spacer()
                            Text("Log out")
                                .foregroundColor(Color(UIColor(red: 0.8, green: 0, blue: 0, alpha: 1)))
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                }
            }.navigationBarTitle("Profile Settings", displayMode: .inline)
        }
        .font(.muli())
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct IconWidth: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct MainProfileView_Previews: PreviewProvider {
    static let user: User = .placeholder()

    static var previews: some View {
        MainProfileView(
            viewModel: MainProfileViewModel(
                user: .placeholder(),
                userController: UserController(dataLoader: MockUserDataProvider()),
                delegate: nil)
        )
    }
}
