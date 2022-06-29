//
//  WrapView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 8/6/22.
//

import SwiftUI

struct WrapView: View {

    let colorLine: Color = .green
    
    let items: [String]
    private var groupedItems: [[String]] = [[]]
    private let screenWidth = UIScreen.main.bounds.width
    
    init(items: [String]) {
        self.items = items
        self.groupedItems = createGroupedItems(items)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(groupedItems, id: \.self) { subItems in
                HStack{
                    ForEach(subItems, id: \.self) { word in
                        Text(word)
                            .font(.system(size: 10, weight: .regular, design: .rounded))
                            .textCase(.uppercase)
                            .padding(5)
                            .frame(width: 40, height: 20)
                            .background{
                                switch word{
                                case "C-1":
                                    Color.C1
                                case "C-2":
                                    Color.C2
                                case "C-3":
                                    Color.C3
                                case "C-3A", "C-3B":
                                    Color.C3AB
                                case "C-4":
                                    Color.C4
                                case "C-5":
                                    Color.C5
                                case "C-7":
                                    Color.C7
                                case "C-8":
                                    Color.C8
                                case "C-9":
                                    Color.C9
                                case "C-10":
                                    Color.C10
                                default:
                                    Color.greenBus
                                }}
                            .cornerRadius(5)
                    }
                }
            }
        }
    }
    
    private func createGroupedItems(_ items: [String]) -> [[String]] {
        var groupedItems: [[String]] = [[]]
        var tempItems: [String] = []
        var width: CGFloat = 0
        
        items.forEach { word in
            let label = UILabel()
            label.text = word
            label.sizeToFit()
        
        let labelWidth = label.frame.size.width + 32
        
        if (width + labelWidth + 32) < screenWidth {
            width += labelWidth
            tempItems.append(word)
        } else{
            width = labelWidth
            if !tempItems.isEmpty {
                groupedItems.append(tempItems)
            }
            tempItems.removeAll()
            tempItems.append(word)
        }
        }
        groupedItems.append(tempItems)
        return groupedItems
    }

}

struct WrapView_Previews: PreviewProvider {
    static var previews: some View {
        WrapView(items: ["620","C-1","C-2","C-3","C-4","C-5","626","C-7","C-8","C-9","561a","561B", "C-10", "C-3A", "C-3B"])
    }
}

extension Color {
    static let greenBus = Color("greenBus")
    static let redTrain = Color("redTrain")
    static let C1 = Color("C-1")
    static let C2 = Color("C-2")
    static let C3 = Color("C-3")
    static let C3AB = Color("C-3AB")
    static let C4 = Color("C-4")
    static let C5 = Color("C-5")
    static let C7 = Color("C-7")
    static let C8 = Color("C-8")
    static let C9 = Color("C-9")
    static let C10 = Color("C-10")
    static let CellMapView = Color("CellMapView")
}
