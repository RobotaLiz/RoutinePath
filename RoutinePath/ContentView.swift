
import SwiftUI
import FirebaseCore
import Firebase


//TODO:
//[x] Anropa add functionen på rätt sätt i AddNewRoutineView
//[ ] Anropa listenToFirebase från contentView? så att det man lagt till faktiskt syns i listan
//[ ] Gör det som finns i våran VStack till en egen view? så blir det tydligare vad if-satsen gör! :)
  
struct ContentView: View {
    let db = Firestore.firestore()
    @StateObject var routineList = RoutineViewModel()
   
    var body: some View {
        NavigationView {
            if(routineList.isAdding) {
               // AddNewRoutineView(routineList: routineList)
                InfoView(viewModel: routineList)
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
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Add") {routineList.isAdding = true
                                
                                
                            }
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button("Info") {routineList.isAdding = true }
                                }
                            }
                       
                        }
                    }
                }
            }
        }
        .padding()
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
