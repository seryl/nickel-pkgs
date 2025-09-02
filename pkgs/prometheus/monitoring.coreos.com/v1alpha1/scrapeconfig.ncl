# Module: scrapeconfig.monitoring.coreos.com

let k8s_io_objectmeta = import "k8s_io" in

{
  ScrapeConfig = {
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
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
        } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
        type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
      } | doc "Authorization header to use on every scrape request.",
      azureSDConfigs | optional | Array {
        authenticationMethod | optional | String | doc m%"
# The authentication method, either `OAuth` or `ManagedIdentity` or `SDK`.
See https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview
SDK authentication method uses environment variables by default.
See https://learn.microsoft.com/en-us/azure/developer/go/azure-sdk-authentication
"%,
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
          type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
        } | doc m%"
Authorization header configuration to authenticate against the target HTTP endpoint.
Cannot be set at the same time as `oAuth2`, or `basicAuth`.
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
`username` specifies a key of a Secret containing the username for
authentication.
"%,
        } | doc m%"
BasicAuth information to authenticate against the target HTTP endpoint.
More info: https://prometheus.io/docs/operating/configuration/#endpoints
Cannot be set at the same time as `authorization`, or `oAuth2`.
"%,
        clientID | optional | String | doc "Optional client ID. Only required with the OAuth authentication method.",
        clientSecret | optional | {
          key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
          name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
        } | doc "Optional client secret. Only required with the OAuth authentication method.",
        enableHTTP2 | optional | Bool | doc "Whether to enable HTTP2.",
        environment | optional | String | doc "The Azure environment.",
        followRedirects | optional | Bool | doc "Configure whether HTTP requests follow HTTP 3xx redirects.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
Optional OAuth 2.0 configuration to authenticate against the target HTTP endpoint.
Cannot be set at the same time as `authorization`, or `basicAuth`.
"%,
        port | optional | Number | doc m%"
The port to scrape metrics from. If using the public IP address, this must
instead be specified in the relabeling rule.
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
        refreshInterval | optional | String | doc m%"
RefreshInterval configures the refresh interval at which Prometheus will re-read the instance list.
"%,
        resourceGroup | optional | String | doc m%"
Optional resource group name. Limits discovery to this resource group.
Requires  Prometheus v2.35.0 and above
"%,
        subscriptionID | String | doc "The subscription ID. Always required.",
        tenantID | optional | String | doc "Optional tenant ID. Only required with the OAuth authentication method.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration applying to the target HTTP endpoint.",
      } | doc "AzureSDConfigs defines a list of Azure service discovery configurations.",
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
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
        } | doc m%"
`username` specifies a key of a Secret containing the username for
authentication.
"%,
      } | doc "BasicAuth information to use on every scrape request.",
      consulSDConfigs | optional | Array {
        allowStale | optional | Bool | doc m%"
Allow stale Consul results (see https://www.consul.io/api/features/consistency.html). Will reduce load on Consul.
If unset, Prometheus uses its default value.
"%,
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
          type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
        } | doc m%"
Optional Authorization header configuration to authenticate against the Consul Server.
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
`username` specifies a key of a Secret containing the username for
authentication.
"%,
        } | doc m%"
Optional BasicAuth information to authenticate against the Consul Server.
More info: https://prometheus.io/docs/operating/configuration/#endpoints
Cannot be set at the same time as `authorization`, or `oauth2`.
"%,
        datacenter | optional | String | doc m%"
Consul Datacenter name, if not provided it will use the local Consul Agent Datacenter.
"%,
        enableHTTP2 | optional | Bool | doc m%"
Whether to enable HTTP2.
If unset, Prometheus uses its default value.
"%,
        filter | optional | String | doc m%"
Filter expression used to filter the catalog results.
See https://www.consul.io/api-docs/catalog#list-services
It requires Prometheus >= 3.0.0.
"%,
        followRedirects | optional | Bool | doc m%"
Configure whether HTTP requests follow HTTP 3xx redirects.
If unset, Prometheus uses its default value.
"%,
        namespace | optional | String | doc m%"
Namespaces are only supported in Consul Enterprise.

It requires Prometheus >= 2.28.0.
"%,
        noProxy | optional | String | doc m%"
