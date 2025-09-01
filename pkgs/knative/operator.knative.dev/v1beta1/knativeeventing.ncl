# Module: knativeeventing.operator.knative.dev

let k8s_io_envvar = import "k8s_io" in
let k8s_io_objectmeta = import "k8s_io" in
let k8s_io_volumemount = import "k8s_io" in
let k8s_io_toleration = import "k8s_io" in

{
  KnativeEventing = {
    apiVersion | optional | String | doc m%"
APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
"%,
    kind | optional | String | doc m%"
Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
"%,
    metadata | optional | k8s_io_envvar.ObjectMeta,
    spec | optional | {
      additionalManifests | optional | Array {
        URL | optional | String | doc "The link of the additional manifest URL",
      } | doc m%"
A list of the additional eventing manifests, which will be installed by the operator
"%,
      config | optional | {
      } | doc "A means to override the corresponding entries in the upstream configmaps",
      defaultBrokerClass | optional | String | doc m%"
The default broker type to use for the brokers Knative creates. If no value is provided, MTChannelBasedBroker will be used.
"%,
      deployments | optional | Array {
        affinity | optional | {
          nodeAffinity | optional | {
            preferredDuringSchedulingIgnoredDuringExecution | optional | Array {
              preference | {
                matchExpressions | optional | Array {
                  key | String | doc "The label key that the selector applies to.",
                  operator | String | doc m%"
Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
"%,
                  values | optional | Array String | doc m%"
An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.
"%,
                } | doc "A list of node selector requirements by node's labels.",
                matchFields | optional | Array {
                  key | String | doc "The label key that the selector applies to.",
                  operator | String | doc m%"
Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
"%,
                  values | optional | Array String | doc m%"
An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.
"%,
                } | doc "A list of node selector requirements by node's fields.",
              } | doc "A node selector term, associated with the corresponding weight.",
              weight | Number | doc m%"
Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.
"%,
            } | doc m%"
The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.
"%,
            requiredDuringSchedulingIgnoredDuringExecution | optional | {
              nodeSelectorTerms | Array {
                matchExpressions | optional | Array {
                  key | String | doc "The label key that the selector applies to.",
                  operator | String | doc m%"
Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
"%,
                  values | optional | Array String | doc m%"
An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.
"%,
                } | doc "A list of node selector requirements by node's labels.",
                matchFields | optional | Array {
                  key | String | doc "The label key that the selector applies to.",
                  operator | String | doc m%"
Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
"%,
                  values | optional | Array String | doc m%"
An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.
"%,
                } | doc "A list of node selector requirements by node's fields.",
              } | doc "Required. A list of node selector terms. The terms are ORed.",
            } | doc m%"
If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.
"%,
          } | doc "Describes node affinity scheduling rules for the pod.",
          podAffinity | optional | {
            preferredDuringSchedulingIgnoredDuringExecution | optional | Array {
              podAffinityTerm | {
                labelSelector | optional | {
                  matchExpressions | optional | Array {
                    key | String | doc "key is the label key that the selector applies to.",
                    operator | String | doc m%"
operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.
"%,
                    values | optional | Array String | doc m%"
values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.
"%,
                  } | doc m%"
matchExpressions is a list of label selector requirements. The requirements are ANDed.
"%,
                  matchLabels | optional | {
                  } | doc m%"
matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
"%,
                } | doc "A label query over a set of resources, in this case pods.",
                namespaces | optional | Array String | doc m%"
namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means "this pod's namespace"
"%,
                topologyKey | String | doc m%"
This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.
"%,
              } | doc "Required. A pod affinity term, associated with the corresponding weight.",
              weight | Number | doc m%"
weight associated with matching the corresponding podAffinityTerm, in the range 1-100.
"%,
            } | doc m%"
The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
"%,
            requiredDuringSchedulingIgnoredDuringExecution | optional | Array {
              labelSelector | optional | {
                matchExpressions | optional | Array {
                  key | String | doc "key is the label key that the selector applies to.",
                  operator | String | doc m%"
operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.
"%,
                  values | optional | Array String | doc m%"
values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.
"%,
                } | doc m%"
matchExpressions is a list of label selector requirements. The requirements are ANDed.
"%,
                matchLabels | optional | {
                } | doc m%"
matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
"%,
              } | doc "A label query over a set of resources, in this case pods.",
              namespaces | optional | Array String | doc m%"
namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means "this pod's namespace"
"%,
              topologyKey | String | doc m%"
This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.
"%,
            } | doc m%"
If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
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
operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.
"%,
                    values | optional | Array String | doc m%"
values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.
"%,
                  } | doc m%"
matchExpressions is a list of label selector requirements. The requirements are ANDed.
"%,
                  matchLabels | optional | {
                  } | doc m%"
matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
"%,
                } | doc "A label query over a set of resources, in this case pods.",
                namespaces | optional | Array String | doc m%"
namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means "this pod's namespace"
"%,
                topologyKey | String | doc m%"
This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.
"%,
              } | doc "Required. A pod affinity term, associated with the corresponding weight.",
              weight | Number | doc m%"
weight associated with matching the corresponding podAffinityTerm, in the range 1-100.
"%,
            } | doc m%"
The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
"%,
            requiredDuringSchedulingIgnoredDuringExecution | optional | Array {
              labelSelector | optional | {
                matchExpressions | optional | Array {
                  key | String | doc "key is the label key that the selector applies to.",
                  operator | String | doc m%"
operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.
"%,
                  values | optional | Array String | doc m%"
values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.
"%,
                } | doc m%"
matchExpressions is a list of label selector requirements. The requirements are ANDed.
"%,
                matchLabels | optional | {
                } | doc m%"
matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
"%,
              } | doc "A label query over a set of resources, in this case pods.",
              namespaces | optional | Array String | doc m%"
namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means "this pod's namespace"
"%,
              topologyKey | String | doc m%"
This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.
"%,
            } | doc m%"
If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
"%,
          } | doc m%"
Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).
"%,
        } | doc "If specified, the pod's scheduling constraints.",
        annotations | optional | {
        } | doc "Annotations overrides labels for the deployment and its template.",
        env | optional | Array k8s_io_envvar.EnvVar | doc "Env overrides env vars for the containers.",
        hostNetwork | optional | Bool | doc m%"
