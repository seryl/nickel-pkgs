# Module: pipelinerun.tekton.dev

let k8s_io_toleration = import "k8s_io" in
let k8s_io_objectmeta = import "k8s_io" in
let k8s_io_envvar = import "k8s_io" in

{
  PipelineRun = {
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
    metadata | optional | k8s_io_toleration.ObjectMeta,
    spec | optional | {
      params | optional | Array {
        name | String,
        value | Dyn,
      } | doc "Params is a list of parameter names and values.",
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
      } | doc "PipelineRef can be used to refer to a specific instance of a Pipeline.",
      pipelineSpec | optional | Dyn | doc m%"
Specifying PipelineSpec can be disabled by setting
`disable-inline-spec` feature flag.
See Pipeline.spec (API version: tekton.dev/v1)
"%,
      status | optional | String | doc "Used for cancelling a pipelinerun (and maybe more later on)",
      taskRunSpecs | optional | Array {
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
        metadata | optional | {
          annotations | optional | {
          },
          labels | optional | {
          },
        } | doc "PipelineTaskMetadata contains the labels or annotations for an EmbeddedTask",
        pipelineTaskName | optional | String,
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
          env | optional | Array k8s_io_toleration.EnvVar | doc m%"
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
          tolerations | optional | Array k8s_io_toleration.Toleration | doc "If specified, the pod's tolerations.",
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
        },
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
        },
      } | doc "TaskRunSpecs holds a set of runtime specs",
      taskRunTemplate | optional | {
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
          env | optional | Array k8s_io_toleration.EnvVar | doc m%"
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
          tolerations | optional | Array k8s_io_toleration.Toleration | doc "If specified, the pod's tolerations.",
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
        serviceAccountName | optional | String,
      } | doc "TaskRunTemplate represent template of taskrun",
      timeouts | optional | {
        finally | optional | String | doc "Finally sets the maximum allowed duration of this pipeline's finally",
        pipeline | optional | String | doc m%"
Pipeline sets the maximum allowed duration for execution of the entire pipeline. The sum of individual timeouts for tasks and finally must not exceed this value.
"%,
        tasks | optional | String | doc "Tasks sets the maximum allowed duration of this pipeline's tasks",
      } | doc m%"
Time after which the Pipeline times out.
Currently three keys are accepted in the map
pipeline, tasks and finally
with Timeouts.pipeline >= Timeouts.tasks + Timeouts.finally
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
      } | doc m%"
Workspaces holds a set of workspace bindings that must match names
with those declared in the pipeline.
"%,
    } | doc "PipelineRunSpec defines the desired state of PipelineRun",
    status | optional | {
      annotations | optional | {
      } | doc m%"
Annotations is additional Status fields for the Resource to save some
additional State as well as convey more information to the user. This is
roughly akin to Annotations on any k8s resource, just the reconciler conveying
richer information outwards.
"%,
      childReferences | optional | Array {
        apiVersion | optional | String,
        displayName | optional | String | doc m%"
DisplayName is a user-facing name of the pipelineTask that may be
used to populate a UI.
"%,
        kind | optional | String,
        name | optional | String | doc "Name is the name of the TaskRun or Run this is referencing.",
        pipelineTaskName | optional | String | doc "PipelineTaskName is the name of the PipelineTask this is referencing.",
        whenExpressions | optional | Array {
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
        } | doc "WhenExpressions is the list of checks guarding the execution of the PipelineTask",
      } | doc m%"
list of TaskRun and Run names, PipelineTask names, and API versions/kinds for children of this PipelineRun.
"%,
      completionTime | optional | String | doc "CompletionTime is the time the PipelineRun completed.",
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
      finallyStartTime | optional | String | doc m%"
FinallyStartTime is when all non-finally tasks have been completed and only finally tasks are being executed.
"%,
      observedGeneration | optional | Number | doc m%"
ObservedGeneration is the 'Generation' of the Service that
was last processed by the controller.
"%,
      pipelineSpec | optional | Dyn | doc m%"
PipelineSpec contains the exact spec used to instantiate the run.
See Pipeline.spec (API version: tekton.dev/v1)
"%,
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
        name | String | doc "Name is the result's name as declared by the Pipeline",
        value | Dyn | doc "Value is the result returned from the execution of this PipelineRun",
      } | doc "Results are the list of results written out by the pipeline task's containers",
      skippedTasks | optional | Array {
        name | String | doc "Name is the Pipeline Task name",
        reason | String | doc "Reason is the cause of the PipelineTask being skipped.",
        whenExpressions | optional | Array {
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
        } | doc "WhenExpressions is the list of checks guarding the execution of the PipelineTask",
      } | doc "list of tasks that were skipped due to when expressions evaluating to false",
      spanContext | optional | {
      } | doc "SpanContext contains tracing span context fields",
      startTime | optional | String | doc "StartTime is the time the PipelineRun is actually started.",
    } | doc "PipelineRunStatus defines the observed state of PipelineRun",
  },
}
