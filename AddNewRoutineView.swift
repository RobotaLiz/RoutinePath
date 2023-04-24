import Foundation
import SwiftUI


struct AddNewRoutineView : View {
    @StateObject var routineList : RoutineViewModel
    @State var habit = ""
    @State var days = ""
    @State var motivation = ""
    @State var image = ""
    
    var body: some View {
      
        VStack{
                Image("icon")
                
            Spacer()
            
            TextField("image:", text: $image)
                .font(.title2)
                
            TextField("Habit : ", text: $habit)
                .font(.title2)
                
            TextField("Days : ", text: $days)
                .font(.title2)
                
                .keyboardType(.numberPad)
            TextField("Motivation : ", text: $motivation)
                .font(.title2)
                
            Spacer()
            Button("Add Habit  ", action: {
                routineList.add(routine: RoutineModel(habit: habit, motivation: motivation, days: Int(days) ?? 0, image: image))
            })
                .foregroundColor(.white)
                .background(.cyan)
                .cornerRadius(8)
                .padding(-2)
                .font(.title)
        }
        
        
        .toolbar(){
            
            Button("back", action: {routineList.isAdding = false})
        }
        .padding(40)
    }
}
