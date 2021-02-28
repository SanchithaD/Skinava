

import SwiftUI

struct AboutUsView: View {
    
    @State var showDetails1 = false
    @State var showDetails2 = false
    @State var showDetails3 = false
    
    var body: some View {
        VStack {
            Text("Frequent Conditions")
                .font(.largeTitle)
                .fontWeight(.thin)
    
                
            Condition(showDetail: $showDetails1, image: "Eczema", text: "Warm Baths                Moisturize twice daily Anti-itch medications")
            
            
            Condition(showDetail: $showDetails2, image: "Keratosis", text: "Apply keratolyic      Exfoliate gently       Lactic acid creams")
            
            Condition(showDetail: $showDetails3, image: "Acne", text: "Apple cider vinegar          Aloe vera lotion   Green tea facemasks")
        } .padding([.top, .leading, .trailing], 20)
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}

struct Condition : View {
    
    @Binding var showDetail : Bool
    
    var image : String
    var text : String
    
    var body : some View {
        return   GeometryReader { geometry in
            HStack {
                Image(self.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width / 2)
                    .cornerRadius(10)
                Spacer()
                
                VStack {
                    
                    HStack {
                        
                        Text(self.image)
                            .font(.title)
                            .fontWeight(.thin)
                            .foregroundColor(Color.purple.opacity(8.8))
                        Button(action: {
                            self.showDetail.toggle()
                        }) {
                            Image(systemName: "chevron.down.circle")
                                .font(.title)
                                .rotationEffect(.degrees(self.showDetail ? 0: -180))
                                .animation(.default)
                        }
                    }.offset(y: self.showDetail ? 0 : geometry.size.height / 10)
                        .animation(.easeInOut(duration: 0.5))
                    Text(self.text)
                        .fontWeight(.thin)
                        .opacity(self.showDetail ? 1 : 0)
                        .animation(Animation.easeInOut(duration: 2).speed(3))
                }.frame(width: geometry.size.width / 2)
            }
        }.navigationBarTitle("Frequent Conditions")
    }
}
