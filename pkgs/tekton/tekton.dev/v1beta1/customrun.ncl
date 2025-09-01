# Module: customrun.tekton.dev

let k8s_io_objectmeta = import "k8s_io" in

{
  CustomRun = {
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
      customRef | optional | {
        apiVersion | optional | String | doc m%"
API version of the referent
Note: A Task with non-empty APIVersion and Kind is considered a Custom Task
"%,
        bundle | optional | String | doc m%"
Bundle url reference to a Tekton Bundle.

Deprecated: Please use ResolverRef with the bundles resolver instead.
The field is staying there for go client backward compatibility, but is not used/allowed anymore.
"%,
        kind | optional | String | doc m%"
TaskKind indicates the Kind of the Task:
1. Namespaced Task when Kind is set to "Task". If Kind is "", it defaults to "Task".
2. Custom Task when Kind is non-empty and APIVersion is non-empty
"%,
        name | optional | String | doc m%"
Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
"%,
        params | optional | Array {
          name | String,
          value | Dyn,
        } | doc m%"
Params contains the parameters used to identify the
referenced Tekton resource. Example entries might include
"repo" or "path" but the set of params ultimately depends on
the chosen resolver.
"%,
        resolver | optional | String | doc m%"
Resolver is the name of the resolver that should perform
resolution of the referenced Tekton resource, such as "git".
"%,
      } | doc "TaskRef can be used to refer to a specific instance of a task.",
      customSpec | optional | {
        apiVersion | optional | String,
        kind | optional | String,
        metadata | optional | {
          annotations | optional | {
          },
          labels | optional | {
          },
        } | doc "PipelineTaskMetadata contains the labels or annotations for an EmbeddedTask",
        spec | optional | {
        } | doc "Spec is a specification of a custom task",
      } | doc "Spec is a specification of a custom task",
      params | optional | Array {
        name | String,
        value | Dyn,
      } | doc "Params is a list of Param",
      retries | optional | Number | doc "Used for propagating retries count to custom tasks",
      serviceAccountName | optional | String,
      status | optional | String | doc "Used for cancelling a customrun (and maybe more later on)",
      statusMessage | optional | String | doc "Status message for cancellation.",
      timeout | optional | String | doc m%"
Time after which the custom-task times out.
Refer Go's ParseDuration documentation for expected format: https://golang.org/pkg/time/#ParseDuration
"%,
      workspaces | optional | Array {
        configMap | optional | {
          defaultMode | optional | Number | doc m%"
defaultMode is optional: mode bits used to set permissions on created files by default.
Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
Defaults to 0644.
Directories within the path are not affected by this setting.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
          items | optional | Array {
            key | String | doc "key is the key to project.",
            mode | optional | Number | doc m%"
mode is Optional: mode bits used to set permissions on this file.
Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
If not specified, the volume defaultMode will be used.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
            path | String | doc m%"
path is the relative path of the file to map the key to.
May not be an absolute path.
May not contain the path element '..'.
May not start with the string '..'.
"%,
          } | doc m%"
items if unspecified, each key-value pair in the Data field of the referenced
ConfigMap will be projected into the volume as a file whose name is the
key and content is the value. If specified, the listed keys will be
projected into the specified paths, and unlisted keys will not be
present. If a key is specified which is not present in the ConfigMap,
the volume setup will error unless it is marked optional. Paths must be
relative and may not contain the '..' path or start with '..'.
"%,
          name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          optional | optional | Bool | doc "optional specify whether the ConfigMap or its keys must be defined",
        } | doc "ConfigMap represents a configMap that should populate this workspace.",
        csi | optional | {
          driver | String | doc m%"
driver is the name of the CSI driver that handles this volume.
Consult with your admin for the correct name as registered in the cluster.
"%,
          fsType | optional | String | doc m%"
fsType to mount. Ex. "ext4", "xfs", "ntfs".
If not provided, the empty value is passed to the associated CSI driver
which will determine the default filesystem to apply.
"%,
          nodePublishSecretRef | optional | {
            name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
          } | doc m%"
nodePublishSecretRef is a reference to the secret object containing
sensitive information to pass to the CSI driver to complete the CSI
NodePublishVolume and NodeUnpublishVolume calls.
This field is optional, and  may be empty if no secret is required. If the
secret object contains more than one secret, all secret references are passed.
"%,
          readOnly | optional | Bool | doc m%"
readOnly specifies a read-only configuration for the volume.
Defaults to false (read/write).
"%,
          volumeAttributes | optional | {
          } | doc m%"
volumeAttributes stores driver-specific properties that are passed to the CSI
driver. Consult your driver's documentation for supported values.
"%,
        } | doc m%"
CSI (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers.
"%,
        emptyDir | optional | {
          medium | optional | String | doc m%"
medium represents what type of storage medium should back this directory.
The default is "" which means to use the node's default medium.
Must be an empty string (default) or Memory.
More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
"%,
          sizeLimit | optional | Number | String | doc m%"
sizeLimit is the total amount of local storage required for this EmptyDir volume.
The size limit is also applicable for memory medium.
The maximum usage on memory medium EmptyDir would be the minimum value between
the SizeLimit specified here and the sum of memory limits of all containers in a pod.
The default is nil which means that the limit is undefined.
More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
"%,
        } | doc m%"
EmptyDir represents a temporary directory that shares a Task's lifetime.
More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
Either this OR PersistentVolumeClaim can be used.
"%,
        name | String | doc "Name is the name of the workspace populated by the volume.",
        persistentVolumeClaim | optional | {
          claimName | String | doc m%"
claimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume.
More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
"%,
          readOnly | optional | Bool | doc m%"
readOnly Will force the ReadOnly setting in VolumeMounts.
Default false.
"%,
        } | doc m%"
PersistentVolumeClaimVolumeSource represents a reference to a
PersistentVolumeClaim in the same namespace. Either this OR EmptyDir can be used.
"%,
        projected | optional | {
          defaultMode | optional | Number | doc m%"
defaultMode are the mode bits used to set permissions on created files by default.
Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
Directories within the path are not affected by this setting.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
          sources | optional | Array {
            clusterTrustBundle | optional | {
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
Select all ClusterTrustBundles that match this label selector.  Only has
effect if signerName is set.  Mutually-exclusive with name.  If unset,
interpreted as "match nothing".  If set but empty, interpreted as "match
everything".
"%,
              name | optional | String | doc m%"
Select a single ClusterTrustBundle by object name.  Mutually-exclusive
with signerName and labelSelector.
"%,
              optional | optional | Bool | doc m%"
If true, don't block pod startup if the referenced ClusterTrustBundle(s)
aren't available.  If using name, then the named ClusterTrustBundle is
allowed not to exist.  If using signerName, then the combination of
signerName and labelSelector is allowed to match zero
ClusterTrustBundles.
"%,
              path | String | doc "Relative path from the volume root to write the bundle.",
              signerName | optional | String | doc m%"
Select all ClusterTrustBundles that match this signer name.
Mutually-exclusive with name.  The contents of all selected
ClusterTrustBundles will be unified and deduplicated.
"%,
            } | doc m%"
ClusterTrustBundle allows a pod to access the `.spec.trustBundle` field
of ClusterTrustBundle objects in an auto-updating file.

Alpha, gated by the ClusterTrustBundleProjection feature gate.

ClusterTrustBundle objects can either be selected by name, or by the
combination of signer name and a label selector.

Kubelet performs aggressive normalization of the PEM contents written
into the pod filesystem.  Esoteric PEM features such as inter-block
comments and block headers are stripped.  Certificates are deduplicated.
The ordering of certificates within the file is arbitrary, and Kubelet
may change the order over time.
"%,
            configMap | optional | {
              items | optional | Array {
                key | String | doc "key is the key to project.",
                mode | optional | Number | doc m%"
mode is Optional: mode bits used to set permissions on this file.
Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
If not specified, the volume defaultMode will be used.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
                path | String | doc m%"
path is the relative path of the file to map the key to.
May not be an absolute path.
May not contain the path element '..'.
May not start with the string '..'.
"%,
              } | doc m%"
items if unspecified, each key-value pair in the Data field of the referenced
ConfigMap will be projected into the volume as a file whose name is the
key and content is the value. If specified, the listed keys will be
projected into the specified paths, and unlisted keys will not be
present. If a key is specified which is not present in the ConfigMap,
the volume setup will error unless it is marked optional. Paths must be
relative and may not contain the '..' path or start with '..'.
"%,
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "optional specify whether the ConfigMap or its keys must be defined",
            } | doc "configMap information about the configMap data to project",
            downwardAPI | optional | {
              items | optional | Array {
                fieldRef | optional | {
                  apiVersion | optional | String | doc "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".",
                  fieldPath | String | doc "Path of the field to select in the specified API version.",
                } | doc m%"
Required: Selects a field of the pod: only annotations, labels, name, namespace and uid are supported.
"%,
                mode | optional | Number | doc m%"
Optional: mode bits used to set permissions on this file, must be an octal value
between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
If not specified, the volume defaultMode will be used.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
                path | String | doc m%"
Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'
"%,
                resourceFieldRef | optional | {
                  containerName | optional | String | doc "Container name: required for volumes, optional for env vars",
                  divisor | optional | Number | String | doc "Specifies the output format of the exposed resources, defaults to \"1\"",
                  resource | String | doc "Required: resource to select",
                } | doc m%"
Selects a resource of the container: only resources limits and requests
(limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported.
"%,
              } | doc "Items is a list of DownwardAPIVolume file",
            } | doc "downwardAPI information about the downwardAPI data to project",
            secret | optional | {
              items | optional | Array {
                key | String | doc "key is the key to project.",
                mode | optional | Number | doc m%"
mode is Optional: mode bits used to set permissions on this file.
Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
If not specified, the volume defaultMode will be used.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
                path | String | doc m%"
path is the relative path of the file to map the key to.
May not be an absolute path.
May not contain the path element '..'.
May not start with the string '..'.
"%,
              } | doc m%"
items if unspecified, each key-value pair in the Data field of the referenced
Secret will be projected into the volume as a file whose name is the
key and content is the value. If specified, the listed keys will be
projected into the specified paths, and unlisted keys will not be
present. If a key is specified which is not present in the Secret,
the volume setup will error unless it is marked optional. Paths must be
relative and may not contain the '..' path or start with '..'.
"%,
              name | String | doc m%"
Name of the referent.
This field is effectively required, but due to backwards compatibility is
allowed to be empty. Instances of this type with an empty value here are
almost certainly wrong.
More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
"% | default = "",
              optional | optional | Bool | doc "optional field specify whether the Secret or its key must be defined",
            } | doc "secret information about the secret data to project",
            serviceAccountToken | optional | {
              audience | optional | String | doc m%"
audience is the intended audience of the token. A recipient of a token
must identify itself with an identifier specified in the audience of the
token, and otherwise should reject the token. The audience defaults to the
identifier of the apiserver.
"%,
              expirationSeconds | optional | Number | doc m%"
expirationSeconds is the requested duration of validity of the service
account token. As the token approaches expiration, the kubelet volume
plugin will proactively rotate the service account token. The kubelet will
start trying to rotate the token if the token is older than 80 percent of
its time to live or if the token is older than 24 hours.Defaults to 1 hour
and must be at least 10 minutes.
"%,
              path | String | doc m%"
path is the path relative to the mount point of the file to project the
token into.
"%,
            } | doc "serviceAccountToken is information about the serviceAccountToken data to project",
          } | doc m%"
sources is the list of volume projections. Each entry in this list
handles one source.
"%,
        } | doc "Projected represents a projected volume that should populate this workspace.",
        secret | optional | {
          defaultMode | optional | Number | doc m%"
defaultMode is Optional: mode bits used to set permissions on created files by default.
Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values
for mode bits. Defaults to 0644.
Directories within the path are not affected by this setting.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
          items | optional | Array {
            key | String | doc "key is the key to project.",
            mode | optional | Number | doc m%"
mode is Optional: mode bits used to set permissions on this file.
Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511.
YAML accepts both octal and decimal values, JSON requires decimal values for mode bits.
If not specified, the volume defaultMode will be used.
This might be in conflict with other options that affect the file
mode, like fsGroup, and the result can be other mode bits set.
"%,
            path | String | doc m%"
path is the relative path of the file to map the key to.
May not be an absolute path.
May not contain the path element '..'.
May not start with the string '..'.
"%,
          } | doc m%"
items If unspecified, each key-value pair in the Data field of the referenced
Secret will be projected into the volume as a file whose name is the
key and content is the value. If specified, the listed keys will be
projected into the specified paths, and unlisted keys will not be
present. If a key is specified which is not present in the Secret,
the volume setup will error unless it is marked optional. Paths must be
relative and may not contain the '..' path or start with '..'.
"%,
          optional | optional | Bool | doc "optional field specify whether the Secret or its keys must be defined",
          secretName | optional | String | doc m%"
secretName is the name of the secret in the pod's namespace to use.
More info: https://kubernetes.io/docs/concepts/storage/volumes#secret
"%,
        } | doc "Secret represents a secret that should populate this workspace.",
        subPath | optional | String | doc m%"
SubPath is optionally a directory on the volume which should be used
for this binding (i.e. the volume will be mounted at this sub directory).
"%,
        volumeClaimTemplate | optional | Dyn | doc m%"
VolumeClaimTemplate is a template for a claim that will be created in the same namespace.
The PipelineRun controller is responsible for creating a unique claim for each instance of PipelineRun.
See PersistentVolumeClaim (API version: v1)
"%,
      } | doc "Workspaces is a list of WorkspaceBindings from volumes to workspaces.",
    } | doc "CustomRunSpec defines the desired state of CustomRun",
    status | optional | {
      annotations | optional | {
      } | doc m%"
Annotations is additional Status fields for the Resource to save some
additional State as well as convey more information to the user. This is
roughly akin to Annotations on any k8s resource, just the reconciler conveying
richer information outwards.
"%,
      completionTime | optional | String | doc "CompletionTime is the time the build completed.",
      conditions | optional | Array {
        lastTransitionTime | optional | String | doc m%"
LastTransitionTime is the last time the condition transitioned from one status to another.
We use VolatileTime in place of metav1.Time to exclude this from creating equality.Semantic
differences (all other things held constant).
"%,
        message | optional | String | doc "A human readable message indicating details about the transition.",
        reason | optional | String | doc "The reason for the condition's last transition.",
        severity | optional | String | doc m%"
Severity with which to treat failures of this type of condition.
When this is not specified, it defaults to Error.
"%,
        status | String | doc "Status of the condition, one of True, False, Unknown.",
        type | String | doc "Type of condition.",
      } | doc "Conditions the latest available observations of a resource's current state.",
      extraFields | optional | Dyn | doc m%"
ExtraFields holds arbitrary fields provided by the custom task
controller.
"%,
      observedGeneration | optional | Number | doc m%"
ObservedGeneration is the 'Generation' of the Service that
was last processed by the controller.
"%,
      results | optional | Array {
        name | String | doc "Name the given name",
        value | String | doc "Value the given value of the result",
      } | doc m%"
Results reports any output result values to be consumed by later
tasks in a pipeline.
"%,
      retriesStatus | optional | Dyn | doc m%"
RetriesStatus contains the history of CustomRunStatus, in case of a retry.
See CustomRun.status (API version: tekton.dev/v1beta1)
"%,
      startTime | optional | String | doc "StartTime is the time the build is actually started.",
    } | doc "CustomRunStatus defines the observed state of CustomRun",
  },
}