`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
"%,
        nodeMeta | optional | {
        } | doc m%"
Node metadata key/value pairs to filter nodes for a given service.
Starting with Consul 1.14, it is recommended to use `filter` with the `NodeMeta` selector instead.
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
Optional OAuth2.0 configuration.
Cannot be set at the same time as `basicAuth`, or `authorization`.
"%,
        partition | optional | String | doc "Admin Partitions are only supported in Consul Enterprise.",
        pathPrefix | optional | String | doc m%"
Prefix for URIs for when consul is behind an API gateway (reverse proxy).

It requires Prometheus >= 2.45.0.
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
        refreshInterval | optional | String | doc m%"
The time after which the provided names are refreshed.
On large setup it might be a good idea to increase this value because the catalog will change all the time.
If unset, Prometheus uses its default value.
"%,
        scheme | optional | String | doc "HTTP Scheme default \"http\"",
        server | String | doc m%"
Consul server address. A valid string consisting of a hostname or IP followed by an optional port number.
"%,
        services | optional | Array String | doc m%"
A list of services for which targets are retrieved. If omitted, all services are scraped.
"%,
        tagSeparator | optional | String | doc m%"
The string by which Consul tags are joined into the tag label.
If unset, Prometheus uses its default value.
"%,
        tags | optional | Array String | doc m%"
An optional list of tags used to filter nodes for a given service. Services must contain all tags in the list.
Starting with Consul 1.14, it is recommended to use `filter` with the `ServiceTags` selector instead.
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration to connect to the Consul API.",
        tokenRef | optional | {
          key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
          name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
        } | doc m%"
Consul ACL TokenRef, if not provided it will use the ACL from the local Consul Agent.
"%,
      } | doc "ConsulSDConfigs defines a list of Consul service discovery configurations.",
      convertClassicHistogramsToNHCB | optional | Bool | doc m%"
Whether to convert all scraped classic histograms into a native histogram with custom buckets.
It requires Prometheus >= v3.0.0.
"%,
      digitalOceanSDConfigs | optional | Array {
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
          type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
        } | doc m%"
Authorization header configuration to authenticate against the DigitalOcean API.
Cannot be set at the same time as `oauth2`.
"%,
        enableHTTP2 | optional | Bool | doc "Whether to enable HTTP2.",
        followRedirects | optional | Bool | doc "Configure whether HTTP requests follow HTTP 3xx redirects.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
Optional OAuth 2.0 configuration.
Cannot be set at the same time as `authorization`.
"%,
        port | optional | Number | doc "The port to scrape metrics from.",
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
        refreshInterval | optional | String | doc "Refresh interval to re-read the instance list.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration applying to the target HTTP endpoint.",
      } | doc m%"
DigitalOceanSDConfigs defines a list of DigitalOcean service discovery configurations.
"%,
      dnsSDConfigs | optional | Array {
        names | Array String | doc "A list of DNS domain names to be queried.",
        port | optional | Number | doc m%"
The port number used if the query type is not SRV
Ignored for SRV records
"%,
        refreshInterval | optional | String | doc m%"
RefreshInterval configures the time after which the provided names are refreshed.
If not set, Prometheus uses its default value.
"%,
        type | optional | String | doc m%"
The type of DNS query to perform. One of SRV, A, AAAA, MX or NS.
If not set, Prometheus uses its default value.

When set to NS, it requires Prometheus >= v2.49.0.
When set to MX, it requires Prometheus >= v2.38.0
"%,
      } | doc "DNSSDConfigs defines a list of DNS service discovery configurations.",
      dockerSDConfigs | optional | Array {
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
          type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
        } | doc m%"
Authorization header configuration to authenticate against the Docker API.
Cannot be set at the same time as `oauth2`.
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
`username` specifies a key of a Secret containing the username for
authentication.
"%,
        } | doc "BasicAuth information to use on every scrape request.",
        enableHTTP2 | optional | Bool | doc "Whether to enable HTTP2.",
        filters | optional | Array {
          name | String | doc "Name of the Filter.",
          values | Array String | doc "Value to filter on.",
        } | doc m%"
Optional filters to limit the discovery process to a subset of the available resources.
"%,
        followRedirects | optional | Bool | doc "Configure whether HTTP requests follow HTTP 3xx redirects.",
        host | String | doc "Address of the docker daemon",
        hostNetworkingHost | optional | String | doc "The host to use if the container is in host networking mode.",
        matchFirstNetwork | optional | Bool | doc m%"
Configure whether to match the first network if the container has multiple networks defined.
If unset, Prometheus uses true by default.
It requires Prometheus >= v2.54.1.
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
Optional OAuth 2.0 configuration.
Cannot be set at the same time as `authorization`.
"%,
        port | optional | Number | doc "The port to scrape metrics from.",
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
        refreshInterval | optional | String | doc "Time after which the container is refreshed.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration applying to the target HTTP endpoint.",
      } | doc "DockerSDConfigs defines a list of Docker service discovery configurations.",
      dockerSwarmSDConfigs | optional | Array {
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
          type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
        } | doc m%"
Authorization header configuration to authenticate against the target HTTP endpoint.
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
`username` specifies a key of a Secret containing the username for
authentication.
"%,
        } | doc "Optional HTTP basic authentication information.",
        enableHTTP2 | optional | Bool | doc "Whether to enable HTTP2.",
        filters | optional | Array {
          name | String | doc "Name of the Filter.",
          values | Array String | doc "Value to filter on.",
        } | doc m%"
Optional filters to limit the discovery process to a subset of available
resources.
The available filters are listed in the upstream documentation:
Services: https://docs.docker.com/engine/api/v1.40/#operation/ServiceList
Tasks: https://docs.docker.com/engine/api/v1.40/#operation/TaskList
Nodes: https://docs.docker.com/engine/api/v1.40/#operation/NodeList
"%,
        followRedirects | optional | Bool | doc "Configure whether HTTP requests follow HTTP 3xx redirects.",
        host | String | doc "Address of the Docker daemon",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
Optional OAuth 2.0 configuration.
Cannot be set at the same time as `authorization`, or `basicAuth`.
"%,
        port | optional | Number | doc m%"
The port to scrape metrics from, when `role` is nodes, and for discovered
tasks and services that don't have published ports.
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
        refreshInterval | optional | String | doc "The time after which the service discovery data is refreshed.",
        role | String | doc "Role of the targets to retrieve. Must be `Services`, `Tasks`, or `Nodes`.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration to use on every scrape request",
      } | doc m%"
DockerswarmSDConfigs defines a list of Dockerswarm service discovery configurations.
"%,
      ec2SDConfigs | optional | Array {
        accessKey | optional | {
          key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
          name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
        } | doc "AccessKey is the AWS API key.",
        enableHTTP2 | optional | Bool | doc m%"
Whether to enable HTTP2.
It requires Prometheus >= v2.41.0
"%,
        filters | optional | Array {
          name | String | doc "Name of the Filter.",
          values | Array String | doc "Value to filter on.",
        } | doc m%"
Filters can be used optionally to filter the instance list by other criteria.
Available filter criteria can be found here:
https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html
Filter API documentation: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Filter.html
It requires Prometheus >= v2.3.0
"%,
        followRedirects | optional | Bool | doc m%"
Configure whether HTTP requests follow HTTP 3xx redirects.
It requires Prometheus >= v2.41.0
"%,
        noProxy | optional | String | doc m%"
`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
"%,
        port | optional | Number | doc m%"
