//
//  TopMenu.swift
//  Zan-Lab
//
//  Created by Андрей on 24.09.2023.
//

import SwiftUI

struct TopMenu: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        if  mainVM.userLogined {
            HStack {
                Menu {
                    Button(action: {
                        mainVM.showProfile = true
                        
                    },
                           label: {
                        Image(systemName: "person")
                        Text("Личный кабинет")
                    })
                    
                    Button(action: { },
                           label: {
                        Image(systemName: "text.bubble")
                        Text("Мои обращения")
                    })
                    
                    Button(action: {
                        mainVM.showEditProfile = true
                        mainVM.showProfile = true
                    },
                           label: {
                        Image(systemName: "pencil")
                        Text("Редактировать профиль")
                    })
                    
                    Button(action: { },
                           label: {
                        Image(systemName: "person.badge.shield.checkmark")
                        Text("Регистрация специалиста")
                    })
                    
                    Divider()
                    
                    Button(action: { mainVM.logout() },
                           label: {
                        Text("Выход")
                    })
                    
                } label: {
                    HStack{
                        ImageView(url: mainVM.user?.getImageURL(), backupImage: "person")
                            .frame(width: 36, height: 36)
                            .cornerRadius(8.0)
                        Text(mainVM.user!.getName())
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
            .background(Color("zlGray"))
        } else {
            HStack(alignment: .top){
                NavigationLink(destination: Login()) {
                    Text("Вход")
                        .padding(5)
                }
                
                Spacer()
                
                NavigationLink(destination: Registration()) {
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
