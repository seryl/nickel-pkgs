# Module: challenge.acme.cert-manager.io

let k8s_io_toleration = import "k8s_io" in
let k8s_io_objectmeta = import "k8s_io" in

{
  Challenge = {
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
    metadata | k8s_io_toleration.ObjectMeta,
    spec | {
      authorizationURL | String | doc m%"
The URL to the ACME Authorization resource that this
challenge is a part of.
"%,
      dnsName | String | doc m%"
dnsName is the identifier that this challenge is for, e.g., example.com.
If the requested DNSName is a 'wildcard', this field MUST be set to the
non-wildcard domain, e.g., for `*.example.com`, it must be `example.com`.
"%,
      issuerRef | {
        group | optional | String | doc "Group of the resource being referred to.",
        kind | optional | String | doc "Kind of the resource being referred to.",
        name | String | doc "Name of the resource being referred to.",
      } | doc m%"
References a properly configured ACME-type Issuer which should
be used to create this Challenge.
If the Issuer does not exist, processing will be retried.
If the Issuer is not an 'ACME' Issuer, an error will be returned and the
Challenge will be marked as failed.
"%,
      key | String | doc m%"
The ACME challenge key for this challenge
For HTTP01 challenges, this is the value that must be responded with to
complete the HTTP01 challenge in the format:
`<private key JWK thumbprint>.<key from acme server for challenge>`.
For DNS01 challenges, this is the base64 encoded SHA256 sum of the
`<private key JWK thumbprint>.<key from acme server for challenge>`
text that must be set as the TXT record content.
"%,
      solver | {
        dns01 | optional | {
          acmeDNS | optional | {
            accountSecretRef | {
              key | optional | String | doc m%"
The key of the entry in the Secret resource's `data` field to be used.
Some instances of this field may be defaulted, in others it may be
required.
"%,
              name | String | doc m%"
Name of the resource being referred to.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"%,
            } | doc m%"
A reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.
"%,
            host | String,
          } | doc m%"
Use the 'ACME DNS' (https://github.com/joohoi/acme-dns) API to manage
DNS01 challenge records.
"%,
          akamai | optional | {
            accessTokenSecretRef | {
              key | optional | String | doc m%"
The key of the entry in the Secret resource's `data` field to be used.
Some instances of this field may be defaulted, in others it may be
required.
"%,
              name | String | doc m%"
Name of the resource being referred to.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"%,
            } | doc m%"
A reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.
"%,
            clientSecretSecretRef | {
              key | optional | String | doc m%"
The key of the entry in the Secret resource's `data` field to be used.
Some instances of this field may be defaulted, in others it may be
required.
"%,
              name | String | doc m%"
Name of the resource being referred to.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"%,
            } | doc m%"
A reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.
"%,
            clientTokenSecretRef | {
              key | optional | String | doc m%"
The key of the entry in the Secret resource's `data` field to be used.
Some instances of this field may be defaulted, in others it may be
required.
"%,
              name | String | doc m%"
Name of the resource being referred to.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"%,
            } | doc m%"
A reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.
"%,
            serviceConsumerDomain | String,
          } | doc "Use the Akamai DNS zone management API to manage DNS01 challenge records.",
          azureDNS | optional | {
            clientID | optional | String | doc m%"
Auth: Azure Service Principal:
The ClientID of the Azure Service Principal used to authenticate with Azure DNS.
If set, ClientSecret and TenantID must also be set.
"%,
            clientSecretSecretRef | optional | {
              key | optional | String | doc m%"
The key of the entry in the Secret resource's `data` field to be used.
Some instances of this field may be defaulted, in others it may be
required.
"%,
              name | String | doc m%"
Name of the resource being referred to.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"%,
            } | doc m%"
Auth: Azure Service Principal:
A reference to a Secret containing the password associated with the Service Principal.
If set, ClientID and TenantID must also be set.
"%,
            environment | optional | String | doc "name of the Azure environment (default AzurePublicCloud)",
            hostedZoneName | optional | String | doc "name of the DNS zone that should be used",
            managedIdentity | optional | {
              clientID | optional | String | doc "client ID of the managed identity, cannot be used at the same time as resourceID",
              resourceID | optional | String | doc m%"
resource ID of the managed identity, cannot be used at the same time as clientID
Cannot be used for Azure Managed Service Identity
"%,
              tenantID | optional | String | doc "tenant ID of the managed identity, cannot be used at the same time as resourceID",
            } | doc m%"
Auth: Azure Workload Identity or Azure Managed Service Identity:
Settings to enable Azure Workload Identity or Azure Managed Service Identity
If set, ClientID, ClientSecret and TenantID must not be set.
"%,
            resourceGroupName | String | doc "resource group the DNS zone is located in",
            subscriptionID | String | doc "ID of the Azure subscription",
            tenantID | optional | String | doc m%"
Auth: Azure Service Principal:
The TenantID of the Azure Service Principal used to authenticate with Azure DNS.
If set, ClientID and ClientSecret must also be set.
"%,
          } | doc "Use the Microsoft Azure DNS API to manage DNS01 challenge records.",
          cloudDNS | optional | {
            hostedZoneName | optional | String | doc m%"
HostedZoneName is an optional field that tells cert-manager in which
Cloud DNS zone the challenge record has to be created.
If left empty cert-manager will automatically choose a zone.
"%,
            project | String,
            serviceAccountSecretRef | optional | {
              key | optional | String | doc m%"
The key of the entry in the Secret resource's `data` field to be used.
Some instances of this field may be defaulted, in others it may be
required.
"%,
              name | String | doc m%"
Name of the resource being referred to.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"%,
            } | doc m%"
A reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.
"%,
          } | doc "Use the Google Cloud DNS API to manage DNS01 challenge records.",
          cloudflare | optional | {
            apiKeySecretRef | optional | {
              key | optional | String | doc m%"
The key of the entry in the Secret resource's `data` field to be used.
Some instances of this field may be defaulted, in others it may be
required.
"%,
              name | String | doc m%"
Name of the resource being referred to.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"%,
            } | doc m%"
API key to use to authenticate with Cloudflare.
Note: using an API token to authenticate is now the recommended method
as it allows greater control of permissions.
"%,
            apiTokenSecretRef | optional | {
              key | optional | String | doc m%"
The key of the entry in the Secret resource's `data` field to be used.
Some instances of this field may be defaulted, in others it may be
required.
"%,
              name | String | doc m%"
Name of the resource being referred to.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"%,
            } | doc "API token used to authenticate with Cloudflare.",
            email | optional | String | doc "Email of the account, only required when using API key based authentication.",
          } | doc "Use the Cloudflare API to manage DNS01 challenge records.",
          cnameStrategy | optional | String | doc m%"
CNAMEStrategy configures how the DNS01 provider should handle CNAME
records when found in DNS zones.
"%,
          digitalocean | optional | {
            tokenSecretRef | {
              key | optional | String | doc m%"
The key of the entry in the Secret resource's `data` field to be used.
Some instances of this field may be defaulted, in others it may be
required.
"%,
              name | String | doc m%"
Name of the resource being referred to.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"%,
            } | doc m%"
A reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.
"%,
          } | doc "Use the DigitalOcean DNS API to manage DNS01 challenge records.",
          rfc2136 | optional | {
            nameserver | String | doc m%"
The IP address or hostname of an authoritative DNS server supporting
RFC2136 in the form host:port. If the host is an IPv6 address it must be
enclosed in square brackets (e.g [2001:db8::1]) ; port is optional.
This field is required.
"%,
            tsigAlgorithm | optional | String | doc m%"
The TSIG Algorithm configured in the DNS supporting RFC2136. Used only
when ``tsigSecretSecretRef`` and ``tsigKeyName`` are defined.
Supported values are (case-insensitive): ``HMACMD5`` (default),
``HMACSHA1``, ``HMACSHA256`` or ``HMACSHA512``.
"%,
            tsigKeyName | optional | String | doc m%"
The TSIG Key name configured in the DNS.
If ``tsigSecretSecretRef`` is defined, this field is required.
"%,
            tsigSecretSecretRef | optional | {
              key | optional | String | doc m%"
The key of the entry in the Secret resource's `data` field to be used.
Some instances of this field may be defaulted, in others it may be
required.
"%,
              name | String | doc m%"
Name of the resource being referred to.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"%,
            } | doc m%"
The name of the secret containing the TSIG value.
If ``tsigKeyName`` is defined, this field is required.
"%,
          } | doc m%"
Use RFC2136 ("Dynamic Updates in the Domain Name System") (https://datatracker.ietf.org/doc/rfc2136/)
to manage DNS01 challenge records.
"%,
          route53 | optional | {
            accessKeyID | optional | String | doc m%"
The AccessKeyID is used for authentication.
Cannot be set when SecretAccessKeyID is set.
If neither the Access Key nor Key ID are set, we fall-back to using env
vars, shared credentials file or AWS Instance metadata,
see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials
"%,
            accessKeyIDSecretRef | optional | {
              key | optional | String | doc m%"
The key of the entry in the Secret resource's `data` field to be used.
Some instances of this field may be defaulted, in others it may be
required.
"%,
              name | String | doc m%"
Name of the resource being referred to.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"%,
            } | doc m%"
The SecretAccessKey is used for authentication. If set, pull the AWS
access key ID from a key within a Kubernetes Secret.
Cannot be set when AccessKeyID is set.
If neither the Access Key nor Key ID are set, we fall-back to using env
vars, shared credentials file or AWS Instance metadata,
see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials
"%,
            auth | optional | {
              kubernetes | {
                serviceAccountRef | {
                  audiences | optional | Array String | doc m%"
TokenAudiences is an optional list of audiences to include in the
token passed to AWS. The default token consisting of the issuer's namespace
and name is always included.
If unset the audience defaults to `sts.amazonaws.com`.
"%,
                  name | String | doc "Name of the ServiceAccount used to request a token.",
                } | doc m%"
A reference to a service account that will be used to request a bound
token (also known as "projected token"). To use this field, you must
configure an RBAC rule to let cert-manager request a token.
"%,
              } | doc m%"
Kubernetes authenticates with Route53 using AssumeRoleWithWebIdentity
by passing a bound ServiceAccount token.
"%,
            } | doc "Auth configures how cert-manager authenticates.",
            hostedZoneID | optional | String | doc m%"
If set, the provider will manage only this zone in Route53 and will not do a lookup using the route53:ListHostedZonesByName api call.
"%,
            region | optional | String | doc m%"
Override the AWS region.

Route53 is a global service and does not have regional endpoints but the
region specified here (or via environment variables) is used as a hint to
help compute the correct AWS credential scope and partition when it
connects to Route53. See:
- [Amazon Route 53 endpoints and quotas](https://docs.aws.amazon.com/general/latest/gr/r53.html)
- [Global services](https://docs.aws.amazon.com/whitepapers/latest/aws-fault-isolation-boundaries/global-services.html)

If you omit this region field, cert-manager will use the region from
AWS_REGION and AWS_DEFAULT_REGION environment variables, if they are set
in the cert-manager controller Pod.

The `region` field is not needed if you use [IAM Roles for Service Accounts (IRSA)](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html).
Instead an AWS_REGION environment variable is added to the cert-manager controller Pod by:
[Amazon EKS Pod Identity Webhook](https://github.com/aws/amazon-eks-pod-identity-webhook).
In this case this `region` field value is ignored.

The `region` field is not needed if you use [EKS Pod Identities](https://docs.aws.amazon.com/eks/latest/userguide/pod-identities.html).
Instead an AWS_REGION environment variable is added to the cert-manager controller Pod by:
[Amazon EKS Pod Identity Agent](https://github.com/aws/eks-pod-identity-agent),
In this case this `region` field value is ignored.
"%,
            role | optional | String | doc m%"
Role is a Role ARN which the Route53 provider will assume using either the explicit credentials AccessKeyID/SecretAccessKey
or the inferred credentials from environment variables, shared credentials file or AWS Instance metadata
"%,
            secretAccessKeySecretRef | optional | {
              key | optional | String | doc m%"
The key of the entry in the Secret resource's `data` field to be used.
Some instances of this field may be defaulted, in others it may be
required.
"%,
              name | String | doc m%"
Name of the resource being referred to.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"%,
            } | doc m%"
The SecretAccessKey is used for authentication.
If neither the Access Key nor Key ID are set, we fall-back to using env
vars, shared credentials file or AWS Instance metadata,
see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials
"%,
          } | doc "Use the AWS Route53 API to manage DNS01 challenge records.",
          webhook | optional | {
            config | optional | Dyn | doc m%"
Additional configuration that should be passed to the webhook apiserver
when challenges are processed.
This can contain arbitrary JSON data.
Secret values should not be specified in this stanza.
If secret values are needed (e.g., credentials for a DNS service), you
should use a SecretKeySelector to reference a Secret resource.
For details on the schema of this field, consult the webhook provider
implementation's documentation.
"%,
            groupName | String | doc m%"
The API group name that should be used when POSTing ChallengePayload
resources to the webhook apiserver.
This should be the same as the GroupName specified in the webhook
provider implementation.
"%,
            solverName | String | doc m%"
The name of the solver to use, as defined in the webhook provider
implementation.
This will typically be the name of the provider, e.g., 'cloudflare'.
"%,
          } | doc m%"
Configure an external webhook based DNS01 challenge solver to manage
DNS01 challenge records.
"%,
        } | doc m%"
Configures cert-manager to attempt to complete authorizations by
performing the DNS01 challenge flow.
"%,
        http01 | optional | {
          gatewayHTTPRoute | optional | {
            labels | optional | {
            } | doc m%"
Custom labels that will be applied to HTTPRoutes created by cert-manager
while solving HTTP-01 challenges.
"%,
            parentRefs | optional | Array {
              group | String | doc m%"
Group is the group of the referent.
When unspecified, "gateway.networking.k8s.io" is inferred.
To set the core API group (such as for a "Service" kind referent),
Group must be explicitly set to "" (empty string).

Support: Core
"% | default = "gateway.networking.k8s.io",
              kind | String | doc m%"
Kind is kind of the referent.

There are two kinds of parent resources with "Core" support:

* Gateway (Gateway conformance profile)
* Service (Mesh conformance profile, ClusterIP Services only)

Support for other resources is Implementation-Specific.
"% | default = "Gateway",
              name | String | doc m%"
Name is the name of the referent.

Support: Core
"%,
              namespace | optional | String | doc m%"
Namespace is the namespace of the referent. When unspecified, this refers
to the local namespace of the Route.

Note that there are specific rules for ParentRefs which cross namespace
boundaries. Cross-namespace references are only valid if they are explicitly
allowed by something in the namespace they are referring to. For example:
Gateway has the AllowedRoutes field, and ReferenceGrant provides a
generic way to enable any other kind of cross-namespace reference.

<gateway:experimental:description>
ParentRefs from a Route to a Service in the same namespace are "producer"
routes, which apply default routing rules to inbound connections from
any namespace to the Service.

ParentRefs from a Route to a Service in a different namespace are
"consumer" routes, and these routing rules are only applied to outbound
connections originating from the same namespace as the Route, for which
the intended destination of the connections are a Service targeted as a
ParentRef of the Route.
</gateway:experimental:description>

Support: Core
"%,
              port | optional | Number | doc m%"
Port is the network port this Route targets. It can be interpreted
differently based on the type of parent resource.

When the parent resource is a Gateway, this targets all listeners
listening on the specified port that also support this kind of Route(and
select this Route). It's not recommended to set `Port` unless the
networking behaviors specified in a Route must apply to a specific port
as opposed to a listener(s) whose port(s) may be changed. When both Port
and SectionName are specified, the name and port of the selected listener
must match both specified values.

<gateway:experimental:description>
When the parent resource is a Service, this targets a specific port in the
Service spec. When both Port (experimental) and SectionName are specified,
the name and port of the selected port must match both specified values.
</gateway:experimental:description>

Implementations MAY choose to support other parent resources.
Implementations supporting other types of parent resources MUST clearly
document how/if Port is interpreted.

For the purpose of status, an attachment is considered successful as
long as the parent resource accepts it partially. For example, Gateway
listeners can restrict which Routes can attach to them by Route kind,
namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
from the referencing Route, the Route MUST be considered successfully
attached. If no Gateway listeners accept attachment from this Route,
the Route MUST be considered detached from the Gateway.

Support: Extended
"%,
              sectionName | optional | String | doc m%"
SectionName is the name of a section within the target resource. In the
following resources, SectionName is interpreted as the following:

* Gateway: Listener name. When both Port (experimental) and SectionName
are specified, the name and port of the selected listener must match
both specified values.
* Service: Port name. When both Port (experimental) and SectionName
are specified, the name and port of the selected listener must match
both specified values.

Implementations MAY choose to support attaching Routes to other resources.
If that is the case, they MUST clearly document how SectionName is
interpreted.

When unspecified (empty string), this will reference the entire resource.
For the purpose of status, an attachment is considered successful if at
least one section in the parent resource accepts it. For example, Gateway
listeners can restrict which Routes can attach to them by Route kind,
namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
the referencing Route, the Route MUST be considered successfully
attached. If no Gateway listeners accept attachment from this Route, the
Route MUST be considered detached from the Gateway.

Support: Core
"%,
            } | doc m%"
When solving an HTTP-01 challenge, cert-manager creates an HTTPRoute.
cert-manager needs to know which parentRefs should be used when creating
the HTTPRoute. Usually, the parentRef references a Gateway. See:
https://gateway-api.sigs.k8s.io/api-types/httproute/#attaching-to-gateways
"%,
            podTemplate | optional | {
              metadata | optional | {
                annotations | optional | {
                } | doc "Annotations that should be added to the created ACME HTTP01 solver pods.",
                labels | optional | {
                } | doc "Labels that should be added to the created ACME HTTP01 solver pods.",
              } | doc m%"
ObjectMeta overrides for the pod used to solve HTTP01 challenges.
Only the 'labels' and 'annotations' fields may be set.
If labels or annotations overlap with in-built values, the values here
will override the in-built values.
"%,
              spec | optional | {
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
                } | doc "If specified, the pod's scheduling constraints",
                imagePullSecrets | optional | Array {
                  name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                } | doc "If specified, the pod's imagePullSecrets",
                nodeSelector | optional | {
                } | doc m%"
NodeSelector is a selector which must be true for the pod to fit on a node.
Selector which must match a node's labels for the pod to be scheduled on that node.
More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
"%,
                priorityClassName | optional | String | doc "If specified, the pod's priorityClassName.",
                securityContext | optional | {
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
A list of groups applied to the first process run in each container, in addition
to the container's primary GID, the fsGroup (if specified), and group memberships
defined in the container image for the uid of the container process. If unspecified,
no additional groups are added to any container. Note that group memberships
defined in the container image for the uid of the container process are still effective,
even if they are not included in this list.
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
                } | doc "If specified, the pod's security context",
                serviceAccountName | optional | String | doc "If specified, the pod's service account",
                tolerations | optional | Array k8s_io_toleration.Toleration | doc "If specified, the pod's tolerations.",
              } | doc m%"
PodSpec defines overrides for the HTTP01 challenge solver pod.
Check ACMEChallengeSolverHTTP01IngressPodSpec to find out currently supported fields.
All other fields will be ignored.
"%,
            } | doc m%"
Optional pod template used to configure the ACME challenge solver pods
used for HTTP01 challenges.
"%,
            serviceType | optional | String | doc m%"
Optional service type for Kubernetes solver service. Supported values
are NodePort or ClusterIP. If unset, defaults to NodePort.
"%,
          } | doc m%"
The Gateway API is a sig-network community API that models service networking
in Kubernetes (https://gateway-api.sigs.k8s.io/). The Gateway solver will
create HTTPRoutes with the specified labels in the same namespace as the challenge.
This solver is experimental, and fields / behaviour may change in the future.
"%,
          ingress | optional | {
            class | optional | String | doc m%"
This field configures the annotation `kubernetes.io/ingress.class` when
creating Ingress resources to solve ACME challenges that use this
challenge solver. Only one of `class`, `name` or `ingressClassName` may
be specified.
"%,
            ingressClassName | optional | String | doc m%"
This field configures the field `ingressClassName` on the created Ingress
resources used to solve ACME challenges that use this challenge solver.
This is the recommended way of configuring the ingress class. Only one of
`class`, `name` or `ingressClassName` may be specified.
"%,
            ingressTemplate | optional | {
              metadata | optional | {
                annotations | optional | {
                } | doc "Annotations that should be added to the created ACME HTTP01 solver ingress.",
                labels | optional | {
                } | doc "Labels that should be added to the created ACME HTTP01 solver ingress.",
              } | doc m%"
ObjectMeta overrides for the ingress used to solve HTTP01 challenges.
Only the 'labels' and 'annotations' fields may be set.
If labels or annotations overlap with in-built values, the values here
will override the in-built values.
"%,
            } | doc m%"
Optional ingress template used to configure the ACME challenge solver
ingress used for HTTP01 challenges.
"%,
            name | optional | String | doc m%"
The name of the ingress resource that should have ACME challenge solving
routes inserted into it in order to solve HTTP01 challenges.
This is typically used in conjunction with ingress controllers like
ingress-gce, which maintains a 1:1 mapping between external IPs and
ingress resources. Only one of `class`, `name` or `ingressClassName` may
be specified.
"%,
            podTemplate | optional | {
              metadata | optional | {
                annotations | optional | {
                } | doc "Annotations that should be added to the created ACME HTTP01 solver pods.",
                labels | optional | {
                } | doc "Labels that should be added to the created ACME HTTP01 solver pods.",
              } | doc m%"
ObjectMeta overrides for the pod used to solve HTTP01 challenges.
Only the 'labels' and 'annotations' fields may be set.
If labels or annotations overlap with in-built values, the values here
will override the in-built values.
"%,
              spec | optional | {
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
This is a beta field and requires enabling MatchLabelKeysInPodAffinity feature gate (enabled by default).
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
                } | doc "If specified, the pod's scheduling constraints",
                imagePullSecrets | optional | Array {
                  name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
                } | doc "If specified, the pod's imagePullSecrets",
                nodeSelector | optional | {
                } | doc m%"
NodeSelector is a selector which must be true for the pod to fit on a node.
Selector which must match a node's labels for the pod to be scheduled on that node.
More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
"%,
                priorityClassName | optional | String | doc "If specified, the pod's priorityClassName.",
                securityContext | optional | {
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
A list of groups applied to the first process run in each container, in addition
to the container's primary GID, the fsGroup (if specified), and group memberships
defined in the container image for the uid of the container process. If unspecified,
no additional groups are added to any container. Note that group memberships
defined in the container image for the uid of the container process are still effective,
even if they are not included in this list.
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
                } | doc "If specified, the pod's security context",
                serviceAccountName | optional | String | doc "If specified, the pod's service account",
                tolerations | optional | Array k8s_io_toleration.Toleration | doc "If specified, the pod's tolerations.",
              } | doc m%"
PodSpec defines overrides for the HTTP01 challenge solver pod.
Check ACMEChallengeSolverHTTP01IngressPodSpec to find out currently supported fields.
All other fields will be ignored.
"%,
            } | doc m%"
Optional pod template used to configure the ACME challenge solver pods
used for HTTP01 challenges.
"%,
            serviceType | optional | String | doc m%"
Optional service type for Kubernetes solver service. Supported values
are NodePort or ClusterIP. If unset, defaults to NodePort.
"%,
          } | doc m%"
The ingress based HTTP01 challenge solver will solve challenges by
creating or modifying Ingress resources in order to route requests for
'/.well-known/acme-challenge/XYZ' to 'challenge solver' pods that are
provisioned by cert-manager for each Challenge to be completed.
"%,
        } | doc m%"
Configures cert-manager to attempt to complete authorizations by
performing the HTTP01 challenge flow.
It is not possible to obtain certificates for wildcard domain names
(e.g., `*.example.com`) using the HTTP01 challenge mechanism.
"%,
        selector | optional | {
          dnsNames | optional | Array String | doc m%"
List of DNSNames that this solver will be used to solve.
If specified and a match is found, a dnsNames selector will take
precedence over a dnsZones selector.
If multiple solvers match with the same dnsNames value, the solver
with the most matching labels in matchLabels will be selected.
If neither has more matches, the solver defined earlier in the list
will be selected.
"%,
          dnsZones | optional | Array String | doc m%"
List of DNSZones that this solver will be used to solve.
The most specific DNS zone match specified here will take precedence
over other DNS zone matches, so a solver specifying sys.example.com
will be selected over one specifying example.com for the domain
www.sys.example.com.
If multiple solvers match with the same dnsZones value, the solver
with the most matching labels in matchLabels will be selected.
If neither has more matches, the solver defined earlier in the list
will be selected.
"%,
          matchLabels | optional | {
          } | doc m%"
A label selector that is used to refine the set of certificate's that
this challenge solver will apply to.
"%,
        } | doc m%"
Selector selects a set of DNSNames on the Certificate resource that
should be solved using this challenge solver.
If not specified, the solver will be treated as the 'default' solver
with the lowest priority, i.e. if any other solver has a more specific
match, it will be used instead.
"%,
      } | doc m%"
Contains the domain solving configuration that should be used to
solve this challenge resource.
"%,
      token | String | doc m%"
The ACME challenge token for this challenge.
This is the raw value returned from the ACME server.
"%,
      type | String | doc m%"
The type of ACME challenge this resource represents.
One of "HTTP-01" or "DNS-01".
"%,
      url | String | doc m%"
The URL of the ACME Challenge resource for this challenge.
This can be used to lookup details about the status of this challenge.
"%,
      wildcard | optional | Bool | doc m%"
wildcard will be true if this challenge is for a wildcard identifier,
for example '*.example.com'.
"%,
    },
    status | optional | {
      presented | optional | Bool | doc m%"
presented will be set to true if the challenge values for this challenge
are currently 'presented'.
This *does not* imply the self check is passing. Only that the values
have been 'submitted' for the appropriate challenge mechanism (i.e. the
DNS01 TXT record has been presented, or the HTTP01 configuration has been
configured).
"%,
      processing | optional | Bool | doc m%"
Used to denote whether this challenge should be processed or not.
This field will only be set to true by the 'scheduling' component.
It will only be set to false by the 'challenges' controller, after the
challenge has reached a final state or timed out.
If this field is set to false, the challenge controller will not take
any more action.
"%,
      reason | optional | String | doc m%"
Contains human readable information on why the Challenge is in the
current state.
"%,
      state | optional | String | doc m%"
Contains the current 'state' of the challenge.
If not set, the state of the challenge is unknown.
"%,
    },
  },
}
