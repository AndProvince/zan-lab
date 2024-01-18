//
//  AboutRequests.swift
//  Zan-Lab
//
//  Created by Андрей on 24.09.2023.
//

import SwiftUI

struct AboutRequests: View {
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Обращения от пользователей")
                .font(
                Font.custom("Montserrat", size: 24)
                .weight(.bold)
                )
                .padding()
            
            Text("Вы можете разместить инфрмацию о случившемся у нас на сервисе, а мы постараемся как можно быстрее найти для вас эксперта, который сможет помочь в решении ваших проблем.")
                .font(Font.custom("Open Sans", size: 14))
                .kerning(0.14)
                .padding()
            
            Button(action: { self.tabSelection = 3 }, label: {
                Text("Создай своё обращение")
                    .font(
                    Font.custom("Montserrat", size: 14)
                    .weight(.medium)
                    )
                    .frame(minWidth: 100, maxWidth: .infinity)
                    .padding()
            })
            .buttonStyle(MainBlueButtonStyle())
            .padding()
            
            Text("Подробную информацию о работе обращений вы можете узнать в разделе частых вопросов")
                .font(Font.custom("Open Sans", size: 14))
                .kerning(0.14)
                .foregroundColor(Color.gray)
                .padding()
            
        }
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

//struct AboutRequests_Previews: PreviewProvider {
//    static var previews: some View {
//        AboutRequests()
//    }
//}
