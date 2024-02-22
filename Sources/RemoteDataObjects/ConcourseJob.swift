// SPDX-License-Identifier: Apache-2.0

import Foundation

struct ConcourseBuild: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, status
        case startTime = "start_time"
        case endTime = "end_time"
        case teamName = "team_name"
        case pipelineId = "pipeline_id"
        case pipelineName = "pipeline_name"
        case jobName = "job_name"
    }

    var id: Int
    var name: String
    var status: String
    var startTime: Int
    var endTime: Int
    var teamName: String
    var pipelineId: Int
    var pipelineName: String
    var jobName: String
}

struct JobInput: Codable {
    var name: String
    var resource: String
    var trigger: Bool?
    var passed: [String]?
}

struct ConcourseJob: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id, name, inputs
        case teamName = "team_name"
        case pipelineId = "pipeline_id"
        case pipelineName = "pipeline_name"
        case finishedBuild = "finished_build"
        case transitionBuild = "transition_build"
        case nextBuild = "next_build"
    }

    var id: Int
    var name: String
    var teamName: String
    var pipelineId: Int
    var pipelineName: String
    var finishedBuild: ConcourseBuild?
    var transitionBuild: ConcourseBuild?
    var nextBuild: ConcourseBuild?
    var inputs: [JobInput]?
}
