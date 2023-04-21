

import Foundation
import SwiftUI

struct InfoView : View {

    var viewModel : RoutineViewModel
    
    var body: some View {
        NavigationView {
            VStack{
                Label("Activities", systemImage: "figure.strengthtraining.traditional" )
                    .font(.title)
                    .foregroundColor(.blue)
                Spacer()
                List{
                    ForEach (viewModel.list) { list in
                            NavigationLink(destination: RoutineView(list: list)) {
                                Text(list.habit)
                                
                            }
                            
                        }
                    }
                }
            }
        }
    }
    

