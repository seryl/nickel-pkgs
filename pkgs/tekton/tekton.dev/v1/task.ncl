# Module: task.tekton.dev

let k8s_io_envfromsource = import "k8s_io" in
let k8s_io_volumemount = import "k8s_io" in
let k8s_io_objectmeta = import "k8s_io" in
let k8s_io_envvar = import "k8s_io" in

{
  Task = {
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
    metadata | optional | k8s_io_envfromsource.ObjectMeta,
    spec | optional | {
      description | optional | String | doc m%"
Description is a user-facing description of the task that may be
used to populate a UI.
"%,
      displayName | optional | String | doc m%"
DisplayName is a user-facing name of the task that may be
used to populate a UI.
"%,
      params | optional | Array {
        default | optional | Dyn | doc m%"
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
Params is a list of input parameters required to run the task. Params
must be supplied as inputs in TaskRuns unless they declare a default
value.
"%,
      results | optional | Array {
        description | optional | String | doc "Description is a human-readable description of the result",
        name | String | doc "Name the given name",
        properties | optional | {
        } | doc "Properties is the JSON Schema properties to support key-value pairs results.",
        type | optional | String | doc m%"
Type is the user-specified type of the result. The possible type
is currently "string" and will support "array" in following work.
"%,
        value | optional | Dyn | doc m%"
Value the expression used to retrieve the value of the result from an underlying Step.
"%,
      } | doc "Results are values that this Task can output",
      sidecars | optional | Array {
        args | optional | Array String | doc m%"
Arguments to the entrypoint.
The image's CMD is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the Sidecar's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
        command | optional | Array String | doc m%"
Entrypoint array. Not executed within a shell.
The image's ENTRYPOINT is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the Sidecar's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
        computeResources | optional | {
          claims | optional | Array {
            name | String | doc m%"
Name must match the name of one entry in pod.spec.resourceClaims of
the Pod where this field is used. It makes that resource available
inside a container.
"%,
            request | optional | String | doc m%"
Request is the name chosen for a request in the referenced claim.
If empty, everything from the claim is made available, otherwise
only the result of this request.
"%,
          } | doc m%"
Claims lists the names of resources, defined in spec.resourceClaims,
that are used by this container.

This is an alpha field and requires enabling the
DynamicResourceAllocation feature gate.

This field is immutable. It can only be set for containers.
"%,
          limits | optional | {
          } | doc m%"
Limits describes the maximum amount of compute resources allowed.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
          requests | optional | {
          } | doc m%"
Requests describes the minimum amount of compute resources required.
If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
otherwise to an implementation-defined value. Requests cannot exceed Limits.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
        } | doc m%"
ComputeResources required by this Sidecar.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
        env | optional | Array k8s_io_envfromsource.EnvVar | doc m%"
List of environment variables to set in the Sidecar.
Cannot be updated.
"%,
        envFrom | optional | Array k8s_io_envfromsource.EnvFromSource | doc m%"
List of sources to populate environment variables in the Sidecar.
The keys defined within a source must be a C_IDENTIFIER. All invalid keys
will be reported as an event when the container is starting. When a key exists in multiple
sources, the value associated with the last source will take precedence.
Values defined by an Env with a duplicate key will take precedence.
Cannot be updated.
"%,
        image | optional | String | doc m%"
Image reference name.
More info: https://kubernetes.io/docs/concepts/containers/images
"%,
        imagePullPolicy | optional | String | doc m%"
Image pull policy.
One of Always, Never, IfNotPresent.
Defaults to Always if :latest tag is specified, or IfNotPresent otherwise.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/containers/images#updating-images
"%,
        lifecycle | optional | {
          postStart | optional | {
            exec | optional | {
              command | optional | Array String | doc m%"
Command is the command line to execute inside the container, the working directory for the
command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
a shell, you need to explicitly call out to that shell.
Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
"%,
            } | doc "Exec specifies a command to execute in the container.",
            httpGet | optional | {
              host | optional | String | doc m%"
Host name to connect to, defaults to the pod IP. You probably want to set
"Host" in httpHeaders instead.
"%,
              httpHeaders | optional | Array {
                name | String | doc m%"
The header field name.
This will be canonicalized upon output, so case-variant names will be understood as the same header.
"%,
                value | String | doc "The header field value",
              } | doc "Custom headers to set in the request. HTTP allows repeated headers.",
              path | optional | String | doc "Path to access on the HTTP server.",
              port | Number | String | doc m%"
Name or number of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
              scheme | optional | String | doc m%"
Scheme to use for connecting to the host.
Defaults to HTTP.
"%,
            } | doc "HTTPGet specifies an HTTP GET request to perform.",
            sleep | optional | {
              seconds | Number | doc "Seconds is the number of seconds to sleep.",
            } | doc "Sleep represents a duration that the container should sleep.",
            tcpSocket | optional | {
              host | optional | String | doc "Optional: Host name to connect to, defaults to the pod IP.",
              port | Number | String | doc m%"
Number or name of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
            } | doc m%"
Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept
for backward compatibility. There is no validation of this field and
lifecycle hooks will fail at runtime when it is specified.
"%,
          } | doc m%"
PostStart is called immediately after a container is created. If the handler fails,
the container is terminated and restarted according to its restart policy.
Other management of the container blocks until the hook completes.
More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
"%,
          preStop | optional | {
            exec | optional | {
              command | optional | Array String | doc m%"
Command is the command line to execute inside the container, the working directory for the
command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
a shell, you need to explicitly call out to that shell.
Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
"%,
            } | doc "Exec specifies a command to execute in the container.",
            httpGet | optional | {
              host | optional | String | doc m%"
Host name to connect to, defaults to the pod IP. You probably want to set
"Host" in httpHeaders instead.
"%,
              httpHeaders | optional | Array {
                name | String | doc m%"
The header field name.
This will be canonicalized upon output, so case-variant names will be understood as the same header.
"%,
                value | String | doc "The header field value",
              } | doc "Custom headers to set in the request. HTTP allows repeated headers.",
              path | optional | String | doc "Path to access on the HTTP server.",
              port | Number | String | doc m%"
Name or number of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
              scheme | optional | String | doc m%"
Scheme to use for connecting to the host.
Defaults to HTTP.
"%,
            } | doc "HTTPGet specifies an HTTP GET request to perform.",
            sleep | optional | {
              seconds | Number | doc "Seconds is the number of seconds to sleep.",
            } | doc "Sleep represents a duration that the container should sleep.",
            tcpSocket | optional | {
              host | optional | String | doc "Optional: Host name to connect to, defaults to the pod IP.",
              port | Number | String | doc m%"
Number or name of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
            } | doc m%"
Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept
for backward compatibility. There is no validation of this field and
lifecycle hooks will fail at runtime when it is specified.
"%,
          } | doc m%"
PreStop is called immediately before a container is terminated due to an
API request or management event such as liveness/startup probe failure,
preemption, resource contention, etc. The handler is not called if the
container crashes or exits. The Pod's termination grace period countdown begins before the
PreStop hook is executed. Regardless of the outcome of the handler, the
container will eventually terminate within the Pod's termination grace
period (unless delayed by finalizers). Other management of the container blocks until the hook completes
or until the termination grace period is reached.
More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
"%,
        } | doc m%"
Actions that the management system should take in response to Sidecar lifecycle events.
Cannot be updated.
"%,
        livenessProbe | optional | {
          exec | optional | {
            command | optional | Array String | doc m%"
Command is the command line to execute inside the container, the working directory for the
command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
a shell, you need to explicitly call out to that shell.
Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
"%,
          } | doc "Exec specifies a command to execute in the container.",
          failureThreshold | optional | Number | doc m%"
Minimum consecutive failures for the probe to be considered failed after having succeeded.
Defaults to 3. Minimum value is 1.
"%,
          grpc | optional | {
            port | Number | doc "Port number of the gRPC service. Number must be in the range 1 to 65535.",
            service | String | doc m%"
Service is the name of the service to place in the gRPC HealthCheckRequest
(see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).

If this is not specified, the default behavior is defined by gRPC.
"% | default = "",
          } | doc "GRPC specifies a GRPC HealthCheckRequest.",
          httpGet | optional | {
            host | optional | String | doc m%"
Host name to connect to, defaults to the pod IP. You probably want to set
"Host" in httpHeaders instead.
"%,
            httpHeaders | optional | Array {
              name | String | doc m%"
The header field name.
This will be canonicalized upon output, so case-variant names will be understood as the same header.
"%,
              value | String | doc "The header field value",
            } | doc "Custom headers to set in the request. HTTP allows repeated headers.",
            path | optional | String | doc "Path to access on the HTTP server.",
            port | Number | String | doc m%"
Name or number of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
            scheme | optional | String | doc m%"
Scheme to use for connecting to the host.
Defaults to HTTP.
"%,
          } | doc "HTTPGet specifies an HTTP GET request to perform.",
          initialDelaySeconds | optional | Number | doc m%"
Number of seconds after the container has started before liveness probes are initiated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
          periodSeconds | optional | Number | doc m%"
How often (in seconds) to perform the probe.
Default to 10 seconds. Minimum value is 1.
"%,
          successThreshold | optional | Number | doc m%"
Minimum consecutive successes for the probe to be considered successful after having failed.
Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
"%,
          tcpSocket | optional | {
            host | optional | String | doc "Optional: Host name to connect to, defaults to the pod IP.",
            port | Number | String | doc m%"
Number or name of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
          } | doc "TCPSocket specifies a connection to a TCP port.",
          terminationGracePeriodSeconds | optional | Number | doc m%"
Optional duration in seconds the pod needs to terminate gracefully upon probe failure.
The grace period is the duration in seconds after the processes running in the pod are sent
a termination signal and the time when the processes are forcibly halted with a kill signal.
Set this value longer than the expected cleanup time for your process.
If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this
value overrides the value provided by the pod spec.
Value must be non-negative integer. The value zero indicates stop immediately via
the kill signal (no opportunity to shut down).
This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.
Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
"%,
          timeoutSeconds | optional | Number | doc m%"
Number of seconds after which the probe times out.
Defaults to 1 second. Minimum value is 1.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        } | doc m%"
Periodic probe of Sidecar liveness.
Container will be restarted if the probe fails.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        name | String | doc m%"
Name of the Sidecar specified as a DNS_LABEL.
Each Sidecar in a Task must have a unique name (DNS_LABEL).
Cannot be updated.
"%,
        ports | optional | Array {
          containerPort | Number | doc m%"
Number of port to expose on the pod's IP address.
This must be a valid port number, 0 < x < 65536.
"%,
          hostIP | optional | String | doc "What host IP to bind the external port to.",
          hostPort | optional | Number | doc m%"
Number of port to expose on the host.
If specified, this must be a valid port number, 0 < x < 65536.
If HostNetwork is specified, this must match ContainerPort.
Most containers do not need this.
"%,
          name | optional | String | doc m%"
If specified, this must be an IANA_SVC_NAME and unique within the pod. Each
named port in a pod must have a unique name. Name for the port that can be
referred to by services.
"%,
          protocol | String | doc m%"
Protocol for port. Must be UDP, TCP, or SCTP.
Defaults to "TCP".
"% | default = "TCP",
        } | doc m%"
List of ports to expose from the Sidecar. Exposing a port here gives
the system additional information about the network connections a
container uses, but is primarily informational. Not specifying a port here
DOES NOT prevent that port from being exposed. Any port which is
listening on the default "0.0.0.0" address inside a container will be
accessible from the network.
Cannot be updated.
"%,
        readinessProbe | optional | {
          exec | optional | {
            command | optional | Array String | doc m%"
Command is the command line to execute inside the container, the working directory for the
command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
a shell, you need to explicitly call out to that shell.
Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
"%,
          } | doc "Exec specifies a command to execute in the container.",
          failureThreshold | optional | Number | doc m%"
Minimum consecutive failures for the probe to be considered failed after having succeeded.
Defaults to 3. Minimum value is 1.
"%,
          grpc | optional | {
            port | Number | doc "Port number of the gRPC service. Number must be in the range 1 to 65535.",
            service | String | doc m%"
Service is the name of the service to place in the gRPC HealthCheckRequest
(see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).

If this is not specified, the default behavior is defined by gRPC.
"% | default = "",
          } | doc "GRPC specifies a GRPC HealthCheckRequest.",
          httpGet | optional | {
            host | optional | String | doc m%"
Host name to connect to, defaults to the pod IP. You probably want to set
"Host" in httpHeaders instead.
"%,
            httpHeaders | optional | Array {
              name | String | doc m%"
The header field name.
This will be canonicalized upon output, so case-variant names will be understood as the same header.
"%,
              value | String | doc "The header field value",
            } | doc "Custom headers to set in the request. HTTP allows repeated headers.",
            path | optional | String | doc "Path to access on the HTTP server.",
            port | Number | String | doc m%"
Name or number of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
            scheme | optional | String | doc m%"
Scheme to use for connecting to the host.
Defaults to HTTP.
"%,
          } | doc "HTTPGet specifies an HTTP GET request to perform.",
          initialDelaySeconds | optional | Number | doc m%"
Number of seconds after the container has started before liveness probes are initiated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
          periodSeconds | optional | Number | doc m%"
How often (in seconds) to perform the probe.
Default to 10 seconds. Minimum value is 1.
"%,
          successThreshold | optional | Number | doc m%"
Minimum consecutive successes for the probe to be considered successful after having failed.
Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
"%,
          tcpSocket | optional | {
            host | optional | String | doc "Optional: Host name to connect to, defaults to the pod IP.",
            port | Number | String | doc m%"
Number or name of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
          } | doc "TCPSocket specifies a connection to a TCP port.",
          terminationGracePeriodSeconds | optional | Number | doc m%"
Optional duration in seconds the pod needs to terminate gracefully upon probe failure.
The grace period is the duration in seconds after the processes running in the pod are sent
a termination signal and the time when the processes are forcibly halted with a kill signal.
Set this value longer than the expected cleanup time for your process.
If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this
value overrides the value provided by the pod spec.
Value must be non-negative integer. The value zero indicates stop immediately via
the kill signal (no opportunity to shut down).
This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.
Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
"%,
          timeoutSeconds | optional | Number | doc m%"
Number of seconds after which the probe times out.
Defaults to 1 second. Minimum value is 1.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        } | doc m%"
Periodic probe of Sidecar service readiness.
Container will be removed from service endpoints if the probe fails.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        restartPolicy | optional | String | doc m%"
RestartPolicy refers to kubernetes RestartPolicy. It can only be set for an
initContainer and must have it's policy set to "Always". It is currently
left optional to help support Kubernetes versions prior to 1.29 when this feature
was introduced.
"%,
        script | optional | String | doc m%"
Script is the contents of an executable file to execute.

If Script is not empty, the Step cannot have an Command or Args.
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
SecurityContext defines the security options the Sidecar should be run with.
If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.
More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
"%,
        startupProbe | optional | {
          exec | optional | {
            command | optional | Array String | doc m%"
Command is the command line to execute inside the container, the working directory for the
command  is root ('/') in the container's filesystem. The command is simply exec'd, it is
not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use
a shell, you need to explicitly call out to that shell.
Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
"%,
          } | doc "Exec specifies a command to execute in the container.",
          failureThreshold | optional | Number | doc m%"
Minimum consecutive failures for the probe to be considered failed after having succeeded.
Defaults to 3. Minimum value is 1.
"%,
          grpc | optional | {
            port | Number | doc "Port number of the gRPC service. Number must be in the range 1 to 65535.",
            service | String | doc m%"
Service is the name of the service to place in the gRPC HealthCheckRequest
(see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).

If this is not specified, the default behavior is defined by gRPC.
"% | default = "",
          } | doc "GRPC specifies a GRPC HealthCheckRequest.",
          httpGet | optional | {
            host | optional | String | doc m%"
Host name to connect to, defaults to the pod IP. You probably want to set
"Host" in httpHeaders instead.
"%,
            httpHeaders | optional | Array {
              name | String | doc m%"
The header field name.
This will be canonicalized upon output, so case-variant names will be understood as the same header.
"%,
              value | String | doc "The header field value",
            } | doc "Custom headers to set in the request. HTTP allows repeated headers.",
            path | optional | String | doc "Path to access on the HTTP server.",
            port | Number | String | doc m%"
Name or number of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
            scheme | optional | String | doc m%"
Scheme to use for connecting to the host.
Defaults to HTTP.
"%,
          } | doc "HTTPGet specifies an HTTP GET request to perform.",
          initialDelaySeconds | optional | Number | doc m%"
Number of seconds after the container has started before liveness probes are initiated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
          periodSeconds | optional | Number | doc m%"
How often (in seconds) to perform the probe.
Default to 10 seconds. Minimum value is 1.
"%,
          successThreshold | optional | Number | doc m%"
Minimum consecutive successes for the probe to be considered successful after having failed.
Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1.
"%,
          tcpSocket | optional | {
            host | optional | String | doc "Optional: Host name to connect to, defaults to the pod IP.",
            port | Number | String | doc m%"
Number or name of the port to access on the container.
Number must be in the range 1 to 65535.
Name must be an IANA_SVC_NAME.
"%,
          } | doc "TCPSocket specifies a connection to a TCP port.",
          terminationGracePeriodSeconds | optional | Number | doc m%"
Optional duration in seconds the pod needs to terminate gracefully upon probe failure.
The grace period is the duration in seconds after the processes running in the pod are sent
a termination signal and the time when the processes are forcibly halted with a kill signal.
Set this value longer than the expected cleanup time for your process.
If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this
value overrides the value provided by the pod spec.
Value must be non-negative integer. The value zero indicates stop immediately via
the kill signal (no opportunity to shut down).
This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.
Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset.
"%,
          timeoutSeconds | optional | Number | doc m%"
Number of seconds after which the probe times out.
Defaults to 1 second. Minimum value is 1.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        } | doc m%"
StartupProbe indicates that the Pod the Sidecar is running in has successfully initialized.
If specified, no other probes are executed until this completes successfully.
If this probe fails, the Pod will be restarted, just as if the livenessProbe failed.
This can be used to provide different probe parameters at the beginning of a Pod's lifecycle,
when it might take a long time to load data or warm a cache, than during steady-state operation.
This cannot be updated.
More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
"%,
        stdin | optional | Bool | doc m%"
Whether this Sidecar should allocate a buffer for stdin in the container runtime. If this
is not set, reads from stdin in the Sidecar will always result in EOF.
Default is false.
"%,
        stdinOnce | optional | Bool | doc m%"
Whether the container runtime should close the stdin channel after it has been opened by
a single attach. When stdin is true the stdin stream will remain open across multiple attach
sessions. If stdinOnce is set to true, stdin is opened on Sidecar start, is empty until the
first client attaches to stdin, and then remains open and accepts data until the client disconnects,
at which time stdin is closed and remains closed until the Sidecar is restarted. If this
flag is false, a container processes that reads from stdin will never receive an EOF.
Default is false
"%,
        terminationMessagePath | optional | String | doc m%"
Optional: Path at which the file to which the Sidecar's termination message
will be written is mounted into the Sidecar's filesystem.
Message written is intended to be brief final status, such as an assertion failure message.
Will be truncated by the node if greater than 4096 bytes. The total message length across
all containers will be limited to 12kb.
Defaults to /dev/termination-log.
Cannot be updated.
"%,
        terminationMessagePolicy | optional | String | doc m%"
Indicate how the termination message should be populated. File will use the contents of
terminationMessagePath to populate the Sidecar status message on both success and failure.
FallbackToLogsOnError will use the last chunk of Sidecar log output if the termination
message file is empty and the Sidecar exited with an error.
The log output is limited to 2048 bytes or 80 lines, whichever is smaller.
Defaults to File.
Cannot be updated.
"%,
        tty | optional | Bool | doc m%"
Whether this Sidecar should allocate a TTY for itself, also requires 'stdin' to be true.
Default is false.
"%,
        volumeDevices | optional | Array {
          devicePath | String | doc m%"
devicePath is the path inside of the container that the device will be mapped to.
"%,
          name | String | doc "name must match the name of a persistentVolumeClaim in the pod",
        } | doc "volumeDevices is the list of block devices to be used by the Sidecar.",
        volumeMounts | optional | Array k8s_io_envfromsource.VolumeMount | doc m%"
Volumes to mount into the Sidecar's filesystem.
Cannot be updated.
"%,
        workingDir | optional | String | doc m%"
Sidecar's working directory.
If not specified, the container runtime's default will be used, which
might be configured in the container image.
Cannot be updated.
"%,
        workspaces | optional | Array {
          mountPath | String | doc m%"
MountPath is the path that the workspace should be mounted to inside the Step or Sidecar,
overriding any MountPath specified in the Task's WorkspaceDeclaration.
"%,
          name | String | doc "Name is the name of the workspace this Step or Sidecar wants access to.",
        } | doc m%"
This is an alpha field. You must set the "enable-api-fields" feature flag to "alpha"
for this field to be supported.

Workspaces is a list of workspaces from the Task that this Sidecar wants
exclusive access to. Adding a workspace to this list means that any
other Step or Sidecar that does not also request this Workspace will
not have access to it.
"%,
      } | doc m%"
Sidecars are run alongside the Task's step containers. They begin before
the steps start and end after the steps complete.
"%,
      stepTemplate | optional | {
        args | optional | Array String | doc m%"
Arguments to the entrypoint.
The image's CMD is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the Step's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
        command | optional | Array String | doc m%"
Entrypoint array. Not executed within a shell.
The image's ENTRYPOINT is used if this is not provided.
Variable references $(VAR_NAME) are expanded using the Step's environment. If a variable
cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced
to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless
of whether the variable exists or not. Cannot be updated.
More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
"%,
        computeResources | optional | {
          claims | optional | Array {
            name | String | doc m%"
Name must match the name of one entry in pod.spec.resourceClaims of
the Pod where this field is used. It makes that resource available
inside a container.
"%,
            request | optional | String | doc m%"
Request is the name chosen for a request in the referenced claim.
If empty, everything from the claim is made available, otherwise
only the result of this request.
"%,
          } | doc m%"
Claims lists the names of resources, defined in spec.resourceClaims,
that are used by this container.

This is an alpha field and requires enabling the
DynamicResourceAllocation feature gate.

This field is immutable. It can only be set for containers.
"%,
          limits | optional | {
          } | doc m%"
Limits describes the maximum amount of compute resources allowed.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
          requests | optional | {
          } | doc m%"
Requests describes the minimum amount of compute resources required.
If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
otherwise to an implementation-defined value. Requests cannot exceed Limits.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
        } | doc m%"
ComputeResources required by this Step.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
        env | optional | Array k8s_io_envfromsource.EnvVar | doc m%"
List of environment variables to set in the Step.
Cannot be updated.
"%,
        envFrom | optional | Array k8s_io_envfromsource.EnvFromSource | doc m%"
List of sources to populate environment variables in the Step.
The keys defined within a source must be a C_IDENTIFIER. All invalid keys
will be reported as an event when the Step is starting. When a key exists in multiple
sources, the value associated with the last source will take precedence.
Values defined by an Env with a duplicate key will take precedence.
Cannot be updated.
"%,
        image | optional | String | doc m%"
Image reference name.
More info: https://kubernetes.io/docs/concepts/containers/images
"%,
        imagePullPolicy | optional | String | doc m%"
Image pull policy.
One of Always, Never, IfNotPresent.
Defaults to Always if :latest tag is specified, or IfNotPresent otherwise.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/containers/images#updating-images
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
"%,
        volumeDevices | optional | Array {
          devicePath | String | doc m%"
devicePath is the path inside of the container that the device will be mapped to.
"%,
          name | String | doc "name must match the name of a persistentVolumeClaim in the pod",
        } | doc "volumeDevices is the list of block devices to be used by the Step.",
        volumeMounts | optional | Array k8s_io_envfromsource.VolumeMount | doc m%"
Volumes to mount into the Step's filesystem.
Cannot be updated.
"%,
        workingDir | optional | String | doc m%"
Step's working directory.
If not specified, the container runtime's default will be used, which
might be configured in the container image.
Cannot be updated.
"%,
      } | doc m%"
StepTemplate can be used as the basis for all step containers within the
Task, so that the steps inherit settings on the base container.
"%,
      steps | optional | Array {
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
        computeResources | optional | {
          claims | optional | Array {
            name | String | doc m%"
Name must match the name of one entry in pod.spec.resourceClaims of
the Pod where this field is used. It makes that resource available
inside a container.
"%,
            request | optional | String | doc m%"
Request is the name chosen for a request in the referenced claim.
If empty, everything from the claim is made available, otherwise
only the result of this request.
"%,
          } | doc m%"
Claims lists the names of resources, defined in spec.resourceClaims,
that are used by this container.

This is an alpha field and requires enabling the
DynamicResourceAllocation feature gate.

This field is immutable. It can only be set for containers.
"%,
          limits | optional | {
          } | doc m%"
Limits describes the maximum amount of compute resources allowed.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
          requests | optional | {
          } | doc m%"
Requests describes the minimum amount of compute resources required.
If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
otherwise to an implementation-defined value. Requests cannot exceed Limits.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
        } | doc m%"
ComputeResources required by this Step.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
"%,
        env | optional | Array k8s_io_envfromsource.EnvVar | doc m%"
List of environment variables to set in the Step.
Cannot be updated.
"%,
        envFrom | optional | Array k8s_io_envfromsource.EnvFromSource | doc m%"
List of sources to populate environment variables in the Step.
The keys defined within a source must be a C_IDENTIFIER. All invalid keys
will be reported as an event when the Step is starting. When a key exists in multiple
sources, the value associated with the last source will take precedence.
Values defined by an Env with a duplicate key will take precedence.
Cannot be updated.
"%,
        image | optional | String | doc m%"
Docker image name.
More info: https://kubernetes.io/docs/concepts/containers/images
"%,
        imagePullPolicy | optional | String | doc m%"
Image pull policy.
One of Always, Never, IfNotPresent.
Defaults to Always if :latest tag is specified, or IfNotPresent otherwise.
Cannot be updated.
More info: https://kubernetes.io/docs/concepts/containers/images#updating-images
"%,
        name | String | doc m%"
Name of the Step specified as a DNS_LABEL.
Each Step in a Task must have a unique name.
"%,
        onError | optional | String | doc m%"
OnError defines the exiting behavior of a container on error
can be set to [ continue | stopAndFail ]
"%,
        params | optional | Array {
          name | String,
          value | Dyn,
        } | doc "Params declares parameters passed to this step action.",
        ref | optional | {
          name | optional | String | doc "Name of the referenced step",
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
        } | doc "Contains the reference to an existing StepAction.",
        results | optional | Array {
          description | optional | String | doc "Description is a human-readable description of the result",
          name | String | doc "Name the given name",
          properties | optional | {
          } | doc "Properties is the JSON Schema properties to support key-value pairs results.",
          type | optional | String | doc m%"
The possible types are 'string', 'array', and 'object', with 'string' as the default.
"%,
        } | doc m%"
Results declares StepResults produced by the Step.

It can be used in an inlined Step when used to store Results to $(step.results.resultName.path).
It cannot be used when referencing StepActions using [v1.Step.Ref].
The Results declared by the StepActions will be stored here instead.
"%,
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
"%,
        stderrConfig | optional | {
          path | optional | String | doc "Path to duplicate stdout stream to on container's local filesystem.",
        } | doc "Stores configuration for the stderr stream of the step.",
        stdoutConfig | optional | {
          path | optional | String | doc "Path to duplicate stdout stream to on container's local filesystem.",
        } | doc "Stores configuration for the stdout stream of the step.",
        timeout | optional | String | doc m%"
Timeout is the time after which the step times out. Defaults to never.
Refer to Go's ParseDuration documentation for expected format: https://golang.org/pkg/time/#ParseDuration
"%,
        volumeDevices | optional | Array {
          devicePath | String | doc m%"
devicePath is the path inside of the container that the device will be mapped to.
"%,
          name | String | doc "name must match the name of a persistentVolumeClaim in the pod",
        } | doc "volumeDevices is the list of block devices to be used by the Step.",
        volumeMounts | optional | Array k8s_io_envfromsource.VolumeMount | doc m%"
Volumes to mount into the Step's filesystem.
Cannot be updated.
"%,
        when | optional | Array {
          cel | optional | String | doc m%"
CEL is a string of Common Language Expression, which can be used to conditionally execute
the task based on the result of the expression evaluation
More info about CEL syntax: https://github.com/google/cel-spec/blob/master/doc/langdef.md
"%,
          input | optional | String | doc m%"
Input is the string for guard checking which can be a static input or an output from a parent Task
"%,
          operator | optional | String | doc "Operator that represents an Input's relationship to the values",
          values | optional | Array String | doc m%"
Values is an array of strings, which is compared against the input, for guard checking
It must be non-empty
"%,
        } | doc "When is a list of when expressions that need to be true for the task to run",
        workingDir | optional | String | doc m%"
Step's working directory.
If not specified, the container runtime's default will be used, which
might be configured in the container image.
Cannot be updated.
"%,
        workspaces | optional | Array {
          mountPath | String | doc m%"
MountPath is the path that the workspace should be mounted to inside the Step or Sidecar,
overriding any MountPath specified in the Task's WorkspaceDeclaration.
"%,
          name | String | doc "Name is the name of the workspace this Step or Sidecar wants access to.",
        } | doc m%"
This is an alpha field. You must set the "enable-api-fields" feature flag to "alpha"
for this field to be supported.

Workspaces is a list of workspaces from the Task that this Step wants
exclusive access to. Adding a workspace to this list means that any
other Step or Sidecar that does not also request this Workspace will
not have access to it.
"%,
      } | doc m%"
Steps are the steps of the build; each step is run sequentially with the
source mounted into /workspace.
"%,
      volumes | optional | Dyn | doc m%"
Volumes is a collection of volumes that are available to mount into the
steps of the build.
See Pod.spec.volumes (API version: v1)
"%,
      workspaces | optional | Array {
        description | optional | String | doc "Description is an optional human readable description of this volume.",
        mountPath | optional | String | doc "MountPath overrides the directory that the volume will be made available at.",
        name | String | doc "Name is the name by which you can bind the volume at runtime.",
        optional | optional | Bool | doc m%"
Optional marks a Workspace as not being required in TaskRuns. By default
this field is false and so declared workspaces are required.
"%,
        readOnly | optional | Bool | doc m%"
ReadOnly dictates whether a mounted volume is writable. By default this
field is false and so mounted volumes are writable.
"%,
      } | doc "Workspaces are the volumes that this Task requires.",
    } | doc "Spec holds the desired state of the Task from the client",
  },
}
