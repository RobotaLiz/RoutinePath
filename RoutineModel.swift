import Foundation
import FirebaseFirestoreSwift

struct RoutineModel : Identifiable, Codable  {
    @DocumentID var id : String?
    
    
    
    var habit : String
    var motivation : String
    var days : Int
   
    init(id: String, habit: String, motivation: String, days: Int) {
        self.id = id
        self.habit = habit
        self.motivation = motivation
        self.days = days
    }
    
    
}
    



