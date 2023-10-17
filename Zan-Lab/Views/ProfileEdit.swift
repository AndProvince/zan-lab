//
//  ProfileEdit.swift
//  Zan-Lab
//
//  Created by Андрей on 06.10.2023.
//

import SwiftUI

struct ProfileEdit: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var selectedLocation = 0
    @State private var mobile = ""
    @State private var contactPhone = ""
    @State private var email = ""
    @State private var contactEmail = ""
    @State private var about = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Личная информация")
                .font(.headline)
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Фамилия")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .opacity(lastName.isEmpty ? 0 : 1)
                    .offset(y: lastName.isEmpty ? 20 : 0)
                    .padding(.horizontal)
                
                TextField("Фамилия", text: $lastName)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("zlGray"))
                    .cornerRadius(12)

                Text("Имя и Отчетство")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .opacity(firstName.isEmpty ? 0 : 1)
                    .offset(y: firstName.isEmpty ? 20 : 0)
                    .padding(.horizontal)
                
                TextField("Имя и Отчетство", text: $firstName)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("zlGray"))
                    .cornerRadius(12)
                
                Divider()
                    .padding(.vertical)
                
            }
            .animation(.default, value: UUID())
                
//            Text(lastName.isEmpty ? " " : "Населенный пункт")
//                .font(.subheadline)
//                .foregroundColor(.gray)
//                .padding(.horizontal)
            
            HStack {
                Picker("Населенный пункт", selection: $selectedLocation) {
                    ForEach(0 ..< mainVM.allLocations.count) { index in
                        Text("\(mainVM.allLocations[index].valueRu)")
                            .foregroundColor(Color.black)
                    }
                }
                .pickerStyle(.navigationLink)
                .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("zlGray"))
            .cornerRadius(12)
            
            Divider()
                .padding(.vertical)
            
            // контакты - номера телефонов
            VStack(alignment: .leading, spacing: 2) {
                Text("Номер телефона")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .opacity(mobile.isEmpty ? 0 : 1)
                    .offset(y: mobile.isEmpty ? 20 : 0)
                    .padding(.horizontal)
                
                HStack{
                    Image(systemName: "phone")
                    TextField("Номер телефона", text: $mobile)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.gray)
                .background(Color("zlGray"))
                .cornerRadius(12)
                .disabled(true)
                
                Button(action: {
                    // to do
                }, label: {
                    Text("Изменить номер телефона")
                        .padding([.bottom, .horizontal])
                })

                Text("Контактный номер")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .opacity(contactPhone.isEmpty ? 0 : 1)
                    .offset(y: contactPhone.isEmpty ? 20 : 0)
                    .padding(.horizontal)
                
                HStack{
                    Image(systemName: "phone")
                    TextField("Контактный номер", text: $contactPhone)
                        .keyboardType(.phonePad)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("zlGray"))
                .cornerRadius(12)
                
                Text("Без указания контактного номера телефона будет использован основной номер для связи с вами.")
                    .font(.callout)
                    .padding(.horizontal)
                
                Divider()
                    .padding(.vertical)
            }
            .animation(.default, value: UUID())
                
            
            // контакты - электронные почты
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
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.gray)
                .background(Color("zlGray"))
                .cornerRadius(12)
                .disabled(true)
                
                Button(action: {
                    // to do
                }, label: {
                    Text("Изменить электронну почту")
                        .padding(.horizontal)
                })
                
                Text("Контактная почта")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .opacity(contactEmail.isEmpty ? 0 : 1)
                    .offset(y: contactEmail.isEmpty ? 20 : 0)
                    .padding(.horizontal)
                
                HStack{
                    Image(systemName: "envelope")
                    TextField("Контактная почта", text: $contactEmail)
                        .keyboardType(.emailAddress)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("zlGray"))
                .cornerRadius(12)
                
                Text("Без указания контактной электронной почты будет использована основная электронная почта для связи с вами.")
                    .font(.callout)
                    .padding(.horizontal)
                
                Divider()
                    .padding(.vertical)
            }
            .animation(.default, value: UUID())
            
            VStack(alignment: .leading) {
                Button(action: {
                    // to do
                }, label: {
                    Text("Изменить пароль")
                        .padding(.horizontal)
                })
                
                Divider()
                    .padding(.vertical)
            }
            
            VStack(alignment: .leading, spacing: 2){
                Text("Расскажите о себе")
                    .font(.caption)
                    .foregroundColor(.gray)
                    //.opacity(contactEmail.isEmpty ? 0 : 1)
                    //.offset(y: contactEmail.isEmpty ? 20 : 0)
                    .padding(.horizontal)
                
                HStack{
                    TextField("", text: $about)
                }
                .frame(maxWidth: .infinity, idealHeight: 100, maxHeight: 200, alignment: .top)
                .padding()
                .background(Color("zlGray"))
                .cornerRadius(12)
            }
            
            Button(action: {
                mainVM.user?.lastName = self.lastName
                mainVM.user?.firstName = self.firstName
                mainVM.user?.locationRefKeyId = mainVM.allLocations[self.selectedLocation].refKeyId
                //mainVM.user?.mobile = self.mobile
                //mainVM.user?.email = self.email
                mainVM.user?.about = self.about
                mainVM.putUser()
                mainVM.showEditProfile.toggle()
            },label: {
                    Text("Сохранить")
                        .font(.title2)
                        .frame(minWidth: 100, maxWidth: .infinity)
                        .padding()
            })
            .buttonStyle(MainBlueButtonStyle())
            .padding()

        }
        .padding()
        .background(.white)
        .onAppear(perform: {
            if self.lastName == "" {
                self.lastName = mainVM.user?.lastName ?? ""
            }
            if self.firstName == "" {
                self.firstName = mainVM.user?.firstName ?? ""
            }
            if self.selectedLocation == 0 {
                self.selectedLocation = mainVM.allLocations.firstIndex(where: { $0.refKeyId == mainVM.user?.locationRefKeyId }) ?? 0
            }
            if self.mobile == "" {
                self.mobile = mainVM.user?.getMobile() ?? ""
            }
            if self.email == "" {
                self.email = mainVM.user?.email ?? ""
            }
            if self.about == "" {
                self.about = mainVM.user?.about ?? ""
            }
        })
    }
}

//struct ProfileEdit_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileEdit()
//    }
//}