Use the host's network namespace if true. Make sure to understand the security implications if you want to enable it. When hostNetwork is enabled, this will set dnsPolicy to ClusterFirstWithHostNet automatically.
"%,
        labels | optional | {
        } | doc "Labels overrides labels for the deployment and its template.",
        livenessProbes | optional | Array {
          container | String | doc "The container name",
          failureThreshold | optional | Number | doc m%"
Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1.
"%,
          initialDelaySeconds | optional | Number | doc m%"
Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
          periodSeconds | optional | Number | doc m%"
How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.
"%,
          successThreshold | optional | Number | doc m%"
Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
"%,
          terminationGracePeriodSeconds | optional | Number | doc m%"
Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
"%,
          timeoutSeconds | optional | Number | doc m%"
Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        } | doc "LivenessProbes overrides liveness probes for the containers.",
        name | optional | String | doc "The name of the deployment",
        nodeSelector | optional | {
        } | doc "NodeSelector overrides nodeSelector for the deployment.",
        readinessProbes | optional | Array {
          container | String | doc "The container name",
          failureThreshold | optional | Number | doc m%"
Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1.
"%,
          initialDelaySeconds | optional | Number | doc m%"
Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
          periodSeconds | optional | Number | doc m%"
How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.
"%,
          successThreshold | optional | Number | doc m%"
Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
"%,
          terminationGracePeriodSeconds | optional | Number | doc m%"
Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
"%,
          timeoutSeconds | optional | Number | doc m%"
Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        } | doc "ReadinessProbes overrides readiness probes for the containers.",
        replicas | optional | Number | doc "The number of replicas that HA parts of the control plane will be scaled to",
        resources | optional | Array {
          container | optional | String | doc "The name of the container",
          limits | optional | {
            cpu | optional | String,
            memory | optional | String,
          },
          requests | optional | {
            cpu | optional | String,
            memory | optional | String,
          },
        } | doc "If specified, the container's resources.",
        tolerations | optional | Array k8s_io_envvar.Toleration | doc "If specified, the pod's tolerations.",
        topologySpreadConstraints | optional | Array {
          labelSelector | optional | {
            matchExpressions | optional | Array {
              key | String | doc "key is the label key that the selector applies to.",
              operator | String | doc m%"
operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.
"%,
              values | optional | Array String | doc m%"
values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.
"%,
            } | doc m%"
matchExpressions is a list of label selector requirements. The requirements are ANDed.
"%,
            matchLabels | optional | {
            } | doc m%"
matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
"%,
          } | doc m%"
LabelSelector is used to find matching pods. Pods that match this label selector are counted to determine the number of pods in their corresponding topology domain.
"%,
          maxSkew | Number | doc m%"
MaxSkew describes the degree to which pods may be unevenly distributed. It's the maximum permitted difference between the number of matching pods in any two topology domains of a given topology type. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 1/1/0: | zone1 | zone2 | zone3 | |   P   |   P   |       | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 1/1/1; scheduling it onto zone1(zone2) would make the ActualSkew(2-0) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. It's a required field. Default value is 1 and 0 is not allowed.
"%,
          topologyKey | String | doc m%"
TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a "bucket", and try to put balanced number of pods into each bucket. It's a required field.
"%,
          whenUnsatisfiable | String | doc m%"
WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it - ScheduleAnyway tells the scheduler to still schedule it It's considered as "Unsatisfiable" if and only if placing incoming pod on any topology violates "MaxSkew". For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field.
"%,
        } | doc "If specified, the pod's topology spread constraints.",
      } | doc "A mapping of deployment name to override",
      high-availability | optional | {
        replicas | optional | Number | doc "The number of replicas that HA parts of the control plane will be scaled to",
      } | doc "Allows specification of HA control plane",
      manifests | optional | Array {
        URL | optional | String | doc "The link of the manifest URL",
      } | doc "A list of eventing manifests, which will be installed by the operator",
      namespace | optional | {
        annotations | optional | {
        } | doc "Annotations overrides labels for the namespace and its template.",
        labels | optional | {
        } | doc "Labels overrides labels for the namespace and its template.",
      } | doc "A field of namespace name to override the labels and annotations",
      podDisruptionBudgets | optional | Array {
        maxUnavailable | optional | Number | String | doc m%"
An eviction is allowed if at most "maxUnavailable" pods selected by "selector" are unavailable after the eviction, i.e. even in absence of the evicted pod. For example, one can prevent all voluntary evictions by specifying 0. This is a mutually exclusive setting with "minAvailable".
"%,
        minAvailable | optional | Number | String | doc m%"
An eviction is allowed if at least "minAvailable" pods selected by "selector" will still be available after the eviction, i.e. even in the absence of the evicted pod.  So for example you can prevent all voluntary evictions by specifying "100%".
"%,
        name | optional | String | doc "The name of the podDisruptionBudget",
      } | doc "A mapping of podDisruptionBudget name to override",
      registry | optional | {
        default | optional | String | doc m%"
The default image reference template to use for all knative images. Takes the form of example-registry.io/custom/path/${NAME}:custom-tag
"%,
        imagePullSecrets | optional | Array {
          name | optional | String | doc "The name of the secret.",
        } | doc m%"
A list of secrets to be used when pulling the knative images. The secret must be created in the same namespace as the knative-eventing deployments, and not the namespace of this resource.
"%,
        override | optional | {
        } | doc m%"
A map of a container name or image name to the full image location of the individual knative image.
"%,
      } | doc m%"
