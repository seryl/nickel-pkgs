# Module: pipeline.tekton.dev

let k8s_io_objectmeta = import "k8s_io" in

{
  Pipeline = {
    apiVersion | optional | String | doc m%"
APIVersion defines the versioned schema of this representation of an object.
Servers should convert recognized schemas to the latest internal value, and
may reject unrecognized values.
More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
"%,
    kind | optional | String | doc m%"
Kind is a string value representing the REST resource this object represents.
Servers may infer this from the endpoint the client submits requests to.
Cannot be updated.
In CamelCase.
More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
"%,
    metadata | optional | k8s_io_objectmeta.ObjectMeta,
    spec | optional | {
      description | optional | String | doc m%"
Description is a user-facing description of the pipeline that may be
used to populate a UI.
"%,
      displayName | optional | String | doc m%"
DisplayName is a user-facing name of the pipeline that may be
used to populate a UI.
"%,
      finally | optional | Array {
        description | optional | String | doc m%"
Description is the description of this task within the context of a Pipeline.
This description may be used to populate a UI.
"%,
        displayName | optional | String | doc m%"
DisplayName is the display name of this task within the context of a Pipeline.
This display name may be used to populate a UI.
"%,
        matrix | optional | {
          include | optional | Array {
            name | optional | String | doc "Name the specified combination",
            params | optional | Array {
              name | String,
              value | Dyn,
            } | doc m%"
Params takes only `Parameters` of type `"string"`
The names of the `params` must match the names of the `params` in the underlying `Task`
"%,
          } | doc m%"
Include is a list of IncludeParams which allows passing in specific combinations of Parameters into the Matrix.
"%,
          params | optional | Array {
            name | String,
            value | Dyn,
          } | doc m%"
Params is a list of parameters used to fan out the pipelineTask
Params takes only `Parameters` of type `"array"`
Each array element is supplied to the `PipelineTask` by substituting `params` of type `"string"` in the underlying `Task`.
The names of the `params` in the `Matrix` must match the names of the `params` in the underlying `Task` that they will be substituting.
"%,
        } | doc "Matrix declares parameters used to fan out this task.",
        name | optional | String | doc m%"
Name is the name of this task within the context of a Pipeline. Name is
used as a coordinate with the `from` and `runAfter` fields to establish
the execution order of tasks relative to one another.
"%,
        onError | optional | String | doc m%"
OnError defines the exiting behavior of a PipelineRun on error
can be set to [ continue | stopAndFail ]
"%,
        params | optional | Array {
          name | String,
          value | Dyn,
        } | doc "Parameters declares parameters passed to this task.",
        pipelineRef | optional | {
          apiVersion | optional | String | doc "API version of the referent",
          name | optional | String | doc m%"
Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
"%,
          params | optional | Array {
            name | String,
            value | Dyn,
          } | doc m%"
Params contains the parameters used to identify the
referenced Tekton resource. Example entries might include
"repo" or "path" but the set of params ultimately depends on
the chosen resolver.
"%,
          resolver | optional | String | doc m%"
Resolver is the name of the resolver that should perform
resolution of the referenced Tekton resource, such as "git".
"%,
        } | doc m%"
PipelineRef is a reference to a pipeline definition
Note: PipelineRef is in preview mode and not yet supported
"%,
        pipelineSpec | optional | Dyn | doc m%"
PipelineSpec is a specification of a pipeline
Note: PipelineSpec is in preview mode and not yet supported
Specifying PipelineSpec can be disabled by setting
`disable-inline-spec` feature flag.
See Pipeline.spec (API version: tekton.dev/v1)
"%,
        retries | optional | Number | doc m%"
Retries represents how many times this task should be retried in case of task failure: ConditionSucceeded set to False
"%,
        runAfter | optional | Array String | doc m%"
RunAfter is the list of PipelineTask names that should be executed before
this Task executes. (Used to force a specific ordering in graph execution.)
"%,
        taskRef | optional | {
          apiVersion | optional | String | doc m%"
API version of the referent
Note: A Task with non-empty APIVersion and Kind is considered a Custom Task
"%,
          kind | optional | String | doc m%"
TaskKind indicates the Kind of the Task:
1. Namespaced Task when Kind is set to "Task". If Kind is "", it defaults to "Task".
2. Custom Task when Kind is non-empty and APIVersion is non-empty
"%,
          name | optional | String | doc m%"
Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
"%,
          params | optional | Array {
            name | String,
            value | Dyn,
          } | doc m%"
Params contains the parameters used to identify the
referenced Tekton resource. Example entries might include
"repo" or "path" but the set of params ultimately depends on
the chosen resolver.
"%,
          resolver | optional | String | doc m%"
Resolver is the name of the resolver that should perform
resolution of the referenced Tekton resource, such as "git".
"%,
        } | doc "TaskRef is a reference to a task definition.",
        taskSpec | optional | Dyn | doc m%"
TaskSpec is a specification of a task
Specifying TaskSpec can be disabled by setting
`disable-inline-spec` feature flag.
See Task.spec (API version: tekton.dev/v1)
"%,
        timeout | optional | String | doc m%"
Time after which the TaskRun times out. Defaults to 1 hour.
Refer Go's ParseDuration documentation for expected format: https://golang.org/pkg/time/#ParseDuration
"%,
        when | optional | Array {
          cel | optional | String | doc m%"
CEL is a string of Common Language Expression, which can be used to conditionally execute
the task based on the result of the expression evaluation
More info about CEL syntax: https://github.com/google/cel-spec/blob/master/doc/langdef.md
"%,
          input | optional | String | doc m%"
Input is the string for guard checking which can be a static input or an output from a parent Task
"%,
          operator | optional | String | doc "Operator that represents an Input's relationship to the values",
          values | optional | Array String | doc m%"
Values is an array of strings, which is compared against the input, for guard checking
It must be non-empty
"%,
        } | doc "When is a list of when expressions that need to be true for the task to run",
        workspaces | optional | Array {
          name | String | doc "Name is the name of the workspace as declared by the task",
          subPath | optional | String | doc m%"
SubPath is optionally a directory on the volume which should be used
for this binding (i.e. the volume will be mounted at this sub directory).
"%,
          workspace | optional | String | doc "Workspace is the name of the workspace declared by the pipeline",
        } | doc m%"
Workspaces maps workspaces from the pipeline spec to the workspaces
declared in the Task.
"%,
      } | doc m%"
Finally declares the list of Tasks that execute just before leaving the Pipeline
i.e. either after all Tasks are finished executing successfully
or after a failure which would result in ending the Pipeline
"%,
      params | optional | Array {
        default | optional | Dyn | doc m%"
Default is the value a parameter takes if no input value is supplied. If
default is set, a Task may be executed without a supplied value for the
parameter.
"%,
        description | optional | String | doc m%"
Description is a user-facing description of the parameter that may be
used to populate a UI.
"%,
        enum | optional | Array String | doc m%"
Enum declares a set of allowed param input values for tasks/pipelines that can be validated.
If Enum is not set, no input validation is performed for the param.
"%,
        name | String | doc "Name declares the name by which a parameter is referenced.",
        properties | optional | {
        } | doc "Properties is the JSON Schema properties to support key-value pairs parameter.",
        type | optional | String | doc m%"
Type is the user-specified type of the parameter. The possible types
are currently "string", "array" and "object", and "string" is the default.
"%,
      } | doc m%"
Params declares a list of input parameters that must be supplied when
this Pipeline is run.
"%,
      results | optional | Array {
        description | optional | String | doc "Description is a human-readable description of the result",
        name | String | doc "Name the given name",
        type | optional | String | doc m%"
Type is the user-specified type of the result.
The possible types are 'string', 'array', and 'object', with 'string' as the default.
'array' and 'object' types are alpha features.
"%,
        value | Dyn | doc "Value the expression used to retrieve the value",
      } | doc "Results are values that this pipeline can output once run",
      tasks | optional | Array {
        description | optional | String | doc m%"
Description is the description of this task within the context of a Pipeline.
This description may be used to populate a UI.
"%,
        displayName | optional | String | doc m%"
DisplayName is the display name of this task within the context of a Pipeline.
This display name may be used to populate a UI.
"%,
        matrix | optional | {
          include | optional | Array {
            name | optional | String | doc "Name the specified combination",
            params | optional | Array {
              name | String,
              value | Dyn,
            } | doc m%"
Params takes only `Parameters` of type `"string"`
The names of the `params` must match the names of the `params` in the underlying `Task`
"%,
          } | doc m%"
Include is a list of IncludeParams which allows passing in specific combinations of Parameters into the Matrix.
"%,
          params | optional | Array {
            name | String,
            value | Dyn,
          } | doc m%"
Params is a list of parameters used to fan out the pipelineTask
Params takes only `Parameters` of type `"array"`
Each array element is supplied to the `PipelineTask` by substituting `params` of type `"string"` in the underlying `Task`.
The names of the `params` in the `Matrix` must match the names of the `params` in the underlying `Task` that they will be substituting.
"%,
        } | doc "Matrix declares parameters used to fan out this task.",
        name | optional | String | doc m%"
Name is the name of this task within the context of a Pipeline. Name is
used as a coordinate with the `from` and `runAfter` fields to establish
the execution order of tasks relative to one another.
"%,
        onError | optional | String | doc m%"
OnError defines the exiting behavior of a PipelineRun on error
can be set to [ continue | stopAndFail ]
"%,
        params | optional | Array {
          name | String,
          value | Dyn,
        } | doc "Parameters declares parameters passed to this task.",
        pipelineRef | optional | {
          apiVersion | optional | String | doc "API version of the referent",
          name | optional | String | doc m%"
Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
"%,
          params | optional | Array {
            name | String,
            value | Dyn,
          } | doc m%"
Params contains the parameters used to identify the
referenced Tekton resource. Example entries might include
"repo" or "path" but the set of params ultimately depends on
the chosen resolver.
"%,
          resolver | optional | String | doc m%"
Resolver is the name of the resolver that should perform
resolution of the referenced Tekton resource, such as "git".
"%,
        } | doc m%"
PipelineRef is a reference to a pipeline definition
Note: PipelineRef is in preview mode and not yet supported
"%,
        pipelineSpec | optional | Dyn | doc m%"
PipelineSpec is a specification of a pipeline
Note: PipelineSpec is in preview mode and not yet supported
Specifying PipelineSpec can be disabled by setting
`disable-inline-spec` feature flag.
See Pipeline.spec (API version: tekton.dev/v1)
"%,
        retries | optional | Number | doc m%"
Retries represents how many times this task should be retried in case of task failure: ConditionSucceeded set to False
"%,
        runAfter | optional | Array String | doc m%"
RunAfter is the list of PipelineTask names that should be executed before
this Task executes. (Used to force a specific ordering in graph execution.)
"%,
        taskRef | optional | {
          apiVersion | optional | String | doc m%"
API version of the referent
Note: A Task with non-empty APIVersion and Kind is considered a Custom Task
"%,
          kind | optional | String | doc m%"
TaskKind indicates the Kind of the Task:
1. Namespaced Task when Kind is set to "Task". If Kind is "", it defaults to "Task".
2. Custom Task when Kind is non-empty and APIVersion is non-empty
"%,
          name | optional | String | doc m%"
Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
"%,
          params | optional | Array {
            name | String,
            value | Dyn,
          } | doc m%"
Params contains the parameters used to identify the
referenced Tekton resource. Example entries might include
"repo" or "path" but the set of params ultimately depends on
the chosen resolver.
"%,
          resolver | optional | String | doc m%"
Resolver is the name of the resolver that should perform
resolution of the referenced Tekton resource, such as "git".
"%,
        } | doc "TaskRef is a reference to a task definition.",
        taskSpec | optional | Dyn | doc m%"
TaskSpec is a specification of a task
Specifying TaskSpec can be disabled by setting
`disable-inline-spec` feature flag.
See Task.spec (API version: tekton.dev/v1)
"%,
        timeout | optional | String | doc m%"
Time after which the TaskRun times out. Defaults to 1 hour.
Refer Go's ParseDuration documentation for expected format: https://golang.org/pkg/time/#ParseDuration
"%,
        when | optional | Array {
          cel | optional | String | doc m%"
CEL is a string of Common Language Expression, which can be used to conditionally execute
the task based on the result of the expression evaluation
More info about CEL syntax: https://github.com/google/cel-spec/blob/master/doc/langdef.md
"%,
          input | optional | String | doc m%"
Input is the string for guard checking which can be a static input or an output from a parent Task
"%,
          operator | optional | String | doc "Operator that represents an Input's relationship to the values",
          values | optional | Array String | doc m%"
Values is an array of strings, which is compared against the input, for guard checking
It must be non-empty
"%,
        } | doc "When is a list of when expressions that need to be true for the task to run",
        workspaces | optional | Array {
          name | String | doc "Name is the name of the workspace as declared by the task",
          subPath | optional | String | doc m%"
SubPath is optionally a directory on the volume which should be used
for this binding (i.e. the volume will be mounted at this sub directory).
"%,
          workspace | optional | String | doc "Workspace is the name of the workspace declared by the pipeline",
        } | doc m%"
Workspaces maps workspaces from the pipeline spec to the workspaces
declared in the Task.
"%,
      } | doc "Tasks declares the graph of Tasks that execute when this Pipeline is run.",
      workspaces | optional | Array {
        description | optional | String | doc m%"
Description is a human readable string describing how the workspace will be
used in the Pipeline. It can be useful to include a bit of detail about which
tasks are intended to have access to the data on the workspace.
"%,
        name | String | doc "Name is the name of a workspace to be provided by a PipelineRun.",
        optional | optional | Bool | doc m%"
Optional marks a Workspace as not being required in PipelineRuns. By default
this field is false and so declared workspaces are required.
"%,
      } | doc m%"
Workspaces declares a set of named workspaces that are expected to be
provided by a PipelineRun.
"%,
    } | doc "Spec holds the desired state of the Pipeline from the client",
  },
}
