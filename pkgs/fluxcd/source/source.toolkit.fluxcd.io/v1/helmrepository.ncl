# Module: helmrepository.source.toolkit.fluxcd.io

let k8s_io_objectmeta = import "k8s_io" in

{
  HelmRepository = {
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
      certSecretRef | optional | {
        name | String | doc "Name of the referent.",
      } | doc m%"
CertSecretRef can be given the name of a Secret containing
either or both of

- a PEM-encoded client certificate (`tls.crt`) and private
key (`tls.key`);
- a PEM-encoded CA certificate (`ca.crt`)

and whichever are supplied, will be used for connecting to the
registry. The client cert and key are useful if you are
authenticating with a certificate; the CA cert is useful if
you are using a self-signed server certificate. The Secret must
be of type `Opaque` or `kubernetes.io/tls`.

It takes precedence over the values specified in the Secret referred
to by `.spec.secretRef`.
"%,
      insecure | optional | Bool | doc m%"
Insecure allows connecting to a non-TLS HTTP container registry.
This field is only taken into account if the .spec.type field is set to 'oci'.
"%,
      interval | optional | String | doc m%"
Interval at which the HelmRepository URL is checked for updates.
This interval is approximate and may be subject to jitter to ensure
efficient use of resources.
"%,
      passCredentials | optional | Bool | doc m%"
PassCredentials allows the credentials from the SecretRef to be passed
on to a host that does not match the host as defined in URL.
This may be required if the host of the advertised chart URLs in the
index differ from the defined URL.
Enabling this should be done with caution, as it can potentially result
in credentials getting stolen in a MITM-attack.
"%,
      provider | String | doc m%"
Provider used for authentication, can be 'aws', 'azure', 'gcp' or 'generic'.
This field is optional, and only taken into account if the .spec.type field is set to 'oci'.
When not specified, defaults to 'generic'.
"% | default = "generic",
      secretRef | optional | {
        name | String | doc "Name of the referent.",
      } | doc m%"
SecretRef specifies the Secret containing authentication credentials
for the HelmRepository.
For HTTP/S basic auth the secret must contain 'username' and 'password'
fields.
Support for TLS auth using the 'certFile' and 'keyFile', and/or 'caFile'
keys is deprecated. Please use `.spec.certSecretRef` instead.
"%,
      suspend | optional | Bool | doc m%"
Suspend tells the controller to suspend the reconciliation of this
HelmRepository.
"%,
      timeout | optional | String | doc m%"
Timeout is used for the index fetch operation for an HTTPS helm repository,
and for remote OCI Repository operations like pulling for an OCI helm
chart by the associated HelmChart.
Its default value is 60s.
"%,
      type | optional | String | doc m%"
Type of the HelmRepository.
When this field is set to  "oci", the URL field value must be prefixed with "oci://".
"%,
      url | String | doc m%"
URL of the Helm repository, a valid URL contains at least a protocol and
host.
"%,
    } | doc m%"
HelmRepositorySpec specifies the required configuration to produce an
Artifact for a Helm repository index YAML.
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
      } | doc "Artifact represents the last successful HelmRepository reconciliation.",
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
      } | doc "Conditions holds the conditions for the HelmRepository.",
      lastHandledReconcileAt | optional | String | doc m%"
LastHandledReconcileAt holds the value of the most recent
reconcile request value, so a change of the annotation value
can be detected.
"%,
      observedGeneration | optional | Number | doc m%"
ObservedGeneration is the last observed generation of the HelmRepository
object.
"%,
      url | optional | String | doc m%"
URL is the dynamic fetch link for the latest Artifact.
It is provided on a "best effort" basis, and using the precise
HelmRepositoryStatus.Artifact data is recommended.
"%,
    } | doc "HelmRepositoryStatus records the observed state of the HelmRepository." | default = {
      observedGeneration = -1
    },
  },
}