The port to scrape metrics from. If using the public IP address, this must
instead be specified in the relabeling rule.
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
        refreshInterval | optional | String | doc m%"
RefreshInterval configures the refresh interval at which Prometheus will re-read the instance list.
"%,
        region | optional | String | doc "The AWS region.",
        roleARN | optional | String | doc "AWS Role ARN, an alternative to using AWS API keys.",
        secretKey | optional | {
          key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
          name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
        } | doc "SecretKey is the AWS API secret.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
TLS configuration to connect to the AWS EC2 API.
It requires Prometheus >= v2.41.0
"%,
      } | doc "EC2SDConfigs defines a list of EC2 service discovery configurations.",
      enableCompression | optional | Bool | doc m%"
When false, Prometheus will request uncompressed response from the scraped target.

It requires Prometheus >= v2.49.0.

If unset, Prometheus uses true by default.
"%,
      enableHTTP2 | optional | Bool | doc "Whether to enable HTTP2.",
      eurekaSDConfigs | optional | Array {
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
          type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
        } | doc "Authorization header to use on every scrape request.",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
`username` specifies a key of a Secret containing the username for
authentication.
"%,
        } | doc "BasicAuth information to use on every scrape request.",
        enableHTTP2 | optional | Bool | doc "Whether to enable HTTP2.",
        followRedirects | optional | Bool | doc "Configure whether HTTP requests follow HTTP 3xx redirects.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
Optional OAuth 2.0 configuration.
Cannot be set at the same time as `authorization` or `basic_auth`.
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
        refreshInterval | optional | String | doc "Refresh interval to re-read the instance list.",
        server | String | doc "The URL to connect to the Eureka server.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration applying to the target HTTP endpoint.",
      } | doc "EurekaSDConfigs defines a list of Eureka service discovery configurations.",
      fallbackScrapeProtocol | optional | String | doc m%"
