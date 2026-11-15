import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @State private var currencies: [Waluta] = []
    let service = CurrencyService()

    var body: some View {
        NavigationView {
            List(currencies) { currency in
                NavigationLink(destination: CurrencyConverterView(currencies: currencies)) {
                    HStack {
                        WebImage(url: URL(string: "https://flagcdn.com/w40/\(countryCode(for: currency.code)).png"))
                            .resizable()
                            .frame(width: 30, height: 20)
                        Text("\(currency.nazwawaluty) (\(currency.code)): \(currency.mid)")
                    }
                }
            }
            .navigationTitle("Kursy NBP")
            .onAppear {
                service.fetchRates { currencies in
                    if let currencies = currencies {
                        self.currencies = currencies
                    }
                }
            }
        }
    }
}
