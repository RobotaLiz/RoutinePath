
import SwiftUI
import FirebaseCore
import Firebase

  
struct ContentView: View {
    let db = Firestore.firestore()
    @StateObject var routineList = RoutineViewModel()
   
    var body: some View {
        NavigationView {
            if(routineList.isAdding) {
                AddNewRoutineView(routineList: routineList)
            }
            else{
                VStack {
                    List {
                        ForEach(routineList.list) { list in
                            NavigationLink(destination: RoutineView(list: list)) {
                                Text(list.habit)
                                
                            }
                            
                        }
          
                    }
                    .toolbar{ ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add") {routineList.isAdding = true
                    }
                       
                    }
                        
                    }
                }
            }
            
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
