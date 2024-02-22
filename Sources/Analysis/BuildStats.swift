import Foundation

extension Collection<ConcourseBuild> {
    var successRate: Float? {
        guard self.count > 0 else { return nil}
        return Float(self.filter { $0.status == "succeeded" }.count) / Float(self.count)
    }
}