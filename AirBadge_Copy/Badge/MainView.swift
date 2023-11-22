import SwiftUI

struct MainView: View {
    @State public var completedHours: Double = 0
    @State private var targetHoursInput: String = ""
    @State private var targetHours: Double = 4 // Cambiato da Double a Int
    @State private var showAlert = false
    @State private var badgeInTime: Date?
    
    @State private var badgeOutTime: Date?
    
    @State private var showCompleteAlert = false
    
    @State private var selectedDate: Date = Date()
    @State public var hoursWorked: Double = 0.0
    
    @State private var isPressed = false
    
    @EnvironmentObject var sharedData: SharedData
    
    @State private var currentTime: String = ""
    
    @State private var animateCircle = false
    @State private var animate = false
    @State private var animate1 = false
    @State private var animate2 = false
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter
    }()
    
    @State private var showAlertConfirmation = false
    var body: some View {
        Color(red: 0.1, green: 0.13, blue: 0.19).overlay{
            VStack{
                VStack{
                    VStack(alignment: .leading){
                        Text("Today").font(.largeTitle).bold().foregroundColor(.white)
                        Text(dateFormatter.string(from: Date())).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/).foregroundColor(.white).textCase(.uppercase)
                    }.offset(x: -70).padding(.bottom, 50)
                    
                    //Hours counter
                    HStack{
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 157, height: 94)
                                .background(Color(red: 0.11, green: 0.18, blue: 0.24))
                                .cornerRadius(9)
                            VStack{
                                Text("Current Time:").foregroundColor(.gray).font(.system(size: 15))
                                Image(systemName: "clock.fill").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white).padding(.bottom, 2).padding(.top, 2)
                                Text(currentTime)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15))
                                    .bold()
                                    .onAppear {
                                        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                            let formatter = DateFormatter()
                                            formatter.dateFormat = "HH:mm:ss"
                                            currentTime = formatter.string(from: Date())
                                        }
                                        RunLoop.current.add(timer, forMode: .common)
                                    }
                            }
                        }.padding(.horizontal, 10)
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 157, height: 94)
                                .background(Color(red: 0.11, green: 0.18, blue: 0.24))
                                .cornerRadius(9)
                            VStack{
                                Text("Hours Today:").foregroundColor(.gray).font(.system(size: 15))
                                HStack{
                                    Rectangle().frame(width: 15, height: 15).cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/).offset(x:2)
                                        .foregroundColor(completedHours >= 1 ? Color(red: 0.17, green: 0.64, blue: 1) : Color(red: 0.75, green: 0.87, blue: 0.98) )
                                    Rectangle().frame(width: 15, height: 15)
                                        .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/).offset(x:-2).foregroundColor(completedHours >= 2 ? Color(red: 0.17, green: 0.64, blue: 1) : Color(red: 0.75, green: 0.87, blue: 0.98) )
                                    
                                }.offset(y:2)
                                HStack{
                                    Rectangle().frame(width: 15, height: 15).cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/).offset(x:2).foregroundColor(completedHours >= 3 ? Color(red: 0.17, green: 0.64, blue: 1) : Color(red: 0.75, green: 0.87, blue: 0.98) )
                                    
                                    Rectangle().frame(width: 15, height: 15).cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/).offset(x:-2).foregroundColor(completedHours >= 4 ? Color(red: 0.17, green: 0.64, blue: 1) : Color(red: 0.75, green: 0.87, blue: 0.98) )
                                }.offset(y:-2)
                                Text("\(completedHours, specifier: "%.0f")").foregroundColor(.gray).font(.system(size: 15))
                            }
                        }.padding(.horizontal, 10)
                    }
                    
                    //Mark
                    Text("Marks").font(.title3).bold().foregroundColor(.white).offset(x: -140).padding(.top, 30)
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 340, height: 94)
                            .background(Color(red: 0.11, green: 0.18, blue: 0.24))
                            .cornerRadius(9)
                        VStack{
                            ZStack{
                                HStack{
                                    Image(systemName: "square.and.arrow.down").foregroundColor(.gray)
                                    Text("Badge In at:").foregroundColor(.gray)
                                }.offset(x: -80)
                                Text(getTimeString(time: badgeInTime)).foregroundColor(.white).font(.system(size: 15)).bold().offset(x: 120)
                            }.padding(.bottom, 10)
                            
                            ZStack{
                                HStack{
                                    Image(systemName: "square.and.arrow.up").foregroundColor(.gray)
                                    Text("Badge Out at:").foregroundColor(.gray)
                                }.offset(x: -73)
                                Text(getTimeString(time: badgeOutTime)).foregroundColor(.white).font(.system(size: 15)).bold().offset(x: 120)
                            }
                        }.offset(x: -5)
                    }
                    
                    
                }
            }.offset(y:-150)
            Button(action: {
                if badgeOutTime != nil {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    badgeInTime = Date()
                    badgeOutTime = nil
                } else {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    if badgeInTime != nil {
                        badgeOutTime = Date()
                        calculateTimeDifference()
                        sharedData.doubleValue = completedHours
                    } else {
                        badgeInTime = Date()
                    }
                }
            }){
                ZStack{
                    Circle().foregroundColor(Color(red: 0.09, green: 0.19, blue: 0.28)).frame(width: animate1 ? 160 : 155, height: animate1 ? 160 : 155)
                        .scaleEffect(animate1 ? 1.7 : 1.3)
                        .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true).delay(1.0))
                        .onAppear() {
                            withAnimation {
                                self.animate1.toggle()
                                
                            }
                        }
                    Circle().foregroundColor(Color(red: 0.13, green: 0.27, blue: 0.4))
                        .frame(width: animate2 ? 150 : 135, height: animate2 ? 150 : 145)
                        .scaleEffect(animate2 ? 1.6 : 1.4)
                        .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true).delay(0.5))
                        .onAppear() {
                            withAnimation {
                                self.animate2.toggle()
                                
                            }
                        }
                    Circle()
                        .fill(Color(red: 0.09, green: 0.35, blue: 0.54))
                        .frame(width: animate ? 140 : 135, height: animate ? 140 : 135)
                        .scaleEffect(animate ? 1.5 : 1.3)
                        .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true))
                        .onAppear() {
                            withAnimation {
                                self.animate.toggle()
                            }
                        }
                    Text(badgeInTime != nil ? "Badge out" : "Badge in")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    
                }
                
            }.offset(y: 190)
            
        }.ignoresSafeArea().onAppear {
            if isNewDay() {
                UserDefaults.standard.set(Date(), forKey: "lastDate")
                completedHours = 0 // Reimposta le completedHours a 0 se è un nuovo giorno
            }
        }
    }
    
    func getTimeString(time: Date?) -> String {
        guard let time = time else {
            return "-"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: time)
    }
    
    func calculateTimeDifference() {
        guard let badgeIn = badgeInTime, let badgeOut = badgeOutTime else { return }
        
        // Calcola le ore lavorate utilizzando la funzione calculateWorkedHours
        let hoursWorked = calculateWorkedHours(badgeInTime: badgeIn, badgeOutTime: badgeOut)
        
        completedHours += hoursWorked
        
        // Assicura che le ore completate non superino mai il target
        if completedHours > targetHours {
            
                showCompleteAlert = true
                completedHours = targetHours
            
        } else {
            showCompleteAlert = false
        }
    }
    
    func calculateWorkedHours(badgeInTime: Date?, badgeOutTime: Date?) -> Double {
        guard let badgeIn = badgeInTime, let badgeOut = badgeOutTime else { return 0 }
        
        let timeDifference = badgeOut.timeIntervalSince(badgeIn)
        let hoursWorked = timeDifference // / 3600 // Converti da secondi a ore
        
        return hoursWorked
    }
    
    func isNewDay() -> Bool {
        let lastDate = UserDefaults.standard.object(forKey: "lastDate") as? Date ?? Date()
        let currentDate = Date()
        
        let calendar = Calendar.current
        let lastDateComponents = calendar.dateComponents([.year, .month, .day], from: lastDate)
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        return lastDateComponents.year != currentDateComponents.year || lastDateComponents.month != currentDateComponents.month || lastDateComponents.day != currentDateComponents.day
    }
}

#Preview {
    MainView()
}
