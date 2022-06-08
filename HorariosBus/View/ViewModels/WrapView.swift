//
//  WrapView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 8/6/22.
//

import SwiftUI

struct WrapView: View {
    
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
                            .padding(5)
                            .frame(width: 35, height: 20)
                            .background(.green)
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
        WrapView(items: ["620","621","622","623","624","625","626","627","628","629","561A","561B"])
    }
}

