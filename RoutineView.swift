import Foundation
import SwiftUI


struct RoutineView : View {
    @Environment(\.presentationMode) var presentationMode
    @State var model : RoutineModel
    @State var vModel : RoutineViewModel
    @State var dates : Set<DateComponents> = []
    @State var showingPopup = false
   
    var body: some View {
        ZStack{
            
            VStack{
                Image(systemName: "figure.run")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(model.habit)
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding()
                MultiDatePicker("Days", selection: $dates, in: Date.now...)
                    .frame(height: 300)
                
                    .padding()
                Spacer()
                HStack{
                    
                    Image(systemName: "calendar.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("Streaks:\(calculateStreaks(dateComponents: dates)) ")
                        .font(.title2)
                    
                    
                }
                .padding(.trailing, 250)
                Spacer()
                
                Button("Notification") {
                    showingPopup = true
                    
                    
                }
                .font(.headline)
                .padding()
                
                
            }
            
        }
        .popup(isPresented: $showingPopup) {
                  ZStack { // 4
                      Color.yellow.frame(width: 400, height: 200)
                     
                      VStack{
                          Text("Would you like to add a notification for tomorrow? ")
                              .font(.title2)
                              .padding()
                          HStack{
                              Button(action: {
                                  vModel.HabitReminder(routineModel: model)
                                  showingPopup = false
                              }, label: {
                                  Text("Yes  ")
                                  
                                      .foregroundColor(.black)
                                      .background(.orange)
                                      .cornerRadius(11)
                                      .font(.title2)
                                  
                              })
                              Button(action: {
                                  showingPopup = false
                              }, label: {
                                  Text(" No  ")
                                  
                                      .foregroundColor(.black)
                                      .background(.orange)
                                      .cornerRadius(11)
                                 
                                      .font(.title2)
                              })
                              
                          }
                        
                      }
                  }
              }
        .navigationBarItems(leading:  Button("Back") {
            
            vModel.currentRoutinId = ""
                
            
            
        }).navigationBarItems(trailing: Image(systemName: "trash").onTapGesture {
            vModel.DeleteRoutine(Routine: model)
            vModel.currentRoutinId = ""
        })
        
        .foregroundColor(.black)
        .onAppear{
            GetMarkedDays()
        }
        
    }
    func calculateStreaks(dateComponents: Set<DateComponents>) -> Int {
        let sortedDates = dateComponents.compactMap { Calendar.current.date(from: $0) }.sorted()
        
        var currentStreak = 1
        var previousDate: Date?
        if(dateComponents.count == 0){
            return 0
        }
        if(dateComponents.count == 1){
            return 1
        }
        
        for date in sortedDates {
            if let previousDate = previousDate {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.day], from: previousDate, to: date)
                
                if components.day == 1 {
                    currentStreak += 1
                } else {
                    currentStreak = 1
                }
                
            }
            
            previousDate = date
        }
        
        return currentStreak
    }
    func GetMarkedDays(){
        
        for date in model.markedDays {
            let comp = Calendar.current.dateComponents([.year, .month, .day], from: date)
            dates.insert(comp)
        }
    }
}