The protocol to use if a scrape returns blank, unparseable, or otherwise invalid Content-Type.

It requires Prometheus >= v3.0.0.
"%,
      fileSDConfigs | optional | Array {
        files | Array String | doc m%"
List of files to be used for file discovery. Recommendation: use absolute paths. While relative paths work, the
prometheus-operator project makes no guarantees about the working directory where the configuration file is
stored.
Files must be mounted using Prometheus.ConfigMaps or Prometheus.Secrets.
"%,
        refreshInterval | optional | String | doc m%"
RefreshInterval configures the refresh interval at which Prometheus will reload the content of the files.
"%,
      } | doc "FileSDConfigs defines a list of file service discovery configurations.",
      gceSDConfigs | optional | Array {
        filter | optional | String | doc m%"
Filter can be used optionally to filter the instance list by other criteria
Syntax of this filter is described in the filter query parameter section:
https://cloud.google.com/compute/docs/reference/latest/instances/list
"%,
        port | optional | Number | doc m%"
The port to scrape metrics from. If using the public IP address, this must
instead be specified in the relabeling rule.
"%,
        project | String | doc "The Google Cloud Project ID",
        refreshInterval | optional | String | doc m%"
RefreshInterval configures the refresh interval at which Prometheus will re-read the instance list.
"%,
        tagSeparator | optional | String | doc "The tag separator is used to separate the tags on concatenation",
        zone | String | doc m%"
The zone of the scrape targets. If you need multiple zones use multiple GCESDConfigs.
"%,
      } | doc "GCESDConfigs defines a list of GCE service discovery configurations.",
      hetznerSDConfigs | optional | Array {
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
          type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
        } | doc m%"
Authorization header configuration, required when role is hcloud.
Role robot does not support bearer token authentication.
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
`username` specifies a key of a Secret containing the username for
authentication.
"%,
        } | doc m%"
BasicAuth information to use on every scrape request, required when role is robot.
Role hcloud does not support basic auth.
"%,
        enableHTTP2 | optional | Bool | doc "Whether to enable HTTP2.",
        followRedirects | optional | Bool | doc "Configure whether HTTP requests follow HTTP 3xx redirects.",
        labelSelector | optional | String | doc m%"
Label selector used to filter the servers when fetching them from the API.
It requires Prometheus >= v3.5.0.
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
Optional OAuth 2.0 configuration.
Cannot be used at the same time as `basic_auth` or `authorization`.
"%,
        port | optional | Number | doc "The port to scrape metrics from.",
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
        refreshInterval | optional | String | doc "The time after which the servers are refreshed.",
        role | String | doc "The Hetzner role of entities that should be discovered.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration to use on every scrape request.",
      } | doc "HetznerSDConfigs defines a list of Hetzner service discovery configurations.",
      honorLabels | optional | Bool | doc "HonorLabels chooses the metric's labels on collisions with target labels.",
      honorTimestamps | optional | Bool | doc m%"
HonorTimestamps controls whether Prometheus respects the timestamps present in scraped data.
"%,
      httpSDConfigs | optional | Array {
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
          type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
        } | doc m%"
Authorization header configuration to authenticate against the target HTTP endpoint.
Cannot be set at the same time as `oAuth2`, or `basicAuth`.
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
`username` specifies a key of a Secret containing the username for
authentication.
"%,
        } | doc m%"
BasicAuth information to authenticate against the target HTTP endpoint.
More info: https://prometheus.io/docs/operating/configuration/#endpoints
Cannot be set at the same time as `authorization`, or `oAuth2`.
"%,
        enableHTTP2 | optional | Bool | doc "Whether to enable HTTP2.",
        followRedirects | optional | Bool | doc "Configure whether HTTP requests follow HTTP 3xx redirects.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
Optional OAuth 2.0 configuration to authenticate against the target HTTP endpoint.
Cannot be set at the same time as `authorization`, or `basicAuth`.
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
        refreshInterval | optional | String | doc m%"
