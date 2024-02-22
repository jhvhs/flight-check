// SPDX-License-Identifier: Apache-2.0

#if canImport(FoundationNetworking)
import Foundation
import FoundationNetworking

// The async APIs aren't available in FoundationNetworking, but they can be defined

extension URLSession {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        return try await withUnsafeThrowingContinuation { continuation in
            let sessionDataTask = self.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                switch (data, response, error) {
                case (      nil,           nil, let error?): continuation.resume(throwing: error)
                case (let data?, let response?,        nil): continuation.resume(returning: (data, response))
                default: fatalError("The data and response should be non-nil if there's no error!")
                }
            }

            sessionDataTask.resume()
        }
    }
}
#endif
