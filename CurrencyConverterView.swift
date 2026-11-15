import SwiftUI
import SDWebImageSwiftUI

struct CurrencyConverterView: View {
    let currencies: [Waluta]

    @State private var selectedFromCurrency: Waluta?
    @State private var selectedToCurrency: Waluta?
    @State private var amount: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var orientation = UIDevice.current.orientation

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Przelicznik Walut")
                    .font(.largeTitle)
                    .padding()

                Text(orientationText)
                    .font(.footnote)

                Text("Wybierz walutę źródłową:")
                Picker("Wybierz walutę", selection: $selectedFromCurrency) {
                    Text("Wybierz...").tag(Optional<Waluta>.none)
                    ForEach(currencies) { currency in
                        Text("\(currency.code): \(currency.mid)").tag(Optional(currency))
                    }
                }
                .pickerStyle(MenuPickerStyle())

                Text("Wybierz walutę docelową:")
                Picker("Wybierz walutę", selection: $selectedToCurrency) {
                    Text("Wybierz...").tag(Optional<Waluta>.none)
                    ForEach(currencies) { currency in
                        Text("\(currency.code): \(currency.mid)").tag(Optional(currency))
                    }
                }
                .pickerStyle(MenuPickerStyle())

                if let selected = selectedFromCurrency {
                    HStack {
                        WebImage(url: URL(string: "https://flagcdn.com/w40/\(countryCode(for: selected.code)).png"))
                            .resizable()
                            .frame(width: 30, height: 20)
                        Text(selected.nazwawaluty)
                    }
                }

                Text("Wprowadź kwotę:")
                TextField("Kwota", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .onChange(of: amount) { _, newValue in
                        let normalized = newValue.replacingOccurrences(of: ",", with: ".")
                        if normalized != newValue {
                            amount = normalized
                            return
                        }
                        if !newValue.isEmpty && Double(newValue) == nil {
                            alertMessage = "Wprowadź tylko cyfry!"
                            showAlert = true
                        }
                    }

                Button("Przelicz") {
                    if amount.isEmpty || Double(amount) == nil {
                        alertMessage = "Wprowadź tylko cyfry!"
                        showAlert = true
                    } else if let value = Double(amount), value <= 0 {
                        alertMessage = "Kwota musi być większa od zera"
                        showAlert = true
                    }
                }
                .padding()

                if let from = selectedFromCurrency,
                   let to = selectedToCurrency,
                   let amountValue = Double(amount),
                   amountValue > 0 {
                    Text("Wynik: \(calculateResult(from: from, to: to, amount: amountValue)) \(to.code)")
                        .font(.headline)
                }
            }
            .padding()
            .onAppear {
                orientation = UIDevice.current.orientation
            }
            .onChange(of: geometry.size.width) {
                orientation = UIDevice.current.orientation
            }
            .alert("Błąd", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }

    private var orientationText: String {
        if orientation.isPortrait {
            return "Orientacja: pionowa"
        }
        if orientation.isLandscape {
            return "Orientacja: pozioma"
        }
        return "Orientacja: inna"
    }

    func calculateResult(from: Waluta, to: Waluta, amount: Double) -> String {
        let result = amount * (from.mid / to.mid)
        return String(format: "%.2f", result)
    }
}
