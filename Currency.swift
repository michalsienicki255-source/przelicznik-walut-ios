import Foundation

struct Waluta: Codable, Identifiable, Hashable {
    let nazwawaluty: String
    let code: String
    let mid: Double
    let id = UUID()

    enum CodingKeys: String, CodingKey {
        case nazwawaluty = "currency"
        case code
        case mid
    }
}

struct TabelaKursow: Codable {
    let rates: [Waluta]
}

func countryCode(for currencyCode: String) -> String {
    let countryMap = [
        "USD": "us",
        "EUR": "eu",
        "GBP": "gb",
        "PLN": "pl",
        "CHF": "ch",
        "JPY": "jp",
        "AUD": "au",
        "CAD": "ca",
        "CNY": "cn",
        "SEK": "se",
        "NOK": "no",
        "DKK": "dk"
    ]
    return countryMap[currencyCode] ?? "xx"
}
