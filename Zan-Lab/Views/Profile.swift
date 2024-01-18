//
//  Profile.swift
//  Zan-Lab
//
//  Created by Андрей on 05.10.2023.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        VStack(alignment: .leading) {            
            ScrollView {
                // вывод аваратки и меню по ее изменению
                Section {
                    Menu {
                        Button(action: { },
                               label: {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                            Text("Изменить фото")
                        })
                        
                        Button(action: {}
                               , label: {
                            Image(systemName: "trash")
                            Text("Удалить фото")
                        })
                        
                    } label: {
                        ImageView(url: mainVM.user?.getImageURL(), backupImage: "person")
                            //.foregroundColor(.clear)
                            .frame(width: 296, height: 304)
                            .background(Color("Gray_bg"))
                            .cornerRadius(12.0)
                            .scaledToFill()
                            .padding()
                    }
                }
                
                if mainVM.showEditProfile {
                    ProfileEdit()
                } else {
                    ProfileView()
                }
            }
        }
        .background(Color("zlGray"))
        .navigationTitle(mainVM.user!.getName())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: { mainVM.showEditProfile.toggle() },
                       label: { Text(mainVM.showEditProfile ? "Отмена" : "Редактировать") })
            }
            
        }
    }
}

//struct Profile_Previews: PreviewProvider {
//    static var previews: some View {
//        Profile()
//    }
//}
