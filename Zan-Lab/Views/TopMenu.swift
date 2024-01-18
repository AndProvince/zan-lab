//
//  TopMenu.swift
//  Zan-Lab
//
//  Created by Андрей on 24.09.2023.
//

import SwiftUI

struct TopMenu: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    @Binding var path: [NavView]
    
    var body: some View {
        if  mainVM.userLogined {
            HStack {
                Menu {
                    Button(action: {
                        mainVM.showEditProfile = false
                        mainVM.showProfile = true
                        
                    },
                           label: {
                        Image(systemName: "person")
                        Text("Личный кабинет")
                            .font(Font.custom("Open Sans", size: 16))
                            .kerning(0.16)
                    })
                    
                    Button(action: { },
                           label: {
                        Image(systemName: "text.bubble")
                        Text("Мои обращения")
                            .font(Font.custom("Open Sans", size: 16))
                            .kerning(0.16)
                    })
                    
                    Button(action: {
                        mainVM.showEditProfile = true
                        mainVM.showProfile = true
                    },
                           label: {
                        Image(systemName: "pencil")
                        Text("Редактировать профиль")
                            .font(Font.custom("Open Sans", size: 16))
                            .kerning(0.16)
                    })
                    
                    Button(action: { },
                           label: {
                        Image(systemName: "person.badge.shield.checkmark")
                        Text("Регистрация специалиста")
                            .font(Font.custom("Open Sans", size: 16))
                            .kerning(0.16)
                    })
                    
                    Divider()
                    
                    Button(action: { mainVM.logout() },
                           label: {
                        Text("Выход")
                            .font(Font.custom("Open Sans", size: 16))
                            .kerning(0.16)
                    })
                    
                } label: {
                    HStack(alignment: .center, spacing: 8){
                        ImageView(url: mainVM.user?.getImageURL(), backupImage: "person")
                            .frame(width: 34, height: 34)
                            .cornerRadius(8.0)
                        Text(mainVM.user!.getName())
                            .font(
                            Font.custom("Montserrat", size: 14)
                            .weight(.semibold)
                            )
                            .foregroundColor(Color(red: 0.21, green: 0.21, blue: 0.21))
                        Spacer()
                    }
                    .padding()
                    .foregroundColor(Color.black)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    
                }
                .padding(.horizontal)
            }
            .background(Color("Gray_bg"))
        } else {
            HStack(alignment: .top){
                NavigationLink(value: NavView.login) {
                    Text("Вход")
                        .padding(5)
                }
                
                Spacer()
                
                NavigationLink(value: NavView.register) {
                    Text("Регистрация")
                        .foregroundColor(.gray)
                        .padding(5)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1))
                }
            }
            .padding()
            //.foregroundColor(Color.black)
            .background(.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .font(.body)
            .padding(.horizontal)
        }
    }
}

//struct TopMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        TopMenu()
//    }
//}
