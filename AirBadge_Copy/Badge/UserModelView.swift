import SwiftUI

struct UserModelView: View {
    var name = "Michele" // Utilizzo di @AppStorage per memorizzare il nome
    var surname = "Colella" // Utilizzo di @AppStorage per memorizzare il cognome
    var day = "Morning" // Utilizzo di @AppStorage per memorizzare il cognome
    @State private var isSheetPresented = false
    @State var totalcompletedHours: Double = 0
    
    var body: some View {
        Color(red: 0.1, green: 0.13, blue: 0.19).overlay(
            VStack{
                
                Text("Badge")
                    .font(.largeTitle)
                    .bold().offset(x: -120, y: -70).foregroundColor(.white)
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(
                            Color(red: 0.09, green: 0.35, blue: 0.54)
                        )
                        .frame(width: 350, height: 500)
                        .cornerRadius(20)
                    
                    
                    VStack{
                        Text("Developer Academy").font(.title).bold().foregroundColor(.white)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 350, height: 10)
                            .background(Color.white).padding(.top, 20)
                        Text("854").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().foregroundColor(.white).padding(.top, 20)
                        
                        Text("\(name)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().padding(.top, 20).foregroundColor(.white)
                        Text("\(surname)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().padding(.top, 20).foregroundColor(.white)
                        Text("\(day)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().foregroundColor(.white).padding(.top, 20)
                    }.offset(y:-30)
                }
            }
        )
        .ignoresSafeArea()
    }
    
    func calculateTotalCompletedHours() {
            let savedHoursData = UserDefaults.standard.dictionary(forKey: "DailyHoursData") as? [String: Double] ?? [:]
            
            // Somma di tutte le ore salvate
            totalcompletedHours = savedHoursData.values.reduce(0.0, +)
        }
    
}

#Preview {
    UserModelView()
}
