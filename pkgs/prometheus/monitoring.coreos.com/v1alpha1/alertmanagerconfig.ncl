# Module: alertmanagerconfig.monitoring.coreos.com

let k8s_io_objectmeta = import "k8s_io" in

{
  AlertmanagerConfig = {
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
      inhibitRules | optional | Array {
        equal | optional | Array String | doc m%"
Labels that must have an equal value in the source and target alert for
the inhibition to take effect.
"%,
        sourceMatch | optional | Array {
          matchType | optional | String | doc m%"
Match operation available with AlertManager >= v0.22.0 and
takes precedence over Regex (deprecated) if non-empty.
"%,
          name | String | doc "Label to match.",
          regex | optional | Bool | doc m%"
Whether to match on equality (false) or regular-expression (true).
Deprecated: for AlertManager >= v0.22.0, `matchType` should be used instead.
"%,
          value | optional | String | doc "Label value to match.",
        } | doc m%"
Matchers for which one or more alerts have to exist for the inhibition
to take effect. The operator enforces that the alert matches the
resource's namespace.
"%,
        targetMatch | optional | Array {
          matchType | optional | String | doc m%"
Match operation available with AlertManager >= v0.22.0 and
takes precedence over Regex (deprecated) if non-empty.
"%,
          name | String | doc "Label to match.",
          regex | optional | Bool | doc m%"
Whether to match on equality (false) or regular-expression (true).
Deprecated: for AlertManager >= v0.22.0, `matchType` should be used instead.
"%,
          value | optional | String | doc "Label value to match.",
        } | doc m%"
Matchers that have to be fulfilled in the alerts to be muted. The
operator enforces that the alert matches the resource's namespace.
"%,
      } | doc m%"
List of inhibition rules. The rules will only apply to alerts matching
the resource's namespace.
"%,
      muteTimeIntervals | optional | Array {
        name | String | doc "Name of the time interval",
        timeIntervals | optional | Array {
          daysOfMonth | optional | Array {
            end | optional | Number | doc "End of the inclusive range",
            start | optional | Number | doc "Start of the inclusive range",
          } | doc "DaysOfMonth is a list of DayOfMonthRange",
          months | optional | Array String | doc "Months is a list of MonthRange",
          times | optional | Array {
            endTime | optional | String | doc "EndTime is the end time in 24hr format.",
            startTime | optional | String | doc "StartTime is the start time in 24hr format.",
          } | doc "Times is a list of TimeRange",
          weekdays | optional | Array String | doc "Weekdays is a list of WeekdayRange",
          years | optional | Array String | doc "Years is a list of YearRange",
        } | doc "TimeIntervals is a list of TimeInterval",
      } | doc "List of MuteTimeInterval specifying when the routes should be muted.",
      receivers | optional | Array {
        discordConfigs | optional | Array {
          apiURL | {
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
The secret's key that contains the Discord webhook URL.
The secret needs to be in the same namespace as the AlertmanagerConfig
object and accessible by the Prometheus Operator.
"%,
          avatarURL | optional | String | doc "The avatar url of the message sender.",
          content | optional | String | doc "The template of the content's body.",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The secret's key that contains the bearer token to be used by the client
for authentication.
The secret needs to be in the same namespace as the AlertmanagerConfig
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
            proxyURL | optional | String | doc m%"
Optional proxy URL.

If defined, this field takes precedence over `proxyUrl`.
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
            } | doc "TLS configuration for the client.",
          } | doc "HTTP client configuration.",
          message | optional | String | doc "The template of the message's body.",
          sendResolved | optional | Bool | doc "Whether or not to notify about resolved alerts.",
          title | optional | String | doc "The template of the message's title.",
          username | optional | String | doc "The username of the message sender.",
        } | doc "List of Discord configurations.",
        emailConfigs | optional | Array {
          authIdentity | optional | String | doc "The identity to use for authentication.",
          authPassword | optional | {
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
The secret's key that contains the password to use for authentication.
The secret needs to be in the same namespace as the AlertmanagerConfig
object and accessible by the Prometheus Operator.
"%,
          authSecret | optional | {
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
The secret's key that contains the CRAM-MD5 secret.
The secret needs to be in the same namespace as the AlertmanagerConfig
object and accessible by the Prometheus Operator.
"%,
          authUsername | optional | String | doc "The username to use for authentication.",
          from | optional | String | doc "The sender address.",
          headers | optional | Array {
            key | String | doc "Key of the tuple.",
            value | String | doc "Value of the tuple.",
          } | doc m%"
Further headers email header key/value pairs. Overrides any headers
previously set by the notification implementation.
"%,
          hello | optional | String | doc "The hostname to identify to the SMTP server.",
          html | optional | String | doc "The HTML body of the email notification.",
          requireTLS | optional | Bool | doc m%"
The SMTP TLS requirement.
Note that Go does not support unencrypted connections to remote SMTP endpoints.
"%,
          sendResolved | optional | Bool | doc "Whether or not to notify about resolved alerts.",
          smarthost | optional | String | doc "The SMTP host and port through which emails are sent. E.g. example.com:25",
          text | optional | String | doc "The text body of the email notification.",
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
          } | doc "TLS configuration",
          to | optional | String | doc "The email address to send notifications to.",
        } | doc "List of Email configurations.",
        msteamsConfigs | optional | Array {
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The secret's key that contains the bearer token to be used by the client
for authentication.
The secret needs to be in the same namespace as the AlertmanagerConfig
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
            proxyURL | optional | String | doc m%"
Optional proxy URL.

If defined, this field takes precedence over `proxyUrl`.
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
            } | doc "TLS configuration for the client.",
          } | doc "HTTP client configuration.",
          sendResolved | optional | Bool | doc "Whether to notify about resolved alerts.",
          summary | optional | String | doc m%"
Message summary template.
It requires Alertmanager >= 0.27.0.
"%,
          text | optional | String | doc "Message body template.",
          title | optional | String | doc "Message title template.",
          webhookUrl | {
            key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc "MSTeams webhook URL.",
        } | doc m%"
List of MSTeams configurations.
It requires Alertmanager >= 0.26.0.
"%,
        msteamsv2Configs | optional | Array {
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The secret's key that contains the bearer token to be used by the client
for authentication.
The secret needs to be in the same namespace as the AlertmanagerConfig
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
            proxyURL | optional | String | doc m%"
Optional proxy URL.

If defined, this field takes precedence over `proxyUrl`.
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
            } | doc "TLS configuration for the client.",
          } | doc "HTTP client configuration.",
          sendResolved | optional | Bool | doc "Whether to notify about resolved alerts.",
          text | optional | String | doc "Message body template.",
          title | optional | String | doc "Message title template.",
          webhookURL | optional | {
            key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc "MSTeams incoming webhook URL.",
        } | doc m%"
List of MSTeamsV2 configurations.
It requires Alertmanager >= 0.28.0.
"%,
        name | String | doc "Name of the receiver. Must be unique across all items from the list.",
        opsgenieConfigs | optional | Array {
          actions | optional | String | doc "Comma separated list of actions that will be available for the alert.",
          apiKey | optional | {
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
The secret's key that contains the OpsGenie API key.
The secret needs to be in the same namespace as the AlertmanagerConfig
object and accessible by the Prometheus Operator.
"%,
          apiURL | optional | String | doc "The URL to send OpsGenie API requests to.",
          description | optional | String | doc "Description of the incident.",
          details | optional | Array {
            key | String | doc "Key of the tuple.",
            value | String | doc "Value of the tuple.",
          } | doc m%"
A set of arbitrary key/value pairs that provide further detail about the incident.
"%,
          entity | optional | String | doc "Optional field that can be used to specify which domain alert is related to.",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The secret's key that contains the bearer token to be used by the client
for authentication.
The secret needs to be in the same namespace as the AlertmanagerConfig
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
            proxyURL | optional | String | doc m%"
Optional proxy URL.

If defined, this field takes precedence over `proxyUrl`.
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
            } | doc "TLS configuration for the client.",
          } | doc "HTTP client configuration.",
          message | optional | String | doc "Alert text limited to 130 characters.",
          note | optional | String | doc "Additional alert note.",
          "priority" | optional | String | doc "Priority level of alert. Possible values are P1, P2, P3, P4, and P5.",
          responders | optional | Array {
            id | optional | String | doc "ID of the responder.",
            name | optional | String | doc "Name of the responder.",
            type | String | doc "Type of responder.",
            username | optional | String | doc "Username of the responder.",
          } | doc "List of responders responsible for notifications.",
          sendResolved | optional | Bool | doc "Whether or not to notify about resolved alerts.",
          source | optional | String | doc "Backlink to the sender of the notification.",
          tags | optional | String | doc "Comma separated list of tags attached to the notifications.",
          updateAlerts | optional | Bool | doc m%"
Whether to update message and description of the alert in OpsGenie if it already exists
By default, the alert is never updated in OpsGenie, the new message only appears in activity log.
"%,
        } | doc "List of OpsGenie configurations.",
        pagerdutyConfigs | optional | Array {
          class | optional | String | doc "The class/type of the event.",
          client | optional | String | doc "Client identification.",
          clientURL | optional | String | doc "Backlink to the sender of notification.",
          component | optional | String | doc "The part or component of the affected system that is broken.",
          description | optional | String | doc "Description of the incident.",
          details | optional | Array {
            key | String | doc "Key of the tuple.",
            value | String | doc "Value of the tuple.",
          } | doc "Arbitrary key/value pairs that provide further detail about the incident.",
          group | optional | String | doc "A cluster or grouping of sources.",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The secret's key that contains the bearer token to be used by the client
for authentication.
The secret needs to be in the same namespace as the AlertmanagerConfig
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
            proxyURL | optional | String | doc m%"
Optional proxy URL.

If defined, this field takes precedence over `proxyUrl`.
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
            } | doc "TLS configuration for the client.",
          } | doc "HTTP client configuration.",
          pagerDutyImageConfigs | optional | Array {
            alt | optional | String | doc "Alt is the optional alternative text for the image.",
            href | optional | String | doc "Optional URL; makes the image a clickable link.",
            src | optional | String | doc "Src of the image being attached to the incident",
          } | doc "A list of image details to attach that provide further detail about an incident.",
          pagerDutyLinkConfigs | optional | Array {
            alt | optional | String | doc "Text that describes the purpose of the link, and can be used as the link's text.",
            href | optional | String | doc "Href is the URL of the link to be attached",
          } | doc "A list of link details to attach that provide further detail about an incident.",
          routingKey | optional | {
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
The secret's key that contains the PagerDuty integration key (when using
Events API v2). Either this field or `serviceKey` needs to be defined.
The secret needs to be in the same namespace as the AlertmanagerConfig
object and accessible by the Prometheus Operator.
"%,
          sendResolved | optional | Bool | doc "Whether or not to notify about resolved alerts.",
          serviceKey | optional | {
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
The secret's key that contains the PagerDuty service key (when using
integration type "Prometheus"). Either this field or `routingKey` needs to
be defined.
The secret needs to be in the same namespace as the AlertmanagerConfig
object and accessible by the Prometheus Operator.
"%,
          severity | optional | String | doc "Severity of the incident.",
          source | optional | String | doc "Unique location of the affected system.",
          url | optional | String | doc "The URL to send requests to.",
        } | doc "List of PagerDuty configurations.",
        pushoverConfigs | optional | Array {
          device | optional | String | doc "The name of a device to send the notification to",
          expire | optional | String | doc m%"
How long your notification will continue to be retried for, unless the user
acknowledges the notification.
"%,
          html | optional | Bool | doc "Whether notification message is HTML or plain text.",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The secret's key that contains the bearer token to be used by the client
for authentication.
The secret needs to be in the same namespace as the AlertmanagerConfig
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
            proxyURL | optional | String | doc m%"
Optional proxy URL.

If defined, this field takes precedence over `proxyUrl`.
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
            } | doc "TLS configuration for the client.",
          } | doc "HTTP client configuration.",
          message | optional | String | doc "Notification message.",
          "priority" | optional | String | doc "Priority, see https://pushover.net/api#priority",
          retry | optional | String | doc m%"
