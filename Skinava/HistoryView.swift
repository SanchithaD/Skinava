

import SwiftUI

struct HistoryView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.purple
    }
    
    @State var selected = 3
    
    var body: some View {
        TabView(selection: $selected) {
            AppsView().tabItem({
                Image(systemName: Constants.TabBarImageName.tabBar0)
                    .font(.title)
                Text("\(Constants.TabBarText.tabBar0)")
            }).tag(0)
            
            AboutUsView().tabItem({
                Image(systemName: Constants.TabBarImageName.tabBar1)
                    .font(.title)
                Text("\(Constants.TabBarText.tabBar1)")
            }).tag(1)
            
        }.accentColor(Color.purple.opacity(0.8))
    }
}

