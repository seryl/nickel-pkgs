# Module: prometheusrule.monitoring.coreos.com

let k8s_io_objectmeta = import "k8s_io" in

{
  PrometheusRule = {
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
      groups | optional | Array {
        interval | optional | String | doc "Interval determines how often rules in the group are evaluated.",
        labels | optional | {
        } | doc m%"
Labels to add or overwrite before storing the result for its rules.
The labels defined at the rule level take precedence.

It requires Prometheus >= 3.0.0.
The field is ignored for Thanos Ruler.
"%,
        limit | optional | Number | doc m%"
Limit the number of alerts an alerting rule and series a recording
rule can produce.
Limit is supported starting with Prometheus >= 2.31 and Thanos Ruler >= 0.24.
"%,
        name | String | doc "Name of the rule group.",
        partial_response_strategy | optional | String | doc m%"
PartialResponseStrategy is only used by ThanosRuler and will
be ignored by Prometheus instances.
More info: https://github.com/thanos-io/thanos/blob/main/docs/components/rule.md#partial-response
"%,
        query_offset | optional | String | doc m%"
Defines the offset the rule evaluation timestamp of this particular group by the specified duration into the past.

It requires Prometheus >= v2.53.0.
It is not supported for ThanosRuler.
"%,
        rules | optional | Array {
          alert | optional | String | doc m%"
Name of the alert. Must be a valid label value.
Only one of `record` and `alert` must be set.
"%,
          annotations | optional | {
          } | doc m%"
Annotations to add to each alert.
Only valid for alerting rules.
"%,
          expr | Number | String | doc "PromQL expression to evaluate.",
          for | optional | String | doc "Alerts are considered firing once they have been returned for this long.",
          keep_firing_for | optional | String | doc m%"
KeepFiringFor defines how long an alert will continue firing after the condition that triggered it has cleared.
"%,
          labels | optional | {
          } | doc "Labels to add or overwrite.",
          record | optional | String | doc m%"
Name of the time series to output to. Must be a valid metric name.
Only one of `record` and `alert` must be set.
"%,
        } | doc "List of alerting and recording rules.",
      } | doc "Content of Prometheus rule file",
    } | doc "Specification of desired alerting rule definitions for Prometheus.",
  },
}
