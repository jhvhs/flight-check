// SPDX-License-Identifier: Apache-2.0

#if canImport(FoundationNetworking)
import Foundation

extension URL {
    func appending(components: String...) -> URL {
        var newURL = self
        for i in components.indices {
            newURL = newURL.appendingPathComponent(components[i], isDirectory: (i < components.count - 1))
        }
        return newURL
    }
}
#endif
