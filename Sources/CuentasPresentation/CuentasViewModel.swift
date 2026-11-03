import CuentasDomain
import Foundation

public struct EstadoCuentas: Equatable, Sendable {
    public var total: Int
    public var gastos: [Gasto]
    public var mensaje: String?

    public init(total: Int = 0, gastos: [Gasto] = [], mensaje: String? = nil) {
        self.total = total
        self.gastos = gastos
        self.mensaje = mensaje
    }
}

public final class CuentasViewModel {
    public private(set) var estado: EstadoCuentas
    private let libro: LibroDeCuentas

    public init(libro: LibroDeCuentas) {
        self.libro = libro
        self.estado = EstadoCuentas()
        sincronizar(mensaje: nil)
    }

    public func agregar(categoria: String, montoCentavos: Int, nota: String) {
        do {
            _ = try libro.registrar(categoria: categoria, montoCentavos: montoCentavos, nota: nota)
            sincronizar(mensaje: nil)
        } catch ErrorLibro.topeExcedido {
            sincronizar(mensaje: "Ese gasto pasa el tope del mes")
        } catch {
            sincronizar(mensaje: "No pude registrar el gasto")
        }
    }

    private func sincronizar(mensaje: String?) {
        estado = EstadoCuentas(total: libro.total, gastos: libro.gastos, mensaje: mensaje)
    }
}

#if canImport(SwiftUI)
import SwiftUI

public struct CuentasView: View {
    @State private var modelo: CuentasViewModel
    public init(modelo: CuentasViewModel) { self.modelo = modelo }

    public var body: some View {
        List {
            Section("Total") {
                Text(centavos(modelo.estado.total))
            }
            if let mensaje = modelo.estado.mensaje {
                Text(mensaje)
            }
            Section("Gastos") {
                ForEach(modelo.estado.gastos, id: \.id) { gasto in
                    Text("\(gasto.categoria) · \(centavos(gasto.montoCentavos))")
                }
            }
        }
        .navigationTitle("Cuentas claras")
    }

    private func centavos(_ valor: Int) -> String {
        String(format: "S/ %.2f", Double(valor) / 100)
    }
}
#endif
