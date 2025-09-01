# Module: cloudeventsource.eventing.keda.sh

let k8s_io_objectmeta = import "k8s_io" in

{
  CloudEventSource = {
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
      authenticationRef | optional | {
        kind | optional | String | doc "Kind of the resource being referred to. Defaults to TriggerAuthentication.",
        name | String,
      } | doc m%"
AuthenticationRef points to the TriggerAuthentication or ClusterTriggerAuthentication object that
is used to authenticate the scaler with the environment
"%,
      clusterName | optional | String,
      destination | {
        azureEventGridTopic | optional | {
          endpoint | String,
        },
        http | optional | {
          uri | String,
        },
      } | doc "Destination defines the various ways to emit events",
      eventSubscription | optional | {
        excludedEventTypes | optional | Array String,
        includedEventTypes | optional | Array String,
      } | doc "EventSubscription defines filters for events",
    } | doc "CloudEventSourceSpec defines the spec of CloudEventSource",
    status | optional | {
      conditions | optional | Array {
        message | optional | String | doc "A human readable message indicating details about the transition.",
        reason | optional | String | doc "The reason for the condition's last transition.",
        status | String | doc "Status of the condition, one of True, False, Unknown.",
        type | String | doc "Type of condition",
      } | doc "Conditions an array representation to store multiple Conditions",
    } | doc "CloudEventSourceStatus defines the observed state of CloudEventSource",
  },
}
