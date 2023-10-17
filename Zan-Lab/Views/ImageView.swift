//
//  IconViewTopSituations.swift
//  Zan-Lab
//
//  Created by Андрей on 04.10.2023.
//

import SwiftUI

struct ImageView: View {
    let url: URL?
    var backupImage: String = "wifi.slash"
    
    var body: some View {
        AsyncImage(
            url: url,
            transaction: Transaction(animation: .easeInOut)
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
            case .failure:
                Image(systemName: backupImage)
                    .resizable()
            @unknown default:
                EmptyView()
            }
            
        }
    }
}

//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageView(url: URL(string: "https://www.graphicpie.com/wp-content/uploads/2020/11/red-among-us-png-842x1024.png")!)
//    }
//}