How often the Pushover servers will send the same notification to the user.
Must be at least 30 seconds.
"%,
          sendResolved | optional | Bool | doc "Whether or not to notify about resolved alerts.",
          sound | optional | String | doc m%"
The name of one of the sounds supported by device clients to override the user's default sound choice
"%,
          title | optional | String | doc "Notification title.",
          token | optional | {
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
The secret's key that contains the registered application's API token, see https://pushover.net/apps.
The secret needs to be in the same namespace as the AlertmanagerConfig
object and accessible by the Prometheus Operator.
Either `token` or `tokenFile` is required.
"%,
          tokenFile | optional | String | doc m%"
The token file that contains the registered application's API token, see https://pushover.net/apps.
Either `token` or `tokenFile` is required.
It requires Alertmanager >= v0.26.0.
"%,
          ttl | optional | String | doc "The time to live definition for the alert notification",
          url | optional | String | doc "A supplementary URL shown alongside the message.",
          urlTitle | optional | String | doc "A title for supplementary URL, otherwise just the URL is shown",
          userKey | optional | {
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
The secret's key that contains the recipient user's user key.
The secret needs to be in the same namespace as the AlertmanagerConfig
object and accessible by the Prometheus Operator.
Either `userKey` or `userKeyFile` is required.
"%,
          userKeyFile | optional | String | doc m%"
The user key file that contains the recipient user's user key.
Either `userKey` or `userKeyFile` is required.
It requires Alertmanager >= v0.26.0.
"%,
        } | doc "List of Pushover configurations.",
        rocketchatConfigs | optional | Array {
          actions | optional | Array {
            msg | optional | String | doc "The message to send when the button is clicked.",
            text | optional | String | doc "The button text.",
            url | optional | String | doc "The URL the button links to.",
          } | doc "Actions to include in the message.",
          apiURL | optional | String | doc m%"
The API URL for RocketChat.
Defaults to https://open.rocket.chat/ if not specified.
"%,
          channel | optional | String | doc "The channel to send alerts to.",
          color | optional | String | doc "The message color.",
          emoji | optional | String | doc "If provided, the avatar will be displayed as an emoji.",
          fields | optional | Array {
            short | optional | Bool | doc "Whether this field should be a short field.",
            title | optional | String | doc "The title of this field.",
            value | optional | String | doc "The value of this field, displayed underneath the title value.",
          } | doc "Additional fields for the message.",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The secret's key that contains the bearer token to be used by the client
for authentication.
The secret needs to be in the same namespace as the AlertmanagerConfig
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
            proxyURL | optional | String | doc m%"
Optional proxy URL.

If defined, this field takes precedence over `proxyUrl`.
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
            } | doc "TLS configuration for the client.",
          } | doc "HTTP client configuration.",
          iconURL | optional | String | doc "Icon URL for the message.",
          imageURL | optional | String | doc "Image URL for the message.",
          linkNames | optional | Bool | doc "Whether to enable link names.",
          sendResolved | optional | Bool | doc "Whether to notify about resolved alerts.",
          shortFields | optional | Bool | doc "Whether to use short fields.",
          text | optional | String | doc "The message text to send, it is optional because of attachments.",
          thumbURL | optional | String | doc "Thumbnail URL for the message.",
          title | optional | String | doc "The message title.",
          titleLink | optional | String | doc "The title link for the message.",
          token | {
            key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc "The sender token.",
          tokenID | {
            key | String | doc "The key of the secret to select from.  Must be a valid secret key.",
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
            "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
          } | doc "The sender token ID.",
        } | doc m%"
