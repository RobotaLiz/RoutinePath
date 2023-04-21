import Foundation
import SwiftUI


struct RoutineView : View {
    @Environment(\.presentationMode) var presentationMode
    @State var list : RoutineModel
    
    
    var body: some View {
        NavigationView {
            VStack{
                Label("Overview", systemImage: "figure.walk")
                    .font(.title2)
                    .foregroundColor(.cyan)
                    Spacer()
                
                
                  TextField(list.motivation, text: $list.motivation)
                      Spacer()
            }
            
        }
        .navigationBarItems(trailing: Button("Delete") {
            presentationMode.wrappedValue.dismiss()
        })
        
    }
}
