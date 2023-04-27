import Foundation
import FirebaseFirestoreSwift

struct RoutineModel : Identifiable, Codable  {
    @DocumentID var id : String?
    
    
    var markedDays: [Date]
    var habit : String
    var image : String
   
    init( habit: String,image: String, markedDays: [Date]) {
        self.habit = habit
        self.markedDays = markedDays
        self.image = image
    }
    
    
}
    



