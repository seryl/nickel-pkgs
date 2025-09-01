# Module: scaledobject.keda.sh

let k8s_io_objectmeta = import "k8s_io" in

{
  ScaledObject = {
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
      advanced | optional | {
        horizontalPodAutoscalerConfig | optional | {
          behavior | optional | {
            scaleDown | optional | {
              policies | optional | Array {
                periodSeconds | Number | doc m%"
periodSeconds specifies the window of time for which the policy should hold true.
PeriodSeconds must be greater than zero and less than or equal to 1800 (30 min).
"%,
                type | String | doc "type is used to specify the scaling policy.",
                value | Number | doc m%"
value contains the amount of change which is permitted by the policy.
It must be greater than zero
"%,
              } | doc m%"
policies is a list of potential scaling polices which can be used during scaling.
At least one policy must be specified, otherwise the HPAScalingRules will be discarded as invalid
"%,
              selectPolicy | optional | String | doc m%"
selectPolicy is used to specify which policy should be used.
If not set, the default value Max is used.
"%,
              stabilizationWindowSeconds | optional | Number | doc m%"
stabilizationWindowSeconds is the number of seconds for which past recommendations should be
considered while scaling up or scaling down.
StabilizationWindowSeconds must be greater than or equal to zero and less than or equal to 3600 (one hour).
If not set, use the default values:
- For scale up: 0 (i.e. no stabilization is done).
- For scale down: 300 (i.e. the stabilization window is 300 seconds long).
"%,
            } | doc m%"
scaleDown is scaling policy for scaling Down.
If not set, the default value is to allow to scale down to minReplicas pods, with a
300 second stabilization window (i.e., the highest recommendation for
the last 300sec is used).
"%,
            scaleUp | optional | {
              policies | optional | Array {
                periodSeconds | Number | doc m%"
periodSeconds specifies the window of time for which the policy should hold true.
PeriodSeconds must be greater than zero and less than or equal to 1800 (30 min).
"%,
                type | String | doc "type is used to specify the scaling policy.",
                value | Number | doc m%"
value contains the amount of change which is permitted by the policy.
It must be greater than zero
"%,
              } | doc m%"
policies is a list of potential scaling polices which can be used during scaling.
At least one policy must be specified, otherwise the HPAScalingRules will be discarded as invalid
"%,
              selectPolicy | optional | String | doc m%"
selectPolicy is used to specify which policy should be used.
If not set, the default value Max is used.
"%,
              stabilizationWindowSeconds | optional | Number | doc m%"
stabilizationWindowSeconds is the number of seconds for which past recommendations should be
considered while scaling up or scaling down.
StabilizationWindowSeconds must be greater than or equal to zero and less than or equal to 3600 (one hour).
If not set, use the default values:
- For scale up: 0 (i.e. no stabilization is done).
- For scale down: 300 (i.e. the stabilization window is 300 seconds long).
"%,
            } | doc m%"
scaleUp is scaling policy for scaling Up.
If not set, the default value is the higher of:
  * increase no more than 4 pods per 60 seconds
  * double the number of pods per 60 seconds
No stabilization is used.
"%,
          } | doc m%"
HorizontalPodAutoscalerBehavior configures the scaling behavior of the target
in both Up and Down directions (scaleUp and scaleDown fields respectively).
"%,
          name | optional | String,
        } | doc "HorizontalPodAutoscalerConfig specifies horizontal scale config",
        restoreToOriginalReplicaCount | optional | Bool,
        scalingModifiers | optional | {
          activationTarget | optional | String,
          formula | optional | String,
          metricType | optional | String | doc m%"
MetricTargetType specifies the type of metric being targeted, and should be either
"Value", "AverageValue", or "Utilization"
"%,
          target | optional | String,
        } | doc "ScalingModifiers describes advanced scaling logic options like formula",
      } | doc "AdvancedConfig specifies advance scaling options",
      cooldownPeriod | optional | Number,
      fallback | optional | {
        behavior | String | default = "static",
        failureThreshold | Number,
        replicas | Number,
      } | doc "Fallback is the spec for fallback options",
      idleReplicaCount | optional | Number,
      initialCooldownPeriod | optional | Number,
      maxReplicaCount | optional | Number,
      minReplicaCount | optional | Number,
      pollingInterval | optional | Number,
      scaleTargetRef | {
        apiVersion | optional | String,
        envSourceContainerName | optional | String,
        kind | optional | String,
        name | String,
      } | doc "ScaleTarget holds the reference to the scale target Object",
      triggers | Array {
        authenticationRef | optional | {
          kind | optional | String | doc "Kind of the resource being referred to. Defaults to TriggerAuthentication.",
          name | String,
        } | doc m%"
AuthenticationRef points to the TriggerAuthentication or ClusterTriggerAuthentication object that
is used to authenticate the scaler with the environment
"%,
        metadata | k8s_io_objectmeta.ObjectMeta,
        metricType | optional | String | doc m%"
MetricTargetType specifies the type of metric being targeted, and should be either
"Value", "AverageValue", or "Utilization"
"%,
        name | optional | String,
        type | String,
        useCachedMetrics | optional | Bool,
      },
    } | doc "ScaledObjectSpec is the spec for a ScaledObject resource",
    status | optional | {
      authenticationsTypes | optional | String,
      compositeScalerName | optional | String,
      conditions | optional | Array {
        message | optional | String | doc "A human readable message indicating details about the transition.",
        reason | optional | String | doc "The reason for the condition's last transition.",
        status | String | doc "Status of the condition, one of True, False, Unknown.",
        type | String | doc "Type of condition",
      } | doc "Conditions an array representation to store multiple Conditions",
      externalMetricNames | optional | Array String,
      health | optional | {
      },
      hpaName | optional | String,
      lastActiveTime | optional | String,
      originalReplicaCount | optional | Number,
      pausedReplicaCount | optional | Number,
      resourceMetricNames | optional | Array String,
      scaleTargetGVKR | optional | {
        group | String,
        kind | String,
        resource | String,
        version | String,
      } | doc m%"
GroupVersionKindResource provides unified structure for schema.GroupVersionKind and Resource
"%,
      scaleTargetKind | optional | String,
      triggersTypes | optional | String,
    } | doc "ScaledObjectStatus is the status for a ScaledObject resource",
  },
}
