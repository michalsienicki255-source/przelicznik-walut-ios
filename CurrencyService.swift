import Foundation

class CurrencyService {
    func fetchRates(completion: @escaping ([Waluta]?) -> Void) {
        let url = URL(string: "https://api.nbp.pl/api/exchangerates/tables/A/?format=json")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                let tables = try decoder.decode([TabelaKursow].self, from: data)
                DispatchQueue.main.async {
                    completion(tables.first?.rates)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }

        task.resume()
    }
}
