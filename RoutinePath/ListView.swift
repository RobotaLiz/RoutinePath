

import SwiftUI

struct ListView: View {
    @StateObject var vmodel : RoutineViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(vmodel.list) { model in
                    HStack{
                     
                        
                        HStack{
                            Image(model.image)
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(model.habit)
                                .foregroundColor(.blue)
                                .font(.callout)
                        }
                        .onTapGesture {
                            vmodel.currentRoutinId = model.id ?? ""
                        }
                        Spacer()
                        
                        HStack{
                            Image( vmodel.doneNotDone(model: model) ? "fullBlue" : "whiteCirkel")
                                .resizable()
                                .frame(width: 17, height: 17)
                        }
                        .onTapGesture {
                            vmodel.markDay(model: model)
                        }
                    }
                }
                .listRowBackground(Color.orange)
            }
            .scrollContentBackground(.hidden)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {vmodel.isAdding = true
                        
                        
                    }
                    .foregroundColor(.blue)
                    .font(.headline)
                    
                }
            }
        }
    }
}
