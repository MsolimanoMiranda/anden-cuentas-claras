import Foundation

public enum ErrorLibro: Error, Equatable {
    case montoInvalido
    case categoriaVacia
    case topeExcedido
}

public struct Gasto: Equatable, Sendable {
    public let id: UUID
    public let categoria: String
    public let montoCentavos: Int
    public let nota: String

    public init(id: UUID, categoria: String, montoCentavos: Int, nota: String) {
        self.id = id
        self.categoria = categoria
        self.montoCentavos = montoCentavos
        self.nota = nota
    }
}

public final class LibroDeCuentas: @unchecked Sendable {
    public private(set) var gastos: [Gasto] = []
    public let topeMensual: Int

    public init(topeMensual: Int) {
        self.topeMensual = topeMensual
    }

    public var total: Int {
        gastos.reduce(0) { $0 + $1.montoCentavos }
    }

    public func registrar(categoria: String, montoCentavos: Int, nota: String) throws -> Gasto {
        guard montoCentavos > 0 else { throw ErrorLibro.montoInvalido }
        guard !categoria.trimmingCharacters(in: .whitespaces).isEmpty else { throw ErrorLibro.categoriaVacia }
        guard total + montoCentavos <= topeMensual else { throw ErrorLibro.topeExcedido }
        let gasto = Gasto(id: UUID(), categoria: categoria, montoCentavos: montoCentavos, nota: nota)
        gastos.append(gasto)
        return gasto
    }
}