RefreshInterval configures the refresh interval at which Prometheus will re-query the
endpoint to update the target list.
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration applying to the target HTTP endpoint.",
        url | String | doc "URL from which the targets are fetched.",
      } | doc "HTTPSDConfigs defines a list of HTTP service discovery configurations.",
      ionosSDConfigs | optional | Array {
        authorization | {
          credentials | optional | {
            key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
          type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
        } | doc "Authorization` header configuration, required when using IONOS.",
        datacenterID | String | doc "The unique ID of the IONOS data center.",
        enableHTTP2 | optional | Bool | doc "Configure whether to enable HTTP2.",
        followRedirects | optional | Bool | doc "Configure whether the HTTP requests should follow HTTP 3xx redirects.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "Configure whether to enable OAuth2.",
        port | optional | Number | doc "Port to scrape the metrics from.",
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
        refreshInterval | optional | String | doc "Refresh interval to re-read the list of resources.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration to use when connecting to the IONOS API.",
      } | doc "IonosSDConfigs defines a list of IONOS service discovery configurations.",
      jobName | optional | String | doc m%"
The value of the `job` label assigned to the scraped metrics by default.

The `job_name` field in the rendered scrape configuration is always controlled by the
operator to prevent duplicate job names, which Prometheus does not allow. Instead the
`job` label is set by means of relabeling configs.
"%,
      keepDroppedTargets | optional | Number | doc m%"
Per-scrape limit on the number of targets dropped by relabeling
that will be kept in memory. 0 means no limit.

It requires Prometheus >= v2.47.0.
"%,
      kubernetesSDConfigs | optional | Array {
        apiServer | optional | String | doc m%"
The API server address consisting of a hostname or IP address followed
by an optional port number.
If left empty, Prometheus is assumed to run inside
of the cluster. It will discover API servers automatically and use the pod's
CA certificate and bearer token file at /var/run/secrets/kubernetes.io/serviceaccount/.
"%,
        attachMetadata | optional | {
          node | optional | Bool | doc m%"
Attaches node metadata to discovered targets.
When set to true, Prometheus must have the `get` permission on the
`Nodes` objects.
Only valid for Pod, Endpoint and Endpointslice roles.
"%,
        } | doc m%"
Optional metadata to attach to discovered targets.
It requires Prometheus >= v2.35.0 when using the `Pod` role and
Prometheus >= v2.37.0 for `Endpoints` and `Endpointslice` roles.
"%,
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
          type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
        } | doc m%"
Authorization header to use on every scrape request.
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
`username` specifies a key of a Secret containing the username for
authentication.
"%,
        } | doc m%"
BasicAuth information to use on every scrape request.
Cannot be set at the same time as `authorization`, or `oauth2`.
"%,
        enableHTTP2 | optional | Bool | doc "Whether to enable HTTP2.",
        followRedirects | optional | Bool | doc "Configure whether HTTP requests follow HTTP 3xx redirects.",
        namespaces | optional | {
          names | optional | Array String | doc m%"
List of namespaces where to watch for resources.
If empty and `ownNamespace` isn't true, Prometheus watches for resources in all namespaces.
"%,
          ownNamespace | optional | Bool | doc m%"
Includes the namespace in which the Prometheus pod runs to the list of watched namespaces.
"%,
        } | doc m%"
Optional namespace discovery. If omitted, Prometheus discovers targets across all namespaces.
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
Optional OAuth 2.0 configuration.
Cannot be set at the same time as `authorization`, or `basicAuth`.
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
        role | String | doc m%"
Role of the Kubernetes entities that should be discovered.
Role `Endpointslice` requires Prometheus >= v2.21.0
"%,
        selectors | optional | Array {
          field | optional | String | doc m%"
An optional field selector to limit the service discovery to resources which have fields with specific values.
e.g: `metadata.name=foobar`
"%,
          label | optional | String | doc m%"
An optional label selector to limit the service discovery to resources with specific labels and label values.
e.g: `node.kubernetes.io/instance-type=master`
"%,
          role | String | doc m%"
Role specifies the type of Kubernetes resource to limit the service discovery to.
Accepted values are: Node, Pod, Endpoints, EndpointSlice, Service, Ingress.
"%,
        } | doc m%"
Selector to select objects.
It requires Prometheus >= v2.17.0
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration to connect to the Kubernetes API.",
      } | doc m%"
KubernetesSDConfigs defines a list of Kubernetes service discovery configurations.
"%,
      kumaSDConfigs | optional | Array {
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
          type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
        } | doc "Authorization header to use on every scrape request.",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
`username` specifies a key of a Secret containing the username for
authentication.
"%,
        } | doc "BasicAuth information to use on every scrape request.",
        clientID | optional | String | doc m%"
