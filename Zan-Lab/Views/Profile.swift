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
                if mainVM.showEditProfile {
                    ProfileEdit()
                } else {
                    ProfileView()
                }
            }
        }
        .background(Color("Gray_bg"))
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
