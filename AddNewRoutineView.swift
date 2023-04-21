import Foundation
import SwiftUI


struct AddNewRoutineView : View {
    @StateObject var routineList : RoutineViewModel
    @State var habit = ""
    @State var days = ""
    @State var motivation = ""
    
    var body: some View {
        VStack{
           
            TextField("Habit : ", text: $habit)
                .font(.title)
            TextField("Days : ", text: $days)
                .font(.title)
                .keyboardType(.numberPad)
            TextField("Motivation : ", text: $motivation)
                .font(.title)
          Spacer()
            Button("Add Habit  ", action: {
                routineList.add()
            })
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(8)
                .padding(-2)
                .font(.title)
        }
        .padding(.top, 230)
        .padding(.bottom, 40)
    }
}