Client id is used by Kuma Control Plane to compute Monitoring Assignment for specific Prometheus backend.
"%,
        enableHTTP2 | optional | Bool | doc "Whether to enable HTTP2.",
        fetchTimeout | optional | String | doc "The time after which the monitoring assignments are refreshed.",
        followRedirects | optional | Bool | doc "Configure whether HTTP requests follow HTTP 3xx redirects.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
Optional OAuth 2.0 configuration.
Cannot be set at the same time as `authorization`, or `basicAuth`.
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
        refreshInterval | optional | String | doc "The time to wait between polling update requests.",
        server | String | doc "Address of the Kuma Control Plane's MADS xDS server.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration to use on every scrape request",
      } | doc "KumaSDConfigs defines a list of Kuma service discovery configurations.",
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
      lightSailSDConfigs | optional | Array {
        accessKey | optional | {
          key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
          name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
        } | doc "AccessKey is the AWS API key.",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
          type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
        } | doc m%"
Optional `authorization` HTTP header configuration.
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
`username` specifies a key of a Secret containing the username for
authentication.
"%,
        } | doc m%"
Optional HTTP basic authentication information.
Cannot be set at the same time as `authorization`, or `oauth2`.
"%,
        enableHTTP2 | optional | Bool | doc "Configure whether to enable HTTP2.",
        endpoint | optional | String | doc "Custom endpoint to be used.",
        followRedirects | optional | Bool | doc "Configure whether the HTTP requests should follow HTTP 3xx redirects.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
Optional OAuth2.0 configuration.
Cannot be set at the same time as `basicAuth`, or `authorization`.
"%,
        port | optional | Number | doc m%"
Port to scrape the metrics from.
If using the public IP address, this must instead be specified in the relabeling rule.
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
        refreshInterval | optional | String | doc "Refresh interval to re-read the list of instances.",
        region | optional | String | doc "The AWS region.",
        roleARN | optional | String | doc "AWS Role ARN, an alternative to using AWS API keys.",
        secretKey | optional | {
          key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
          name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
        } | doc "SecretKey is the AWS API secret.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration to connect to the Puppet DB.",
      } | doc "LightsailSDConfigs defines a list of Lightsail service discovery configurations.",
      linodeSDConfigs | optional | Array {
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
          type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
        } | doc "Authorization header configuration.",
        enableHTTP2 | optional | Bool | doc "Whether to enable HTTP2.",
        followRedirects | optional | Bool | doc "Configure whether HTTP requests follow HTTP 3xx redirects.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
Optional OAuth 2.0 configuration.
Cannot be used at the same time as `authorization`.
"%,
        port | optional | Number | doc "Default port to scrape metrics from.",
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
        refreshInterval | optional | String | doc "Time after which the linode instances are refreshed.",
        region | optional | String | doc "Optional region to filter on.",
        tagSeparator | optional | String | doc "The string by which Linode Instance tags are joined into the tag label.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration applying to the target HTTP endpoint.",
      } | doc "LinodeSDConfigs defines a list of Linode service discovery configurations.",
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
      metricsPath | optional | String | doc m%"
MetricsPath HTTP path to scrape for metrics. If empty, Prometheus uses the default value (e.g. /metrics).
"%,
      nameEscapingScheme | optional | String | doc m%"
Metric name escaping mode to request through content negotiation.

It requires Prometheus >= v3.4.0.
"%,
      nameValidationScheme | optional | String | doc m%"
Specifies the validation scheme for metric and label names.

It requires Prometheus >= v3.0.0.
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
      noProxy | optional | String | doc m%"
