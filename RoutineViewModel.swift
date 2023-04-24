import Foundation
import Firebase

class RoutineViewModel : ObservableObject {
    @Published var isAdding = false
    let db = Firestore.firestore()
   @Published var currentRoutinId = ""
    
   @Published var list = [RoutineModel]()
    
    func add(routine : RoutineModel) {
        do {
            try db.collection("routine").addDocument(from: routine)
        }catch{
            print("Error")
        }
       
        isAdding = false
    }
    func pickUpModel(id : String) -> RoutineModel{
        return list.first(where: { $0.id == id}) ?? RoutineModel(habit: "", motivation: "", days: 0, image: "")
    }
    func DeleteRoutine (Routine : RoutineModel) {
        db.collection("routine").document(Routine.id ?? "").delete() { err in
            if let err = err {
                print("Error deleting! \(err)")
            }else{
                print("The document is removed ")
            }
            
        }
        
    }
    
    func followFirebase () {
        
        db.collection("routine").addSnapshotListener() {
            snapshot, err in
            
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("error get document \(err)")
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
