# Module: application.argoproj.io

let k8s_io_envvar = import "k8s_io" in
let k8s_io_objectmeta = import "k8s_io" in

{
  Application = {
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
    metadata | k8s_io_envvar.ObjectMeta,
    operation | optional | {
      info | optional | Array {
        name | String,
        value | String,
      } | doc "Info is a list of informational items for this operation",
      initiatedBy | optional | {
        automated | optional | Bool | doc m%"
Automated is set to true if operation was initiated automatically by the application controller.
"%,
        username | optional | String | doc "Username contains the name of a user who started operation",
      } | doc "InitiatedBy contains information about who initiated the operations",
      retry | optional | {
        backoff | optional | {
          duration | optional | String | doc m%"
Duration is the amount to back off. Default unit is seconds, but could also be a duration (e.g. "2m", "1h")
"%,
          factor | optional | Number | doc "Factor is a factor to multiply the base duration after each failed retry",
          maxDuration | optional | String | doc "MaxDuration is the maximum amount of time allowed for the backoff strategy",
        } | doc "Backoff controls how to backoff on subsequent retries of failed syncs",
        limit | optional | Number | doc m%"
Limit is the maximum number of attempts for retrying a failed sync. If set to 0, no retries will be performed.
"%,
      } | doc "Retry controls the strategy to apply if a sync fails",
      sync | optional | {
        autoHealAttemptsCount | optional | Number | doc "SelfHealAttemptsCount contains the number of auto-heal attempts",
        dryRun | optional | Bool | doc m%"
DryRun specifies to perform a `kubectl apply --dry-run` without actually performing the sync
"%,
        manifests | optional | Array String | doc m%"
Manifests is an optional field that overrides sync source with a local directory for development
"%,
        prune | optional | Bool | doc m%"
Prune specifies to delete resources from the cluster that are no longer tracked in git
"%,
        resources | optional | Array {
          group | optional | String,
          kind | String,
          name | String,
          namespace | optional | String,
        } | doc "Resources describes which resources shall be part of the sync",
        revision | optional | String | doc m%"
Revision is the revision (Git) or chart version (Helm) which to sync the application to
If omitted, will use the revision specified in app spec.
"%,
        revisions | optional | Array String | doc m%"
Revisions is the list of revision (Git) or chart version (Helm) which to sync each source in sources field for the application to
If omitted, will use the revision specified in app spec.
"%,
        source | optional | {
          chart | optional | String | doc m%"
Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
"%,
          directory | optional | {
            exclude | optional | String | doc m%"
Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
"%,
            include | optional | String | doc m%"
Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
"%,
            jsonnet | optional | {
              extVars | optional | Array {
                code | optional | Bool,
                name | String,
                value | String,
              } | doc "ExtVars is a list of Jsonnet External Variables",
              libs | optional | Array String | doc "Additional library search dirs",
              tlas | optional | Array {
                code | optional | Bool,
                name | String,
                value | String,
              } | doc "TLAS is a list of Jsonnet Top-level Arguments",
            } | doc "Jsonnet holds options specific to Jsonnet",
            recurse | optional | Bool | doc "Recurse specifies whether to scan a directory recursively for manifests",
          } | doc "Directory holds path/directory specific options",
          helm | optional | {
            apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
            fileParameters | optional | Array {
              name | optional | String | doc "Name is the name of the Helm parameter",
              path | optional | String | doc "Path is the path to the file containing the values for the Helm parameter",
            } | doc "FileParameters are file parameters to the helm template",
            ignoreMissingValueFiles | optional | Bool | doc m%"
IgnoreMissingValueFiles prevents helm template from failing when valueFiles do not exist locally by not appending them to helm template --values
"%,
            kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
            namespace | optional | String | doc m%"
Namespace is an optional namespace to template with. If left empty, defaults to the app's destination namespace.
"%,
            parameters | optional | Array {
              forceString | optional | Bool | doc m%"
ForceString determines whether to tell Helm to interpret booleans and numbers as strings
"%,
              name | optional | String | doc "Name is the name of the Helm parameter",
              value | optional | String | doc "Value is the value for the Helm parameter",
            } | doc m%"
Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
"%,
            passCredentials | optional | Bool | doc "PassCredentials pass credentials to all domains (Helm's --pass-credentials)",
            releaseName | optional | String | doc m%"
ReleaseName is the Helm release name to use. If omitted it will use the application name
"%,
            skipCrds | optional | Bool | doc "SkipCrds skips custom resource definition installation step (Helm's --skip-crds)",
            skipSchemaValidation | optional | Bool | doc m%"
SkipSchemaValidation skips JSON schema validation (Helm's --skip-schema-validation)
"%,
            skipTests | optional | Bool | doc "SkipTests skips test manifest installation step (Helm's --skip-tests).",
            valueFiles | optional | Array String | doc "ValuesFiles is a list of Helm value files to use when generating a template",
            values | optional | String | doc m%"
Values specifies Helm values to be passed to helm template, typically defined as a block. ValuesObject takes precedence over Values, so use one or the other.
"%,
            valuesObject | optional | {
            } | doc m%"
ValuesObject specifies Helm values to be passed to helm template, defined as a map. This takes precedence over Values.
"%,
            version | optional | String | doc "Version is the Helm version to use for templating (\"3\")",
          } | doc "Helm holds helm specific options",
          kustomize | optional | {
            apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
            commonAnnotations | optional | {
            } | doc m%"
CommonAnnotations is a list of additional annotations to add to rendered manifests
"%,
            commonAnnotationsEnvsubst | optional | Bool | doc m%"
CommonAnnotationsEnvsubst specifies whether to apply env variables substitution for annotation values
"%,
            commonLabels | optional | {
            } | doc "CommonLabels is a list of additional labels to add to rendered manifests",
            components | optional | Array String | doc m%"
Components specifies a list of kustomize components to add to the kustomization before building
"%,
            forceCommonAnnotations | optional | Bool | doc m%"
ForceCommonAnnotations specifies whether to force applying common annotations to resources for Kustomize apps
"%,
            forceCommonLabels | optional | Bool | doc m%"
ForceCommonLabels specifies whether to force applying common labels to resources for Kustomize apps
"%,
            ignoreMissingComponents | optional | Bool | doc m%"
IgnoreMissingComponents prevents kustomize from failing when components do not exist locally by not appending them to kustomization file
"%,
            images | optional | Array String | doc "Images is a list of Kustomize image override specifications",
            kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
            labelIncludeTemplates | optional | Bool | doc m%"
LabelIncludeTemplates specifies whether to apply common labels to resource templates or not
"%,
            labelWithoutSelector | optional | Bool | doc m%"
LabelWithoutSelector specifies whether to apply common labels to resource selectors or not
"%,
            namePrefix | optional | String | doc "NamePrefix is a prefix appended to resources for Kustomize apps",
            nameSuffix | optional | String | doc "NameSuffix is a suffix appended to resources for Kustomize apps",
            namespace | optional | String | doc "Namespace sets the namespace that Kustomize adds to all resources",
            patches | optional | Array {
              options | optional | {
              },
              patch | optional | String,
              path | optional | String,
              target | optional | {
                annotationSelector | optional | String,
                group | optional | String,
                kind | optional | String,
                labelSelector | optional | String,
                name | optional | String,
                namespace | optional | String,
                version | optional | String,
              },
            } | doc "Patches is a list of Kustomize patches",
            replicas | optional | Array {
              count | Number | String | doc "Number of replicas",
              name | String | doc "Name of Deployment or StatefulSet",
            } | doc "Replicas is a list of Kustomize Replicas override specifications",
            version | optional | String | doc "Version controls which version of Kustomize to use for rendering manifests",
          } | doc "Kustomize holds kustomize specific options",
          name | optional | String | doc m%"
Name is used to refer to a source and is displayed in the UI. It is used in multi-source Applications.
"%,
          path | optional | String | doc m%"
Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
"%,
          plugin | optional | {
            env | optional | Array k8s_io_envvar.EnvVar | doc "Env is a list of environment variable entries",
            name | optional | String,
            parameters | optional | Array {
              array | optional | Array String | doc "Array is the value of an array type parameter.",
              map | optional | {
              } | doc "Map is the value of a map type parameter.",
              name | optional | String | doc "Name is the name identifying a parameter.",
              string | optional | String | doc "String_ is the value of a string type parameter.",
            },
          } | doc "Plugin holds config management plugin specific options",
          ref | optional | String | doc m%"
Ref is reference to another source within sources field. This field will not be used if used with a `source` tag.
"%,
          repoURL | String | doc m%"
RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
"%,
          targetRevision | optional | String | doc m%"
TargetRevision defines the revision of the source to sync the application to.
In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD.
In case of Helm, this is a semver tag for the Chart's version.
"%,
        } | doc m%"
Source overrides the source definition set in the application.
This is typically set in a Rollback operation and is nil during a Sync operation
"%,
        sources | optional | Array {
          chart | optional | String | doc m%"
Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
"%,
          directory | optional | {
            exclude | optional | String | doc m%"
Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
"%,
            include | optional | String | doc m%"
Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
"%,
            jsonnet | optional | {
              extVars | optional | Array {
                code | optional | Bool,
                name | String,
                value | String,
              } | doc "ExtVars is a list of Jsonnet External Variables",
              libs | optional | Array String | doc "Additional library search dirs",
              tlas | optional | Array {
                code | optional | Bool,
                name | String,
                value | String,
              } | doc "TLAS is a list of Jsonnet Top-level Arguments",
            } | doc "Jsonnet holds options specific to Jsonnet",
            recurse | optional | Bool | doc "Recurse specifies whether to scan a directory recursively for manifests",
          } | doc "Directory holds path/directory specific options",
          helm | optional | {
            apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
            fileParameters | optional | Array {
              name | optional | String | doc "Name is the name of the Helm parameter",
              path | optional | String | doc "Path is the path to the file containing the values for the Helm parameter",
            } | doc "FileParameters are file parameters to the helm template",
            ignoreMissingValueFiles | optional | Bool | doc m%"
IgnoreMissingValueFiles prevents helm template from failing when valueFiles do not exist locally by not appending them to helm template --values
"%,
            kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
            namespace | optional | String | doc m%"
Namespace is an optional namespace to template with. If left empty, defaults to the app's destination namespace.
"%,
            parameters | optional | Array {
              forceString | optional | Bool | doc m%"
ForceString determines whether to tell Helm to interpret booleans and numbers as strings
"%,
              name | optional | String | doc "Name is the name of the Helm parameter",
              value | optional | String | doc "Value is the value for the Helm parameter",
            } | doc m%"
Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
"%,
            passCredentials | optional | Bool | doc "PassCredentials pass credentials to all domains (Helm's --pass-credentials)",
            releaseName | optional | String | doc m%"
ReleaseName is the Helm release name to use. If omitted it will use the application name
"%,
            skipCrds | optional | Bool | doc "SkipCrds skips custom resource definition installation step (Helm's --skip-crds)",
            skipSchemaValidation | optional | Bool | doc m%"
SkipSchemaValidation skips JSON schema validation (Helm's --skip-schema-validation)
"%,
            skipTests | optional | Bool | doc "SkipTests skips test manifest installation step (Helm's --skip-tests).",
            valueFiles | optional | Array String | doc "ValuesFiles is a list of Helm value files to use when generating a template",
            values | optional | String | doc m%"
Values specifies Helm values to be passed to helm template, typically defined as a block. ValuesObject takes precedence over Values, so use one or the other.
"%,
            valuesObject | optional | {
            } | doc m%"
ValuesObject specifies Helm values to be passed to helm template, defined as a map. This takes precedence over Values.
"%,
            version | optional | String | doc "Version is the Helm version to use for templating (\"3\")",
          } | doc "Helm holds helm specific options",
          kustomize | optional | {
            apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
            commonAnnotations | optional | {
            } | doc m%"
CommonAnnotations is a list of additional annotations to add to rendered manifests
"%,
            commonAnnotationsEnvsubst | optional | Bool | doc m%"
CommonAnnotationsEnvsubst specifies whether to apply env variables substitution for annotation values
"%,
            commonLabels | optional | {
            } | doc "CommonLabels is a list of additional labels to add to rendered manifests",
            components | optional | Array String | doc m%"
Components specifies a list of kustomize components to add to the kustomization before building
"%,
            forceCommonAnnotations | optional | Bool | doc m%"
ForceCommonAnnotations specifies whether to force applying common annotations to resources for Kustomize apps
"%,
            forceCommonLabels | optional | Bool | doc m%"
ForceCommonLabels specifies whether to force applying common labels to resources for Kustomize apps
"%,
            ignoreMissingComponents | optional | Bool | doc m%"
IgnoreMissingComponents prevents kustomize from failing when components do not exist locally by not appending them to kustomization file
"%,
            images | optional | Array String | doc "Images is a list of Kustomize image override specifications",
            kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
            labelIncludeTemplates | optional | Bool | doc m%"
LabelIncludeTemplates specifies whether to apply common labels to resource templates or not
"%,
            labelWithoutSelector | optional | Bool | doc m%"
LabelWithoutSelector specifies whether to apply common labels to resource selectors or not
"%,
            namePrefix | optional | String | doc "NamePrefix is a prefix appended to resources for Kustomize apps",
            nameSuffix | optional | String | doc "NameSuffix is a suffix appended to resources for Kustomize apps",
            namespace | optional | String | doc "Namespace sets the namespace that Kustomize adds to all resources",
            patches | optional | Array {
              options | optional | {
              },
              patch | optional | String,
              path | optional | String,
              target | optional | {
                annotationSelector | optional | String,
                group | optional | String,
                kind | optional | String,
                labelSelector | optional | String,
                name | optional | String,
                namespace | optional | String,
                version | optional | String,
              },
            } | doc "Patches is a list of Kustomize patches",
            replicas | optional | Array {
              count | Number | String | doc "Number of replicas",
              name | String | doc "Name of Deployment or StatefulSet",
            } | doc "Replicas is a list of Kustomize Replicas override specifications",
            version | optional | String | doc "Version controls which version of Kustomize to use for rendering manifests",
          } | doc "Kustomize holds kustomize specific options",
          name | optional | String | doc m%"
Name is used to refer to a source and is displayed in the UI. It is used in multi-source Applications.
"%,
          path | optional | String | doc m%"
Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
"%,
          plugin | optional | {
            env | optional | Array k8s_io_envvar.EnvVar | doc "Env is a list of environment variable entries",
            name | optional | String,
            parameters | optional | Array {
              array | optional | Array String | doc "Array is the value of an array type parameter.",
              map | optional | {
              } | doc "Map is the value of a map type parameter.",
              name | optional | String | doc "Name is the name identifying a parameter.",
              string | optional | String | doc "String_ is the value of a string type parameter.",
            },
          } | doc "Plugin holds config management plugin specific options",
          ref | optional | String | doc m%"
Ref is reference to another source within sources field. This field will not be used if used with a `source` tag.
"%,
          repoURL | String | doc m%"
RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
"%,
          targetRevision | optional | String | doc m%"
TargetRevision defines the revision of the source to sync the application to.
In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD.
In case of Helm, this is a semver tag for the Chart's version.
"%,
        } | doc m%"
Sources overrides the source definition set in the application.
This is typically set in a Rollback operation and is nil during a Sync operation
"%,
        syncOptions | optional | Array String | doc "SyncOptions provide per-sync sync-options, e.g. Validate=false",
        syncStrategy | optional | {
          apply | optional | {
            force | optional | Bool | doc m%"
Force indicates whether or not to supply the --force flag to `kubectl apply`.
The --force flag deletes and re-create the resource, when PATCH encounters conflict and has
retried for 5 times.
"%,
          } | doc "Apply will perform a `kubectl apply` to perform the sync.",
          hook | optional | {
            force | optional | Bool | doc m%"
Force indicates whether or not to supply the --force flag to `kubectl apply`.
The --force flag deletes and re-create the resource, when PATCH encounters conflict and has
retried for 5 times.
"%,
          } | doc m%"
Hook will submit any referenced resources to perform the sync. This is the default strategy
"%,
        } | doc "SyncStrategy describes how to perform the sync",
      } | doc "Sync contains parameters for the operation",
    } | doc "Operation contains information about a requested or running operation",
    spec | {
      destination | {
        name | optional | String | doc m%"
Name is an alternate way of specifying the target cluster by its symbolic name. This must be set if Server is not set.
"%,
        namespace | optional | String | doc m%"
Namespace specifies the target namespace for the application's resources.
The namespace will only be set for namespace-scoped resources that have not set a value for .metadata.namespace
"%,
        server | optional | String | doc m%"
Server specifies the URL of the target cluster's Kubernetes control plane API. This must be set if Name is not set.
"%,
      } | doc "Destination is a reference to the target Kubernetes server and namespace",
      ignoreDifferences | optional | Array {
        group | optional | String,
        jqPathExpressions | optional | Array String,
        jsonPointers | optional | Array String,
        kind | String,
        managedFieldsManagers | optional | Array String | doc m%"
ManagedFieldsManagers is a list of trusted managers. Fields mutated by those managers will take precedence over the
desired state defined in the SCM and won't be displayed in diffs
"%,
        name | optional | String,
        namespace | optional | String,
      } | doc m%"
IgnoreDifferences is a list of resources and their fields which should be ignored during comparison
"%,
      info | optional | Array {
        name | String,
        value | String,
      } | doc m%"
Info contains a list of information (URLs, email addresses, and plain text) that relates to the application
"%,
      project | String | doc m%"
Project is a reference to the project this application belongs to.
The empty string means that application belongs to the 'default' project.
"%,
      revisionHistoryLimit | optional | Number | doc m%"
RevisionHistoryLimit limits the number of items kept in the application's revision history, which is used for informational purposes as well as for rollbacks to previous versions.
This should only be changed in exceptional circumstances.
Setting to zero will store no history. This will reduce storage used.
Increasing will increase the space used to store the history, so we do not recommend increasing it.
Default is 10.
"%,
      source | optional | {
        chart | optional | String | doc m%"
Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
"%,
        directory | optional | {
          exclude | optional | String | doc m%"
Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
"%,
          include | optional | String | doc m%"
Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
"%,
          jsonnet | optional | {
            extVars | optional | Array {
              code | optional | Bool,
              name | String,
              value | String,
            } | doc "ExtVars is a list of Jsonnet External Variables",
            libs | optional | Array String | doc "Additional library search dirs",
            tlas | optional | Array {
              code | optional | Bool,
              name | String,
              value | String,
            } | doc "TLAS is a list of Jsonnet Top-level Arguments",
          } | doc "Jsonnet holds options specific to Jsonnet",
          recurse | optional | Bool | doc "Recurse specifies whether to scan a directory recursively for manifests",
        } | doc "Directory holds path/directory specific options",
        helm | optional | {
          apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
          fileParameters | optional | Array {
            name | optional | String | doc "Name is the name of the Helm parameter",
            path | optional | String | doc "Path is the path to the file containing the values for the Helm parameter",
          } | doc "FileParameters are file parameters to the helm template",
          ignoreMissingValueFiles | optional | Bool | doc m%"
IgnoreMissingValueFiles prevents helm template from failing when valueFiles do not exist locally by not appending them to helm template --values
"%,
          kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
          namespace | optional | String | doc m%"
Namespace is an optional namespace to template with. If left empty, defaults to the app's destination namespace.
"%,
          parameters | optional | Array {
            forceString | optional | Bool | doc m%"
ForceString determines whether to tell Helm to interpret booleans and numbers as strings
"%,
            name | optional | String | doc "Name is the name of the Helm parameter",
            value | optional | String | doc "Value is the value for the Helm parameter",
          } | doc m%"
Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
"%,
          passCredentials | optional | Bool | doc "PassCredentials pass credentials to all domains (Helm's --pass-credentials)",
          releaseName | optional | String | doc m%"
ReleaseName is the Helm release name to use. If omitted it will use the application name
"%,
          skipCrds | optional | Bool | doc "SkipCrds skips custom resource definition installation step (Helm's --skip-crds)",
          skipSchemaValidation | optional | Bool | doc m%"
SkipSchemaValidation skips JSON schema validation (Helm's --skip-schema-validation)
"%,
          skipTests | optional | Bool | doc "SkipTests skips test manifest installation step (Helm's --skip-tests).",
          valueFiles | optional | Array String | doc "ValuesFiles is a list of Helm value files to use when generating a template",
          values | optional | String | doc m%"
Values specifies Helm values to be passed to helm template, typically defined as a block. ValuesObject takes precedence over Values, so use one or the other.
"%,
          valuesObject | optional | {
          } | doc m%"
ValuesObject specifies Helm values to be passed to helm template, defined as a map. This takes precedence over Values.
"%,
          version | optional | String | doc "Version is the Helm version to use for templating (\"3\")",
        } | doc "Helm holds helm specific options",
        kustomize | optional | {
          apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
          commonAnnotations | optional | {
          } | doc m%"
CommonAnnotations is a list of additional annotations to add to rendered manifests
"%,
          commonAnnotationsEnvsubst | optional | Bool | doc m%"
CommonAnnotationsEnvsubst specifies whether to apply env variables substitution for annotation values
"%,
          commonLabels | optional | {
          } | doc "CommonLabels is a list of additional labels to add to rendered manifests",
          components | optional | Array String | doc m%"
Components specifies a list of kustomize components to add to the kustomization before building
"%,
          forceCommonAnnotations | optional | Bool | doc m%"
ForceCommonAnnotations specifies whether to force applying common annotations to resources for Kustomize apps
"%,
          forceCommonLabels | optional | Bool | doc m%"
ForceCommonLabels specifies whether to force applying common labels to resources for Kustomize apps
"%,
          ignoreMissingComponents | optional | Bool | doc m%"
IgnoreMissingComponents prevents kustomize from failing when components do not exist locally by not appending them to kustomization file
"%,
          images | optional | Array String | doc "Images is a list of Kustomize image override specifications",
          kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
          labelIncludeTemplates | optional | Bool | doc m%"
LabelIncludeTemplates specifies whether to apply common labels to resource templates or not
"%,
          labelWithoutSelector | optional | Bool | doc m%"
LabelWithoutSelector specifies whether to apply common labels to resource selectors or not
"%,
          namePrefix | optional | String | doc "NamePrefix is a prefix appended to resources for Kustomize apps",
          nameSuffix | optional | String | doc "NameSuffix is a suffix appended to resources for Kustomize apps",
          namespace | optional | String | doc "Namespace sets the namespace that Kustomize adds to all resources",
          patches | optional | Array {
            options | optional | {
            },
            patch | optional | String,
            path | optional | String,
            target | optional | {
              annotationSelector | optional | String,
              group | optional | String,
              kind | optional | String,
              labelSelector | optional | String,
              name | optional | String,
              namespace | optional | String,
              version | optional | String,
            },
          } | doc "Patches is a list of Kustomize patches",
          replicas | optional | Array {
            count | Number | String | doc "Number of replicas",
            name | String | doc "Name of Deployment or StatefulSet",
          } | doc "Replicas is a list of Kustomize Replicas override specifications",
          version | optional | String | doc "Version controls which version of Kustomize to use for rendering manifests",
        } | doc "Kustomize holds kustomize specific options",
        name | optional | String | doc m%"
Name is used to refer to a source and is displayed in the UI. It is used in multi-source Applications.
"%,
        path | optional | String | doc m%"
Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
"%,
        plugin | optional | {
          env | optional | Array k8s_io_envvar.EnvVar | doc "Env is a list of environment variable entries",
          name | optional | String,
          parameters | optional | Array {
            array | optional | Array String | doc "Array is the value of an array type parameter.",
            map | optional | {
            } | doc "Map is the value of a map type parameter.",
            name | optional | String | doc "Name is the name identifying a parameter.",
            string | optional | String | doc "String_ is the value of a string type parameter.",
          },
        } | doc "Plugin holds config management plugin specific options",
        ref | optional | String | doc m%"
Ref is reference to another source within sources field. This field will not be used if used with a `source` tag.
"%,
        repoURL | String | doc m%"
RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
"%,
        targetRevision | optional | String | doc m%"
TargetRevision defines the revision of the source to sync the application to.
In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD.
In case of Helm, this is a semver tag for the Chart's version.
"%,
      } | doc "Source is a reference to the location of the application's manifests or chart",
      sourceHydrator | optional | {
        drySource | {
          path | String | doc m%"
Path is a directory path within the Git repository where the manifests are located
"%,
          repoURL | String | doc "RepoURL is the URL to the git repository that contains the application manifests",
          targetRevision | String | doc "TargetRevision defines the revision of the source to hydrate",
        } | doc "DrySource specifies where the dry \"don't repeat yourself\" manifest source lives.",
        hydrateTo | optional | {
          targetBranch | String | doc "TargetBranch is the branch to which hydrated manifests should be committed",
        } | doc m%"
HydrateTo specifies an optional "staging" location to push hydrated manifests to. An external system would then
have to move manifests to the SyncSource, e.g. by pull request.
"%,
        syncSource | {
          path | String | doc m%"
Path is a directory path within the git repository where hydrated manifests should be committed to and synced
from. If hydrateTo is set, this is just the path from which hydrated manifests will be synced.
"%,
          targetBranch | String | doc "TargetBranch is the branch to which hydrated manifests should be committed",
        } | doc "SyncSource specifies where to sync hydrated manifests from.",
      } | doc m%"
SourceHydrator provides a way to push hydrated manifests back to git before syncing them to the cluster.
"%,
      sources | optional | Array {
        chart | optional | String | doc m%"
Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
"%,
        directory | optional | {
          exclude | optional | String | doc m%"
Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
"%,
          include | optional | String | doc m%"
Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
"%,
          jsonnet | optional | {
            extVars | optional | Array {
              code | optional | Bool,
              name | String,
              value | String,
            } | doc "ExtVars is a list of Jsonnet External Variables",
            libs | optional | Array String | doc "Additional library search dirs",
            tlas | optional | Array {
              code | optional | Bool,
              name | String,
              value | String,
            } | doc "TLAS is a list of Jsonnet Top-level Arguments",
          } | doc "Jsonnet holds options specific to Jsonnet",
          recurse | optional | Bool | doc "Recurse specifies whether to scan a directory recursively for manifests",
        } | doc "Directory holds path/directory specific options",
        helm | optional | {
          apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
          fileParameters | optional | Array {
            name | optional | String | doc "Name is the name of the Helm parameter",
            path | optional | String | doc "Path is the path to the file containing the values for the Helm parameter",
          } | doc "FileParameters are file parameters to the helm template",
          ignoreMissingValueFiles | optional | Bool | doc m%"
IgnoreMissingValueFiles prevents helm template from failing when valueFiles do not exist locally by not appending them to helm template --values
"%,
          kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
          namespace | optional | String | doc m%"
Namespace is an optional namespace to template with. If left empty, defaults to the app's destination namespace.
"%,
          parameters | optional | Array {
            forceString | optional | Bool | doc m%"
ForceString determines whether to tell Helm to interpret booleans and numbers as strings
"%,
            name | optional | String | doc "Name is the name of the Helm parameter",
            value | optional | String | doc "Value is the value for the Helm parameter",
          } | doc m%"
Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
"%,
          passCredentials | optional | Bool | doc "PassCredentials pass credentials to all domains (Helm's --pass-credentials)",
          releaseName | optional | String | doc m%"
ReleaseName is the Helm release name to use. If omitted it will use the application name
"%,
          skipCrds | optional | Bool | doc "SkipCrds skips custom resource definition installation step (Helm's --skip-crds)",
          skipSchemaValidation | optional | Bool | doc m%"
SkipSchemaValidation skips JSON schema validation (Helm's --skip-schema-validation)
"%,
          skipTests | optional | Bool | doc "SkipTests skips test manifest installation step (Helm's --skip-tests).",
          valueFiles | optional | Array String | doc "ValuesFiles is a list of Helm value files to use when generating a template",
          values | optional | String | doc m%"
Values specifies Helm values to be passed to helm template, typically defined as a block. ValuesObject takes precedence over Values, so use one or the other.
"%,
          valuesObject | optional | {
          } | doc m%"
ValuesObject specifies Helm values to be passed to helm template, defined as a map. This takes precedence over Values.
"%,
          version | optional | String | doc "Version is the Helm version to use for templating (\"3\")",
        } | doc "Helm holds helm specific options",
        kustomize | optional | {
          apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
          commonAnnotations | optional | {
          } | doc m%"
CommonAnnotations is a list of additional annotations to add to rendered manifests
"%,
          commonAnnotationsEnvsubst | optional | Bool | doc m%"
CommonAnnotationsEnvsubst specifies whether to apply env variables substitution for annotation values
"%,
          commonLabels | optional | {
          } | doc "CommonLabels is a list of additional labels to add to rendered manifests",
          components | optional | Array String | doc m%"
Components specifies a list of kustomize components to add to the kustomization before building
"%,
          forceCommonAnnotations | optional | Bool | doc m%"
ForceCommonAnnotations specifies whether to force applying common annotations to resources for Kustomize apps
"%,
          forceCommonLabels | optional | Bool | doc m%"
ForceCommonLabels specifies whether to force applying common labels to resources for Kustomize apps
"%,
          ignoreMissingComponents | optional | Bool | doc m%"
IgnoreMissingComponents prevents kustomize from failing when components do not exist locally by not appending them to kustomization file
"%,
          images | optional | Array String | doc "Images is a list of Kustomize image override specifications",
          kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
          labelIncludeTemplates | optional | Bool | doc m%"
LabelIncludeTemplates specifies whether to apply common labels to resource templates or not
"%,
          labelWithoutSelector | optional | Bool | doc m%"
LabelWithoutSelector specifies whether to apply common labels to resource selectors or not
"%,
          namePrefix | optional | String | doc "NamePrefix is a prefix appended to resources for Kustomize apps",
          nameSuffix | optional | String | doc "NameSuffix is a suffix appended to resources for Kustomize apps",
          namespace | optional | String | doc "Namespace sets the namespace that Kustomize adds to all resources",
          patches | optional | Array {
            options | optional | {
            },
            patch | optional | String,
            path | optional | String,
            target | optional | {
              annotationSelector | optional | String,
              group | optional | String,
              kind | optional | String,
              labelSelector | optional | String,
              name | optional | String,
              namespace | optional | String,
              version | optional | String,
            },
          } | doc "Patches is a list of Kustomize patches",
          replicas | optional | Array {
            count | Number | String | doc "Number of replicas",
            name | String | doc "Name of Deployment or StatefulSet",
          } | doc "Replicas is a list of Kustomize Replicas override specifications",
          version | optional | String | doc "Version controls which version of Kustomize to use for rendering manifests",
        } | doc "Kustomize holds kustomize specific options",
        name | optional | String | doc m%"
Name is used to refer to a source and is displayed in the UI. It is used in multi-source Applications.
"%,
        path | optional | String | doc m%"
Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
"%,
        plugin | optional | {
          env | optional | Array k8s_io_envvar.EnvVar | doc "Env is a list of environment variable entries",
          name | optional | String,
          parameters | optional | Array {
            array | optional | Array String | doc "Array is the value of an array type parameter.",
            map | optional | {
            } | doc "Map is the value of a map type parameter.",
            name | optional | String | doc "Name is the name identifying a parameter.",
            string | optional | String | doc "String_ is the value of a string type parameter.",
          },
        } | doc "Plugin holds config management plugin specific options",
        ref | optional | String | doc m%"
Ref is reference to another source within sources field. This field will not be used if used with a `source` tag.
"%,
        repoURL | String | doc m%"
RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
"%,
        targetRevision | optional | String | doc m%"
TargetRevision defines the revision of the source to sync the application to.
In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD.
In case of Helm, this is a semver tag for the Chart's version.
"%,
      } | doc "Sources is a reference to the location of the application's manifests or chart",
      syncPolicy | optional | {
        automated | optional | {
          allowEmpty | optional | Bool | doc "AllowEmpty allows apps have zero live resources (default: false)",
          enabled | optional | Bool | doc "Enable allows apps to explicitly control automated sync",
          prune | optional | Bool | doc m%"
Prune specifies whether to delete resources from the cluster that are not found in the sources anymore as part of automated sync (default: false)
"%,
          selfHeal | optional | Bool | doc m%"
SelfHeal specifies whether to revert resources back to their desired state upon modification in the cluster (default: false)
"%,
        } | doc "Automated will keep an application synced to the target revision",
        managedNamespaceMetadata | optional | {
          annotations | optional | {
          },
          labels | optional | {
          },
        } | doc m%"
ManagedNamespaceMetadata controls metadata in the given namespace (if CreateNamespace=true)
"%,
        retry | optional | {
          backoff | optional | {
            duration | optional | String | doc m%"
Duration is the amount to back off. Default unit is seconds, but could also be a duration (e.g. "2m", "1h")
"%,
            factor | optional | Number | doc "Factor is a factor to multiply the base duration after each failed retry",
            maxDuration | optional | String | doc "MaxDuration is the maximum amount of time allowed for the backoff strategy",
          } | doc "Backoff controls how to backoff on subsequent retries of failed syncs",
          limit | optional | Number | doc m%"
Limit is the maximum number of attempts for retrying a failed sync. If set to 0, no retries will be performed.
"%,
        } | doc "Retry controls failed sync retry behavior",
        syncOptions | optional | Array String | doc "Options allow you to specify whole app sync-options",
      } | doc "SyncPolicy controls when and how a sync will be performed",
    } | doc m%"
ApplicationSpec represents desired application state. Contains link to repository with application definition and additional parameters link definition revision.
"%,
    status | optional | {
      conditions | optional | Array {
        lastTransitionTime | optional | String | doc "LastTransitionTime is the time the condition was last observed",
        message | String | doc "Message contains human-readable message indicating details about condition",
        type | String | doc "Type is an application condition type",
      } | doc "Conditions is a list of currently observed application conditions",
      controllerNamespace | optional | String | doc m%"
ControllerNamespace indicates the namespace in which the application controller is located
"%,
      health | optional | {
        lastTransitionTime | optional | String | doc "LastTransitionTime is the time the HealthStatus was set or updated",
        message | optional | String | doc m%"
Message is a human-readable informational message describing the health status

Deprecated: this field is not used and will be removed in a future release.
"%,
        status | optional | String | doc "Status holds the status code of the application",
      } | doc "Health contains information about the application's current health status",
      history | optional | Array {
        deployStartedAt | optional | String | doc "DeployStartedAt holds the time the sync operation started",
        deployedAt | String | doc "DeployedAt holds the time the sync operation completed",
        id | Number | doc "ID is an auto incrementing identifier of the RevisionHistory",
        initiatedBy | optional | {
          automated | optional | Bool | doc m%"
Automated is set to true if operation was initiated automatically by the application controller.
"%,
          username | optional | String | doc "Username contains the name of a user who started operation",
        } | doc "InitiatedBy contains information about who initiated the operations",
        revision | optional | String | doc "Revision holds the revision the sync was performed against",
        revisions | optional | Array String | doc m%"
Revisions holds the revision of each source in sources field the sync was performed against
"%,
        source | optional | {
          chart | optional | String | doc m%"
Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
"%,
          directory | optional | {
            exclude | optional | String | doc m%"
Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
"%,
            include | optional | String | doc m%"
Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
"%,
            jsonnet | optional | {
              extVars | optional | Array {
                code | optional | Bool,
                name | String,
                value | String,
              } | doc "ExtVars is a list of Jsonnet External Variables",
              libs | optional | Array String | doc "Additional library search dirs",
              tlas | optional | Array {
                code | optional | Bool,
                name | String,
                value | String,
              } | doc "TLAS is a list of Jsonnet Top-level Arguments",
            } | doc "Jsonnet holds options specific to Jsonnet",
            recurse | optional | Bool | doc "Recurse specifies whether to scan a directory recursively for manifests",
          } | doc "Directory holds path/directory specific options",
          helm | optional | {
            apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
            fileParameters | optional | Array {
              name | optional | String | doc "Name is the name of the Helm parameter",
              path | optional | String | doc "Path is the path to the file containing the values for the Helm parameter",
            } | doc "FileParameters are file parameters to the helm template",
            ignoreMissingValueFiles | optional | Bool | doc m%"
IgnoreMissingValueFiles prevents helm template from failing when valueFiles do not exist locally by not appending them to helm template --values
"%,
            kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
            namespace | optional | String | doc m%"
Namespace is an optional namespace to template with. If left empty, defaults to the app's destination namespace.
"%,
            parameters | optional | Array {
              forceString | optional | Bool | doc m%"
ForceString determines whether to tell Helm to interpret booleans and numbers as strings
"%,
              name | optional | String | doc "Name is the name of the Helm parameter",
              value | optional | String | doc "Value is the value for the Helm parameter",
            } | doc m%"
Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
"%,
            passCredentials | optional | Bool | doc "PassCredentials pass credentials to all domains (Helm's --pass-credentials)",
            releaseName | optional | String | doc m%"
ReleaseName is the Helm release name to use. If omitted it will use the application name
"%,
            skipCrds | optional | Bool | doc "SkipCrds skips custom resource definition installation step (Helm's --skip-crds)",
            skipSchemaValidation | optional | Bool | doc m%"
SkipSchemaValidation skips JSON schema validation (Helm's --skip-schema-validation)
"%,
            skipTests | optional | Bool | doc "SkipTests skips test manifest installation step (Helm's --skip-tests).",
            valueFiles | optional | Array String | doc "ValuesFiles is a list of Helm value files to use when generating a template",
            values | optional | String | doc m%"
Values specifies Helm values to be passed to helm template, typically defined as a block. ValuesObject takes precedence over Values, so use one or the other.
"%,
            valuesObject | optional | {
            } | doc m%"
ValuesObject specifies Helm values to be passed to helm template, defined as a map. This takes precedence over Values.
"%,
            version | optional | String | doc "Version is the Helm version to use for templating (\"3\")",
          } | doc "Helm holds helm specific options",
          kustomize | optional | {
            apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
            commonAnnotations | optional | {
            } | doc m%"
CommonAnnotations is a list of additional annotations to add to rendered manifests
"%,
            commonAnnotationsEnvsubst | optional | Bool | doc m%"
CommonAnnotationsEnvsubst specifies whether to apply env variables substitution for annotation values
"%,
            commonLabels | optional | {
            } | doc "CommonLabels is a list of additional labels to add to rendered manifests",
            components | optional | Array String | doc m%"
Components specifies a list of kustomize components to add to the kustomization before building
"%,
            forceCommonAnnotations | optional | Bool | doc m%"
ForceCommonAnnotations specifies whether to force applying common annotations to resources for Kustomize apps
"%,
            forceCommonLabels | optional | Bool | doc m%"
ForceCommonLabels specifies whether to force applying common labels to resources for Kustomize apps
"%,
            ignoreMissingComponents | optional | Bool | doc m%"
IgnoreMissingComponents prevents kustomize from failing when components do not exist locally by not appending them to kustomization file
"%,
            images | optional | Array String | doc "Images is a list of Kustomize image override specifications",
            kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
            labelIncludeTemplates | optional | Bool | doc m%"
LabelIncludeTemplates specifies whether to apply common labels to resource templates or not
"%,
            labelWithoutSelector | optional | Bool | doc m%"
LabelWithoutSelector specifies whether to apply common labels to resource selectors or not
"%,
            namePrefix | optional | String | doc "NamePrefix is a prefix appended to resources for Kustomize apps",
            nameSuffix | optional | String | doc "NameSuffix is a suffix appended to resources for Kustomize apps",
            namespace | optional | String | doc "Namespace sets the namespace that Kustomize adds to all resources",
            patches | optional | Array {
              options | optional | {
              },
              patch | optional | String,
              path | optional | String,
              target | optional | {
                annotationSelector | optional | String,
                group | optional | String,
                kind | optional | String,
                labelSelector | optional | String,
                name | optional | String,
                namespace | optional | String,
                version | optional | String,
              },
            } | doc "Patches is a list of Kustomize patches",
            replicas | optional | Array {
              count | Number | String | doc "Number of replicas",
              name | String | doc "Name of Deployment or StatefulSet",
            } | doc "Replicas is a list of Kustomize Replicas override specifications",
            version | optional | String | doc "Version controls which version of Kustomize to use for rendering manifests",
          } | doc "Kustomize holds kustomize specific options",
          name | optional | String | doc m%"
Name is used to refer to a source and is displayed in the UI. It is used in multi-source Applications.
"%,
          path | optional | String | doc m%"
Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
"%,
          plugin | optional | {
            env | optional | Array k8s_io_envvar.EnvVar | doc "Env is a list of environment variable entries",
            name | optional | String,
            parameters | optional | Array {
              array | optional | Array String | doc "Array is the value of an array type parameter.",
              map | optional | {
              } | doc "Map is the value of a map type parameter.",
              name | optional | String | doc "Name is the name identifying a parameter.",
              string | optional | String | doc "String_ is the value of a string type parameter.",
            },
          } | doc "Plugin holds config management plugin specific options",
          ref | optional | String | doc m%"
Ref is reference to another source within sources field. This field will not be used if used with a `source` tag.
"%,
          repoURL | String | doc m%"
RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
"%,
          targetRevision | optional | String | doc m%"
TargetRevision defines the revision of the source to sync the application to.
In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD.
In case of Helm, this is a semver tag for the Chart's version.
"%,
        } | doc "Source is a reference to the application source used for the sync operation",
        sources | optional | Array {
          chart | optional | String | doc m%"
Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
"%,
          directory | optional | {
            exclude | optional | String | doc m%"
Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
"%,
            include | optional | String | doc m%"
Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
"%,
            jsonnet | optional | {
              extVars | optional | Array {
                code | optional | Bool,
                name | String,
                value | String,
              } | doc "ExtVars is a list of Jsonnet External Variables",
              libs | optional | Array String | doc "Additional library search dirs",
              tlas | optional | Array {
                code | optional | Bool,
                name | String,
                value | String,
              } | doc "TLAS is a list of Jsonnet Top-level Arguments",
            } | doc "Jsonnet holds options specific to Jsonnet",
            recurse | optional | Bool | doc "Recurse specifies whether to scan a directory recursively for manifests",
          } | doc "Directory holds path/directory specific options",
          helm | optional | {
            apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
            fileParameters | optional | Array {
              name | optional | String | doc "Name is the name of the Helm parameter",
              path | optional | String | doc "Path is the path to the file containing the values for the Helm parameter",
            } | doc "FileParameters are file parameters to the helm template",
            ignoreMissingValueFiles | optional | Bool | doc m%"
IgnoreMissingValueFiles prevents helm template from failing when valueFiles do not exist locally by not appending them to helm template --values
"%,
            kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
            namespace | optional | String | doc m%"
Namespace is an optional namespace to template with. If left empty, defaults to the app's destination namespace.
"%,
            parameters | optional | Array {
              forceString | optional | Bool | doc m%"
ForceString determines whether to tell Helm to interpret booleans and numbers as strings
"%,
              name | optional | String | doc "Name is the name of the Helm parameter",
              value | optional | String | doc "Value is the value for the Helm parameter",
            } | doc m%"
Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
"%,
            passCredentials | optional | Bool | doc "PassCredentials pass credentials to all domains (Helm's --pass-credentials)",
            releaseName | optional | String | doc m%"
ReleaseName is the Helm release name to use. If omitted it will use the application name
"%,
            skipCrds | optional | Bool | doc "SkipCrds skips custom resource definition installation step (Helm's --skip-crds)",
            skipSchemaValidation | optional | Bool | doc m%"
SkipSchemaValidation skips JSON schema validation (Helm's --skip-schema-validation)
"%,
            skipTests | optional | Bool | doc "SkipTests skips test manifest installation step (Helm's --skip-tests).",
            valueFiles | optional | Array String | doc "ValuesFiles is a list of Helm value files to use when generating a template",
            values | optional | String | doc m%"
Values specifies Helm values to be passed to helm template, typically defined as a block. ValuesObject takes precedence over Values, so use one or the other.
"%,
            valuesObject | optional | {
            } | doc m%"
ValuesObject specifies Helm values to be passed to helm template, defined as a map. This takes precedence over Values.
"%,
            version | optional | String | doc "Version is the Helm version to use for templating (\"3\")",
          } | doc "Helm holds helm specific options",
          kustomize | optional | {
            apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
            commonAnnotations | optional | {
            } | doc m%"
CommonAnnotations is a list of additional annotations to add to rendered manifests
"%,
            commonAnnotationsEnvsubst | optional | Bool | doc m%"
CommonAnnotationsEnvsubst specifies whether to apply env variables substitution for annotation values
"%,
            commonLabels | optional | {
            } | doc "CommonLabels is a list of additional labels to add to rendered manifests",
            components | optional | Array String | doc m%"
Components specifies a list of kustomize components to add to the kustomization before building
"%,
            forceCommonAnnotations | optional | Bool | doc m%"
ForceCommonAnnotations specifies whether to force applying common annotations to resources for Kustomize apps
"%,
            forceCommonLabels | optional | Bool | doc m%"
ForceCommonLabels specifies whether to force applying common labels to resources for Kustomize apps
"%,
            ignoreMissingComponents | optional | Bool | doc m%"
IgnoreMissingComponents prevents kustomize from failing when components do not exist locally by not appending them to kustomization file
"%,
            images | optional | Array String | doc "Images is a list of Kustomize image override specifications",
            kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
            labelIncludeTemplates | optional | Bool | doc m%"
LabelIncludeTemplates specifies whether to apply common labels to resource templates or not
"%,
            labelWithoutSelector | optional | Bool | doc m%"
LabelWithoutSelector specifies whether to apply common labels to resource selectors or not
"%,
            namePrefix | optional | String | doc "NamePrefix is a prefix appended to resources for Kustomize apps",
            nameSuffix | optional | String | doc "NameSuffix is a suffix appended to resources for Kustomize apps",
            namespace | optional | String | doc "Namespace sets the namespace that Kustomize adds to all resources",
            patches | optional | Array {
              options | optional | {
              },
              patch | optional | String,
              path | optional | String,
              target | optional | {
                annotationSelector | optional | String,
                group | optional | String,
                kind | optional | String,
                labelSelector | optional | String,
                name | optional | String,
                namespace | optional | String,
                version | optional | String,
              },
            } | doc "Patches is a list of Kustomize patches",
            replicas | optional | Array {
              count | Number | String | doc "Number of replicas",
              name | String | doc "Name of Deployment or StatefulSet",
            } | doc "Replicas is a list of Kustomize Replicas override specifications",
            version | optional | String | doc "Version controls which version of Kustomize to use for rendering manifests",
          } | doc "Kustomize holds kustomize specific options",
          name | optional | String | doc m%"
Name is used to refer to a source and is displayed in the UI. It is used in multi-source Applications.
"%,
          path | optional | String | doc m%"
Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
"%,
          plugin | optional | {
            env | optional | Array k8s_io_envvar.EnvVar | doc "Env is a list of environment variable entries",
            name | optional | String,
            parameters | optional | Array {
              array | optional | Array String | doc "Array is the value of an array type parameter.",
              map | optional | {
              } | doc "Map is the value of a map type parameter.",
              name | optional | String | doc "Name is the name identifying a parameter.",
              string | optional | String | doc "String_ is the value of a string type parameter.",
            },
          } | doc "Plugin holds config management plugin specific options",
          ref | optional | String | doc m%"
Ref is reference to another source within sources field. This field will not be used if used with a `source` tag.
"%,
          repoURL | String | doc m%"
RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
"%,
          targetRevision | optional | String | doc m%"
TargetRevision defines the revision of the source to sync the application to.
In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD.
In case of Helm, this is a semver tag for the Chart's version.
"%,
        } | doc "Sources is a reference to the application sources used for the sync operation",
      } | doc "History contains information about the application's sync history",
      observedAt | optional | String | doc m%"
ObservedAt indicates when the application state was updated without querying latest git state
Deprecated: controller no longer updates ObservedAt field
"%,
      operationState | optional | {
        finishedAt | optional | String | doc "FinishedAt contains time of operation completion",
        message | optional | String | doc m%"
Message holds any pertinent messages when attempting to perform operation (typically errors).
"%,
        operation | {
          info | optional | Array {
            name | String,
            value | String,
          } | doc "Info is a list of informational items for this operation",
          initiatedBy | optional | {
            automated | optional | Bool | doc m%"
Automated is set to true if operation was initiated automatically by the application controller.
"%,
            username | optional | String | doc "Username contains the name of a user who started operation",
          } | doc "InitiatedBy contains information about who initiated the operations",
          retry | optional | {
            backoff | optional | {
              duration | optional | String | doc m%"
Duration is the amount to back off. Default unit is seconds, but could also be a duration (e.g. "2m", "1h")
"%,
              factor | optional | Number | doc "Factor is a factor to multiply the base duration after each failed retry",
              maxDuration | optional | String | doc "MaxDuration is the maximum amount of time allowed for the backoff strategy",
            } | doc "Backoff controls how to backoff on subsequent retries of failed syncs",
            limit | optional | Number | doc m%"
Limit is the maximum number of attempts for retrying a failed sync. If set to 0, no retries will be performed.
"%,
          } | doc "Retry controls the strategy to apply if a sync fails",
          sync | optional | {
            autoHealAttemptsCount | optional | Number | doc "SelfHealAttemptsCount contains the number of auto-heal attempts",
            dryRun | optional | Bool | doc m%"
DryRun specifies to perform a `kubectl apply --dry-run` without actually performing the sync
"%,
            manifests | optional | Array String | doc m%"
Manifests is an optional field that overrides sync source with a local directory for development
"%,
            prune | optional | Bool | doc m%"
Prune specifies to delete resources from the cluster that are no longer tracked in git
"%,
            resources | optional | Array {
              group | optional | String,
              kind | String,
              name | String,
              namespace | optional | String,
            } | doc "Resources describes which resources shall be part of the sync",
            revision | optional | String | doc m%"
Revision is the revision (Git) or chart version (Helm) which to sync the application to
If omitted, will use the revision specified in app spec.
"%,
            revisions | optional | Array String | doc m%"
Revisions is the list of revision (Git) or chart version (Helm) which to sync each source in sources field for the application to
If omitted, will use the revision specified in app spec.
"%,
            source | optional | {
              chart | optional | String | doc m%"
Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
"%,
              directory | optional | {
                exclude | optional | String | doc m%"
Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
"%,
                include | optional | String | doc m%"
Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
"%,
                jsonnet | optional | {
                  extVars | optional | Array {
                    code | optional | Bool,
                    name | String,
                    value | String,
                  } | doc "ExtVars is a list of Jsonnet External Variables",
                  libs | optional | Array String | doc "Additional library search dirs",
                  tlas | optional | Array {
                    code | optional | Bool,
                    name | String,
                    value | String,
                  } | doc "TLAS is a list of Jsonnet Top-level Arguments",
                } | doc "Jsonnet holds options specific to Jsonnet",
                recurse | optional | Bool | doc "Recurse specifies whether to scan a directory recursively for manifests",
              } | doc "Directory holds path/directory specific options",
              helm | optional | {
                apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
                fileParameters | optional | Array {
                  name | optional | String | doc "Name is the name of the Helm parameter",
                  path | optional | String | doc "Path is the path to the file containing the values for the Helm parameter",
                } | doc "FileParameters are file parameters to the helm template",
                ignoreMissingValueFiles | optional | Bool | doc m%"
IgnoreMissingValueFiles prevents helm template from failing when valueFiles do not exist locally by not appending them to helm template --values
"%,
                kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
                namespace | optional | String | doc m%"
Namespace is an optional namespace to template with. If left empty, defaults to the app's destination namespace.
"%,
                parameters | optional | Array {
                  forceString | optional | Bool | doc m%"
ForceString determines whether to tell Helm to interpret booleans and numbers as strings
"%,
                  name | optional | String | doc "Name is the name of the Helm parameter",
                  value | optional | String | doc "Value is the value for the Helm parameter",
                } | doc m%"
Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
"%,
                passCredentials | optional | Bool | doc "PassCredentials pass credentials to all domains (Helm's --pass-credentials)",
                releaseName | optional | String | doc m%"
ReleaseName is the Helm release name to use. If omitted it will use the application name
"%,
                skipCrds | optional | Bool | doc "SkipCrds skips custom resource definition installation step (Helm's --skip-crds)",
                skipSchemaValidation | optional | Bool | doc m%"
SkipSchemaValidation skips JSON schema validation (Helm's --skip-schema-validation)
"%,
                skipTests | optional | Bool | doc "SkipTests skips test manifest installation step (Helm's --skip-tests).",
                valueFiles | optional | Array String | doc "ValuesFiles is a list of Helm value files to use when generating a template",
                values | optional | String | doc m%"
Values specifies Helm values to be passed to helm template, typically defined as a block. ValuesObject takes precedence over Values, so use one or the other.
"%,
                valuesObject | optional | {
                } | doc m%"
ValuesObject specifies Helm values to be passed to helm template, defined as a map. This takes precedence over Values.
"%,
                version | optional | String | doc "Version is the Helm version to use for templating (\"3\")",
              } | doc "Helm holds helm specific options",
              kustomize | optional | {
                apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
                commonAnnotations | optional | {
                } | doc m%"
CommonAnnotations is a list of additional annotations to add to rendered manifests
"%,
                commonAnnotationsEnvsubst | optional | Bool | doc m%"
CommonAnnotationsEnvsubst specifies whether to apply env variables substitution for annotation values
"%,
                commonLabels | optional | {
                } | doc "CommonLabels is a list of additional labels to add to rendered manifests",
                components | optional | Array String | doc m%"
Components specifies a list of kustomize components to add to the kustomization before building
"%,
                forceCommonAnnotations | optional | Bool | doc m%"
ForceCommonAnnotations specifies whether to force applying common annotations to resources for Kustomize apps
"%,
                forceCommonLabels | optional | Bool | doc m%"
ForceCommonLabels specifies whether to force applying common labels to resources for Kustomize apps
"%,
                ignoreMissingComponents | optional | Bool | doc m%"
IgnoreMissingComponents prevents kustomize from failing when components do not exist locally by not appending them to kustomization file
"%,
                images | optional | Array String | doc "Images is a list of Kustomize image override specifications",
                kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
                labelIncludeTemplates | optional | Bool | doc m%"
LabelIncludeTemplates specifies whether to apply common labels to resource templates or not
"%,
                labelWithoutSelector | optional | Bool | doc m%"
LabelWithoutSelector specifies whether to apply common labels to resource selectors or not
"%,
                namePrefix | optional | String | doc "NamePrefix is a prefix appended to resources for Kustomize apps",
                nameSuffix | optional | String | doc "NameSuffix is a suffix appended to resources for Kustomize apps",
                namespace | optional | String | doc "Namespace sets the namespace that Kustomize adds to all resources",
                patches | optional | Array {
                  options | optional | {
                  },
                  patch | optional | String,
                  path | optional | String,
                  target | optional | {
                    annotationSelector | optional | String,
                    group | optional | String,
                    kind | optional | String,
                    labelSelector | optional | String,
                    name | optional | String,
                    namespace | optional | String,
                    version | optional | String,
                  },
                } | doc "Patches is a list of Kustomize patches",
                replicas | optional | Array {
                  count | Number | String | doc "Number of replicas",
                  name | String | doc "Name of Deployment or StatefulSet",
                } | doc "Replicas is a list of Kustomize Replicas override specifications",
                version | optional | String | doc "Version controls which version of Kustomize to use for rendering manifests",
              } | doc "Kustomize holds kustomize specific options",
              name | optional | String | doc m%"
Name is used to refer to a source and is displayed in the UI. It is used in multi-source Applications.
"%,
              path | optional | String | doc m%"
Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
"%,
              plugin | optional | {
                env | optional | Array k8s_io_envvar.EnvVar | doc "Env is a list of environment variable entries",
                name | optional | String,
                parameters | optional | Array {
                  array | optional | Array String | doc "Array is the value of an array type parameter.",
                  map | optional | {
                  } | doc "Map is the value of a map type parameter.",
                  name | optional | String | doc "Name is the name identifying a parameter.",
                  string | optional | String | doc "String_ is the value of a string type parameter.",
                },
              } | doc "Plugin holds config management plugin specific options",
              ref | optional | String | doc m%"
Ref is reference to another source within sources field. This field will not be used if used with a `source` tag.
"%,
              repoURL | String | doc m%"
RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
"%,
              targetRevision | optional | String | doc m%"
TargetRevision defines the revision of the source to sync the application to.
In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD.
In case of Helm, this is a semver tag for the Chart's version.
"%,
            } | doc m%"
Source overrides the source definition set in the application.
This is typically set in a Rollback operation and is nil during a Sync operation
"%,
            sources | optional | Array {
              chart | optional | String | doc m%"
Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
"%,
              directory | optional | {
                exclude | optional | String | doc m%"
Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
"%,
                include | optional | String | doc m%"
Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
"%,
                jsonnet | optional | {
                  extVars | optional | Array {
                    code | optional | Bool,
                    name | String,
                    value | String,
                  } | doc "ExtVars is a list of Jsonnet External Variables",
                  libs | optional | Array String | doc "Additional library search dirs",
                  tlas | optional | Array {
                    code | optional | Bool,
                    name | String,
                    value | String,
                  } | doc "TLAS is a list of Jsonnet Top-level Arguments",
                } | doc "Jsonnet holds options specific to Jsonnet",
                recurse | optional | Bool | doc "Recurse specifies whether to scan a directory recursively for manifests",
              } | doc "Directory holds path/directory specific options",
              helm | optional | {
                apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
                fileParameters | optional | Array {
                  name | optional | String | doc "Name is the name of the Helm parameter",
                  path | optional | String | doc "Path is the path to the file containing the values for the Helm parameter",
                } | doc "FileParameters are file parameters to the helm template",
                ignoreMissingValueFiles | optional | Bool | doc m%"
IgnoreMissingValueFiles prevents helm template from failing when valueFiles do not exist locally by not appending them to helm template --values
"%,
                kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
                namespace | optional | String | doc m%"
Namespace is an optional namespace to template with. If left empty, defaults to the app's destination namespace.
"%,
                parameters | optional | Array {
                  forceString | optional | Bool | doc m%"
ForceString determines whether to tell Helm to interpret booleans and numbers as strings
"%,
                  name | optional | String | doc "Name is the name of the Helm parameter",
                  value | optional | String | doc "Value is the value for the Helm parameter",
                } | doc m%"
Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
"%,
                passCredentials | optional | Bool | doc "PassCredentials pass credentials to all domains (Helm's --pass-credentials)",
                releaseName | optional | String | doc m%"
ReleaseName is the Helm release name to use. If omitted it will use the application name
"%,
                skipCrds | optional | Bool | doc "SkipCrds skips custom resource definition installation step (Helm's --skip-crds)",
                skipSchemaValidation | optional | Bool | doc m%"
SkipSchemaValidation skips JSON schema validation (Helm's --skip-schema-validation)
"%,
                skipTests | optional | Bool | doc "SkipTests skips test manifest installation step (Helm's --skip-tests).",
                valueFiles | optional | Array String | doc "ValuesFiles is a list of Helm value files to use when generating a template",
                values | optional | String | doc m%"
Values specifies Helm values to be passed to helm template, typically defined as a block. ValuesObject takes precedence over Values, so use one or the other.
"%,
                valuesObject | optional | {
                } | doc m%"
ValuesObject specifies Helm values to be passed to helm template, defined as a map. This takes precedence over Values.
"%,
                version | optional | String | doc "Version is the Helm version to use for templating (\"3\")",
              } | doc "Helm holds helm specific options",
              kustomize | optional | {
                apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
                commonAnnotations | optional | {
                } | doc m%"
CommonAnnotations is a list of additional annotations to add to rendered manifests
"%,
                commonAnnotationsEnvsubst | optional | Bool | doc m%"
CommonAnnotationsEnvsubst specifies whether to apply env variables substitution for annotation values
"%,
                commonLabels | optional | {
                } | doc "CommonLabels is a list of additional labels to add to rendered manifests",
                components | optional | Array String | doc m%"
Components specifies a list of kustomize components to add to the kustomization before building
"%,
                forceCommonAnnotations | optional | Bool | doc m%"
ForceCommonAnnotations specifies whether to force applying common annotations to resources for Kustomize apps
"%,
                forceCommonLabels | optional | Bool | doc m%"
ForceCommonLabels specifies whether to force applying common labels to resources for Kustomize apps
"%,
                ignoreMissingComponents | optional | Bool | doc m%"
IgnoreMissingComponents prevents kustomize from failing when components do not exist locally by not appending them to kustomization file
"%,
                images | optional | Array String | doc "Images is a list of Kustomize image override specifications",
                kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
                labelIncludeTemplates | optional | Bool | doc m%"
LabelIncludeTemplates specifies whether to apply common labels to resource templates or not
"%,
                labelWithoutSelector | optional | Bool | doc m%"
LabelWithoutSelector specifies whether to apply common labels to resource selectors or not
"%,
                namePrefix | optional | String | doc "NamePrefix is a prefix appended to resources for Kustomize apps",
                nameSuffix | optional | String | doc "NameSuffix is a suffix appended to resources for Kustomize apps",
                namespace | optional | String | doc "Namespace sets the namespace that Kustomize adds to all resources",
                patches | optional | Array {
                  options | optional | {
                  },
                  patch | optional | String,
                  path | optional | String,
                  target | optional | {
                    annotationSelector | optional | String,
                    group | optional | String,
                    kind | optional | String,
                    labelSelector | optional | String,
                    name | optional | String,
                    namespace | optional | String,
                    version | optional | String,
                  },
                } | doc "Patches is a list of Kustomize patches",
                replicas | optional | Array {
                  count | Number | String | doc "Number of replicas",
                  name | String | doc "Name of Deployment or StatefulSet",
                } | doc "Replicas is a list of Kustomize Replicas override specifications",
                version | optional | String | doc "Version controls which version of Kustomize to use for rendering manifests",
              } | doc "Kustomize holds kustomize specific options",
              name | optional | String | doc m%"
Name is used to refer to a source and is displayed in the UI. It is used in multi-source Applications.
"%,
              path | optional | String | doc m%"
Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
"%,
              plugin | optional | {
                env | optional | Array k8s_io_envvar.EnvVar | doc "Env is a list of environment variable entries",
                name | optional | String,
                parameters | optional | Array {
                  array | optional | Array String | doc "Array is the value of an array type parameter.",
                  map | optional | {
                  } | doc "Map is the value of a map type parameter.",
                  name | optional | String | doc "Name is the name identifying a parameter.",
                  string | optional | String | doc "String_ is the value of a string type parameter.",
                },
              } | doc "Plugin holds config management plugin specific options",
              ref | optional | String | doc m%"
Ref is reference to another source within sources field. This field will not be used if used with a `source` tag.
"%,
              repoURL | String | doc m%"
RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
"%,
              targetRevision | optional | String | doc m%"
TargetRevision defines the revision of the source to sync the application to.
In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD.
In case of Helm, this is a semver tag for the Chart's version.
"%,
            } | doc m%"
Sources overrides the source definition set in the application.
This is typically set in a Rollback operation and is nil during a Sync operation
"%,
            syncOptions | optional | Array String | doc "SyncOptions provide per-sync sync-options, e.g. Validate=false",
            syncStrategy | optional | {
              apply | optional | {
                force | optional | Bool | doc m%"
Force indicates whether or not to supply the --force flag to `kubectl apply`.
The --force flag deletes and re-create the resource, when PATCH encounters conflict and has
retried for 5 times.
"%,
              } | doc "Apply will perform a `kubectl apply` to perform the sync.",
              hook | optional | {
                force | optional | Bool | doc m%"
Force indicates whether or not to supply the --force flag to `kubectl apply`.
The --force flag deletes and re-create the resource, when PATCH encounters conflict and has
retried for 5 times.
"%,
              } | doc m%"
Hook will submit any referenced resources to perform the sync. This is the default strategy
"%,
            } | doc "SyncStrategy describes how to perform the sync",
          } | doc "Sync contains parameters for the operation",
        } | doc "Operation is the original requested operation",
        phase | String | doc "Phase is the current phase of the operation",
        retryCount | optional | Number | doc "RetryCount contains time of operation retries",
        startedAt | String | doc "StartedAt contains time of operation start",
        syncResult | optional | {
          managedNamespaceMetadata | optional | {
            annotations | optional | {
            },
            labels | optional | {
            },
          } | doc m%"
ManagedNamespaceMetadata contains the current sync state of managed namespace metadata
"%,
          resources | optional | Array {
            group | String | doc "Group specifies the API group of the resource",
            hookPhase | optional | String | doc m%"
HookPhase contains the state of any operation associated with this resource OR hook
This can also contain values for non-hook resources.
"%,
            hookType | optional | String | doc "HookType specifies the type of the hook. Empty for non-hook resources",
            images | optional | Array String | doc "Images contains the images related to the ResourceResult",
            kind | String | doc "Kind specifies the API kind of the resource",
            message | optional | String | doc m%"
Message contains an informational or error message for the last sync OR operation
"%,
            name | String | doc "Name specifies the name of the resource",
            namespace | String | doc "Namespace specifies the target namespace of the resource",
            status | optional | String | doc m%"
Status holds the final result of the sync. Will be empty if the resources is yet to be applied/pruned and is always zero-value for hooks
"%,
            syncPhase | optional | String | doc m%"
SyncPhase indicates the particular phase of the sync that this result was acquired in
"%,
            version | String | doc "Version specifies the API version of the resource",
          } | doc m%"
Resources contains a list of sync result items for each individual resource in a sync operation
"%,
          revision | String | doc "Revision holds the revision this sync operation was performed to",
          revisions | optional | Array String | doc m%"
Revisions holds the revision this sync operation was performed for respective indexed source in sources field
"%,
          source | optional | {
            chart | optional | String | doc m%"
Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
"%,
            directory | optional | {
              exclude | optional | String | doc m%"
Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
"%,
              include | optional | String | doc m%"
Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
"%,
              jsonnet | optional | {
                extVars | optional | Array {
                  code | optional | Bool,
                  name | String,
                  value | String,
                } | doc "ExtVars is a list of Jsonnet External Variables",
                libs | optional | Array String | doc "Additional library search dirs",
                tlas | optional | Array {
                  code | optional | Bool,
                  name | String,
                  value | String,
                } | doc "TLAS is a list of Jsonnet Top-level Arguments",
              } | doc "Jsonnet holds options specific to Jsonnet",
              recurse | optional | Bool | doc "Recurse specifies whether to scan a directory recursively for manifests",
            } | doc "Directory holds path/directory specific options",
            helm | optional | {
              apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
              fileParameters | optional | Array {
                name | optional | String | doc "Name is the name of the Helm parameter",
                path | optional | String | doc "Path is the path to the file containing the values for the Helm parameter",
              } | doc "FileParameters are file parameters to the helm template",
              ignoreMissingValueFiles | optional | Bool | doc m%"
IgnoreMissingValueFiles prevents helm template from failing when valueFiles do not exist locally by not appending them to helm template --values
"%,
              kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
              namespace | optional | String | doc m%"
Namespace is an optional namespace to template with. If left empty, defaults to the app's destination namespace.
"%,
              parameters | optional | Array {
                forceString | optional | Bool | doc m%"
ForceString determines whether to tell Helm to interpret booleans and numbers as strings
"%,
                name | optional | String | doc "Name is the name of the Helm parameter",
                value | optional | String | doc "Value is the value for the Helm parameter",
              } | doc m%"
Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
"%,
              passCredentials | optional | Bool | doc "PassCredentials pass credentials to all domains (Helm's --pass-credentials)",
              releaseName | optional | String | doc m%"
ReleaseName is the Helm release name to use. If omitted it will use the application name
"%,
              skipCrds | optional | Bool | doc "SkipCrds skips custom resource definition installation step (Helm's --skip-crds)",
              skipSchemaValidation | optional | Bool | doc m%"
SkipSchemaValidation skips JSON schema validation (Helm's --skip-schema-validation)
"%,
              skipTests | optional | Bool | doc "SkipTests skips test manifest installation step (Helm's --skip-tests).",
              valueFiles | optional | Array String | doc "ValuesFiles is a list of Helm value files to use when generating a template",
              values | optional | String | doc m%"
Values specifies Helm values to be passed to helm template, typically defined as a block. ValuesObject takes precedence over Values, so use one or the other.
"%,
              valuesObject | optional | {
              } | doc m%"
ValuesObject specifies Helm values to be passed to helm template, defined as a map. This takes precedence over Values.
"%,
              version | optional | String | doc "Version is the Helm version to use for templating (\"3\")",
            } | doc "Helm holds helm specific options",
            kustomize | optional | {
              apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
              commonAnnotations | optional | {
              } | doc m%"
CommonAnnotations is a list of additional annotations to add to rendered manifests
"%,
              commonAnnotationsEnvsubst | optional | Bool | doc m%"
CommonAnnotationsEnvsubst specifies whether to apply env variables substitution for annotation values
"%,
              commonLabels | optional | {
              } | doc "CommonLabels is a list of additional labels to add to rendered manifests",
              components | optional | Array String | doc m%"
Components specifies a list of kustomize components to add to the kustomization before building
"%,
              forceCommonAnnotations | optional | Bool | doc m%"
ForceCommonAnnotations specifies whether to force applying common annotations to resources for Kustomize apps
"%,
              forceCommonLabels | optional | Bool | doc m%"
ForceCommonLabels specifies whether to force applying common labels to resources for Kustomize apps
"%,
              ignoreMissingComponents | optional | Bool | doc m%"
IgnoreMissingComponents prevents kustomize from failing when components do not exist locally by not appending them to kustomization file
"%,
              images | optional | Array String | doc "Images is a list of Kustomize image override specifications",
              kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
              labelIncludeTemplates | optional | Bool | doc m%"
LabelIncludeTemplates specifies whether to apply common labels to resource templates or not
"%,
              labelWithoutSelector | optional | Bool | doc m%"
LabelWithoutSelector specifies whether to apply common labels to resource selectors or not
"%,
              namePrefix | optional | String | doc "NamePrefix is a prefix appended to resources for Kustomize apps",
              nameSuffix | optional | String | doc "NameSuffix is a suffix appended to resources for Kustomize apps",
              namespace | optional | String | doc "Namespace sets the namespace that Kustomize adds to all resources",
              patches | optional | Array {
                options | optional | {
                },
                patch | optional | String,
                path | optional | String,
                target | optional | {
                  annotationSelector | optional | String,
                  group | optional | String,
                  kind | optional | String,
                  labelSelector | optional | String,
                  name | optional | String,
                  namespace | optional | String,
                  version | optional | String,
                },
              } | doc "Patches is a list of Kustomize patches",
              replicas | optional | Array {
                count | Number | String | doc "Number of replicas",
                name | String | doc "Name of Deployment or StatefulSet",
              } | doc "Replicas is a list of Kustomize Replicas override specifications",
              version | optional | String | doc "Version controls which version of Kustomize to use for rendering manifests",
            } | doc "Kustomize holds kustomize specific options",
            name | optional | String | doc m%"
Name is used to refer to a source and is displayed in the UI. It is used in multi-source Applications.
"%,
            path | optional | String | doc m%"
Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
"%,
            plugin | optional | {
              env | optional | Array k8s_io_envvar.EnvVar | doc "Env is a list of environment variable entries",
              name | optional | String,
              parameters | optional | Array {
                array | optional | Array String | doc "Array is the value of an array type parameter.",
                map | optional | {
                } | doc "Map is the value of a map type parameter.",
                name | optional | String | doc "Name is the name identifying a parameter.",
                string | optional | String | doc "String_ is the value of a string type parameter.",
              },
            } | doc "Plugin holds config management plugin specific options",
            ref | optional | String | doc m%"
Ref is reference to another source within sources field. This field will not be used if used with a `source` tag.
"%,
            repoURL | String | doc m%"
RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
"%,
            targetRevision | optional | String | doc m%"
TargetRevision defines the revision of the source to sync the application to.
In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD.
In case of Helm, this is a semver tag for the Chart's version.
"%,
          } | doc m%"
Source records the application source information of the sync, used for comparing auto-sync
"%,
          sources | optional | Array {
            chart | optional | String | doc m%"
Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
"%,
            directory | optional | {
              exclude | optional | String | doc m%"
Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
"%,
              include | optional | String | doc m%"
Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
"%,
              jsonnet | optional | {
                extVars | optional | Array {
                  code | optional | Bool,
                  name | String,
                  value | String,
                } | doc "ExtVars is a list of Jsonnet External Variables",
                libs | optional | Array String | doc "Additional library search dirs",
                tlas | optional | Array {
                  code | optional | Bool,
                  name | String,
                  value | String,
                } | doc "TLAS is a list of Jsonnet Top-level Arguments",
              } | doc "Jsonnet holds options specific to Jsonnet",
              recurse | optional | Bool | doc "Recurse specifies whether to scan a directory recursively for manifests",
            } | doc "Directory holds path/directory specific options",
            helm | optional | {
              apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
              fileParameters | optional | Array {
                name | optional | String | doc "Name is the name of the Helm parameter",
                path | optional | String | doc "Path is the path to the file containing the values for the Helm parameter",
              } | doc "FileParameters are file parameters to the helm template",
              ignoreMissingValueFiles | optional | Bool | doc m%"
IgnoreMissingValueFiles prevents helm template from failing when valueFiles do not exist locally by not appending them to helm template --values
"%,
              kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
              namespace | optional | String | doc m%"
Namespace is an optional namespace to template with. If left empty, defaults to the app's destination namespace.
"%,
              parameters | optional | Array {
                forceString | optional | Bool | doc m%"
ForceString determines whether to tell Helm to interpret booleans and numbers as strings
"%,
                name | optional | String | doc "Name is the name of the Helm parameter",
                value | optional | String | doc "Value is the value for the Helm parameter",
              } | doc m%"
Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
"%,
              passCredentials | optional | Bool | doc "PassCredentials pass credentials to all domains (Helm's --pass-credentials)",
              releaseName | optional | String | doc m%"
ReleaseName is the Helm release name to use. If omitted it will use the application name
"%,
              skipCrds | optional | Bool | doc "SkipCrds skips custom resource definition installation step (Helm's --skip-crds)",
              skipSchemaValidation | optional | Bool | doc m%"
SkipSchemaValidation skips JSON schema validation (Helm's --skip-schema-validation)
"%,
              skipTests | optional | Bool | doc "SkipTests skips test manifest installation step (Helm's --skip-tests).",
              valueFiles | optional | Array String | doc "ValuesFiles is a list of Helm value files to use when generating a template",
              values | optional | String | doc m%"
Values specifies Helm values to be passed to helm template, typically defined as a block. ValuesObject takes precedence over Values, so use one or the other.
"%,
              valuesObject | optional | {
              } | doc m%"
ValuesObject specifies Helm values to be passed to helm template, defined as a map. This takes precedence over Values.
"%,
              version | optional | String | doc "Version is the Helm version to use for templating (\"3\")",
            } | doc "Helm holds helm specific options",
            kustomize | optional | {
              apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
              commonAnnotations | optional | {
              } | doc m%"
CommonAnnotations is a list of additional annotations to add to rendered manifests
"%,
              commonAnnotationsEnvsubst | optional | Bool | doc m%"
CommonAnnotationsEnvsubst specifies whether to apply env variables substitution for annotation values
"%,
              commonLabels | optional | {
              } | doc "CommonLabels is a list of additional labels to add to rendered manifests",
              components | optional | Array String | doc m%"
Components specifies a list of kustomize components to add to the kustomization before building
"%,
              forceCommonAnnotations | optional | Bool | doc m%"
ForceCommonAnnotations specifies whether to force applying common annotations to resources for Kustomize apps
"%,
              forceCommonLabels | optional | Bool | doc m%"
ForceCommonLabels specifies whether to force applying common labels to resources for Kustomize apps
"%,
              ignoreMissingComponents | optional | Bool | doc m%"
IgnoreMissingComponents prevents kustomize from failing when components do not exist locally by not appending them to kustomization file
"%,
              images | optional | Array String | doc "Images is a list of Kustomize image override specifications",
              kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
              labelIncludeTemplates | optional | Bool | doc m%"
LabelIncludeTemplates specifies whether to apply common labels to resource templates or not
"%,
              labelWithoutSelector | optional | Bool | doc m%"
LabelWithoutSelector specifies whether to apply common labels to resource selectors or not
"%,
              namePrefix | optional | String | doc "NamePrefix is a prefix appended to resources for Kustomize apps",
              nameSuffix | optional | String | doc "NameSuffix is a suffix appended to resources for Kustomize apps",
              namespace | optional | String | doc "Namespace sets the namespace that Kustomize adds to all resources",
              patches | optional | Array {
                options | optional | {
                },
                patch | optional | String,
                path | optional | String,
                target | optional | {
                  annotationSelector | optional | String,
                  group | optional | String,
                  kind | optional | String,
                  labelSelector | optional | String,
                  name | optional | String,
                  namespace | optional | String,
                  version | optional | String,
                },
              } | doc "Patches is a list of Kustomize patches",
              replicas | optional | Array {
                count | Number | String | doc "Number of replicas",
                name | String | doc "Name of Deployment or StatefulSet",
              } | doc "Replicas is a list of Kustomize Replicas override specifications",
              version | optional | String | doc "Version controls which version of Kustomize to use for rendering manifests",
            } | doc "Kustomize holds kustomize specific options",
            name | optional | String | doc m%"
Name is used to refer to a source and is displayed in the UI. It is used in multi-source Applications.
"%,
            path | optional | String | doc m%"
Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
"%,
            plugin | optional | {
              env | optional | Array k8s_io_envvar.EnvVar | doc "Env is a list of environment variable entries",
              name | optional | String,
              parameters | optional | Array {
                array | optional | Array String | doc "Array is the value of an array type parameter.",
                map | optional | {
                } | doc "Map is the value of a map type parameter.",
                name | optional | String | doc "Name is the name identifying a parameter.",
                string | optional | String | doc "String_ is the value of a string type parameter.",
              },
            } | doc "Plugin holds config management plugin specific options",
            ref | optional | String | doc m%"
Ref is reference to another source within sources field. This field will not be used if used with a `source` tag.
"%,
            repoURL | String | doc m%"
RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
"%,
            targetRevision | optional | String | doc m%"
TargetRevision defines the revision of the source to sync the application to.
In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD.
In case of Helm, this is a semver tag for the Chart's version.
"%,
          } | doc m%"
Source records the application source information of the sync, used for comparing auto-sync
"%,
        } | doc "SyncResult is the result of a Sync operation",
      } | doc "OperationState contains information about any ongoing operations, such as a sync",
      reconciledAt | optional | String | doc m%"
ReconciledAt indicates when the application state was reconciled using the latest git version
"%,
      resourceHealthSource | optional | String | doc m%"
ResourceHealthSource indicates where the resource health status is stored: inline if not set or appTree
"%,
      resources | optional | Array {
        group | optional | String | doc "Group represents the API group of the resource (e.g., \"apps\" for Deployments).",
        health | optional | {
          lastTransitionTime | optional | String | doc m%"
LastTransitionTime is the time the HealthStatus was set or updated

Deprecated: this field is not used and will be removed in a future release.
"%,
          message | optional | String | doc "Message is a human-readable informational message describing the health status",
          status | optional | String | doc "Status holds the status code of the resource",
        } | doc m%"
Health indicates the health status of the resource (e.g., Healthy, Degraded, Progressing).
"%,
        hook | optional | Bool | doc m%"
Hook is true if the resource is used as a lifecycle hook in an Argo CD application.
"%,
        kind | optional | String | doc "Kind specifies the type of the resource (e.g., \"Deployment\", \"Service\").",
        name | optional | String | doc "Name is the unique name of the resource within the namespace.",
        namespace | optional | String | doc "Namespace defines the Kubernetes namespace where the resource is located.",
        requiresDeletionConfirmation | optional | Bool | doc m%"
RequiresDeletionConfirmation is true if the resource requires explicit user confirmation before deletion.
"%,
        requiresPruning | optional | Bool | doc m%"
RequiresPruning is true if the resource needs to be pruned (deleted) as part of synchronization.
"%,
        status | optional | String | doc m%"
Status represents the synchronization state of the resource (e.g., Synced, OutOfSync).
"%,
        syncWave | optional | Number | doc m%"
SyncWave determines the order in which resources are applied during a sync operation.
Lower values are applied first.
"%,
        version | optional | String | doc "Version indicates the API version of the resource (e.g., \"v1\", \"v1beta1\").",
      } | doc "Resources is a list of Kubernetes resources managed by this application",
      sourceHydrator | optional | {
        currentOperation | optional | {
          drySHA | optional | String | doc m%"
DrySHA holds the resolved revision (sha) of the dry source as of the most recent reconciliation
"%,
          finishedAt | optional | String | doc "FinishedAt indicates when the hydrate operation finished",
          hydratedSHA | optional | String | doc m%"
HydratedSHA holds the resolved revision (sha) of the hydrated source as of the most recent reconciliation
"%,
          message | String | doc m%"
Message contains a message describing the current status of the hydrate operation
"%,
          phase | String | doc "Phase indicates the status of the hydrate operation",
          sourceHydrator | optional | {
            drySource | {
              path | String | doc m%"
Path is a directory path within the Git repository where the manifests are located
"%,
              repoURL | String | doc "RepoURL is the URL to the git repository that contains the application manifests",
              targetRevision | String | doc "TargetRevision defines the revision of the source to hydrate",
            } | doc "DrySource specifies where the dry \"don't repeat yourself\" manifest source lives.",
            hydrateTo | optional | {
              targetBranch | String | doc "TargetBranch is the branch to which hydrated manifests should be committed",
            } | doc m%"
HydrateTo specifies an optional "staging" location to push hydrated manifests to. An external system would then
have to move manifests to the SyncSource, e.g. by pull request.
"%,
            syncSource | {
              path | String | doc m%"
Path is a directory path within the git repository where hydrated manifests should be committed to and synced
from. If hydrateTo is set, this is just the path from which hydrated manifests will be synced.
"%,
              targetBranch | String | doc "TargetBranch is the branch to which hydrated manifests should be committed",
            } | doc "SyncSource specifies where to sync hydrated manifests from.",
          } | doc "SourceHydrator holds the hydrator config used for the hydrate operation",
          startedAt | optional | String | doc "StartedAt indicates when the hydrate operation started",
        } | doc "CurrentOperation holds the status of the hydrate operation",
        lastSuccessfulOperation | optional | {
          drySHA | optional | String | doc m%"
DrySHA holds the resolved revision (sha) of the dry source as of the most recent reconciliation
"%,
          hydratedSHA | optional | String | doc m%"
HydratedSHA holds the resolved revision (sha) of the hydrated source as of the most recent reconciliation
"%,
          sourceHydrator | optional | {
            drySource | {
              path | String | doc m%"
Path is a directory path within the Git repository where the manifests are located
"%,
              repoURL | String | doc "RepoURL is the URL to the git repository that contains the application manifests",
              targetRevision | String | doc "TargetRevision defines the revision of the source to hydrate",
            } | doc "DrySource specifies where the dry \"don't repeat yourself\" manifest source lives.",
            hydrateTo | optional | {
              targetBranch | String | doc "TargetBranch is the branch to which hydrated manifests should be committed",
            } | doc m%"
HydrateTo specifies an optional "staging" location to push hydrated manifests to. An external system would then
have to move manifests to the SyncSource, e.g. by pull request.
"%,
            syncSource | {
              path | String | doc m%"
Path is a directory path within the git repository where hydrated manifests should be committed to and synced
from. If hydrateTo is set, this is just the path from which hydrated manifests will be synced.
"%,
              targetBranch | String | doc "TargetBranch is the branch to which hydrated manifests should be committed",
            } | doc "SyncSource specifies where to sync hydrated manifests from.",
          } | doc "SourceHydrator holds the hydrator config used for the hydrate operation",
        } | doc "LastSuccessfulOperation holds info about the most recent successful hydration",
      } | doc "SourceHydrator stores information about the current state of source hydration",
      sourceType | optional | String | doc "SourceType specifies the type of this application",
      sourceTypes | optional | Array String | doc "SourceTypes specifies the type of the sources included in the application",
      summary | optional | {
        externalURLs | optional | Array String | doc "ExternalURLs holds all external URLs of application child resources.",
        images | optional | Array String | doc "Images holds all images of application child resources.",
      } | doc "Summary contains a list of URLs and container images used by this application",
      sync | optional | {
        comparedTo | optional | {
          destination | {
            name | optional | String | doc m%"
Name is an alternate way of specifying the target cluster by its symbolic name. This must be set if Server is not set.
"%,
            namespace | optional | String | doc m%"
Namespace specifies the target namespace for the application's resources.
The namespace will only be set for namespace-scoped resources that have not set a value for .metadata.namespace
"%,
            server | optional | String | doc m%"
Server specifies the URL of the target cluster's Kubernetes control plane API. This must be set if Name is not set.
"%,
          } | doc "Destination is a reference to the application's destination used for comparison",
          ignoreDifferences | optional | Array {
            group | optional | String,
            jqPathExpressions | optional | Array String,
            jsonPointers | optional | Array String,
            kind | String,
            managedFieldsManagers | optional | Array String | doc m%"
ManagedFieldsManagers is a list of trusted managers. Fields mutated by those managers will take precedence over the
desired state defined in the SCM and won't be displayed in diffs
"%,
            name | optional | String,
            namespace | optional | String,
          } | doc m%"
IgnoreDifferences is a reference to the application's ignored differences used for comparison
"%,
          source | optional | {
            chart | optional | String | doc m%"
Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
"%,
            directory | optional | {
              exclude | optional | String | doc m%"
Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
"%,
              include | optional | String | doc m%"
Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
"%,
              jsonnet | optional | {
                extVars | optional | Array {
                  code | optional | Bool,
                  name | String,
                  value | String,
                } | doc "ExtVars is a list of Jsonnet External Variables",
                libs | optional | Array String | doc "Additional library search dirs",
                tlas | optional | Array {
                  code | optional | Bool,
                  name | String,
                  value | String,
                } | doc "TLAS is a list of Jsonnet Top-level Arguments",
              } | doc "Jsonnet holds options specific to Jsonnet",
              recurse | optional | Bool | doc "Recurse specifies whether to scan a directory recursively for manifests",
            } | doc "Directory holds path/directory specific options",
            helm | optional | {
              apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
              fileParameters | optional | Array {
                name | optional | String | doc "Name is the name of the Helm parameter",
                path | optional | String | doc "Path is the path to the file containing the values for the Helm parameter",
              } | doc "FileParameters are file parameters to the helm template",
              ignoreMissingValueFiles | optional | Bool | doc m%"
IgnoreMissingValueFiles prevents helm template from failing when valueFiles do not exist locally by not appending them to helm template --values
"%,
              kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
              namespace | optional | String | doc m%"
Namespace is an optional namespace to template with. If left empty, defaults to the app's destination namespace.
"%,
              parameters | optional | Array {
                forceString | optional | Bool | doc m%"
ForceString determines whether to tell Helm to interpret booleans and numbers as strings
"%,
                name | optional | String | doc "Name is the name of the Helm parameter",
                value | optional | String | doc "Value is the value for the Helm parameter",
              } | doc m%"
Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
"%,
              passCredentials | optional | Bool | doc "PassCredentials pass credentials to all domains (Helm's --pass-credentials)",
              releaseName | optional | String | doc m%"
ReleaseName is the Helm release name to use. If omitted it will use the application name
"%,
              skipCrds | optional | Bool | doc "SkipCrds skips custom resource definition installation step (Helm's --skip-crds)",
              skipSchemaValidation | optional | Bool | doc m%"
SkipSchemaValidation skips JSON schema validation (Helm's --skip-schema-validation)
"%,
              skipTests | optional | Bool | doc "SkipTests skips test manifest installation step (Helm's --skip-tests).",
              valueFiles | optional | Array String | doc "ValuesFiles is a list of Helm value files to use when generating a template",
              values | optional | String | doc m%"
Values specifies Helm values to be passed to helm template, typically defined as a block. ValuesObject takes precedence over Values, so use one or the other.
"%,
              valuesObject | optional | {
              } | doc m%"
ValuesObject specifies Helm values to be passed to helm template, defined as a map. This takes precedence over Values.
"%,
              version | optional | String | doc "Version is the Helm version to use for templating (\"3\")",
            } | doc "Helm holds helm specific options",
            kustomize | optional | {
              apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
              commonAnnotations | optional | {
              } | doc m%"
CommonAnnotations is a list of additional annotations to add to rendered manifests
"%,
              commonAnnotationsEnvsubst | optional | Bool | doc m%"
CommonAnnotationsEnvsubst specifies whether to apply env variables substitution for annotation values
"%,
              commonLabels | optional | {
              } | doc "CommonLabels is a list of additional labels to add to rendered manifests",
              components | optional | Array String | doc m%"
Components specifies a list of kustomize components to add to the kustomization before building
"%,
              forceCommonAnnotations | optional | Bool | doc m%"
ForceCommonAnnotations specifies whether to force applying common annotations to resources for Kustomize apps
"%,
              forceCommonLabels | optional | Bool | doc m%"
ForceCommonLabels specifies whether to force applying common labels to resources for Kustomize apps
"%,
              ignoreMissingComponents | optional | Bool | doc m%"
IgnoreMissingComponents prevents kustomize from failing when components do not exist locally by not appending them to kustomization file
"%,
              images | optional | Array String | doc "Images is a list of Kustomize image override specifications",
              kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
              labelIncludeTemplates | optional | Bool | doc m%"
LabelIncludeTemplates specifies whether to apply common labels to resource templates or not
"%,
              labelWithoutSelector | optional | Bool | doc m%"
LabelWithoutSelector specifies whether to apply common labels to resource selectors or not
"%,
              namePrefix | optional | String | doc "NamePrefix is a prefix appended to resources for Kustomize apps",
              nameSuffix | optional | String | doc "NameSuffix is a suffix appended to resources for Kustomize apps",
              namespace | optional | String | doc "Namespace sets the namespace that Kustomize adds to all resources",
              patches | optional | Array {
                options | optional | {
                },
                patch | optional | String,
                path | optional | String,
                target | optional | {
                  annotationSelector | optional | String,
                  group | optional | String,
                  kind | optional | String,
                  labelSelector | optional | String,
                  name | optional | String,
                  namespace | optional | String,
                  version | optional | String,
                },
              } | doc "Patches is a list of Kustomize patches",
              replicas | optional | Array {
                count | Number | String | doc "Number of replicas",
                name | String | doc "Name of Deployment or StatefulSet",
              } | doc "Replicas is a list of Kustomize Replicas override specifications",
              version | optional | String | doc "Version controls which version of Kustomize to use for rendering manifests",
            } | doc "Kustomize holds kustomize specific options",
            name | optional | String | doc m%"
Name is used to refer to a source and is displayed in the UI. It is used in multi-source Applications.
"%,
            path | optional | String | doc m%"
Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
"%,
            plugin | optional | {
              env | optional | Array k8s_io_envvar.EnvVar | doc "Env is a list of environment variable entries",
              name | optional | String,
              parameters | optional | Array {
                array | optional | Array String | doc "Array is the value of an array type parameter.",
                map | optional | {
                } | doc "Map is the value of a map type parameter.",
                name | optional | String | doc "Name is the name identifying a parameter.",
                string | optional | String | doc "String_ is the value of a string type parameter.",
              },
            } | doc "Plugin holds config management plugin specific options",
            ref | optional | String | doc m%"
Ref is reference to another source within sources field. This field will not be used if used with a `source` tag.
"%,
            repoURL | String | doc m%"
RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
"%,
            targetRevision | optional | String | doc m%"
TargetRevision defines the revision of the source to sync the application to.
In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD.
In case of Helm, this is a semver tag for the Chart's version.
"%,
          } | doc "Source is a reference to the application's source used for comparison",
          sources | optional | Array {
            chart | optional | String | doc m%"
Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
"%,
            directory | optional | {
              exclude | optional | String | doc m%"
Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
"%,
              include | optional | String | doc m%"
Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
"%,
              jsonnet | optional | {
                extVars | optional | Array {
                  code | optional | Bool,
                  name | String,
                  value | String,
                } | doc "ExtVars is a list of Jsonnet External Variables",
                libs | optional | Array String | doc "Additional library search dirs",
                tlas | optional | Array {
                  code | optional | Bool,
                  name | String,
                  value | String,
                } | doc "TLAS is a list of Jsonnet Top-level Arguments",
              } | doc "Jsonnet holds options specific to Jsonnet",
              recurse | optional | Bool | doc "Recurse specifies whether to scan a directory recursively for manifests",
            } | doc "Directory holds path/directory specific options",
            helm | optional | {
              apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
              fileParameters | optional | Array {
                name | optional | String | doc "Name is the name of the Helm parameter",
                path | optional | String | doc "Path is the path to the file containing the values for the Helm parameter",
              } | doc "FileParameters are file parameters to the helm template",
              ignoreMissingValueFiles | optional | Bool | doc m%"
IgnoreMissingValueFiles prevents helm template from failing when valueFiles do not exist locally by not appending them to helm template --values
"%,
              kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
              namespace | optional | String | doc m%"
Namespace is an optional namespace to template with. If left empty, defaults to the app's destination namespace.
"%,
              parameters | optional | Array {
                forceString | optional | Bool | doc m%"
ForceString determines whether to tell Helm to interpret booleans and numbers as strings
"%,
                name | optional | String | doc "Name is the name of the Helm parameter",
                value | optional | String | doc "Value is the value for the Helm parameter",
              } | doc m%"
Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
"%,
              passCredentials | optional | Bool | doc "PassCredentials pass credentials to all domains (Helm's --pass-credentials)",
              releaseName | optional | String | doc m%"
ReleaseName is the Helm release name to use. If omitted it will use the application name
"%,
              skipCrds | optional | Bool | doc "SkipCrds skips custom resource definition installation step (Helm's --skip-crds)",
              skipSchemaValidation | optional | Bool | doc m%"
SkipSchemaValidation skips JSON schema validation (Helm's --skip-schema-validation)
"%,
              skipTests | optional | Bool | doc "SkipTests skips test manifest installation step (Helm's --skip-tests).",
              valueFiles | optional | Array String | doc "ValuesFiles is a list of Helm value files to use when generating a template",
              values | optional | String | doc m%"
Values specifies Helm values to be passed to helm template, typically defined as a block. ValuesObject takes precedence over Values, so use one or the other.
"%,
              valuesObject | optional | {
              } | doc m%"
ValuesObject specifies Helm values to be passed to helm template, defined as a map. This takes precedence over Values.
"%,
              version | optional | String | doc "Version is the Helm version to use for templating (\"3\")",
            } | doc "Helm holds helm specific options",
            kustomize | optional | {
              apiVersions | optional | Array String | doc m%"
APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,
Argo CD uses the API versions of the target cluster. The format is [group/]version/kind.
"%,
              commonAnnotations | optional | {
              } | doc m%"
CommonAnnotations is a list of additional annotations to add to rendered manifests
"%,
              commonAnnotationsEnvsubst | optional | Bool | doc m%"
CommonAnnotationsEnvsubst specifies whether to apply env variables substitution for annotation values
"%,
              commonLabels | optional | {
              } | doc "CommonLabels is a list of additional labels to add to rendered manifests",
              components | optional | Array String | doc m%"
Components specifies a list of kustomize components to add to the kustomization before building
"%,
              forceCommonAnnotations | optional | Bool | doc m%"
ForceCommonAnnotations specifies whether to force applying common annotations to resources for Kustomize apps
"%,
              forceCommonLabels | optional | Bool | doc m%"
ForceCommonLabels specifies whether to force applying common labels to resources for Kustomize apps
"%,
              ignoreMissingComponents | optional | Bool | doc m%"
IgnoreMissingComponents prevents kustomize from failing when components do not exist locally by not appending them to kustomization file
"%,
              images | optional | Array String | doc "Images is a list of Kustomize image override specifications",
              kubeVersion | optional | String | doc m%"
KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD
uses the Kubernetes version of the target cluster.
"%,
              labelIncludeTemplates | optional | Bool | doc m%"
LabelIncludeTemplates specifies whether to apply common labels to resource templates or not
"%,
              labelWithoutSelector | optional | Bool | doc m%"
LabelWithoutSelector specifies whether to apply common labels to resource selectors or not
"%,
              namePrefix | optional | String | doc "NamePrefix is a prefix appended to resources for Kustomize apps",
              nameSuffix | optional | String | doc "NameSuffix is a suffix appended to resources for Kustomize apps",
              namespace | optional | String | doc "Namespace sets the namespace that Kustomize adds to all resources",
              patches | optional | Array {
                options | optional | {
                },
                patch | optional | String,
                path | optional | String,
                target | optional | {
                  annotationSelector | optional | String,
                  group | optional | String,
                  kind | optional | String,
                  labelSelector | optional | String,
                  name | optional | String,
                  namespace | optional | String,
                  version | optional | String,
                },
              } | doc "Patches is a list of Kustomize patches",
              replicas | optional | Array {
                count | Number | String | doc "Number of replicas",
                name | String | doc "Name of Deployment or StatefulSet",
              } | doc "Replicas is a list of Kustomize Replicas override specifications",
              version | optional | String | doc "Version controls which version of Kustomize to use for rendering manifests",
            } | doc "Kustomize holds kustomize specific options",
            name | optional | String | doc m%"
Name is used to refer to a source and is displayed in the UI. It is used in multi-source Applications.
"%,
            path | optional | String | doc m%"
Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
"%,
            plugin | optional | {
              env | optional | Array k8s_io_envvar.EnvVar | doc "Env is a list of environment variable entries",
              name | optional | String,
              parameters | optional | Array {
                array | optional | Array String | doc "Array is the value of an array type parameter.",
                map | optional | {
                } | doc "Map is the value of a map type parameter.",
                name | optional | String | doc "Name is the name identifying a parameter.",
                string | optional | String | doc "String_ is the value of a string type parameter.",
              },
            } | doc "Plugin holds config management plugin specific options",
            ref | optional | String | doc m%"
Ref is reference to another source within sources field. This field will not be used if used with a `source` tag.
"%,
            repoURL | String | doc m%"
RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
"%,
            targetRevision | optional | String | doc m%"
TargetRevision defines the revision of the source to sync the application to.
In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD.
In case of Helm, this is a semver tag for the Chart's version.
"%,
          } | doc "Sources is a reference to the application's multiple sources used for comparison",
        } | doc "ComparedTo contains information about what has been compared",
        revision | optional | String | doc m%"
Revision contains information about the revision the comparison has been performed to
"%,
        revisions | optional | Array String | doc m%"
Revisions contains information about the revisions of multiple sources the comparison has been performed to
"%,
        status | String | doc "Status is the sync state of the comparison",
      } | doc "Sync contains information about the application's current sync status",
    } | doc "ApplicationStatus contains status information for the application",
  },
}
