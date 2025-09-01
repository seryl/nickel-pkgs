# Module: verificationpolicy.tekton.dev

let k8s_io_objectmeta = import "k8s_io" in

{
  VerificationPolicy = {
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
      authorities | Array {
        key | optional | {
          data | optional | String | doc "Data contains the inline public key.",
          hashAlgorithm | optional | String | doc m%"
HashAlgorithm always defaults to sha256 if the algorithm hasn't been explicitly set
"%,
          kms | optional | String | doc m%"
KMS contains the KMS url of the public key
Supported formats differ based on the KMS system used.
One example of a KMS url could be:
gcpkms://projects/[PROJECT]/locations/[LOCATION]>/keyRings/[KEYRING]/cryptoKeys/[KEY]/cryptoKeyVersions/[KEY_VERSION]
For more examples please refer https://docs.sigstore.dev/cosign/kms_support.
Note that the KMS is not supported yet.
"%,
          secretRef | optional | {
            name | optional | String | doc "name is unique within a namespace to reference a secret resource.",
            namespace | optional | String | doc "namespace defines the space within which the secret name must be unique.",
          } | doc "SecretRef sets a reference to a secret with the key.",
        } | doc "Key contains the public key to validate the resource.",
        name | String | doc "Name is the name for this authority.",
      } | doc "Authorities defines the rules for validating signatures.",
      mode | optional | String | doc m%"
Mode controls whether a failing policy will fail the taskrun/pipelinerun, or only log the warnings
enforce - fail the taskrun/pipelinerun if verification fails (default)
warn - don't fail the taskrun/pipelinerun if verification fails but log warnings
"%,
      resources | Array {
        pattern | String | doc m%"
Pattern defines a resource pattern. Regex is created to filter resources based on `Pattern`
Example patterns:
GitHub resource: https://github.com/tektoncd/catalog.git, https://github.com/tektoncd/*
Bundle resource: gcr.io/tekton-releases/catalog/upstream/git-clone, gcr.io/tekton-releases/catalog/upstream/*
Hub resource: https://artifacthub.io/*,
"%,
      } | doc m%"
Resources defines the patterns of resources sources that should be subject to this policy.
For example, we may want to apply this Policy from a certain GitHub repo.
Then the ResourcesPattern should be valid regex. E.g. If using gitresolver, and we want to config keys from a certain git repo.
`ResourcesPattern` can be `https://github.com/tektoncd/catalog.git`, we will use regex to filter out those resources.
"%,
    } | doc "Spec holds the desired state of the VerificationPolicy.",
  },
}