List of RocketChat configurations.
It requires Alertmanager >= 0.28.0.
"%,
        slackConfigs | optional | Array {
          actions | optional | Array {
            confirm | optional | {
              dismissText | optional | String,
              okText | optional | String,
              text | String,
              title | optional | String,
            } | doc m%"
SlackConfirmationField protect users from destructive actions or
particularly distinguished decisions by asking them to confirm their button
click one more time.
See https://api.slack.com/docs/interactive-message-field-guide#confirmation_fields
for more information.
"%,
            name | optional | String,
            style | optional | String,
            text | String,
            type | String,
            url | optional | String,
            value | optional | String,
          } | doc "A list of Slack actions that are sent with each notification.",
          apiURL | optional | {
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
The secret's key that contains the Slack webhook URL.
The secret needs to be in the same namespace as the AlertmanagerConfig
object and accessible by the Prometheus Operator.
"%,
          callbackId | optional | String,
          channel | optional | String | doc "The channel or user to send notifications to.",
          color | optional | String,
          fallback | optional | String,
          fields | optional | Array {
            short | optional | Bool,
            title | String,
            value | String,
          } | doc "A list of Slack fields that are sent with each notification.",
          footer | optional | String,
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The secret's key that contains the bearer token to be used by the client
for authentication.
The secret needs to be in the same namespace as the AlertmanagerConfig
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
            proxyURL | optional | String | doc m%"
Optional proxy URL.

If defined, this field takes precedence over `proxyUrl`.
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
            } | doc "TLS configuration for the client.",
          } | doc "HTTP client configuration.",
          iconEmoji | optional | String,
          iconURL | optional | String,
          imageURL | optional | String,
          linkNames | optional | Bool,
          mrkdwnIn | optional | Array String,
          pretext | optional | String,
          sendResolved | optional | Bool | doc "Whether or not to notify about resolved alerts.",
          shortFields | optional | Bool,
          text | optional | String,
          thumbURL | optional | String,
          title | optional | String,
          titleLink | optional | String,
          username | optional | String,
        } | doc "List of Slack configurations.",
        snsConfigs | optional | Array {
          apiURL | optional | String | doc m%"
The SNS API URL i.e. https://sns.us-east-2.amazonaws.com.
If not specified, the SNS API URL from the SNS SDK will be used.
"%,
          attributes | optional | {
          } | doc "SNS message attributes.",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The secret's key that contains the bearer token to be used by the client
for authentication.
The secret needs to be in the same namespace as the AlertmanagerConfig
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
            proxyURL | optional | String | doc m%"
Optional proxy URL.

If defined, this field takes precedence over `proxyUrl`.
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
            } | doc "TLS configuration for the client.",
          } | doc "HTTP client configuration.",
          message | optional | String | doc "The message content of the SNS notification.",
          phoneNumber | optional | String | doc m%"
