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
            HStack(alignment: .top) {
                Text(mainVM.user!.getName())
                    .font(
                    Font.custom("Montserrat", size: 20)
                    .weight(.bold)
                    )
                Spacer()
            }
            .padding(12)
            
            VStack(alignment: .leading) {
                Text("Контактный телефон")
                    .font(Font.custom("Open Sans", size: 12))
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            
                Text(mainVM.user!.getMobile())
                    .font(Font.custom("Open Sans", size: 14))
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(.horizontal, 12)
            
            // проверка есть ли у пользователя email
            // вывод информации если есть
            if let email = mainVM.user!.email {
                VStack(alignment: .leading) {
                    Text("Контактный почта")
                        .font(Font.custom("Open Sans", size: 12))
                        .foregroundColor(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .topLeading)

                    Text("\(mainVM.user!.email!)")
                        .font(Font.custom("Open Sans", size: 14))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .padding(12)
            }
            
            // проверка есть ли у пользователя населенный пункт
            // вывод информации если есть
            if let lovationId = mainVM.user!.locationRefKeyId {
                Divider()
                VStack(alignment: .leading) {
                    Text("Населенный пункт")
                        .font(Font.custom("Open Sans", size: 12))
                        .foregroundColor(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .topLeading)

                    Text("\(mainVM.allLocations.first(where: { $0.refKeyId ==  mainVM.user!.locationRefKeyId})!.valueRu)")
                        .font(Font.custom("Open Sans", size: 14))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .padding(12)
            }
            
            // проверка есть ли у пользователя информаци о себе
            // вывод информации если есть
            if ((mainVM.user!.about?.isEmpty) != nil) {
                Divider()
                VStack(alignment: .leading) {
                    Text("Информация о себе")
                        .font(Font.custom("Open Sans", size: 12))
                        .foregroundColor(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .topLeading)

                    Text(mainVM.user!.about!)
                        .font(Font.custom("Open Sans", size: 14))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .padding(12)
            }
            
        }
        .background(.white)
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
