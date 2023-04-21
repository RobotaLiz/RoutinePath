import Foundation
import Firebase

class RoutineViewModel : ObservableObject {
    @Published var isAdding = false
    let db = Firestore.firestore()
    
   @Published var list = [RoutineModel]()
    
    func add(routine : RoutineModel) {
        do {
            try db.collection("routine").addDocument(from: routine)
        }catch{
            print("Error")
        }
        // lägga till ny habit
        isAdding = false 
    }
    
    func followFirebase () {
        
        db.collection("routine").addSnapshotListener() {
            snapshot, err in
            
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("error get documen \(err)")
            }else{
                self.list.removeAll()
                for document in snapshot.documents {
                    do{
                        let routine = try document.data(as: RoutineModel.self)
                        self.list.append(routine)
                    }catch{
                        print("error in document...")
                    }
                }
            }
        }
    }
}
