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
    
    @State private var specializationSearch = true
    @State private var showFilter = false
    
    @State private var workExperience = 0
    let workExperiences = ["Любой", "Менее 1 года", "От 1 до 3 лет", "От 3 до 5 лет", "От 5 до 10 лет", "Более 10 лет"]
    
    @State private var selectedCase = 0
    @State private var selectedLocation = 0
    @State private var selectedSpecialization = 0
    
    private var defaultValues: Bool {
        return workExperience == 0 && selectedCase == 0 && selectedLocation == 0 && selectedSpecialization == 0
    }
    
    var body: some View {
        HStack{
            Button(action: {
                withAnimation {
                    self.showFilter.toggle()
                }
            }, label: {
                Image(systemName: self.showFilter ? "line.3.horizontal.decrease.circle" : "line.3.horizontal.decrease.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(self.defaultValues ? Color.gray : Color.blue)
            })
            .padding(.trailing)
            
            // Поле поиска
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("Поиск", text: $searchQuery)
            }
            .padding([.leading, .vertical])
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
                .shadow(radius: 20))
        }
        .padding(.horizontal)
        
        Divider()
        
        if self.showFilter {
            // Переключатель типа поиска
            HStack{
                Button(action: {
                    self.specializationSearch.toggle()
                }, label: {
                    if self.specializationSearch {
                        Text("Поиск по специализации")
                        Spacer()
                        Text(">")
                        //Image(systemName: "greaterthan")
                    } else {
                        Text("<")
                        //Image(systemName: "lessthan")
                        Spacer()
                        Text("Поиск по ситуациям")
                    }
                    
                })
                .foregroundColor(.black)
            }
            .padding()
            
            // выбора ситуации или специализации
            HStack{
                if self.specializationSearch {
                    HStack {
                        Picker("Ситуация", selection: $selectedCase) {
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
                } else {
                    HStack {
                        Picker("Специализация", selection: $selectedSpecialization) {
                            ForEach(0 ..< mainVM.allSpecializations.count) { index in
                                Text("\(mainVM.allSpecializations[index].valueRu)")
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
                }
            }
            .padding(.horizontal)
            
            // выбор стаж работы
            HStack {
                Picker("Стаж работы", selection: $workExperience) {
                    ForEach(0 ..< workExperiences.count) { index in
                        Text("\(workExperiences[index])")
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
            .padding(.horizontal)
            
            // выбор населенного пункта
            HStack {
                Picker("Населенный пункт", selection: $selectedLocation) {
                    ForEach(0 ..< mainVM.allLocations.count) { index in
                        Text("\(mainVM.allLocations[index].valueRu)")
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
            .padding(.horizontal)
            
            // кнопка сбросить фильтр
            HStack(alignment: .center) {
                Button(action: {
                    withAnimation {
                        specializationSearch = true
                        workExperience = 0
                        selectedCase = 0
                        selectedLocation = 0
                        // to do - add more field
                    }
                }, label: {
                    Text("Сбросить фильтр")
                        .foregroundColor(.black)
                })
                .frame(maxWidth: .infinity)
            }
            
            // кнопка принять
            Button(action: {
                withAnimation {
                    // to do
                    // получить результаты примерения фильтра
                    
                    self.showFilter.toggle()
                }
            }, label: {
                Text("Принять")
                    .font(.title2)
                    .frame(minWidth: 100, maxWidth: .infinity)
                    .padding()
            })
            .buttonStyle(MainBlueButtonStyle())
            .padding()
        }
        
        // вывод специалистов
        List(mainVM.specialists, id: \.person.id) { specialist in
            NavigationLink(destination: {
                Text("Детальная информация")
            }, label: {
                VStack {
                    HStack {
                        ImageView(url: specialist.person.getImageURL(), backupImage: "person")
                            .frame(width: 60, height: 60)
                            .cornerRadius(12.0)
                            .padding(.trailing)
                        VStack(alignment: .leading){
                            Text(specialist.person.lastName ?? "")
                            Text(specialist.person.firstName ?? "")
                        }
                    }
                }
            })
        }
    }

}

//struct Search_Previews: PreviewProvider {
//    static var previews: some View {
//        Search()
//    }
//}
