# Module: taskrun.tekton.dev

let k8s_io_envfromsource = import "k8s_io" in
let k8s_io_volumemount = import "k8s_io" in
let k8s_io_objectmeta = import "k8s_io" in
let k8s_io_envvar = import "k8s_io" in
let k8s_io_toleration = import "k8s_io" in

{
  TaskRun = {
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
    metadata | optional | k8s_io_envfromsource.ObjectMeta,
    spec | optional | {
      computeResources | optional | {
        claims | optional | Array {
          name | String | doc m%"
Name must match the name of one entry in pod.spec.resourceClaims of
the Pod where this field is used. It makes that resource available
inside a container.
"%,
          request | optional | String | doc m%"
Request is the name chosen for a request in the referenced claim.
If empty, everything from the claim is made available, otherwise
only the result of this request.
"%,
        } | doc m%"
Claims lists the names of resources, defined in spec.resourceClaims,
that are used by this container.

This is an alpha field and requires enabling the
DynamicResourceAllocation feature gate.

This field is immutable. It can only be set for containers.
"%,
        limits | optional | {
        } | doc m%"
Limits describes the maximum amount of compute resources allowed.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
        requests | optional | {
        } | doc m%"
Requests describes the minimum amount of compute resources required.
If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
otherwise to an implementation-defined value. Requests cannot exceed Limits.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
      } | doc "Compute resources to use for this TaskRun",
      debug | optional | {
        breakpoints | optional | {
          beforeSteps | optional | Array String,
          onFailure | optional | String | doc m%"
if enabled, pause TaskRun on failure of a step
failed step will not exit
"%,
        } | doc "TaskBreakpoints defines the breakpoint config for a particular Task",
      } | doc "TaskRunDebug defines the breakpoint config for a particular TaskRun",
      params | optional | Array {
        name | String,
        value | Dyn,
      } | doc "Params is a list of Param",
      podTemplate | optional | {
        affinity | optional | Dyn | doc m%"
If specified, the pod's scheduling constraints.
See Pod.spec.affinity (API version: v1)
"%,
        automountServiceAccountToken | optional | Bool | doc m%"
AutomountServiceAccountToken indicates whether pods running as this
service account should have an API token automatically mounted.
"%,
        dnsConfig | optional | {
          nameservers | optional | Array String | doc m%"
A list of DNS name server IP addresses.
This will be appended to the base nameservers generated from DNSPolicy.
Duplicated nameservers will be removed.
"%,
          options | optional | Array {
            name | optional | String | doc m%"
Name is this DNS resolver option's name.
Required.
"%,
            value | optional | String | doc "Value is this DNS resolver option's value.",
          } | doc m%"
A list of DNS resolver options.
This will be merged with the base options generated from DNSPolicy.
Duplicated entries will be removed. Resolution options given in Options
will override those that appear in the base DNSPolicy.
"%,
          searches | optional | Array String | doc m%"
A list of DNS search domains for host-name lookup.
This will be appended to the base search paths generated from DNSPolicy.
Duplicated search paths will be removed.
"%,
        } | doc m%"
Specifies the DNS parameters of a pod.
Parameters specified here will be merged to the generated DNS
configuration based on DNSPolicy.
"%,
        dnsPolicy | optional | String | doc m%"
Set DNS policy for the pod. Defaults to "ClusterFirst". Valid values are
'ClusterFirst', 'Default' or 'None'. DNS parameters given in DNSConfig
will be merged with the policy selected with DNSPolicy.
"%,
        enableServiceLinks | optional | Bool | doc m%"
EnableServiceLinks indicates whether information about services should be injected into pod's
environment variables, matching the syntax of Docker links.
Optional: Defaults to true.
"%,
        env | optional | Array k8s_io_envfromsource.EnvVar | doc m%"
List of environment variables that can be provided to the containers belonging to the pod.
"%,
        hostAliases | optional | Array {
          hostnames | optional | Array String | doc "Hostnames for the above IP address.",
          ip | String | doc "IP address of the host file entry.",
        } | doc m%"
HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts
file if specified. This is only valid for non-hostNetwork pods.
"%,
        hostNetwork | optional | Bool | doc "HostNetwork specifies whether the pod may use the node network namespace",
        imagePullSecrets | optional | Array {
          name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
        } | doc m%"
ImagePullSecrets gives the name of the secret used by the pod to pull the image if specified
"%,
        nodeSelector | optional | {
        } | doc m%"
NodeSelector is a selector which must be true for the pod to fit on a node.
Selector which must match a node's labels for the pod to be scheduled on that node.
More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
"%,
        priorityClassName | optional | String | doc m%"
If specified, indicates the pod's priority. "system-node-critical" and
"system-cluster-critical" are two special keywords which indicate the
highest priorities with the former being the highest priority. Any other
name must be defined by creating a PriorityClass object with that name.
If not specified, the pod priority will be default or zero if there is no
default.
"%,
        runtimeClassName | optional | String | doc m%"
RuntimeClassName refers to a RuntimeClass object in the node.k8s.io
group, which should be used to run this pod. If no RuntimeClass resource
matches the named class, the pod will not be run. If unset or empty, the
"legacy" RuntimeClass will be used, which is an implicit class with an
empty definition that uses the default runtime handler.
More info: https://git.k8s.io/enhancements/keps/sig-node/runtime-class.md
This is a beta feature as of Kubernetes v1.14.
"%,
        schedulerName | optional | String | doc "SchedulerName specifies the scheduler to be used to dispatch the Pod",
        securityContext | optional | Dyn | doc m%"
SecurityContext holds pod-level security attributes and common container settings.
Optional: Defaults to empty.  See type description for default values of each field.
See Pod.spec.securityContext (API version: v1)
"%,
        tolerations | optional | Array k8s_io_envfromsource.Toleration | doc "If specified, the pod's tolerations.",
        topologySpreadConstraints | optional | Array {
          labelSelector | optional | {
            matchExpressions | optional | Array {
              key | String | doc "key is the label key that the selector applies to.",
              operator | String | doc m%"
operator represents a key's relationship to a set of values.
Valid operators are In, NotIn, Exists and DoesNotExist.
"%,
              values | optional | Array String | doc m%"
values is an array of string values. If the operator is In or NotIn,
the values array must be non-empty. If the operator is Exists or DoesNotExist,
the values array must be empty. This array is replaced during a strategic
merge patch.
"%,
            } | doc m%"
matchExpressions is a list of label selector requirements. The requirements are ANDed.
"%,
            matchLabels | optional | {
            } | doc m%"
matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels
map is equivalent to an element of matchExpressions, whose key field is "key", the
operator is "In", and the values array contains only "value". The requirements are ANDed.
"%,
          } | doc m%"
LabelSelector is used to find matching pods.
Pods that match this label selector are counted to determine the number of pods
in their corresponding topology domain.
"%,
          matchLabelKeys | optional | Array String | doc m%"
MatchLabelKeys is a set of pod label keys to select the pods over which
spreading will be calculated. The keys are used to lookup values from the
incoming pod labels, those key-value labels are ANDed with labelSelector
to select the group of existing pods over which spreading will be calculated
for the incoming pod. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector.
MatchLabelKeys cannot be set when LabelSelector isn't set.
Keys that don't exist in the incoming pod labels will
be ignored. A null or empty list means only match against labelSelector.

This is a beta field and requires the MatchLabelKeysInPodTopologySpread feature gate to be enabled (enabled by default).
"%,
          maxSkew | Number | doc m%"
MaxSkew describes the degree to which pods may be unevenly distributed.
When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference
between the number of matching pods in the target topology and the global minimum.
The global minimum is the minimum number of matching pods in an eligible domain
or zero if the number of eligible domains is less than MinDomains.
For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same
labelSelector spread as 2/2/1:
In this case, the global minimum is 1.
| zone1 | zone2 | zone3 |
|  P P  |  P P  |   P   |
- if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 2/2/2;
scheduling it onto zone1(zone2) would make the ActualSkew(3-1) on zone1(zone2)
violate MaxSkew(1).
- if MaxSkew is 2, incoming pod can be scheduled onto any zone.
When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence
to topologies that satisfy it.
It's a required field. Default value is 1 and 0 is not allowed.
"%,
          minDomains | optional | Number | doc m%"
MinDomains indicates a minimum number of eligible domains.
When the number of eligible domains with matching topology keys is less than minDomains,
Pod Topology Spread treats "global minimum" as 0, and then the calculation of Skew is performed.
And when the number of eligible domains with matching topology keys equals or greater than minDomains,
this value has no effect on scheduling.
As a result, when the number of eligible domains is less than minDomains,
scheduler won't schedule more than maxSkew Pods to those domains.
If value is nil, the constraint behaves as if MinDomains is equal to 1.
Valid values are integers greater than 0.
When value is not nil, WhenUnsatisfiable must be DoNotSchedule.

For example, in a 3-zone cluster, MaxSkew is set to 2, MinDomains is set to 5 and pods with the same
labelSelector spread as 2/2/2:
| zone1 | zone2 | zone3 |
|  P P  |  P P  |  P P  |
The number of domains is less than 5(MinDomains), so "global minimum" is treated as 0.
In this situation, new pod with the same labelSelector cannot be scheduled,
because computed skew will be 3(3 - 0) if new Pod is scheduled to any of the three zones,
it will violate MaxSkew.
"%,
          nodeAffinityPolicy | optional | String | doc m%"
NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector
when calculating pod topology spread skew. Options are:
- Honor: only nodes matching nodeAffinity/nodeSelector are included in the calculations.
- Ignore: nodeAffinity/nodeSelector are ignored. All nodes are included in the calculations.

If this value is nil, the behavior is equivalent to the Honor policy.
This is a beta-level feature default enabled by the NodeInclusionPolicyInPodTopologySpread feature flag.
"%,
          nodeTaintsPolicy | optional | String | doc m%"
NodeTaintsPolicy indicates how we will treat node taints when calculating
pod topology spread skew. Options are:
- Honor: nodes without taints, along with tainted nodes for which the incoming pod
has a toleration, are included.
- Ignore: node taints are ignored. All nodes are included.

If this value is nil, the behavior is equivalent to the Ignore policy.
This is a beta-level feature default enabled by the NodeInclusionPolicyInPodTopologySpread feature flag.
"%,
          topologyKey | String | doc m%"
TopologyKey is the key of node labels. Nodes that have a label with this key
and identical values are considered to be in the same topology.
We consider each <key, value> as a "bucket", and try to put balanced number
of pods into each bucket.
We define a domain as a particular instance of a topology.
Also, we define an eligible domain as a domain whose nodes meet the requirements of
nodeAffinityPolicy and nodeTaintsPolicy.
e.g. If TopologyKey is "kubernetes.io/hostname", each Node is a domain of that topology.
And, if TopologyKey is "topology.kubernetes.io/zone", each zone is a domain of that topology.
It's a required field.
"%,
          whenUnsatisfiable | String | doc m%"
WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy
the spread constraint.
- DoNotSchedule (default) tells the scheduler not to schedule it.
- ScheduleAnyway tells the scheduler to schedule the pod in any location,
  but giving higher precedence to topologies that would help reduce the
  skew.
A constraint is considered "Unsatisfiable" for an incoming pod
if and only if every possible node assignment for that pod would violate
"MaxSkew" on some topology.
For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same
labelSelector spread as 3/1/1:
| zone1 | zone2 | zone3 |
| P P P |   P   |   P   |
If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled
to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies
MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler
won't make it *more* imbalanced.
It's a required field.
"%,
        } | doc m%"
TopologySpreadConstraints controls how Pods are spread across your cluster among
failure-domains such as regions, zones, nodes, and other user-defined topology domains.
"%,
        volumes | optional | Dyn | doc m%"
List of volumes that can be mounted by containers belonging to the pod.
More info: https://kubernetes.io/docs/concepts/storage/volumes
See Pod.spec.volumes (API version: v1)
"%,
      } | doc "PodTemplate holds pod specific configuration",
      retries | optional | Number | doc m%"
Retries represents how many times this TaskRun should be retried in the event of task failure.
"%,
      serviceAccountName | optional | String,
      sidecarSpecs | optional | Array {
        computeResources | {
          claims | optional | Array {
            name | String | doc m%"
Name must match the name of one entry in pod.spec.resourceClaims of
the Pod where this field is used. It makes that resource available
inside a container.
"%,
            request | optional | String | doc m%"
Request is the name chosen for a request in the referenced claim.
If empty, everything from the claim is made available, otherwise
only the result of this request.
"%,
          } | doc m%"
Claims lists the names of resources, defined in spec.resourceClaims,
that are used by this container.

This is an alpha field and requires enabling the
DynamicResourceAllocation feature gate.

This field is immutable. It can only be set for containers.
"%,
          limits | optional | {
          } | doc m%"
Limits describes the maximum amount of compute resources allowed.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
          requests | optional | {
          } | doc m%"
Requests describes the minimum amount of compute resources required.
If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
otherwise to an implementation-defined value. Requests cannot exceed Limits.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
        } | doc "The resource requirements to apply to the Sidecar.",
        name | String | doc "The name of the Sidecar to override.",
      } | doc m%"
Specs to apply to Sidecars in this TaskRun.
If a field is specified in both a Sidecar and a SidecarSpec,
the value from the SidecarSpec will be used.
This field is only supported when the alpha feature gate is enabled.
"%,
      status | optional | String | doc "Used for cancelling a TaskRun (and maybe more later on)",
      statusMessage | optional | String | doc "Status message for cancellation.",
      stepSpecs | optional | Array {
        computeResources | {
          claims | optional | Array {
            name | String | doc m%"
Name must match the name of one entry in pod.spec.resourceClaims of
the Pod where this field is used. It makes that resource available
inside a container.
"%,
            request | optional | String | doc m%"
Request is the name chosen for a request in the referenced claim.
If empty, everything from the claim is made available, otherwise
only the result of this request.
"%,
          } | doc m%"
Claims lists the names of resources, defined in spec.resourceClaims,
that are used by this container.

This is an alpha field and requires enabling the
DynamicResourceAllocation feature gate.

This field is immutable. It can only be set for containers.
"%,
          limits | optional | {
          } | doc m%"
Limits describes the maximum amount of compute resources allowed.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
          requests | optional | {
          } | doc m%"
Requests describes the minimum amount of compute resources required.
If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
otherwise to an implementation-defined value. Requests cannot exceed Limits.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
        } | doc "The resource requirements to apply to the Step.",
        name | String | doc "The name of the Step to override.",
      } | doc m%"
Specs to apply to Steps in this TaskRun.
If a field is specified in both a Step and a StepSpec,
the value from the StepSpec will be used.
This field is only supported when the alpha feature gate is enabled.
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
      } | doc "no more than one of the TaskRef and TaskSpec may be specified.",
      taskSpec | optional | Dyn | doc m%"
Specifying TaskSpec can be disabled by setting
`disable-inline-spec` feature flag.
See Task.spec (API version: tekton.dev/v1)
"%,
      timeout | optional | String | doc m%"
Time after which one retry attempt times out. Defaults to 1 hour.
Refer Go's ParseDuration documentation for expected format: https://golang.org/pkg/time/#ParseDuration
"%,
      workspaces | optional | Array {
        configMap | optional | {
          defaultMode | optional | Number | doc m%"
defaultMode is optional: mode bits used to set permissions on created files by default.
Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
Defaults to 0644.
Directories within the path are not affected by this setting.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
          items | optional | Array {
            key | String | doc "key is the key to project.",
            mode | optional | Number | doc m%"
mode is Optional: mode bits used to set permissions on this file.
Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
If not specified, the volume defaultMode will be used.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
            path | String | doc m%"
path is the relative path of the file to map the key to.
May not be an absolute path.
May not contain the path element '..'.
May not start with the string '..'.
"%,
          } | doc m%"
items if unspecified, each key-value pair in the Data field of the referenced
ConfigMap will be projected into the volume as a file whose name is the
key and content is the value. If specified, the listed keys will be
projected into the specified paths, and unlisted keys will not be
present. If a key is specified which is not present in the ConfigMap,
the volume setup will error unless it is marked optional. Paths must be
relative and may not contain the '..' path or start with '..'.
"%,
          name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          "optional" | optional | Bool | doc "optional specify whether the ConfigMap or its keys must be defined",
        } | doc "ConfigMap represents a configMap that should populate this workspace.",
        csi | optional | {
          driver | String | doc m%"
driver is the name of the CSI driver that handles this volume.
Consult with your admin for the correct name as registered in the cluster.
"%,
          fsType | optional | String | doc m%"
fsType to mount. Ex. "ext4", "xfs", "ntfs".
If not provided, the empty value is passed to the associated CSI driver
which will determine the default filesystem to apply.
"%,
          nodePublishSecretRef | optional | {
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          } | doc m%"
nodePublishSecretRef is a reference to the secret object containing
sensitive information to pass to the CSI driver to complete the CSI
NodePublishVolume and NodeUnpublishVolume calls.
This field is optional, and  may be empty if no secret is required. If the
secret object contains more than one secret, all secret references are passed.
"%,
          readOnly | optional | Bool | doc m%"
readOnly specifies a read-only configuration for the volume.
Defaults to false (read/write).
"%,
          volumeAttributes | optional | {
          } | doc m%"
volumeAttributes stores driver-specific properties that are passed to the CSI
driver. Consult your driver's documentation for supported values.
"%,
        } | doc m%"
CSI (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers.
"%,
        emptyDir | optional | {
          medium | optional | String | doc m%"
medium represents what type of storage medium should back this directory.
The default is "" which means to use the node's default medium.
Must be an empty string (default) or Memory.
More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
"%,
          sizeLimit | optional | Number | String | doc m%"
sizeLimit is the total amount of local storage required for this EmptyDir volume.
The size limit is also applicable for memory medium.
The maximum usage on memory medium EmptyDir would be the minimum value between
the SizeLimit specified here and the sum of memory limits of all containers in a pod.
The default is nil which means that the limit is undefined.
More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
"%,
        } | doc m%"
EmptyDir represents a temporary directory that shares a Task's lifetime.
More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
Either this OR PersistentVolumeClaim can be used.
"%,
        name | String | doc "Name is the name of the workspace populated by the volume.",
        persistentVolumeClaim | optional | {
          claimName | String | doc m%"
claimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume.
More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
"%,
          readOnly | optional | Bool | doc m%"
readOnly Will force the ReadOnly setting in VolumeMounts.
Default false.
"%,
        } | doc m%"
PersistentVolumeClaimVolumeSource represents a reference to a
PersistentVolumeClaim in the same namespace. Either this OR EmptyDir can be used.
"%,
        projected | optional | {
          defaultMode | optional | Number | doc m%"
defaultMode are the mode bits used to set permissions on created files by default.
Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
Directories within the path are not affected by this setting.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
          sources | optional | Array {
            clusterTrustBundle | optional | {
              labelSelector | optional | {
                matchExpressions | optional | Array {
                  key | String | doc "key is the label key that the selector applies to.",
                  operator | String | doc m%"
operator represents a key's relationship to a set of values.
Valid operators are In, NotIn, Exists and DoesNotExist.
"%,
                  values | optional | Array String | doc m%"
values is an array of string values. If the operator is In or NotIn,
the values array must be non-empty. If the operator is Exists or DoesNotExist,
the values array must be empty. This array is replaced during a strategic
merge patch.
"%,
                } | doc m%"
matchExpressions is a list of label selector requirements. The requirements are ANDed.
"%,
                matchLabels | optional | {
                } | doc m%"
matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels
map is equivalent to an element of matchExpressions, whose key field is "key", the
operator is "In", and the values array contains only "value". The requirements are ANDed.
"%,
              } | doc m%"
Select all ClusterTrustBundles that match this label selector.  Only has
effect if signerName is set.  Mutually-exclusive with name.  If unset,
interpreted as "match nothing".  If set but empty, interpreted as "match
everything".
"%,
              name | optional | String | doc m%"
Select a single ClusterTrustBundle by object name.  Mutually-exclusive
with signerName and labelSelector.
"%,
              "optional" | optional | Bool | doc m%"
If true, don't block pod startup if the referenced ClusterTrustBundle(s)
aren't available.  If using name, then the named ClusterTrustBundle is
allowed not to exist.  If using signerName, then the combination of
signerName and labelSelector is allowed to match zero
ClusterTrustBundles.
"%,
              path | String | doc "Relative path from the volume root to write the bundle.",
              signerName | optional | String | doc m%"
Select all ClusterTrustBundles that match this signer name.
Mutually-exclusive with name.  The contents of all selected
ClusterTrustBundles will be unified and deduplicated.
"%,
            } | doc m%"
ClusterTrustBundle allows a pod to access the `.spec.trustBundle` field
of ClusterTrustBundle objects in an auto-updating file.

Alpha, gated by the ClusterTrustBundleProjection feature gate.

ClusterTrustBundle objects can either be selected by name, or by the
combination of signer name and a label selector.

Kubelet performs aggressive normalization of the PEM contents written
into the pod filesystem.  Esoteric PEM features such as inter-block
comments and block headers are stripped.  Certificates are deduplicated.
The ordering of certificates within the file is arbitrary, and Kubelet
may change the order over time.
"%,
            configMap | optional | {
              items | optional | Array {
                key | String | doc "key is the key to project.",
                mode | optional | Number | doc m%"
mode is Optional: mode bits used to set permissions on this file.
Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
If not specified, the volume defaultMode will be used.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
                path | String | doc m%"
path is the relative path of the file to map the key to.
May not be an absolute path.
May not contain the path element '..'.
May not start with the string '..'.
"%,
              } | doc m%"
items if unspecified, each key-value pair in the Data field of the referenced
ConfigMap will be projected into the volume as a file whose name is the
key and content is the value. If specified, the listed keys will be
projected into the specified paths, and unlisted keys will not be
present. If a key is specified which is not present in the ConfigMap,
the volume setup will error unless it is marked optional. Paths must be
relative and may not contain the '..' path or start with '..'.
"%,
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              "optional" | optional | Bool | doc "optional specify whether the ConfigMap or its keys must be defined",
            } | doc "configMap information about the configMap data to project",
            downwardAPI | optional | {
              items | optional | Array {
                fieldRef | optional | {
                  apiVersion | optional | String | doc "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".",
                  fieldPath | String | doc "Path of the field to select in the specified API version.",
                } | doc m%"
Required: Selects a field of the pod: only annotations, labels, name, namespace and uid are supported.
"%,
                mode | optional | Number | doc m%"
Optional: mode bits used to set permissions on this file, must be an octal value
between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
If not specified, the volume defaultMode will be used.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
                path | String | doc m%"
Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'
"%,
                resourceFieldRef | optional | {
                  containerName | optional | String | doc "Container name: required for volumes, optional for env vars",
                  divisor | optional | Number | String | doc "Specifies the output format of the exposed resources, defaults to \"1\"",
                  resource | String | doc "Required: resource to select",
                } | doc m%"
Selects a resource of the container: only resources limits and requests
(limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported.
"%,
              } | doc "Items is a list of DownwardAPIVolume file",
            } | doc "downwardAPI information about the downwardAPI data to project",
            secret | optional | {
              items | optional | Array {
                key | String | doc "key is the key to project.",
                mode | optional | Number | doc m%"
mode is Optional: mode bits used to set permissions on this file.
Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
If not specified, the volume defaultMode will be used.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
                path | String | doc m%"
path is the relative path of the file to map the key to.
May not be an absolute path.
May not contain the path element '..'.
May not start with the string '..'.
"%,
              } | doc m%"
items if unspecified, each key-value pair in the Data field of the referenced
Secret will be projected into the volume as a file whose name is the
key and content is the value. If specified, the listed keys will be
projected into the specified paths, and unlisted keys will not be
present. If a key is specified which is not present in the Secret,
the volume setup will error unless it is marked optional. Paths must be
relative and may not contain the '..' path or start with '..'.
"%,
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              "optional" | optional | Bool | doc "optional field specify whether the Secret or its key must be defined",
            } | doc "secret information about the secret data to project",
            serviceAccountToken | optional | {
              audience | optional | String | doc m%"
audience is the intended audience of the token. A recipient of a token
must identify itself with an identifier specified in the audience of the
token, and otherwise should reject the token. The audience defaults to the
identifier of the apiserver.
"%,
              expirationSeconds | optional | Number | doc m%"
expirationSeconds is the requested duration of validity of the service
account token. As the token approaches expiration, the kubelet volume
plugin will proactively rotate the service account token. The kubelet will
start trying to rotate the token if the token is older than 80 percent of
its time to live or if the token is older than 24 hours.Defaults to 1 hour
and must be at least 10 minutes.
"%,
              path | String | doc m%"
path is the path relative to the mount point of the file to project the
token into.
"%,
            } | doc "serviceAccountToken is information about the serviceAccountToken data to project",
          } | doc m%"
sources is the list of volume projections. Each entry in this list
handles one source.
"%,
        } | doc "Projected represents a projected volume that should populate this workspace.",
        secret | optional | {
          defaultMode | optional | Number | doc m%"
defaultMode is Optional: mode bits used to set permissions on created files by default.
Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values
for mode bits. Defaults to 0644.
Directories within the path are not affected by this setting.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
          items | optional | Array {
            key | String | doc "key is the key to project.",
            mode | optional | Number | doc m%"
mode is Optional: mode bits used to set permissions on this file.
Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
If not specified, the volume defaultMode will be used.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
            path | String | doc m%"
path is the relative path of the file to map the key to.
May not be an absolute path.
May not contain the path element '..'.
May not start with the string '..'.
"%,
          } | doc m%"
items If unspecified, each key-value pair in the Data field of the referenced
Secret will be projected into the volume as a file whose name is the
key and content is the value. If specified, the listed keys will be
projected into the specified paths, and unlisted keys will not be
present. If a key is specified which is not present in the Secret,
the volume setup will error unless it is marked optional. Paths must be
relative and may not contain the '..' path or start with '..'.
"%,
          "optional" | optional | Bool | doc "optional field specify whether the Secret or its keys must be defined",
          secretName | optional | String | doc m%"
secretName is the name of the secret in the pod's namespace to use.
More info: https://kubernetes.io/docs/concepts/storage/volumes#secret
"%,
        } | doc "Secret represents a secret that should populate this workspace.",
        subPath | optional | String | doc m%"
SubPath is optionally a directory on the volume which should be used
for this binding (i.e. the volume will be mounted at this sub directory).
"%,
        volumeClaimTemplate | optional | Dyn | doc m%"
VolumeClaimTemplate is a template for a claim that will be created in the same namespace.
The PipelineRun controller is responsible for creating a unique claim for each instance of PipelineRun.
See PersistentVolumeClaim (API version: v1)
"%,
      } | doc "Workspaces is a list of WorkspaceBindings from volumes to workspaces.",
    } | doc "TaskRunSpec defines the desired state of TaskRun",
    status | optional | {
      annotations | optional | {
      } | doc m%"
Annotations is additional Status fields for the Resource to save some
additional State as well as convey more information to the user. This is
roughly akin to Annotations on any k8s resource, just the reconciler conveying
richer information outwards.
"%,
      artifacts | optional | {
        inputs | optional | Array {
          buildOutput | optional | Bool | doc "Indicate if the artifact is a build output or a by-product",
          name | optional | String | doc "The artifact's identifying category name",
          values | optional | Array {
            digest | optional | {
            },
            uri | optional | String,
          } | doc "A collection of values related to the artifact",
        },
        outputs | optional | Array {
          buildOutput | optional | Bool | doc "Indicate if the artifact is a build output or a by-product",
          name | optional | String | doc "The artifact's identifying category name",
          values | optional | Array {
            digest | optional | {
            },
            uri | optional | String,
          } | doc "A collection of values related to the artifact",
        },
      } | doc "Artifacts are the list of artifacts written out by the task's containers",
      completionTime | optional | String | doc "CompletionTime is the time the build completed.",
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
      observedGeneration | optional | Number | doc m%"
ObservedGeneration is the 'Generation' of the Service that
was last processed by the controller.
"%,
      podName | String | doc "PodName is the name of the pod responsible for executing this task's steps.",
      provenance | optional | {
        featureFlags | optional | {
          awaitSidecarReadiness | optional | Bool,
          coschedule | optional | String,
          disableCredsInit | optional | Bool,
          disableInlineSpec | optional | String,
          enableAPIFields | optional | String,
          enableArtifacts | optional | Bool,
          enableCELInWhenExpression | optional | Bool,
          enableConciseResolverSyntax | optional | Bool,
          enableKeepPodOnCancel | optional | Bool,
          enableKubernetesSidecar | optional | Bool,
          enableParamEnum | optional | Bool,
          enableProvenanceInStatus | optional | Bool,
          enableStepActions | optional | Bool | doc "EnableStepActions is a no-op flag since StepActions are stable",
          enableWaitExponentialBackoff | optional | Bool,
          enforceNonfalsifiability | optional | String,
          maxResultSize | optional | Number,
          requireGitSSHSecretKnownHosts | optional | Bool,
          resultExtractionMethod | optional | String,
          runningInEnvWithInjectedSidecars | optional | Bool,
          sendCloudEventsForRuns | optional | Bool,
          setSecurityContext | optional | Bool,
          setSecurityContextReadOnlyRootFilesystem | optional | Bool,
          verificationNoMatchPolicy | optional | String | doc m%"
VerificationNoMatchPolicy is the feature flag for "trusted-resources-verification-no-match-policy"
VerificationNoMatchPolicy can be set to "ignore", "warn" and "fail" values.
ignore: skip trusted resources verification when no matching verification policies found
warn: skip trusted resources verification when no matching verification policies found and log a warning
fail: fail the taskrun or pipelines run if no matching verification policies found
"%,
        } | doc m%"
FeatureFlags identifies the feature flags that were used during the task/pipeline run
"%,
        refSource | optional | {
          digest | optional | {
          } | doc m%"
Digest is a collection of cryptographic digests for the contents of the artifact specified by URI.
Example: {"sha1": "f99d13e554ffcb696dee719fa85b695cb5b0f428"}
"%,
          entryPoint | optional | String | doc m%"
EntryPoint identifies the entry point into the build. This is often a path to a
build definition file and/or a target label within that file.
Example: "task/git-clone/0.10/git-clone.yaml"
"%,
          uri | optional | String | doc m%"
URI indicates the identity of the source of the build definition.
Example: "https://github.com/tektoncd/catalog"
"%,
        } | doc "RefSource identifies the source where a remote task/pipeline came from.",
      } | doc m%"
Provenance contains some key authenticated metadata about how a software artifact was built (what sources, what inputs/outputs, etc.).
"%,
      results | optional | Array {
        name | String | doc "Name the given name",
        type | optional | String | doc m%"
Type is the user-specified type of the result. The possible type
is currently "string" and will support "array" in following work.
"%,
        value | Dyn | doc "Value the given value of the result",
      } | doc "Results are the list of results written out by the task's containers",
      retriesStatus | optional | Dyn | doc m%"
RetriesStatus contains the history of TaskRunStatus in case of a retry in order to keep record of failures.
All TaskRunStatus stored in RetriesStatus will have no date within the RetriesStatus as is redundant.
"%,
      sidecars | optional | Array {
        container | optional | String,
        imageID | optional | String,
        name | optional | String,
        running | optional | {
          startedAt | optional | String | doc "Time at which the container was last (re-)started",
        } | doc "Details about a running container",
        terminated | optional | {
          containerID | optional | String | doc "Container's ID in the format '<type>://<container_id>'",
          exitCode | Number | doc "Exit status from the last termination of the container",
          finishedAt | optional | String | doc "Time at which the container last terminated",
          message | optional | String | doc "Message regarding the last termination of the container",
          reason | optional | String | doc "(brief) reason from the last termination of the container",
          signal | optional | Number | doc "Signal from the last termination of the container",
          startedAt | optional | String | doc "Time at which previous execution of the container started",
        } | doc "Details about a terminated container",
        waiting | optional | {
          message | optional | String | doc "Message regarding why the container is not yet running.",
          reason | optional | String | doc "(brief) reason the container is not yet running.",
        } | doc "Details about a waiting container",
      } | doc m%"
The list has one entry per sidecar in the manifest. Each entry is
represents the imageid of the corresponding sidecar.
"%,
      spanContext | optional | {
      } | doc "SpanContext contains tracing span context fields",
      startTime | optional | String | doc "StartTime is the time the build is actually started.",
      steps | optional | Array {
        container | optional | String,
        imageID | optional | String,
        inputs | optional | Array {
          buildOutput | optional | Bool | doc "Indicate if the artifact is a build output or a by-product",
          name | optional | String | doc "The artifact's identifying category name",
          values | optional | Array {
            digest | optional | {
            },
            uri | optional | String,
          } | doc "A collection of values related to the artifact",
        },
        name | optional | String,
        outputs | optional | Array {
          buildOutput | optional | Bool | doc "Indicate if the artifact is a build output or a by-product",
          name | optional | String | doc "The artifact's identifying category name",
          values | optional | Array {
            digest | optional | {
            },
            uri | optional | String,
          } | doc "A collection of values related to the artifact",
        },
        provenance | optional | {
          featureFlags | optional | {
            awaitSidecarReadiness | optional | Bool,
            coschedule | optional | String,
            disableCredsInit | optional | Bool,
            disableInlineSpec | optional | String,
            enableAPIFields | optional | String,
            enableArtifacts | optional | Bool,
            enableCELInWhenExpression | optional | Bool,
            enableConciseResolverSyntax | optional | Bool,
            enableKeepPodOnCancel | optional | Bool,
            enableKubernetesSidecar | optional | Bool,
            enableParamEnum | optional | Bool,
            enableProvenanceInStatus | optional | Bool,
            enableStepActions | optional | Bool | doc "EnableStepActions is a no-op flag since StepActions are stable",
            enableWaitExponentialBackoff | optional | Bool,
            enforceNonfalsifiability | optional | String,
            maxResultSize | optional | Number,
            requireGitSSHSecretKnownHosts | optional | Bool,
            resultExtractionMethod | optional | String,
            runningInEnvWithInjectedSidecars | optional | Bool,
            sendCloudEventsForRuns | optional | Bool,
            setSecurityContext | optional | Bool,
            setSecurityContextReadOnlyRootFilesystem | optional | Bool,
            verificationNoMatchPolicy | optional | String | doc m%"
VerificationNoMatchPolicy is the feature flag for "trusted-resources-verification-no-match-policy"
VerificationNoMatchPolicy can be set to "ignore", "warn" and "fail" values.
ignore: skip trusted resources verification when no matching verification policies found
warn: skip trusted resources verification when no matching verification policies found and log a warning
fail: fail the taskrun or pipelines run if no matching verification policies found
"%,
          } | doc m%"
FeatureFlags identifies the feature flags that were used during the task/pipeline run
"%,
          refSource | optional | {
            digest | optional | {
            } | doc m%"
Digest is a collection of cryptographic digests for the contents of the artifact specified by URI.
Example: {"sha1": "f99d13e554ffcb696dee719fa85b695cb5b0f428"}
"%,
            entryPoint | optional | String | doc m%"
EntryPoint identifies the entry point into the build. This is often a path to a
build definition file and/or a target label within that file.
Example: "task/git-clone/0.10/git-clone.yaml"
"%,
            uri | optional | String | doc m%"
URI indicates the identity of the source of the build definition.
Example: "https://github.com/tektoncd/catalog"
"%,
          } | doc "RefSource identifies the source where a remote task/pipeline came from.",
        } | doc m%"
Provenance contains metadata about resources used in the TaskRun/PipelineRun
such as the source from where a remote build definition was fetched.
This field aims to carry minimum amoumt of metadata in *Run status so that
Tekton Chains can capture them in the provenance.
"%,
        results | optional | Array {
          name | String | doc "Name the given name",
          type | optional | String | doc m%"
Type is the user-specified type of the result. The possible type
is currently "string" and will support "array" in following work.
"%,
          value | Dyn | doc "Value the given value of the result",
        },
        running | optional | {
          startedAt | optional | String | doc "Time at which the container was last (re-)started",
        } | doc "Details about a running container",
        terminated | optional | {
          containerID | optional | String | doc "Container's ID in the format '<type>://<container_id>'",
          exitCode | Number | doc "Exit status from the last termination of the container",
          finishedAt | optional | String | doc "Time at which the container last terminated",
          message | optional | String | doc "Message regarding the last termination of the container",
          reason | optional | String | doc "(brief) reason from the last termination of the container",
          signal | optional | Number | doc "Signal from the last termination of the container",
          startedAt | optional | String | doc "Time at which previous execution of the container started",
        } | doc "Details about a terminated container",
        terminationReason | optional | String,
        waiting | optional | {
          message | optional | String | doc "Message regarding why the container is not yet running.",
          reason | optional | String | doc "(brief) reason the container is not yet running.",
        } | doc "Details about a waiting container",
      } | doc "Steps describes the state of each build step container.",
      taskSpec | optional | {
        description | optional | String | doc m%"
Description is a user-facing description of the task that may be
used to populate a UI.
"%,
        displayName | optional | String | doc m%"
DisplayName is a user-facing name of the task that may be
used to populate a UI.
"%,
        params | optional | Array {
          "default" | optional | Dyn | doc m%"
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
Params is a list of input parameters required to run the task. Params
must be supplied as inputs in TaskRuns unless they declare a default
value.
"%,
        results | optional | Array {
          description | optional | String | doc "Description is a human-readable description of the result",
          name | String | doc "Name the given name",
          properties | optional | {
          } | doc "Properties is the JSON Schema properties to support key-value pairs results.",
          type | optional | String | doc m%"
Type is the user-specified type of the result. The possible type
is currently "string" and will support "array" in following work.
"%,
          value | optional | Dyn | doc m%"
Value the expression used to retrieve the value of the result from an underlying Step.
"%,
        } | doc "Results are values that this Task can output",
        sidecars | optional | Array {
          args | optional | Array String | doc m%"
Arguments to the entrypoint.
The image's CMD is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the Sidecar's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
          command | optional | Array String | doc m%"
Entrypoint array. Not executed within a shell.
The image's ENTRYPOINT is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the Sidecar's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
          computeResources | optional | {
            claims | optional | Array {
              name | String | doc m%"
Name must match the name of one entry in pod.spec.resourceClaims of
the Pod where this field is used. It makes that resource available
inside a container.
"%,
              request | optional | String | doc m%"
Request is the name chosen for a request in the referenced claim.
If empty, everything from the claim is made available, otherwise
only the result of this request.
"%,
            } | doc m%"
Claims lists the names of resources, defined in spec.resourceClaims,
that are used by this container.

This is an alpha field and requires enabling the
DynamicResourceAllocation feature gate.

This field is immutable. It can only be set for containers.
"%,
            limits | optional | {
            } | doc m%"
Limits describes the maximum amount of compute resources allowed.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
            requests | optional | {
            } | doc m%"
Requests describes the minimum amount of compute resources required.
If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
otherwise to an implementation-defined value. Requests cannot exceed Limits.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
          } | doc m%"
ComputeResources required by this Sidecar.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
          env | optional | Array k8s_io_envfromsource.EnvVar | doc m%"
List of environment variables to set in the Sidecar.
Cannot be updated.
"%,
          envFrom | optional | Array k8s_io_envfromsource.EnvFromSource | doc m%"
List of sources to populate environment variables in the Sidecar.
The keys defined within a source must be a C_IDENTIFIER. All invalid keys
will be reported as an event when the container is starting. When a key exists in multiple
sources, the value associated with the last source will take precedence.
Values defined by an Env with a duplicate key will take precedence.
Cannot be updated.
"%,
          image | optional | String | doc m%"
Image reference name.
More info: https://kubernetes.io/docs/concepts/containers/images
"%,
          imagePullPolicy | optional | String | doc m%"
Image pull policy.
One of Always, Never, IfNotPresent.
Defaults to Always if :latest tag is specified, or IfNotPresent otherwise.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/containers/images#updating-images
"%,
          lifecycle | optional | {
            postStart | optional | {
              exec | optional | {
                command | optional | Array String | doc m%"
Command is the command line to execute inside the container, the working directory for the
command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
a shell, you need to explicitly call out to that shell.
Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
"%,
              } | doc "Exec specifies a command to execute in the container.",
              httpGet | optional | {
                host | optional | String | doc m%"
Host name to connect to, defaults to the pod IP. You probably want to set
"Host" in httpHeaders instead.
"%,
                httpHeaders | optional | Array {
                  name | String | doc m%"
The header field name.
This will be canonicalized upon output, so case-variant names will be understood as the same header.
"%,
                  value | String | doc "The header field value",
                } | doc "Custom headers to set in the request. HTTP allows repeated headers.",
                path | optional | String | doc "Path to access on the HTTP server.",
                port | Number | String | doc m%"
Name or number of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
                scheme | optional | String | doc m%"
Scheme to use for connecting to the host.
Defaults to HTTP.
"%,
              } | doc "HTTPGet specifies an HTTP GET request to perform.",
              sleep | optional | {
                seconds | Number | doc "Seconds is the number of seconds to sleep.",
              } | doc "Sleep represents a duration that the container should sleep.",
              tcpSocket | optional | {
                host | optional | String | doc "Optional: Host name to connect to, defaults to the pod IP.",
                port | Number | String | doc m%"
Number or name of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
              } | doc m%"
Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept
for backward compatibility. There is no validation of this field and
lifecycle hooks will fail at runtime when it is specified.
"%,
            } | doc m%"
PostStart is called immediately after a container is created. If the handler fails,
the container is terminated and restarted according to its restart policy.
Other management of the container blocks until the hook completes.
More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
"%,
            preStop | optional | {
              exec | optional | {
                command | optional | Array String | doc m%"
Command is the command line to execute inside the container, the working directory for the
command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
a shell, you need to explicitly call out to that shell.
Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
"%,
              } | doc "Exec specifies a command to execute in the container.",
              httpGet | optional | {
                host | optional | String | doc m%"
Host name to connect to, defaults to the pod IP. You probably want to set
"Host" in httpHeaders instead.
"%,
                httpHeaders | optional | Array {
                  name | String | doc m%"
The header field name.
This will be canonicalized upon output, so case-variant names will be understood as the same header.
"%,
                  value | String | doc "The header field value",
                } | doc "Custom headers to set in the request. HTTP allows repeated headers.",
                path | optional | String | doc "Path to access on the HTTP server.",
                port | Number | String | doc m%"
Name or number of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
                scheme | optional | String | doc m%"
Scheme to use for connecting to the host.
Defaults to HTTP.
"%,
              } | doc "HTTPGet specifies an HTTP GET request to perform.",
              sleep | optional | {
                seconds | Number | doc "Seconds is the number of seconds to sleep.",
              } | doc "Sleep represents a duration that the container should sleep.",
              tcpSocket | optional | {
                host | optional | String | doc "Optional: Host name to connect to, defaults to the pod IP.",
                port | Number | String | doc m%"
Number or name of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
              } | doc m%"
Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept
for backward compatibility. There is no validation of this field and
lifecycle hooks will fail at runtime when it is specified.
"%,
            } | doc m%"
PreStop is called immediately before a container is terminated due to an
API request or management event such as liveness/startup probe failure,
preemption, resource contention, etc. The handler is not called if the
container crashes or exits. The Pod's termination grace period countdown begins before the
PreStop hook is executed. Regardless of the outcome of the handler, the
container will eventually terminate within the Pod's termination grace
period (unless delayed by finalizers). Other management of the container blocks until the hook completes
or until the termination grace period is reached.
More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
"%,
          } | doc m%"
Actions that the management system should take in response to Sidecar lifecycle events.
Cannot be updated.
"%,
          livenessProbe | optional | {
            exec | optional | {
              command | optional | Array String | doc m%"
Command is the command line to execute inside the container, the working directory for the
command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
a shell, you need to explicitly call out to that shell.
Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
"%,
            } | doc "Exec specifies a command to execute in the container.",
            failureThreshold | optional | Number | doc m%"
Minimum consecutive failures for the probe to be considered failed after having succeeded.
Defaults to 3. Minimum value is 1.
"%,
            grpc | optional | {
              port | Number | doc "Port number of the gRPC service. Number must be in the range 1 to 65535.",
              service | String | doc m%"
Service is the name of the service to place in the gRPC HealthCheckRequest
(see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).

If this is not specified, the default behavior is defined by gRPC.
"% | default = "",
            } | doc "GRPC specifies a GRPC HealthCheckRequest.",
            httpGet | optional | {
              host | optional | String | doc m%"
Host name to connect to, defaults to the pod IP. You probably want to set
"Host" in httpHeaders instead.
"%,
              httpHeaders | optional | Array {
                name | String | doc m%"
The header field name.
This will be canonicalized upon output, so case-variant names will be understood as the same header.
"%,
                value | String | doc "The header field value",
              } | doc "Custom headers to set in the request. HTTP allows repeated headers.",
              path | optional | String | doc "Path to access on the HTTP server.",
              port | Number | String | doc m%"
Name or number of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
              scheme | optional | String | doc m%"
Scheme to use for connecting to the host.
Defaults to HTTP.
"%,
            } | doc "HTTPGet specifies an HTTP GET request to perform.",
            initialDelaySeconds | optional | Number | doc m%"
Number of seconds after the container has started before liveness probes are initiated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
            periodSeconds | optional | Number | doc m%"
How often (in seconds) to perform the probe.
Default to 10 seconds. Minimum value is 1.
"%,
            successThreshold | optional | Number | doc m%"
Minimum consecutive successes for the probe to be considered successful after having failed.
Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
"%,
            tcpSocket | optional | {
              host | optional | String | doc "Optional: Host name to connect to, defaults to the pod IP.",
              port | Number | String | doc m%"
Number or name of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
            } | doc "TCPSocket specifies a connection to a TCP port.",
            terminationGracePeriodSeconds | optional | Number | doc m%"
Optional duration in seconds the pod needs to terminate gracefully upon probe failure.
The grace period is the duration in seconds after the processes running in the pod are sent
a termination signal and the time when the processes are forcibly halted with a kill signal.
Set this value longer than the expected cleanup time for your process.
If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this
value overrides the value provided by the pod spec.
Value must be non-negative integer. The value zero indicates stop immediately via
the kill signal (no opportunity to shut down).
This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.
Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
"%,
            timeoutSeconds | optional | Number | doc m%"
Number of seconds after which the probe times out.
Defaults to 1 second. Minimum value is 1.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
          } | doc m%"
Periodic probe of Sidecar liveness.
Container will be restarted if the probe fails.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
          name | String | doc m%"
Name of the Sidecar specified as a DNS_LABEL.
Each Sidecar in a Task must have a unique name (DNS_LABEL).
Cannot be updated.
"%,
          ports | optional | Array {
            containerPort | Number | doc m%"
Number of port to expose on the pod's IP address.
This must be a valid port number, 0 < x < 65536.
"%,
            hostIP | optional | String | doc "What host IP to bind the external port to.",
            hostPort | optional | Number | doc m%"
Number of port to expose on the host.
If specified, this must be a valid port number, 0 < x < 65536.
If HostNetwork is specified, this must match ContainerPort.
Most containers do not need this.
"%,
            name | optional | String | doc m%"
If specified, this must be an IANA_SVC_NAME and unique within the pod. Each
named port in a pod must have a unique name. Name for the port that can be
referred to by services.
"%,
            protocol | String | doc m%"
Protocol for port. Must be UDP, TCP, or SCTP.
Defaults to "TCP".
"% | default = "TCP",
          } | doc m%"
List of ports to expose from the Sidecar. Exposing a port here gives
the system additional information about the network connections a
container uses, but is primarily informational. Not specifying a port here
DOES NOT prevent that port from being exposed. Any port which is
listening on the default "0.0.0.0" address inside a container will be
accessible from the network.
Cannot be updated.
"%,
          readinessProbe | optional | {
            exec | optional | {
              command | optional | Array String | doc m%"
Command is the command line to execute inside the container, the working directory for the
command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
a shell, you need to explicitly call out to that shell.
Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
"%,
            } | doc "Exec specifies a command to execute in the container.",
            failureThreshold | optional | Number | doc m%"
Minimum consecutive failures for the probe to be considered failed after having succeeded.
Defaults to 3. Minimum value is 1.
"%,
            grpc | optional | {
              port | Number | doc "Port number of the gRPC service. Number must be in the range 1 to 65535.",
              service | String | doc m%"
Service is the name of the service to place in the gRPC HealthCheckRequest
(see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).

If this is not specified, the default behavior is defined by gRPC.
"% | default = "",
            } | doc "GRPC specifies a GRPC HealthCheckRequest.",
            httpGet | optional | {
              host | optional | String | doc m%"
Host name to connect to, defaults to the pod IP. You probably want to set
"Host" in httpHeaders instead.
"%,
              httpHeaders | optional | Array {
                name | String | doc m%"
The header field name.
This will be canonicalized upon output, so case-variant names will be understood as the same header.
"%,
                value | String | doc "The header field value",
              } | doc "Custom headers to set in the request. HTTP allows repeated headers.",
              path | optional | String | doc "Path to access on the HTTP server.",
              port | Number | String | doc m%"
Name or number of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
              scheme | optional | String | doc m%"
Scheme to use for connecting to the host.
Defaults to HTTP.
"%,
            } | doc "HTTPGet specifies an HTTP GET request to perform.",
            initialDelaySeconds | optional | Number | doc m%"
Number of seconds after the container has started before liveness probes are initiated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
            periodSeconds | optional | Number | doc m%"
How often (in seconds) to perform the probe.
Default to 10 seconds. Minimum value is 1.
"%,
            successThreshold | optional | Number | doc m%"
Minimum consecutive successes for the probe to be considered successful after having failed.
Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
"%,
            tcpSocket | optional | {
              host | optional | String | doc "Optional: Host name to connect to, defaults to the pod IP.",
              port | Number | String | doc m%"
Number or name of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
            } | doc "TCPSocket specifies a connection to a TCP port.",
            terminationGracePeriodSeconds | optional | Number | doc m%"
Optional duration in seconds the pod needs to terminate gracefully upon probe failure.
The grace period is the duration in seconds after the processes running in the pod are sent
a termination signal and the time when the processes are forcibly halted with a kill signal.
Set this value longer than the expected cleanup time for your process.
If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this
value overrides the value provided by the pod spec.
Value must be non-negative integer. The value zero indicates stop immediately via
the kill signal (no opportunity to shut down).
This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.
Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
"%,
            timeoutSeconds | optional | Number | doc m%"
Number of seconds after which the probe times out.
Defaults to 1 second. Minimum value is 1.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
          } | doc m%"
Periodic probe of Sidecar service readiness.
Container will be removed from service endpoints if the probe fails.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
          restartPolicy | optional | String | doc m%"
RestartPolicy refers to kubernetes RestartPolicy. It can only be set for an
initContainer and must have it's policy set to "Always". It is currently
left optional to help support Kubernetes versions prior to 1.29 when this feature
was introduced.
"%,
          script | optional | String | doc m%"
Script is the contents of an executable file to execute.

If Script is not empty, the Step cannot have an Command or Args.
"%,
          securityContext | optional | {
            allowPrivilegeEscalation | optional | Bool | doc m%"
AllowPrivilegeEscalation controls whether a process can gain more
privileges than its parent process. This bool directly controls if
the no_new_privs flag will be set on the container process.
AllowPrivilegeEscalation is true always when the container is:
1) run as Privileged
2) has CAP_SYS_ADMIN
Note that this field cannot be set when spec.os.name is windows.
"%,
            appArmorProfile | optional | {
              localhostProfile | optional | String | doc m%"
localhostProfile indicates a profile loaded on the node that should be used.
The profile must be preconfigured on the node to work.
Must match the loaded name of the profile.
Must be set if and only if type is "Localhost".
"%,
              type | String | doc m%"
type indicates which kind of AppArmor profile will be applied.
Valid options are:
  Localhost - a profile pre-loaded on the node.
  RuntimeDefault - the container runtime's default profile.
  Unconfined - no AppArmor enforcement.
"%,
            } | doc m%"
appArmorProfile is the AppArmor options to use by this container. If set, this profile
overrides the pod's appArmorProfile.
Note that this field cannot be set when spec.os.name is windows.
"%,
            capabilities | optional | {
              add | optional | Array String | doc "Added capabilities",
              drop | optional | Array String | doc "Removed capabilities",
            } | doc m%"
The capabilities to add/drop when running containers.
Defaults to the default set of capabilities granted by the container runtime.
Note that this field cannot be set when spec.os.name is windows.
"%,
            privileged | optional | Bool | doc m%"
Run container in privileged mode.
Processes in privileged containers are essentially equivalent to root on the host.
Defaults to false.
Note that this field cannot be set when spec.os.name is windows.
"%,
            procMount | optional | String | doc m%"
procMount denotes the type of proc mount to use for the containers.
The default value is Default which uses the container runtime defaults for
readonly paths and masked paths.
This requires the ProcMountType feature flag to be enabled.
Note that this field cannot be set when spec.os.name is windows.
"%,
            readOnlyRootFilesystem | optional | Bool | doc m%"
Whether this container has a read-only root filesystem.
Default is false.
Note that this field cannot be set when spec.os.name is windows.
"%,
            runAsGroup | optional | Number | doc m%"
The GID to run the entrypoint of the container process.
Uses runtime default if unset.
May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is windows.
"%,
            runAsNonRoot | optional | Bool | doc m%"
Indicates that the container must run as a non-root user.
If true, the Kubelet will validate the image at runtime to ensure that it
does not run as UID 0 (root) and fail to start the container if it does.
If unset or false, no such validation will be performed.
May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
"%,
            runAsUser | optional | Number | doc m%"
The UID to run the entrypoint of the container process.
Defaults to user specified in image metadata if unspecified.
May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is windows.
"%,
            seLinuxOptions | optional | {
              level | optional | String | doc "Level is SELinux level label that applies to the container.",
              role | optional | String | doc "Role is a SELinux role label that applies to the container.",
              type | optional | String | doc "Type is a SELinux type label that applies to the container.",
              user | optional | String | doc "User is a SELinux user label that applies to the container.",
            } | doc m%"
The SELinux context to be applied to the container.
If unspecified, the container runtime will allocate a random SELinux context for each
container.  May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is windows.
"%,
            seccompProfile | optional | {
              localhostProfile | optional | String | doc m%"
localhostProfile indicates a profile defined in a file on the node should be used.
The profile must be preconfigured on the node to work.
Must be a descending path, relative to the kubelet's configured seccomp profile location.
Must be set if type is "Localhost". Must NOT be set for any other type.
"%,
              type | String | doc m%"
type indicates which kind of seccomp profile will be applied.
Valid options are:

Localhost - a profile defined in a file on the node should be used.
RuntimeDefault - the container runtime default profile should be used.
Unconfined - no profile should be applied.
"%,
            } | doc m%"
The seccomp options to use by this container. If seccomp options are
provided at both the pod & container level, the container options
override the pod options.
Note that this field cannot be set when spec.os.name is windows.
"%,
            windowsOptions | optional | {
              gmsaCredentialSpec | optional | String | doc m%"
GMSACredentialSpec is where the GMSA admission webhook
(https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the
GMSA credential spec named by the GMSACredentialSpecName field.
"%,
              gmsaCredentialSpecName | optional | String | doc "GMSACredentialSpecName is the name of the GMSA credential spec to use.",
              hostProcess | optional | Bool | doc m%"
HostProcess determines if a container should be run as a 'Host Process' container.
All of a Pod's containers must have the same effective HostProcess value
(it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).
In addition, if HostProcess is true then HostNetwork must also be set to true.
"%,
              runAsUserName | optional | String | doc m%"
The UserName in Windows to run the entrypoint of the container process.
Defaults to the user specified in image metadata if unspecified.
May also be set in PodSecurityContext. If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
"%,
            } | doc m%"
The Windows specific settings applied to all containers.
If unspecified, the options from the PodSecurityContext will be used.
If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is linux.
"%,
          } | doc m%"
SecurityContext defines the security options the Sidecar should be run with.
If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.
More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
"%,
          startupProbe | optional | {
            exec | optional | {
              command | optional | Array String | doc m%"
Command is the command line to execute inside the container, the working directory for the
command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
a shell, you need to explicitly call out to that shell.
Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
"%,
            } | doc "Exec specifies a command to execute in the container.",
            failureThreshold | optional | Number | doc m%"
Minimum consecutive failures for the probe to be considered failed after having succeeded.
Defaults to 3. Minimum value is 1.
"%,
            grpc | optional | {
              port | Number | doc "Port number of the gRPC service. Number must be in the range 1 to 65535.",
              service | String | doc m%"
Service is the name of the service to place in the gRPC HealthCheckRequest
(see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).

If this is not specified, the default behavior is defined by gRPC.
"% | default = "",
            } | doc "GRPC specifies a GRPC HealthCheckRequest.",
            httpGet | optional | {
              host | optional | String | doc m%"
Host name to connect to, defaults to the pod IP. You probably want to set
"Host" in httpHeaders instead.
"%,
              httpHeaders | optional | Array {
                name | String | doc m%"
The header field name.
This will be canonicalized upon output, so case-variant names will be understood as the same header.
"%,
                value | String | doc "The header field value",
              } | doc "Custom headers to set in the request. HTTP allows repeated headers.",
              path | optional | String | doc "Path to access on the HTTP server.",
              port | Number | String | doc m%"
Name or number of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
              scheme | optional | String | doc m%"
Scheme to use for connecting to the host.
Defaults to HTTP.
"%,
            } | doc "HTTPGet specifies an HTTP GET request to perform.",
            initialDelaySeconds | optional | Number | doc m%"
Number of seconds after the container has started before liveness probes are initiated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
            periodSeconds | optional | Number | doc m%"
How often (in seconds) to perform the probe.
Default to 10 seconds. Minimum value is 1.
"%,
            successThreshold | optional | Number | doc m%"
Minimum consecutive successes for the probe to be considered successful after having failed.
Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
"%,
            tcpSocket | optional | {
              host | optional | String | doc "Optional: Host name to connect to, defaults to the pod IP.",
              port | Number | String | doc m%"
Number or name of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
            } | doc "TCPSocket specifies a connection to a TCP port.",
            terminationGracePeriodSeconds | optional | Number | doc m%"
Optional duration in seconds the pod needs to terminate gracefully upon probe failure.
The grace period is the duration in seconds after the processes running in the pod are sent
a termination signal and the time when the processes are forcibly halted with a kill signal.
Set this value longer than the expected cleanup time for your process.
If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this
value overrides the value provided by the pod spec.
Value must be non-negative integer. The value zero indicates stop immediately via
the kill signal (no opportunity to shut down).
This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.
Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
"%,
            timeoutSeconds | optional | Number | doc m%"
Number of seconds after which the probe times out.
Defaults to 1 second. Minimum value is 1.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
          } | doc m%"
StartupProbe indicates that the Pod the Sidecar is running in has successfully initialized.
If specified, no other probes are executed until this completes successfully.
If this probe fails, the Pod will be restarted, just as if the livenessProbe failed.
This can be used to provide different probe parameters at the beginning of a Pod's lifecycle,
when it might take a long time to load data or warm a cache, than during steady-state operation.
This cannot be updated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
          stdin | optional | Bool | doc m%"
Whether this Sidecar should allocate a buffer for stdin in the container runtime. If this
is not set, reads from stdin in the Sidecar will always result in EOF.
Default is false.
"%,
          stdinOnce | optional | Bool | doc m%"
Whether the container runtime should close the stdin channel after it has been opened by
a single attach. When stdin is true the stdin stream will remain open across multiple attach
sessions. If stdinOnce is set to true, stdin is opened on Sidecar start, is empty until the
first client attaches to stdin, and then remains open and accepts data until the client disconnects,
at which time stdin is closed and remains closed until the Sidecar is restarted. If this
flag is false, a container processes that reads from stdin will never receive an EOF.
Default is false
"%,
          terminationMessagePath | optional | String | doc m%"
Optional: Path at which the file to which the Sidecar's termination message
will be written is mounted into the Sidecar's filesystem.
Message written is intended to be brief final status, such as an assertion failure message.
Will be truncated by the node if greater than 4096 bytes. The total message length across
all containers will be limited to 12kb.
Defaults to /dev/termination-log.
Cannot be updated.
"%,
          terminationMessagePolicy | optional | String | doc m%"
Indicate how the termination message should be populated. File will use the contents of
terminationMessagePath to populate the Sidecar status message on both success and failure.
FallbackToLogsOnError will use the last chunk of Sidecar log output if the termination
message file is empty and the Sidecar exited with an error.
The log output is limited to 2048 bytes or 80 lines, whichever is smaller.
Defaults to File.
Cannot be updated.
"%,
          tty | optional | Bool | doc m%"
Whether this Sidecar should allocate a TTY for itself, also requires 'stdin' to be true.
Default is false.
"%,
          volumeDevices | optional | Array {
            devicePath | String | doc m%"
devicePath is the path inside of the container that the device will be mapped to.
"%,
            name | String | doc "name must match the name of a persistentVolumeClaim in the pod",
          } | doc "volumeDevices is the list of block devices to be used by the Sidecar.",
          volumeMounts | optional | Array k8s_io_envfromsource.VolumeMount | doc m%"
Volumes to mount into the Sidecar's filesystem.
Cannot be updated.
"%,
          workingDir | optional | String | doc m%"
Sidecar's working directory.
If not specified, the container runtime's default will be used, which
might be configured in the container image.
Cannot be updated.
"%,
          workspaces | optional | Array {
            mountPath | String | doc m%"
MountPath is the path that the workspace should be mounted to inside the Step or Sidecar,
overriding any MountPath specified in the Task's WorkspaceDeclaration.
"%,
            name | String | doc "Name is the name of the workspace this Step or Sidecar wants access to.",
          } | doc m%"
This is an alpha field. You must set the "enable-api-fields" feature flag to "alpha"
for this field to be supported.

Workspaces is a list of workspaces from the Task that this Sidecar wants
exclusive access to. Adding a workspace to this list means that any
other Step or Sidecar that does not also request this Workspace will
not have access to it.
"%,
        } | doc m%"
Sidecars are run alongside the Task's step containers. They begin before
the steps start and end after the steps complete.
"%,
        stepTemplate | optional | {
          args | optional | Array String | doc m%"
Arguments to the entrypoint.
The image's CMD is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the Step's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
          command | optional | Array String | doc m%"
Entrypoint array. Not executed within a shell.
The image's ENTRYPOINT is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the Step's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
          computeResources | optional | {
            claims | optional | Array {
              name | String | doc m%"
Name must match the name of one entry in pod.spec.resourceClaims of
the Pod where this field is used. It makes that resource available
inside a container.
"%,
              request | optional | String | doc m%"
Request is the name chosen for a request in the referenced claim.
If empty, everything from the claim is made available, otherwise
only the result of this request.
"%,
            } | doc m%"
Claims lists the names of resources, defined in spec.resourceClaims,
that are used by this container.

This is an alpha field and requires enabling the
DynamicResourceAllocation feature gate.

This field is immutable. It can only be set for containers.
"%,
            limits | optional | {
            } | doc m%"
Limits describes the maximum amount of compute resources allowed.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
            requests | optional | {
            } | doc m%"
Requests describes the minimum amount of compute resources required.
If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
otherwise to an implementation-defined value. Requests cannot exceed Limits.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
          } | doc m%"
ComputeResources required by this Step.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
          env | optional | Array k8s_io_envfromsource.EnvVar | doc m%"
List of environment variables to set in the Step.
Cannot be updated.
"%,
          envFrom | optional | Array k8s_io_envfromsource.EnvFromSource | doc m%"
List of sources to populate environment variables in the Step.
The keys defined within a source must be a C_IDENTIFIER. All invalid keys
will be reported as an event when the Step is starting. When a key exists in multiple
sources, the value associated with the last source will take precedence.
Values defined by an Env with a duplicate key will take precedence.
Cannot be updated.
"%,
          image | optional | String | doc m%"
Image reference name.
More info: https://kubernetes.io/docs/concepts/containers/images
"%,
          imagePullPolicy | optional | String | doc m%"
Image pull policy.
One of Always, Never, IfNotPresent.
Defaults to Always if :latest tag is specified, or IfNotPresent otherwise.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/containers/images#updating-images
"%,
          securityContext | optional | {
            allowPrivilegeEscalation | optional | Bool | doc m%"
AllowPrivilegeEscalation controls whether a process can gain more
privileges than its parent process. This bool directly controls if
the no_new_privs flag will be set on the container process.
AllowPrivilegeEscalation is true always when the container is:
1) run as Privileged
2) has CAP_SYS_ADMIN
Note that this field cannot be set when spec.os.name is windows.
"%,
            appArmorProfile | optional | {
              localhostProfile | optional | String | doc m%"
localhostProfile indicates a profile loaded on the node that should be used.
The profile must be preconfigured on the node to work.
Must match the loaded name of the profile.
Must be set if and only if type is "Localhost".
"%,
              type | String | doc m%"
type indicates which kind of AppArmor profile will be applied.
Valid options are:
  Localhost - a profile pre-loaded on the node.
  RuntimeDefault - the container runtime's default profile.
  Unconfined - no AppArmor enforcement.
"%,
            } | doc m%"
appArmorProfile is the AppArmor options to use by this container. If set, this profile
overrides the pod's appArmorProfile.
Note that this field cannot be set when spec.os.name is windows.
"%,
            capabilities | optional | {
              add | optional | Array String | doc "Added capabilities",
              drop | optional | Array String | doc "Removed capabilities",
            } | doc m%"
The capabilities to add/drop when running containers.
Defaults to the default set of capabilities granted by the container runtime.
Note that this field cannot be set when spec.os.name is windows.
"%,
            privileged | optional | Bool | doc m%"
Run container in privileged mode.
Processes in privileged containers are essentially equivalent to root on the host.
Defaults to false.
Note that this field cannot be set when spec.os.name is windows.
"%,
            procMount | optional | String | doc m%"
procMount denotes the type of proc mount to use for the containers.
The default value is Default which uses the container runtime defaults for
readonly paths and masked paths.
This requires the ProcMountType feature flag to be enabled.
Note that this field cannot be set when spec.os.name is windows.
"%,
            readOnlyRootFilesystem | optional | Bool | doc m%"
Whether this container has a read-only root filesystem.
Default is false.
Note that this field cannot be set when spec.os.name is windows.
"%,
            runAsGroup | optional | Number | doc m%"
The GID to run the entrypoint of the container process.
Uses runtime default if unset.
May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is windows.
"%,
            runAsNonRoot | optional | Bool | doc m%"
Indicates that the container must run as a non-root user.
If true, the Kubelet will validate the image at runtime to ensure that it
does not run as UID 0 (root) and fail to start the container if it does.
If unset or false, no such validation will be performed.
May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
"%,
            runAsUser | optional | Number | doc m%"
The UID to run the entrypoint of the container process.
Defaults to user specified in image metadata if unspecified.
May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is windows.
"%,
            seLinuxOptions | optional | {
              level | optional | String | doc "Level is SELinux level label that applies to the container.",
              role | optional | String | doc "Role is a SELinux role label that applies to the container.",
              type | optional | String | doc "Type is a SELinux type label that applies to the container.",
              user | optional | String | doc "User is a SELinux user label that applies to the container.",
            } | doc m%"
The SELinux context to be applied to the container.
If unspecified, the container runtime will allocate a random SELinux context for each
container.  May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is windows.
"%,
            seccompProfile | optional | {
              localhostProfile | optional | String | doc m%"
localhostProfile indicates a profile defined in a file on the node should be used.
The profile must be preconfigured on the node to work.
Must be a descending path, relative to the kubelet's configured seccomp profile location.
Must be set if type is "Localhost". Must NOT be set for any other type.
"%,
              type | String | doc m%"
type indicates which kind of seccomp profile will be applied.
Valid options are:

Localhost - a profile defined in a file on the node should be used.
RuntimeDefault - the container runtime default profile should be used.
Unconfined - no profile should be applied.
"%,
            } | doc m%"
The seccomp options to use by this container. If seccomp options are
provided at both the pod & container level, the container options
override the pod options.
Note that this field cannot be set when spec.os.name is windows.
"%,
            windowsOptions | optional | {
              gmsaCredentialSpec | optional | String | doc m%"
GMSACredentialSpec is where the GMSA admission webhook
(https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the
GMSA credential spec named by the GMSACredentialSpecName field.
"%,
              gmsaCredentialSpecName | optional | String | doc "GMSACredentialSpecName is the name of the GMSA credential spec to use.",
              hostProcess | optional | Bool | doc m%"
HostProcess determines if a container should be run as a 'Host Process' container.
All of a Pod's containers must have the same effective HostProcess value
(it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).
In addition, if HostProcess is true then HostNetwork must also be set to true.
"%,
              runAsUserName | optional | String | doc m%"
The UserName in Windows to run the entrypoint of the container process.
Defaults to the user specified in image metadata if unspecified.
May also be set in PodSecurityContext. If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
"%,
            } | doc m%"
The Windows specific settings applied to all containers.
If unspecified, the options from the PodSecurityContext will be used.
If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is linux.
"%,
          } | doc m%"
SecurityContext defines the security options the Step should be run with.
If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.
More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
"%,
          volumeDevices | optional | Array {
            devicePath | String | doc m%"
devicePath is the path inside of the container that the device will be mapped to.
"%,
            name | String | doc "name must match the name of a persistentVolumeClaim in the pod",
          } | doc "volumeDevices is the list of block devices to be used by the Step.",
          volumeMounts | optional | Array k8s_io_envfromsource.VolumeMount | doc m%"
Volumes to mount into the Step's filesystem.
Cannot be updated.
"%,
          workingDir | optional | String | doc m%"
Step's working directory.
If not specified, the container runtime's default will be used, which
might be configured in the container image.
Cannot be updated.
"%,
        } | doc m%"
StepTemplate can be used as the basis for all step containers within the
Task, so that the steps inherit settings on the base container.
"%,
        steps | optional | Array {
          args | optional | Array String | doc m%"
Arguments to the entrypoint.
The image's CMD is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the container's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
          command | optional | Array String | doc m%"
Entrypoint array. Not executed within a shell.
The image's ENTRYPOINT is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the container's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
          computeResources | optional | {
            claims | optional | Array {
              name | String | doc m%"
Name must match the name of one entry in pod.spec.resourceClaims of
the Pod where this field is used. It makes that resource available
inside a container.
"%,
              request | optional | String | doc m%"
Request is the name chosen for a request in the referenced claim.
If empty, everything from the claim is made available, otherwise
only the result of this request.
"%,
            } | doc m%"
Claims lists the names of resources, defined in spec.resourceClaims,
that are used by this container.

This is an alpha field and requires enabling the
DynamicResourceAllocation feature gate.

This field is immutable. It can only be set for containers.
"%,
            limits | optional | {
            } | doc m%"
Limits describes the maximum amount of compute resources allowed.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
            requests | optional | {
            } | doc m%"
Requests describes the minimum amount of compute resources required.
If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
otherwise to an implementation-defined value. Requests cannot exceed Limits.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
          } | doc m%"
ComputeResources required by this Step.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
          env | optional | Array k8s_io_envfromsource.EnvVar | doc m%"
List of environment variables to set in the Step.
Cannot be updated.
"%,
          envFrom | optional | Array k8s_io_envfromsource.EnvFromSource | doc m%"
List of sources to populate environment variables in the Step.
The keys defined within a source must be a C_IDENTIFIER. All invalid keys
will be reported as an event when the Step is starting. When a key exists in multiple
sources, the value associated with the last source will take precedence.
Values defined by an Env with a duplicate key will take precedence.
Cannot be updated.
"%,
          image | optional | String | doc m%"
Docker image name.
More info: https://kubernetes.io/docs/concepts/containers/images
"%,
          imagePullPolicy | optional | String | doc m%"
Image pull policy.
One of Always, Never, IfNotPresent.
Defaults to Always if :latest tag is specified, or IfNotPresent otherwise.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/containers/images#updating-images
"%,
          name | String | doc m%"
Name of the Step specified as a DNS_LABEL.
Each Step in a Task must have a unique name.
"%,
          onError | optional | String | doc m%"
OnError defines the exiting behavior of a container on error
can be set to [ continue | stopAndFail ]
"%,
          params | optional | Array {
            name | String,
            value | Dyn,
          } | doc "Params declares parameters passed to this step action.",
          ref | optional | {
            name | optional | String | doc "Name of the referenced step",
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
          } | doc "Contains the reference to an existing StepAction.",
          results | optional | Array {
            description | optional | String | doc "Description is a human-readable description of the result",
            name | String | doc "Name the given name",
            properties | optional | {
            } | doc "Properties is the JSON Schema properties to support key-value pairs results.",
            type | optional | String | doc m%"
The possible types are 'string', 'array', and 'object', with 'string' as the default.
"%,
          } | doc m%"
Results declares StepResults produced by the Step.

It can be used in an inlined Step when used to store Results to $(step.results.resultName.path).
It cannot be used when referencing StepActions using [v1.Step.Ref].
The Results declared by the StepActions will be stored here instead.
"%,
          script | optional | String | doc m%"
Script is the contents of an executable file to execute.

If Script is not empty, the Step cannot have an Command and the Args will be passed to the Script.
"%,
          securityContext | optional | {
            allowPrivilegeEscalation | optional | Bool | doc m%"
AllowPrivilegeEscalation controls whether a process can gain more
privileges than its parent process. This bool directly controls if
the no_new_privs flag will be set on the container process.
AllowPrivilegeEscalation is true always when the container is:
1) run as Privileged
2) has CAP_SYS_ADMIN
Note that this field cannot be set when spec.os.name is windows.
"%,
            appArmorProfile | optional | {
              localhostProfile | optional | String | doc m%"
localhostProfile indicates a profile loaded on the node that should be used.
The profile must be preconfigured on the node to work.
Must match the loaded name of the profile.
Must be set if and only if type is "Localhost".
"%,
              type | String | doc m%"
type indicates which kind of AppArmor profile will be applied.
Valid options are:
  Localhost - a profile pre-loaded on the node.
  RuntimeDefault - the container runtime's default profile.
  Unconfined - no AppArmor enforcement.
"%,
            } | doc m%"
appArmorProfile is the AppArmor options to use by this container. If set, this profile
overrides the pod's appArmorProfile.
Note that this field cannot be set when spec.os.name is windows.
"%,
            capabilities | optional | {
              add | optional | Array String | doc "Added capabilities",
              drop | optional | Array String | doc "Removed capabilities",
            } | doc m%"
The capabilities to add/drop when running containers.
Defaults to the default set of capabilities granted by the container runtime.
Note that this field cannot be set when spec.os.name is windows.
"%,
            privileged | optional | Bool | doc m%"
Run container in privileged mode.
Processes in privileged containers are essentially equivalent to root on the host.
Defaults to false.
Note that this field cannot be set when spec.os.name is windows.
"%,
            procMount | optional | String | doc m%"
procMount denotes the type of proc mount to use for the containers.
The default value is Default which uses the container runtime defaults for
readonly paths and masked paths.
This requires the ProcMountType feature flag to be enabled.
Note that this field cannot be set when spec.os.name is windows.
"%,
            readOnlyRootFilesystem | optional | Bool | doc m%"
Whether this container has a read-only root filesystem.
Default is false.
Note that this field cannot be set when spec.os.name is windows.
"%,
            runAsGroup | optional | Number | doc m%"
The GID to run the entrypoint of the container process.
Uses runtime default if unset.
May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is windows.
"%,
            runAsNonRoot | optional | Bool | doc m%"
Indicates that the container must run as a non-root user.
If true, the Kubelet will validate the image at runtime to ensure that it
does not run as UID 0 (root) and fail to start the container if it does.
If unset or false, no such validation will be performed.
May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
"%,
            runAsUser | optional | Number | doc m%"
The UID to run the entrypoint of the container process.
Defaults to user specified in image metadata if unspecified.
May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is windows.
"%,
            seLinuxOptions | optional | {
              level | optional | String | doc "Level is SELinux level label that applies to the container.",
              role | optional | String | doc "Role is a SELinux role label that applies to the container.",
              type | optional | String | doc "Type is a SELinux type label that applies to the container.",
              user | optional | String | doc "User is a SELinux user label that applies to the container.",
            } | doc m%"
The SELinux context to be applied to the container.
If unspecified, the container runtime will allocate a random SELinux context for each
container.  May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is windows.
"%,
            seccompProfile | optional | {
              localhostProfile | optional | String | doc m%"
localhostProfile indicates a profile defined in a file on the node should be used.
The profile must be preconfigured on the node to work.
Must be a descending path, relative to the kubelet's configured seccomp profile location.
Must be set if type is "Localhost". Must NOT be set for any other type.
"%,
              type | String | doc m%"
type indicates which kind of seccomp profile will be applied.
Valid options are:

Localhost - a profile defined in a file on the node should be used.
RuntimeDefault - the container runtime default profile should be used.
Unconfined - no profile should be applied.
"%,
            } | doc m%"
The seccomp options to use by this container. If seccomp options are
provided at both the pod & container level, the container options
override the pod options.
Note that this field cannot be set when spec.os.name is windows.
"%,
            windowsOptions | optional | {
              gmsaCredentialSpec | optional | String | doc m%"
GMSACredentialSpec is where the GMSA admission webhook
(https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the
GMSA credential spec named by the GMSACredentialSpecName field.
"%,
              gmsaCredentialSpecName | optional | String | doc "GMSACredentialSpecName is the name of the GMSA credential spec to use.",
              hostProcess | optional | Bool | doc m%"
HostProcess determines if a container should be run as a 'Host Process' container.
All of a Pod's containers must have the same effective HostProcess value
(it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).
In addition, if HostProcess is true then HostNetwork must also be set to true.
"%,
              runAsUserName | optional | String | doc m%"
The UserName in Windows to run the entrypoint of the container process.
Defaults to the user specified in image metadata if unspecified.
May also be set in PodSecurityContext. If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
"%,
            } | doc m%"
The Windows specific settings applied to all containers.
If unspecified, the options from the PodSecurityContext will be used.
If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is linux.
"%,
          } | doc m%"
SecurityContext defines the security options the Step should be run with.
If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.
More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
"%,
          stderrConfig | optional | {
            path | optional | String | doc "Path to duplicate stdout stream to on container's local filesystem.",
          } | doc "Stores configuration for the stderr stream of the step.",
          stdoutConfig | optional | {
            path | optional | String | doc "Path to duplicate stdout stream to on container's local filesystem.",
          } | doc "Stores configuration for the stdout stream of the step.",
          timeout | optional | String | doc m%"
Timeout is the time after which the step times out. Defaults to never.
Refer to Go's ParseDuration documentation for expected format: https://golang.org/pkg/time/#ParseDuration
"%,
          volumeDevices | optional | Array {
            devicePath | String | doc m%"
devicePath is the path inside of the container that the device will be mapped to.
"%,
            name | String | doc "name must match the name of a persistentVolumeClaim in the pod",
          } | doc "volumeDevices is the list of block devices to be used by the Step.",
          volumeMounts | optional | Array k8s_io_envfromsource.VolumeMount | doc m%"
Volumes to mount into the Step's filesystem.
Cannot be updated.
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
          workingDir | optional | String | doc m%"
Step's working directory.
If not specified, the container runtime's default will be used, which
might be configured in the container image.
Cannot be updated.
"%,
          workspaces | optional | Array {
            mountPath | String | doc m%"
MountPath is the path that the workspace should be mounted to inside the Step or Sidecar,
overriding any MountPath specified in the Task's WorkspaceDeclaration.
"%,
            name | String | doc "Name is the name of the workspace this Step or Sidecar wants access to.",
          } | doc m%"
This is an alpha field. You must set the "enable-api-fields" feature flag to "alpha"
for this field to be supported.

Workspaces is a list of workspaces from the Task that this Step wants
exclusive access to. Adding a workspace to this list means that any
other Step or Sidecar that does not also request this Workspace will
not have access to it.
"%,
        } | doc m%"
Steps are the steps of the build; each step is run sequentially with the
source mounted into /workspace.
"%,
        volumes | optional | Dyn | doc m%"
Volumes is a collection of volumes that are available to mount into the
steps of the build.
See Pod.spec.volumes (API version: v1)
"%,
        workspaces | optional | Array {
          description | optional | String | doc "Description is an optional human readable description of this volume.",
          mountPath | optional | String | doc "MountPath overrides the directory that the volume will be made available at.",
          name | String | doc "Name is the name by which you can bind the volume at runtime.",
          "optional" | optional | Bool | doc m%"
Optional marks a Workspace as not being required in TaskRuns. By default
this field is false and so declared workspaces are required.
"%,
          readOnly | optional | Bool | doc m%"
ReadOnly dictates whether a mounted volume is writable. By default this
field is false and so mounted volumes are writable.
"%,
        } | doc "Workspaces are the volumes that this Task requires.",
      } | doc m%"
TaskSpec contains the Spec from the dereferenced Task definition used to instantiate this TaskRun.
"%,
    } | doc "TaskRunStatus defines the observed state of TaskRun",
  },
}
