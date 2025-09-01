# Module: gitrepository.source.toolkit.fluxcd.io

let k8s_io_objectmeta = import "k8s_io" in

{
  GitRepository = {
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
      accessFrom | optional | {
        namespaceSelectors | Array {
          matchLabels | optional | {
          } | doc m%"
MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels
map is equivalent to an element of matchExpressions, whose key field is "key", the
operator is "In", and the values array contains only "value". The requirements are ANDed.
"%,
        } | doc m%"
NamespaceSelectors is the list of namespace selectors to which this ACL applies.
Items in this list are evaluated using a logical OR operation.
"%,
      } | doc m%"
AccessFrom specifies an Access Control List for allowing cross-namespace
references to this object.
NOTE: Not implemented, provisional as of https://github.com/fluxcd/flux2/pull/2092
"%,
      gitImplementation | String | doc m%"
GitImplementation specifies which Git client library implementation to
use. Defaults to 'go-git', valid values are ('go-git', 'libgit2').
Deprecated: gitImplementation is deprecated now that 'go-git' is the
only supported implementation.
"% | default = "go-git",
      ignore | optional | String | doc m%"
Ignore overrides the set of excluded patterns in the .sourceignore format
(which is the same as .gitignore). If not provided, a default will be used,
consult the documentation for your version to find out what those are.
"%,
      include | optional | Array {
        fromPath | optional | String | doc m%"
FromPath specifies the path to copy contents from, defaults to the root
of the Artifact.
"%,
        repository | {
          name | String | doc "Name of the referent.",
        } | doc m%"
GitRepositoryRef specifies the GitRepository which Artifact contents
must be included.
"%,
        toPath | optional | String | doc m%"
ToPath specifies the path to copy contents to, defaults to the name of
the GitRepositoryRef.
"%,
      } | doc m%"
Include specifies a list of GitRepository resources which Artifacts
should be included in the Artifact produced for this GitRepository.
"%,
      interval | String | doc "Interval at which to check the GitRepository for updates.",
      recurseSubmodules | optional | Bool | doc m%"
RecurseSubmodules enables the initialization of all submodules within
the GitRepository as cloned from the URL, using their default settings.
"%,
      ref | optional | {
        branch | optional | String | doc "Branch to check out, defaults to 'master' if no other field is defined.",
        commit | optional | String | doc m%"
Commit SHA to check out, takes precedence over all reference fields.

This can be combined with Branch to shallow clone the branch, in which
the commit is expected to exist.
"%,
        name | optional | String | doc m%"
Name of the reference to check out; takes precedence over Branch, Tag and SemVer.

It must be a valid Git reference: https://git-scm.com/docs/git-check-ref-format#_description
Examples: "refs/heads/main", "refs/tags/v0.1.0", "refs/pull/420/head", "refs/merge-requests/1/head"
"%,
        semver | optional | String | doc "SemVer tag expression to check out, takes precedence over Tag.",
        tag | optional | String | doc "Tag to check out, takes precedence over Branch.",
      } | doc m%"
Reference specifies the Git reference to resolve and monitor for
changes, defaults to the 'master' branch.
"%,
      secretRef | optional | {
        name | String | doc "Name of the referent.",
      } | doc m%"
SecretRef specifies the Secret containing authentication credentials for
the GitRepository.
For HTTPS repositories the Secret must contain 'username' and 'password'
fields for basic auth or 'bearerToken' field for token auth.
For SSH repositories the Secret must contain 'identity'
and 'known_hosts' fields.
"%,
      suspend | optional | Bool | doc m%"
Suspend tells the controller to suspend the reconciliation of this
GitRepository.
"%,
      timeout | String | doc "Timeout for Git operations like cloning, defaults to 60s." | default = "60s",
      url | String | doc "URL specifies the Git repository URL, it can be an HTTP/S or SSH address.",
      verify | optional | {
        mode | String | doc "Mode specifies what Git object should be verified, currently ('head').",
        secretRef | {
          name | String | doc "Name of the referent.",
        } | doc m%"
SecretRef specifies the Secret containing the public keys of trusted Git
authors.
"%,
      } | doc m%"
Verification specifies the configuration to verify the Git commit
signature(s).
"%,
    } | doc m%"
GitRepositorySpec specifies the required configuration to produce an
Artifact for a Git repository.
"%,
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
      } | doc "Artifact represents the last successful GitRepository reconciliation.",
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
      } | doc "Conditions holds the conditions for the GitRepository.",
      contentConfigChecksum | optional | String | doc m%"
ContentConfigChecksum is a checksum of all the configurations related to
the content of the source artifact:
 - .spec.ignore
 - .spec.recurseSubmodules
 - .spec.included and the checksum of the included artifacts
observed in .status.observedGeneration version of the object. This can
be used to determine if the content of the included repository has
changed.
It has the format of `<algo>:<checksum>`, for example: `sha256:<checksum>`.

Deprecated: Replaced with explicit fields for observed artifact content
config in the status.
"%,
      includedArtifacts | optional | Array {
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
      } | doc m%"
IncludedArtifacts contains a list of the last successfully included
Artifacts as instructed by GitRepositorySpec.Include.
"%,
      lastHandledReconcileAt | optional | String | doc m%"
LastHandledReconcileAt holds the value of the most recent
reconcile request value, so a change of the annotation value
can be detected.
"%,
      observedGeneration | optional | Number | doc m%"
ObservedGeneration is the last observed generation of the GitRepository
object.
"%,
      observedIgnore | optional | String | doc m%"
ObservedIgnore is the observed exclusion patterns used for constructing
the source artifact.
"%,
      observedInclude | optional | Array {
        fromPath | optional | String | doc m%"
FromPath specifies the path to copy contents from, defaults to the root
of the Artifact.
"%,
        repository | {
          name | String | doc "Name of the referent.",
        } | doc m%"
GitRepositoryRef specifies the GitRepository which Artifact contents
must be included.
"%,
        toPath | optional | String | doc m%"
ToPath specifies the path to copy contents to, defaults to the name of
the GitRepositoryRef.
"%,
      } | doc m%"
ObservedInclude is the observed list of GitRepository resources used to
to produce the current Artifact.
"%,
      observedRecurseSubmodules | optional | Bool | doc m%"
ObservedRecurseSubmodules is the observed resource submodules
configuration used to produce the current Artifact.
"%,
      url | optional | String | doc m%"
URL is the dynamic fetch link for the latest Artifact.
It is provided on a "best effort" basis, and using the precise
GitRepositoryStatus.Artifact data is recommended.
"%,
    } | doc "GitRepositoryStatus records the observed state of a Git repository." | default = {
      observedGeneration = -1
    },
  },
}
