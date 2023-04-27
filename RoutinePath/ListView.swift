

import SwiftUI

struct ListView: View {
    @StateObject var routineList : RoutineViewModel
    
    
    var body: some View {
        VStack {
            List {
                ForEach(routineList.list) { model in
                    HStack{
                     
                        
                        HStack{
                            Image(model.image)
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(model.habit)
                                .foregroundColor(.cyan)
                                .font(.callout)
                        }
                        .onTapGesture {
                            routineList.currentRoutinId = model.id ?? ""
                        }
                        Spacer()
                        
                        HStack{
                            Image( routineList.doneNotDone(model: model) ? "fullBlue" : "whiteCirkel")
                                .resizable()
                                .frame(width: 17, height: 17)
                        }
                        .onTapGesture {
                            routineList.markDay(model: model)
                        }
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {routineList.isAdding = true
                        
                        
                    }
                    .foregroundColor(.cyan)
                    
                }
            }
        }
    }
}