`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
"%,
      nomadSDConfigs | optional | Array {
        allowStale | optional | Bool | doc m%"
The information to access the Nomad API. It is to be defined
as the Nomad documentation requires.
"%,
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
          type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
        } | doc "Authorization header to use on every scrape request.",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
`username` specifies a key of a Secret containing the username for
authentication.
"%,
        } | doc "BasicAuth information to use on every scrape request.",
        enableHTTP2 | optional | Bool | doc "Whether to enable HTTP2.",
        followRedirects | optional | Bool | doc "Configure whether HTTP requests follow HTTP 3xx redirects.",
        namespace | optional | String,
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
Optional OAuth 2.0 configuration.
Cannot be set at the same time as `authorization` or `basic_auth`.
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
        refreshInterval | optional | String | doc m%"
Duration is a valid time duration that can be parsed by Prometheus model.ParseDuration() function.
Supported units: y, w, d, h, m, s, ms
Examples: `30s`, `1m`, `1h20m15s`, `15d`
"%,
        region | optional | String,
        server | String,
        tagSeparator | optional | String,
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration applying to the target HTTP endpoint.",
      } | doc "NomadSDConfigs defines a list of Nomad service discovery configurations.",
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
            "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
      } | doc "OAuth2 configuration to use on every scrape request.",
      openstackSDConfigs | optional | Array {
        allTenants | optional | Bool | doc m%"
Whether the service discovery should list all instances for all projects.
It is only relevant for the 'instance' role and usually requires admin permissions.
"%,
        applicationCredentialId | optional | String | doc "ApplicationCredentialID",
        applicationCredentialName | optional | String | doc m%"
The ApplicationCredentialID or ApplicationCredentialName fields are
required if using an application credential to authenticate. Some providers
allow you to create an application credential to authenticate rather than a
password.
"%,
        applicationCredentialSecret | optional | {
          key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
          name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
        } | doc m%"
The applicationCredentialSecret field is required if using an application
credential to authenticate.
"%,
        availability | optional | String | doc "Availability of the endpoint to connect to.",
        domainID | optional | String | doc "DomainID",
        domainName | optional | String | doc m%"
At most one of domainId and domainName must be provided if using username
with Identity V3. Otherwise, either are optional.
"%,
        identityEndpoint | optional | String | doc m%"
IdentityEndpoint specifies the HTTP endpoint that is required to work with
the Identity API of the appropriate version.
"%,
        password | optional | {
          key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
          name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
        } | doc m%"
Password for the Identity V2 and V3 APIs. Consult with your provider's
control panel to discover your account's preferred method of authentication.
"%,
        port | optional | Number | doc m%"
The port to scrape metrics from. If using the public IP address, this must
instead be specified in the relabeling rule.
"%,
        projectID | optional | String | doc " ProjectID",
        projectName | optional | String | doc m%"
The ProjectId and ProjectName fields are optional for the Identity V2 API.
Some providers allow you to specify a ProjectName instead of the ProjectId.
Some require both. Your provider's authentication policies will determine
how these fields influence authentication.
"%,
        refreshInterval | optional | String | doc "Refresh interval to re-read the instance list.",
        region | String | doc "The OpenStack Region.",
        role | String | doc m%"
The OpenStack role of entities that should be discovered.

Note: The `LoadBalancer` role requires Prometheus >= v3.2.0.
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration applying to the target HTTP endpoint.",
        userid | optional | String | doc "UserID",
        username | optional | String | doc m%"
Username is required if using Identity V2 API. Consult with your provider's
control panel to discover your account's username.
In Identity V3, either userid or a combination of username
and domainId or domainName are needed
"%,
      } | doc "OpenStackSDConfigs defines a list of OpenStack service discovery configurations.",
      ovhcloudSDConfigs | optional | Array {
        applicationKey | String | doc "Access key to use. https://api.ovh.com.",
        applicationSecret | {
          key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
          name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
        } | doc "SecretKeySelector selects a key of a Secret.",
        consumerKey | {
          key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
          name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
        } | doc "SecretKeySelector selects a key of a Secret.",
        endpoint | optional | String | doc "Custom endpoint to be used.",
        refreshInterval | optional | String | doc "Refresh interval to re-read the resources list.",
        service | String | doc "Service of the targets to retrieve. Must be `VPS` or `DedicatedServer`.",
      } | doc "OVHCloudSDConfigs defines a list of OVHcloud service discovery configurations.",
      params | optional | {
      } | doc "Optional HTTP URL parameters",
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
      puppetDBSDConfigs | optional | Array {
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
Selects a key of a Secret in the namespace that contains the credentials for authentication.
"%,
          type | optional | String | doc m%"
Defines the authentication type. The value is case-insensitive.

"Basic" is not a supported value.

Default: "Bearer"
"%,
        } | doc m%"
Optional `authorization` HTTP header configuration.
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc m%"
`username` specifies a key of a Secret containing the username for
authentication.
"%,
        } | doc m%"
Optional HTTP basic authentication information.
Cannot be set at the same time as `authorization`, or `oauth2`.
"%,
        enableHTTP2 | optional | Bool | doc "Configure whether to enable HTTP2.",
        followRedirects | optional | Bool | doc "Configure whether the HTTP requests should follow HTTP 3xx redirects.",
        includeParameters | optional | Bool | doc m%"
Whether to include the parameters as meta labels.
Note: Enabling this exposes parameters in the Prometheus UI and API. Make sure
that you don't have secrets exposed as parameters if you enable this.
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
                "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
Optional OAuth2.0 configuration.
Cannot be set at the same time as `basicAuth`, or `authorization`.
"%,
        port | optional | Number | doc "Port to scrape the metrics from.",
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
        query | String | doc m%"
Puppet Query Language (PQL) query. Only resources are supported.
https://puppet.com/docs/puppetdb/latest/api/query/v4/pql.html
"%,
        refreshInterval | optional | String | doc "Refresh interval to re-read the list of resources.",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration to connect to the Puppet DB.",
        url | String | doc "The URL of the PuppetDB root query endpoint.",
      } | doc "PuppetDBSDConfigs defines a list of PuppetDB service discovery configurations.",
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
RelabelConfigs defines how to rewrite the target's labels before scraping.
Prometheus Operator automatically adds relabelings for a few standard Kubernetes fields.
The original scrape job's name is available via the `__tmp_prometheus_job_name` label.
More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
"%,
      sampleLimit | optional | Number | doc m%"
SampleLimit defines per-scrape limit on number of scraped samples that will be accepted.
"%,
      scalewaySDConfigs | optional | Array {
        accessKey | String | doc "Access key to use. https://console.scaleway.com/project/credentials",
        apiURL | optional | String | doc "API URL to use when doing the server listing requests.",
        enableHTTP2 | optional | Bool | doc "Whether to enable HTTP2.",
        followRedirects | optional | Bool | doc "Configure whether HTTP requests follow HTTP 3xx redirects.",
        nameFilter | optional | String | doc m%"
NameFilter specify a name filter (works as a LIKE) to apply on the server listing request.
"%,
        noProxy | optional | String | doc m%"
`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
"%,
        port | optional | Number | doc "The port to scrape metrics from.",
        projectID | String | doc "Project ID of the targets.",
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
        refreshInterval | optional | String | doc "Refresh interval to re-read the list of instances.",
        role | String | doc "Service of the targets to retrieve. Must be `Instance` or `Baremetal`.",
        secretKey | {
          key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
          name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
        } | doc "Secret key to use when listing targets.",
        tagsFilter | optional | Array String | doc m%"
