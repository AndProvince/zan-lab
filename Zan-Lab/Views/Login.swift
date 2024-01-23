//
//  Login.swift
//  Zan-Lab
//
//  Created by Андрей on 30.09.2023.
//

import SwiftUI
import Combine

struct Login: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    @Binding var path: [NavView]
    
    @State private var telephone = ""
    @State private var password = ""
    
    // Флаг скрыть-показать данные в поле ввода пароля
    @State private var isSecured: Bool = true
    
    private let mask = "+X (XXX) XXX-XX-XX"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24){
            
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
            .animation(.default, value: UUID())
            
            
            // Поле ввода пароля
            HStack(alignment: .center, spacing: 12){
                Image(systemName: "key")
                ZStack(alignment: .leading) {
                    Text("Введите пароль")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .opacity(password.isEmpty ? 0 : 1)
                        .offset(y: password.isEmpty ? 0 : -20)

                    Group {
                        if isSecured {
                            SecureField("Введите пароль", text: $password)
                        } else {
                            TextField("Введите пароль", text: $password)
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
                .stroke(Color("Gray_elements"), lineWidth: 1)
            )
            .animation(.default, value: UUID())
        
            Button("Забыли пароль?") {}
                .padding(.horizontal)
            
            Spacer()
                
            Button(action: {
                let login = UnFormatByMask(with: mask, phone: self.telephone)
                mainVM.doLogin(login: login, password: password)
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

        }
        .padding(.horizontal, 12)
        .padding(.top, 12)
        .navigationTitle("Вход в систему")
        .onReceive(Just(mainVM.userLogined), perform: { _ in
            if mainVM.userLogined {
                path.removeAll()
            }
        })
    }
    
}

//struct Login_Previews: PreviewProvider {
//    static var previews: some View {
//        Login()
//    }
//}
