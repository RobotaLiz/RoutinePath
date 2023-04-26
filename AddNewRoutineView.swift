import Foundation
import SwiftUI


struct AddNewRoutineView : View {
    @StateObject var routineList : RoutineViewModel
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
        
                .keyboardType(.numberPad)
            TextField("Motivation : ", text: $motivation)
                .font(.title2)
                
            Spacer()
            Button("Finish  ", action: {
                routineList.add(routine: RoutineModel(habit: habit, motivation: motivation, image: String (""), date: Date()))
            })
                .foregroundColor(.white)
                .background(.cyan)
                .cornerRadius(11)
                .padding(-2)
                .font(.title3)
        }
        
        
        .toolbar(){
            
            Button("back", action: {routineList.isAdding = false})
        }
        .padding(40)
        .foregroundColor(.cyan)
    }
}
