//
//  ContentView.swift
//  Zan-Lab
//
//  Created by Андрей on 24.09.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var mainVM = MainViewModel()
    
    @State private var tabSelection = 1
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                // Верхнее меню не скроллится и не входит в табы
                HStack{
                    TopMenu()
                }
                
                // Делитель на табы снизу
                TabView(selection: $tabSelection) {
                    // Главная страница
                    ScrollView{
                        TopSituations()
                        AboutRequests(tabSelection: $tabSelection)
                    }
                    .background(Color("Gray_bg"))
                    .tabItem(){
                        Image(systemName: "house")
                        Text("Главная")
                    }
                    .tag(1)
                    
                    // Поиск
                    VStack{
                        Search()
                    }
                    .tabItem(){
                        Image(systemName: "magnifyingglass")
                        Text("Поиск")
                    }
                    .tag(2)
                    
                    // Создать обращение
                    VStack{
                        CreateRequest()
                    }
                    .tabItem(){
                        Image(systemName: "plus.message")
                        Text("Обращение")
                    }
                    .tag(3)
                    
                    // Настройки
                    VStack{
                        Text("ZAN-LAB")
                            .font(.title)
                            .foregroundColor(Color.gray)
                    }
                    .tabItem(){
                        Image(systemName: "slider.horizontal.3")
                        Text("Меню")
                    }
                    .tag(4)
                }
            }
            .background(Color("zlGray"))
            .background(
                Group {
                    NavigationLink(destination: Profile(), isActive: $mainVM.showProfile) { EmptyView() }
                }
            )
        }
        .background(Color("zlGray"))
        .edgesIgnoringSafeArea(.all)
        .environmentObject(mainVM)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
