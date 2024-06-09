import Benchmark
import Foundation
import StringGenerator
import StringResource

let benchmarks = {
    Benchmark("StringGenerator.generateSource(for:tableName:accessLevel:)") { benchmark in
        let resources: [Resource] = (1...1000)
            .map { .mock(id: $0, includeArguments: $0 % 5 == 0) }

        benchmark.startMeasurement()
        for _ in benchmark.scaledIterations {
            blackHole(
                StringGenerator.generateSource(for: resources, tableName: "Localizable", accessLevel: .internal)
            )
        }
    }
}

extension Resource {
    static func mock(id: Int, includeArguments: Bool = false) -> Resource {
        Resource(
            key: "String\(id)",
            comment: "Resource for string \(id)",
            identifier: "string\(id)",
            arguments: id % 5 == 0 ? [.init(label: nil, name: "arg1", placeholderType: .object)] : [],
            sourceLocalization: "String \(id): %@"
        )
    }
}
