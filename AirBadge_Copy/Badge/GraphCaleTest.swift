import SwiftUI

struct GraphCaleTest: View {
    // Array dei giorni della settimana
    let daysOfWeek = ["Lun", "Mar", "Mer", "Gio", "Ven"] // Modifica i giorni se necessario
    
    @State public var completedHours: Double = 8
    @State private var targetHours: Double = 20
    
    
    
    @EnvironmentObject var sharedData: SharedData
    @State var selectedDate: Date = Date()
    // Array con altezze per i rettangoli
    let rectangleHeights = [0, 0, 0, 0, 0] // Array di altezze dei rettangoli
    
        var currentDayIndex: Int {
            let calendar = Calendar.current
            let today = calendar.component(.weekday, from: Date()) // Ottieni il giorno corrente della settimana (da 1 a 7, dove 1 è Domenica e 7 è Sabato)

            // Converto il giorno ottenuto da Calendar nel formato desiderato (da lunedì a venerdì)
            switch today {
            case 2: // Lunedì
                return 0
            case 3: // Martedì
                return 1
            case 4: // Mercoledì
                return 2
            case 5: // Giovedì
                return 3
            case 6: // Venerdì
                return 4
            default:
                return -1 // Se non è un giorno valido (sabato o domenica, ad esempio)
            }
        } // Modifica queste altezze in base ai tuoi requisiti
    
    var simulatedHoursWorked: Double {
            sharedData.doubleValue.rounded()
        }
    
    var body: some View {
        
            Color(red: 0.1, green: 0.13, blue: 0.19).overlay{
                ZStack{
                    
                    
                    
                    VStack{
                        Text("Hours").font(.largeTitle).bold().foregroundColor(.white).offset(x: -130)
                        Text(currentMonthAndYear())
                            .foregroundColor(.white)
                    }.offset(y: -300)
                    
                    //Calendar
                    HStack(spacing: 0) {
                        ForEach(daysOfWeek.indices, id: \.self) { index in
                            ZStack {
                                ZStack{
                                    Rectangle()
                                        .frame(width: 30, height: mapValueToHeight(currentDayIndex == index ? Int(simulatedHoursWorked): 0))
                                        .foregroundColor(Color(red: 0.17, green: 0.65, blue: 1))
                                        .cornerRadius(50)
                                        .offset(y: -mapValueToHeight(currentDayIndex == index ? Int(simulatedHoursWorked): 0) / 2) // Sposta il rettangolo verso l'alto per allinearlo
                                    
                                    Text("\(currentDayIndex == index ? Int(simulatedHoursWorked): 0)") // Mostra il valore sopra il rettangolo
                                        .foregroundColor(.white)
                                        .offset(y: -mapValueToHeight(currentDayIndex == index ? Int(simulatedHoursWorked): 0) - 20)
                                }.offset(y: -20)
                                
                                
                                Text(daysOfWeek[index])
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    
                    Text("Week").font(.title3).bold().foregroundColor(.white).offset(x: -140, y: 70)
                    HStack{
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 157, height: 94)
                                .background(Color(red: 0.11, green: 0.18, blue: 0.24))
                                .cornerRadius(9)
                            VStack{
                                VStack {
                                    Text("Hours Done:").foregroundColor(.gray).font(.system(size: 15))
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 10)
                                            .foregroundColor(Color(red: 0.79, green: 0.91, blue: 1))
                                        
                                        Circle()
                                            .trim(from: 0.0, to: CGFloat(simulatedHoursWorked / targetHours))
                                            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                                            .fill(Color(red: 0.17, green: 0.65, blue: 1))
                                            .rotationEffect(.degrees(-90))
                                            .animation(.linear(duration: 0.5)) // Imposta la durata dell'animazione
                                            .shadow(color: .black.opacity(0.25), radius: 5.1, x: 0, y: 0)
                                        
                                        
                                    }
                                    .frame(width: 30, height: 30)
                                    
                                    Text(String(format: "%.0f/%.0f", simulatedHoursWorked, targetHours))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .animation(.none)
                                }
                                .padding()
                            }
                        }.padding(.horizontal, 10)
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 157, height: 94)
                                .background(Color(red: 0.11, green: 0.18, blue: 0.24))
                                .cornerRadius(9)
                            VStack{
                                VStack {
                                    Text("Hours Done:").foregroundColor(.gray).font(.system(size: 15))
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 10)
                                            .foregroundColor(Color(red: 0.95, green: 0.8, blue: 0.8))
                                        
                                        Circle()
                                            .trim(from: 0.0, to: CGFloat((targetHours-simulatedHoursWorked) / targetHours))
                                            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                                            .fill(Color(red: 0.82, green: 0.19, blue: 0.19))
                                            .rotationEffect(.degrees(-90))
                                            .animation(.linear(duration: 0.5)) // Imposta la durata dell'animazione
                                            .shadow(color: .black.opacity(0.25), radius: 5.1, x: 0, y: 0)
                                        
                                        
                                    }
                                    .frame(width: 30, height: 30)
                                    
                                    Text(String(format: "%.0f", (targetHours-simulatedHoursWorked)))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .animation(.none)
                                }
                                .padding()
                            }
                        }.padding(.horizontal, 10)
                    }.offset(y: 150)
                }
            }.ignoresSafeArea()
            }
        }
        
    
         
    func currentMonthAndYear() -> String {
        let dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.dateFormat = "MMMM yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    // Mappa i valori dell'altezza in un range compreso tra 0 e 4
    func mapValueToHeight(_ value: Int) -> CGFloat {
        
        let clampedValue = min(max(0, value), 4) // Assicura che l'altezza sia compresa tra 0 e 4
        return CGFloat(clampedValue) * 20 // Scala l'altezza in base al valore
    }


#Preview {
    GraphCaleTest()
}
