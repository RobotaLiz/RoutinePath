import SwiftUI
import FirebaseCore
import Firebase


struct ContentView: View {
    @State var test = false
    
    let db = Firestore.firestore()
    @StateObject var routineList = RoutineViewModel()
    var body: some View {
        NavigationView {
            if(routineList.isAdding) {
                AddNewRoutineView(routineList: routineList)
                
            }
            else if routineList.currentRoutinId != "" {
                RoutineView(model: routineList.pickUpModel(id: routineList.currentRoutinId), vModel: routineList)
            }
            else{
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
                                    Image( test ? "whiteCirkel" : "fullBlue")
                                        .resizable()
                                        .frame(width: 17, height: 17)
                                }
                                .onTapGesture {
                                    test = !test
                                    
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
        .onAppear(){
            routineList.followFirebase()
            print("hej")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
