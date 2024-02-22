import Foundation

struct Flag {
    let shortFlag: String
    let longFlag: String?
    let environmentVariableName: String?
    let helpText: String

    var value: String? {
        return getValueForFlag(flag: longFlag) ?? getValueForFlag(flag: shortFlag) ?? getValueForEnvVar(varName: environmentVariableName)
    }

    var helpDescription: String {
        "\t\(shortFlag)\(longFlagDescription)\(envVarDescription)\n\t\t\(helpText)"
    }

    var flagPresent: Bool {
        CommandLine.arguments.firstIndex(of: shortFlag) != nil || (longFlag != nil && CommandLine.arguments.firstIndex(of: longFlag!) != nil)
    }

    private var longFlagDescription: String {
        longFlag != nil ? ", \(longFlag!)" : ""
    }
    private var envVarDescription: String {
        environmentVariableName != nil ? ", environment variable: \(environmentVariableName!)": ""
    }

    private func getValueForEnvVar(varName: String?) -> String? {
        if let v = varName, let result = ProcessInfo.processInfo.environment[v] {
            return result
        }
        return nil
    }

    private func getValueForFlag(flag: String?) -> String? {
        if let f = flag, let i = CommandLine.arguments.firstIndex(of: f) {
            if CommandLine.arguments.count > i + 1 {
                return CommandLine.arguments[i + 1]
            }
        }
        return nil
    }
}