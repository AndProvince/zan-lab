//
//  Search.swift
//  Zan-Lab
//
//  Created by Андрей on 30.09.2023.
//

import SwiftUI

struct Search: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    @State private var searchQuery = ""
    
    @State private var searchType: String = "Поиск по специализации"
    @State private var showFilter = false
    
    @State private var workExperience = 0
    let workExperiences = ["Любой", "Менее 1 года", "От 1 до 3 лет", "От 3 до 5 лет", "От 5 до 10 лет", "Более 10 лет"]
    
    let defaultValue: Int = -1
    @State private var selectedCase = -1
    @State private var selectedLocation = -1
    @State private var selectedSpecialization = -1
    @State private var selectedStep = -1
    
    private var defaultValues: Bool {
        return workExperience == 0 && selectedCase == self.defaultValue && selectedLocation == self.defaultValue && selectedSpecialization == self.defaultValue
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center, spacing: 12){
                Button(action: {
                    withAnimation {
                        self.showFilter.toggle()
                    }
                }, label: {
                    Image(systemName: self.showFilter ? "xmark" : self.defaultValues ? "line.3.horizontal.decrease.circle" : "line.3.horizontal.decrease.circle.fill")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color.gray)
                })
                
                Divider()
                
                // Поле поиска
                HStack{
                    Image(systemName: "magnifyingglass")
                    TextField("Поиск", text: $searchQuery)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 0.96, green: 0.96, blue: 0.97))
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.94, green: 0.94, blue: 0.94), lineWidth: 1)
                )
            }
            .frame(height: 44)
            .background(.white)
            .cornerRadius(12)
            .padding(.horizontal, 12)
            
            ZStack(alignment: .topLeading) {
                VStack {
                    // вывод специалистов
                    List(mainVM.specialists, id: \.person.id) { specialist in
                        NavigationLink(destination: {
                            Text("Детальная информация")
                        }, label: {
                            ScrollView {
                                VStack {
                                    HStack {
                                        ImageView(url: specialist.person.getImageURL(), backupImage: "person")
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(12.0)
                                            .padding(.trailing)
                                        VStack(alignment: .leading){
                                            Text(specialist.person.lastName)
                                            Text(specialist.person.firstName)
                                        }
                                    }
                                }
                            }
                        })
                    }
                }
                
                if self.showFilter {
                    VStack{
                        // Переключатель типа поиска
                        Picker("Выберите формат поиска", selection: $searchType) {
                            ForEach(["Поиск по специализации", "Поиск по ситуациям"], id: \.self) { option in
                                Text(option)
                                    .font(Font.custom("Open Sans", size: 14))
                                    .kerning(0.14)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                                    .frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20, alignment: .topTrailing)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal, 12)
                        
                        
                        // выбора ситуации или специализации
                        HStack{
                            if self.searchType == "Поиск по специализации" {
                                Menu {
                                    ForEach(0 ..< mainVM.allSpecializations.count, id: \.self) { index in
                                        Button("\(mainVM.allSpecializations[index].valueRu)") {
                                            withAnimation {
                                                selectedSpecialization = index
                                            }
                                        }
                                    }
                                } label: {
                                    HStack {
                                        ZStack(alignment: .leading) {
                                            Text("Специализация")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                                .opacity(selectedSpecialization == defaultValue ? 0 : 1)
                                                .offset(y: selectedSpecialization == defaultValue ? 0 : -20)
                                            
                                            Text(selectedSpecialization == defaultValue ? "Специализация" : "\(mainVM.allSpecializations[selectedSpecialization].valueRu)")
                                                .font(Font.custom("Open Sans", size: 14))
                                                .kerning(0.14)
                                                .foregroundColor(selectedSpecialization == defaultValue ? Color(red: 0.51, green: 0.51, blue: 0.51) : Color(red: 0.21, green: 0.21, blue: 0.21))
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
                            } else {
                                VStack {
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
                                                Text("Ситуация")
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                                    .opacity(selectedCase == defaultValue ? 0 : 1)
                                                    .offset(y: selectedCase == defaultValue ? 0 : -20)
                                                
                                                Text(selectedCase == defaultValue ? "Ситуация" : "\(mainVM.allCases[selectedCase].caseNameRu)")
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
                                    
                                    // выбор этапа на котором находится ситуация
                                    if selectedCase != defaultValue {
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
                                                        .font(.caption)
                                                        .foregroundColor(.gray)
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
                                            .background(Color("Gray_bg"))
                                            .cornerRadius(12)
                                            .overlay(RoundedRectangle(cornerRadius: 12)
                                                .inset(by: 1)
                                                .stroke(Color(red: 0.94, green: 0.94, blue: 0.94), lineWidth: 2)
                                            )
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                        
                        Divider()
                            .padding(.horizontal, 12)
                            .padding(.bottom, 12)
                        
                        // выбор стаж работы
                        Text("Стаж работы")
                            .font(Font.custom("Open Sans", size: 14))
                            .kerning(0.14)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                            .frame(maxWidth: .infinity, alignment: .top)
                        
                        HStack(alignment: .top) {
                            ForEach(0 ..< workExperiences.count, id: \.self) { index in
                                Button(action: {
                                    withAnimation {
                                        workExperience = index
                                    }
                                }, label: {
                                    VStack{
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(height: 6)
                                            .background(Group {
                                                if workExperience == index { LinearGradient(
                                                    stops: [
                                                        Gradient.Stop(color: Color(red: 0.15, green: 0.32, blue: 0.91), location: 0.00),
                                                        Gradient.Stop(color: Color(red: 0.14, green: 0.33, blue: 0.92), location: 0.05),
                                                        Gradient.Stop(color: Color(red: 0, green: 0.54, blue: 1), location: 1.00),
                                                    ],
                                                    startPoint: UnitPoint(x: 1, y: 0),
                                                    endPoint: UnitPoint(x: 0, y: 1)
                                                )} else { Color(red: 0.94, green: 0.94, blue: 0.94)}
                                            }
                                            )
                                            .cornerRadius(8)
                                        Text("\(workExperiences[index])")
                                            .font(Font.custom("Open Sans", size: 10))
                                            .kerning(0.1)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(nil)
                                            .foregroundColor(Color(red: 0.21, green: 0.21, blue: 0.21))
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                            //.fixedSize(horizontal: false, vertical: true)
                                    }
                                })
                            }
                        }
                        .padding(.horizontal, 12)
                        
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
                                    Text("Населенный пункт")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .opacity(selectedLocation == defaultValue ? 0 : 1)
                                        .offset(y: selectedLocation == defaultValue ? 0 : -20)
                                    
                                    Text(selectedLocation == defaultValue ? "Населенный пункт" : "\(mainVM.allLocations[selectedLocation].valueRu)")
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
                            .padding(.horizontal, 12)
                        }
                        
                        // кнопка сбросить фильтр
                        Button(action: {
                            withAnimation {
                                searchType = "Поиск по специализации"
                                workExperience = 0
                                selectedCase = -1
                                selectedLocation = -1
                                selectedSpecialization = -1
                                selectedStep = -1
                                // to do - add more field
                            }
                        }, label: {
                            Text("Сбросить фильтр")
                                .font(Font.custom("Open Sans", size: 14))
                                .kerning(0.14)
                                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                        })
                        .padding(.vertical, 12)
                        
                        // кнопка принять
                        Button(action: {
                            withAnimation {
                                // to do
                                // получить результаты примерения фильтра
                                
                                self.showFilter.toggle()
                            }
                        }, label: {
                            Text("Принять")
                                .font(Font.custom("Montserrat", size: 14)
                                    .weight(.medium)
                                )
                                .frame(minWidth: 100, maxWidth: .infinity)
                                .padding()
                        })
                        .buttonStyle(MainBlueButtonStyle())
                        .padding(.horizontal, 12)
                    }
                    .background(Color.white)
                    .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        
    }

}

//struct Search_Previews: PreviewProvider {
//    static var previews: some View {
//        Search()
//    }
//}
