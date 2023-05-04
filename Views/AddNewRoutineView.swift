import Foundation
import SwiftUI


struct AddNewRoutineView : View {
    @StateObject var vModel : RoutineViewModel
    @State var habit = ""
    @State var motivation = ""
    @State var image = ""
    var images = ["figure.run","figure.walk","figure.mind.and.body","figure.strengthtraining.traditional","figure.yoga"]
    
    var body: some View {
        
        VStack{
            
            Image("calender")
                .resizable()
                .frame(width: 150, height: 150)
            
            
            Label("Make your own Habit", systemImage: "sparkles")
            
            Spacer()
    
        HStack {
           Text("Icon :")
                .font(.title2)
                .foregroundColor(.secondary)
                     Picker("choose icon", selection: $image) {
                         ForEach(images, id: \.self) {
                             
                    Image(systemName: $0)
                                
                         }
                     }
                   
                }
        
            TextField("Habit : ", text: $habit)
                .font(.title2)
                .padding(.leading, 111)
            
            Spacer()
            Button("Finish  ", action: {
                vModel.add(routine: RoutineModel(habit: habit,image: image, markedDays: []))
            })
            .foregroundColor(.black)
            .background(.yellow)
            .cornerRadius(11)
            .padding(-2)
            .font(.title3)
            
        }
        .textInputAutocapitalization(.never)
        
        .toolbar(){
            
            Button("back", action: {vModel.isAdding = false})
                .font(.headline)
                .foregroundColor(.black)
            
        }
        .padding(20)
    }
}