Phone number if message is delivered via SMS in E.164 format.
If you don't specify this value, you must specify a value for the TopicARN or TargetARN.
"%,
          sendResolved | optional | Bool | doc "Whether or not to notify about resolved alerts.",
          sigv4 | optional | {
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
            } | doc m%"
AccessKey is the AWS API key. If not specified, the environment variable
`AWS_ACCESS_KEY_ID` is used.
"%,
            profile | optional | String | doc "Profile is the named AWS profile used to authenticate.",
            region | optional | String | doc m%"
Region is the AWS region. If blank, the region from the default credentials chain used.
"%,
            roleArn | optional | String | doc "RoleArn is the named AWS profile used to authenticate.",
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
            } | doc m%"
SecretKey is the AWS API secret. If not specified, the environment
variable `AWS_SECRET_ACCESS_KEY` is used.
"%,
          } | doc "Configures AWS's Signature Verification 4 signing process to sign requests.",
          subject | optional | String | doc "Subject line when the message is delivered to email endpoints.",
          targetARN | optional | String | doc m%"
The  mobile platform endpoint ARN if message is delivered via mobile notifications.
If you don't specify this value, you must specify a value for the topic_arn or PhoneNumber.
"%,
          topicARN | optional | String | doc m%"
SNS topic ARN, i.e. arn:aws:sns:us-east-2:698519295917:My-Topic
If you don't specify this value, you must specify a value for the PhoneNumber or TargetARN.
"%,
        } | doc "List of SNS configurations",
        telegramConfigs | optional | Array {
          apiURL | optional | String | doc m%"
The Telegram API URL i.e. https://api.telegram.org.
If not specified, default API URL will be used.
"%,
          botToken | optional | {
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
Telegram bot token. It is mutually exclusive with `botTokenFile`.
The secret needs to be in the same namespace as the AlertmanagerConfig
object and accessible by the Prometheus Operator.

Either `botToken` or `botTokenFile` is required.
"%,
          botTokenFile | optional | String | doc m%"
File to read the Telegram bot token from. It is mutually exclusive with `botToken`.
Either `botToken` or `botTokenFile` is required.

It requires Alertmanager >= v0.26.0.
"%,
          chatID | Number | doc "The Telegram chat ID.",
          disableNotifications | optional | Bool | doc "Disable telegram notifications",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The secret's key that contains the bearer token to be used by the client
for authentication.
The secret needs to be in the same namespace as the AlertmanagerConfig
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
            proxyURL | optional | String | doc m%"
Optional proxy URL.

If defined, this field takes precedence over `proxyUrl`.
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
            } | doc "TLS configuration for the client.",
          } | doc "HTTP client configuration.",
          message | optional | String | doc "Message template",
          messageThreadID | optional | Number | doc m%"
