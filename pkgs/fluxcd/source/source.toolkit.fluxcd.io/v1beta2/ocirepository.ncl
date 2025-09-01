# Module: ocirepository.source.toolkit.fluxcd.io

let k8s_io_objectmeta = import "k8s_io" in

{
  OCIRepository = {
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
    spec | optional | {
      certSecretRef | optional | {
        name | String | doc "Name of the referent.",
      } | doc m%"
CertSecretRef can be given the name of a Secret containing
either or both of

- a PEM-encoded client certificate (`tls.crt`) and private
key (`tls.key`);
- a PEM-encoded CA certificate (`ca.crt`)

and whichever are supplied, will be used for connecting to the
registry. The client cert and key are useful if you are
authenticating with a certificate; the CA cert is useful if
you are using a self-signed server certificate. The Secret must
be of type `Opaque` or `kubernetes.io/tls`.

Note: Support for the `caFile`, `certFile` and `keyFile` keys have
been deprecated.
"%,
      ignore | optional | String | doc m%"
Ignore overrides the set of excluded patterns in the .sourceignore format
(which is the same as .gitignore). If not provided, a default will be used,
consult the documentation for your version to find out what those are.
"%,
      insecure | optional | Bool | doc "Insecure allows connecting to a non-TLS HTTP container registry.",
      interval | String | doc m%"
Interval at which the OCIRepository URL is checked for updates.
This interval is approximate and may be subject to jitter to ensure
efficient use of resources.
"%,
      layerSelector | optional | {
        mediaType | optional | String | doc m%"
MediaType specifies the OCI media type of the layer
which should be extracted from the OCI Artifact. The
first layer matching this type is selected.
"%,
        operation | optional | String | doc m%"
Operation specifies how the selected layer should be processed.
By default, the layer compressed content is extracted to storage.
When the operation is set to 'copy', the layer compressed content
is persisted to storage as it is.
"%,
      } | doc m%"
LayerSelector specifies which layer should be extracted from the OCI artifact.
When not specified, the first layer found in the artifact is selected.
"%,
      provider | String | doc m%"
The provider used for authentication, can be 'aws', 'azure', 'gcp' or 'generic'.
When not specified, defaults to 'generic'.
"% | default = "generic",
      proxySecretRef | optional | {
        name | String | doc "Name of the referent.",
      } | doc m%"
ProxySecretRef specifies the Secret containing the proxy configuration
to use while communicating with the container registry.
"%,
      ref | optional | {
        digest | optional | String | doc m%"
Digest is the image digest to pull, takes precedence over SemVer.
The value should be in the format 'sha256:<HASH>'.
"%,
        semver | optional | String | doc m%"
SemVer is the range of tags to pull selecting the latest within
the range, takes precedence over Tag.
"%,
        semverFilter | optional | String | doc "SemverFilter is a regex pattern to filter the tags within the SemVer range.",
        tag | optional | String | doc "Tag is the image tag to pull, defaults to latest.",
      } | doc m%"
The OCI reference to pull and monitor for changes,
defaults to the latest tag.
"%,
      secretRef | optional | {
        name | String | doc "Name of the referent.",
      } | doc m%"
SecretRef contains the secret name containing the registry login
credentials to resolve image metadata.
The secret must be of type kubernetes.io/dockerconfigjson.
"%,
      serviceAccountName | optional | String | doc m%"
ServiceAccountName is the name of the Kubernetes ServiceAccount used to authenticate
the image pull if the service account has attached pull secrets. For more information:
https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#add-imagepullsecrets-to-a-service-account
"%,
      suspend | optional | Bool | doc "This flag tells the controller to suspend the reconciliation of this source.",
      timeout | String | doc "The timeout for remote OCI Repository operations like pulling, defaults to 60s." | default = "60s",
      url | String | doc m%"
URL is a reference to an OCI artifact repository hosted
on a remote container registry.
"%,
      verify | optional | {
        matchOIDCIdentity | optional | Array {
          issuer | String | doc m%"
Issuer specifies the regex pattern to match against to verify
the OIDC issuer in the Fulcio certificate. The pattern must be a
valid Go regular expression.
"%,
          subject | String | doc m%"
Subject specifies the regex pattern to match against to verify
the identity subject in the Fulcio certificate. The pattern must
be a valid Go regular expression.
"%,
        } | doc m%"
MatchOIDCIdentity specifies the identity matching criteria to use
while verifying an OCI artifact which was signed using Cosign keyless
signing. The artifact's identity is deemed to be verified if any of the
specified matchers match against the identity.
"%,
        provider | String | doc "Provider specifies the technology used to sign the OCI Artifact." | default = "cosign",
        secretRef | optional | {
          name | String | doc "Name of the referent.",
        } | doc m%"
SecretRef specifies the Kubernetes Secret containing the
trusted public keys.
"%,
      } | doc m%"
Verify contains the secret name containing the trusted public keys
used to verify the signature and specifies which provider to use to check
whether OCI image is authentic.
"%,
    } | doc "OCIRepositorySpec defines the desired state of OCIRepository",
    status | {
      artifact | optional | {
        digest | optional | String | doc "Digest is the digest of the file in the form of '<algorithm>:<checksum>'.",
        lastUpdateTime | String | doc m%"
LastUpdateTime is the timestamp corresponding to the last update of the
Artifact.
"%,
        metadata | optional | k8s_io_objectmeta.ObjectMeta | doc "Metadata holds upstream information such as OCI annotations.",
        path | String | doc m%"
Path is the relative file path of the Artifact. It can be used to locate
the file in the root of the Artifact storage on the local file system of
the controller managing the Source.
"%,
        revision | String | doc m%"
Revision is a human-readable identifier traceable in the origin source
system. It can be a Git commit SHA, Git tag, a Helm chart version, etc.
"%,
        size | optional | Number | doc "Size is the number of bytes in the file.",
        url | String | doc m%"
URL is the HTTP address of the Artifact as exposed by the controller
managing the Source. It can be used to retrieve the Artifact for
consumption, e.g. by another controller applying the Artifact contents.
"%,
      } | doc "Artifact represents the output of the last successful OCI Repository sync.",
      conditions | optional | Array {
        lastTransitionTime | String | doc m%"
lastTransitionTime is the last time the condition transitioned from one status to another.
This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
"%,
        message | String | doc m%"
message is a human readable message indicating details about the transition.
This may be an empty string.
"%,
        observedGeneration | optional | Number | doc m%"
observedGeneration represents the .metadata.generation that the condition was set based upon.
For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
with respect to the current state of the instance.
"%,
        reason | String | doc m%"
reason contains a programmatic identifier indicating the reason for the condition's last transition.
Producers of specific condition types may define expected values and meanings for this field,
and whether the values are considered a guaranteed API.
The value should be a CamelCase string.
This field may not be empty.
"%,
        status | String | doc "status of the condition, one of True, False, Unknown.",
        type | String | doc "type of condition in CamelCase or in foo.example.com/CamelCase.",
      } | doc "Conditions holds the conditions for the OCIRepository.",
      contentConfigChecksum | optional | String | doc m%"
ContentConfigChecksum is a checksum of all the configurations related to
the content of the source artifact:
 - .spec.ignore
 - .spec.layerSelector
observed in .status.observedGeneration version of the object. This can
be used to determine if the content configuration has changed and the
artifact needs to be rebuilt.
It has the format of `<algo>:<checksum>`, for example: `sha256:<checksum>`.

Deprecated: Replaced with explicit fields for observed artifact content
config in the status.
"%,
      lastHandledReconcileAt | optional | String | doc m%"
LastHandledReconcileAt holds the value of the most recent
reconcile request value, so a change of the annotation value
can be detected.
"%,
      observedGeneration | optional | Number | doc "ObservedGeneration is the last observed generation.",
      observedIgnore | optional | String | doc m%"
ObservedIgnore is the observed exclusion patterns used for constructing
the source artifact.
"%,
      observedLayerSelector | optional | {
        mediaType | optional | String | doc m%"
MediaType specifies the OCI media type of the layer
which should be extracted from the OCI Artifact. The
first layer matching this type is selected.
"%,
        operation | optional | String | doc m%"
Operation specifies how the selected layer should be processed.
By default, the layer compressed content is extracted to storage.
When the operation is set to 'copy', the layer compressed content
is persisted to storage as it is.
"%,
      } | doc m%"
ObservedLayerSelector is the observed layer selector used for constructing
the source artifact.
"%,
      url | optional | String | doc m%"
URL is the download link for the artifact output of the last OCI Repository sync.
"%,
    } | doc "OCIRepositoryStatus defines the observed state of OCIRepository" | default = {
      observedGeneration = -1
    },
  },
}
