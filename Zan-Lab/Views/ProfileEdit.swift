//
//  ProfileEdit.swift
//  Zan-Lab
//
//  Created by Андрей on 06.10.2023.
//

import SwiftUI
import Combine

struct ProfileEdit: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented: Bool = false
    
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var selectedLocation = 0
    @State private var mobile = ""
    @State private var contactPhone = ""
    @State private var email = ""
    @State private var contactEmail = ""
    @State private var about = ""
    
    var body: some View {
        // вывод аваратки и меню по ее изменению
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)  {
            Menu {
                Button(action: {
                    isImagePickerPresented.toggle()
                },
                       label: {
                    Image(systemName: "arrow.triangle.2.circlepath.camera")
                    Text("Изменить фото")
                })
                
                Button(action: { 
                    mainVM.deleteProfilePhoto()
                },
                       label: {
                    Image(systemName: "trash")
                    Text("Удалить фото")
                })
                
            } label: {
                ImageView(url: mainVM.user!.getImageURL(), backupImage: "person")
            }
        }
        .frame(width: 296, height: 304)
        .background(Color("Gray_bg"))
        .cornerRadius(12.0)
        .scaledToFill()
        .padding()
        
        VStack(alignment: .leading, spacing: 24) {
            Text("Личная информация")
                .font(
                Font.custom("Montserrat", size: 20)
                .weight(.bold)
                )
                .padding(.bottom, 12)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center){
                    ZStack(alignment: .leading) {
                        TextField("Фамилия", text: $lastName)
                            .padding(12)
                            .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .center)
                            .background(Color("Gray_bg"))
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color("Gray_elements"), lineWidth: 1)
                            )
                        
                        Text("Фамилия")
                            .font(Font.custom("Open Sans", size: 8))
                            .foregroundColor(Color.gray)
                            .frame(width: 157, alignment: .topLeading)
                            .opacity(lastName.isEmpty ? 0 : 1)
                            .offset(x: 10, y: lastName.isEmpty ? 0 : -20)
                    }
                }
                
                HStack(alignment: .center){
                    ZStack(alignment: .leading) {
                        TextField("Имя и Отчетство", text: $firstName)
                            .padding(12)
                            .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .center)
                            .background(Color("Gray_bg"))
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color("Gray_elements"), lineWidth: 1)
                            )
                        
                        Text("Имя и Отчетство")
                            .font(Font.custom("Open Sans", size: 8))
                            .foregroundColor(Color.gray)
                            .frame(width: 157, alignment: .topLeading)
                            .opacity(firstName.isEmpty ? 0 : 1)
                            .offset(x: 10, y: firstName.isEmpty ? 0 : -20)
                    }
                }
                
                HStack {
                    Picker("Населенный пункт", selection: $selectedLocation) {
                        ForEach(0 ..< mainVM.allLocations.count, id: \.self) { index in
                            Text("\(mainVM.allLocations[index].valueRu)")
                                .foregroundColor(Color.black)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    .foregroundColor(.gray)
                }
                .padding(12)
                .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .center)
                .background(Color("Gray_bg"))
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color("Gray_elements"), lineWidth: 1)
                )
                
            }
            .animation(.default, value: UUID())
            
            Divider()
            
            // контакты - номера телефонов
            VStack(alignment: .leading, spacing: 12) {
                
                HStack(alignment: .center, spacing: 12){
                    Image(systemName: "phone")
                    ZStack(alignment: .leading) {
                        TextField("Номер телефона", text: $mobile)
                        
                        Text("Номер телефона")
                            .font(Font.custom("Open Sans", size: 8))
                            .foregroundColor(Color.gray)
                            .frame(width: 157, alignment: .topLeading)
                            .opacity(mobile.isEmpty ? 0 : 1)
                            .offset(y: mobile.isEmpty ? 0 : -20)
                    }
                }
                .padding(12)
                .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .center)
                .foregroundColor(.gray)
                .background(Color("Gray_bg"))
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color("Gray_elements"), lineWidth: 1)
                )
                .disabled(true)
                
                Button(action: {
                    // to do
                }, label: {
                    Text("Изменить номер телефона")
                })
                
                
                HStack(alignment: .center, spacing: 12){
                    Image(systemName: "phone")
                    ZStack(alignment: .leading) {
                        TextField("Номер телефона", text: $contactPhone)
                            .keyboardType(.phonePad)
                        
                        Text("Контактный номер")
                            .font(Font.custom("Open Sans", size: 8))
                            .foregroundColor(Color.gray)
                            .frame(width: 157, alignment: .topLeading)
                            .opacity(contactPhone.isEmpty ? 0 : 1)
                            .offset(y: contactPhone.isEmpty ? 0 : -20)
                    }
                }
                .padding(12)
                .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .center)
                .foregroundColor(.gray)
                .background(Color("Gray_bg"))
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color("Gray_elements"), lineWidth: 1)
                )
                
                Text("Без указания контактного номера телефона будет использован основной номер для связи с вами.")
                    .font(Font.custom("Open Sans", size: 12))
                    .kerning(0.12)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
            }
            .animation(.default, value: UUID())
            
            Divider()
            
            // контакты - электронные почты
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center, spacing: 12){
                    Image(systemName: "envelope")
                    ZStack(alignment: .leading) {
                        TextField("Электронная почта", text: $email)
                        
                        Text("Электронная почта")
                            .font(Font.custom("Open Sans", size: 8))
                            .foregroundColor(Color.gray)
                            .frame(width: 157, alignment: .topLeading)
                            .opacity(email.isEmpty ? 0 : 1)
                            .offset(y: email.isEmpty ? 0 : -20)
                    }
                }
                .padding(12)
                .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .center)
                .foregroundColor(.gray)
                .background(Color("Gray_bg"))
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color("Gray_elements"), lineWidth: 1)
                )
                .disabled(true)
                
                Button(action: {
                    // to do
                }, label: {
                    Text("Изменить электронну почту")
                })
                
                HStack(alignment: .center, spacing: 12){
                    Image(systemName: "envelope")
                    ZStack(alignment: .leading) {
                        TextField("Контактная почта", text: $contactEmail)
                            .keyboardType(.emailAddress)
                        
                        Text("Контактная почта")
                            .font(Font.custom("Open Sans", size: 8))
                            .foregroundColor(Color.gray)
                            .frame(width: 157, alignment: .topLeading)
                            .opacity(contactEmail.isEmpty ? 0 : 1)
                            .offset(y: contactEmail.isEmpty ? 0 : -20)
                    }
                }
                .padding(12)
                .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .center)
                .foregroundColor(.gray)
                .background(Color("Gray_bg"))
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color("Gray_elements"), lineWidth: 1)
                )
                
                Text("Без указания контактной электронной почты будет использована основная электронная почта для связи с вами.")
                    .font(Font.custom("Open Sans", size: 12))
                    .kerning(0.12)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
            }
            .animation(.default, value: UUID())
            
            
            VStack(alignment: .leading, spacing: 24) {
                Divider()
                
                Button(action: {
                    // to do
                }, label: {
                    Text("Изменить пароль")
                })
                
                Divider()
            }
        
            
            VStack(alignment: .leading, spacing: 12){
                HStack(alignment: .center){
                    ZStack(alignment: .leading){
                        TextField("Расскажите о себе", text: $about)
                        
                        Text("Расскажите о себе")
                            .font(Font.custom("Open Sans", size: 8))
                            .foregroundColor(Color.gray)
                            .frame(width: 157, alignment: .topLeading)
                            .opacity(about.isEmpty ? 0 : 1)
                            .offset(y: about.isEmpty ? 0 : -20)
                    }
                }
                .frame(maxWidth: .infinity, idealHeight: 100, maxHeight: 200, alignment: .top)
                .padding()
                .background(Color("Gray_bg"))
                .cornerRadius(12)
            }
            
            Button(action: {
                mainVM.user!.lastName = self.lastName
                mainVM.user!.firstName = self.firstName
                mainVM.user!.locationRefKeyId = mainVM.allLocations[self.selectedLocation].refKeyId
                //mainVM.user?.mobile = self.mobile
                //mainVM.user?.email = self.email
                mainVM.user!.about = self.about
                mainVM.putUser()
                mainVM.showEditProfile.toggle()
            }, label: {
                    Text("Сохранить")
                        .font(.title2)
                        .frame(minWidth: 100, maxWidth: .infinity)
                        .padding()
            })
            .buttonStyle(MainBlueButtonStyle())

        }
        .padding(.horizontal, 12)
        .padding(.vertical, 24)
        .background(.white)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke(Color.white, lineWidth: 1)
        )
        .onAppear(perform: {
            if self.lastName == "" {
                self.lastName = mainVM.user!.lastName ?? ""
            }
            if self.firstName == "" {
                self.firstName = mainVM.user!.firstName ?? ""
            }
            if self.selectedLocation == 0 {
                self.selectedLocation = mainVM.allLocations.firstIndex(where: { $0.refKeyId == mainVM.user!.locationRefKeyId }) ?? 0
            }
            if self.mobile == "" {
                self.mobile = mainVM.user!.getMobile() ?? ""
            }
            if self.email == "" {
                self.email = mainVM.user!.email ?? ""
            }
            if self.about == "" {
                self.about = mainVM.user!.about ?? ""
            }
        })
        .sheet(isPresented: $isImagePickerPresented, content: {
            ImagePicker(selectedImage: $selectedImage)
                .onChange(of: selectedImage){ _ in
                    if let selectedImage = selectedImage {
                        print("photo selected")
                        mainVM.saveProfilePhoto(image: selectedImage)
                    }
                }
        })
    }
}

//struct ProfileEdit_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileEdit()
//    }
//}
