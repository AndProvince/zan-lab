//
//  SpecialiststList.swift
//  Zan-Lab
//
//  Created by Андрей on 03.10.2023.
//

import SwiftUI

struct SpecialiststList: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        NavigationView {
            List(mainVM.specialists, id: \.person.id) { spec in
                NavigationLink(destination: {
                    Text("Детальная информация")
                }, label: {
                    VStack {
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 60, height: 60)
                            VStack{
                                Text(spec.person.lastName)
                                Text(spec.person.firstName)
                            }
                        }
                    }
                })
            }
        }
        .onAppear {
            if mainVM.specialists.isEmpty {
                mainVM.getSpecialists()
            }
        }
        
    }
}

//struct SpecialiststList_Previews: PreviewProvider {
//    static var previews: some View {
//        SpecialiststList()
//    }
//}
