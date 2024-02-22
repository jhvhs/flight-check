// SPDX-License-Identifier: Apache-2.0

import Foundation

struct ConcourseTeamAuthOwner: Codable {
    let groups: [String]
    let users: [String]
}

struct ConcourseTeamAuth: Codable {
    let owner: ConcourseTeamAuthOwner
}

struct ConcourseTeam: Codable {
    let id: Int
    let name: String
    let auth: ConcourseTeamAuth
}