TagsFilter specify a tag filter (a server needs to have all defined tags to be listed) to apply on the server listing request.
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
        } | doc "TLS configuration to use on every scrape request",
        zone | optional | String | doc "Zone is the availability zone of your targets (e.g. fr-par-1).",
      } | doc m%"
ScalewaySDConfigs defines a list of Scaleway instances and baremetal service discovery configurations.
"%,
      scheme | optional | String | doc m%"
Configures the protocol scheme used for requests.
If empty, Prometheus uses HTTP by default.
"%,
      scrapeClass | optional | String | doc "The scrape class to apply.",
      scrapeClassicHistograms | optional | Bool | doc m%"
Whether to scrape a classic histogram that is also exposed as a native histogram.
It requires Prometheus >= v2.45.0.

Notice: `scrapeClassicHistograms` corresponds to the `always_scrape_classic_histograms` field in the Prometheus configuration.
"%,
      scrapeInterval | optional | String | doc "ScrapeInterval is the interval between consecutive scrapes.",
      scrapeProtocols | optional | Array String | doc m%"
The protocols to negotiate during a scrape. It tells clients the
protocols supported by Prometheus in order of preference (from most to least preferred).

If unset, Prometheus uses its default value.

It requires Prometheus >= v2.49.0.
"%,
      scrapeTimeout | optional | String | doc m%"
ScrapeTimeout is the number of seconds to wait until a scrape request times out.
The value cannot be greater than the scrape interval otherwise the operator will reject the resource.
"%,
      staticConfigs | optional | Array {
        labels | optional | {
        } | doc "Labels assigned to all metrics scraped from the targets.",
        targets | Array String | doc "List of targets for this static configuration.",
      } | doc "StaticConfigs defines a list of static targets with a common label set.",
      targetLimit | optional | Number | doc m%"
TargetLimit defines a limit on the number of scraped targets that will be accepted.
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
            "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the ConfigMap or its key must be defined",
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
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
          "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
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
      } | doc "TLS configuration to use on every scrape request",
      trackTimestampsStaleness | optional | Bool | doc m%"
TrackTimestampsStaleness whether Prometheus tracks staleness of
the metrics that have an explicit timestamp present in scraped data.
Has no effect if `honorTimestamps` is false.
It requires Prometheus >= v2.48.0.
"%,
    } | doc m%"
ScrapeConfigSpec is a specification of the desired configuration for a scrape configuration.
"%,
  },
}
