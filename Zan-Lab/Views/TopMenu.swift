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
            HStack(alignment: .center, spacing: 8) {
                Menu {
                    Button(action: {
                        mainVM.showEditProfile = false
                        mainVM.showProfile = true
                        
                    },
                           label: {
                        Image(systemName: "person")
                            .frame(width: 18, height: 18)
                        Text("Личный кабинет")
                            .font(Font.custom("Open Sans", size: 16))
                            .kerning(0.16)
                    })
                    
                    Button(action: { },
                           label: {
                        Image(systemName: "text.bubble")
                            .frame(width: 18, height: 18)
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
                            .frame(width: 18, height: 18)
                        Text("Редактировать профиль")
                            .font(Font.custom("Open Sans", size: 16))
                            .kerning(0.16)
                    })
                    
                    Button(action: { },
                           label: {
                        Image(systemName: "person.badge.shield.checkmark")
                            .frame(width: 18, height: 18)
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
                    ImageView(url: mainVM.user!.getImageURL(), backupImage: "person")
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
                .padding(12)
                .frame(height: 60, alignment: .leading)
                .background(.white)
                .cornerRadius(12)
                .padding(.horizontal, 12)
            }
            .background(Color("Gray_bg"))
        } else {
            HStack(alignment: .center, spacing: 8){
                NavigationLink(value: NavView.login) {
                    Text("Авторизация")
                        .font(Font.custom("Open Sans", size: 12))
                        .kerning(0.12)
                }
                
                Spacer()
                
                NavigationLink(value: NavView.register) {
                    Text("Регистрация")
                        .font(Font.custom("Open Sans", size: 12))
                        .kerning(0.12)
                        .foregroundColor(.black)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1))
                }
            }
            .padding(12)
            .frame(height: 60, alignment: .leading)
            .background(.white)
            .cornerRadius(12)
            .padding(.horizontal, 12)
        }
    }
}

//struct TopMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        TopMenu()
//    }
//}
