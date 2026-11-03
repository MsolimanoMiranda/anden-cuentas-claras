# Cuentas claras

Gastos del mes en Swift con Clean Architecture y MVVM. El dominio y el view model compilan y se prueban en Linux. La vista SwiftUI se compila solo donde existe SwiftUI (`#if canImport(SwiftUI)`), o sea en Xcode.

## Capas

- `CuentasDomain` — `LibroDeCuentas`. No deja pasar el tope mensual.
- `CuentasPresentation` — `CuentasViewModel` traduce los errores a un mensaje. `CuentasView` es la vista.

## Correr

```bash
cd projects/swift-cuentas-claras
swift test
```
