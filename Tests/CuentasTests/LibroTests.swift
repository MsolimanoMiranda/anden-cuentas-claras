import CuentasDomain
import CuentasPresentation
import XCTest

final class LibroTests: XCTestCase {
    func testElTopeFrenaElGastoYElViewModelLoCuenta() throws {
        let libro = LibroDeCuentas(topeMensual: 1_000)
        let modelo = CuentasViewModel(libro: libro)
        modelo.agregar(categoria: "Mercado", montoCentavos: 700, nota: "verduras")
        modelo.agregar(categoria: "Café", montoCentavos: 400, nota: "de más")

        XCTAssertEqual(modelo.estado.total, 700)
        XCTAssertEqual(modelo.estado.gastos.count, 1)
        XCTAssertEqual(modelo.estado.mensaje, "Ese gasto pasa el tope del mes")
        XCTAssertThrowsError(try libro.registrar(categoria: " ", montoCentavos: 10, nota: "")) { error in
            XCTAssertEqual(error as? ErrorLibro, .categoriaVacia)
        }
    }
}
