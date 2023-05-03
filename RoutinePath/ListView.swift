

import SwiftUI

struct ListView: View {
    @StateObject var vmodel : RoutineViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(vmodel.list) { model in
                    HStack{
                     
                        
                        HStack{
                            Image(systemName: model.image) 
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(model.habit)
                                .foregroundColor(.black)
                                .font(.callout)
                        }
                        .onTapGesture {
                            vmodel.currentRoutinId = model.id ?? ""
                        }
                        Spacer()
                        
                        HStack{
                            Image(systemName: vmodel.doneNotDone(model: model) ? "checkmark.square.fill" : "square")
                                .resizable()
                                .frame(width: 17, height: 17)
                                .foregroundColor(.orange)
                        }
                        .onTapGesture {
                            vmodel.markDay(model: model)
                        }
                    }
                }
                .listRowBackground(Color.yellow)
            }
            .scrollContentBackground(.hidden)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {vmodel.isAdding = true
                        
                        
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                    
                }
            }
        }
    }
}
