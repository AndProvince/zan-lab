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
                .font(.largeTitle)
                .padding()
            
            Text("Вы можете разместить инфрмацию о случившемся у нас на сервисе, а мы постараемся как можно быстрее найти для вас эксперта, который сможет помочь в решении ваших проблем.")
                .font(.body)
                .padding()
            
            Button(action: { self.tabSelection = 3 }, label: {
                Text("Создай своё обращение")
                    .font(.title2)
                    .frame(minWidth: 100, maxWidth: .infinity)
                    .padding()
            })
            .buttonStyle(MainBlueButtonStyle())
            .padding()
            
            Text("Подробную информацию о работе обращений вы можете узнать в разделе частых вопросов")
                .font(.body)
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
