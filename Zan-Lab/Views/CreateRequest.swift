//
//  CreateRequest.swift
//  Zan-Lab
//
//  Created by Андрей on 10.10.2023.
//

import SwiftUI

struct CreateRequest: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    private let defaultValue = -1
    @State private var selectedCase = -1
    @State private var selectedStep = -1
    @State private var description = ""
    @State private var selectedLocation = -1
    @State private var selectedDate = Date()
    @State private var isDatePickerPresented = false
    @State private var currentDate = Date()
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var telephone = ""
    @State private var contactEmail = ""
    
    private let mask = "+X (XXX) XXX-XX-XX"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Информация о происшествии")
                    .font(Font.custom("Montserrat", size: 20)
                        .weight(.bold)
                        )
                    .foregroundColor(Color(red: 0.21, green: 0.21, blue: 0.21))
                    .padding(.bottom, 24)
                
                // выбор ситуации
                Menu {
                    ForEach(0 ..< mainVM.allCases.count, id: \.self) { index in
                        Button("\(mainVM.allCases[index].caseNameRu)") {
                            withAnimation {
                                selectedCase = index
                            }
                        }
                    }
                } label: {
                    HStack {
                        ZStack(alignment: .leading) {
                            Text("Выберите ситуацию")
                                .font(Font.custom("Open Sans", size: 8))
                                .kerning(0.08)
                                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                                .opacity(selectedCase == defaultValue ? 0 : 1)
                                .offset(y: selectedCase == defaultValue ? 0 : -20)
                            
                            Text(selectedCase == defaultValue ? "Выберите ситуацию" : "\(mainVM.allCases[selectedCase].caseNameRu)")
                                .font(Font.custom("Open Sans", size: 14))
                                .kerning(0.14)
                                .foregroundColor(selectedCase == defaultValue ? Color(red: 0.51, green: 0.51, blue: 0.51) : Color(red: 0.21, green: 0.21, blue: 0.21))
                                .frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20, alignment: .topLeading)
                                .padding(.vertical, 8)
                        }
                        Spacer()
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .background(Color("Gray_bg"))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12)
                        .inset(by: 1)
                        .stroke(Color(red: 0.94, green: 0.94, blue: 0.94), lineWidth: 2)
                    )
                }
                
                // выбор этапа
                Menu {
                    ForEach(0 ..< mainVM.allSteps.count, id: \.self) { index in
                        Button("\(mainVM.allSteps[index].stepHintRu)") {
                            withAnimation {
                                selectedStep = index
                            }
                        }
                    }
                } label: {
                    HStack {
                        ZStack(alignment: .leading) {
                            Text("Этап ситуации")
                                .font(Font.custom("Open Sans", size: 8))
                                .kerning(0.08)
                                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                                .opacity(selectedStep == defaultValue ? 0 : 1)
                                .offset(y: selectedStep == defaultValue ? 0 : -20)
                            
                            Text(selectedStep == defaultValue ? "Этап ситуации" : "\(mainVM.allSteps[selectedStep].stepHintRu)")
                                .font(Font.custom("Open Sans", size: 14))
                                .kerning(0.14)
                                .foregroundColor(selectedStep == defaultValue ? Color(red: 0.51, green: 0.51, blue: 0.51) : Color(red: 0.21, green: 0.21, blue: 0.21))
                                .frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20, alignment: .topLeading)
                                .padding(.vertical, 8)
                        }
                        Spacer()
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .background(selectedCase == defaultValue ? Color("Gray_elements") : Color("Gray_bg"))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12)
                        .inset(by: 1)
                        .stroke(Color(red: 0.94, green: 0.94, blue: 0.94), lineWidth: 2)
                    )
                }
                .disabled(selectedCase == defaultValue)
                
                if selectedStep != defaultValue {
                    Divider()
                        .padding(.vertical, 24)
                    
                    // описание происшествия
                    HStack(alignment: .center){
                        ZStack(alignment: .leading){
                            TextField("Описание происшествия", text: $description)
                            
                            Text("Описание происшествия")
                                .font(Font.custom("Open Sans", size: 8))
                                .kerning(0.08)
                                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                                .opacity(description.isEmpty ? 0 : 1)
                                .offset(y: description.isEmpty ? 0 : -20)
                        }
                    }
                    .frame(maxWidth: .infinity, idealHeight: 100, maxHeight: 200, alignment: .top)
                    .padding()
                    .background(Color("Gray_bg"))
                    .cornerRadius(12)
                    
                    Divider()
                        .padding(.vertical, 24)
                    
                    // выбор населенного пункта
                    Menu {
                        ForEach(0 ..< mainVM.allLocations.count, id: \.self) { index in
                            Button("\(mainVM.allLocations[index].valueRu)") {
                                withAnimation {
                                    selectedLocation = index
                                }
                            }
                        }
                    } label: {
                        HStack {
                            ZStack(alignment: .leading) {
                                Text("Место происшествия")
                                    .font(Font.custom("Open Sans", size: 8))
                                    .kerning(0.08)
                                    .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                                    .opacity(selectedLocation == defaultValue ? 0 : 1)
                                    .offset(y: selectedLocation == defaultValue ? 0 : -20)
                                
                                Text(selectedLocation == defaultValue ? "Место происшествия" : "\(mainVM.allLocations[selectedLocation].valueRu)")
                                    .font(Font.custom("Open Sans", size: 14))
                                    .kerning(0.14)
                                    .foregroundColor(selectedLocation == defaultValue ? Color(red: 0.51, green: 0.51, blue: 0.51) : Color(red: 0.21, green: 0.21, blue: 0.21))
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .padding(.vertical, 8)
                            }
                            Spacer()
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .background(Color("Gray_bg"))
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            .inset(by: 1)
                            .stroke(Color(red: 0.94, green: 0.94, blue: 0.94), lineWidth: 2)
                        )
                    }
                    
                    VStack {
                        HStack{
                            ZStack(alignment: .leading) {
                                Text("Дата происшествия")
                                    .font(Font.custom("Open Sans", size: 8))
                                    .kerning(0.08)
                                    .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                                    //.opacity(1)
                                    .offset(y: -20)
                                
                                Text(dateFormatter.string(from: selectedDate))
                                    .font(Font.custom("Open Sans", size: 14))
                                    .kerning(0.14)
                                    .foregroundColor(Color(red: 0.21, green: 0.21, blue: 0.21))
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .padding(.vertical, 8)
                            }
                            Spacer()
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .background(Color("Gray_bg"))
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            .inset(by: 1)
                            .stroke(Color(red: 0.94, green: 0.94, blue: 0.94), lineWidth: 2)
                        )
                        .onTapGesture {
                            isDatePickerPresented.toggle()
                        }

                        if isDatePickerPresented {
                            DatePicker("Дата происшествия", selection: $selectedDate, in: ...currentDate, displayedComponents: .date)
                                .labelsHidden()
                                .datePickerStyle(GraphicalDatePickerStyle())
                                //.frame(maxWidth: .infinity, maxHeight: 400)
                                .onChange(of: selectedDate) {_ in
                                    isDatePickerPresented.toggle()
                                }
                        }
                    }
                    .onAppear {
                        currentDate = Date()
                    }
                    
                    Divider()
                        .padding(.vertical, 24)
                    
                    VStack(alignment: .leading) {
                        HStack(alignment: .center, spacing: 8) {
                            Button(action: { },
                                   label: {
                                Image(systemName: "paperclip")
                                    .frame(width: 18, height: 18)
                                Text("Прикрепить документы")
                                    .font(Font.custom("Open Sans", size: 16))
                                    .kerning(0.16)
                                    .foregroundColor(Color(red: 0.15, green: 0.32, blue: 0.91))
                            })
                        }
                        
                        Text("Прикрепите до 10 файлов общим весом до 100 мб. Допустимы форматы файлов: png, jpg, jpeg, pdf")
                            .font(Font.custom("Open Sans", size: 12))
                            .kerning(0.12)
                            .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                    }
                }
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .padding([.horizontal, .bottom])
            
            // контактная информация
            VStack(alignment: .leading) {
                Text("Контактная информация")
                    .font(Font.custom("Montserrat", size: 20)
                            .weight(.bold)
                            )
                    .foregroundColor(Color(red: 0.21, green: 0.21, blue: 0.21))
                    .padding(.bottom, 24)
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .center){
                        ZStack(alignment: .leading) {
                            TextField("Фамилия", text: $lastName)
                                .font(Font.custom("Open Sans", size: 14))
                                .kerning(0.14)
                                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
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
                                .font(Font.custom("Open Sans", size: 14))
                                .kerning(0.14)
                                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
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
                }
                .animation(.default, value: UUID())
                
                Divider()
                    .padding(.vertical, 24)
                
                VStack(alignment: .leading, spacing: 12) {
                    // Поле ввода телефона
                    HStack(alignment: .center, spacing: 12){
                        Image(systemName: "phone")
                        ZStack(alignment: .leading) {
                            Text("Контактный номер")
                                .font(Font.custom("Open Sans", size: 8))
                                .kerning(0.08)
                                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                                .opacity(telephone.isEmpty ? 0 : 1)
                                .offset(y: telephone.isEmpty ? 0 : -20)

                            TextField("Контактный номер", text: $telephone)
                                .font(Font.custom("Open Sans", size: 14))
                                .kerning(0.14)
                                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
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
                    
                    
                    // Поле ввода почты
                    HStack(alignment: .center, spacing: 12){
                        Image(systemName: "envelope")
                        ZStack(alignment: .leading) {
                            Text("Контактная почта")
                                .font(Font.custom("Open Sans", size: 8))
                                .kerning(0.08)
                                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                                .opacity(contactEmail.isEmpty ? 0 : 1)
                                .offset(y: contactEmail.isEmpty ? 0 : -20)
                            
                            TextField("Контактная почта", text: $contactEmail)
                                .keyboardType(.emailAddress)
                                .font(Font.custom("Open Sans", size: 14))
                                .kerning(0.14)
                                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
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
                        .font(Font.custom("Montserrat", size: 14)
                            .weight(.medium)
                            )
                        .foregroundColor(.white)
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
