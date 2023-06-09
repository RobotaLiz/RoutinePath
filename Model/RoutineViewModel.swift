import Foundation
import Firebase
import EventKit

class RoutineViewModel : ObservableObject {
    @Published var isAdding = false
    @Published var currentRoutinId = ""
    @Published var list = [RoutineModel]()
    @Published var test = false
    let eventStore = EKEventStore()
    let db = Firestore.firestore()
    
    func add(routine : RoutineModel) {
        do {
            try db.collection("routine").addDocument(from: routine)
        }catch{
            print("Error")
        }
        
        isAdding = false
    }
    func pickUpModel(id : String) -> RoutineModel{
        return list.first(where: { $0.id == id}) ?? RoutineModel(habit: "",image: "", markedDays: [])
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
    func doneNotDone(model: RoutineModel) -> Bool {
        if(model.markedDays.count == 0){
            return false
        }
        guard let lastDay = model.markedDays.last else { return false }
        
        let todayComp =  Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let lastDayComp = Calendar.current.dateComponents([.year, .month, .day], from: lastDay)
        
        if(todayComp.day == lastDayComp.day){
            
            return true
        }
        
        return false
    }
    func markDay (model: RoutineModel) {
        var copyOfDays = model.markedDays
        
        
        if(doneNotDone(model: model)){
            copyOfDays.removeLast()
        }
        else{
            copyOfDays.append(Date.now)
        }
        
        
        let updatedModel = RoutineModel(habit: model.habit, image: model.image, markedDays: copyOfDays)
        
        if let documentId = model.id{
            do{
                try db.collection("routine").document(documentId).setData(from: updatedModel)
            }catch{
                print("couldnt update")
            }
        }
    }
    func HabitReminder(routineModel: RoutineModel) {
        
        self.eventStore.requestAccess(to: .reminder) { granted, error in
            if granted && error == nil {
                let reminder = EKReminder(eventStore: self.eventStore)
                reminder.title = routineModel.habit
                reminder.calendar = self.eventStore.defaultCalendarForNewReminders()
                
                let today = Date()
                let tomorrow = today.addingTimeInterval(86400)
                
                var comp = Calendar.current.dateComponents([.year, .month, .day], from: tomorrow)
                comp.hour = 11
                
                
                reminder.dueDateComponents = comp
                
                do {
                    try self.eventStore.save(reminder, commit: true)
                } catch {
                    print("Error creating and saving new reminder : \(error.localizedDescription)")
                }
            } else {
                print("Error accessing reminders: \(error?.localizedDescription ?? "")")
                
            }
        }
    }
}
