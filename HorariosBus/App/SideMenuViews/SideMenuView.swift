//
//  MenuView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba on 5/5/23.
//

import SwiftUI

struct SideMenuView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var isFavorite = false
    @State var isInterBus = false
    @State var isTrein = false
    
    @State var width: Double = UIScreen.main.bounds.width/1.6
    
    @Binding var isShowingSideMenu: Bool
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.25))
            .opacity(isShowingSideMenu ? 1 : 0)
            .animation(.easeIn.delay(0.25), value: isShowingSideMenu)
            .onTapGesture {
                isShowingSideMenu.toggle()
            }

            VStack(alignment: .leading, spacing: 0) {
                SideMenuCellView(boolean: isFavorite, image: "star.fill", imageColor: .yellow, imageBackgroundColor: .clear, name: "Paradas favoritas", view: AnyView(FavoriteStopsView()))
                    .padding(.top, 90)
                SideMenuCellView(boolean: isInterBus, image: "bus.fill", imageColor: .black, imageBackgroundColor: .greenBus, name: "Autobuses interurbanos", view: AnyView(SearchBusStopView(searchTextNumberStop: "")))
                SideMenuCellView(boolean: isTrein, image: "tram.fill", imageColor: .black, imageBackgroundColor: .redTrain, name: "Cercanías", view: AnyView(SearchTrainStopView()))
                
                Spacer()
            
            }
            .background(Color.backgrounColor)
            .cornerRadius(25)
            .ignoresSafeArea()
            .padding(.trailing, UIScreen.main.bounds.width - width)
            .offset(x: isShowingSideMenu ? 0 : -width)
            .animation(.default, value: isShowingSideMenu)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowingSideMenu: .constant(true))
    }
}
