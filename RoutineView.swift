import Foundation
import SwiftUI


struct RoutineView : View {
    @Environment(\.presentationMode) var presentationMode
    @State var model : RoutineModel
    @State var vModel : RoutineViewModel
    @State var dates : Set<DateComponents> = []
    
    var body: some View {
        
        //NavigationView {
        VStack{
            Image(model.image)
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
                
                Image("images")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("Streaks:\(calculateStreaks(dateComponents: dates)) ")
                    .font(.title2)
                
                
            }
            .padding(.trailing, 250)
            Spacer()
            
            Button("Notification") {
                vModel.HabitReminder()
                
            }
            .font(.headline)
            .padding()
            
            
        }
        
        //}
        .navigationBarItems(leading:  Button("Back") {
            vModel.currentRoutinId = ""
            
            
            
        }).navigationBarItems(trailing: Image(systemName: "trash").onTapGesture {
            vModel.DeleteRoutine(Routine: model)
            vModel.currentRoutinId = ""
        })
        
        
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
