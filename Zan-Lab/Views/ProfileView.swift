//
//  ProfileView.swift
//  Zan-Lab
//
//  Created by Андрей on 06.10.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(mainVM.user!.getName())
                    .font(.title)
                Spacer()
            }
            .padding()
            .background(.white)
            
            VStack(alignment: .leading) {
                Text("Контактный телефон")
                    .font(.caption)
            
                Text(mainVM.user!.getMobile())
            }
            .padding()
            
            // проверка есть ли у пользователя email
            // вывод информации если есть
            if ((mainVM.user!.email?.isEmpty) != nil) {
                VStack(alignment: .leading) {
                    Text("Контактный почта")
                        .font(.caption)

                    Text("\(mainVM.user!.email!)")
                }
                .padding()
            }
            
            // проверка есть ли у пользователя населенный пункт
            // вывод информации если есть
            if (mainVM.user!.locationRefKeyId != nil) {
                VStack(alignment: .leading) {
                    Text("Населенный пункт")
                        .font(.caption)

                    Text("\(mainVM.allLocations.first(where: { $0.refKeyId ==  mainVM.user!.locationRefKeyId})!.valueRu)")
                }
                .padding()
            }
            
            // проверка есть ли у пользователя информаци о себе
            // вывод информации если есть
            if ((mainVM.user!.about?.isEmpty) != nil) {
                VStack(alignment: .leading) {
                    Text("Информация о себе")
                        .font(.caption)

                    Text(mainVM.user!.about!)
                }
                .padding()
            }
            
        }
        //.padding()
        .background(.white)
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
