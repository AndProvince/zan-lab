//
//  Registration.swift
//  Zan-Lab
//
//  Created by Андрей on 24.09.2023.
//

import SwiftUI
import Combine

struct Registration: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
    @State private var telephone = ""
    @State private var password = ""
    @State private var email = ""
    @State private var otpCode = ""
    
    // Флаг скрыть-показать данные в поле ввода пароля
    @State private var isSecured: Bool = true
    
    // Флаг ошибки при вводе пароля
    @State private var isPasswordError: Bool = false
    
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertText: String = ""
    
    private let mask = "+X (XXX) XXX-XX-XX"
    
    var body: some View {
        // Проверка требуется ли форма входа
        if mainVM.loginPending {
            withAnimation {
                Login()
            }
        } else {
            ScrollView {
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Поле ввода телефона
                    HStack(alignment: .center, spacing: 12){
                        Image(systemName: "phone")
                        ZStack(alignment: .leading) {
                            Text("Телефон")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .opacity(telephone.isEmpty ? 0 : 1)
                                .offset(y: telephone.isEmpty ? 0 : -20)

                            TextField("Телефон", text: $telephone)
                                .keyboardType(.phonePad)
                                .onChange(of: telephone, perform: { [oldValue = telephone] newValue in
                                    // 9 digits and 9 symbols in mask = 18
                                    if newValue.count > 18 {
                                        self.telephone = oldValue
                                    }
                                    telephone = FormatByMask(with: mask, phone: telephone)
                                })
                        }
                        .padding(.vertical, 10)
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .topLeading)
                    .background(Color("Gray_bg"))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color("Gray_elements"), lineWidth: 1)
                    )
                    .disabled(mainVM.registerPending)
                    .animation(.default, value: UUID())
                    
                    
                    // Поле ввода пароля
                    HStack(alignment: .center, spacing: 12){
                        Image(systemName: "key")
                        ZStack(alignment: .leading) {
                            Text("Придумайте пароль")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .opacity(password.isEmpty ? 0 : 1)
                                .offset(y: password.isEmpty ? 0 : -20)

                            Group {
                                if isSecured {
                                    SecureField("Придумайте пароль", text: $password)
                                        .onReceive(Just(password), perform: { newValue in
                                            self.password = SaveRomanLettersAndDigits(word: newValue)
                                        })
                                } else {
                                    TextField("Придумайте пароль", text: $password)
                                        .onReceive(Just(password), perform: { newValue in
                                            self.password = SaveRomanLettersAndDigits(word: newValue)
                                        })
                                }
                            }
                        }
                        .padding(.vertical, 10)
                        
                        // Кнопка переключения видимости данных в поле ввода пароля
                        Button {
                            isSecured.toggle()
                        } label: {
                            Image(systemName: self.isSecured ? "eye" : "eye.slash")
                                .accentColor(.gray)
                        }
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .topLeading)
                    .background(Color("Gray_bg"))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(isPasswordError ? .red : Color("Gray_elements"), lineWidth: 1)
                    )
                    .disabled(mainVM.registerPending)
                    .animation(.default, value: UUID())
                        
                    Text("Не менее 6 знаков, включать минимум одну заглавную и одну строчную буквы, цифры и специальные символы")
                        .font(.callout)
                        .foregroundColor(Color(.gray))
                    
                }
                .padding(.horizontal, 12)
                .padding(.top, 12)
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Поле ввода почты
                    HStack(alignment: .center, spacing: 12){
                        Image(systemName: "envelope")
                        ZStack(alignment: .leading) {
                            Text("Электронная почта")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .opacity(email.isEmpty ? 0 : 1)
                                .offset(y: email.isEmpty ? 0 : -20)
                            
                            TextField("Электронная почта", text: $email)
                                .keyboardType(.emailAddress)
                        }
                        .padding(.vertical, 10)
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .topLeading)
                    .background(Color("Gray_bg"))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color("Gray_elements"), lineWidth: 1)
                    )
                    .disabled(mainVM.registerPending)
                    .animation(.default, value: UUID())
                
                    Text("Вам необходимо указать свой адрес электронной почты для использования в качестве альтернативного способа входа и для восстановления пароля")
                        .font(.callout)
                        .foregroundColor(Color(.gray))

                    Text("Используя сервис Zan-Lab и продолжая регистрацию вы даете согаласие на сбор и обработку Ваших данных и соглашаетесь с условиями пользовательского соглашения")
                }
                .padding(.horizontal, 12)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 24) {
                    if mainVM.registerPending {
                        // Поле ввода OTP
                        HStack(alignment: .center, spacing: 12){
                            ZStack(alignment: .leading) {
                                Text("Введите код из SMS")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .opacity(otpCode.isEmpty ? 0 : 1)
                                    .offset(y: otpCode.isEmpty ? 0 : -20)
                                
                                TextField("Введите код из SMS", text: $otpCode)
                                    .keyboardType(.numberPad)
                            }
                            .padding(.vertical,  10)
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .topLeading)
                        .background(Color("Gray_bg"))
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0.5)
                            .stroke(Color("Gray_elements"), lineWidth: 1)
                        )
                        .animation(.default, value: UUID())
                    }
                    
                    Button(action: {
                        // Проверка на наличие цифр в пароле
                        if IsNeedNumber(word: self.password){
                            self.alertTitle = "Ошибка ввода пароля"
                            self.alertText = "Не менее 6 знаков на латинице, включать минимум одну заглавную и одну строчную буквы, цифры и специальные символы"
                            
                            self.isPasswordError = true
                            self.showAlert.toggle()
                        }
                        // Проверка на наличие заглавных букв
                        else if IsNeedUpper(word: self.password){
                            self.alertTitle = "Ошибка ввода пароля"
                            self.alertText = "Не менее 6 знаков на латинице, включать минимум одну заглавную и одну строчную буквы, цифры и специальные символы"
                            
                            self.isPasswordError = true
                            self.showAlert.toggle()
                        }
                        else if IsNeedLower(word: self.password){
                            self.alertTitle = "Ошибка ввода пароля"
                            self.alertText = "Не менее 6 знаков на латинице, включать минимум одну заглавную и одну строчную буквы, цифры и специальные символы"
                            
                            self.isPasswordError = true
                            self.showAlert.toggle()
                        }
                        else {
                            self.isPasswordError = false
                        }
                        
                        let login = UnFormatByMask(with: mask, phone: self.telephone)
                        if mainVM.registerPending {
                            mainVM.register(login: login, password: self.password, otpCode: self.otpCode)
                        } else
                        {
                            mainVM.sendOtp(login: login)
                        }
                    }, label: {
                        Text(mainVM.registerPending ? "Зарегистрированться" : "Получить SMS код")
                            .font(.title2)
                            .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
                            .padding(.horizontal)
                            .foregroundColor(.gray)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 2)
                                .shadow(radius: 20))
                    })
                    .cornerRadius(10)
                    .padding(.vertical)
                    .alert(isPresented: $showAlert){
                        Alert(title: Text(alertTitle), message: Text(alertText), dismissButton: .default(Text("Ok")))
                    }
                }
                .padding(.horizontal, 12)
                
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

//struct Registration_Previews: PreviewProvider {
//    static var previews: some View {
//        Registration()
//    }
//}
