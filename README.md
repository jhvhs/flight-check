# FlightCheck

A spike for a cross-platform tool for analysing build consistency for concourse jobs.

Building and running requires `macOS 13.0` or higher, or `Linux`.

## Usage
```text
  FlightCheck [flags...]
	-u, --url, environment variable: FC_CONCOURSE_URL
		Main Concourse URL
	-t, --team, environment variable: FC_CONCOURSE_TEAM
		Concourse team name
	-k, --token, environment variable: FC_CONCOURSE_TOKEN
		Concourse auth token, can be obtained by visiting <concourse-url>/login?fly_port=10987
	-p, --pipeline, environment variable: FC_CONCOURSE_PIPELINE
		Concourse pipeline name
	-j, --job, environment variable: FC_CONCOURSE_JOB
		Name of the job in the pipeline
	-c, --build-count, environment variable: FC_CONCOURSE_BUILD_COUNT
		(optional) The number of builds to analyse
	-h, --help
		Display help
```