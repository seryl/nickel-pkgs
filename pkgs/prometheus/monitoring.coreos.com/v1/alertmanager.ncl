# Module: alertmanager.monitoring.coreos.com

let k8s_io_objectmeta = import "k8s_io" in
let k8s_io_volumemount = import "k8s_io" in
let k8s_io_toleration = import "k8s_io" in
let k8s_io_envvar = import "k8s_io" in
let k8s_io_envfromsource = import "k8s_io" in

{
  Alertmanager = {
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
    spec | {
      additionalArgs | optional | Array {
        name | String | doc "Name of the argument, e.g. \"scrape.discovery-reload-interval\".",
        value | optional | String | doc m%"
Argument value, e.g. 30s. Can be empty for name-only arguments (e.g. --storage.tsdb.no-lockfile)
"%,
      } | doc m%"
AdditionalArgs allows setting additional arguments for the 'Alertmanager' container.
It is intended for e.g. activating hidden flags which are not supported by
the dedicated configuration options yet. The arguments are passed as-is to the
Alertmanager container which may cause issues if they are invalid or not supported
by the given Alertmanager version.
"%,
      additionalPeers | optional | Array String | doc m%"
AdditionalPeers allows injecting a set of additional Alertmanagers to peer with to form a highly available cluster.
"%,
      affinity | optional | {
        nodeAffinity | optional | {
          preferredDuringSchedulingIgnoredDuringExecution | optional | Array {
            preference | {
              matchExpressions | optional | Array {
                key | String | doc "The label key that the selector applies to.",
                operator | String | doc m%"
Represents a key's relationship to a set of values.
Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
"%,
                values | optional | Array String | doc m%"
An array of string values. If the operator is In or NotIn,
the values array must be non-empty. If the operator is Exists or DoesNotExist,
the values array must be empty. If the operator is Gt or Lt, the values
array must have a single element, which will be interpreted as an integer.
This array is replaced during a strategic merge patch.
"%,
              } | doc "A list of node selector requirements by node's labels.",
              matchFields | optional | Array {
                key | String | doc "The label key that the selector applies to.",
                operator | String | doc m%"
Represents a key's relationship to a set of values.
Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
"%,
                values | optional | Array String | doc m%"
An array of string values. If the operator is In or NotIn,
the values array must be non-empty. If the operator is Exists or DoesNotExist,
the values array must be empty. If the operator is Gt or Lt, the values
array must have a single element, which will be interpreted as an integer.
This array is replaced during a strategic merge patch.
"%,
              } | doc "A list of node selector requirements by node's fields.",
            } | doc "A node selector term, associated with the corresponding weight.",
            weight | Number | doc m%"
Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.
"%,
          } | doc m%"
The scheduler will prefer to schedule pods to nodes that satisfy
the affinity expressions specified by this field, but it may choose
a node that violates one or more of the expressions. The node that is
most preferred is the one with the greatest sum of weights, i.e.
for each node that meets all of the scheduling requirements (resource
request, requiredDuringScheduling affinity expressions, etc.),
compute a sum by iterating through the elements of this field and adding
"weight" to the sum if the node matches the corresponding matchExpressions; the
node(s) with the highest sum are the most preferred.
"%,
          requiredDuringSchedulingIgnoredDuringExecution | optional | {
            nodeSelectorTerms | Array {
              matchExpressions | optional | Array {
                key | String | doc "The label key that the selector applies to.",
                operator | String | doc m%"
Represents a key's relationship to a set of values.
Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
"%,
                values | optional | Array String | doc m%"
An array of string values. If the operator is In or NotIn,
the values array must be non-empty. If the operator is Exists or DoesNotExist,
the values array must be empty. If the operator is Gt or Lt, the values
array must have a single element, which will be interpreted as an integer.
This array is replaced during a strategic merge patch.
"%,
              } | doc "A list of node selector requirements by node's labels.",
              matchFields | optional | Array {
                key | String | doc "The label key that the selector applies to.",
                operator | String | doc m%"
Represents a key's relationship to a set of values.
Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
"%,
                values | optional | Array String | doc m%"
An array of string values. If the operator is In or NotIn,
the values array must be non-empty. If the operator is Exists or DoesNotExist,
the values array must be empty. If the operator is Gt or Lt, the values
array must have a single element, which will be interpreted as an integer.
This array is replaced during a strategic merge patch.
"%,
              } | doc "A list of node selector requirements by node's fields.",
            } | doc "Required. A list of node selector terms. The terms are ORed.",
          } | doc m%"
If the affinity requirements specified by this field are not met at
scheduling time, the pod will not be scheduled onto the node.
If the affinity requirements specified by this field cease to be met
at some point during pod execution (e.g. due to an update), the system
may or may not try to eventually evict the pod from its node.
"%,
        } | doc "Describes node affinity scheduling rules for the pod.",
        podAffinity | optional | {
          preferredDuringSchedulingIgnoredDuringExecution | optional | Array {
            podAffinityTerm | {
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
A label query over a set of resources, in this case pods.
If it's null, this PodAffinityTerm matches with no Pods.
"%,
              matchLabelKeys | optional | Array String | doc m%"
MatchLabelKeys is a set of pod label keys to select which pods will
be taken into consideration. The keys are used to lookup values from the
incoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`
to select the group of existing pods which pods will be taken into consideration
for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
pod labels will be ignored. The default value is empty.
The same key is forbidden to exist in both matchLabelKeys and labelSelector.
Also, matchLabelKeys cannot be set when labelSelector isn't set.
"%,
              mismatchLabelKeys | optional | Array String | doc m%"
MismatchLabelKeys is a set of pod label keys to select which pods will
be taken into consideration. The keys are used to lookup values from the
incoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`
to select the group of existing pods which pods will be taken into consideration
for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
pod labels will be ignored. The default value is empty.
The same key is forbidden to exist in both mismatchLabelKeys and labelSelector.
Also, mismatchLabelKeys cannot be set when labelSelector isn't set.
"%,
              namespaceSelector | optional | {
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
A label query over the set of namespaces that the term applies to.
The term is applied to the union of the namespaces selected by this field
and the ones listed in the namespaces field.
null selector and null or empty namespaces list means "this pod's namespace".
An empty selector ({}) matches all namespaces.
"%,
              namespaces | optional | Array String | doc m%"
namespaces specifies a static list of namespace names that the term applies to.
The term is applied to the union of the namespaces listed in this field
and the ones selected by namespaceSelector.
null or empty namespaces list and null namespaceSelector means "this pod's namespace".
"%,
              topologyKey | String | doc m%"
This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching
the labelSelector in the specified namespaces, where co-located is defined as running on a node
whose value of the label with key topologyKey matches that of any node on which any of the
selected pods is running.
Empty topologyKey is not allowed.
"%,
            } | doc "Required. A pod affinity term, associated with the corresponding weight.",
            weight | Number | doc m%"
weight associated with matching the corresponding podAffinityTerm,
in the range 1-100.
"%,
          } | doc m%"
The scheduler will prefer to schedule pods to nodes that satisfy
the affinity expressions specified by this field, but it may choose
a node that violates one or more of the expressions. The node that is
most preferred is the one with the greatest sum of weights, i.e.
for each node that meets all of the scheduling requirements (resource
request, requiredDuringScheduling affinity expressions, etc.),
compute a sum by iterating through the elements of this field and adding
"weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the
node(s) with the highest sum are the most preferred.
"%,
          requiredDuringSchedulingIgnoredDuringExecution | optional | Array {
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
A label query over a set of resources, in this case pods.
If it's null, this PodAffinityTerm matches with no Pods.
"%,
            matchLabelKeys | optional | Array String | doc m%"
MatchLabelKeys is a set of pod label keys to select which pods will
be taken into consideration. The keys are used to lookup values from the
incoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`
to select the group of existing pods which pods will be taken into consideration
for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
pod labels will be ignored. The default value is empty.
The same key is forbidden to exist in both matchLabelKeys and labelSelector.
Also, matchLabelKeys cannot be set when labelSelector isn't set.
"%,
            mismatchLabelKeys | optional | Array String | doc m%"
MismatchLabelKeys is a set of pod label keys to select which pods will
be taken into consideration. The keys are used to lookup values from the
incoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`
to select the group of existing pods which pods will be taken into consideration
for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
pod labels will be ignored. The default value is empty.
The same key is forbidden to exist in both mismatchLabelKeys and labelSelector.
Also, mismatchLabelKeys cannot be set when labelSelector isn't set.
"%,
            namespaceSelector | optional | {
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
A label query over the set of namespaces that the term applies to.
The term is applied to the union of the namespaces selected by this field
and the ones listed in the namespaces field.
null selector and null or empty namespaces list means "this pod's namespace".
An empty selector ({}) matches all namespaces.
"%,
            namespaces | optional | Array String | doc m%"
namespaces specifies a static list of namespace names that the term applies to.
The term is applied to the union of the namespaces listed in this field
and the ones selected by namespaceSelector.
null or empty namespaces list and null namespaceSelector means "this pod's namespace".
"%,
            topologyKey | String | doc m%"
This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching
the labelSelector in the specified namespaces, where co-located is defined as running on a node
whose value of the label with key topologyKey matches that of any node on which any of the
selected pods is running.
Empty topologyKey is not allowed.
"%,
          } | doc m%"
If the affinity requirements specified by this field are not met at
scheduling time, the pod will not be scheduled onto the node.
If the affinity requirements specified by this field cease to be met
at some point during pod execution (e.g. due to a pod label update), the
system may or may not try to eventually evict the pod from its node.
When there are multiple elements, the lists of nodes corresponding to each
podAffinityTerm are intersected, i.e. all terms must be satisfied.
"%,
        } | doc m%"
Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).
"%,
        podAntiAffinity | optional | {
          preferredDuringSchedulingIgnoredDuringExecution | optional | Array {
            podAffinityTerm | {
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
A label query over a set of resources, in this case pods.
If it's null, this PodAffinityTerm matches with no Pods.
"%,
              matchLabelKeys | optional | Array String | doc m%"
MatchLabelKeys is a set of pod label keys to select which pods will
be taken into consideration. The keys are used to lookup values from the
incoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`
to select the group of existing pods which pods will be taken into consideration
for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
pod labels will be ignored. The default value is empty.
The same key is forbidden to exist in both matchLabelKeys and labelSelector.
Also, matchLabelKeys cannot be set when labelSelector isn't set.
"%,
              mismatchLabelKeys | optional | Array String | doc m%"
MismatchLabelKeys is a set of pod label keys to select which pods will
be taken into consideration. The keys are used to lookup values from the
incoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`
to select the group of existing pods which pods will be taken into consideration
for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
pod labels will be ignored. The default value is empty.
The same key is forbidden to exist in both mismatchLabelKeys and labelSelector.
Also, mismatchLabelKeys cannot be set when labelSelector isn't set.
"%,
              namespaceSelector | optional | {
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
A label query over the set of namespaces that the term applies to.
The term is applied to the union of the namespaces selected by this field
and the ones listed in the namespaces field.
null selector and null or empty namespaces list means "this pod's namespace".
An empty selector ({}) matches all namespaces.
"%,
              namespaces | optional | Array String | doc m%"
namespaces specifies a static list of namespace names that the term applies to.
The term is applied to the union of the namespaces listed in this field
and the ones selected by namespaceSelector.
null or empty namespaces list and null namespaceSelector means "this pod's namespace".
"%,
              topologyKey | String | doc m%"
This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching
the labelSelector in the specified namespaces, where co-located is defined as running on a node
whose value of the label with key topologyKey matches that of any node on which any of the
selected pods is running.
Empty topologyKey is not allowed.
"%,
            } | doc "Required. A pod affinity term, associated with the corresponding weight.",
            weight | Number | doc m%"
weight associated with matching the corresponding podAffinityTerm,
in the range 1-100.
"%,
          } | doc m%"
The scheduler will prefer to schedule pods to nodes that satisfy
the anti-affinity expressions specified by this field, but it may choose
a node that violates one or more of the expressions. The node that is
most preferred is the one with the greatest sum of weights, i.e.
for each node that meets all of the scheduling requirements (resource
request, requiredDuringScheduling anti-affinity expressions, etc.),
compute a sum by iterating through the elements of this field and adding
"weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the
node(s) with the highest sum are the most preferred.
"%,
          requiredDuringSchedulingIgnoredDuringExecution | optional | Array {
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
A label query over a set of resources, in this case pods.
If it's null, this PodAffinityTerm matches with no Pods.
"%,
            matchLabelKeys | optional | Array String | doc m%"
MatchLabelKeys is a set of pod label keys to select which pods will
be taken into consideration. The keys are used to lookup values from the
incoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`
to select the group of existing pods which pods will be taken into consideration
for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
pod labels will be ignored. The default value is empty.
The same key is forbidden to exist in both matchLabelKeys and labelSelector.
Also, matchLabelKeys cannot be set when labelSelector isn't set.
"%,
            mismatchLabelKeys | optional | Array String | doc m%"
MismatchLabelKeys is a set of pod label keys to select which pods will
be taken into consideration. The keys are used to lookup values from the
incoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`
to select the group of existing pods which pods will be taken into consideration
for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming
pod labels will be ignored. The default value is empty.
The same key is forbidden to exist in both mismatchLabelKeys and labelSelector.
Also, mismatchLabelKeys cannot be set when labelSelector isn't set.
"%,
            namespaceSelector | optional | {
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
A label query over the set of namespaces that the term applies to.
The term is applied to the union of the namespaces selected by this field
and the ones listed in the namespaces field.
null selector and null or empty namespaces list means "this pod's namespace".
An empty selector ({}) matches all namespaces.
"%,
            namespaces | optional | Array String | doc m%"
namespaces specifies a static list of namespace names that the term applies to.
The term is applied to the union of the namespaces listed in this field
and the ones selected by namespaceSelector.
null or empty namespaces list and null namespaceSelector means "this pod's namespace".
"%,
            topologyKey | String | doc m%"
This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching
the labelSelector in the specified namespaces, where co-located is defined as running on a node
whose value of the label with key topologyKey matches that of any node on which any of the
selected pods is running.
Empty topologyKey is not allowed.
"%,
          } | doc m%"
If the anti-affinity requirements specified by this field are not met at
scheduling time, the pod will not be scheduled onto the node.
If the anti-affinity requirements specified by this field cease to be met
at some point during pod execution (e.g. due to a pod label update), the
system may or may not try to eventually evict the pod from its node.
When there are multiple elements, the lists of nodes corresponding to each
podAffinityTerm are intersected, i.e. all terms must be satisfied.
"%,
        } | doc m%"
Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).
"%,
      } | doc "If specified, the pod's scheduling constraints.",
      alertmanagerConfigMatcherStrategy | optional | {
        type | String | doc m%"
AlertmanagerConfigMatcherStrategyType defines the strategy used by
AlertmanagerConfig objects to match alerts in the routes and inhibition
rules.

The default value is `OnNamespace`.
"% | default = "OnNamespace",
      } | doc m%"
AlertmanagerConfigMatcherStrategy defines how AlertmanagerConfig objects
process incoming alerts.
"%,
      alertmanagerConfigNamespaceSelector | optional | {
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
Namespaces to be selected for AlertmanagerConfig discovery. If nil, only
check own namespace.
"%,
      alertmanagerConfigSelector | optional | {
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
      } | doc "AlertmanagerConfigs to be selected for to merge and configure Alertmanager with.",
      alertmanagerConfiguration | optional | {
        global | optional | {
          httpConfig | optional | {
            authorization | optional | {
              credentials | optional | {
                key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
                name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
              } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
              type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
            } | doc m%"
Authorization header configuration for the client.
This is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.
"%,
            basicAuth | optional | {
              password | optional | {
                key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
                name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
              } | doc m%"
`password` specifies a key of a Secret containing the password for
authentication.
"%,
              username | optional | {
                key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
                name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
              } | doc m%"
`username` specifies a key of a Secret containing the username for
authentication.
"%,
            } | doc m%"
BasicAuth for the client.
This is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.
"%,
            bearerTokenSecret | optional | {
              key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The secret's key that contains the bearer token to be used by the client
for authentication.
The secret needs to be in the same namespace as the Alertmanager
object and accessible by the Prometheus Operator.
"%,
            followRedirects | optional | Bool | doc "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.",
            noProxy | optional | String | doc m%"
`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
"%,
            oauth2 | optional | {
              clientId | {
                configMap | optional | {
                  key | String | doc "The key to select.",
                  name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                  optional | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
                } | doc "ConfigMap containing data to use for the targets.",
                secret | optional | {
                  key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
                  name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                  optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
                } | doc "Secret containing data to use for the targets.",
              } | doc m%"
`clientId` specifies a key of a Secret or ConfigMap containing the
OAuth2 client's ID.
"%,
              clientSecret | {
                key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
                name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
              } | doc m%"
`clientSecret` specifies a key of a Secret containing the OAuth2
client's secret.
"%,
              endpointParams | optional | {
              } | doc m%"
`endpointParams` configures the HTTP parameters to append to the token
URL.
"%,
              noProxy | optional | String | doc m%"
`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
"%,
              proxyConnectHeader | optional | {
              } | doc m%"
ProxyConnectHeader optionally specifies headers to send to
proxies during CONNECT requests.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
"%,
              proxyFromEnvironment | optional | Bool | doc m%"
Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
"%,
              proxyUrl | optional | String | doc "`proxyURL` defines the HTTP proxy server to use.",
              scopes | optional | Array String | doc "`scopes` defines the OAuth2 scopes used for the token request.",
              tlsConfig | optional | {
                ca | optional | {
                  configMap | optional | {
                    key | String | doc "The key to select.",
                    name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                    optional | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
                  } | doc "ConfigMap containing data to use for the targets.",
                  secret | optional | {
                    key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
                    name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                    optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
                  } | doc "Secret containing data to use for the targets.",
                } | doc "Certificate authority used when verifying server certificates.",
                cert | optional | {
                  configMap | optional | {
                    key | String | doc "The key to select.",
                    name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                    optional | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
                  } | doc "ConfigMap containing data to use for the targets.",
                  secret | optional | {
                    key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
                    name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                    optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
                  } | doc "Secret containing data to use for the targets.",
                } | doc "Client certificate to present when doing client-authentication.",
                insecureSkipVerify | optional | Bool | doc "Disable target certificate validation.",
                keySecret | optional | {
                  key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
                  name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                  optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
                } | doc "Secret containing the client key file for the targets.",
                maxVersion | optional | String | doc m%"
Maximum acceptable TLS version.

It requires Prometheus >= v2.41.0 or Thanos >= v0.31.0.
"%,
                minVersion | optional | String | doc m%"
Minimum acceptable TLS version.

It requires Prometheus >= v2.35.0 or Thanos >= v0.28.0.
"%,
                serverName | optional | String | doc "Used to verify the hostname for the targets.",
              } | doc m%"
TLS configuration to use when connecting to the OAuth2 server.
It requires Prometheus >= v2.43.0.
"%,
              tokenUrl | String | doc "`tokenURL` configures the URL to fetch the token from.",
            } | doc "OAuth2 client credentials used to fetch a token for the targets.",
            proxyConnectHeader | optional | {
            } | doc m%"
ProxyConnectHeader optionally specifies headers to send to
proxies during CONNECT requests.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
"%,
            proxyFromEnvironment | optional | Bool | doc m%"
Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
"%,
            proxyUrl | optional | String | doc "`proxyURL` defines the HTTP proxy server to use.",
            tlsConfig | optional | {
              ca | optional | {
                configMap | optional | {
                  key | String | doc "The key to select.",
                  name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                  optional | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
                } | doc "ConfigMap containing data to use for the targets.",
                secret | optional | {
                  key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
                  name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                  optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
                } | doc "Secret containing data to use for the targets.",
              } | doc "Certificate authority used when verifying server certificates.",
              cert | optional | {
                configMap | optional | {
                  key | String | doc "The key to select.",
                  name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                  optional | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
                } | doc "ConfigMap containing data to use for the targets.",
                secret | optional | {
                  key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
                  name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                  optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
                } | doc "Secret containing data to use for the targets.",
              } | doc "Client certificate to present when doing client-authentication.",
              insecureSkipVerify | optional | Bool | doc "Disable target certificate validation.",
              keySecret | optional | {
                key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
                name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
              } | doc "Secret containing the client key file for the targets.",
              maxVersion | optional | String | doc m%"
Maximum acceptable TLS version.

It requires Prometheus >= v2.41.0 or Thanos >= v0.31.0.
"%,
              minVersion | optional | String | doc m%"
Minimum acceptable TLS version.

It requires Prometheus >= v2.35.0 or Thanos >= v0.28.0.
"%,
              serverName | optional | String | doc "Used to verify the hostname for the targets.",
            } | doc "TLS configuration for the client.",
          } | doc "HTTP client configuration.",
          jira | optional | {
            apiURL | optional | String | doc m%"
The default Jira API URL.

It requires Alertmanager >= v0.28.0.
"%,
          } | doc "The default configuration for Jira.",
          opsGenieApiKey | optional | {
            key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
            optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc "The default OpsGenie API Key.",
          opsGenieApiUrl | optional | {
            key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
            optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc "The default OpsGenie API URL.",
          pagerdutyUrl | optional | String | doc "The default Pagerduty URL.",
          resolveTimeout | optional | String | doc m%"
ResolveTimeout is the default value used by alertmanager if the alert does
not include EndsAt, after this time passes it can declare the alert as resolved if it has not been updated.
This has no impact on alerts from Prometheus, as they always include EndsAt.
"%,
          rocketChat | optional | {
            apiURL | optional | String | doc m%"
The default Rocket Chat API URL.

It requires Alertmanager >= v0.28.0.
"%,
            token | optional | {
              key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The default Rocket Chat token.

It requires Alertmanager >= v0.28.0.
"%,
            tokenID | optional | {
              key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The default Rocket Chat Token ID.

It requires Alertmanager >= v0.28.0.
"%,
          } | doc "The default configuration for Rocket Chat.",
          slackApiUrl | optional | {
            key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
            optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc "The default Slack API URL.",
          smtp | optional | {
            authIdentity | optional | String | doc "SMTP Auth using PLAIN",
            authPassword | optional | {
              key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc "SMTP Auth using LOGIN and PLAIN.",
            authSecret | optional | {
              key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc "SMTP Auth using CRAM-MD5.",
            authUsername | optional | String | doc m%"
SMTP Auth using CRAM-MD5, LOGIN and PLAIN. If empty, Alertmanager doesn't authenticate to the SMTP server.
"%,
            from | optional | String | doc "The default SMTP From header field.",
            hello | optional | String | doc "The default hostname to identify to the SMTP server.",
            requireTLS | optional | Bool | doc m%"
The default SMTP TLS requirement.
Note that Go does not support unencrypted connections to remote SMTP endpoints.
"%,
            smartHost | optional | {
              host | String | doc "Defines the host's address, it can be a DNS name or a literal IP address.",
              port | String | doc "Defines the host's port, it can be a literal port number or a port name.",
            } | doc "The default SMTP smarthost used for sending emails.",
            tlsConfig | optional | {
              ca | optional | {
                configMap | optional | {
                  key | String | doc "The key to select.",
                  name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                  optional | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
                } | doc "ConfigMap containing data to use for the targets.",
                secret | optional | {
                  key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
                  name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                  optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
                } | doc "Secret containing data to use for the targets.",
              } | doc "Certificate authority used when verifying server certificates.",
              cert | optional | {
                configMap | optional | {
                  key | String | doc "The key to select.",
                  name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                  optional | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
                } | doc "ConfigMap containing data to use for the targets.",
                secret | optional | {
                  key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
                  name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                  optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
                } | doc "Secret containing data to use for the targets.",
              } | doc "Client certificate to present when doing client-authentication.",
              insecureSkipVerify | optional | Bool | doc "Disable target certificate validation.",
              keySecret | optional | {
                key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
                name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
              } | doc "Secret containing the client key file for the targets.",
              maxVersion | optional | String | doc m%"
Maximum acceptable TLS version.

It requires Prometheus >= v2.41.0 or Thanos >= v0.31.0.
"%,
              minVersion | optional | String | doc m%"
Minimum acceptable TLS version.

It requires Prometheus >= v2.35.0 or Thanos >= v0.28.0.
"%,
              serverName | optional | String | doc "Used to verify the hostname for the targets.",
            } | doc "The default TLS configuration for SMTP receivers",
          } | doc "Configures global SMTP parameters.",
          telegram | optional | {
            apiURL | optional | String | doc m%"
The default Telegram API URL.

It requires Alertmanager >= v0.24.0.
"%,
          } | doc "The default Telegram config",
          victorops | optional | {
            apiKey | optional | {
              key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc "The default VictorOps API Key.",
            apiURL | optional | String | doc "The default VictorOps API URL.",
          } | doc "The default configuration for VictorOps.",
          webex | optional | {
            apiURL | optional | String | doc m%"
The default Webex API URL.

It requires Alertmanager >= v0.25.0.
"%,
          } | doc "The default configuration for Jira.",
          wechat | optional | {
            apiCorpID | optional | String | doc "The default WeChat API Corporate ID.",
            apiSecret | optional | {
              key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc "The default WeChat API Secret.",
            apiURL | optional | String | doc m%"
The default WeChat API URL.
The default value is "https://qyapi.weixin.qq.com/cgi-bin/"
"%,
          } | doc "The default WeChat Config",
        } | doc "Defines the global parameters of the Alertmanager configuration.",
        name | optional | String | doc m%"
The name of the AlertmanagerConfig resource which is used to generate the Alertmanager configuration.
It must be defined in the same namespace as the Alertmanager object.
The operator will not enforce a `namespace` label for routes and inhibition rules.
"%,
        templates | optional | Array {
          configMap | optional | {
            key | String | doc "The key to select.",
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
            optional | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
          } | doc "ConfigMap containing data to use for the targets.",
          secret | optional | {
            key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
            optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc "Secret containing data to use for the targets.",
        } | doc "Custom notification templates.",
      } | doc m%"
alertmanagerConfiguration specifies the configuration of Alertmanager.

If defined, it takes precedence over the `configSecret` field.

This is an *experimental feature*, it may change in any upcoming release
in a breaking way.
"%,
      automountServiceAccountToken | optional | Bool | doc m%"
AutomountServiceAccountToken indicates whether a service account token should be automatically mounted in the pod.
If the service account has `automountServiceAccountToken: true`, set the field to `false` to opt out of automounting API credentials.
"%,
      baseImage | optional | String | doc m%"
Base image that is used to deploy pods, without tag.
Deprecated: use 'image' instead.
"%,
      clusterAdvertiseAddress | optional | String | doc m%"
ClusterAdvertiseAddress is the explicit address to advertise in cluster.
Needs to be provided for non RFC1918 [1] (public) addresses.
[1] RFC1918: https://tools.ietf.org/html/rfc1918
"%,
      clusterGossipInterval | optional | String | doc "Interval between gossip attempts.",
      clusterLabel | optional | String | doc m%"
Defines the identifier that uniquely identifies the Alertmanager cluster.
You should only set it when the Alertmanager cluster includes Alertmanager instances which are external to this Alertmanager resource. In practice, the addresses of the external instances are provided via the `.spec.additionalPeers` field.
"%,
      clusterPeerTimeout | optional | String | doc "Timeout for cluster peering.",
      clusterPushpullInterval | optional | String | doc "Interval between pushpull attempts.",
      clusterTLS | optional | {
        client | {
          ca | optional | {
            configMap | optional | {
              key | String | doc "The key to select.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
            } | doc "ConfigMap containing data to use for the targets.",
            secret | optional | {
              key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc "Secret containing data to use for the targets.",
          } | doc "Certificate authority used when verifying server certificates.",
          cert | optional | {
            configMap | optional | {
              key | String | doc "The key to select.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
            } | doc "ConfigMap containing data to use for the targets.",
            secret | optional | {
              key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc "Secret containing data to use for the targets.",
          } | doc "Client certificate to present when doing client-authentication.",
          insecureSkipVerify | optional | Bool | doc "Disable target certificate validation.",
          keySecret | optional | {
            key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
            optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc "Secret containing the client key file for the targets.",
          maxVersion | optional | String | doc m%"
Maximum acceptable TLS version.

It requires Prometheus >= v2.41.0 or Thanos >= v0.31.0.
"%,
          minVersion | optional | String | doc m%"
Minimum acceptable TLS version.

It requires Prometheus >= v2.35.0 or Thanos >= v0.28.0.
"%,
          serverName | optional | String | doc "Used to verify the hostname for the targets.",
        } | doc "Client-side configuration for mutual TLS.",
        server | {
          cert | optional | {
            configMap | optional | {
              key | String | doc "The key to select.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
            } | doc "ConfigMap containing data to use for the targets.",
            secret | optional | {
              key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc "Secret containing data to use for the targets.",
          } | doc m%"
Secret or ConfigMap containing the TLS certificate for the web server.

Either `keySecret` or `keyFile` must be defined.

It is mutually exclusive with `certFile`.
"%,
          certFile | optional | String | doc m%"
Path to the TLS certificate file in the container for the web server.

Either `keySecret` or `keyFile` must be defined.

It is mutually exclusive with `cert`.
"%,
          cipherSuites | optional | Array String | doc m%"
List of supported cipher suites for TLS versions up to TLS 1.2.

If not defined, the Go default cipher suites are used.
Available cipher suites are documented in the Go documentation:
https://golang.org/pkg/crypto/tls/#pkg-constants
"%,
          clientAuthType | optional | String | doc m%"
The server policy for client TLS authentication.

For more detail on clientAuth options:
https://golang.org/pkg/crypto/tls/#ClientAuthType
"%,
          clientCAFile | optional | String | doc m%"
Path to the CA certificate file for client certificate authentication to
the server.

It is mutually exclusive with `client_ca`.
"%,
          client_ca | optional | {
            configMap | optional | {
              key | String | doc "The key to select.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
            } | doc "ConfigMap containing data to use for the targets.",
            secret | optional | {
              key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc "Secret containing data to use for the targets.",
          } | doc m%"
Secret or ConfigMap containing the CA certificate for client certificate
authentication to the server.

It is mutually exclusive with `clientCAFile`.
"%,
          curvePreferences | optional | Array String | doc m%"
Elliptic curves that will be used in an ECDHE handshake, in preference
order.

Available curves are documented in the Go documentation:
https://golang.org/pkg/crypto/tls/#CurveID
"%,
          keyFile | optional | String | doc m%"
Path to the TLS private key file in the container for the web server.

If defined, either `cert` or `certFile` must be defined.

It is mutually exclusive with `keySecret`.
"%,
          keySecret | optional | {
            key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
            optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Secret containing the TLS private key for the web server.

Either `cert` or `certFile` must be defined.

It is mutually exclusive with `keyFile`.
"%,
          maxVersion | optional | String | doc "Maximum TLS version that is acceptable.",
          minVersion | optional | String | doc "Minimum TLS version that is acceptable.",
          preferServerCipherSuites | optional | Bool | doc m%"
Controls whether the server selects the client's most preferred cipher
suite, or the server's most preferred cipher suite.

If true then the server's preference, as expressed in
the order of elements in cipherSuites, is used.
"%,
        } | doc "Server-side configuration for mutual TLS.",
      } | doc m%"
Configures the mutual TLS configuration for the Alertmanager cluster's gossip protocol.

It requires Alertmanager >= 0.24.0.
"%,
      configMaps | optional | Array String | doc m%"
ConfigMaps is a list of ConfigMaps in the same namespace as the Alertmanager
object, which shall be mounted into the Alertmanager Pods.
Each ConfigMap is added to the StatefulSet definition as a volume named `configmap-<configmap-name>`.
The ConfigMaps are mounted into `/etc/alertmanager/configmaps/<configmap-name>` in the 'alertmanager' container.
"%,
      configSecret | optional | String | doc m%"
ConfigSecret is the name of a Kubernetes Secret in the same namespace as the
Alertmanager object, which contains the configuration for this Alertmanager
instance. If empty, it defaults to `alertmanager-<alertmanager-name>`.

The Alertmanager configuration should be available under the
`alertmanager.yaml` key. Additional keys from the original secret are
copied to the generated secret and mounted into the
`/etc/alertmanager/config` directory in the `alertmanager` container.

If either the secret or the `alertmanager.yaml` key is missing, the
operator provisions a minimal Alertmanager configuration with one empty
receiver (effectively dropping alert notifications).
"%,
      containers | optional | Array {
        args | optional | Array String | doc m%"
Arguments to the entrypoint.
The container image's CMD is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the container's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
        command | optional | Array String | doc m%"
Entrypoint array. Not executed within a shell.
The container image's ENTRYPOINT is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the container's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
        env | optional | Array k8s_io_objectmeta.EnvVar | doc m%"
List of environment variables to set in the container.
Cannot be updated.
"%,
        envFrom | optional | Array k8s_io_objectmeta.EnvFromSource | doc m%"
List of sources to populate environment variables in the container.
The keys defined within a source must be a C_IDENTIFIER. All invalid keys
will be reported as an event when the container is starting. When a key exists in multiple
sources, the value associated with the last source will take precedence.
Values defined by an Env with a duplicate key will take precedence.
Cannot be updated.
"%,
        image | optional | String | doc m%"
Container image name.
More info: https://kubernetes.io/docs/concepts/containers/images
This field is optional to allow higher level config management to default or override
container images in workload controllers like Deployments and StatefulSets.
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
          stopSignal | optional | String | doc m%"
StopSignal defines which signal will be sent to a container when it is being stopped.
If not specified, the default is defined by the container runtime in use.
StopSignal can only be set for Pods with a non-empty .spec.os.name
"%,
        } | doc m%"
Actions that the management system should take in response to container lifecycle events.
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
Periodic probe of container liveness.
Container will be restarted if the probe fails.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        name | String | doc m%"
Name of the container specified as a DNS_LABEL.
Each container in a pod must have a unique name (DNS_LABEL).
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
List of ports to expose from the container. Not specifying a port here
DOES NOT prevent that port from being exposed. Any port which is
listening on the default "0.0.0.0" address inside a container will be
accessible from the network.
Modifying this array with strategic merge patch may corrupt the data.
For more information See https://github.com/kubernetes/kubernetes/issues/108255.
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
Periodic probe of container service readiness.
Container will be removed from service endpoints if the probe fails.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        resizePolicy | optional | Array {
          resourceName | String | doc m%"
Name of the resource to which this resource resize policy applies.
Supported values: cpu, memory.
"%,
          restartPolicy | String | doc m%"
Restart policy to apply when specified resource is resized.
If not specified, it defaults to NotRequired.
"%,
        } | doc "Resources resize policy for the container.",
        resources | optional | {
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
Compute Resources required by this container.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
        restartPolicy | optional | String | doc m%"
RestartPolicy defines the restart behavior of individual containers in a pod.
This field may only be set for init containers, and the only allowed value is "Always".
For non-init containers or when this field is not specified,
the restart behavior is defined by the Pod's restart policy and the container type.
Setting the RestartPolicy as "Always" for the init container will have the following effect:
this init container will be continually restarted on
exit until all regular containers have terminated. Once all regular
containers have completed, all init containers with restartPolicy "Always"
will be shut down. This lifecycle differs from normal init containers and
is often referred to as a "sidecar" container. Although this init
container still starts in the init container sequence, it does not wait
for the container to complete before proceeding to the next init
container. Instead, the next init container starts immediately after this
init container is started, or after any startupProbe has successfully
completed.
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
SecurityContext defines the security options the container should be run with.
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
StartupProbe indicates that the Pod has successfully initialized.
If specified, no other probes are executed until this completes successfully.
If this probe fails, the Pod will be restarted, just as if the livenessProbe failed.
This can be used to provide different probe parameters at the beginning of a Pod's lifecycle,
when it might take a long time to load data or warm a cache, than during steady-state operation.
This cannot be updated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        stdin | optional | Bool | doc m%"
Whether this container should allocate a buffer for stdin in the container runtime. If this
is not set, reads from stdin in the container will always result in EOF.
Default is false.
"%,
        stdinOnce | optional | Bool | doc m%"
Whether the container runtime should close the stdin channel after it has been opened by
a single attach. When stdin is true the stdin stream will remain open across multiple attach
sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the
first client attaches to stdin, and then remains open and accepts data until the client disconnects,
at which time stdin is closed and remains closed until the container is restarted. If this
flag is false, a container processes that reads from stdin will never receive an EOF.
Default is false
"%,
        terminationMessagePath | optional | String | doc m%"
Optional: Path at which the file to which the container's termination message
will be written is mounted into the container's filesystem.
Message written is intended to be brief final status, such as an assertion failure message.
Will be truncated by the node if greater than 4096 bytes. The total message length across
all containers will be limited to 12kb.
Defaults to /dev/termination-log.
Cannot be updated.
"%,
        terminationMessagePolicy | optional | String | doc m%"
Indicate how the termination message should be populated. File will use the contents of
terminationMessagePath to populate the container status message on both success and failure.
FallbackToLogsOnError will use the last chunk of container log output if the termination
message file is empty and the container exited with an error.
The log output is limited to 2048 bytes or 80 lines, whichever is smaller.
Defaults to File.
Cannot be updated.
"%,
        tty | optional | Bool | doc m%"
Whether this container should allocate a TTY for itself, also requires 'stdin' to be true.
Default is false.
"%,
        volumeDevices | optional | Array {
          devicePath | String | doc m%"
devicePath is the path inside of the container that the device will be mapped to.
"%,
          name | String | doc "name must match the name of a persistentVolumeClaim in the pod",
        } | doc "volumeDevices is the list of block devices to be used by the container.",
        volumeMounts | optional | Array k8s_io_objectmeta.VolumeMount | doc m%"
Pod volumes to mount into the container's filesystem.
Cannot be updated.
"%,
        workingDir | optional | String | doc m%"
Container's working directory.
If not specified, the container runtime's default will be used, which
might be configured in the container image.
Cannot be updated.
"%,
      } | doc m%"
Containers allows injecting additional containers. This is meant to
allow adding an authentication proxy to an Alertmanager pod.
Containers described here modify an operator generated container if they
share the same name and modifications are done via a strategic merge
patch. The current container names are: `alertmanager` and
`config-reloader`. Overriding containers is entirely outside the scope
of what the maintainers will support and by doing so, you accept that
this behaviour may break at any time without notice.
"%,
      dnsConfig | optional | {
        nameservers | optional | Array String | doc m%"
A list of DNS name server IP addresses.
This will be appended to the base nameservers generated from DNSPolicy.
"%,
        options | optional | Array {
          name | String | doc "Name is required and must be unique.",
          value | optional | String | doc "Value is optional.",
        } | doc m%"
A list of DNS resolver options.
This will be merged with the base options generated from DNSPolicy.
Resolution options given in Options
will override those that appear in the base DNSPolicy.
"%,
        searches | optional | Array String | doc m%"
A list of DNS search domains for host-name lookup.
This will be appended to the base search paths generated from DNSPolicy.
"%,
      } | doc "Defines the DNS configuration for the pods.",
      dnsPolicy | optional | String | doc "Defines the DNS policy for the pods.",
      enableFeatures | optional | Array String | doc m%"
Enable access to Alertmanager feature flags. By default, no features are enabled.
Enabling features which are disabled by default is entirely outside the
scope of what the maintainers will support and by doing so, you accept
that this behaviour may break at any time without notice.

It requires Alertmanager >= 0.27.0.
"%,
      enableServiceLinks | optional | Bool | doc m%"
Indicates whether information about services should be injected into pod's environment variables
"%,
      externalUrl | optional | String | doc m%"
The external URL the Alertmanager instances will be available under. This is
necessary to generate correct URLs. This is necessary if Alertmanager is not
served from root of a DNS name.
"%,
      forceEnableClusterMode | optional | Bool | doc m%"
ForceEnableClusterMode ensures Alertmanager does not deactivate the cluster mode when running with a single replica.
Use case is e.g. spanning an Alertmanager cluster across Kubernetes clusters with a single replica in each.
"%,
      hostAliases | optional | Array {
        hostnames | Array String | doc "Hostnames for the above IP address.",
        ip | String | doc "IP address of the host file entry.",
      } | doc "Pods' hostAliases configuration",
      hostUsers | optional | Bool | doc m%"
HostUsers supports the user space in Kubernetes.

More info: https://kubernetes.io/docs/tasks/configure-pod-container/user-namespaces/

The feature requires at least Kubernetes 1.28 with the `UserNamespacesSupport` feature gate enabled.
Starting Kubernetes 1.33, the feature is enabled by default.
"%,
      image | optional | String | doc m%"
Image if specified has precedence over baseImage, tag and sha
combinations. Specifying the version is still necessary to ensure the
Prometheus Operator knows what version of Alertmanager is being
configured.
"%,
      imagePullPolicy | optional | String | doc m%"
Image pull policy for the 'alertmanager', 'init-config-reloader' and 'config-reloader' containers.
See https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy for more details.
"%,
      imagePullSecrets | optional | Array {
        name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
      } | doc m%"
An optional list of references to secrets in the same namespace
to use for pulling prometheus and alertmanager images from registries
see https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
"%,
      initContainers | optional | Array {
        args | optional | Array String | doc m%"
Arguments to the entrypoint.
The container image's CMD is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the container's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
        command | optional | Array String | doc m%"
Entrypoint array. Not executed within a shell.
The container image's ENTRYPOINT is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the container's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
        env | optional | Array k8s_io_objectmeta.EnvVar | doc m%"
List of environment variables to set in the container.
Cannot be updated.
"%,
        envFrom | optional | Array k8s_io_objectmeta.EnvFromSource | doc m%"
List of sources to populate environment variables in the container.
The keys defined within a source must be a C_IDENTIFIER. All invalid keys
will be reported as an event when the container is starting. When a key exists in multiple
sources, the value associated with the last source will take precedence.
Values defined by an Env with a duplicate key will take precedence.
Cannot be updated.
"%,
        image | optional | String | doc m%"
Container image name.
More info: https://kubernetes.io/docs/concepts/containers/images
This field is optional to allow higher level config management to default or override
container images in workload controllers like Deployments and StatefulSets.
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
          stopSignal | optional | String | doc m%"
StopSignal defines which signal will be sent to a container when it is being stopped.
If not specified, the default is defined by the container runtime in use.
StopSignal can only be set for Pods with a non-empty .spec.os.name
"%,
        } | doc m%"
Actions that the management system should take in response to container lifecycle events.
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
Periodic probe of container liveness.
Container will be restarted if the probe fails.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        name | String | doc m%"
Name of the container specified as a DNS_LABEL.
Each container in a pod must have a unique name (DNS_LABEL).
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
List of ports to expose from the container. Not specifying a port here
DOES NOT prevent that port from being exposed. Any port which is
listening on the default "0.0.0.0" address inside a container will be
accessible from the network.
Modifying this array with strategic merge patch may corrupt the data.
For more information See https://github.com/kubernetes/kubernetes/issues/108255.
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
Periodic probe of container service readiness.
Container will be removed from service endpoints if the probe fails.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        resizePolicy | optional | Array {
          resourceName | String | doc m%"
Name of the resource to which this resource resize policy applies.
Supported values: cpu, memory.
"%,
          restartPolicy | String | doc m%"
Restart policy to apply when specified resource is resized.
If not specified, it defaults to NotRequired.
"%,
        } | doc "Resources resize policy for the container.",
        resources | optional | {
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
Compute Resources required by this container.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
        restartPolicy | optional | String | doc m%"
RestartPolicy defines the restart behavior of individual containers in a pod.
This field may only be set for init containers, and the only allowed value is "Always".
For non-init containers or when this field is not specified,
the restart behavior is defined by the Pod's restart policy and the container type.
Setting the RestartPolicy as "Always" for the init container will have the following effect:
this init container will be continually restarted on
exit until all regular containers have terminated. Once all regular
containers have completed, all init containers with restartPolicy "Always"
will be shut down. This lifecycle differs from normal init containers and
is often referred to as a "sidecar" container. Although this init
container still starts in the init container sequence, it does not wait
for the container to complete before proceeding to the next init
container. Instead, the next init container starts immediately after this
init container is started, or after any startupProbe has successfully
completed.
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
SecurityContext defines the security options the container should be run with.
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
StartupProbe indicates that the Pod has successfully initialized.
If specified, no other probes are executed until this completes successfully.
If this probe fails, the Pod will be restarted, just as if the livenessProbe failed.
This can be used to provide different probe parameters at the beginning of a Pod's lifecycle,
when it might take a long time to load data or warm a cache, than during steady-state operation.
This cannot be updated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        stdin | optional | Bool | doc m%"
Whether this container should allocate a buffer for stdin in the container runtime. If this
is not set, reads from stdin in the container will always result in EOF.
Default is false.
"%,
        stdinOnce | optional | Bool | doc m%"
Whether the container runtime should close the stdin channel after it has been opened by
a single attach. When stdin is true the stdin stream will remain open across multiple attach
sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the
first client attaches to stdin, and then remains open and accepts data until the client disconnects,
at which time stdin is closed and remains closed until the container is restarted. If this
flag is false, a container processes that reads from stdin will never receive an EOF.
Default is false
"%,
        terminationMessagePath | optional | String | doc m%"
Optional: Path at which the file to which the container's termination message
will be written is mounted into the container's filesystem.
Message written is intended to be brief final status, such as an assertion failure message.
Will be truncated by the node if greater than 4096 bytes. The total message length across
all containers will be limited to 12kb.
Defaults to /dev/termination-log.
Cannot be updated.
"%,
        terminationMessagePolicy | optional | String | doc m%"
Indicate how the termination message should be populated. File will use the contents of
terminationMessagePath to populate the container status message on both success and failure.
FallbackToLogsOnError will use the last chunk of container log output if the termination
message file is empty and the container exited with an error.
The log output is limited to 2048 bytes or 80 lines, whichever is smaller.
Defaults to File.
Cannot be updated.
"%,
        tty | optional | Bool | doc m%"
Whether this container should allocate a TTY for itself, also requires 'stdin' to be true.
Default is false.
"%,
        volumeDevices | optional | Array {
          devicePath | String | doc m%"
devicePath is the path inside of the container that the device will be mapped to.
"%,
          name | String | doc "name must match the name of a persistentVolumeClaim in the pod",
        } | doc "volumeDevices is the list of block devices to be used by the container.",
        volumeMounts | optional | Array k8s_io_objectmeta.VolumeMount | doc m%"
Pod volumes to mount into the container's filesystem.
Cannot be updated.
"%,
        workingDir | optional | String | doc m%"
Container's working directory.
If not specified, the container runtime's default will be used, which
might be configured in the container image.
Cannot be updated.
"%,
      } | doc m%"
InitContainers allows adding initContainers to the pod definition. Those can be used to e.g.
fetch secrets for injection into the Alertmanager configuration from external sources. Any
errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
InitContainers described here modify an operator
generated init containers if they share the same name and modifications are
done via a strategic merge patch. The current init container name is:
`init-config-reloader`. Overriding init containers is entirely outside the
scope of what the maintainers will support and by doing so, you accept that
this behaviour may break at any time without notice.
"%,
      limits | optional | {
        maxPerSilenceBytes | optional | String | doc m%"
The maximum size of an individual silence as stored on disk. This corresponds to the Alertmanager's
`--silences.max-per-silence-bytes` flag.
It requires Alertmanager >= v0.28.0.
"%,
        maxSilences | optional | Number | doc m%"
The maximum number active and pending silences. This corresponds to the
Alertmanager's `--silences.max-silences` flag.
It requires Alertmanager >= v0.28.0.
"%,
      } | doc "Defines the limits command line flags when starting Alertmanager.",
      listenLocal | optional | Bool | doc m%"
ListenLocal makes the Alertmanager server listen on loopback, so that it
does not bind against the Pod IP. Note this is only for the Alertmanager
UI, not the gossip communication.
"%,
      logFormat | optional | String | doc "Log format for Alertmanager to be configured with.",
      logLevel | optional | String | doc "Log level for Alertmanager to be configured with.",
      minReadySeconds | optional | Number | doc m%"
Minimum number of seconds for which a newly created pod should be ready
without any of its container crashing for it to be considered available.

If unset, pods will be considered available as soon as they are ready.
"%,
      nodeSelector | optional | {
      } | doc "Define which Nodes the Pods are scheduled on.",
      paused | optional | Bool | doc m%"
If set to true all actions on the underlying managed objects are not
going to be performed, except for delete actions.
"%,
      persistentVolumeClaimRetentionPolicy | optional | {
        whenDeleted | optional | String | doc m%"
WhenDeleted specifies what happens to PVCs created from StatefulSet
VolumeClaimTemplates when the StatefulSet is deleted. The default policy
of `Retain` causes PVCs to not be affected by StatefulSet deletion. The
`Delete` policy causes those PVCs to be deleted.
"%,
        whenScaled | optional | String | doc m%"
WhenScaled specifies what happens to PVCs created from StatefulSet
VolumeClaimTemplates when the StatefulSet is scaled down. The default
policy of `Retain` causes PVCs to not be affected by a scaledown. The
`Delete` policy causes the associated PVCs for any excess pods above
the replica count to be deleted.
"%,
      } | doc m%"
The field controls if and how PVCs are deleted during the lifecycle of a StatefulSet.
The default behavior is all PVCs are retained.
This is an alpha field from kubernetes 1.23 until 1.26 and a beta field from 1.26.
It requires enabling the StatefulSetAutoDeletePVC feature gate.
"%,
      podMetadata | optional | {
        annotations | optional | {
        } | doc m%"
Annotations is an unstructured key value map stored with a resource that may be
set by external tools to store and retrieve arbitrary metadata. They are not
queryable and should be preserved when modifying objects.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/
"%,
        labels | optional | {
        } | doc m%"
Map of string keys and values that can be used to organize and categorize
(scope and select) objects. May match selectors of replication controllers
and services.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
"%,
        name | optional | String | doc m%"
Name must be unique within a namespace. Is required when creating resources, although
some resources may allow a client to request the generation of an appropriate name
automatically. Name is primarily intended for creation idempotence and configuration
definition.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/
"%,
      } | doc m%"
PodMetadata configures labels and annotations which are propagated to the Alertmanager pods.

The following items are reserved and cannot be overridden:
* "alertmanager" label, set to the name of the Alertmanager instance.
* "app.kubernetes.io/instance" label, set to the name of the Alertmanager instance.
* "app.kubernetes.io/managed-by" label, set to "prometheus-operator".
* "app.kubernetes.io/name" label, set to "alertmanager".
* "app.kubernetes.io/version" label, set to the Alertmanager version.
* "kubectl.kubernetes.io/default-container" annotation, set to "alertmanager".
"%,
      portName | String | doc m%"
Port name used for the pods and governing service.
Defaults to `web`.
"% | default = "web",
      priorityClassName | optional | String | doc "Priority class assigned to the Pods",
      replicas | optional | Number | doc m%"
Size is the expected size of the alertmanager cluster. The controller will
eventually make the size of the running cluster equal to the expected
size.
"%,
      resources | optional | {
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
      } | doc "Define resources requests and limits for single Pods.",
      retention | String | doc m%"
Time duration Alertmanager shall retain data for. Default is '120h',
and must match the regular expression `[0-9]+(ms|s|m|h)` (milliseconds seconds minutes hours).
"% | default = "120h",
      routePrefix | optional | String | doc m%"
The route prefix Alertmanager registers HTTP handlers for. This is useful,
if using ExternalURL and a proxy is rewriting HTTP routes of a request,
and the actual ExternalURL is still true, but the server serves requests
under a different route prefix. For example for use with `kubectl proxy`.
"%,
      secrets | optional | Array String | doc m%"
Secrets is a list of Secrets in the same namespace as the Alertmanager
object, which shall be mounted into the Alertmanager Pods.
Each Secret is added to the StatefulSet definition as a volume named `secret-<secret-name>`.
The Secrets are mounted into `/etc/alertmanager/secrets/<secret-name>` in the 'alertmanager' container.
"%,
      securityContext | optional | {
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
appArmorProfile is the AppArmor options to use by the containers in this pod.
Note that this field cannot be set when spec.os.name is windows.
"%,
        fsGroup | optional | Number | doc m%"
A special supplemental group that applies to all containers in a pod.
Some volume types allow the Kubelet to change the ownership of that volume
to be owned by the pod:

1. The owning GID will be the FSGroup
2. The setgid bit is set (new files created in the volume will be owned by FSGroup)
3. The permission bits are OR'd with rw-rw----

If unset, the Kubelet will not modify the ownership and permissions of any volume.
Note that this field cannot be set when spec.os.name is windows.
"%,
        fsGroupChangePolicy | optional | String | doc m%"
fsGroupChangePolicy defines behavior of changing ownership and permission of the volume
before being exposed inside Pod. This field will only apply to
volume types which support fsGroup based ownership(and permissions).
It will have no effect on ephemeral volume types such as: secret, configmaps
and emptydir.
Valid values are "OnRootMismatch" and "Always". If not specified, "Always" is used.
Note that this field cannot be set when spec.os.name is windows.
"%,
        runAsGroup | optional | Number | doc m%"
The GID to run the entrypoint of the container process.
Uses runtime default if unset.
May also be set in SecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence
for that container.
Note that this field cannot be set when spec.os.name is windows.
"%,
        runAsNonRoot | optional | Bool | doc m%"
Indicates that the container must run as a non-root user.
If true, the Kubelet will validate the image at runtime to ensure that it
does not run as UID 0 (root) and fail to start the container if it does.
If unset or false, no such validation will be performed.
May also be set in SecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
"%,
        runAsUser | optional | Number | doc m%"
The UID to run the entrypoint of the container process.
Defaults to user specified in image metadata if unspecified.
May also be set in SecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence
for that container.
Note that this field cannot be set when spec.os.name is windows.
"%,
        seLinuxChangePolicy | optional | String | doc m%"
seLinuxChangePolicy defines how the container's SELinux label is applied to all volumes used by the Pod.
It has no effect on nodes that do not support SELinux or to volumes does not support SELinux.
Valid values are "MountOption" and "Recursive".

"Recursive" means relabeling of all files on all Pod volumes by the container runtime.
This may be slow for large volumes, but allows mixing privileged and unprivileged Pods sharing the same volume on the same node.

"MountOption" mounts all eligible Pod volumes with `-o context` mount option.
This requires all Pods that share the same volume to use the same SELinux label.
It is not possible to share the same volume among privileged and unprivileged Pods.
Eligible volumes are in-tree FibreChannel and iSCSI volumes, and all CSI volumes
whose CSI driver announces SELinux support by setting spec.seLinuxMount: true in their
CSIDriver instance. Other volumes are always re-labelled recursively.
"MountOption" value is allowed only when SELinuxMount feature gate is enabled.

If not specified and SELinuxMount feature gate is enabled, "MountOption" is used.
If not specified and SELinuxMount feature gate is disabled, "MountOption" is used for ReadWriteOncePod volumes
and "Recursive" for all other volumes.

This field affects only Pods that have SELinux label set, either in PodSecurityContext or in SecurityContext of all containers.

All Pods that use the same volume should use the same seLinuxChangePolicy, otherwise some pods can get stuck in ContainerCreating state.
Note that this field cannot be set when spec.os.name is windows.
"%,
        seLinuxOptions | optional | {
          level | optional | String | doc "Level is SELinux level label that applies to the container.",
          role | optional | String | doc "Role is a SELinux role label that applies to the container.",
          type | optional | String | doc "Type is a SELinux type label that applies to the container.",
          user | optional | String | doc "User is a SELinux user label that applies to the container.",
        } | doc m%"
The SELinux context to be applied to all containers.
If unspecified, the container runtime will allocate a random SELinux context for each
container.  May also be set in SecurityContext.  If set in
both SecurityContext and PodSecurityContext, the value specified in SecurityContext
takes precedence for that container.
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
The seccomp options to use by the containers in this pod.
Note that this field cannot be set when spec.os.name is windows.
"%,
        supplementalGroups | optional | Array Number | doc m%"
A list of groups applied to the first process run in each container, in
addition to the container's primary GID and fsGroup (if specified).  If
the SupplementalGroupsPolicy feature is enabled, the
supplementalGroupsPolicy field determines whether these are in addition
to or instead of any group memberships defined in the container image.
If unspecified, no additional groups are added, though group memberships
defined in the container image may still be used, depending on the
supplementalGroupsPolicy field.
Note that this field cannot be set when spec.os.name is windows.
"%,
        supplementalGroupsPolicy | optional | String | doc m%"
Defines how supplemental groups of the first container processes are calculated.
Valid values are "Merge" and "Strict". If not specified, "Merge" is used.
(Alpha) Using the field requires the SupplementalGroupsPolicy feature gate to be enabled
and the container runtime must implement support for this feature.
Note that this field cannot be set when spec.os.name is windows.
"%,
        sysctls | optional | Array {
          name | String | doc "Name of a property to set",
          value | String | doc "Value of a property to set",
        } | doc m%"
Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported
sysctls (by the container runtime) might fail to launch.
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
If unspecified, the options within a container's SecurityContext will be used.
If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is linux.
"%,
      } | doc m%"
SecurityContext holds pod-level security attributes and common container settings.
This defaults to the default PodSecurityContext.
"%,
      serviceAccountName | optional | String | doc m%"
ServiceAccountName is the name of the ServiceAccount to use to run the
Prometheus Pods.
"%,
      serviceName | optional | String | doc m%"
The name of the service name used by the underlying StatefulSet(s) as the governing service.
If defined, the Service  must be created before the Alertmanager resource in the same namespace and it must define a selector that matches the pod labels.
If empty, the operator will create and manage a headless service named `alertmanager-operated` for Alermanager resources.
When deploying multiple Alertmanager resources in the same namespace, it is recommended to specify a different value for each.
See https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#stable-network-id for more details.
"%,
      sha | optional | String | doc m%"
SHA of Alertmanager container image to be deployed. Defaults to the value of `version`.
Similar to a tag, but the SHA explicitly deploys an immutable container image.
Version and Tag are ignored if SHA is set.
Deprecated: use 'image' instead. The image digest can be specified as part of the image URL.
"%,
      storage | optional | {
        disableMountSubPath | optional | Bool | doc "Deprecated: subPath usage will be removed in a future release.",
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
EmptyDirVolumeSource to be used by the StatefulSet.
If specified, it takes precedence over `ephemeral` and `volumeClaimTemplate`.
More info: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir
"%,
        ephemeral | optional | {
          volumeClaimTemplate | optional | {
            metadata | optional | k8s_io_objectmeta.ObjectMeta | doc m%"
May contain labels and annotations that will be copied into the PVC
when creating it. No other fields are allowed and will be rejected during
validation.
"%,
            spec | {
              accessModes | optional | Array String | doc m%"
accessModes contains the desired access modes the volume should have.
More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
"%,
              dataSource | optional | {
                apiGroup | optional | String | doc m%"
APIGroup is the group for the resource being referenced.
If APIGroup is not specified, the specified Kind must be in the core API group.
For any other third-party types, APIGroup is required.
"%,
                kind | String | doc "Kind is the type of resource being referenced",
                name | String | doc "Name is the name of resource being referenced",
              } | doc m%"
dataSource field can be used to specify either:
* An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)
* An existing PVC (PersistentVolumeClaim)
If the provisioner or an external controller can support the specified data source,
it will create a new volume based on the contents of the specified data source.
When the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef,
and dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified.
If the namespace is specified, then dataSourceRef will not be copied to dataSource.
"%,
              dataSourceRef | optional | {
                apiGroup | optional | String | doc m%"
APIGroup is the group for the resource being referenced.
If APIGroup is not specified, the specified Kind must be in the core API group.
For any other third-party types, APIGroup is required.
"%,
                kind | String | doc "Kind is the type of resource being referenced",
                name | String | doc "Name is the name of resource being referenced",
                namespace | optional | String | doc m%"
Namespace is the namespace of resource being referenced
Note that when a namespace is specified, a gateway.networking.k8s.io/ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details.
(Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
"%,
              } | doc m%"
dataSourceRef specifies the object from which to populate the volume with data, if a non-empty
volume is desired. This may be any object from a non-empty API group (non
core object) or a PersistentVolumeClaim object.
When this field is specified, volume binding will only succeed if the type of
the specified object matches some installed volume populator or dynamic
provisioner.
This field will replace the functionality of the dataSource field and as such
if both fields are non-empty, they must have the same value. For backwards
compatibility, when namespace isn't specified in dataSourceRef,
both fields (dataSource and dataSourceRef) will be set to the same
value automatically if one of them is empty and the other is non-empty.
When namespace is specified in dataSourceRef,
dataSource isn't set to the same value and must be empty.
There are three important differences between dataSource and dataSourceRef:
* While dataSource only allows two specific types of objects, dataSourceRef
  allows any non-core object, as well as PersistentVolumeClaim objects.
* While dataSource ignores disallowed values (dropping them), dataSourceRef
  preserves all values, and generates an error if a disallowed value is
  specified.
* While dataSource only allows local objects, dataSourceRef allows objects
  in any namespaces.
(Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled.
(Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
"%,
              resources | optional | {
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
resources represents the minimum resources the volume should have.
If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements
that are lower than previous value but must still be higher than capacity recorded in the
status field of the claim.
More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources
"%,
              selector | optional | {
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
              } | doc "selector is a label query over volumes to consider for binding.",
              storageClassName | optional | String | doc m%"
storageClassName is the name of the StorageClass required by the claim.
More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1
"%,
              volumeAttributesClassName | optional | String | doc m%"
volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim.
If specified, the CSI driver will create or update the volume with the attributes defined
in the corresponding VolumeAttributesClass. This has a different purpose than storageClassName,
it can be changed after the claim is created. An empty string value means that no VolumeAttributesClass
will be applied to the claim but it's not allowed to reset this field to empty string once it is set.
If unspecified and the PersistentVolumeClaim is unbound, the default VolumeAttributesClass
will be set by the persistentvolume controller if it exists.
If the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be
set to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource
exists.
More info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/
(Beta) Using this field requires the VolumeAttributesClass feature gate to be enabled (off by default).
"%,
              volumeMode | optional | String | doc m%"
volumeMode defines what type of volume is required by the claim.
Value of Filesystem is implied when not included in claim spec.
"%,
              volumeName | optional | String | doc "volumeName is the binding reference to the PersistentVolume backing this claim.",
            } | doc m%"
The specification for the PersistentVolumeClaim. The entire content is
copied unchanged into the PVC that gets created from this
template. The same fields as in a PersistentVolumeClaim
are also valid here.
"%,
          } | doc m%"
Will be used to create a stand-alone PVC to provision the volume.
The pod in which this EphemeralVolumeSource is embedded will be the
owner of the PVC, i.e. the PVC will be deleted together with the
pod.  The name of the PVC will be `<pod name>-<volume name>` where
`<volume name>` is the name from the `PodSpec.Volumes` array
entry. Pod validation will reject the pod if the concatenated name
is not valid for a PVC (for example, too long).

An existing PVC with that name that is not owned by the pod
will *not* be used for the pod to avoid using an unrelated
volume by mistake. Starting the pod is then blocked until
the unrelated PVC is removed. If such a pre-created PVC is
meant to be used by the pod, the PVC has to updated with an
owner reference to the pod once the pod exists. Normally
this should not be necessary, but it may be useful when
manually reconstructing a broken cluster.

This field is read-only and no changes will be made by Kubernetes
to the PVC after it has been created.

Required, must not be nil.
"%,
        } | doc m%"
EphemeralVolumeSource to be used by the StatefulSet.
This is a beta field in k8s 1.21 and GA in 1.15.
For lower versions, starting with k8s 1.19, it requires enabling the GenericEphemeralVolume feature gate.
More info: https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/#generic-ephemeral-volumes
"%,
        volumeClaimTemplate | optional | {
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
          metadata | optional | {
            annotations | optional | {
            } | doc m%"
Annotations is an unstructured key value map stored with a resource that may be
set by external tools to store and retrieve arbitrary metadata. They are not
queryable and should be preserved when modifying objects.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/
"%,
            labels | optional | {
            } | doc m%"
Map of string keys and values that can be used to organize and categorize
(scope and select) objects. May match selectors of replication controllers
and services.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
"%,
            name | optional | String | doc m%"
Name must be unique within a namespace. Is required when creating resources, although
some resources may allow a client to request the generation of an appropriate name
automatically. Name is primarily intended for creation idempotence and configuration
definition.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/
"%,
          } | doc "EmbeddedMetadata contains metadata relevant to an EmbeddedResource.",
          spec | optional | {
            accessModes | optional | Array String | doc m%"
accessModes contains the desired access modes the volume should have.
More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
"%,
            dataSource | optional | {
              apiGroup | optional | String | doc m%"
APIGroup is the group for the resource being referenced.
If APIGroup is not specified, the specified Kind must be in the core API group.
For any other third-party types, APIGroup is required.
"%,
              kind | String | doc "Kind is the type of resource being referenced",
              name | String | doc "Name is the name of resource being referenced",
            } | doc m%"
dataSource field can be used to specify either:
* An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)
* An existing PVC (PersistentVolumeClaim)
If the provisioner or an external controller can support the specified data source,
it will create a new volume based on the contents of the specified data source.
When the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef,
and dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified.
If the namespace is specified, then dataSourceRef will not be copied to dataSource.
"%,
            dataSourceRef | optional | {
              apiGroup | optional | String | doc m%"
APIGroup is the group for the resource being referenced.
If APIGroup is not specified, the specified Kind must be in the core API group.
For any other third-party types, APIGroup is required.
"%,
              kind | String | doc "Kind is the type of resource being referenced",
              name | String | doc "Name is the name of resource being referenced",
              namespace | optional | String | doc m%"
Namespace is the namespace of resource being referenced
Note that when a namespace is specified, a gateway.networking.k8s.io/ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details.
(Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
"%,
            } | doc m%"
dataSourceRef specifies the object from which to populate the volume with data, if a non-empty
volume is desired. This may be any object from a non-empty API group (non
core object) or a PersistentVolumeClaim object.
When this field is specified, volume binding will only succeed if the type of
the specified object matches some installed volume populator or dynamic
provisioner.
This field will replace the functionality of the dataSource field and as such
if both fields are non-empty, they must have the same value. For backwards
compatibility, when namespace isn't specified in dataSourceRef,
both fields (dataSource and dataSourceRef) will be set to the same
value automatically if one of them is empty and the other is non-empty.
When namespace is specified in dataSourceRef,
dataSource isn't set to the same value and must be empty.
There are three important differences between dataSource and dataSourceRef:
* While dataSource only allows two specific types of objects, dataSourceRef
  allows any non-core object, as well as PersistentVolumeClaim objects.
* While dataSource ignores disallowed values (dropping them), dataSourceRef
  preserves all values, and generates an error if a disallowed value is
  specified.
* While dataSource only allows local objects, dataSourceRef allows objects
  in any namespaces.
(Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled.
(Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
"%,
            resources | optional | {
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
resources represents the minimum resources the volume should have.
If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements
that are lower than previous value but must still be higher than capacity recorded in the
status field of the claim.
More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources
"%,
            selector | optional | {
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
            } | doc "selector is a label query over volumes to consider for binding.",
            storageClassName | optional | String | doc m%"
storageClassName is the name of the StorageClass required by the claim.
More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1
"%,
            volumeAttributesClassName | optional | String | doc m%"
volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim.
If specified, the CSI driver will create or update the volume with the attributes defined
in the corresponding VolumeAttributesClass. This has a different purpose than storageClassName,
it can be changed after the claim is created. An empty string value means that no VolumeAttributesClass
will be applied to the claim but it's not allowed to reset this field to empty string once it is set.
If unspecified and the PersistentVolumeClaim is unbound, the default VolumeAttributesClass
will be set by the persistentvolume controller if it exists.
If the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be
set to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource
exists.
More info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/
(Beta) Using this field requires the VolumeAttributesClass feature gate to be enabled (off by default).
"%,
            volumeMode | optional | String | doc m%"
volumeMode defines what type of volume is required by the claim.
Value of Filesystem is implied when not included in claim spec.
"%,
            volumeName | optional | String | doc "volumeName is the binding reference to the PersistentVolume backing this claim.",
          } | doc m%"
Defines the desired characteristics of a volume requested by a pod author.
More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
"%,
          status | optional | {
            accessModes | optional | Array String | doc m%"
accessModes contains the actual access modes the volume backing the PVC has.
More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
"%,
            allocatedResourceStatuses | optional | {
            } | doc m%"
allocatedResourceStatuses stores status of resource being resized for the given PVC.
Key names follow standard Kubernetes label syntax. Valid values are either:
	* Un-prefixed keys:
		- storage - the capacity of the volume.
	* Custom resources must use implementation-defined prefixed names such as "example.com/my-custom-resource"
Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered
reserved and hence may not be used.

ClaimResourceStatus can be in any of following states:
	- ControllerResizeInProgress:
		State set when resize controller starts resizing the volume in control-plane.
	- ControllerResizeFailed:
		State set when resize has failed in resize controller with a terminal error.
	- NodeResizePending:
		State set when resize controller has finished resizing the volume but further resizing of
		volume is needed on the node.
	- NodeResizeInProgress:
		State set when kubelet starts resizing the volume.
	- NodeResizeFailed:
		State set when resizing has failed in kubelet with a terminal error. Transient errors don't set
		NodeResizeFailed.
For example: if expanding a PVC for more capacity - this field can be one of the following states:
	- pvc.status.allocatedResourceStatus['storage'] = "ControllerResizeInProgress"
     - pvc.status.allocatedResourceStatus['storage'] = "ControllerResizeFailed"
     - pvc.status.allocatedResourceStatus['storage'] = "NodeResizePending"
     - pvc.status.allocatedResourceStatus['storage'] = "NodeResizeInProgress"
     - pvc.status.allocatedResourceStatus['storage'] = "NodeResizeFailed"
When this field is not set, it means that no resize operation is in progress for the given PVC.

A controller that receives PVC update with previously unknown resourceName or ClaimResourceStatus
should ignore the update for the purpose it was designed. For example - a controller that
only is responsible for resizing capacity of the volume, should ignore PVC updates that change other valid
resources associated with PVC.

This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature.
"%,
            allocatedResources | optional | {
            } | doc m%"
allocatedResources tracks the resources allocated to a PVC including its capacity.
Key names follow standard Kubernetes label syntax. Valid values are either:
	* Un-prefixed keys:
		- storage - the capacity of the volume.
	* Custom resources must use implementation-defined prefixed names such as "example.com/my-custom-resource"
Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered
reserved and hence may not be used.

Capacity reported here may be larger than the actual capacity when a volume expansion operation
is requested.
For storage quota, the larger value from allocatedResources and PVC.spec.resources is used.
If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation.
If a volume expansion capacity request is lowered, allocatedResources is only
lowered if there are no expansion operations in progress and if the actual volume capacity
is equal or lower than the requested capacity.

A controller that receives PVC update with previously unknown resourceName
should ignore the update for the purpose it was designed. For example - a controller that
only is responsible for resizing capacity of the volume, should ignore PVC updates that change other valid
resources associated with PVC.

This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature.
"%,
            capacity | optional | {
            } | doc "capacity represents the actual resources of the underlying volume.",
            conditions | optional | Array {
              lastProbeTime | optional | String | doc "lastProbeTime is the time we probed the condition.",
              lastTransitionTime | optional | String | doc m%"
lastTransitionTime is the time the condition transitioned from one status to another.
"%,
              message | optional | String | doc "message is the human-readable message indicating details about last transition.",
              reason | optional | String | doc m%"
reason is a unique, this should be a short, machine understandable string that gives the reason
for condition's last transition. If it reports "Resizing" that means the underlying
persistent volume is being resized.
"%,
              status | String | doc m%"
Status is the status of the condition.
Can be True, False, Unknown.
More info: https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=state%20of%20pvc-,conditions.status,-(string)%2C%20required
"%,
              type | String | doc m%"
Type is the type of the condition.
More info: https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=set%20to%20%27ResizeStarted%27.-,PersistentVolumeClaimCondition,-contains%20details%20about
"%,
            } | doc m%"
conditions is the current Condition of persistent volume claim. If underlying persistent volume is being
resized then the Condition will be set to 'Resizing'.
"%,
            currentVolumeAttributesClassName | optional | String | doc m%"
currentVolumeAttributesClassName is the current name of the VolumeAttributesClass the PVC is using.
When unset, there is no VolumeAttributeClass applied to this PersistentVolumeClaim
This is a beta field and requires enabling VolumeAttributesClass feature (off by default).
"%,
            modifyVolumeStatus | optional | {
              status | String | doc m%"
status is the status of the ControllerModifyVolume operation. It can be in any of following states:
 - Pending
   Pending indicates that the PersistentVolumeClaim cannot be modified due to unmet requirements, such as
   the specified VolumeAttributesClass not existing.
 - InProgress
   InProgress indicates that the volume is being modified.
 - Infeasible
  Infeasible indicates that the request has been rejected as invalid by the CSI driver. To
	  resolve the error, a valid VolumeAttributesClass needs to be specified.
Note: New statuses can be added in the future. Consumers should check for unknown statuses and fail appropriately.
"%,
              targetVolumeAttributesClassName | optional | String | doc m%"
targetVolumeAttributesClassName is the name of the VolumeAttributesClass the PVC currently being reconciled
"%,
            } | doc m%"
ModifyVolumeStatus represents the status object of ControllerModifyVolume operation.
When this is unset, there is no ModifyVolume operation being attempted.
This is a beta field and requires enabling VolumeAttributesClass feature (off by default).
"%,
            phase | optional | String | doc "phase represents the current phase of PersistentVolumeClaim.",
          } | doc "Deprecated: this field is never set.",
        } | doc m%"
Defines the PVC spec to be used by the Prometheus StatefulSets.
The easiest way to use a volume that cannot be automatically provisioned
is to use a label selector alongside manually created PersistentVolumes.
"%,
      } | doc m%"
Storage is the definition of how storage will be used by the Alertmanager
instances.
"%,
      tag | optional | String | doc m%"
Tag of Alertmanager container image to be deployed. Defaults to the value of `version`.
Version is ignored if Tag is set.
Deprecated: use 'image' instead. The image tag can be specified as part of the image URL.
"%,
      terminationGracePeriodSeconds | optional | Number | doc m%"
Optional duration in seconds the pod needs to terminate gracefully.
Value must be non-negative integer. The value zero indicates stop immediately via
the kill signal (no opportunity to shut down) which may lead to data corruption.

Defaults to 120 seconds.
"%,
      tolerations | optional | Array k8s_io_objectmeta.Toleration | doc "If specified, the pod's tolerations.",
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
"%,
        nodeTaintsPolicy | optional | String | doc m%"
NodeTaintsPolicy indicates how we will treat node taints when calculating
pod topology spread skew. Options are:
- Honor: nodes without taints, along with tainted nodes for which the incoming pod
has a toleration, are included.
- Ignore: node taints are ignored. All nodes are included.

If this value is nil, the behavior is equivalent to the Ignore policy.
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
      } | doc "If specified, the pod's topology spread constraints.",
      version | optional | String | doc "Version the cluster should be on.",
      volumeMounts | optional | Array k8s_io_objectmeta.VolumeMount | doc m%"
VolumeMounts allows configuration of additional VolumeMounts on the output StatefulSet definition.
VolumeMounts specified will be appended to other VolumeMounts in the alertmanager container,
that are generated as a result of StorageSpec objects.
"%,
      volumes | optional | Array {
        awsElasticBlockStore | optional | {
          fsType | optional | String | doc m%"
fsType is the filesystem type of the volume that you want to mount.
Tip: Ensure that the filesystem type is supported by the host operating system.
Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
"%,
          partition | optional | Number | doc m%"
partition is the partition in the volume that you want to mount.
If omitted, the default is to mount by volume name.
Examples: For volume /dev/sda1, you specify the partition as "1".
Similarly, the volume partition for /dev/sda is "0" (or you can leave the property empty).
"%,
          readOnly | optional | Bool | doc m%"
readOnly value true will force the readOnly setting in VolumeMounts.
More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
"%,
          volumeID | String | doc m%"
volumeID is unique ID of the persistent disk resource in AWS (Amazon EBS volume).
More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
"%,
        } | doc m%"
awsElasticBlockStore represents an AWS Disk resource that is attached to a
kubelet's host machine and then exposed to the pod.
Deprecated: AWSElasticBlockStore is deprecated. All operations for the in-tree
awsElasticBlockStore type are redirected to the ebs.csi.aws.com CSI driver.
More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
"%,
        azureDisk | optional | {
          cachingMode | optional | String | doc "cachingMode is the Host Caching mode: None, Read Only, Read Write.",
          diskName | String | doc "diskName is the Name of the data disk in the blob storage",
          diskURI | String | doc "diskURI is the URI of data disk in the blob storage",
          fsType | String | doc m%"
fsType is Filesystem type to mount.
Must be a filesystem type supported by the host operating system.
Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
"% | default = "ext4",
          kind | optional | String | doc m%"
kind expected values are Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared
"%,
          readOnly | Bool | doc m%"
readOnly Defaults to false (read/write). ReadOnly here will force
the ReadOnly setting in VolumeMounts.
"% | default = false,
        } | doc m%"
azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.
Deprecated: AzureDisk is deprecated. All operations for the in-tree azureDisk type
are redirected to the disk.csi.azure.com CSI driver.
"%,
        azureFile | optional | {
          readOnly | optional | Bool | doc m%"
readOnly defaults to false (read/write). ReadOnly here will force
the ReadOnly setting in VolumeMounts.
"%,
          secretName | String | doc m%"
secretName is the  name of secret that contains Azure Storage Account Name and Key
"%,
          shareName | String | doc "shareName is the azure share Name",
        } | doc m%"
azureFile represents an Azure File Service mount on the host and bind mount to the pod.
Deprecated: AzureFile is deprecated. All operations for the in-tree azureFile type
are redirected to the file.csi.azure.com CSI driver.
"%,
        cephfs | optional | {
          monitors | Array String | doc m%"
monitors is Required: Monitors is a collection of Ceph monitors
More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
"%,
          path | optional | String | doc m%"
path is Optional: Used as the mounted root, rather than the full Ceph tree, default is /
"%,
          readOnly | optional | Bool | doc m%"
readOnly is Optional: Defaults to false (read/write). ReadOnly here will force
the ReadOnly setting in VolumeMounts.
More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
"%,
          secretFile | optional | String | doc m%"
secretFile is Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret
More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
"%,
          secretRef | optional | {
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          } | doc m%"
secretRef is Optional: SecretRef is reference to the authentication secret for User, default is empty.
More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
"%,
          user | optional | String | doc m%"
user is optional: User is the rados user name, default is admin
More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
"%,
        } | doc m%"
cephFS represents a Ceph FS mount on the host that shares a pod's lifetime.
Deprecated: CephFS is deprecated and the in-tree cephfs type is no longer supported.
"%,
        cinder | optional | {
          fsType | optional | String | doc m%"
fsType is the filesystem type to mount.
Must be a filesystem type supported by the host operating system.
Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
More info: https://examples.k8s.io/mysql-cinder-pd/README.md
"%,
          readOnly | optional | Bool | doc m%"
readOnly defaults to false (read/write). ReadOnly here will force
the ReadOnly setting in VolumeMounts.
More info: https://examples.k8s.io/mysql-cinder-pd/README.md
"%,
          secretRef | optional | {
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          } | doc m%"
secretRef is optional: points to a secret object containing parameters used to connect
to OpenStack.
"%,
          volumeID | String | doc m%"
volumeID used to identify the volume in cinder.
More info: https://examples.k8s.io/mysql-cinder-pd/README.md
"%,
        } | doc m%"
cinder represents a cinder volume attached and mounted on kubelets host machine.
Deprecated: Cinder is deprecated. All operations for the in-tree cinder type
are redirected to the cinder.csi.openstack.org CSI driver.
More info: https://examples.k8s.io/mysql-cinder-pd/README.md
"%,
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
          optional | optional | Bool | doc "optional specify whether the ConfigMap or its keys must be defined",
        } | doc "configMap represents a configMap that should populate this volume",
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
csi (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers.
"%,
        downwardAPI | optional | {
          defaultMode | optional | Number | doc m%"
Optional: mode bits to use on created files by default. Must be a
Optional: mode bits used to set permissions on created files by default.
Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
Defaults to 0644.
Directories within the path are not affected by this setting.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
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
          } | doc "Items is a list of downward API volume file",
        } | doc m%"
downwardAPI represents downward API about the pod that should populate this volume
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
emptyDir represents a temporary directory that shares a pod's lifetime.
More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
"%,
        ephemeral | optional | {
          volumeClaimTemplate | optional | {
            metadata | optional | k8s_io_objectmeta.ObjectMeta | doc m%"
May contain labels and annotations that will be copied into the PVC
when creating it. No other fields are allowed and will be rejected during
validation.
"%,
            spec | {
              accessModes | optional | Array String | doc m%"
accessModes contains the desired access modes the volume should have.
More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
"%,
              dataSource | optional | {
                apiGroup | optional | String | doc m%"
APIGroup is the group for the resource being referenced.
If APIGroup is not specified, the specified Kind must be in the core API group.
For any other third-party types, APIGroup is required.
"%,
                kind | String | doc "Kind is the type of resource being referenced",
                name | String | doc "Name is the name of resource being referenced",
              } | doc m%"
dataSource field can be used to specify either:
* An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)
* An existing PVC (PersistentVolumeClaim)
If the provisioner or an external controller can support the specified data source,
it will create a new volume based on the contents of the specified data source.
When the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef,
and dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified.
If the namespace is specified, then dataSourceRef will not be copied to dataSource.
"%,
              dataSourceRef | optional | {
                apiGroup | optional | String | doc m%"
APIGroup is the group for the resource being referenced.
If APIGroup is not specified, the specified Kind must be in the core API group.
For any other third-party types, APIGroup is required.
"%,
                kind | String | doc "Kind is the type of resource being referenced",
                name | String | doc "Name is the name of resource being referenced",
                namespace | optional | String | doc m%"
Namespace is the namespace of resource being referenced
Note that when a namespace is specified, a gateway.networking.k8s.io/ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details.
(Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
"%,
              } | doc m%"
dataSourceRef specifies the object from which to populate the volume with data, if a non-empty
volume is desired. This may be any object from a non-empty API group (non
core object) or a PersistentVolumeClaim object.
When this field is specified, volume binding will only succeed if the type of
the specified object matches some installed volume populator or dynamic
provisioner.
This field will replace the functionality of the dataSource field and as such
if both fields are non-empty, they must have the same value. For backwards
compatibility, when namespace isn't specified in dataSourceRef,
both fields (dataSource and dataSourceRef) will be set to the same
value automatically if one of them is empty and the other is non-empty.
When namespace is specified in dataSourceRef,
dataSource isn't set to the same value and must be empty.
There are three important differences between dataSource and dataSourceRef:
* While dataSource only allows two specific types of objects, dataSourceRef
  allows any non-core object, as well as PersistentVolumeClaim objects.
* While dataSource ignores disallowed values (dropping them), dataSourceRef
  preserves all values, and generates an error if a disallowed value is
  specified.
* While dataSource only allows local objects, dataSourceRef allows objects
  in any namespaces.
(Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled.
(Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
"%,
              resources | optional | {
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
resources represents the minimum resources the volume should have.
If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements
that are lower than previous value but must still be higher than capacity recorded in the
status field of the claim.
More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources
"%,
              selector | optional | {
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
              } | doc "selector is a label query over volumes to consider for binding.",
              storageClassName | optional | String | doc m%"
storageClassName is the name of the StorageClass required by the claim.
More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1
"%,
              volumeAttributesClassName | optional | String | doc m%"
volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim.
If specified, the CSI driver will create or update the volume with the attributes defined
in the corresponding VolumeAttributesClass. This has a different purpose than storageClassName,
it can be changed after the claim is created. An empty string value means that no VolumeAttributesClass
will be applied to the claim but it's not allowed to reset this field to empty string once it is set.
If unspecified and the PersistentVolumeClaim is unbound, the default VolumeAttributesClass
will be set by the persistentvolume controller if it exists.
If the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be
set to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource
exists.
More info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/
(Beta) Using this field requires the VolumeAttributesClass feature gate to be enabled (off by default).
"%,
              volumeMode | optional | String | doc m%"
volumeMode defines what type of volume is required by the claim.
Value of Filesystem is implied when not included in claim spec.
"%,
              volumeName | optional | String | doc "volumeName is the binding reference to the PersistentVolume backing this claim.",
            } | doc m%"
The specification for the PersistentVolumeClaim. The entire content is
copied unchanged into the PVC that gets created from this
template. The same fields as in a PersistentVolumeClaim
are also valid here.
"%,
          } | doc m%"
Will be used to create a stand-alone PVC to provision the volume.
The pod in which this EphemeralVolumeSource is embedded will be the
owner of the PVC, i.e. the PVC will be deleted together with the
pod.  The name of the PVC will be `<pod name>-<volume name>` where
`<volume name>` is the name from the `PodSpec.Volumes` array
entry. Pod validation will reject the pod if the concatenated name
is not valid for a PVC (for example, too long).

An existing PVC with that name that is not owned by the pod
will *not* be used for the pod to avoid using an unrelated
volume by mistake. Starting the pod is then blocked until
the unrelated PVC is removed. If such a pre-created PVC is
meant to be used by the pod, the PVC has to updated with an
owner reference to the pod once the pod exists. Normally
this should not be necessary, but it may be useful when
manually reconstructing a broken cluster.

This field is read-only and no changes will be made by Kubernetes
to the PVC after it has been created.

Required, must not be nil.
"%,
        } | doc m%"
ephemeral represents a volume that is handled by a cluster storage driver.
The volume's lifecycle is tied to the pod that defines it - it will be created before the pod starts,
and deleted when the pod is removed.

Use this if:
a) the volume is only needed while the pod runs,
b) features of normal volumes like restoring from snapshot or capacity
   tracking are needed,
c) the storage driver is specified through a storage class, and
d) the storage driver supports dynamic volume provisioning through
   a PersistentVolumeClaim (see EphemeralVolumeSource for more
   information on the connection between this volume type
   and PersistentVolumeClaim).

Use PersistentVolumeClaim or one of the vendor-specific
APIs for volumes that persist for longer than the lifecycle
of an individual pod.

Use CSI for light-weight local ephemeral volumes if the CSI driver is meant to
be used that way - see the documentation of the driver for
more information.

A pod can use both types of ephemeral volumes and
persistent volumes at the same time.
"%,
        fc | optional | {
          fsType | optional | String | doc m%"
fsType is the filesystem type to mount.
Must be a filesystem type supported by the host operating system.
Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
"%,
          lun | optional | Number | doc "lun is Optional: FC target lun number",
          readOnly | optional | Bool | doc m%"
readOnly is Optional: Defaults to false (read/write). ReadOnly here will force
the ReadOnly setting in VolumeMounts.
"%,
          targetWWNs | optional | Array String | doc "targetWWNs is Optional: FC target worldwide names (WWNs)",
          wwids | optional | Array String | doc m%"
wwids Optional: FC volume world wide identifiers (wwids)
Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously.
"%,
        } | doc m%"
fc represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod.
"%,
        flexVolume | optional | {
          driver | String | doc "driver is the name of the driver to use for this volume.",
          fsType | optional | String | doc m%"
fsType is the filesystem type to mount.
Must be a filesystem type supported by the host operating system.
Ex. "ext4", "xfs", "ntfs". The default filesystem depends on FlexVolume script.
"%,
          options | optional | {
          } | doc "options is Optional: this field holds extra command options if any.",
          readOnly | optional | Bool | doc m%"
readOnly is Optional: defaults to false (read/write). ReadOnly here will force
the ReadOnly setting in VolumeMounts.
"%,
          secretRef | optional | {
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          } | doc m%"
secretRef is Optional: secretRef is reference to the secret object containing
sensitive information to pass to the plugin scripts. This may be
empty if no secret object is specified. If the secret object
contains more than one secret, all secrets are passed to the plugin
scripts.
"%,
        } | doc m%"
flexVolume represents a generic volume resource that is
provisioned/attached using an exec based plugin.
Deprecated: FlexVolume is deprecated. Consider using a CSIDriver instead.
"%,
        flocker | optional | {
          datasetName | optional | String | doc m%"
datasetName is Name of the dataset stored as metadata -> name on the dataset for Flocker
should be considered as deprecated
"%,
          datasetUUID | optional | String | doc m%"
datasetUUID is the UUID of the dataset. This is unique identifier of a Flocker dataset
"%,
        } | doc m%"
flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running.
Deprecated: Flocker is deprecated and the in-tree flocker type is no longer supported.
"%,
        gcePersistentDisk | optional | {
          fsType | optional | String | doc m%"
fsType is filesystem type of the volume that you want to mount.
Tip: Ensure that the filesystem type is supported by the host operating system.
Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
"%,
          partition | optional | Number | doc m%"
partition is the partition in the volume that you want to mount.
If omitted, the default is to mount by volume name.
Examples: For volume /dev/sda1, you specify the partition as "1".
Similarly, the volume partition for /dev/sda is "0" (or you can leave the property empty).
More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
"%,
          pdName | String | doc m%"
pdName is unique name of the PD resource in GCE. Used to identify the disk in GCE.
More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
"%,
          readOnly | optional | Bool | doc m%"
readOnly here will force the ReadOnly setting in VolumeMounts.
Defaults to false.
More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
"%,
        } | doc m%"
gcePersistentDisk represents a GCE Disk resource that is attached to a
kubelet's host machine and then exposed to the pod.
Deprecated: GCEPersistentDisk is deprecated. All operations for the in-tree
gcePersistentDisk type are redirected to the pd.csi.storage.gke.io CSI driver.
More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
"%,
        gitRepo | optional | {
          directory | optional | String | doc m%"
directory is the target directory name.
Must not contain or start with '..'.  If '.' is supplied, the volume directory will be the
git repository.  Otherwise, if specified, the volume will contain the git repository in
the subdirectory with the given name.
"%,
          repository | String | doc "repository is the URL",
          revision | optional | String | doc "revision is the commit hash for the specified revision.",
        } | doc m%"
gitRepo represents a git repository at a particular revision.
Deprecated: GitRepo is deprecated. To provision a container with a git repo, mount an
EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir
into the Pod's container.
"%,
        glusterfs | optional | {
          endpoints | String | doc m%"
endpoints is the endpoint name that details Glusterfs topology.
More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
"%,
          path | String | doc m%"
path is the Glusterfs volume path.
More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
"%,
          readOnly | optional | Bool | doc m%"
readOnly here will force the Glusterfs volume to be mounted with read-only permissions.
Defaults to false.
More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
"%,
        } | doc m%"
glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime.
Deprecated: Glusterfs is deprecated and the in-tree glusterfs type is no longer supported.
More info: https://examples.k8s.io/volumes/glusterfs/README.md
"%,
        hostPath | optional | {
          path | String | doc m%"
path of the directory on the host.
If the path is a symlink, it will follow the link to the real path.
More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
"%,
          type | optional | String | doc m%"
type for HostPath Volume
Defaults to ""
More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
"%,
        } | doc m%"
hostPath represents a pre-existing file or directory on the host
machine that is directly exposed to the container. This is generally
used for system agents or other privileged things that are allowed
to see the host machine. Most containers will NOT need this.
More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
"%,
        image | optional | {
          pullPolicy | optional | String | doc m%"
Policy for pulling OCI objects. Possible values are:
Always: the kubelet always attempts to pull the reference. Container creation will fail If the pull fails.
Never: the kubelet never pulls the reference and only uses a local image or artifact. Container creation will fail if the reference isn't present.
IfNotPresent: the kubelet pulls if the reference isn't already present on disk. Container creation will fail if the reference isn't present and the pull fails.
Defaults to Always if :latest tag is specified, or IfNotPresent otherwise.
"%,
          reference | optional | String | doc m%"
Required: Image or artifact reference to be used.
Behaves in the same way as pod.spec.containers[*].image.
Pull secrets will be assembled in the same way as for the container image by looking up node credentials, SA image pull secrets, and pod spec image pull secrets.
More info: https://kubernetes.io/docs/concepts/containers/images
This field is optional to allow higher level config management to default or override
container images in workload controllers like Deployments and StatefulSets.
"%,
        } | doc m%"
image represents an OCI object (a container image or artifact) pulled and mounted on the kubelet's host machine.
The volume is resolved at pod startup depending on which PullPolicy value is provided:

- Always: the kubelet always attempts to pull the reference. Container creation will fail If the pull fails.
- Never: the kubelet never pulls the reference and only uses a local image or artifact. Container creation will fail if the reference isn't present.
- IfNotPresent: the kubelet pulls if the reference isn't already present on disk. Container creation will fail if the reference isn't present and the pull fails.

The volume gets re-resolved if the pod gets deleted and recreated, which means that new remote content will become available on pod recreation.
A failure to resolve or pull the image during pod startup will block containers from starting and may add significant latency. Failures will be retried using normal volume backoff and will be reported on the pod reason and message.
The types of objects that may be mounted by this volume are defined by the container runtime implementation on a host machine and at minimum must include all valid types supported by the container image field.
The OCI object gets mounted in a single directory (spec.containers[*].volumeMounts.mountPath) by merging the manifest layers in the same way as for container images.
The volume will be mounted read-only (ro) and non-executable files (noexec).
Sub path mounts for containers are not supported (spec.containers[*].volumeMounts.subpath) before 1.33.
The field spec.securityContext.fsGroupChangePolicy has no effect on this volume type.
"%,
        iscsi | optional | {
          chapAuthDiscovery | optional | Bool | doc "chapAuthDiscovery defines whether support iSCSI Discovery CHAP authentication",
          chapAuthSession | optional | Bool | doc "chapAuthSession defines whether support iSCSI Session CHAP authentication",
          fsType | optional | String | doc m%"
fsType is the filesystem type of the volume that you want to mount.
Tip: Ensure that the filesystem type is supported by the host operating system.
Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi
"%,
          initiatorName | optional | String | doc m%"
initiatorName is the custom iSCSI Initiator Name.
If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface
<target portal>:<volume name> will be created for the connection.
"%,
          iqn | String | doc "iqn is the target iSCSI Qualified Name.",
          iscsiInterface | String | doc m%"
iscsiInterface is the interface Name that uses an iSCSI transport.
Defaults to 'default' (tcp).
"% | default = "default",
          lun | Number | doc "lun represents iSCSI Target Lun number.",
          portals | optional | Array String | doc m%"
portals is the iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port
is other than default (typically TCP ports 860 and 3260).
"%,
          readOnly | optional | Bool | doc m%"
readOnly here will force the ReadOnly setting in VolumeMounts.
Defaults to false.
"%,
          secretRef | optional | {
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          } | doc "secretRef is the CHAP Secret for iSCSI target and initiator authentication",
          targetPortal | String | doc m%"
targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port
is other than default (typically TCP ports 860 and 3260).
"%,
        } | doc m%"
iscsi represents an ISCSI Disk resource that is attached to a
kubelet's host machine and then exposed to the pod.
More info: https://examples.k8s.io/volumes/iscsi/README.md
"%,
        name | String | doc m%"
name of the volume.
Must be a DNS_LABEL and unique within the pod.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"%,
        nfs | optional | {
          path | String | doc m%"
path that is exported by the NFS server.
More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
"%,
          readOnly | optional | Bool | doc m%"
readOnly here will force the NFS export to be mounted with read-only permissions.
Defaults to false.
More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
"%,
          server | String | doc m%"
server is the hostname or IP address of the NFS server.
More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
"%,
        } | doc m%"
nfs represents an NFS mount on the host that shares a pod's lifetime
More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
"%,
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
persistentVolumeClaimVolumeSource represents a reference to a
PersistentVolumeClaim in the same namespace.
More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
"%,
        photonPersistentDisk | optional | {
          fsType | optional | String | doc m%"
fsType is the filesystem type to mount.
Must be a filesystem type supported by the host operating system.
Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
"%,
          pdID | String | doc "pdID is the ID that identifies Photon Controller persistent disk",
        } | doc m%"
photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine.
Deprecated: PhotonPersistentDisk is deprecated and the in-tree photonPersistentDisk type is no longer supported.
"%,
        portworxVolume | optional | {
          fsType | optional | String | doc m%"
fSType represents the filesystem type to mount
Must be a filesystem type supported by the host operating system.
Ex. "ext4", "xfs". Implicitly inferred to be "ext4" if unspecified.
"%,
          readOnly | optional | Bool | doc m%"
readOnly defaults to false (read/write). ReadOnly here will force
the ReadOnly setting in VolumeMounts.
"%,
          volumeID | String | doc "volumeID uniquely identifies a Portworx volume",
        } | doc m%"
portworxVolume represents a portworx volume attached and mounted on kubelets host machine.
Deprecated: PortworxVolume is deprecated. All operations for the in-tree portworxVolume type
are redirected to the pxd.portworx.com CSI driver when the CSIMigrationPortworx feature-gate
is on.
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
              optional | optional | Bool | doc m%"
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
              optional | optional | Bool | doc "optional specify whether the ConfigMap or its keys must be defined",
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
              optional | optional | Bool | doc "optional field specify whether the Secret or its key must be defined",
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
        } | doc "projected items for all in one resources secrets, configmaps, and downward API",
        quobyte | optional | {
          group | optional | String | doc m%"
group to map volume access to
Default is no group
"%,
          readOnly | optional | Bool | doc m%"
readOnly here will force the Quobyte volume to be mounted with read-only permissions.
Defaults to false.
"%,
          registry | String | doc m%"
registry represents a single or multiple Quobyte Registry services
specified as a string as host:port pair (multiple entries are separated with commas)
which acts as the central registry for volumes
"%,
          tenant | optional | String | doc m%"
tenant owning the given Quobyte volume in the Backend
Used with dynamically provisioned Quobyte volumes, value is set by the plugin
"%,
          user | optional | String | doc m%"
user to map volume access to
Defaults to serivceaccount user
"%,
          volume | String | doc "volume is a string that references an already created Quobyte volume by name.",
        } | doc m%"
quobyte represents a Quobyte mount on the host that shares a pod's lifetime.
Deprecated: Quobyte is deprecated and the in-tree quobyte type is no longer supported.
"%,
        rbd | optional | {
          fsType | optional | String | doc m%"
fsType is the filesystem type of the volume that you want to mount.
Tip: Ensure that the filesystem type is supported by the host operating system.
Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd
"%,
          image | String | doc m%"
image is the rados image name.
More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
"%,
          keyring | String | doc m%"
keyring is the path to key ring for RBDUser.
Default is /etc/ceph/keyring.
More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
"% | default = "/etc/ceph/keyring",
          monitors | Array String | doc m%"
monitors is a collection of Ceph monitors.
More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
"%,
          pool | String | doc m%"
pool is the rados pool name.
Default is rbd.
More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
"% | default = "rbd",
          readOnly | optional | Bool | doc m%"
readOnly here will force the ReadOnly setting in VolumeMounts.
Defaults to false.
More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
"%,
          secretRef | optional | {
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          } | doc m%"
secretRef is name of the authentication secret for RBDUser. If provided
overrides keyring.
Default is nil.
More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
"%,
          user | String | doc m%"
user is the rados user name.
Default is admin.
More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
"% | default = "admin",
        } | doc m%"
rbd represents a Rados Block Device mount on the host that shares a pod's lifetime.
Deprecated: RBD is deprecated and the in-tree rbd type is no longer supported.
More info: https://examples.k8s.io/volumes/rbd/README.md
"%,
        scaleIO | optional | {
          fsType | String | doc m%"
fsType is the filesystem type to mount.
Must be a filesystem type supported by the host operating system.
Ex. "ext4", "xfs", "ntfs".
Default is "xfs".
"% | default = "xfs",
          gateway | String | doc "gateway is the host address of the ScaleIO API Gateway.",
          protectionDomain | optional | String | doc m%"
protectionDomain is the name of the ScaleIO Protection Domain for the configured storage.
"%,
          readOnly | optional | Bool | doc m%"
readOnly Defaults to false (read/write). ReadOnly here will force
the ReadOnly setting in VolumeMounts.
"%,
          secretRef | {
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          } | doc m%"
secretRef references to the secret for ScaleIO user and other
sensitive information. If this is not provided, Login operation will fail.
"%,
          sslEnabled | optional | Bool | doc "sslEnabled Flag enable/disable SSL communication with Gateway, default false",
          storageMode | String | doc m%"
storageMode indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned.
Default is ThinProvisioned.
"% | default = "ThinProvisioned",
          storagePool | optional | String | doc "storagePool is the ScaleIO Storage Pool associated with the protection domain.",
          system | String | doc "system is the name of the storage system as configured in ScaleIO.",
          volumeName | optional | String | doc m%"
volumeName is the name of a volume already created in the ScaleIO system
that is associated with this volume source.
"%,
        } | doc m%"
scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes.
Deprecated: ScaleIO is deprecated and the in-tree scaleIO type is no longer supported.
"%,
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
          optional | optional | Bool | doc "optional field specify whether the Secret or its keys must be defined",
          secretName | optional | String | doc m%"
secretName is the name of the secret in the pod's namespace to use.
More info: https://kubernetes.io/docs/concepts/storage/volumes#secret
"%,
        } | doc m%"
secret represents a secret that should populate this volume.
More info: https://kubernetes.io/docs/concepts/storage/volumes#secret
"%,
        storageos | optional | {
          fsType | optional | String | doc m%"
fsType is the filesystem type to mount.
Must be a filesystem type supported by the host operating system.
Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
"%,
          readOnly | optional | Bool | doc m%"
readOnly defaults to false (read/write). ReadOnly here will force
the ReadOnly setting in VolumeMounts.
"%,
          secretRef | optional | {
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          } | doc m%"
secretRef specifies the secret to use for obtaining the StorageOS API
credentials.  If not specified, default values will be attempted.
"%,
          volumeName | optional | String | doc m%"
volumeName is the human-readable name of the StorageOS volume.  Volume
names are only unique within a namespace.
"%,
          volumeNamespace | optional | String | doc m%"
volumeNamespace specifies the scope of the volume within StorageOS.  If no
namespace is specified then the Pod's namespace will be used.  This allows the
Kubernetes name scoping to be mirrored within StorageOS for tighter integration.
Set VolumeName to any name to override the default behaviour.
Set to "default" if you are not using namespaces within StorageOS.
Namespaces that do not pre-exist within StorageOS will be created.
"%,
        } | doc m%"
storageOS represents a StorageOS volume attached and mounted on Kubernetes nodes.
Deprecated: StorageOS is deprecated and the in-tree storageos type is no longer supported.
"%,
        vsphereVolume | optional | {
          fsType | optional | String | doc m%"
fsType is filesystem type to mount.
Must be a filesystem type supported by the host operating system.
Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
"%,
          storagePolicyID | optional | String | doc m%"
storagePolicyID is the storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName.
"%,
          storagePolicyName | optional | String | doc "storagePolicyName is the storage Policy Based Management (SPBM) profile name.",
          volumePath | String | doc "volumePath is the path that identifies vSphere volume vmdk",
        } | doc m%"
vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine.
Deprecated: VsphereVolume is deprecated. All operations for the in-tree vsphereVolume type
are redirected to the csi.vsphere.vmware.com CSI driver.
"%,
      } | doc m%"
Volumes allows configuration of additional volumes on the output StatefulSet definition.
Volumes specified will be appended to other volumes that are generated as a result of
StorageSpec objects.
"%,
      web | optional | {
        getConcurrency | optional | Number | doc m%"
Maximum number of GET requests processed concurrently. This corresponds to the
Alertmanager's `--web.get-concurrency` flag.
"%,
        httpConfig | optional | {
          headers | optional | {
            contentSecurityPolicy | optional | String | doc m%"
Set the Content-Security-Policy header to HTTP responses.
Unset if blank.
"%,
            strictTransportSecurity | optional | String | doc m%"
Set the Strict-Transport-Security header to HTTP responses.
Unset if blank.
Please make sure that you use this with care as this header might force
browsers to load Prometheus and the other applications hosted on the same
domain and subdomains over HTTPS.
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security
"%,
            xContentTypeOptions | optional | String | doc m%"
Set the X-Content-Type-Options header to HTTP responses.
Unset if blank. Accepted value is nosniff.
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options
"%,
            xFrameOptions | optional | String | doc m%"
Set the X-Frame-Options header to HTTP responses.
Unset if blank. Accepted values are deny and sameorigin.
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options
"%,
            xXSSProtection | optional | String | doc m%"
Set the X-XSS-Protection header to all responses.
Unset if blank.
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection
"%,
          } | doc "List of headers that can be added to HTTP responses.",
          http2 | optional | Bool | doc m%"
Enable HTTP/2 support. Note that HTTP/2 is only supported with TLS.
When TLSConfig is not configured, HTTP/2 will be disabled.
Whenever the value of the field changes, a rolling update will be triggered.
"%,
        } | doc "Defines HTTP parameters for web server.",
        timeout | optional | Number | doc m%"
Timeout for HTTP requests. This corresponds to the Alertmanager's
`--web.timeout` flag.
"%,
        tlsConfig | optional | {
          cert | optional | {
            configMap | optional | {
              key | String | doc "The key to select.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
            } | doc "ConfigMap containing data to use for the targets.",
            secret | optional | {
              key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc "Secret containing data to use for the targets.",
          } | doc m%"
Secret or ConfigMap containing the TLS certificate for the web server.

Either `keySecret` or `keyFile` must be defined.

It is mutually exclusive with `certFile`.
"%,
          certFile | optional | String | doc m%"
Path to the TLS certificate file in the container for the web server.

Either `keySecret` or `keyFile` must be defined.

It is mutually exclusive with `cert`.
"%,
          cipherSuites | optional | Array String | doc m%"
List of supported cipher suites for TLS versions up to TLS 1.2.

If not defined, the Go default cipher suites are used.
Available cipher suites are documented in the Go documentation:
https://golang.org/pkg/crypto/tls/#pkg-constants
"%,
          clientAuthType | optional | String | doc m%"
The server policy for client TLS authentication.

For more detail on clientAuth options:
https://golang.org/pkg/crypto/tls/#ClientAuthType
"%,
          clientCAFile | optional | String | doc m%"
Path to the CA certificate file for client certificate authentication to
the server.

It is mutually exclusive with `client_ca`.
"%,
          client_ca | optional | {
            configMap | optional | {
              key | String | doc "The key to select.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
            } | doc "ConfigMap containing data to use for the targets.",
            secret | optional | {
              key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc "Secret containing data to use for the targets.",
          } | doc m%"
Secret or ConfigMap containing the CA certificate for client certificate
authentication to the server.

It is mutually exclusive with `clientCAFile`.
"%,
          curvePreferences | optional | Array String | doc m%"
Elliptic curves that will be used in an ECDHE handshake, in preference
order.

Available curves are documented in the Go documentation:
https://golang.org/pkg/crypto/tls/#CurveID
"%,
          keyFile | optional | String | doc m%"
Path to the TLS private key file in the container for the web server.

If defined, either `cert` or `certFile` must be defined.

It is mutually exclusive with `keySecret`.
"%,
          keySecret | optional | {
            key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
            optional | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Secret containing the TLS private key for the web server.

Either `cert` or `certFile` must be defined.

It is mutually exclusive with `keyFile`.
"%,
          maxVersion | optional | String | doc "Maximum TLS version that is acceptable.",
          minVersion | optional | String | doc "Minimum TLS version that is acceptable.",
          preferServerCipherSuites | optional | Bool | doc m%"
Controls whether the server selects the client's most preferred cipher
suite, or the server's most preferred cipher suite.

If true then the server's preference, as expressed in
the order of elements in cipherSuites, is used.
"%,
        } | doc "Defines the TLS parameters for HTTPS.",
      } | doc "Defines the web command line flags when starting Alertmanager.",
    } | doc m%"
Specification of the desired behavior of the Alertmanager cluster. More info:
https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
"%,
    status | optional | {
      availableReplicas | Number | doc m%"
Total number of available pods (ready for at least minReadySeconds)
targeted by this Alertmanager cluster.
"%,
      conditions | optional | Array {
        lastTransitionTime | String | doc m%"
lastTransitionTime is the time of the last update to the current status property.
"%,
        message | optional | String | doc "Human-readable message indicating details for the condition's last transition.",
        observedGeneration | optional | Number | doc m%"
ObservedGeneration represents the .metadata.generation that the
condition was set based upon. For instance, if `.metadata.generation` is
currently 12, but the `.status.conditions[].observedGeneration` is 9, the
condition is out of date with respect to the current state of the
instance.
"%,
        reason | optional | String | doc "Reason for the condition's last transition.",
        status | String | doc "Status of the condition.",
        type | String | doc "Type of the condition being reported.",
      } | doc "The current state of the Alertmanager object.",
      paused | Bool | doc m%"
Represents whether any actions on the underlying managed objects are
being performed. Only delete actions will be performed.
"%,
      replicas | Number | doc m%"
Total number of non-terminated pods targeted by this Alertmanager
object (their labels match the selector).
"%,
      selector | optional | String | doc "The selector used to match the pods targeted by this Alertmanager object.",
      unavailableReplicas | Number | doc "Total number of unavailable pods targeted by this Alertmanager object.",
      updatedReplicas | Number | doc m%"
Total number of non-terminated pods targeted by this Alertmanager
object that have the desired version spec.
"%,
    } | doc m%"
Most recent observed status of the Alertmanager cluster. Read-only.
More info:
https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
"%,
  },
}
