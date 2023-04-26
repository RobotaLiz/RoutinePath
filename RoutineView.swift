import Foundation
import SwiftUI


struct RoutineView : View {
    @Environment(\.presentationMode) var presentationMode
    @State var model : RoutineModel
    @State var vModel : RoutineViewModel
    @State var dates : Set<DateComponents> = []
    
    var body: some View {
        NavigationView {
            VStack{
                
              Image(model.image)
                .resizable()
            .frame(width: 50, height: 50)
                Text(model.habit)
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding()
                MultiDatePicker("Days", selection: $dates, in: Date.now...)
                    .frame(height: 300)
                
                    .padding()
                
                TextField(model.motivation, text: $model.motivation)
                      Spacer()
                
            }
            
        }
        .navigationBarItems(leading:  Button("Back") {
            vModel.currentRoutinId = ""
        })
       Button(action: {
            vModel.DeleteRoutine(Routine: model)
        }, label: {
            Image(systemName: "trash")
                .foregroundColor(.red)
        })
    }
}
