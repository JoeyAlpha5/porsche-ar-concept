//
//  ContentView.swift
//  PorscheAR
//
//  Created by Jalome Chirwa on 2022/10/22.
//

import SwiftUI
import ARKit
import RealityKit

struct ContentView : View {
    
    @StateObject var arSettings = ARSteetings()
    
    var body: some View {
        return ZStack(alignment: .topLeading){
            
            if arSettings.previewVehicle{
                // render AR model
                ARViewContainer(arSettings: arSettings)
                Button(action: {
                        
                    arSettings.previewVehicle = false
                    
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.black)
                        .font(.title)
                })
                .frame(width: 103, height: 60)
                .background(Color.white)
                .cornerRadius(13)
                .padding(.top, 60)
                .padding(.leading,30)
            }
            else{
                VehicleDetails(arSettings: arSettings)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("PrimaryColor"))
        .edgesIgnoringSafeArea(.all)
    }
}




// porsche details page
struct VehicleDetails: View{
    
    @ObservedObject var arSettings: ARSteetings
    
    var body: some View{
        VStack{
            ScrollView{
                VehicleDetailsTopSection(arSettings: arSettings)
                VehicleDetailsBottomSection()
            }
        }
    }
}




// vehicle details bottom section
struct VehicleDetailsBottomSection: View{
    var body: some View{
        VStack{
            HStack{
                Text("Classic")
                    .foregroundColor(Color.white)
            }
            .frame(width: 90, height: 30, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.white.opacity(0.5),lineWidth: 1)
            )
            .padding(.top,15)
        }
        .frame(width: UIScreen.main.bounds.width*0.9,alignment: .leading)
        
        
        HStack{
            VStack(alignment: .leading){
                Text("Porsche")
                    .font(.title)
                    .fontWeight(.bold)
                Text("930 turbo")
                    .font(.title)
            }
            .foregroundColor(Color.white)
            .padding(.top,10)
            Spacer()
            Image("Logo")
                .resizable()
                .frame(width: 77, height: 43)
                .aspectRatio(contentMode: .fit)
        }
        .frame(width: UIScreen.main.bounds.width*0.9, alignment: .center)
        
        
        HStack{
            Text("Incredible performance, whilst being comfortable and fully suitable for everyday use.")
                .foregroundColor(Color.white)
                .frame(width: UIScreen.main.bounds.width*0.6, alignment: .leading)
        }
        .frame(width: UIScreen.main.bounds.width*0.9, alignment: .leading)
        .padding(.top,0.05)
        
        
        Button(action: {
            
        }, label: {
            Text("Preview")
        })
        .frame(width: UIScreen.main.bounds.width*0.9, height: 60, alignment: .center)
        .foregroundColor(Color.black)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.top,10)
       
    }
}

// vehicle details top section
struct VehicleDetailsTopSection: View{
    
    @ObservedObject var arSettings: ARSteetings
    
    var carHighlights: [CarHighlight] = [
        CarHighlight(highlightTitle: "246 km/h", text: "Top speed"),
        CarHighlight(highlightTitle: "80 000 km", text: "Mileage"),
        CarHighlight(highlightTitle: "Manual", text: "Transmission"),
    ]
    
    
    var body: some View{
        ZStack{
            Image("Car")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.55)
                .cornerRadius(30)
            
            VStack{
                // preview button
                Button(action: {
                        
                    arSettings.previewVehicle = true
                    
                }, label: {
                    Image(systemName: "play.fill")
                        .foregroundColor(Color.white)
                        .font(.title)
                })
                .frame(width: 103, height: 60, alignment: .center)
                .background(Color("PrimaryColor"))
                .cornerRadius(13)
                
                
                // display car highlights
                ForEach(0..<self.carHighlights.count, id:\.self){ index in
                    VStack{
                        Text("\(carHighlights[index].highlightTitle)")
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                        Text("\(carHighlights[index].text)")
                            .font(.caption2)
                            .foregroundColor(Color.black)
                    }
                    .frame(width: 103, height: 60, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(13)
                    .padding(.top,12)
                    
                }
                
            }
            .frame(width: UIScreen.main.bounds.width, alignment:.trailing)
            .padding(.trailing,30)

                
        }
    }
}


struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var arSettings: ARSteetings
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // create AR tracking config
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        arView.session.run(config)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
//        let modelName = "Porsche_911_930_Turbo_1975.usdz"
        // get the object
        let fileName = "FREE_1975_Porsche_911_930_Turbo.usdz"
        let modelEntity = try! ModelEntity.loadModel(named: fileName)

        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(modelEntity)

        uiView.scene.addAnchor(anchorEntity)
        
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
