import Foundation
import SwiftUI


struct AddNewRoutineView : View {
    @StateObject var vModel : RoutineViewModel
    @State var habit = ""
    @State var motivation = ""
    @State var image = ""
    
    var body: some View {
      
        VStack{
           
            Image("habitIcon")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
            
            Label("Make your own Habit", systemImage: "sparkles")
                
            Spacer()
            
            TextField("image:", text: $image)
                .font(.title2)
               
            TextField("Habit : ", text: $habit)
                .font(.title2)
        
            Spacer()
            Button("Finish  ", action: {
                vModel.add(routine: RoutineModel(habit: habit,image: image, markedDays: []))
            })
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(11)
                .padding(-2)
                .font(.title3)
            
        }
        .textInputAutocapitalization(.never)
        
        .toolbar(){
            
            Button("back", action: {vModel.isAdding = false})
                .font(.headline)
               
        }
        .padding(20)
    }
}
