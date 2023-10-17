//
//  Login.swift
//  Zan-Lab
//
//  Created by Андрей on 30.09.2023.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    @State private var telephone = ""
    @State private var password = ""
    
    // Флаг скрыть-показать данные в поле ввода пароля
    @State private var isSecured: Bool = true
    
    var body: some View {
        VStack {
            VStack (alignment: .leading, spacing: 2){
                // Поле ввода телефона
                Text("Телефон")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .opacity(telephone.isEmpty ? 0 : 1)
                    .offset(y: telephone.isEmpty ? 20 : 0)
                    .padding(.horizontal)
                
                HStack{
                    Image(systemName: "phone")
                    TextField("Телефон", text: $telephone)
                        .keyboardType(.phonePad)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
                    .shadow(radius: 20))
                .padding(.horizontal)
            }
            .padding(.vertical)
            .animation(.default, value: UUID())
            
            //            Text("По номеру телефона")
            //                .padding(.horizontal)
            
            VStack (alignment: .leading, spacing: 2){
                // Поле ввода пароля
                Text("Введите пароль")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .opacity(password.isEmpty ? 0 : 1)
                    .offset(y: password.isEmpty ? 20 : 0)
                    .padding(.horizontal)
                
                HStack{
                    Image(systemName: "key")
                    Group {
                        if isSecured {
                            SecureField("Введите пароль", text: $password)
                        } else {
                            TextField("Введите пароль", text: $password)
                        }
                    }
                    // Кнопка переключения видимости данных в поле ввода пароля
                    Button {
                        isSecured.toggle()
                    } label: {
                        Image(systemName: self.isSecured ? "eye" : "eye.slash")
                            .accentColor(.gray)
                    }
                    
                    
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
                    .shadow(radius: 20))
                .padding(.horizontal)
                
                Button("Забыли пароль?") {}
                    .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    mainVM.doLogin(login: telephone, passord: password)
                }, label: {
                    Text("Войти")
                        .font(.title2)
                        .frame(minWidth: 100, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.gray)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                            .shadow(radius: 20))
                })
                .cornerRadius(10)
                .padding()
            }
            //.padding(.vertical)
            .animation(.default, value: UUID())
        }
        .navigationTitle("Вход в систему")
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
