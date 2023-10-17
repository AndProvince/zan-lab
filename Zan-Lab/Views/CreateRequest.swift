//
//  CreateRequest.swift
//  Zan-Lab
//
//  Created by Андрей on 10.10.2023.
//

import SwiftUI

struct CreateRequest: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    @State private var selectedCase = 0
    @State private var selectedStep = 0
    @State private var description = ""
    @State private var selectedLocation = 0
    @State private var selectedDate = Date()
    
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var telephone = ""
    @State private var contactEmail = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Информация о происшествии")
                    .font(.largeTitle)
                    .padding(.vertical)
                
                HStack {
                    Picker("Выберите ситуацию", selection: $selectedCase) {
                        ForEach(0 ..< mainVM.allCases.count) { index in
                            Text("\(mainVM.allCases[index].caseNameRu)")
                                .foregroundColor(.black)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
                    .shadow(radius: 20))
                
                HStack {
                    Picker("На каком этапе ситуация", selection: $selectedStep) {
                        ForEach(0 ..< mainVM.allSteps.count) { index in
                            Text("\(mainVM.allSteps[index].stepNameRu)")
                                .foregroundColor(.black)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
                    .shadow(radius: 20))
                
                Divider()
                
                VStack(alignment: .leading, spacing: 2){
                    Text("Описание происшествия")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    HStack{
                        TextField("", text: $description)
                    }
                    .frame(maxWidth: .infinity, idealHeight: 100, maxHeight: 200, alignment: .top)
                    .padding()
                    .background(Color("zlGray"))
                    .cornerRadius(12)
                }
                
                Divider()
                
                HStack {
                    Picker("Место происшествия", selection: $selectedLocation) {
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
                
                HStack{
                    DatePicker("Дата происшествия", selection: $selectedDate, displayedComponents: .date)
                            .labelsHidden()
                }
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color("zlGray"))
//                .cornerRadius(12)
                
                Divider()
                
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: { },
                               label: {
                            Image(systemName: "paperclip")
                            Text("Прикрепить документы")
                        })
                    }
                    
                    Text("Прикрепите до 10 файлов общим весом до 100 мб. Допустимы форматы файлов: png, jpg, jpeg, pdf")
                        .font(.callout)
                        .foregroundColor(Color.gray)
                }
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .padding([.horizontal, .bottom])
            
            // контактная информация
            VStack(alignment: .leading) {
                Text("Контактная информация")
                    .font(.largeTitle)
                    .padding(.top)
                
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
                        .padding(.top)
                    
                }
                .animation(.default, value: UUID())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Контактный номер")
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
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("zlGray"))
                    .cornerRadius(12)
                    
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
                }
                .animation(.default, value: UUID())
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .padding(.horizontal)
            
            Button(action: {
                // to do
            },label: {
                    Text("Отправить на модерацию")
                        .font(.title2)
                        .frame(minWidth: 100, maxWidth: .infinity)
                        .padding()
            })
            .buttonStyle(MainBlueButtonStyle())
            .padding()
        }
        .background(Color("zlGray"))
    }
}

//struct CreateRequest_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateRequest()
//    }
//}
