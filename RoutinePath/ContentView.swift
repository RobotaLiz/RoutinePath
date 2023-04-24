import SwiftUI
import FirebaseCore
import Firebase


//TODO:
//[x] Anropa add functionen på rätt sätt i AddNewRoutineView
//[ ] Anropa listenToFirebase från contentView? så att det man lagt till faktiskt syns i listan
//[ ] Gör det som finns i våran VStack till en egen view? så blir det tydligare vad if-satsen gör! :)
  
struct ContentView: View {
    @State var test = false
    
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
                        ForEach(routineList.list) { model in
                            
                                HStack{
                                    Image(model.image)
                                        
                                        .resizable()
                                        .frame(width: 40, height: 40)
                        
                                    Text(model.habit)
                                        .foregroundColor(.gray)
                                        .font(.title3)
                                    Spacer()
                                    Button(action: {
                                        test = !test
                                        
                                    }, label: {
                                        Image( test ? "emty star" : "full star")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                               })
                            }
                            
                        }
          
                    }
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Add") {routineList.isAdding = true
                                    
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
