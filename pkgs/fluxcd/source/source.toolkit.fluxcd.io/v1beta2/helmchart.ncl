# Module: helmchart.source.toolkit.fluxcd.io

let k8s_io_objectmeta = import "k8s_io" in

{
  HelmChart = {
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
      chart | String | doc m%"
Chart is the name or path the Helm chart is available at in the
SourceRef.
"%,
      ignoreMissingValuesFiles | optional | Bool | doc m%"
IgnoreMissingValuesFiles controls whether to silently ignore missing values
files rather than failing.
"%,
      interval | String | doc m%"
Interval at which the HelmChart SourceRef is checked for updates.
This interval is approximate and may be subject to jitter to ensure
efficient use of resources.
"%,
      reconcileStrategy | String | doc m%"
ReconcileStrategy determines what enables the creation of a new artifact.
Valid values are ('ChartVersion', 'Revision').
See the documentation of the values for an explanation on their behavior.
Defaults to ChartVersion when omitted.
"% | default = "ChartVersion",
      sourceRef | {
        apiVersion | optional | String | doc "APIVersion of the referent.",
        kind | String | doc m%"
Kind of the referent, valid values are ('HelmRepository', 'GitRepository',
'Bucket').
"%,
        name | String | doc "Name of the referent.",
      } | doc "SourceRef is the reference to the Source the chart is available at.",
      suspend | optional | Bool | doc m%"
Suspend tells the controller to suspend the reconciliation of this
source.
"%,
      valuesFile | optional | String | doc m%"
ValuesFile is an alternative values file to use as the default chart
values, expected to be a relative path in the SourceRef. Deprecated in
favor of ValuesFiles, for backwards compatibility the file specified here
is merged before the ValuesFiles items. Ignored when omitted.
"%,
      valuesFiles | optional | Array String | doc m%"
ValuesFiles is an alternative list of values files to use as the chart
values (values.yaml is not included by default), expected to be a
relative path in the SourceRef.
Values files are merged in the order of this list with the last file
overriding the first. Ignored when omitted.
"%,
      verify | optional | {
        matchOIDCIdentity | optional | Array {
          issuer | String | doc m%"
Issuer specifies the regex pattern to match against to verify
the OIDC issuer in the Fulcio certificate. The pattern must be a
valid Go regular expression.
"%,
          subject | String | doc m%"
Subject specifies the regex pattern to match against to verify
the identity subject in the Fulcio certificate. The pattern must
be a valid Go regular expression.
"%,
        } | doc m%"
MatchOIDCIdentity specifies the identity matching criteria to use
while verifying an OCI artifact which was signed using Cosign keyless
signing. The artifact's identity is deemed to be verified if any of the
specified matchers match against the identity.
"%,
        provider | String | doc "Provider specifies the technology used to sign the OCI Artifact." | default = "cosign",
        secretRef | optional | {
          name | String | doc "Name of the referent.",
        } | doc m%"
SecretRef specifies the Kubernetes Secret containing the
trusted public keys.
"%,
      } | doc m%"
Verify contains the secret name containing the trusted public keys
used to verify the signature and specifies which provider to use to check
whether OCI image is authentic.
This field is only supported when using HelmRepository source with spec.type 'oci'.
Chart dependencies, which are not bundled in the umbrella chart artifact, are not verified.
"%,
      version | String | doc m%"
Version is the chart version semver expression, ignored for charts from
GitRepository and Bucket sources. Defaults to latest when omitted.
"% | default = "*",
    } | doc "HelmChartSpec specifies the desired state of a Helm chart.",
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
      } | doc "Artifact represents the output of the last successful reconciliation.",
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
      } | doc "Conditions holds the conditions for the HelmChart.",
      lastHandledReconcileAt | optional | String | doc m%"
LastHandledReconcileAt holds the value of the most recent
reconcile request value, so a change of the annotation value
can be detected.
"%,
      observedChartName | optional | String | doc m%"
ObservedChartName is the last observed chart name as specified by the
resolved chart reference.
"%,
      observedGeneration | optional | Number | doc m%"
ObservedGeneration is the last observed generation of the HelmChart
object.
"%,
      observedSourceArtifactRevision | optional | String | doc m%"
ObservedSourceArtifactRevision is the last observed Artifact.Revision
of the HelmChartSpec.SourceRef.
"%,
      observedValuesFiles | optional | Array String | doc m%"
ObservedValuesFiles are the observed value files of the last successful
reconciliation.
It matches the chart in the last successfully reconciled artifact.
"%,
      url | optional | String | doc m%"
URL is the dynamic fetch link for the latest Artifact.
It is provided on a "best effort" basis, and using the precise
BucketStatus.Artifact data is recommended.
"%,
    } | doc "HelmChartStatus records the observed state of the HelmChart." | default = {
      observedGeneration = -1
    },
  },
}
