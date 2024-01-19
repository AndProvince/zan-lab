//
//  TopSituations.swift
//  Zan-Lab
//
//  Created by Андрей on 24.09.2023.
//

import SwiftUI

struct GridStact<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows) {row in
                HStack {
                    ForEach(0 ..< self.columns) {column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

struct TopSituations: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Text("Частые ситуации")
                .font(
                Font.custom("Montserrat", size: 24)
                .weight(.bold)
                )
                .padding(.leading, 12)
            
            withAnimation {
                ScrollView(.horizontal){
                    if !mainVM.topCases.isEmpty {
                        GridStact(rows: 3, columns: 3) { row, col in
                            Button(action: { }) {
                                HStack(alignment: .center, spacing: 12){
                                    ImageView(url: mainVM.topCases[row*3+col].caseInfo.files.first?.getImageURL())
                                        .frame(width: 18, height: 18)
                                    Text(mainVM.topCases[row*3+col].caseInfo.caseNameRu)
                                        .font(
                                        Font.custom("Montserrat", size: 14)
                                        .weight(.semibold)
                                        )
                                }
                                .padding(12)
                                .frame(width: 264, height: 83, alignment: .leading)
                            }
                            .buttonStyle(TopSituationButtonStyle())
                        }
                        .padding([.bottom, .horizontal], 12)
                    } else {
                        ProgressView()
                            //.padding(.bottom)
                    }
                }
                .shadow(radius: 5)
                .onAppear {
                    if mainVM.topCases.isEmpty {
                        mainVM.getTopCases()
                    }
                }
            }
        }
        .background(Color("Gray_bg"))
    }
}

//struct TopSituations_Previews: PreviewProvider {
//    static var previews: some View {
//        TopSituations()
//    }
//}