A means to override the corresponding deployment images in the upstream. This affects both apps/v1.Deployment and caching.internal.knative.dev/v1alpha1.Image.
"%,
      services | optional | Array {
        annotations | optional | {
        } | doc "Annotations overrides labels for the service",
        labels | optional | {
        } | doc "Labels overrides labels for the service",
        name | optional | String | doc "The name of the service",
        selector | optional | {
        } | doc "Selector overrides selector for the service",
      } | doc "A mapping of service name to override",
      sinkBindingSelectionMode | optional | String | doc m%"
Specifies the selection mode for the sinkbinding webhook. If the value is `inclusion`, only namespaces/objects labelled as `bindings.knative.dev/include:true` will be considered. If `exclusion` is selected, only `bindings.knative.dev/exclude:true` label is checked and these will NOT be considered. The default is `exclusion`.
"%,
      source | optional | {
        ceph | optional | {
          enabled | optional | Bool,
        } | doc "Ceph settings",
        github | optional | {
          enabled | optional | Bool,
        } | doc "GitHub settings",
        gitlab | optional | {
          enabled | optional | Bool,
        } | doc "GitLab settings",
        kafka | optional | {
          enabled | optional | Bool,
        } | doc "Apache Kafka settings",
        rabbitmq | optional | {
          enabled | optional | Bool,
        } | doc "RabbitMQ settings",
        redis | optional | {
          enabled | optional | Bool,
        } | doc "Redis settings",
      } | doc "The source configuration for Knative Eventing",
      version | optional | String | doc "The version of Knative Eventing to be installed",
      workloads | optional | Array {
        affinity | optional | {
          nodeAffinity | optional | {
            preferredDuringSchedulingIgnoredDuringExecution | optional | Array {
              preference | {
                matchExpressions | optional | Array {
                  key | String | doc "The label key that the selector applies to.",
                  operator | String | doc m%"
Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
"%,
                  values | optional | Array String | doc m%"
An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.
"%,
                } | doc "A list of node selector requirements by node's labels.",
                matchFields | optional | Array {
                  key | String | doc "The label key that the selector applies to.",
                  operator | String | doc m%"
Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
"%,
                  values | optional | Array String | doc m%"
An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.
"%,
                } | doc "A list of node selector requirements by node's fields.",
              } | doc "A node selector term, associated with the corresponding weight.",
              weight | Number | doc m%"
Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.
"%,
            } | doc m%"
The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.
"%,
            requiredDuringSchedulingIgnoredDuringExecution | optional | {
              nodeSelectorTerms | Array {
                matchExpressions | optional | Array {
                  key | String | doc "The label key that the selector applies to.",
                  operator | String | doc m%"
Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
"%,
                  values | optional | Array String | doc m%"
An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.
"%,
                } | doc "A list of node selector requirements by node's labels.",
                matchFields | optional | Array {
                  key | String | doc "The label key that the selector applies to.",
                  operator | String | doc m%"
Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
"%,
                  values | optional | Array String | doc m%"
An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.
"%,
                } | doc "A list of node selector requirements by node's fields.",
              } | doc "Required. A list of node selector terms. The terms are ORed.",
            } | doc m%"
If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.
"%,
          } | doc "Describes node affinity scheduling rules for the pod.",
          podAffinity | optional | {
            preferredDuringSchedulingIgnoredDuringExecution | optional | Array {
              podAffinityTerm | {
                labelSelector | optional | {
                  matchExpressions | optional | Array {
                    key | String | doc "key is the label key that the selector applies to.",
                    operator | String | doc m%"
operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.
"%,
                    values | optional | Array String | doc m%"
values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.
"%,
                  } | doc m%"
matchExpressions is a list of label selector requirements. The requirements are ANDed.
"%,
                  matchLabels | optional | {
                  } | doc m%"
matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
"%,
                } | doc "A label query over a set of resources, in this case pods.",
                namespaces | optional | Array String | doc m%"
namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means "this pod's namespace"
"%,
                topologyKey | String | doc m%"
This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.
"%,
              } | doc "Required. A pod affinity term, associated with the corresponding weight.",
              weight | Number | doc m%"
weight associated with matching the corresponding podAffinityTerm, in the range 1-100.
"%,
            } | doc m%"
The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
"%,
            requiredDuringSchedulingIgnoredDuringExecution | optional | Array {
              labelSelector | optional | {
                matchExpressions | optional | Array {
                  key | String | doc "key is the label key that the selector applies to.",
                  operator | String | doc m%"
operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.
"%,
                  values | optional | Array String | doc m%"
values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.
"%,
                } | doc m%"
matchExpressions is a list of label selector requirements. The requirements are ANDed.
"%,
                matchLabels | optional | {
                } | doc m%"
matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
"%,
              } | doc "A label query over a set of resources, in this case pods.",
              namespaces | optional | Array String | doc m%"
namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means "this pod's namespace"
"%,
              topologyKey | String | doc m%"
This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.
"%,
            } | doc m%"
If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
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
operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.
"%,
                    values | optional | Array String | doc m%"
values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.
"%,
                  } | doc m%"
matchExpressions is a list of label selector requirements. The requirements are ANDed.
"%,
                  matchLabels | optional | {
                  } | doc m%"
matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
"%,
                } | doc "A label query over a set of resources, in this case pods.",
                namespaces | optional | Array String | doc m%"
namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means "this pod's namespace"
"%,
                topologyKey | String | doc m%"
This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.
"%,
              } | doc "Required. A pod affinity term, associated with the corresponding weight.",
              weight | Number | doc m%"
