# Module: probe.monitoring.coreos.com

let k8s_io_objectmeta = import "k8s_io" in

{
  Probe = {
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
      } | doc "Authorization section for this endpoint",
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
BasicAuth allow an endpoint to authenticate over basic authentication.
More info: https://prometheus.io/docs/operating/configuration/#endpoint
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
Secret to mount to read bearer token for scraping targets. The secret
needs to be in the same namespace as the probe and accessible by
the Prometheus Operator.
"%,
      convertClassicHistogramsToNHCB | optional | Bool | doc m%"
Whether to convert all scraped classic histograms into a native histogram with custom buckets.
It requires Prometheus >= v3.0.0.
"%,
      fallbackScrapeProtocol | optional | String | doc m%"
The protocol to use if a scrape returns blank, unparseable, or otherwise invalid Content-Type.

It requires Prometheus >= v3.0.0.
"%,
      interval | optional | String | doc m%"
Interval at which targets are probed using the configured prober.
If not specified Prometheus' global scrape interval is used.
"%,
      jobName | optional | String | doc "The job name assigned to scraped metrics by default.",
      keepDroppedTargets | optional | Number | doc m%"
Per-scrape limit on the number of targets dropped by relabeling
that will be kept in memory. 0 means no limit.

It requires Prometheus >= v2.47.0.
"%,
      labelLimit | optional | Number | doc m%"
Per-scrape limit on number of labels that will be accepted for a sample.
Only valid in Prometheus versions 2.27.0 and newer.
"%,
      labelNameLengthLimit | optional | Number | doc m%"
Per-scrape limit on length of labels name that will be accepted for a sample.
Only valid in Prometheus versions 2.27.0 and newer.
"%,
      labelValueLengthLimit | optional | Number | doc m%"
Per-scrape limit on length of labels value that will be accepted for a sample.
Only valid in Prometheus versions 2.27.0 and newer.
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
      } | doc "MetricRelabelConfigs to apply to samples before ingestion.",
      module | optional | String | doc m%"
The module to use for probing specifying how to probe the target.
Example module configuring in the blackbox exporter:
https://github.com/prometheus/blackbox_exporter/blob/master/example.yml
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
      } | doc "OAuth2 for the URL. Only valid in Prometheus versions 2.27.0 and newer.",
      params | optional | Array {
        name | String | doc "The parameter name",
        values | optional | Array String | doc "The parameter values",
      } | doc m%"
The list of HTTP query parameters for the scrape.
Please note that the `.spec.module` field takes precedence over the `module` parameter from this list when both are defined.
The module name must be added using Module under ProbeSpec.
"%,
      prober | optional | {
        noProxy | optional | String | doc m%"
`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
"%,
        path | String | doc m%"
Path to collect metrics from.
Defaults to `/probe`.
"% | default = "/probe",
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
        scheme | optional | String | doc m%"
HTTP scheme to use for scraping.
`http` and `https` are the expected values unless you rewrite the `__scheme__` label via relabeling.
If empty, Prometheus uses the default value `http`.
"%,
        url | String | doc "Mandatory URL of the prober.",
      } | doc m%"
Specification for the prober to use for probing targets.
The prober.URL parameter is required. Targets cannot be probed if left empty.
"%,
      sampleLimit | optional | Number | doc m%"
SampleLimit defines per-scrape limit on number of scraped samples that will be accepted.
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
      scrapeTimeout | optional | String | doc m%"
Timeout for scraping metrics from the Prometheus exporter.
If not specified, the Prometheus global scrape timeout is used.
The value cannot be greater than the scrape interval otherwise the operator will reject the resource.
"%,
      targetLimit | optional | Number | doc m%"
TargetLimit defines a limit on the number of scraped targets that will be accepted.
"%,
      targets | optional | {
        ingress | optional | {
          namespaceSelector | optional | {
            any | optional | Bool | doc m%"
Boolean describing whether all namespaces are selected in contrast to a
list restricting them.
"%,
            matchNames | optional | Array String | doc "List of namespace names to select from.",
          } | doc "From which namespaces to select Ingress objects.",
          relabelingConfigs | optional | Array {
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
RelabelConfigs to apply to the label set of the target before it gets
scraped.
The original ingress address is available via the
`__tmp_prometheus_ingress_address` label. It can be used to customize the
probed URL.
The original scrape job's name is available via the `__tmp_prometheus_job_name` label.
More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
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
          } | doc "Selector to select the Ingress objects.",
        } | doc m%"
ingress defines the Ingress objects to probe and the relabeling
configuration.
If `staticConfig` is also defined, `staticConfig` takes precedence.
"%,
        staticConfig | optional | {
          labels | optional | {
          } | doc "Labels assigned to all metrics scraped from the targets.",
          relabelingConfigs | optional | Array {
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
RelabelConfigs to apply to the label set of the targets before it gets
scraped.
More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
"%,
          static | optional | Array String | doc "The list of hosts to probe.",
        } | doc m%"
staticConfig defines the static list of targets to probe and the
relabeling configuration.
If `ingress` is also defined, `staticConfig` takes precedence.
More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#static_config.
"%,
      } | doc "Targets defines a set of static or dynamically discovered targets to probe.",
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
      } | doc "TLS configuration to use when scraping the endpoint.",
    } | doc "Specification of desired Ingress selection for target discovery by Prometheus.",
  },
}
