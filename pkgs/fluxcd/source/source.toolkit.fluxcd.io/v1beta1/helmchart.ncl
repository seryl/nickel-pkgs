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
AccessFrom defines an Access Control List for allowing cross-namespace references to this object.
"%,
      chart | String | doc "The name or path the Helm chart is available at in the SourceRef.",
      interval | String | doc "The interval at which to check the Source for updates.",
      reconcileStrategy | String | doc m%"
Determines what enables the creation of a new artifact. Valid values are
('ChartVersion', 'Revision').
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
      } | doc "The reference to the Source the chart is available at.",
      suspend | optional | Bool | doc "This flag tells the controller to suspend the reconciliation of this source.",
      valuesFile | optional | String | doc m%"
Alternative values file to use as the default chart values, expected to
be a relative path in the SourceRef. Deprecated in favor of ValuesFiles,
for backwards compatibility the file defined here is merged before the
ValuesFiles items. Ignored when omitted.
"%,
      valuesFiles | optional | Array String | doc m%"
Alternative list of values files to use as the chart values (values.yaml
is not included by default), expected to be a relative path in the SourceRef.
Values files are merged in the order of this list with the last file overriding
the first. Ignored when omitted.
"%,
      version | String | doc m%"
The chart version semver expression, ignored for charts from GitRepository
and Bucket sources. Defaults to latest when omitted.
"% | default = "*",
    } | doc "HelmChartSpec defines the desired state of a Helm chart.",
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
      } | doc "Artifact represents the output of the last successful chart sync.",
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
      observedGeneration | optional | Number | doc "ObservedGeneration is the last observed generation.",
      url | optional | String | doc "URL is the download link for the last chart pulled.",
    } | doc "HelmChartStatus defines the observed state of the HelmChart." | default = {
      observedGeneration = -1
    },
  },
}
