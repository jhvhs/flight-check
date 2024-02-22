// SPDX-License-Identifier: Apache-2.0

import Foundation

let urlFlag = Flag(shortFlag: "-u", longFlag: "--url", environmentVariableName: "FC_CONCOURSE_URL", helpText: "Main Concourse URL")
let teamFlag = Flag(shortFlag: "-t", longFlag: "--team", environmentVariableName: "FC_CONCOURSE_TEAM", helpText: "Concourse team name")
let helpFlag = Flag(shortFlag: "-h", longFlag: "--help", environmentVariableName: nil, helpText: "Display help")
let tokenFlag = Flag(shortFlag: "-k", longFlag: "--token", environmentVariableName: "FC_CONCOURSE_TOKEN", 
    helpText: "Concourse auth token, can be obtained by visiting \(urlFlag.value?.trimmingCharacters(in: CharacterSet(charactersIn: "/")) ?? "<concourse-url>")/login?fly_port=10987")
let pipelineFlag = Flag(shortFlag: "-p", longFlag: "--pipeline", environmentVariableName: "FC_CONCOURSE_PIPELINE", helpText: "Concourse pipeline name")
let jobFlag = Flag(shortFlag: "-j", longFlag: "--job", environmentVariableName: "FC_CONCOURSE_JOB", helpText: "Name of the job in the pipeline")
let buildCountFlag = Flag(shortFlag: "-c", longFlag: "--build-count", environmentVariableName: "FC_CONCOURSE_BUILD_COUNT", helpText: "(optional) The number of builds to analyse")

if helpFlag.flagPresent {
    displayHelp()
    exit(0)
}

var buildCount: Int?
var flagFailures = [String]()

let url = if let value = urlFlag.value {
    value
} else {
    "\(flagFailures.append("Concourse URL is required"))"
}

let team = if let value = teamFlag.value {
    value
} else {
    "\(flagFailures.append("Concourse team is required"))"
}

let token = if let value = tokenFlag.value {
    value
} else {
    "\(flagFailures.append("Concourse auth token is required"))"
}

let pipeline = if let value = pipelineFlag.value {
    value
} else {
    "\(flagFailures.append("Concourse pipeline name is required"))"
}

let job = if let value = jobFlag.value {
    value
} else {
    "\(flagFailures.append("Concourse job name is required"))"
}

if let value = buildCountFlag.value {
    if let intValue = Int(value) {
        buildCount = intValue
    } else {
        buildCount = 0
        flagFailures.append("Build count has to be a number, but was \(value)")
    }
}

if !flagFailures.isEmpty {
    print("The following flags weren't set, or mis-set")
    flagFailures.forEach { print($0) }
    exit(1)
}

if #available(macOS 13.0, *) {
    var builds = [ConcourseBuild]()

    let fetcher = ConcourseDataFetcher(concourseURLString: url, teamName: team, concourseToken: token)
    do {
        builds = try await fetcher.fetchBuildData(pipeline: pipeline, job: job)
    } catch ConcourseDataFetcher.FetcherError.authenticationError {
        print("Authentication failed")
        exit(1)
    }

    if builds.isEmpty {
        print("The job \(job) in the pipeline \(pipeline) has no builds")
        exit(0)
    }
    
    builds.sort(by: { $0.id < $1.id})
    if let count = buildCount {
        print("The success rate for the last \(min(builds.count, count)) builds of the \(job) job in the \(pipeline) pipeline is \(builds[max(0, (builds.count - count))..<builds.count].successRate!)")
    } else {
        print("The success rate of the job \(job) in the \(pipeline) pipeline is \(builds.successRate!)")
    }
    
} else {
    print("Unable to run here - Requires macOS 13.0+ or Linux")
}

func displayHelp() {
    print("FlightCheck")
    print("A CLI to display success rate of concourse job builds.\nUsage:\n  FlightCheck [flags...]")
    [urlFlag, teamFlag, tokenFlag, pipelineFlag, jobFlag, buildCountFlag, helpFlag].forEach { print($0.helpDescription) }
}
