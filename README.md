# Przelicznik walut iOS

Pięć plików SwiftUI do wklejenia w Xcode. Aplikacja pobiera tabelę A z NBP, pokazuje listę kursów i przelicza kwotę między dwiema walutami.

## Pliki

- `projektApp.swift` — start aplikacji
- `ContentView.swift` — lista kursów i przejście do przelicznika
- `CurrencyConverterView.swift` — wybór walut, kwota, wynik
- `CurrencyService.swift` — pobranie danych z API NBP
- `Currency.swift` — modele danych

## Jak odpalić w Xcode

1. File → New → Project → iOS → App. Nazwa: `projekt`. Interface: SwiftUI.
2. Podmień wygenerowane `ContentView.swift` i `projektApp.swift` plikami z tego repozytorium.
3. Dodaj pozostałe trzy pliki: File → Add Files to "projekt".
4. File → Add Package Dependencies i wklej:

   https://github.com/SDWebImage/SDWebImageSwiftUI

   Zaznacz produkt SDWebImageSwiftUI.
5. W targetcie ustaw minimum iOS 17 i uruchom na symulatorze.

Kursy NBP są podane w złotówkach. Wynik to `kwota × kurs źródłowy / kurs docelowy`.
