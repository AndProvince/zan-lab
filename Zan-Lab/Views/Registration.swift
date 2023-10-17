//
//  Registration.swift
//  Zan-Lab
//
//  Created by Андрей on 24.09.2023.
//

import SwiftUI

struct Registration: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
    @State private var telephone = ""
    @State private var password = ""
    @State private var email = ""
    @State private var otpCode = ""
    
    // Флаг скрыть-показать данные в поле ввода пароля
    @State private var isSecured: Bool = true
    
    var body: some View {
        // Проверка требуется ли форма входа
        if mainVM.loginPending {
            withAnimation {
                Login()
            }
        } else {
            GeometryReader {geo in
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 2) {
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
                        //.padding()
                        .disabled(mainVM.registerPending)
                    }
                    .padding(.horizontal)
                    .animation(.default, value: UUID())
                    
                    // Поле ввода пароля
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Придумайте пароль")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .opacity(password.isEmpty ? 0 : 1)
                            .offset(y: password.isEmpty ? 20 : 0)
                            .padding(.horizontal)
                        
                        HStack{
                            Image(systemName: "key")
                            Group {
                                if isSecured {
                                    SecureField("Придумайте пароль", text: $password)
                                } else {
                                    TextField("Придумайте пароль", text: $password)
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
                        //.padding([.top, .horizontal])
                        .disabled(mainVM.registerPending)
                    
                    
                        Text("Не менее 6 знаков, включать минимум одну заглавную и одну строчную буквы, цифры и специальные символы")
                            .font(.callout)
                    }
                    //.frame(maxWidth: geo.size.width)
                    .padding(.horizontal)
                    .animation(.default, value: UUID())
                    
                    
                    // Поле ввода почты
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Электронная почта")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .opacity(email.isEmpty ? 0 : 1)
                            .offset(y: email.isEmpty ? 20 : 0)
                            .padding(.horizontal)
                        
                        HStack{
                            Image(systemName: "envelope")
                            TextField("Электронная почта", text: $email)
                                .keyboardType(.emailAddress)
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                            .shadow(radius: 20))
                        //.padding([.top, .horizontal])
                        .disabled(mainVM.registerPending)
                    
                        Text("Вам необходимо указать свой адрес электронной почты для использования в качестве альтернативного способа входа и для восстановления пароля")
                            .font(.callout)
                    }
                    //.frame(maxWidth: geo.size.width)
                    .padding(.horizontal)
                    .animation(.default, value: UUID())
                        
                    
                    VStack {
                        Text("Используя сервис Zan-Lab и продолжая регистрацию вы даете согаласие на сбор и обработку Ваших данных и соглашаетесь с условиями пользовательского соглашения")
                    }
                    .frame(maxWidth: geo.size.width)
                    .padding()
                    
                    Spacer()
                    
                    if mainVM.registerPending {
                        // Поле ввода OTP
                        VStack{
                            TextField("Введите код из SMS", text: $otpCode)
                                .keyboardType(.numberPad)
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                            .shadow(radius: 20))
                        .padding()
                    }
                    
                    VStack {
                        Button(action: {
                            if mainVM.registerPending {
                                mainVM.register(login: self.telephone, password: self.password, otpCode: self.otpCode)
                            } else
                            {
                                mainVM.sendOtp(login: self.telephone)
                            }
                        }, label: {
                            Text(mainVM.registerPending ? "Зарегистрированться" : "Получить SMS код")
                                .font(.title2)
                                .frame(minWidth: 100, maxWidth: geo.size.width)
                                .padding()
                                .foregroundColor(.gray)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 2)
                                    .shadow(radius: 20))
                        })
                        .cornerRadius(10)
                        .padding()
                    }
                }
                .navigationTitle("Регистрация")
                .onAppear() {
                    if mainVM.registerPending {
                        mainVM.registerPending = false
                    }
                }
            }
        }
    }
}

//struct Registration_Previews: PreviewProvider {
//    static var previews: some View {
//        Registration()
//    }
//}
