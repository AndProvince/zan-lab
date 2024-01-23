//
//  ContentView.swift
//  Zan-Lab
//
//  Created by Андрей on 24.09.2023.
//

import SwiftUI

enum NavView {
    case register, login
}

struct ContentView: View {
    
    @StateObject var mainVM = MainViewModel()
    
    @State private var tabSelection = 1
    
    @State private var path: [NavView] = []
    
    var body: some View {
        NavigationStack(path: $path){
            VStack(alignment: .leading){
                // Верхнее меню не скроллится и не входит в табы
                HStack{
                    TopMenu(path: $path)
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
            .background(Color("Gray_bg"))
            .navigationDestination(for: NavView.self) { view in
                switch view {
                case .register: Registration(path: $path)
                case .login: Login(path: $path)
                }
            }
            .navigationDestination(isPresented: $mainVM.showProfile) { Profile() }
        }
        .background(Color("Gray_bg"))
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
