import SwiftUI
import FirebaseCore
import Firebase



struct ContentView: View {
    @State var test = false
    @StateObject var vModel = RoutineViewModel()
    let db = Firestore.firestore()
    
    var body: some View {
        
        
        NavigationView {
            ZStack{
                if(vModel.isAdding) {
                    AddNewRoutineView(vModel: vModel)
                        .background(Color(.orange))
                }
                else if vModel.currentRoutinId != "" {
                    RoutineView(model: vModel.pickUpModel(id: vModel.currentRoutinId), vModel: vModel)
                        .background(Color.orange)
                }else{
                    ListView(vmodel: vModel)
                        .background(Color.orange)
                }
                
            }
            
        }
        .onAppear(){
            vModel.followFirebase()
        }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