The Telegram Group Topic ID.
It requires Alertmanager >= 0.26.0.
"%,
          parseMode | optional | String | doc "Parse mode for telegram message",
          sendResolved | optional | Bool | doc "Whether to notify about resolved alerts.",
        } | doc "List of Telegram configurations.",
        victoropsConfigs | optional | Array {
          apiKey | optional | {
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
The secret's key that contains the API key to use when talking to the VictorOps API.
The secret needs to be in the same namespace as the AlertmanagerConfig
object and accessible by the Prometheus Operator.
"%,
          apiUrl | optional | String | doc "The VictorOps API URL.",
          customFields | optional | Array {
            key | String | doc "Key of the tuple.",
            value | String | doc "Value of the tuple.",
          } | doc "Additional custom fields for notification.",
          entityDisplayName | optional | String | doc "Contains summary of the alerted problem.",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The secret's key that contains the bearer token to be used by the client
for authentication.
The secret needs to be in the same namespace as the AlertmanagerConfig
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
            proxyURL | optional | String | doc m%"
Optional proxy URL.

If defined, this field takes precedence over `proxyUrl`.
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
            } | doc "TLS configuration for the client.",
          } | doc "The HTTP client's configuration.",
          messageType | optional | String | doc "Describes the behavior of the alert (CRITICAL, WARNING, INFO).",
          monitoringTool | optional | String | doc "The monitoring tool the state message is from.",
          routingKey | optional | String | doc "A key used to map the alert to a team.",
          sendResolved | optional | Bool | doc "Whether or not to notify about resolved alerts.",
          stateMessage | optional | String | doc "Contains long explanation of the alerted problem.",
        } | doc "List of VictorOps configurations.",
        webexConfigs | optional | Array {
          apiURL | optional | String | doc m%"
The Webex Teams API URL i.e. https://webexapis.com/v1/messages
Provide if different from the default API URL.
"%,
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The secret's key that contains the bearer token to be used by the client
for authentication.
The secret needs to be in the same namespace as the AlertmanagerConfig
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
            proxyURL | optional | String | doc m%"
Optional proxy URL.

If defined, this field takes precedence over `proxyUrl`.
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
            } | doc "TLS configuration for the client.",
          } | doc m%"
