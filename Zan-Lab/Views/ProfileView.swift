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
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            ImageView(url: mainVM.user?.getImageURL(), backupImage: "person")
        }
        .frame(width: 296, height: 304)
        .background(Color("Gray_bg"))
        .cornerRadius(12.0)
        .scaledToFill()
        .padding()
        
        VStack(alignment: .leading) {
            
            HStack(alignment: .top) {
                Text(mainVM.user!.getName())
                    .font(
                    Font.custom("Montserrat", size: 20)
                    .weight(.bold)
                    )
                Spacer()
            }
            .padding(.bottom, 24)
            
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
            .padding(.bottom, 12)
            
            // проверка есть ли у пользователя email
            // вывод информации если есть
            if mainVM.user!.email != nil {
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
                .padding(.bottom, 12)
            }
            
            // проверка есть ли у пользователя населенный пункт
            // вывод информации если есть
            if mainVM.user!.locationRefKeyId != nil {
                Divider()
                    .padding(.bottom, 12)
                
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
                .padding(.bottom, 12)
            }
            
            // проверка есть ли у пользователя информаци о себе
            // вывод информации если есть
            if let about = mainVM.user!.about, !about.isEmpty {
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
            }
            
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 24)
        .background(.white)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke(Color.white, lineWidth: 1)
        )
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
