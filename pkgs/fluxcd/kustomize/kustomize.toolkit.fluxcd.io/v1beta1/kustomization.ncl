# Module: kustomization.kustomize.toolkit.fluxcd.io

let k8s_io_objectmeta = import "k8s_io" in

{
  Kustomization = {
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
      decryption | optional | {
        provider | String | doc "Provider is the name of the decryption engine.",
        secretRef | optional | {
          name | String | doc "Name of the referent.",
        } | doc "The secret name containing the private OpenPGP keys used for decryption.",
      } | doc "Decrypt Kubernetes secrets before applying them on the cluster.",
      dependsOn | optional | Array {
        name | String | doc "Name of the referent.",
        namespace | optional | String | doc "Namespace of the referent, when not specified it acts as LocalObjectReference.",
      } | doc m%"
DependsOn may contain a meta.NamespacedObjectReference slice
with references to Kustomization resources that must be ready before this
Kustomization can be reconciled.
"%,
      "force" | Bool | doc m%"
Force instructs the controller to recreate resources
when patching fails due to an immutable field change.
"% | default = false,
      healthChecks | optional | Array {
        apiVersion | optional | String | doc m%"
API version of the referent, if not specified the Kubernetes preferred version will be used.
"%,
        kind | String | doc "Kind of the referent.",
        name | String | doc "Name of the referent.",
        namespace | optional | String | doc "Namespace of the referent, when not specified it acts as LocalObjectReference.",
      } | doc "A list of resources to be included in the health assessment.",
      images | optional | Array {
        digest | optional | String | doc m%"
Digest is the value used to replace the original image tag.
If digest is present NewTag value is ignored.
"%,
        name | String | doc "Name is a tag-less image name.",
        newName | optional | String | doc "NewName is the value used to replace the original name.",
        newTag | optional | String | doc "NewTag is the value used to replace the original tag.",
      } | doc m%"
Images is a list of (image name, new name, new tag or digest)
for changing image names, tags or digests. This can also be achieved with a
patch, but this operator is simpler to specify.
"%,
      interval | String | doc "The interval at which to reconcile the Kustomization.",
      kubeConfig | optional | {
        secretRef | {
          name | String | doc "Name of the referent.",
        } | doc m%"
SecretRef holds the name to a secret that contains a 'value' key with
the kubeconfig file as the value. It must be in the same namespace as
the Kustomization.
It is recommended that the kubeconfig is self-contained, and the secret
is regularly updated if credentials such as a cloud-access-token expire.
Cloud specific `cmd-path` auth helpers will not function without adding
binaries and credentials to the Pod that is responsible for reconciling
the Kustomization.
"%,
      } | doc m%"
The KubeConfig for reconciling the Kustomization on a remote cluster.
When specified, KubeConfig takes precedence over ServiceAccountName.
"%,
      patches | optional | Array {
        patch | String | doc m%"
Patch contains an inline StrategicMerge patch or an inline JSON6902 patch with
an array of operation objects.
"%,
        target | optional | {
          annotationSelector | optional | String | doc m%"
AnnotationSelector is a string that follows the label selection expression
https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api
It matches with the resource annotations.
"%,
          group | optional | String | doc m%"
Group is the API group to select resources from.
Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources.
https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md
"%,
          kind | optional | String | doc m%"
Kind of the API Group to select resources from.
Together with Group and Version it is capable of unambiguously
identifying and/or selecting resources.
https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md
"%,
          labelSelector | optional | String | doc m%"
LabelSelector is a string that follows the label selection expression
https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api
It matches with the resource labels.
"%,
          name | optional | String | doc "Name to match resources with.",
          namespace | optional | String | doc "Namespace to select resources from.",
          version | optional | String | doc m%"
Version of the API Group to select resources from.
Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources.
https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md
"%,
        } | doc "Target points to the resources that the patch document should be applied to.",
      } | doc m%"
Strategic merge and JSON patches, defined as inline YAML objects,
capable of targeting objects based on kind, label and annotation selectors.
"%,
      patchesJson6902 | optional | Array {
        patch | Array {
          from | optional | String | doc m%"
From contains a JSON-pointer value that references a location within the target document where the operation is
performed. The meaning of the value depends on the value of Op, and is NOT taken into account by all operations.
"%,
          op | String | doc m%"
Op indicates the operation to perform. Its value MUST be one of "add", "remove", "replace", "move", "copy", or
"test".
https://datatracker.ietf.org/doc/html/rfc6902#section-4
"%,
          path | String | doc m%"
Path contains the JSON-pointer value that references a location within the target document where the operation
is performed. The meaning of the value depends on the value of Op.
"%,
          value | optional | Dyn | doc m%"
Value contains a valid JSON structure. The meaning of the value depends on the value of Op, and is NOT taken into
account by all operations.
"%,
        } | doc "Patch contains the JSON6902 patch document with an array of operation objects.",
        target | {
          annotationSelector | optional | String | doc m%"
AnnotationSelector is a string that follows the label selection expression
https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api
It matches with the resource annotations.
"%,
          group | optional | String | doc m%"
Group is the API group to select resources from.
Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources.
https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md
"%,
          kind | optional | String | doc m%"
Kind of the API Group to select resources from.
Together with Group and Version it is capable of unambiguously
identifying and/or selecting resources.
https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md
"%,
          labelSelector | optional | String | doc m%"
LabelSelector is a string that follows the label selection expression
https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api
It matches with the resource labels.
"%,
          name | optional | String | doc "Name to match resources with.",
          namespace | optional | String | doc "Namespace to select resources from.",
          version | optional | String | doc m%"
Version of the API Group to select resources from.
Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources.
https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md
"%,
        } | doc "Target points to the resources that the patch document should be applied to.",
      } | doc "JSON 6902 patches, defined as inline YAML objects.",
      patchesStrategicMerge | optional | Array Dyn | doc "Strategic merge patches, defined as inline YAML objects.",
      path | optional | String | doc m%"
Path to the directory containing the kustomization.yaml file, or the
set of plain YAMLs a kustomization.yaml should be generated for.
Defaults to 'None', which translates to the root path of the SourceRef.
"%,
      postBuild | optional | {
        substitute | optional | {
        } | doc m%"
Substitute holds a map of key/value pairs.
The variables defined in your YAML manifests
that match any of the keys defined in the map
will be substituted with the set value.
Includes support for bash string replacement functions
e.g. ${var:=default}, ${var:position} and ${var/substring/replacement}.
"%,
        substituteFrom | optional | Array {
          kind | String | doc "Kind of the values referent, valid values are ('Secret', 'ConfigMap').",
          name | String | doc m%"
Name of the values referent. Should reside in the same namespace as the
referring resource.
"%,
        } | doc m%"
SubstituteFrom holds references to ConfigMaps and Secrets containing
the variables and their values to be substituted in the YAML manifests.
The ConfigMap and the Secret data keys represent the var names and they
must match the vars declared in the manifests for the substitution to happen.
"%,
      } | doc m%"
PostBuild describes which actions to perform on the YAML manifest
generated by building the kustomize overlay.
"%,
      prune | Bool | doc "Prune enables garbage collection.",
      retryInterval | optional | String | doc m%"
The interval at which to retry a previously failed reconciliation.
When not specified, the controller uses the KustomizationSpec.Interval
value to retry failures.
"%,
      serviceAccountName | optional | String | doc m%"
The name of the Kubernetes service account to impersonate
when reconciling this Kustomization.
"%,
      sourceRef | {
        apiVersion | optional | String | doc "API version of the referent",
        kind | String | doc "Kind of the referent",
        name | String | doc "Name of the referent",
        namespace | optional | String | doc "Namespace of the referent, defaults to the Kustomization namespace",
      } | doc "Reference of the source where the kustomization file is.",
      suspend | optional | Bool | doc m%"
This flag tells the controller to suspend subsequent kustomize executions,
it does not apply to already started executions. Defaults to false.
"%,
      targetNamespace | optional | String | doc m%"
TargetNamespace sets or overrides the namespace in the
kustomization.yaml file.
"%,
      timeout | optional | String | doc m%"
Timeout for validation, apply and health checking operations.
Defaults to 'Interval' duration.
"%,
      validation | optional | String | doc m%"
Validate the Kubernetes objects before applying them on the cluster.
The validation strategy can be 'client' (local dry-run), 'server'
(APIServer dry-run) or 'none'.
When 'Force' is 'true', validation will fallback to 'client' if set to
'server' because server-side validation is not supported in this scenario.
"%,
    } | doc "KustomizationSpec defines the desired state of a kustomization.",
    status | {
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
      },
      lastAppliedRevision | optional | String | doc m%"
The last successfully applied revision.
The revision format for Git sources is <branch|tag>/<commit-sha>.
"%,
      lastAttemptedRevision | optional | String | doc "LastAttemptedRevision is the revision of the last reconciliation attempt.",
      lastHandledReconcileAt | optional | String | doc m%"
LastHandledReconcileAt holds the value of the most recent
reconcile request value, so a change of the annotation value
can be detected.
"%,
      observedGeneration | optional | Number | doc "ObservedGeneration is the last reconciled generation.",
      snapshot | optional | {
        checksum | String | doc "The manifests sha1 checksum.",
        entries | Array {
          kinds | {
          } | doc "The list of Kubernetes kinds.",
          namespace | optional | String | doc "The namespace of this entry.",
        } | doc "A list of Kubernetes kinds grouped by namespace.",
      } | doc "The last successfully applied revision metadata.",
    } | doc "KustomizationStatus defines the observed state of a kustomization." | default = {
      observedGeneration = -1
    },
  },
}
