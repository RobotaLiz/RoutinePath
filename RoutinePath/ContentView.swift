import SwiftUI
import FirebaseCore
import Firebase



struct ContentView: View {
    @State var test = false
    @StateObject var routineList = RoutineViewModel()
    let db = Firestore.firestore()
   
    
    var body: some View {
        
        Button("Create Reminder") {
            routineList.HabitReminder()
        }
        NavigationView {
            if(routineList.isAdding) {
                AddNewRoutineView(routineList: routineList)
                
            }
            else if routineList.currentRoutinId != "" {
                RoutineView(model: routineList.pickUpModel(id: routineList.currentRoutinId), vModel: routineList)
            }else{
                ListView(routineList: routineList)
            }
        }
        .onAppear(){
            routineList.followFirebase()
            
        }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



