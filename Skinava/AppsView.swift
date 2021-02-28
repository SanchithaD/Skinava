

import SwiftUI



struct AppsView: View {
    @State var condition = "bumps"
    @State var texture = "cracked"
    @State var color = "other"
    @State var area = "other"
    
    var body: some View {
        ScrollView {
        VStack{
            Image("logo2")
                .padding(.top)
                .padding(.bottom)
                .frame(width: 50.0)
                
            Text("Type of Condition")
                .font(.title)
                .fontWeight(.thin)
                .padding(.top, 4.0)
                .padding(.bottom)
                

            HStack{
        
                Button(action: {
                    self.condition = "bumps"
                }) {
                    Text("Bumps").fontWeight(.thin).foregroundColor(Color.black).frame(width: 100, height: 50).background(
                        Color.purple.opacity(0.4)
                            
                            .cornerRadius(20)
                    )
                }
                
                Button(action: {
                    self.condition = "patches"
                }) {
                    Text("Patches").fontWeight(.thin).foregroundColor(Color.black).frame(width: 100, height: 50).background(
                        Color.purple.opacity(0.4)
                            
                            .cornerRadius(20)
                    )
                }
                
                Button(action: {
                    self.condition = "singular patch"
                }) {
                    Text("Singular patch").fontWeight(.thin).foregroundColor(Color.black).frame(width: 100, height: 50).background(
                        Color.purple.opacity(0.4)
                            
                            .cornerRadius(20)
                    )
                }
    
    }
            .padding(.bottom)
            
            Text("Texture of Condition")
                .font(.title)
                .fontWeight(.thin)
                .padding(.top)
                .padding(.bottom)
            HStack{
            
                Button(action: {
                    self.texture = "dry"
                }) {
                    Text("Dry").fontWeight(.thin).foregroundColor(Color.black).frame(width: 100, height: 50).background(
                        Color.purple.opacity(0.4)
                            
                            .cornerRadius(20)
                    )
                }
                               
                Button(action: {
                    self.texture = "swollen"
                }) {
                    Text("Swollen").fontWeight(.thin).foregroundColor(Color.black).frame(width: 100, height: 50).background(
                        Color.purple.opacity(0.4)
                            
                            .cornerRadius(20)
                    )
                }
                               
                Button(action: {
                    self.texture = "cracked"
                }) {
                    Text("Cracked").fontWeight(.thin).foregroundColor(Color.black).frame(width: 100, height: 50).background(
                        Color.purple.opacity(0.4)
                            
                            .cornerRadius(20)
                    )
                }
                
        }
            
            Text("Color of Condition")
                .font(.title)
                .fontWeight(.thin)
                .padding(.top)
                .padding(.bottom)
            HStack {
                Button(action: {
                    self.color = "red"
                }) {
                    Text("Red").fontWeight(.thin).foregroundColor(Color.black).frame(width: 100, height: 50).background(
                        Color.purple.opacity(0.4)
                            
                            .cornerRadius(20)
                    )
                }
                                              
                Button(action: {
                    self.color = "brown"
                }) {
                    Text("Brown").fontWeight(.thin).foregroundColor(Color.black).frame(width: 100, height: 50).background(
                        Color.purple.opacity(0.4)
                            
                            .cornerRadius(20)
                    )
                }
                                              
                Button(action: {
                    self.color = "other"
                }) {
                    Text("Other").fontWeight(.thin).foregroundColor(Color.black).frame(width: 100, height: 50).background(
                        Color.purple.opacity(0.4)
                            
                            .cornerRadius(20)
                    )
                }
                
        }
            Text("Affected Area")
                .font(.title)
                .fontWeight(.thin)
                .padding(.top)
                .padding(.bottom)
            HStack {
                Button(action: {
                    self.area = "face"
                }) {
                    Text("Face").fontWeight(.thin).foregroundColor(Color.black).frame(width: 100, height: 50).background(
                        Color.purple.opacity(0.4)
                            
                            .cornerRadius(20)
                    )
                }
                                                     
                Button(action: {
                    self.area = "leg/arm"
                }) {
                    Text("Leg/Arm").fontWeight(.thin).foregroundColor(Color.black).frame(width: 100, height: 50).background(
                        Color.purple.opacity(0.4)
                            
                            .cornerRadius(20)
                    )
                }
                                                     
                Button(action: {
                    self.area = "other"
                }) {
                    Text("Other").fontWeight(.thin).foregroundColor(Color.black).frame(width: 100, height: 50).background(
                        Color.purple.opacity(0.4)
                            
                            .cornerRadius(20)
                    )
                }
                       
        }
            
            
            
            if  self.area == "leg/arm" && self.condition == "bumps" && self.texture == "dry" && self.color == "brown"{
                
                Text("Possibility of Keratosis")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.top, 50.0)
                       
                
            } else if self.area == "face" && self.condition == "bumps" && self.color == "red"{
                
                Text("Possibility of Acne").font(.largeTitle)
                                   .fontWeight(.semibold)
                                   .padding(.top, 50.0)
               
                   
                
            } else if self.color == "red" && self.condition == "patches" && self.texture == "dry"{
            
                Text("Possibility of Eczema") .font(.largeTitle)
                                   .fontWeight(.semibold)
                                   .padding(.top, 50.0)
        
            } else {
                
                Text("No match found yet")
                    .fontWeight(.thin)
                    .padding(.top, 50.0)
    }
    }
        }
}
}

struct AppsView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
    }
}

