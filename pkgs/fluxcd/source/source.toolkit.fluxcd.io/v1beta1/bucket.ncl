# Module: bucket.source.toolkit.fluxcd.io

let k8s_io_objectmeta = import "k8s_io" in

{
  Bucket = {
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
      accessFrom | optional | {
        namespaceSelectors | Array {
          matchLabels | optional | {
          } | doc m%"
MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels
map is equivalent to an element of matchExpressions, whose key field is "key", the
operator is "In", and the values array contains only "value". The requirements are ANDed.
"%,
        } | doc m%"
NamespaceSelectors is the list of namespace selectors to which this ACL applies.
Items in this list are evaluated using a logical OR operation.
"%,
      } | doc m%"
AccessFrom defines an Access Control List for allowing cross-namespace references to this object.
"%,
      bucketName | String | doc "The bucket name.",
      endpoint | String | doc "The bucket endpoint address.",
      ignore | optional | String | doc m%"
Ignore overrides the set of excluded patterns in the .sourceignore format
(which is the same as .gitignore). If not provided, a default will be used,
consult the documentation for your version to find out what those are.
"%,
      insecure | optional | Bool | doc "Insecure allows connecting to a non-TLS S3 HTTP endpoint.",
      interval | String | doc "The interval at which to check for bucket updates.",
      provider | String | doc "The S3 compatible storage provider name, default ('generic')." | default = "generic",
      region | optional | String | doc "The bucket region.",
      secretRef | optional | {
        name | String | doc "Name of the referent.",
      } | doc m%"
The name of the secret containing authentication credentials
for the Bucket.
"%,
      suspend | optional | Bool | doc "This flag tells the controller to suspend the reconciliation of this source.",
      timeout | String | doc "The timeout for download operations, defaults to 60s." | default = "60s",
    } | doc "BucketSpec defines the desired state of an S3 compatible bucket",
    status | {
      artifact | optional | {
        checksum | optional | String | doc "Checksum is the SHA256 checksum of the artifact.",
        lastUpdateTime | String | doc m%"
LastUpdateTime is the timestamp corresponding to the last update of this
artifact.
"%,
        path | String | doc "Path is the relative file path of this artifact.",
        revision | optional | String | doc m%"
Revision is a human readable identifier traceable in the origin source
system. It can be a Git commit SHA, Git tag, a Helm index timestamp, a Helm
chart version, etc.
"%,
        url | String | doc "URL is the HTTP address of this artifact.",
      } | doc "Artifact represents the output of the last successful Bucket sync.",
      conditions | optional | Array {
        lastTransitionTime | String | doc m%"
lastTransitionTime is the last time the condition transitioned from one status to another.
This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
"%,
        message | String | doc m%"
message is a human readable message indicating details about the transition.
This may be an empty string.
"%,
        observedGeneration | optional | Number | doc m%"
observedGeneration represents the .metadata.generation that the condition was set based upon.
For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
with respect to the current state of the instance.
"%,
        reason | String | doc m%"
reason contains a programmatic identifier indicating the reason for the condition's last transition.
Producers of specific condition types may define expected values and meanings for this field,
and whether the values are considered a guaranteed API.
The value should be a CamelCase string.
This field may not be empty.
"%,
        status | String | doc "status of the condition, one of True, False, Unknown.",
        type | String | doc "type of condition in CamelCase or in foo.example.com/CamelCase.",
      } | doc "Conditions holds the conditions for the Bucket.",
      lastHandledReconcileAt | optional | String | doc m%"
LastHandledReconcileAt holds the value of the most recent
reconcile request value, so a change of the annotation value
can be detected.
"%,
      observedGeneration | optional | Number | doc "ObservedGeneration is the last observed generation.",
      url | optional | String | doc "URL is the download link for the artifact output of the last Bucket sync.",
    } | doc "BucketStatus defines the observed state of a bucket" | default = {
      observedGeneration = -1
    },
  },
}
