//
//  ContentView.swift
//  Final
//
//  Created by Wade Belden on 4/28/21.
//

import SwiftUI
struct Response: Codable {
    var results: Result
}
struct Result: Codable {
    var quote = ""
    var author = ""
    var htmloutput = ""
}

struct BaseTextAreaMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5)
            .frame(minWidth: 100, idealWidth:150, maxWidth: 200)
            .background(Color.white)
            .cornerRadius(20)
            .foregroundColor(Color(red:0.25, green:0, blue:1))
            .overlay((RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 2)))
    }
}

extension View {
    func baseTextAreaMod() -> some View {
        modifier(BaseTextAreaMod())
    }
}

struct BaseButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(10)
            .frame(minWidth: 100, idealWidth: 150, maxWidth: 200, minHeight: 40, idealHeight: 40, maxHeight: 40, alignment: .leading)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue,Color(red:0.25,green:0,blue:1)]), startPoint: .center, endPoint: .init(x: 0.5, y: 0)))
            .cornerRadius(20)
    }
}

struct ContentView: View {
    @ObservedObject var orders = Orders()
    @ObservedObject var expenses = Expenses()
    @State private var showingViewOrder = false
    @State private var showingViewExpense = false
    @State private var showingAddOrder = false
    @State private var showingAddExpense = false
//    @State var result = Result()
//    @State var quote = ""
//    @State var author = ""
    
    let now = Date()
//    let urgent = Date().addingTimeInterval(259200)
//    let soon = Date().addingTimeInterval(604800)
    
    func getDate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let stringDate = dateFormatter.string(from: now)
        return stringDate
    }

    
    var body: some View {
        

        
        NavigationView {
            HStack {
                VStack {
                    Text(getDate())
                    .frame(minHeight: 40, idealHeight: 40, maxHeight: 40, alignment: .center)
                    .baseTextAreaMod()
                    .font(.title2)
                             
                    
                    Text("Quote of the Day")
//                    Text("\(quote) - \(author)")
                    .frame(minHeight: 100, idealHeight: 200, maxHeight: 300, alignment: .center)
                    .baseTextAreaMod()
//                    .onAppear(perform: loadData)
                    
                

                    Button(action: {
                        self.showingViewOrder = true
                    }) {
                        HStack {
                            VStack{
                                Image(systemName: "magnifyingglass").offset(x:8, y:22)
                                Image(systemName: "tray")
                            }.offset(x:0, y:-8)
                            Text("View Orders")
                        }
                    }
                    .buttonStyle(BaseButtonStyle())
                    Button(action: {
                        self.showingViewExpense = true
                    }) {
                        HStack {
                            VStack{
                                Image(systemName: "magnifyingglass").offset(x:8, y:22)
                            Image(systemName: "creditcard")
                            }.offset(x:0, y:-9)
                            Text("View Expenses")
                        }
                    }
                    .buttonStyle(BaseButtonStyle())
                
                    Button(action: {
                        self.showingAddOrder = true
                    }) {
                        HStack {
                            VStack {
                                Image(systemName: "plus").scaleEffect(0.8).offset(x:7, y:7)
                                Image(systemName: "doc.text")
                            }.offset(x:3,y:-8)
                            Text("Create Order").padding(3)
                        }
                    }
                    .buttonStyle(BaseButtonStyle())
                
                    Button(action: {
                        self.showingAddExpense = true
                    }) {
                        HStack {
                            VStack {
                                Image(systemName: "plus").scaleEffect(0.8).offset(x:9, y:6)
                                Image(systemName: "dollarsign.square")
                            }.offset(x:2, y:-7)
                            Text("Create Expense").padding(2)
                        }
                    }
                    .buttonStyle(BaseButtonStyle())
                            
                    }
                    .padding(.leading, 10)
                    VStack {
                        Text("Current Mood")
                            .frame(minHeight: 150, idealHeight: 220, maxHeight: 360, alignment: .center)
                            .baseTextAreaMod()
                            

                        Text("Orders Due")
//                        List(orders, id: self.id) { items in
//                            VStack{
//                                if(items.due >= ) {
//
//                                }
//                            }
//                        }
                        .frame(minHeight: 165, idealHeight: 170, maxHeight: 170, alignment: .center)
                            .baseTextAreaMod()
                    }
                    .padding(.trailing, 10)
                    
                    
                }
                .navigationBarTitle(Text("Landing Page"), displayMode: .inline)
                .font(.custom("customSubheadline", size: 14, relativeTo: .subheadline).weight(.regular))
                .sheet(isPresented: $showingViewOrder) {
                    ViewOrders(orders: self.orders)
                }
                .sheet(isPresented: $showingViewExpense) {
                    ViewExpense(expenses: self.expenses)
                }
                .sheet(isPresented: $showingAddOrder) {
                    CreateOrder(orders: self.orders)
                }
                .sheet(isPresented: $showingAddExpense) {
                    CreateExpense(expenses: self.expenses)
                }
        }
    }
        

//    func loadData() {
//        guard let url = URL(string: "https://zenquotes.io/api/today") else {
//            print("Invalid URL")
//            return
//        }
//
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                if let decodedResponse = try? JSONDecoder().decode(Result.self, from: data) {
//                    DispatchQueue.main.async {
//                        self.quote = decodedResponse.quote
//                        self.author = decodedResponse.author
//                    }
//                    return
//                }
//                print("Error")
//            }
//        }.resume()
//
//    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
