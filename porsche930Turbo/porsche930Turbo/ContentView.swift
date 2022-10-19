//
//  ContentView.swift
//  porsche930Turbo
//
//  Created by Jalome Chirwa on 2022/10/19.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        return VStack{
            PorscheDetailsPage()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color("PrimaryColor"))
        .edgesIgnoringSafeArea(.all)
        
        
    }
}



struct PorscheDetailsPage: View{
    var body: some View{
        ScrollView{
            DetailsPageTopComponent()
            DetailsPageBottomComponent()
            
        }
        
    }
}


struct DetailsPageBottomComponent: View{
    var body: some View{
        VStack{
            HStack{
                Text("Classic")
                    .foregroundColor(Color.white)
            }
            .frame(width: 90, height: 30,alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            .padding(.top,10)
            
        }
        .frame(width: UIScreen.main.bounds.width,alignment: .leading)
        .padding(.leading,30)
        
        // title and logo
        HStack{
            VStack(alignment: .leading){
                Text("Porsche")
                    .font(.title)
                    .fontWeight(.bold)
                Text("930 turbo")
                    .font(.title)
            }
            Spacer()
            Image("Logo")
                .resizable()
                .frame(width: 77, height: 43)
                .aspectRatio(contentMode: .fit)
                
        }
        .padding(.trailing,30)
        .padding(.leading,30)
        .padding(.top,10)
        .foregroundColor(Color.white)
        
        // car description
        HStack{
            Text("Incredible performance, whilst being comfortable and fully suitable for everyday use.")
                .foregroundColor(Color.white)
                .frame(width: UIScreen.main.bounds.width*0.6)
        }
        .frame(width: UIScreen.main.bounds.width,alignment: .leading)
        .padding(.leading,30)
        .padding(.top,5)
        
        
        Button(action: {
            
        }, label: {
            Text("Preview")
                .foregroundColor(Color("PrimaryColor"))
        })
        .frame(width: UIScreen.main.bounds.width*0.9, height: 60, alignment: .center)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.top,30)

        
        
    }
}


struct DetailsPageTopComponent: View{
    
    private var Highlights: [CarHiglight] = [
        CarHiglight(highlightTitle: "Top speed", text: "246 km/h"),
        CarHiglight(highlightTitle: "80 000 km", text: "Mileage"),
        CarHiglight(highlightTitle: "Manual", text: "Transmission")
    ]
    
    var body: some View{
        ZStack{
            // background image
            Image("Car")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.55)
            
            // right button sections
            VStack(){
                
                Button(action: {
                    
                }, label: {
                    HStack{
                        Image(systemName:"play.fill")
                            .font(.system(size: 21))
                            .foregroundColor(Color.white)
                    }
                    
                    .frame(width: 103, height: 60)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(13)
                })
                
                // render car highlights
                ForEach (0..<self.Highlights.count, id: \.self) { index in
                    VStack(alignment: .center){
                        Text("\(self.Highlights[index].highlightTitle)")
                            .fontWeight(.bold)
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(.bottom,0.05)
                        Text("\(self.Highlights[index].text)")
                            .font(.caption2)
                            .foregroundColor(Color("PrimaryColor"))
                    }
    
                    .frame(width: 103, height: 60)
                    .background(Color.white)
                    .cornerRadius(13)
                    .padding(.top,12)
                }
            
                
            }
            .frame(width: UIScreen.main.bounds.width,alignment:.trailing)
            .padding(.trailing,30)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.55)
        .background(Color.white)
    }
}


struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
