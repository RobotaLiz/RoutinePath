import Foundation
import FirebaseFirestoreSwift

struct RoutineModel : Identifiable, Codable  {
    @DocumentID var id : String?
    
    
    var date: Date
    var habit : String
    var motivation : String
  
    var image : String
   
    init( habit: String, motivation: String, image: String, date: Date) {
      
        self.habit = habit
        self.motivation = motivation
        self.date = date
        self.image = image
    }
    
    
}
    



