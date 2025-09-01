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
AccessFrom specifies an Access Control List for allowing cross-namespace
references to this object.
NOTE: Not implemented, provisional as of https://github.com/fluxcd/flux2/pull/2092
"%,
      bucketName | String | doc "BucketName is the name of the object storage bucket.",
      certSecretRef | optional | {
        name | String | doc "Name of the referent.",
      } | doc m%"
CertSecretRef can be given the name of a Secret containing
either or both of

- a PEM-encoded client certificate (`tls.crt`) and private
key (`tls.key`);
- a PEM-encoded CA certificate (`ca.crt`)

and whichever are supplied, will be used for connecting to the
bucket. The client cert and key are useful if you are
authenticating with a certificate; the CA cert is useful if
you are using a self-signed server certificate. The Secret must
be of type `Opaque` or `kubernetes.io/tls`.

This field is only supported for the `generic` provider.
"%,
      endpoint | String | doc "Endpoint is the object storage address the BucketName is located at.",
      ignore | optional | String | doc m%"
Ignore overrides the set of excluded patterns in the .sourceignore format
(which is the same as .gitignore). If not provided, a default will be used,
consult the documentation for your version to find out what those are.
"%,
      insecure | optional | Bool | doc "Insecure allows connecting to a non-TLS HTTP Endpoint.",
      interval | String | doc m%"
Interval at which the Bucket Endpoint is checked for updates.
This interval is approximate and may be subject to jitter to ensure
efficient use of resources.
"%,
      prefix | optional | String | doc "Prefix to use for server-side filtering of files in the Bucket.",
      provider | String | doc m%"
Provider of the object storage bucket.
Defaults to 'generic', which expects an S3 (API) compatible object
storage.
"% | default = "generic",
      proxySecretRef | optional | {
        name | String | doc "Name of the referent.",
      } | doc m%"
ProxySecretRef specifies the Secret containing the proxy configuration
to use while communicating with the Bucket server.
"%,
      region | optional | String | doc "Region of the Endpoint where the BucketName is located in.",
      secretRef | optional | {
        name | String | doc "Name of the referent.",
      } | doc m%"
SecretRef specifies the Secret containing authentication credentials
for the Bucket.
"%,
      sts | optional | {
        certSecretRef | optional | {
          name | String | doc "Name of the referent.",
        } | doc m%"
CertSecretRef can be given the name of a Secret containing
either or both of

- a PEM-encoded client certificate (`tls.crt`) and private
key (`tls.key`);
- a PEM-encoded CA certificate (`ca.crt`)

and whichever are supplied, will be used for connecting to the
STS endpoint. The client cert and key are useful if you are
authenticating with a certificate; the CA cert is useful if
you are using a self-signed server certificate. The Secret must
be of type `Opaque` or `kubernetes.io/tls`.

This field is only supported for the `ldap` provider.
"%,
        endpoint | String | doc m%"
Endpoint is the HTTP/S endpoint of the Security Token Service from
where temporary credentials will be fetched.
"%,
        provider | String | doc "Provider of the Security Token Service.",
        secretRef | optional | {
          name | String | doc "Name of the referent.",
        } | doc m%"
SecretRef specifies the Secret containing authentication credentials
for the STS endpoint. This Secret must contain the fields `username`
and `password` and is supported only for the `ldap` provider.
"%,
      } | doc m%"
STS specifies the required configuration to use a Security Token
Service for fetching temporary credentials to authenticate in a
Bucket provider.

This field is only supported for the `aws` and `generic` providers.
"%,
      suspend | optional | Bool | doc m%"
Suspend tells the controller to suspend the reconciliation of this
Bucket.
"%,
      timeout | String | doc "Timeout for fetch operations, defaults to 60s." | default = "60s",
    } | doc m%"
BucketSpec specifies the required configuration to produce an Artifact for
an object storage bucket.
"%,
    status | {
      artifact | optional | {
        digest | optional | String | doc "Digest is the digest of the file in the form of '<algorithm>:<checksum>'.",
        lastUpdateTime | String | doc m%"
LastUpdateTime is the timestamp corresponding to the last update of the
Artifact.
"%,
        metadata | optional | k8s_io_objectmeta.ObjectMeta | doc "Metadata holds upstream information such as OCI annotations.",
        path | String | doc m%"
Path is the relative file path of the Artifact. It can be used to locate
the file in the root of the Artifact storage on the local file system of
the controller managing the Source.
"%,
        revision | String | doc m%"
Revision is a human-readable identifier traceable in the origin source
system. It can be a Git commit SHA, Git tag, a Helm chart version, etc.
"%,
        size | optional | Number | doc "Size is the number of bytes in the file.",
        url | String | doc m%"
URL is the HTTP address of the Artifact as exposed by the controller
managing the Source. It can be used to retrieve the Artifact for
consumption, e.g. by another controller applying the Artifact contents.
"%,
      } | doc "Artifact represents the last successful Bucket reconciliation.",
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
      observedGeneration | optional | Number | doc "ObservedGeneration is the last observed generation of the Bucket object.",
      observedIgnore | optional | String | doc m%"
ObservedIgnore is the observed exclusion patterns used for constructing
the source artifact.
"%,
      url | optional | String | doc m%"
URL is the dynamic fetch link for the latest Artifact.
It is provided on a "best effort" basis, and using the precise
BucketStatus.Artifact data is recommended.
"%,
    } | doc "BucketStatus records the observed state of a Bucket." | default = {
      observedGeneration = -1
    },
  },
}