weight associated with matching the corresponding podAffinityTerm, in the range 1-100.
"%,
            } | doc m%"
The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
"%,
            requiredDuringSchedulingIgnoredDuringExecution | optional | Array {
              labelSelector | optional | {
                matchExpressions | optional | Array {
                  key | String | doc "key is the label key that the selector applies to.",
                  operator | String | doc m%"
operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.
"%,
                  values | optional | Array String | doc m%"
values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.
"%,
                } | doc m%"
matchExpressions is a list of label selector requirements. The requirements are ANDed.
"%,
                matchLabels | optional | {
                } | doc m%"
matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
"%,
              } | doc "A label query over a set of resources, in this case pods.",
              namespaces | optional | Array String | doc m%"
namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means "this pod's namespace"
"%,
              topologyKey | String | doc m%"
This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.
"%,
            } | doc m%"
If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
"%,
          } | doc m%"
Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).
"%,
        } | doc "If specified, the pod's scheduling constraints.",
        annotations | optional | {
        } | doc "Annotations overrides labels for the deployment and its template.",
        env | optional | Array k8s_io_envvar.EnvVar | doc "Env overrides env vars for the containers.",
        hostNetwork | optional | Bool | doc m%"
Use the host's network namespace if true. Make sure to understand the security implications if you want to enable it. When hostNetwork is enabled, this will set dnsPolicy to ClusterFirstWithHostNet automatically.
"%,
        labels | optional | {
        } | doc "Labels overrides labels for the deployment and its template.",
        livenessProbes | optional | Array {
          container | String | doc "The container name",
          failureThreshold | optional | Number | doc m%"
Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1.
"%,
          initialDelaySeconds | optional | Number | doc m%"
Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
          periodSeconds | optional | Number | doc m%"
How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.
"%,
          successThreshold | optional | Number | doc m%"
Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
"%,
          terminationGracePeriodSeconds | optional | Number | doc m%"
Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
"%,
          timeoutSeconds | optional | Number | doc m%"
Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        } | doc "LivenessProbes overrides liveness probes for the containers.",
        name | optional | String | doc "The name of the deployment",
        nodeSelector | optional | {
        } | doc "NodeSelector overrides nodeSelector for the deployment.",
        readinessProbes | optional | Array {
          container | String | doc "The container name",
          failureThreshold | optional | Number | doc m%"
Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1.
"%,
          initialDelaySeconds | optional | Number | doc m%"
Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
          periodSeconds | optional | Number | doc m%"
How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.
"%,
          successThreshold | optional | Number | doc m%"
Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
"%,
          terminationGracePeriodSeconds | optional | Number | doc m%"
Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
"%,
          timeoutSeconds | optional | Number | doc m%"
Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        } | doc "ReadinessProbes overrides readiness probes for the containers.",
        replicas | optional | Number | doc "The number of replicas that HA parts of the control plane will be scaled to",
        resources | optional | Array {
          container | optional | String | doc "The name of the container",
          limits | optional | {
            cpu | optional | String,
            memory | optional | String,
          },
          requests | optional | {
            cpu | optional | String,
            memory | optional | String,
          },
        } | doc "If specified, the container's resources.",
        tolerations | optional | Array k8s_io_envvar.Toleration | doc "If specified, the pod's tolerations.",
        topologySpreadConstraints | optional | Array {
          labelSelector | optional | {
            matchExpressions | optional | Array {
              key | String | doc "key is the label key that the selector applies to.",
              operator | String | doc m%"
operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.
"%,
              values | optional | Array String | doc m%"
values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.
"%,
            } | doc m%"
matchExpressions is a list of label selector requirements. The requirements are ANDed.
"%,
            matchLabels | optional | {
            } | doc m%"
matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
"%,
          } | doc m%"
LabelSelector is used to find matching pods. Pods that match this label selector are counted to determine the number of pods in their corresponding topology domain.
"%,
          maxSkew | Number | doc m%"
MaxSkew describes the degree to which pods may be unevenly distributed. It's the maximum permitted difference between the number of matching pods in any two topology domains of a given topology type. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 1/1/0: | zone1 | zone2 | zone3 | |   P   |   P   |       | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 1/1/1; scheduling it onto zone1(zone2) would make the ActualSkew(2-0) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. It's a required field. Default value is 1 and 0 is not allowed.
"%,
          topologyKey | String | doc m%"
TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a "bucket", and try to put balanced number of pods into each bucket. It's a required field.
"%,
          whenUnsatisfiable | String | doc m%"
WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it - ScheduleAnyway tells the scheduler to still schedule it It's considered as "Unsatisfiable" if and only if placing incoming pod on any topology violates "MaxSkew". For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field.
"%,
        } | doc "If specified, the pod's topology spread constraints.",
        version | optional | String | doc "Version the cluster should be on.",
        volumeMounts | optional | Array k8s_io_envvar.VolumeMount | doc m%"
