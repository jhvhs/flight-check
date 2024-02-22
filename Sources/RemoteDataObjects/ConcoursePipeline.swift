// SPDX-License-Identifier: Apache-2.0

import Foundation

struct PipelineGroup: Codable {
    var name: String
    var jobs: [String]
}

struct ConcoursePipeline: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, groups
        case isPaused = "paused"
        case isArchived = "archived"
        case isPublic = "public"
        case teamName = "team_name"
        case lastUpdated = "last_updated"
    }

    var id: Int
    var name: String
    var isPaused: Bool
    var isArchived: Bool
    var isPublic: Bool
    var groups: [PipelineGroup]?
    var teamName: String
    var lastUpdated: Int?
}