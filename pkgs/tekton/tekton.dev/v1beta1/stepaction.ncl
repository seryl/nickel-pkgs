# Module: stepaction.tekton.dev

let k8s_io_objectmeta = import "k8s_io" in
let k8s_io_volumemount = import "k8s_io" in
let k8s_io_envvar = import "k8s_io" in

{
  StepAction = {
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
      args | optional | Array String | doc m%"
Arguments to the entrypoint.
The image's CMD is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the container's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
      command | optional | Array String | doc m%"
Entrypoint array. Not executed within a shell.
The image's ENTRYPOINT is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the container's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
      description | optional | String | doc m%"
Description is a user-facing description of the stepaction that may be
used to populate a UI.
"%,
      env | optional | Array k8s_io_objectmeta.EnvVar | doc m%"
List of environment variables to set in the container.
Cannot be updated.
"%,
      image | optional | String | doc m%"
Image reference name to run for this StepAction.
More info: https://kubernetes.io/docs/concepts/containers/images
"%,
      params | optional | Array {
        "default" | optional | Dyn | doc m%"
Default is the value a parameter takes if no input value is supplied. If
default is set, a Task may be executed without a supplied value for the
parameter.
"%,
        description | optional | String | doc m%"
Description is a user-facing description of the parameter that may be
used to populate a UI.
"%,
        enum | optional | Array String | doc m%"
Enum declares a set of allowed param input values for tasks/pipelines that can be validated.
If Enum is not set, no input validation is performed for the param.
"%,
        name | String | doc "Name declares the name by which a parameter is referenced.",
        properties | optional | {
        } | doc "Properties is the JSON Schema properties to support key-value pairs parameter.",
        type | optional | String | doc m%"
Type is the user-specified type of the parameter. The possible types
are currently "string", "array" and "object", and "string" is the default.
"%,
      } | doc m%"
Params is a list of input parameters required to run the stepAction.
Params must be supplied as inputs in Steps unless they declare a defaultvalue.
"%,
      results | optional | Array {
        description | optional | String | doc "Description is a human-readable description of the result",
        name | String | doc "Name the given name",
        properties | optional | {
        } | doc "Properties is the JSON Schema properties to support key-value pairs results.",
        type | optional | String | doc m%"
The possible types are 'string', 'array', and 'object', with 'string' as the default.
"%,
      } | doc "Results are values that this StepAction can output",
      script | optional | String | doc m%"
Script is the contents of an executable file to execute.

If Script is not empty, the Step cannot have an Command and the Args will be passed to the Script.
"%,
      securityContext | optional | {
        allowPrivilegeEscalation | optional | Bool | doc m%"
AllowPrivilegeEscalation controls whether a process can gain more
privileges than its parent process. This bool directly controls if
the no_new_privs flag will be set on the container process.
AllowPrivilegeEscalation is true always when the container is:
1) run as Privileged
2) has CAP_SYS_ADMIN
Note that this field cannot be set when spec.os.name is windows.
"%,
        appArmorProfile | optional | {
          localhostProfile | optional | String | doc m%"
localhostProfile indicates a profile loaded on the node that should be used.
The profile must be preconfigured on the node to work.
Must match the loaded name of the profile.
Must be set if and only if type is "Localhost".
"%,
          type | String | doc m%"
type indicates which kind of AppArmor profile will be applied.
Valid options are:
  Localhost - a profile pre-loaded on the node.
  RuntimeDefault - the container runtime's default profile.
  Unconfined - no AppArmor enforcement.
"%,
        } | doc m%"
appArmorProfile is the AppArmor options to use by this container. If set, this profile
overrides the pod's appArmorProfile.
Note that this field cannot be set when spec.os.name is windows.
"%,
        capabilities | optional | {
          add | optional | Array String | doc "Added capabilities",
          drop | optional | Array String | doc "Removed capabilities",
        } | doc m%"
The capabilities to add/drop when running containers.
Defaults to the default set of capabilities granted by the container runtime.
Note that this field cannot be set when spec.os.name is windows.
"%,
        privileged | optional | Bool | doc m%"
Run container in privileged mode.
Processes in privileged containers are essentially equivalent to root on the host.
Defaults to false.
Note that this field cannot be set when spec.os.name is windows.
"%,
        procMount | optional | String | doc m%"
procMount denotes the type of proc mount to use for the containers.
The default value is Default which uses the container runtime defaults for
readonly paths and masked paths.
This requires the ProcMountType feature flag to be enabled.
Note that this field cannot be set when spec.os.name is windows.
"%,
        readOnlyRootFilesystem | optional | Bool | doc m%"
Whether this container has a read-only root filesystem.
Default is false.
Note that this field cannot be set when spec.os.name is windows.
"%,
        runAsGroup | optional | Number | doc m%"
The GID to run the entrypoint of the container process.
Uses runtime default if unset.
May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is windows.
"%,
        runAsNonRoot | optional | Bool | doc m%"
Indicates that the container must run as a non-root user.
If true, the Kubelet will validate the image at runtime to ensure that it
does not run as UID 0 (root) and fail to start the container if it does.
If unset or false, no such validation will be performed.
May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
"%,
        runAsUser | optional | Number | doc m%"
The UID to run the entrypoint of the container process.
Defaults to user specified in image metadata if unspecified.
May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is windows.
"%,
        seLinuxOptions | optional | {
          level | optional | String | doc "Level is SELinux level label that applies to the container.",
          role | optional | String | doc "Role is a SELinux role label that applies to the container.",
          type | optional | String | doc "Type is a SELinux type label that applies to the container.",
          user | optional | String | doc "User is a SELinux user label that applies to the container.",
        } | doc m%"
The SELinux context to be applied to the container.
If unspecified, the container runtime will allocate a random SELinux context for each
container.  May also be set in PodSecurityContext.  If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
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
The seccomp options to use by this container. If seccomp options are
provided at both the pod & container level, the container options
override the pod options.
Note that this field cannot be set when spec.os.name is windows.
"%,
        windowsOptions | optional | {
          gmsaCredentialSpec | optional | String | doc m%"
GMSACredentialSpec is where the GMSA admission webhook
(https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the
GMSA credential spec named by the GMSACredentialSpecName field.
"%,
          gmsaCredentialSpecName | optional | String | doc "GMSACredentialSpecName is the name of the GMSA credential spec to use.",
          hostProcess | optional | Bool | doc m%"
HostProcess determines if a container should be run as a 'Host Process' container.
All of a Pod's containers must have the same effective HostProcess value
(it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).
In addition, if HostProcess is true then HostNetwork must also be set to true.
"%,
          runAsUserName | optional | String | doc m%"
The UserName in Windows to run the entrypoint of the container process.
Defaults to the user specified in image metadata if unspecified.
May also be set in PodSecurityContext. If set in both SecurityContext and
PodSecurityContext, the value specified in SecurityContext takes precedence.
"%,
        } | doc m%"
The Windows specific settings applied to all containers.
If unspecified, the options from the PodSecurityContext will be used.
If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
Note that this field cannot be set when spec.os.name is linux.
"%,
      } | doc m%"
SecurityContext defines the security options the Step should be run with.
If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.
More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
The value set in StepAction will take precedence over the value from Task.
"%,
      volumeMounts | optional | Array k8s_io_objectmeta.VolumeMount | doc m%"
Volumes to mount into the Step's filesystem.
Cannot be updated.
"%,
      workingDir | optional | String | doc m%"
Step's working directory.
If not specified, the container runtime's default will be used, which
might be configured in the container image.
Cannot be updated.
"%,
    } | doc "Spec holds the desired state of the Step from the client",
  },
}
