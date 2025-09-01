# Module: resolutionrequest.resolution.tekton.dev

let k8s_io_objectmeta = import "k8s_io" in

{
  ResolutionRequest = {
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
      params | optional | Array {
        name | String,
        value | Dyn,
      } | doc m%"
Parameters are the runtime attributes passed to
the resolver to help it figure out how to resolve the
resource being requested. For example: repo URL, commit SHA,
path to file, the kind of authentication to leverage, etc.
"%,
      url | optional | String | doc m%"
URL is the runtime url passed to the resolver
to help it figure out how to resolver the resource being
requested.
This is currently at an ALPHA stability level and subject to
alpha API compatibility policies.
"%,
    } | doc "Spec holds the information for the request part of the resource request.",
    status | optional | {
      annotations | optional | {
      } | doc m%"
Annotations is additional Status fields for the Resource to save some
additional State as well as convey more information to the user. This is
roughly akin to Annotations on any k8s resource, just the reconciler conveying
richer information outwards.
"%,
      conditions | optional | Array {
        lastTransitionTime | optional | String | doc m%"
LastTransitionTime is the last time the condition transitioned from one status to another.
We use VolatileTime in place of metav1.Time to exclude this from creating equality.Semantic
differences (all other things held constant).
"%,
        message | optional | String | doc "A human readable message indicating details about the transition.",
        reason | optional | String | doc "The reason for the condition's last transition.",
        severity | optional | String | doc m%"
Severity with which to treat failures of this type of condition.
When this is not specified, it defaults to Error.
"%,
        status | String | doc "Status of the condition, one of True, False, Unknown.",
        type | String | doc "Type of condition.",
      } | doc "Conditions the latest available observations of a resource's current state.",
      data | String | doc m%"
Data is a string representation of the resolved content
of the requested resource in-lined into the ResolutionRequest
object.
"%,
      observedGeneration | optional | Number | doc m%"
ObservedGeneration is the 'Generation' of the Service that
was last processed by the controller.
"%,
      refSource | Dyn | doc m%"
RefSource is the source reference of the remote data that records the url, digest
and the entrypoint.
"%,
      source | Dyn | doc "Deprecated: Use RefSource instead",
    } | doc m%"
Status communicates the state of the request and, ultimately,
the content of the resolved resource.
"%,
  },
}