VolumeMounts allows configuration of additional VolumeMounts on the output StatefulSet definition. VolumeMounts specified will be appended to other VolumeMounts in the alertmanager container, that are generated as a result of StorageSpec objects.
"%,
      } | doc "A mapping of deployment or statefulset name to override",
    } | doc "Spec defines the desired state of KnativeEventing",
    status | optional | {
      conditions | optional | Array {
        lastTransitionTime | optional | String | doc m%"
LastTransitionTime is the last time the condition transitioned from one status to another. We use VolatileTime in place of metav1.Time to exclude this from creating equality.Semantic differences (all other things held constant).
"%,
        message | optional | String | doc "A human readable message indicating details about the transition.",
        reason | optional | String | doc "The reason for the condition's last transition.",
        severity | optional | String | doc m%"
Severity with which to treat failures of this type of condition. When this is not specified, it defaults to Error.
"%,
        status | String | doc "Status of the condition, one of True, False, Unknown.",
        type | String | doc "Type of condition.",
      } | doc "The latest available observations of a resource's current state.",
      manifests | optional | Array String | doc "The list of eventing manifests, which have been installed by the operator",
      observedGeneration | optional | Number | doc "The generation last processed by the controller",
      version | optional | String | doc "The version of the installed release",
    },
  },
}
