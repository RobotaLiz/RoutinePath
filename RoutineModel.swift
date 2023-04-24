import Foundation
import FirebaseFirestoreSwift

struct RoutineModel : Identifiable, Codable  {
    @DocumentID var id : String?
    
    
    
    var habit : String
    var motivation : String
    var days : Int
    var image : String
   
    init( habit: String, motivation: String, days: Int, image: String) {
      
        self.habit = habit
        self.motivation = motivation
        self.days = days
        self.image = image
    }
    
    
}
    