The HTTP client's configuration.
You must supply the bot token via the `httpConfig.authorization` field.
"%,
          message | optional | String | doc "Message template",
          roomID | String | doc "ID of the Webex Teams room where to send the messages.",
          sendResolved | optional | Bool | doc "Whether to notify about resolved alerts.",
        } | doc "List of Webex configurations.",
        webhookConfigs | optional | Array {
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The secret's key that contains the bearer token to be used by the client
for authentication.
The secret needs to be in the same namespace as the AlertmanagerConfig
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
            proxyURL | optional | String | doc m%"
Optional proxy URL.

If defined, this field takes precedence over `proxyUrl`.
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
            } | doc "TLS configuration for the client.",
          } | doc "HTTP client configuration.",
          maxAlerts | optional | Number | doc m%"
Maximum number of alerts to be sent per webhook message. When 0, all alerts are included.
"%,
          sendResolved | optional | Bool | doc "Whether or not to notify about resolved alerts.",
          timeout | optional | String | doc m%"
The maximum time to wait for a webhook request to complete, before failing the
request and allowing it to be retried.
It requires Alertmanager >= v0.28.0.
"%,
          url | optional | String | doc m%"
The URL to send HTTP POST requests to. `urlSecret` takes precedence over
`url`. One of `urlSecret` and `url` should be defined.
"%,
          urlSecret | optional | {
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
The secret's key that contains the webhook URL to send HTTP requests to.
`urlSecret` takes precedence over `url`. One of `urlSecret` and `url`
should be defined.
The secret needs to be in the same namespace as the AlertmanagerConfig
object and accessible by the Prometheus Operator.
"%,
        } | doc "List of webhook configurations.",
        wechatConfigs | optional | Array {
          agentID | optional | String,
          apiSecret | optional | {
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
The secret's key that contains the WeChat API key.
The secret needs to be in the same namespace as the AlertmanagerConfig
object and accessible by the Prometheus Operator.
"%,
          apiURL | optional | String | doc "The WeChat API URL.",
          corpID | optional | String | doc "The corp id for authentication.",
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
              "optional" | optional | Bool | doc "Specify whether the Secret or its key must be defined",
            } | doc m%"
The secret's key that contains the bearer token to be used by the client
for authentication.
The secret needs to be in the same namespace as the AlertmanagerConfig
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
            proxyURL | optional | String | doc m%"
Optional proxy URL.

If defined, this field takes precedence over `proxyUrl`.
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
            } | doc "TLS configuration for the client.",
          } | doc "HTTP client configuration.",
          message | optional | String | doc "API request data as defined by the WeChat API.",
          messageType | optional | String,
          sendResolved | optional | Bool | doc "Whether or not to notify about resolved alerts.",
          toParty | optional | String,
          toTag | optional | String,
          toUser | optional | String,
        } | doc "List of WeChat configurations.",
      } | doc "List of receivers.",
      route | optional | {
        activeTimeIntervals | optional | Array String | doc m%"
ActiveTimeIntervals is a list of MuteTimeInterval names when this route should be active.
"%,
        continue | optional | Bool | doc m%"
Boolean indicating whether an alert should continue matching subsequent
sibling nodes. It will always be overridden to true for the first-level
route by the Prometheus operator.
"%,
        groupBy | optional | Array String | doc m%"
List of labels to group by.
Labels must not be repeated (unique list).
Special label "..." (aggregate by all possible labels), if provided, must be the only element in the list.
"%,
        groupInterval | optional | String | doc m%"
How long to wait before sending an updated notification.
Must match the regular expression`^(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?$`
Example: "5m"
"%,
        groupWait | optional | String | doc m%"
How long to wait before sending the initial notification.
Must match the regular expression`^(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?$`
Example: "30s"
"%,
        matchers | optional | Array {
          matchType | optional | String | doc m%"
Match operation available with AlertManager >= v0.22.0 and
takes precedence over Regex (deprecated) if non-empty.
"%,
          name | String | doc "Label to match.",
          regex | optional | Bool | doc m%"
Whether to match on equality (false) or regular-expression (true).
Deprecated: for AlertManager >= v0.22.0, `matchType` should be used instead.
"%,
          value | optional | String | doc "Label value to match.",
        } | doc m%"
List of matchers that the alert's labels should match. For the first
level route, the operator removes any existing equality and regexp
matcher on the `namespace` label and adds a `namespace: <object
namespace>` matcher.
"%,
        muteTimeIntervals | optional | Array String | doc m%"
Note: this comment applies to the field definition above but appears
below otherwise it gets included in the generated manifest.
CRD schema doesn't support self-referential types for now (see
https://github.com/kubernetes/kubernetes/issues/62872). We have to use
an alternative type to circumvent the limitation. The downside is that
the Kube API can't validate the data beyond the fact that it is a valid
JSON representation.
MuteTimeIntervals is a list of MuteTimeInterval names that will mute this route when matched,
"%,
        receiver | optional | String | doc m%"
Name of the receiver for this route. If not empty, it should be listed in
the `receivers` field.
"%,
        repeatInterval | optional | String | doc m%"
How long to wait before repeating the last notification.
Must match the regular expression`^(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?$`
Example: "4h"
"%,
        routes | optional | Array Dyn | doc "Child routes.",
      } | doc m%"
The Alertmanager route definition for alerts matching the resource's
namespace. If present, it will be added to the generated Alertmanager
configuration as a first-level route.
"%,
    } | doc m%"
AlertmanagerConfigSpec is a specification of the desired behavior of the
Alertmanager configuration.
By default, the Alertmanager configuration only applies to alerts for which
the `namespace` label is equal to the namespace of the AlertmanagerConfig
resource (see the `.spec.alertmanagerConfigMatcherStrategy` field of the
Alertmanager CRD).
"%,
  },
}
