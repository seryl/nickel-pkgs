# Module: podmonitor.monitoring.coreos.com

let k8s_io_objectmeta = import "k8s_io" in

{
  PodMonitor = {
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
      attachMetadata | optional | {
        node | optional | Bool | doc m%"
When set to true, Prometheus attaches node metadata to the discovered
targets.

The Prometheus service account must have the `list` and `watch`
permissions on the `Nodes` objects.
"%,
      } | doc m%"
`attachMetadata` defines additional metadata which is added to the
discovered targets.

It requires Prometheus >= v2.35.0.
"%,
      bodySizeLimit | optional | String | doc m%"
When defined, bodySizeLimit specifies a job level limit on the size
of uncompressed response body that will be accepted by Prometheus.

It requires Prometheus >= v2.28.0.
"%,
      convertClassicHistogramsToNHCB | optional | Bool | doc m%"
Whether to convert all scraped classic histograms into a native histogram with custom buckets.
It requires Prometheus >= v3.0.0.
"%,
      fallbackScrapeProtocol | optional | String | doc m%"
The protocol to use if a scrape returns blank, unparseable, or otherwise invalid Content-Type.

It requires Prometheus >= v3.0.0.
"%,
      jobLabel | optional | String | doc m%"
The label to use to retrieve the job name from.
`jobLabel` selects the label from the associated Kubernetes `Pod`
object which will be used as the `job` label for all metrics.

For example if `jobLabel` is set to `foo` and the Kubernetes `Pod`
object is labeled with `foo: bar`, then Prometheus adds the `job="bar"`
label to all ingested metrics.

If the value of this field is empty, the `job` label of the metrics
defaults to the namespace and name of the PodMonitor object (e.g. `<namespace>/<name>`).
"%,
      keepDroppedTargets | optional | Number | doc m%"
Per-scrape limit on the number of targets dropped by relabeling
that will be kept in memory. 0 means no limit.

It requires Prometheus >= v2.47.0.
"%,
      labelLimit | optional | Number | doc m%"
Per-scrape limit on number of labels that will be accepted for a sample.

It requires Prometheus >= v2.27.0.
"%,
      labelNameLengthLimit | optional | Number | doc m%"
Per-scrape limit on length of labels name that will be accepted for a sample.

It requires Prometheus >= v2.27.0.
"%,
      labelValueLengthLimit | optional | Number | doc m%"
Per-scrape limit on length of labels value that will be accepted for a sample.

It requires Prometheus >= v2.27.0.
"%,
      namespaceSelector | optional | {
        any | optional | Bool | doc m%"
Boolean describing whether all namespaces are selected in contrast to a
list restricting them.
"%,
        matchNames | optional | Array String | doc "List of namespace names to select from.",
      } | doc m%"
`namespaceSelector` defines in which namespace(s) Prometheus should discover the pods.
By default, the pods are discovered in the same namespace as the `PodMonitor` object but it is possible to select pods across different/all namespaces.
"%,
      nativeHistogramBucketLimit | optional | Number | doc m%"
If there are more than this many buckets in a native histogram,
buckets will be merged to stay within the limit.
It requires Prometheus >= v2.45.0.
"%,
      nativeHistogramMinBucketFactor | optional | Number | String | doc m%"
If the growth factor of one bucket to the next is smaller than this,
buckets will be merged to increase the factor sufficiently.
It requires Prometheus >= v2.50.0.
"%,
      podMetricsEndpoints | optional | Array {
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
`authorization` configures the Authorization header credentials to use when
scraping the target.

Cannot be set at the same time as `basicAuth`, or `oauth2`.
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
`basicAuth` configures the Basic Authentication credentials to use when
scraping the target.

Cannot be set at the same time as `authorization`, or `oauth2`.
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
`bearerTokenSecret` specifies a key of a Secret containing the bearer
token for scraping targets. The secret needs to be in the same namespace
as the PodMonitor object and readable by the Prometheus Operator.

Deprecated: use `authorization` instead.
"%,
        enableHttp2 | optional | Bool | doc "`enableHttp2` can be used to disable HTTP2 when scraping the target.",
        filterRunning | optional | Bool | doc m%"
When true, the pods which are not running (e.g. either in Failed or
Succeeded state) are dropped during the target discovery.

If unset, the filtering is enabled.

More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase
"%,
        followRedirects | optional | Bool | doc m%"
`followRedirects` defines whether the scrape requests should follow HTTP
3xx redirects.
"%,
        honorLabels | optional | Bool | doc m%"
When true, `honorLabels` preserves the metric's labels when they collide
with the target's labels.
"%,
        honorTimestamps | optional | Bool | doc m%"
`honorTimestamps` controls whether Prometheus preserves the timestamps
when exposed by the target.
"%,
        interval | optional | String | doc m%"
Interval at which Prometheus scrapes the metrics from the target.

If empty, Prometheus uses the global scrape interval.
"%,
        metricRelabelings | optional | Array {
          action | String | doc m%"
Action to perform based on the regex matching.

`Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0.
`DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0.

Default: "Replace"
"% | default = "replace",
          modulus | optional | Number | doc m%"
Modulus to take of the hash of the source label values.

Only applicable when the action is `HashMod`.
"%,
          regex | optional | String | doc "Regular expression against which the extracted value is matched.",
          replacement | optional | String | doc m%"
Replacement value against which a Replace action is performed if the
regular expression matches.

Regex capture groups are available.
"%,
          separator | optional | String | doc "Separator is the string between concatenated SourceLabels.",
          sourceLabels | optional | Array String | doc m%"
The source labels select values from existing labels. Their content is
concatenated using the configured Separator and matched against the
configured regular expression.
"%,
          targetLabel | optional | String | doc m%"
Label to which the resulting string is written in a replacement.

It is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`,
`KeepEqual` and `DropEqual` actions.

Regex capture groups are available.
"%,
        } | doc m%"
`metricRelabelings` configures the relabeling rules to apply to the
samples before ingestion.
"%,
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
        } | doc m%"
`oauth2` configures the OAuth2 settings to use when scraping the target.

It requires Prometheus >= 2.27.0.

Cannot be set at the same time as `authorization`, or `basicAuth`.
"%,
        params | optional | {
        } | doc "`params` define optional HTTP URL parameters.",
        path | optional | String | doc m%"
HTTP path from which to scrape for metrics.

If empty, Prometheus uses the default value (e.g. `/metrics`).
"%,
        port | optional | String | doc m%"
The `Pod` port name which exposes the endpoint.

It takes precedence over the `portNumber` and `targetPort` fields.
"%,
        portNumber | optional | Number | doc "The `Pod` port number which exposes the endpoint.",
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
        relabelings | optional | Array {
          action | String | doc m%"
Action to perform based on the regex matching.

`Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0.
`DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0.

Default: "Replace"
"% | default = "replace",
          modulus | optional | Number | doc m%"
Modulus to take of the hash of the source label values.

Only applicable when the action is `HashMod`.
"%,
          regex | optional | String | doc "Regular expression against which the extracted value is matched.",
          replacement | optional | String | doc m%"
Replacement value against which a Replace action is performed if the
regular expression matches.

Regex capture groups are available.
"%,
          separator | optional | String | doc "Separator is the string between concatenated SourceLabels.",
          sourceLabels | optional | Array String | doc m%"
The source labels select values from existing labels. Their content is
concatenated using the configured Separator and matched against the
configured regular expression.
"%,
          targetLabel | optional | String | doc m%"
Label to which the resulting string is written in a replacement.

It is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`,
`KeepEqual` and `DropEqual` actions.

Regex capture groups are available.
"%,
        } | doc m%"
`relabelings` configures the relabeling rules to apply the target's
metadata labels.

The Operator automatically adds relabelings for a few standard Kubernetes fields.

The original scrape job's name is available via the `__tmp_prometheus_job_name` label.

More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
"%,
        scheme | optional | String | doc m%"
HTTP scheme to use for scraping.

`http` and `https` are the expected values unless you rewrite the
`__scheme__` label via relabeling.

If empty, Prometheus uses the default value `http`.
"%,
        scrapeTimeout | optional | String | doc m%"
Timeout after which Prometheus considers the scrape to be failed.

If empty, Prometheus uses the global scrape timeout unless it is less
than the target's scrape interval value in which the latter is used.
The value cannot be greater than the scrape interval otherwise the operator will reject the resource.
"%,
        targetPort | optional | Number | String | doc m%"
Name or number of the target port of the `Pod` object behind the Service, the
port must be specified with container port property.

Deprecated: use 'port' or 'portNumber' instead.
"%,
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
        } | doc "TLS configuration to use when scraping the target.",
        trackTimestampsStaleness | optional | Bool | doc m%"
`trackTimestampsStaleness` defines whether Prometheus tracks staleness of
the metrics that have an explicit timestamp present in scraped data.
Has no effect if `honorTimestamps` is false.

It requires Prometheus >= v2.48.0.
"%,
      } | doc "Defines how to scrape metrics from the selected pods.",
      podTargetLabels | optional | Array String | doc m%"
`podTargetLabels` defines the labels which are transferred from the
associated Kubernetes `Pod` object onto the ingested metrics.
"%,
      sampleLimit | optional | Number | doc m%"
`sampleLimit` defines a per-scrape limit on the number of scraped samples
that will be accepted.
"%,
      scrapeClass | optional | String | doc "The scrape class to apply.",
      scrapeClassicHistograms | optional | Bool | doc m%"
Whether to scrape a classic histogram that is also exposed as a native histogram.
It requires Prometheus >= v2.45.0.

Notice: `scrapeClassicHistograms` corresponds to the `always_scrape_classic_histograms` field in the Prometheus configuration.
"%,
      scrapeProtocols | optional | Array String | doc m%"
`scrapeProtocols` defines the protocols to negotiate during a scrape. It tells clients the
protocols supported by Prometheus in order of preference (from most to least preferred).

If unset, Prometheus uses its default value.

It requires Prometheus >= v2.49.0.
"%,
      selector | {
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
      } | doc "Label selector to select the Kubernetes `Pod` objects to scrape metrics from.",
      selectorMechanism | optional | String | doc m%"
Mechanism used to select the endpoints to scrape.
By default, the selection process relies on relabel configurations to filter the discovered targets.
Alternatively, you can opt in for role selectors, which may offer better efficiency in large clusters.
Which strategy is best for your use case needs to be carefully evaluated.

It requires Prometheus >= v2.17.0.
"%,
      targetLimit | optional | Number | doc m%"
`targetLimit` defines a limit on the number of scraped targets that will
be accepted.
"%,
    } | doc "Specification of desired Pod selection for target discovery by Prometheus.",
  },
}
