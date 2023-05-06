//
//  MenuCellView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba on 5/5/23.
//

import SwiftUI

struct SideMenuCellView: View {
    
    @State var boolean: Bool
    @State var image: String
    @State var imageColor: Color
    @State var imageBackgroundColor: Color
    @State var name: String
    @State var view: AnyView
    
    
    var body: some View {
        ZStack{
            HStack{
                Image(systemName: image)
                    .foregroundColor(imageColor)
                    .padding(6)
                    .frame(width: 26, height: 26)
                    .background(imageBackgroundColor)
                    .cornerRadius(13)
                Text(name)
                Spacer()
                Image(systemName: "chevron.forward")
            }
            .padding()
            .onTapGesture {
                self.boolean.toggle()
            }
            NavigationLink("", destination: view, isActive: $boolean)
                .hidden()
        }
    }
}

struct MenuCellView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuCellView(boolean: false, image: "star.fill", imageColor: Color.yellow, imageBackgroundColor: Color.clear, name: "Paradas favoritas", view: AnyView(FavoriteStopsView()))
    }
}
