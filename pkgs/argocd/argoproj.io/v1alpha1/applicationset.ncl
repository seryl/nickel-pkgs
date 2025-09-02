# Module: applicationset.argoproj.io

let k8s_io_objectmeta = import "k8s_io" in
let k8s_io_envvar = import "k8s_io" in

{
  ApplicationSet = {
    apiVersion | optional | String,
    kind | optional | String,
    metadata | k8s_io_objectmeta.ObjectMeta,
    spec | {
      applyNestedSelectors | optional | Bool,
      generators | Array {
        clusterDecisionResource | optional | {
          configMapRef | String,
          labelSelector | optional | {
            matchExpressions | optional | Array {
              key | String,
              operator | String,
              values | optional | Array String,
            },
            matchLabels | optional | {
            },
          },
          name | optional | String,
          requeueAfterSeconds | optional | Number,
          template | optional | {
            metadata | {
              annotations | optional | {
              },
              finalizers | optional | Array String,
              labels | optional | {
              },
              name | optional | String,
              namespace | optional | String,
            },
            spec | {
              destination | {
                name | optional | String,
                namespace | optional | String,
                server | optional | String,
              },
              ignoreDifferences | optional | Array {
                group | optional | String,
                jqPathExpressions | optional | Array String,
                jsonPointers | optional | Array String,
                kind | String,
                managedFieldsManagers | optional | Array String,
                name | optional | String,
                namespace | optional | String,
              },
              info | optional | Array {
                name | String,
                value | String,
              },
              project | String,
              revisionHistoryLimit | optional | Number,
              source | optional | {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              sourceHydrator | optional | {
                drySource | {
                  path | String,
                  repoURL | String,
                  targetRevision | String,
                },
                hydrateTo | optional | {
                  targetBranch | String,
                },
                syncSource | {
                  path | String,
                  targetBranch | String,
                },
              },
              sources | optional | Array {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              syncPolicy | optional | {
                automated | optional | {
                  allowEmpty | optional | Bool,
                  enabled | optional | Bool,
                  prune | optional | Bool,
                  selfHeal | optional | Bool,
                },
                managedNamespaceMetadata | optional | {
                  annotations | optional | {
                  },
                  labels | optional | {
                  },
                },
                retry | optional | {
                  backoff | optional | {
                    duration | optional | String,
                    factor | optional | Number,
                    maxDuration | optional | String,
                  },
                  limit | optional | Number,
                },
                syncOptions | optional | Array String,
              },
            },
          },
          values | optional | {
          },
        },
        clusters | optional | {
          flatList | optional | Bool,
          selector | optional | {
            matchExpressions | optional | Array {
              key | String,
              operator | String,
              values | optional | Array String,
            },
            matchLabels | optional | {
            },
          },
          template | optional | {
            metadata | {
              annotations | optional | {
              },
              finalizers | optional | Array String,
              labels | optional | {
              },
              name | optional | String,
              namespace | optional | String,
            },
            spec | {
              destination | {
                name | optional | String,
                namespace | optional | String,
                server | optional | String,
              },
              ignoreDifferences | optional | Array {
                group | optional | String,
                jqPathExpressions | optional | Array String,
                jsonPointers | optional | Array String,
                kind | String,
                managedFieldsManagers | optional | Array String,
                name | optional | String,
                namespace | optional | String,
              },
              info | optional | Array {
                name | String,
                value | String,
              },
              project | String,
              revisionHistoryLimit | optional | Number,
              source | optional | {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              sourceHydrator | optional | {
                drySource | {
                  path | String,
                  repoURL | String,
                  targetRevision | String,
                },
                hydrateTo | optional | {
                  targetBranch | String,
                },
                syncSource | {
                  path | String,
                  targetBranch | String,
                },
              },
              sources | optional | Array {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              syncPolicy | optional | {
                automated | optional | {
                  allowEmpty | optional | Bool,
                  enabled | optional | Bool,
                  prune | optional | Bool,
                  selfHeal | optional | Bool,
                },
                managedNamespaceMetadata | optional | {
                  annotations | optional | {
                  },
                  labels | optional | {
                  },
                },
                retry | optional | {
                  backoff | optional | {
                    duration | optional | String,
                    factor | optional | Number,
                    maxDuration | optional | String,
                  },
                  limit | optional | Number,
                },
                syncOptions | optional | Array String,
              },
            },
          },
          values | optional | {
          },
        },
        git | optional | {
          directories | optional | Array {
            exclude | optional | Bool,
            path | String,
          },
          files | optional | Array {
            exclude | optional | Bool,
            path | String,
          },
          pathParamPrefix | optional | String,
          repoURL | String,
          requeueAfterSeconds | optional | Number,
          revision | String,
          template | optional | {
            metadata | {
              annotations | optional | {
              },
              finalizers | optional | Array String,
              labels | optional | {
              },
              name | optional | String,
              namespace | optional | String,
            },
            spec | {
              destination | {
                name | optional | String,
                namespace | optional | String,
                server | optional | String,
              },
              ignoreDifferences | optional | Array {
                group | optional | String,
                jqPathExpressions | optional | Array String,
                jsonPointers | optional | Array String,
                kind | String,
                managedFieldsManagers | optional | Array String,
                name | optional | String,
                namespace | optional | String,
              },
              info | optional | Array {
                name | String,
                value | String,
              },
              project | String,
              revisionHistoryLimit | optional | Number,
              source | optional | {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              sourceHydrator | optional | {
                drySource | {
                  path | String,
                  repoURL | String,
                  targetRevision | String,
                },
                hydrateTo | optional | {
                  targetBranch | String,
                },
                syncSource | {
                  path | String,
                  targetBranch | String,
                },
              },
              sources | optional | Array {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              syncPolicy | optional | {
                automated | optional | {
                  allowEmpty | optional | Bool,
                  enabled | optional | Bool,
                  prune | optional | Bool,
                  selfHeal | optional | Bool,
                },
                managedNamespaceMetadata | optional | {
                  annotations | optional | {
                  },
                  labels | optional | {
                  },
                },
                retry | optional | {
                  backoff | optional | {
                    duration | optional | String,
                    factor | optional | Number,
                    maxDuration | optional | String,
                  },
                  limit | optional | Number,
                },
                syncOptions | optional | Array String,
              },
            },
          },
          values | optional | {
          },
        },
        list | optional | {
          elements | optional | Array Dyn,
          elementsYaml | optional | String,
          template | optional | {
            metadata | {
              annotations | optional | {
              },
              finalizers | optional | Array String,
              labels | optional | {
              },
              name | optional | String,
              namespace | optional | String,
            },
            spec | {
              destination | {
                name | optional | String,
                namespace | optional | String,
                server | optional | String,
              },
              ignoreDifferences | optional | Array {
                group | optional | String,
                jqPathExpressions | optional | Array String,
                jsonPointers | optional | Array String,
                kind | String,
                managedFieldsManagers | optional | Array String,
                name | optional | String,
                namespace | optional | String,
              },
              info | optional | Array {
                name | String,
                value | String,
              },
              project | String,
              revisionHistoryLimit | optional | Number,
              source | optional | {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              sourceHydrator | optional | {
                drySource | {
                  path | String,
                  repoURL | String,
                  targetRevision | String,
                },
                hydrateTo | optional | {
                  targetBranch | String,
                },
                syncSource | {
                  path | String,
                  targetBranch | String,
                },
              },
              sources | optional | Array {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              syncPolicy | optional | {
                automated | optional | {
                  allowEmpty | optional | Bool,
                  enabled | optional | Bool,
                  prune | optional | Bool,
                  selfHeal | optional | Bool,
                },
                managedNamespaceMetadata | optional | {
                  annotations | optional | {
                  },
                  labels | optional | {
                  },
                },
                retry | optional | {
                  backoff | optional | {
                    duration | optional | String,
                    factor | optional | Number,
                    maxDuration | optional | String,
                  },
                  limit | optional | Number,
                },
                syncOptions | optional | Array String,
              },
            },
          },
        },
        matrix | optional | {
          generators | Array {
            clusterDecisionResource | optional | {
              configMapRef | String,
              labelSelector | optional | {
                matchExpressions | optional | Array {
                  key | String,
                  operator | String,
                  values | optional | Array String,
                },
                matchLabels | optional | {
                },
              },
              name | optional | String,
              requeueAfterSeconds | optional | Number,
              template | optional | {
                metadata | {
                  annotations | optional | {
                  },
                  finalizers | optional | Array String,
                  labels | optional | {
                  },
                  name | optional | String,
                  namespace | optional | String,
                },
                spec | {
                  destination | {
                    name | optional | String,
                    namespace | optional | String,
                    server | optional | String,
                  },
                  ignoreDifferences | optional | Array {
                    group | optional | String,
                    jqPathExpressions | optional | Array String,
                    jsonPointers | optional | Array String,
                    kind | String,
                    managedFieldsManagers | optional | Array String,
                    name | optional | String,
                    namespace | optional | String,
                  },
                  info | optional | Array {
                    name | String,
                    value | String,
                  },
                  project | String,
                  revisionHistoryLimit | optional | Number,
                  source | optional | {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  sourceHydrator | optional | {
                    drySource | {
                      path | String,
                      repoURL | String,
                      targetRevision | String,
                    },
                    hydrateTo | optional | {
                      targetBranch | String,
                    },
                    syncSource | {
                      path | String,
                      targetBranch | String,
                    },
                  },
                  sources | optional | Array {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  syncPolicy | optional | {
                    automated | optional | {
                      allowEmpty | optional | Bool,
                      enabled | optional | Bool,
                      prune | optional | Bool,
                      selfHeal | optional | Bool,
                    },
                    managedNamespaceMetadata | optional | {
                      annotations | optional | {
                      },
                      labels | optional | {
                      },
                    },
                    retry | optional | {
                      backoff | optional | {
                        duration | optional | String,
                        factor | optional | Number,
                        maxDuration | optional | String,
                      },
                      limit | optional | Number,
                    },
                    syncOptions | optional | Array String,
                  },
                },
              },
              values | optional | {
              },
            },
            clusters | optional | {
              flatList | optional | Bool,
              selector | optional | {
                matchExpressions | optional | Array {
                  key | String,
                  operator | String,
                  values | optional | Array String,
                },
                matchLabels | optional | {
                },
              },
              template | optional | {
                metadata | {
                  annotations | optional | {
                  },
                  finalizers | optional | Array String,
                  labels | optional | {
                  },
                  name | optional | String,
                  namespace | optional | String,
                },
                spec | {
                  destination | {
                    name | optional | String,
                    namespace | optional | String,
                    server | optional | String,
                  },
                  ignoreDifferences | optional | Array {
                    group | optional | String,
                    jqPathExpressions | optional | Array String,
                    jsonPointers | optional | Array String,
                    kind | String,
                    managedFieldsManagers | optional | Array String,
                    name | optional | String,
                    namespace | optional | String,
                  },
                  info | optional | Array {
                    name | String,
                    value | String,
                  },
                  project | String,
                  revisionHistoryLimit | optional | Number,
                  source | optional | {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  sourceHydrator | optional | {
                    drySource | {
                      path | String,
                      repoURL | String,
                      targetRevision | String,
                    },
                    hydrateTo | optional | {
                      targetBranch | String,
                    },
                    syncSource | {
                      path | String,
                      targetBranch | String,
                    },
                  },
                  sources | optional | Array {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  syncPolicy | optional | {
                    automated | optional | {
                      allowEmpty | optional | Bool,
                      enabled | optional | Bool,
                      prune | optional | Bool,
                      selfHeal | optional | Bool,
                    },
                    managedNamespaceMetadata | optional | {
                      annotations | optional | {
                      },
                      labels | optional | {
                      },
                    },
                    retry | optional | {
                      backoff | optional | {
                        duration | optional | String,
                        factor | optional | Number,
                        maxDuration | optional | String,
                      },
                      limit | optional | Number,
                    },
                    syncOptions | optional | Array String,
                  },
                },
              },
              values | optional | {
              },
            },
            git | optional | {
              directories | optional | Array {
                exclude | optional | Bool,
                path | String,
              },
              files | optional | Array {
                exclude | optional | Bool,
                path | String,
              },
              pathParamPrefix | optional | String,
              repoURL | String,
              requeueAfterSeconds | optional | Number,
              revision | String,
              template | optional | {
                metadata | {
                  annotations | optional | {
                  },
                  finalizers | optional | Array String,
                  labels | optional | {
                  },
                  name | optional | String,
                  namespace | optional | String,
                },
                spec | {
                  destination | {
                    name | optional | String,
                    namespace | optional | String,
                    server | optional | String,
                  },
                  ignoreDifferences | optional | Array {
                    group | optional | String,
                    jqPathExpressions | optional | Array String,
                    jsonPointers | optional | Array String,
                    kind | String,
                    managedFieldsManagers | optional | Array String,
                    name | optional | String,
                    namespace | optional | String,
                  },
                  info | optional | Array {
                    name | String,
                    value | String,
                  },
                  project | String,
                  revisionHistoryLimit | optional | Number,
                  source | optional | {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  sourceHydrator | optional | {
                    drySource | {
                      path | String,
                      repoURL | String,
                      targetRevision | String,
                    },
                    hydrateTo | optional | {
                      targetBranch | String,
                    },
                    syncSource | {
                      path | String,
                      targetBranch | String,
                    },
                  },
                  sources | optional | Array {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  syncPolicy | optional | {
                    automated | optional | {
                      allowEmpty | optional | Bool,
                      enabled | optional | Bool,
                      prune | optional | Bool,
                      selfHeal | optional | Bool,
                    },
                    managedNamespaceMetadata | optional | {
                      annotations | optional | {
                      },
                      labels | optional | {
                      },
                    },
                    retry | optional | {
                      backoff | optional | {
                        duration | optional | String,
                        factor | optional | Number,
                        maxDuration | optional | String,
                      },
                      limit | optional | Number,
                    },
                    syncOptions | optional | Array String,
                  },
                },
              },
              values | optional | {
              },
            },
            list | optional | {
              elements | optional | Array Dyn,
              elementsYaml | optional | String,
              template | optional | {
                metadata | {
                  annotations | optional | {
                  },
                  finalizers | optional | Array String,
                  labels | optional | {
                  },
                  name | optional | String,
                  namespace | optional | String,
                },
                spec | {
                  destination | {
                    name | optional | String,
                    namespace | optional | String,
                    server | optional | String,
                  },
                  ignoreDifferences | optional | Array {
                    group | optional | String,
                    jqPathExpressions | optional | Array String,
                    jsonPointers | optional | Array String,
                    kind | String,
                    managedFieldsManagers | optional | Array String,
                    name | optional | String,
                    namespace | optional | String,
                  },
                  info | optional | Array {
                    name | String,
                    value | String,
                  },
                  project | String,
                  revisionHistoryLimit | optional | Number,
                  source | optional | {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  sourceHydrator | optional | {
                    drySource | {
                      path | String,
                      repoURL | String,
                      targetRevision | String,
                    },
                    hydrateTo | optional | {
                      targetBranch | String,
                    },
                    syncSource | {
                      path | String,
                      targetBranch | String,
                    },
                  },
                  sources | optional | Array {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  syncPolicy | optional | {
                    automated | optional | {
                      allowEmpty | optional | Bool,
                      enabled | optional | Bool,
                      prune | optional | Bool,
                      selfHeal | optional | Bool,
                    },
                    managedNamespaceMetadata | optional | {
                      annotations | optional | {
                      },
                      labels | optional | {
                      },
                    },
                    retry | optional | {
                      backoff | optional | {
                        duration | optional | String,
                        factor | optional | Number,
                        maxDuration | optional | String,
                      },
                      limit | optional | Number,
                    },
                    syncOptions | optional | Array String,
                  },
                },
              },
            },
            matrix | optional | Dyn,
            "merge" | optional | Dyn,
            plugin | optional | {
              configMapRef | {
                name | String,
              },
              input | optional | {
                parameters | optional | {
                },
              },
              requeueAfterSeconds | optional | Number,
              template | optional | {
                metadata | {
                  annotations | optional | {
                  },
                  finalizers | optional | Array String,
                  labels | optional | {
                  },
                  name | optional | String,
                  namespace | optional | String,
                },
                spec | {
                  destination | {
                    name | optional | String,
                    namespace | optional | String,
                    server | optional | String,
                  },
                  ignoreDifferences | optional | Array {
                    group | optional | String,
                    jqPathExpressions | optional | Array String,
                    jsonPointers | optional | Array String,
                    kind | String,
                    managedFieldsManagers | optional | Array String,
                    name | optional | String,
                    namespace | optional | String,
                  },
                  info | optional | Array {
                    name | String,
                    value | String,
                  },
                  project | String,
                  revisionHistoryLimit | optional | Number,
                  source | optional | {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  sourceHydrator | optional | {
                    drySource | {
                      path | String,
                      repoURL | String,
                      targetRevision | String,
                    },
                    hydrateTo | optional | {
                      targetBranch | String,
                    },
                    syncSource | {
                      path | String,
                      targetBranch | String,
                    },
                  },
                  sources | optional | Array {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  syncPolicy | optional | {
                    automated | optional | {
                      allowEmpty | optional | Bool,
                      enabled | optional | Bool,
                      prune | optional | Bool,
                      selfHeal | optional | Bool,
                    },
                    managedNamespaceMetadata | optional | {
                      annotations | optional | {
                      },
                      labels | optional | {
                      },
                    },
                    retry | optional | {
                      backoff | optional | {
                        duration | optional | String,
                        factor | optional | Number,
                        maxDuration | optional | String,
                      },
                      limit | optional | Number,
                    },
                    syncOptions | optional | Array String,
                  },
                },
              },
              values | optional | {
              },
            },
            pullRequest | optional | {
              azuredevops | optional | {
                api | optional | String,
                labels | optional | Array String,
                organization | String,
                project | String,
                repo | String,
                tokenRef | optional | {
                  key | String,
                  secretName | String,
                },
              },
              bitbucket | optional | {
                api | optional | String,
                basicAuth | optional | {
                  passwordRef | {
                    key | String,
                    secretName | String,
                  },
                  username | String,
                },
                bearerToken | optional | {
                  tokenRef | {
                    key | String,
                    secretName | String,
                  },
                },
                owner | String,
                repo | String,
              },
              bitbucketServer | optional | {
                api | String,
                basicAuth | optional | {
                  passwordRef | {
                    key | String,
                    secretName | String,
                  },
                  username | String,
                },
                bearerToken | optional | {
                  tokenRef | {
                    key | String,
                    secretName | String,
                  },
                },
                caRef | optional | {
                  configMapName | String,
                  key | String,
                },
                insecure | optional | Bool,
                project | String,
                repo | String,
              },
              filters | optional | Array {
                branchMatch | optional | String,
                targetBranchMatch | optional | String,
              },
              gitea | optional | {
                api | String,
                insecure | optional | Bool,
                labels | optional | Array String,
                owner | String,
                repo | String,
                tokenRef | optional | {
                  key | String,
                  secretName | String,
                },
              },
              github | optional | {
                api | optional | String,
                appSecretName | optional | String,
                labels | optional | Array String,
                owner | String,
                repo | String,
                tokenRef | optional | {
                  key | String,
                  secretName | String,
                },
              },
              gitlab | optional | {
                api | optional | String,
                caRef | optional | {
                  configMapName | String,
                  key | String,
                },
                insecure | optional | Bool,
                labels | optional | Array String,
                project | String,
                pullRequestState | optional | String,
                tokenRef | optional | {
                  key | String,
                  secretName | String,
                },
              },
              requeueAfterSeconds | optional | Number,
              template | optional | {
                metadata | {
                  annotations | optional | {
                  },
                  finalizers | optional | Array String,
                  labels | optional | {
                  },
                  name | optional | String,
                  namespace | optional | String,
                },
                spec | {
                  destination | {
                    name | optional | String,
                    namespace | optional | String,
                    server | optional | String,
                  },
                  ignoreDifferences | optional | Array {
                    group | optional | String,
                    jqPathExpressions | optional | Array String,
                    jsonPointers | optional | Array String,
                    kind | String,
                    managedFieldsManagers | optional | Array String,
                    name | optional | String,
                    namespace | optional | String,
                  },
                  info | optional | Array {
                    name | String,
                    value | String,
                  },
                  project | String,
                  revisionHistoryLimit | optional | Number,
                  source | optional | {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  sourceHydrator | optional | {
                    drySource | {
                      path | String,
                      repoURL | String,
                      targetRevision | String,
                    },
                    hydrateTo | optional | {
                      targetBranch | String,
                    },
                    syncSource | {
                      path | String,
                      targetBranch | String,
                    },
                  },
                  sources | optional | Array {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  syncPolicy | optional | {
                    automated | optional | {
                      allowEmpty | optional | Bool,
                      enabled | optional | Bool,
                      prune | optional | Bool,
                      selfHeal | optional | Bool,
                    },
                    managedNamespaceMetadata | optional | {
                      annotations | optional | {
                      },
                      labels | optional | {
                      },
                    },
                    retry | optional | {
                      backoff | optional | {
                        duration | optional | String,
                        factor | optional | Number,
                        maxDuration | optional | String,
                      },
                      limit | optional | Number,
                    },
                    syncOptions | optional | Array String,
                  },
                },
              },
              values | optional | {
              },
            },
            scmProvider | optional | {
              awsCodeCommit | optional | {
                allBranches | optional | Bool,
                region | optional | String,
                role | optional | String,
                tagFilters | optional | Array {
                  key | String,
                  value | optional | String,
                },
              },
              azureDevOps | optional | {
                accessTokenRef | {
                  key | String,
                  secretName | String,
                },
                allBranches | optional | Bool,
                api | optional | String,
                organization | String,
                teamProject | String,
              },
              bitbucket | optional | {
                allBranches | optional | Bool,
                appPasswordRef | {
                  key | String,
                  secretName | String,
                },
                owner | String,
                user | String,
              },
              bitbucketServer | optional | {
                allBranches | optional | Bool,
                api | String,
                basicAuth | optional | {
                  passwordRef | {
                    key | String,
                    secretName | String,
                  },
                  username | String,
                },
                bearerToken | optional | {
                  tokenRef | {
                    key | String,
                    secretName | String,
                  },
                },
                caRef | optional | {
                  configMapName | String,
                  key | String,
                },
                insecure | optional | Bool,
                project | String,
              },
              cloneProtocol | optional | String,
              filters | optional | Array {
                branchMatch | optional | String,
                labelMatch | optional | String,
                pathsDoNotExist | optional | Array String,
                pathsExist | optional | Array String,
                repositoryMatch | optional | String,
              },
              gitea | optional | {
                allBranches | optional | Bool,
                api | String,
                insecure | optional | Bool,
                owner | String,
                tokenRef | optional | {
                  key | String,
                  secretName | String,
                },
              },
              github | optional | {
                allBranches | optional | Bool,
                api | optional | String,
                appSecretName | optional | String,
                organization | String,
                tokenRef | optional | {
                  key | String,
                  secretName | String,
                },
              },
              gitlab | optional | {
                allBranches | optional | Bool,
                api | optional | String,
                caRef | optional | {
                  configMapName | String,
                  key | String,
                },
                group | String,
                includeSharedProjects | optional | Bool,
                includeSubgroups | optional | Bool,
                insecure | optional | Bool,
                tokenRef | optional | {
                  key | String,
                  secretName | String,
                },
                topic | optional | String,
              },
              requeueAfterSeconds | optional | Number,
              template | optional | {
                metadata | {
                  annotations | optional | {
                  },
                  finalizers | optional | Array String,
                  labels | optional | {
                  },
                  name | optional | String,
                  namespace | optional | String,
                },
                spec | {
                  destination | {
                    name | optional | String,
                    namespace | optional | String,
                    server | optional | String,
                  },
                  ignoreDifferences | optional | Array {
                    group | optional | String,
                    jqPathExpressions | optional | Array String,
                    jsonPointers | optional | Array String,
                    kind | String,
                    managedFieldsManagers | optional | Array String,
                    name | optional | String,
                    namespace | optional | String,
                  },
                  info | optional | Array {
                    name | String,
                    value | String,
                  },
                  project | String,
                  revisionHistoryLimit | optional | Number,
                  source | optional | {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  sourceHydrator | optional | {
                    drySource | {
                      path | String,
                      repoURL | String,
                      targetRevision | String,
                    },
                    hydrateTo | optional | {
                      targetBranch | String,
                    },
                    syncSource | {
                      path | String,
                      targetBranch | String,
                    },
                  },
                  sources | optional | Array {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  syncPolicy | optional | {
                    automated | optional | {
                      allowEmpty | optional | Bool,
                      enabled | optional | Bool,
                      prune | optional | Bool,
                      selfHeal | optional | Bool,
                    },
                    managedNamespaceMetadata | optional | {
                      annotations | optional | {
                      },
                      labels | optional | {
                      },
                    },
                    retry | optional | {
                      backoff | optional | {
                        duration | optional | String,
                        factor | optional | Number,
                        maxDuration | optional | String,
                      },
                      limit | optional | Number,
                    },
                    syncOptions | optional | Array String,
                  },
                },
              },
              values | optional | {
              },
            },
            selector | optional | {
              matchExpressions | optional | Array {
                key | String,
                operator | String,
                values | optional | Array String,
              },
              matchLabels | optional | {
              },
            },
          },
          template | optional | {
            metadata | {
              annotations | optional | {
              },
              finalizers | optional | Array String,
              labels | optional | {
              },
              name | optional | String,
              namespace | optional | String,
            },
            spec | {
              destination | {
                name | optional | String,
                namespace | optional | String,
                server | optional | String,
              },
              ignoreDifferences | optional | Array {
                group | optional | String,
                jqPathExpressions | optional | Array String,
                jsonPointers | optional | Array String,
                kind | String,
                managedFieldsManagers | optional | Array String,
                name | optional | String,
                namespace | optional | String,
              },
              info | optional | Array {
                name | String,
                value | String,
              },
              project | String,
              revisionHistoryLimit | optional | Number,
              source | optional | {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              sourceHydrator | optional | {
                drySource | {
                  path | String,
                  repoURL | String,
                  targetRevision | String,
                },
                hydrateTo | optional | {
                  targetBranch | String,
                },
                syncSource | {
                  path | String,
                  targetBranch | String,
                },
              },
              sources | optional | Array {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              syncPolicy | optional | {
                automated | optional | {
                  allowEmpty | optional | Bool,
                  enabled | optional | Bool,
                  prune | optional | Bool,
                  selfHeal | optional | Bool,
                },
                managedNamespaceMetadata | optional | {
                  annotations | optional | {
                  },
                  labels | optional | {
                  },
                },
                retry | optional | {
                  backoff | optional | {
                    duration | optional | String,
                    factor | optional | Number,
                    maxDuration | optional | String,
                  },
                  limit | optional | Number,
                },
                syncOptions | optional | Array String,
              },
            },
          },
        },
        "merge" | optional | {
          generators | Array {
            clusterDecisionResource | optional | {
              configMapRef | String,
              labelSelector | optional | {
                matchExpressions | optional | Array {
                  key | String,
                  operator | String,
                  values | optional | Array String,
                },
                matchLabels | optional | {
                },
              },
              name | optional | String,
              requeueAfterSeconds | optional | Number,
              template | optional | {
                metadata | {
                  annotations | optional | {
                  },
                  finalizers | optional | Array String,
                  labels | optional | {
                  },
                  name | optional | String,
                  namespace | optional | String,
                },
                spec | {
                  destination | {
                    name | optional | String,
                    namespace | optional | String,
                    server | optional | String,
                  },
                  ignoreDifferences | optional | Array {
                    group | optional | String,
                    jqPathExpressions | optional | Array String,
                    jsonPointers | optional | Array String,
                    kind | String,
                    managedFieldsManagers | optional | Array String,
                    name | optional | String,
                    namespace | optional | String,
                  },
                  info | optional | Array {
                    name | String,
                    value | String,
                  },
                  project | String,
                  revisionHistoryLimit | optional | Number,
                  source | optional | {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  sourceHydrator | optional | {
                    drySource | {
                      path | String,
                      repoURL | String,
                      targetRevision | String,
                    },
                    hydrateTo | optional | {
                      targetBranch | String,
                    },
                    syncSource | {
                      path | String,
                      targetBranch | String,
                    },
                  },
                  sources | optional | Array {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  syncPolicy | optional | {
                    automated | optional | {
                      allowEmpty | optional | Bool,
                      enabled | optional | Bool,
                      prune | optional | Bool,
                      selfHeal | optional | Bool,
                    },
                    managedNamespaceMetadata | optional | {
                      annotations | optional | {
                      },
                      labels | optional | {
                      },
                    },
                    retry | optional | {
                      backoff | optional | {
                        duration | optional | String,
                        factor | optional | Number,
                        maxDuration | optional | String,
                      },
                      limit | optional | Number,
                    },
                    syncOptions | optional | Array String,
                  },
                },
              },
              values | optional | {
              },
            },
            clusters | optional | {
              flatList | optional | Bool,
              selector | optional | {
                matchExpressions | optional | Array {
                  key | String,
                  operator | String,
                  values | optional | Array String,
                },
                matchLabels | optional | {
                },
              },
              template | optional | {
                metadata | {
                  annotations | optional | {
                  },
                  finalizers | optional | Array String,
                  labels | optional | {
                  },
                  name | optional | String,
                  namespace | optional | String,
                },
                spec | {
                  destination | {
                    name | optional | String,
                    namespace | optional | String,
                    server | optional | String,
                  },
                  ignoreDifferences | optional | Array {
                    group | optional | String,
                    jqPathExpressions | optional | Array String,
                    jsonPointers | optional | Array String,
                    kind | String,
                    managedFieldsManagers | optional | Array String,
                    name | optional | String,
                    namespace | optional | String,
                  },
                  info | optional | Array {
                    name | String,
                    value | String,
                  },
                  project | String,
                  revisionHistoryLimit | optional | Number,
                  source | optional | {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  sourceHydrator | optional | {
                    drySource | {
                      path | String,
                      repoURL | String,
                      targetRevision | String,
                    },
                    hydrateTo | optional | {
                      targetBranch | String,
                    },
                    syncSource | {
                      path | String,
                      targetBranch | String,
                    },
                  },
                  sources | optional | Array {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  syncPolicy | optional | {
                    automated | optional | {
                      allowEmpty | optional | Bool,
                      enabled | optional | Bool,
                      prune | optional | Bool,
                      selfHeal | optional | Bool,
                    },
                    managedNamespaceMetadata | optional | {
                      annotations | optional | {
                      },
                      labels | optional | {
                      },
                    },
                    retry | optional | {
                      backoff | optional | {
                        duration | optional | String,
                        factor | optional | Number,
                        maxDuration | optional | String,
                      },
                      limit | optional | Number,
                    },
                    syncOptions | optional | Array String,
                  },
                },
              },
              values | optional | {
              },
            },
            git | optional | {
              directories | optional | Array {
                exclude | optional | Bool,
                path | String,
              },
              files | optional | Array {
                exclude | optional | Bool,
                path | String,
              },
              pathParamPrefix | optional | String,
              repoURL | String,
              requeueAfterSeconds | optional | Number,
              revision | String,
              template | optional | {
                metadata | {
                  annotations | optional | {
                  },
                  finalizers | optional | Array String,
                  labels | optional | {
                  },
                  name | optional | String,
                  namespace | optional | String,
                },
                spec | {
                  destination | {
                    name | optional | String,
                    namespace | optional | String,
                    server | optional | String,
                  },
                  ignoreDifferences | optional | Array {
                    group | optional | String,
                    jqPathExpressions | optional | Array String,
                    jsonPointers | optional | Array String,
                    kind | String,
                    managedFieldsManagers | optional | Array String,
                    name | optional | String,
                    namespace | optional | String,
                  },
                  info | optional | Array {
                    name | String,
                    value | String,
                  },
                  project | String,
                  revisionHistoryLimit | optional | Number,
                  source | optional | {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  sourceHydrator | optional | {
                    drySource | {
                      path | String,
                      repoURL | String,
                      targetRevision | String,
                    },
                    hydrateTo | optional | {
                      targetBranch | String,
                    },
                    syncSource | {
                      path | String,
                      targetBranch | String,
                    },
                  },
                  sources | optional | Array {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  syncPolicy | optional | {
                    automated | optional | {
                      allowEmpty | optional | Bool,
                      enabled | optional | Bool,
                      prune | optional | Bool,
                      selfHeal | optional | Bool,
                    },
                    managedNamespaceMetadata | optional | {
                      annotations | optional | {
                      },
                      labels | optional | {
                      },
                    },
                    retry | optional | {
                      backoff | optional | {
                        duration | optional | String,
                        factor | optional | Number,
                        maxDuration | optional | String,
                      },
                      limit | optional | Number,
                    },
                    syncOptions | optional | Array String,
                  },
                },
              },
              values | optional | {
              },
            },
            list | optional | {
              elements | optional | Array Dyn,
              elementsYaml | optional | String,
              template | optional | {
                metadata | {
                  annotations | optional | {
                  },
                  finalizers | optional | Array String,
                  labels | optional | {
                  },
                  name | optional | String,
                  namespace | optional | String,
                },
                spec | {
                  destination | {
                    name | optional | String,
                    namespace | optional | String,
                    server | optional | String,
                  },
                  ignoreDifferences | optional | Array {
                    group | optional | String,
                    jqPathExpressions | optional | Array String,
                    jsonPointers | optional | Array String,
                    kind | String,
                    managedFieldsManagers | optional | Array String,
                    name | optional | String,
                    namespace | optional | String,
                  },
                  info | optional | Array {
                    name | String,
                    value | String,
                  },
                  project | String,
                  revisionHistoryLimit | optional | Number,
                  source | optional | {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  sourceHydrator | optional | {
                    drySource | {
                      path | String,
                      repoURL | String,
                      targetRevision | String,
                    },
                    hydrateTo | optional | {
                      targetBranch | String,
                    },
                    syncSource | {
                      path | String,
                      targetBranch | String,
                    },
                  },
                  sources | optional | Array {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  syncPolicy | optional | {
                    automated | optional | {
                      allowEmpty | optional | Bool,
                      enabled | optional | Bool,
                      prune | optional | Bool,
                      selfHeal | optional | Bool,
                    },
                    managedNamespaceMetadata | optional | {
                      annotations | optional | {
                      },
                      labels | optional | {
                      },
                    },
                    retry | optional | {
                      backoff | optional | {
                        duration | optional | String,
                        factor | optional | Number,
                        maxDuration | optional | String,
                      },
                      limit | optional | Number,
                    },
                    syncOptions | optional | Array String,
                  },
                },
              },
            },
            matrix | optional | Dyn,
            "merge" | optional | Dyn,
            plugin | optional | {
              configMapRef | {
                name | String,
              },
              input | optional | {
                parameters | optional | {
                },
              },
              requeueAfterSeconds | optional | Number,
              template | optional | {
                metadata | {
                  annotations | optional | {
                  },
                  finalizers | optional | Array String,
                  labels | optional | {
                  },
                  name | optional | String,
                  namespace | optional | String,
                },
                spec | {
                  destination | {
                    name | optional | String,
                    namespace | optional | String,
                    server | optional | String,
                  },
                  ignoreDifferences | optional | Array {
                    group | optional | String,
                    jqPathExpressions | optional | Array String,
                    jsonPointers | optional | Array String,
                    kind | String,
                    managedFieldsManagers | optional | Array String,
                    name | optional | String,
                    namespace | optional | String,
                  },
                  info | optional | Array {
                    name | String,
                    value | String,
                  },
                  project | String,
                  revisionHistoryLimit | optional | Number,
                  source | optional | {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  sourceHydrator | optional | {
                    drySource | {
                      path | String,
                      repoURL | String,
                      targetRevision | String,
                    },
                    hydrateTo | optional | {
                      targetBranch | String,
                    },
                    syncSource | {
                      path | String,
                      targetBranch | String,
                    },
                  },
                  sources | optional | Array {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  syncPolicy | optional | {
                    automated | optional | {
                      allowEmpty | optional | Bool,
                      enabled | optional | Bool,
                      prune | optional | Bool,
                      selfHeal | optional | Bool,
                    },
                    managedNamespaceMetadata | optional | {
                      annotations | optional | {
                      },
                      labels | optional | {
                      },
                    },
                    retry | optional | {
                      backoff | optional | {
                        duration | optional | String,
                        factor | optional | Number,
                        maxDuration | optional | String,
                      },
                      limit | optional | Number,
                    },
                    syncOptions | optional | Array String,
                  },
                },
              },
              values | optional | {
              },
            },
            pullRequest | optional | {
              azuredevops | optional | {
                api | optional | String,
                labels | optional | Array String,
                organization | String,
                project | String,
                repo | String,
                tokenRef | optional | {
                  key | String,
                  secretName | String,
                },
              },
              bitbucket | optional | {
                api | optional | String,
                basicAuth | optional | {
                  passwordRef | {
                    key | String,
                    secretName | String,
                  },
                  username | String,
                },
                bearerToken | optional | {
                  tokenRef | {
                    key | String,
                    secretName | String,
                  },
                },
                owner | String,
                repo | String,
              },
              bitbucketServer | optional | {
                api | String,
                basicAuth | optional | {
                  passwordRef | {
                    key | String,
                    secretName | String,
                  },
                  username | String,
                },
                bearerToken | optional | {
                  tokenRef | {
                    key | String,
                    secretName | String,
                  },
                },
                caRef | optional | {
                  configMapName | String,
                  key | String,
                },
                insecure | optional | Bool,
                project | String,
                repo | String,
              },
              filters | optional | Array {
                branchMatch | optional | String,
                targetBranchMatch | optional | String,
              },
              gitea | optional | {
                api | String,
                insecure | optional | Bool,
                labels | optional | Array String,
                owner | String,
                repo | String,
                tokenRef | optional | {
                  key | String,
                  secretName | String,
                },
              },
              github | optional | {
                api | optional | String,
                appSecretName | optional | String,
                labels | optional | Array String,
                owner | String,
                repo | String,
                tokenRef | optional | {
                  key | String,
                  secretName | String,
                },
              },
              gitlab | optional | {
                api | optional | String,
                caRef | optional | {
                  configMapName | String,
                  key | String,
                },
                insecure | optional | Bool,
                labels | optional | Array String,
                project | String,
                pullRequestState | optional | String,
                tokenRef | optional | {
                  key | String,
                  secretName | String,
                },
              },
              requeueAfterSeconds | optional | Number,
              template | optional | {
                metadata | {
                  annotations | optional | {
                  },
                  finalizers | optional | Array String,
                  labels | optional | {
                  },
                  name | optional | String,
                  namespace | optional | String,
                },
                spec | {
                  destination | {
                    name | optional | String,
                    namespace | optional | String,
                    server | optional | String,
                  },
                  ignoreDifferences | optional | Array {
                    group | optional | String,
                    jqPathExpressions | optional | Array String,
                    jsonPointers | optional | Array String,
                    kind | String,
                    managedFieldsManagers | optional | Array String,
                    name | optional | String,
                    namespace | optional | String,
                  },
                  info | optional | Array {
                    name | String,
                    value | String,
                  },
                  project | String,
                  revisionHistoryLimit | optional | Number,
                  source | optional | {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  sourceHydrator | optional | {
                    drySource | {
                      path | String,
                      repoURL | String,
                      targetRevision | String,
                    },
                    hydrateTo | optional | {
                      targetBranch | String,
                    },
                    syncSource | {
                      path | String,
                      targetBranch | String,
                    },
                  },
                  sources | optional | Array {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  syncPolicy | optional | {
                    automated | optional | {
                      allowEmpty | optional | Bool,
                      enabled | optional | Bool,
                      prune | optional | Bool,
                      selfHeal | optional | Bool,
                    },
                    managedNamespaceMetadata | optional | {
                      annotations | optional | {
                      },
                      labels | optional | {
                      },
                    },
                    retry | optional | {
                      backoff | optional | {
                        duration | optional | String,
                        factor | optional | Number,
                        maxDuration | optional | String,
                      },
                      limit | optional | Number,
                    },
                    syncOptions | optional | Array String,
                  },
                },
              },
              values | optional | {
              },
            },
            scmProvider | optional | {
              awsCodeCommit | optional | {
                allBranches | optional | Bool,
                region | optional | String,
                role | optional | String,
                tagFilters | optional | Array {
                  key | String,
                  value | optional | String,
                },
              },
              azureDevOps | optional | {
                accessTokenRef | {
                  key | String,
                  secretName | String,
                },
                allBranches | optional | Bool,
                api | optional | String,
                organization | String,
                teamProject | String,
              },
              bitbucket | optional | {
                allBranches | optional | Bool,
                appPasswordRef | {
                  key | String,
                  secretName | String,
                },
                owner | String,
                user | String,
              },
              bitbucketServer | optional | {
                allBranches | optional | Bool,
                api | String,
                basicAuth | optional | {
                  passwordRef | {
                    key | String,
                    secretName | String,
                  },
                  username | String,
                },
                bearerToken | optional | {
                  tokenRef | {
                    key | String,
                    secretName | String,
                  },
                },
                caRef | optional | {
                  configMapName | String,
                  key | String,
                },
                insecure | optional | Bool,
                project | String,
              },
              cloneProtocol | optional | String,
              filters | optional | Array {
                branchMatch | optional | String,
                labelMatch | optional | String,
                pathsDoNotExist | optional | Array String,
                pathsExist | optional | Array String,
                repositoryMatch | optional | String,
              },
              gitea | optional | {
                allBranches | optional | Bool,
                api | String,
                insecure | optional | Bool,
                owner | String,
                tokenRef | optional | {
                  key | String,
                  secretName | String,
                },
              },
              github | optional | {
                allBranches | optional | Bool,
                api | optional | String,
                appSecretName | optional | String,
                organization | String,
                tokenRef | optional | {
                  key | String,
                  secretName | String,
                },
              },
              gitlab | optional | {
                allBranches | optional | Bool,
                api | optional | String,
                caRef | optional | {
                  configMapName | String,
                  key | String,
                },
                group | String,
                includeSharedProjects | optional | Bool,
                includeSubgroups | optional | Bool,
                insecure | optional | Bool,
                tokenRef | optional | {
                  key | String,
                  secretName | String,
                },
                topic | optional | String,
              },
              requeueAfterSeconds | optional | Number,
              template | optional | {
                metadata | {
                  annotations | optional | {
                  },
                  finalizers | optional | Array String,
                  labels | optional | {
                  },
                  name | optional | String,
                  namespace | optional | String,
                },
                spec | {
                  destination | {
                    name | optional | String,
                    namespace | optional | String,
                    server | optional | String,
                  },
                  ignoreDifferences | optional | Array {
                    group | optional | String,
                    jqPathExpressions | optional | Array String,
                    jsonPointers | optional | Array String,
                    kind | String,
                    managedFieldsManagers | optional | Array String,
                    name | optional | String,
                    namespace | optional | String,
                  },
                  info | optional | Array {
                    name | String,
                    value | String,
                  },
                  project | String,
                  revisionHistoryLimit | optional | Number,
                  source | optional | {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  sourceHydrator | optional | {
                    drySource | {
                      path | String,
                      repoURL | String,
                      targetRevision | String,
                    },
                    hydrateTo | optional | {
                      targetBranch | String,
                    },
                    syncSource | {
                      path | String,
                      targetBranch | String,
                    },
                  },
                  sources | optional | Array {
                    chart | optional | String,
                    directory | optional | {
                      exclude | optional | String,
                      include | optional | String,
                      jsonnet | optional | {
                        extVars | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                        libs | optional | Array String,
                        tlas | optional | Array {
                          code | optional | Bool,
                          name | String,
                          value | String,
                        },
                      },
                      recurse | optional | Bool,
                    },
                    helm | optional | {
                      apiVersions | optional | Array String,
                      fileParameters | optional | Array {
                        name | optional | String,
                        path | optional | String,
                      },
                      ignoreMissingValueFiles | optional | Bool,
                      kubeVersion | optional | String,
                      namespace | optional | String,
                      parameters | optional | Array {
                        forceString | optional | Bool,
                        name | optional | String,
                        value | optional | String,
                      },
                      passCredentials | optional | Bool,
                      releaseName | optional | String,
                      skipCrds | optional | Bool,
                      skipSchemaValidation | optional | Bool,
                      skipTests | optional | Bool,
                      valueFiles | optional | Array String,
                      values | optional | String,
                      valuesObject | optional | {
                      },
                      version | optional | String,
                    },
                    kustomize | optional | {
                      apiVersions | optional | Array String,
                      commonAnnotations | optional | {
                      },
                      commonAnnotationsEnvsubst | optional | Bool,
                      commonLabels | optional | {
                      },
                      components | optional | Array String,
                      forceCommonAnnotations | optional | Bool,
                      forceCommonLabels | optional | Bool,
                      ignoreMissingComponents | optional | Bool,
                      images | optional | Array String,
                      kubeVersion | optional | String,
                      labelIncludeTemplates | optional | Bool,
                      labelWithoutSelector | optional | Bool,
                      namePrefix | optional | String,
                      nameSuffix | optional | String,
                      namespace | optional | String,
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
                      },
                      replicas | optional | Array {
                        count | Number | String,
                        name | String,
                      },
                      version | optional | String,
                    },
                    name | optional | String,
                    path | optional | String,
                    plugin | optional | {
                      env | optional | Array k8s_io_objectmeta.EnvVar,
                      name | optional | String,
                      parameters | optional | Array {
                        array | optional | Array String,
                        map | optional | {
                        },
                        name | optional | String,
                        string | optional | String,
                      },
                    },
                    ref | optional | String,
                    repoURL | String,
                    targetRevision | optional | String,
                  },
                  syncPolicy | optional | {
                    automated | optional | {
                      allowEmpty | optional | Bool,
                      enabled | optional | Bool,
                      prune | optional | Bool,
                      selfHeal | optional | Bool,
                    },
                    managedNamespaceMetadata | optional | {
                      annotations | optional | {
                      },
                      labels | optional | {
                      },
                    },
                    retry | optional | {
                      backoff | optional | {
                        duration | optional | String,
                        factor | optional | Number,
                        maxDuration | optional | String,
                      },
                      limit | optional | Number,
                    },
                    syncOptions | optional | Array String,
                  },
                },
              },
              values | optional | {
              },
            },
            selector | optional | {
              matchExpressions | optional | Array {
                key | String,
                operator | String,
                values | optional | Array String,
              },
              matchLabels | optional | {
              },
            },
          },
          mergeKeys | Array String,
          template | optional | {
            metadata | {
              annotations | optional | {
              },
              finalizers | optional | Array String,
              labels | optional | {
              },
              name | optional | String,
              namespace | optional | String,
            },
            spec | {
              destination | {
                name | optional | String,
                namespace | optional | String,
                server | optional | String,
              },
              ignoreDifferences | optional | Array {
                group | optional | String,
                jqPathExpressions | optional | Array String,
                jsonPointers | optional | Array String,
                kind | String,
                managedFieldsManagers | optional | Array String,
                name | optional | String,
                namespace | optional | String,
              },
              info | optional | Array {
                name | String,
                value | String,
              },
              project | String,
              revisionHistoryLimit | optional | Number,
              source | optional | {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              sourceHydrator | optional | {
                drySource | {
                  path | String,
                  repoURL | String,
                  targetRevision | String,
                },
                hydrateTo | optional | {
                  targetBranch | String,
                },
                syncSource | {
                  path | String,
                  targetBranch | String,
                },
              },
              sources | optional | Array {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              syncPolicy | optional | {
                automated | optional | {
                  allowEmpty | optional | Bool,
                  enabled | optional | Bool,
                  prune | optional | Bool,
                  selfHeal | optional | Bool,
                },
                managedNamespaceMetadata | optional | {
                  annotations | optional | {
                  },
                  labels | optional | {
                  },
                },
                retry | optional | {
                  backoff | optional | {
                    duration | optional | String,
                    factor | optional | Number,
                    maxDuration | optional | String,
                  },
                  limit | optional | Number,
                },
                syncOptions | optional | Array String,
              },
            },
          },
        },
        plugin | optional | {
          configMapRef | {
            name | String,
          },
          input | optional | {
            parameters | optional | {
            },
          },
          requeueAfterSeconds | optional | Number,
          template | optional | {
            metadata | {
              annotations | optional | {
              },
              finalizers | optional | Array String,
              labels | optional | {
              },
              name | optional | String,
              namespace | optional | String,
            },
            spec | {
              destination | {
                name | optional | String,
                namespace | optional | String,
                server | optional | String,
              },
              ignoreDifferences | optional | Array {
                group | optional | String,
                jqPathExpressions | optional | Array String,
                jsonPointers | optional | Array String,
                kind | String,
                managedFieldsManagers | optional | Array String,
                name | optional | String,
                namespace | optional | String,
              },
              info | optional | Array {
                name | String,
                value | String,
              },
              project | String,
              revisionHistoryLimit | optional | Number,
              source | optional | {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              sourceHydrator | optional | {
                drySource | {
                  path | String,
                  repoURL | String,
                  targetRevision | String,
                },
                hydrateTo | optional | {
                  targetBranch | String,
                },
                syncSource | {
                  path | String,
                  targetBranch | String,
                },
              },
              sources | optional | Array {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              syncPolicy | optional | {
                automated | optional | {
                  allowEmpty | optional | Bool,
                  enabled | optional | Bool,
                  prune | optional | Bool,
                  selfHeal | optional | Bool,
                },
                managedNamespaceMetadata | optional | {
                  annotations | optional | {
                  },
                  labels | optional | {
                  },
                },
                retry | optional | {
                  backoff | optional | {
                    duration | optional | String,
                    factor | optional | Number,
                    maxDuration | optional | String,
                  },
                  limit | optional | Number,
                },
                syncOptions | optional | Array String,
              },
            },
          },
          values | optional | {
          },
        },
        pullRequest | optional | {
          azuredevops | optional | {
            api | optional | String,
            labels | optional | Array String,
            organization | String,
            project | String,
            repo | String,
            tokenRef | optional | {
              key | String,
              secretName | String,
            },
          },
          bitbucket | optional | {
            api | optional | String,
            basicAuth | optional | {
              passwordRef | {
                key | String,
                secretName | String,
              },
              username | String,
            },
            bearerToken | optional | {
              tokenRef | {
                key | String,
                secretName | String,
              },
            },
            owner | String,
            repo | String,
          },
          bitbucketServer | optional | {
            api | String,
            basicAuth | optional | {
              passwordRef | {
                key | String,
                secretName | String,
              },
              username | String,
            },
            bearerToken | optional | {
              tokenRef | {
                key | String,
                secretName | String,
              },
            },
            caRef | optional | {
              configMapName | String,
              key | String,
            },
            insecure | optional | Bool,
            project | String,
            repo | String,
          },
          filters | optional | Array {
            branchMatch | optional | String,
            targetBranchMatch | optional | String,
          },
          gitea | optional | {
            api | String,
            insecure | optional | Bool,
            labels | optional | Array String,
            owner | String,
            repo | String,
            tokenRef | optional | {
              key | String,
              secretName | String,
            },
          },
          github | optional | {
            api | optional | String,
            appSecretName | optional | String,
            labels | optional | Array String,
            owner | String,
            repo | String,
            tokenRef | optional | {
              key | String,
              secretName | String,
            },
          },
          gitlab | optional | {
            api | optional | String,
            caRef | optional | {
              configMapName | String,
              key | String,
            },
            insecure | optional | Bool,
            labels | optional | Array String,
            project | String,
            pullRequestState | optional | String,
            tokenRef | optional | {
              key | String,
              secretName | String,
            },
          },
          requeueAfterSeconds | optional | Number,
          template | optional | {
            metadata | {
              annotations | optional | {
              },
              finalizers | optional | Array String,
              labels | optional | {
              },
              name | optional | String,
              namespace | optional | String,
            },
            spec | {
              destination | {
                name | optional | String,
                namespace | optional | String,
                server | optional | String,
              },
              ignoreDifferences | optional | Array {
                group | optional | String,
                jqPathExpressions | optional | Array String,
                jsonPointers | optional | Array String,
                kind | String,
                managedFieldsManagers | optional | Array String,
                name | optional | String,
                namespace | optional | String,
              },
              info | optional | Array {
                name | String,
                value | String,
              },
              project | String,
              revisionHistoryLimit | optional | Number,
              source | optional | {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              sourceHydrator | optional | {
                drySource | {
                  path | String,
                  repoURL | String,
                  targetRevision | String,
                },
                hydrateTo | optional | {
                  targetBranch | String,
                },
                syncSource | {
                  path | String,
                  targetBranch | String,
                },
              },
              sources | optional | Array {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              syncPolicy | optional | {
                automated | optional | {
                  allowEmpty | optional | Bool,
                  enabled | optional | Bool,
                  prune | optional | Bool,
                  selfHeal | optional | Bool,
                },
                managedNamespaceMetadata | optional | {
                  annotations | optional | {
                  },
                  labels | optional | {
                  },
                },
                retry | optional | {
                  backoff | optional | {
                    duration | optional | String,
                    factor | optional | Number,
                    maxDuration | optional | String,
                  },
                  limit | optional | Number,
                },
                syncOptions | optional | Array String,
              },
            },
          },
          values | optional | {
          },
        },
        scmProvider | optional | {
          awsCodeCommit | optional | {
            allBranches | optional | Bool,
            region | optional | String,
            role | optional | String,
            tagFilters | optional | Array {
              key | String,
              value | optional | String,
            },
          },
          azureDevOps | optional | {
            accessTokenRef | {
              key | String,
              secretName | String,
            },
            allBranches | optional | Bool,
            api | optional | String,
            organization | String,
            teamProject | String,
          },
          bitbucket | optional | {
            allBranches | optional | Bool,
            appPasswordRef | {
              key | String,
              secretName | String,
            },
            owner | String,
            user | String,
          },
          bitbucketServer | optional | {
            allBranches | optional | Bool,
            api | String,
            basicAuth | optional | {
              passwordRef | {
                key | String,
                secretName | String,
              },
              username | String,
            },
            bearerToken | optional | {
              tokenRef | {
                key | String,
                secretName | String,
              },
            },
            caRef | optional | {
              configMapName | String,
              key | String,
            },
            insecure | optional | Bool,
            project | String,
          },
          cloneProtocol | optional | String,
          filters | optional | Array {
            branchMatch | optional | String,
            labelMatch | optional | String,
            pathsDoNotExist | optional | Array String,
            pathsExist | optional | Array String,
            repositoryMatch | optional | String,
          },
          gitea | optional | {
            allBranches | optional | Bool,
            api | String,
            insecure | optional | Bool,
            owner | String,
            tokenRef | optional | {
              key | String,
              secretName | String,
            },
          },
          github | optional | {
            allBranches | optional | Bool,
            api | optional | String,
            appSecretName | optional | String,
            organization | String,
            tokenRef | optional | {
              key | String,
              secretName | String,
            },
          },
          gitlab | optional | {
            allBranches | optional | Bool,
            api | optional | String,
            caRef | optional | {
              configMapName | String,
              key | String,
            },
            group | String,
            includeSharedProjects | optional | Bool,
            includeSubgroups | optional | Bool,
            insecure | optional | Bool,
            tokenRef | optional | {
              key | String,
              secretName | String,
            },
            topic | optional | String,
          },
          requeueAfterSeconds | optional | Number,
          template | optional | {
            metadata | {
              annotations | optional | {
              },
              finalizers | optional | Array String,
              labels | optional | {
              },
              name | optional | String,
              namespace | optional | String,
            },
            spec | {
              destination | {
                name | optional | String,
                namespace | optional | String,
                server | optional | String,
              },
              ignoreDifferences | optional | Array {
                group | optional | String,
                jqPathExpressions | optional | Array String,
                jsonPointers | optional | Array String,
                kind | String,
                managedFieldsManagers | optional | Array String,
                name | optional | String,
                namespace | optional | String,
              },
              info | optional | Array {
                name | String,
                value | String,
              },
              project | String,
              revisionHistoryLimit | optional | Number,
              source | optional | {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              sourceHydrator | optional | {
                drySource | {
                  path | String,
                  repoURL | String,
                  targetRevision | String,
                },
                hydrateTo | optional | {
                  targetBranch | String,
                },
                syncSource | {
                  path | String,
                  targetBranch | String,
                },
              },
              sources | optional | Array {
                chart | optional | String,
                directory | optional | {
                  exclude | optional | String,
                  include | optional | String,
                  jsonnet | optional | {
                    extVars | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                    libs | optional | Array String,
                    tlas | optional | Array {
                      code | optional | Bool,
                      name | String,
                      value | String,
                    },
                  },
                  recurse | optional | Bool,
                },
                helm | optional | {
                  apiVersions | optional | Array String,
                  fileParameters | optional | Array {
                    name | optional | String,
                    path | optional | String,
                  },
                  ignoreMissingValueFiles | optional | Bool,
                  kubeVersion | optional | String,
                  namespace | optional | String,
                  parameters | optional | Array {
                    forceString | optional | Bool,
                    name | optional | String,
                    value | optional | String,
                  },
                  passCredentials | optional | Bool,
                  releaseName | optional | String,
                  skipCrds | optional | Bool,
                  skipSchemaValidation | optional | Bool,
                  skipTests | optional | Bool,
                  valueFiles | optional | Array String,
                  values | optional | String,
                  valuesObject | optional | {
                  },
                  version | optional | String,
                },
                kustomize | optional | {
                  apiVersions | optional | Array String,
                  commonAnnotations | optional | {
                  },
                  commonAnnotationsEnvsubst | optional | Bool,
                  commonLabels | optional | {
                  },
                  components | optional | Array String,
                  forceCommonAnnotations | optional | Bool,
                  forceCommonLabels | optional | Bool,
                  ignoreMissingComponents | optional | Bool,
                  images | optional | Array String,
                  kubeVersion | optional | String,
                  labelIncludeTemplates | optional | Bool,
                  labelWithoutSelector | optional | Bool,
                  namePrefix | optional | String,
                  nameSuffix | optional | String,
                  namespace | optional | String,
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
                  },
                  replicas | optional | Array {
                    count | Number | String,
                    name | String,
                  },
                  version | optional | String,
                },
                name | optional | String,
                path | optional | String,
                plugin | optional | {
                  env | optional | Array k8s_io_objectmeta.EnvVar,
                  name | optional | String,
                  parameters | optional | Array {
                    array | optional | Array String,
                    map | optional | {
                    },
                    name | optional | String,
                    string | optional | String,
                  },
                },
                ref | optional | String,
                repoURL | String,
                targetRevision | optional | String,
              },
              syncPolicy | optional | {
                automated | optional | {
                  allowEmpty | optional | Bool,
                  enabled | optional | Bool,
                  prune | optional | Bool,
                  selfHeal | optional | Bool,
                },
                managedNamespaceMetadata | optional | {
                  annotations | optional | {
                  },
                  labels | optional | {
                  },
                },
                retry | optional | {
                  backoff | optional | {
                    duration | optional | String,
                    factor | optional | Number,
                    maxDuration | optional | String,
                  },
                  limit | optional | Number,
                },
                syncOptions | optional | Array String,
              },
            },
          },
          values | optional | {
          },
        },
        selector | optional | {
          matchExpressions | optional | Array {
            key | String,
            operator | String,
            values | optional | Array String,
          },
          matchLabels | optional | {
          },
        },
      },
      goTemplate | optional | Bool,
      goTemplateOptions | optional | Array String,
      ignoreApplicationDifferences | optional | Array {
        jqPathExpressions | optional | Array String,
        jsonPointers | optional | Array String,
        name | optional | String,
      },
      preservedFields | optional | {
        annotations | optional | Array String,
        labels | optional | Array String,
      },
      strategy | optional | {
        rollingSync | optional | {
          steps | optional | Array {
            matchExpressions | optional | Array {
              key | optional | String,
              operator | optional | String,
              values | optional | Array String,
            },
            maxUpdate | optional | Number | String,
          },
        },
        type | optional | String,
      },
      syncPolicy | optional | {
        applicationsSync | optional | String,
        preserveResourcesOnDeletion | optional | Bool,
      },
      template | {
        metadata | {
          annotations | optional | {
          },
          finalizers | optional | Array String,
          labels | optional | {
          },
          name | optional | String,
          namespace | optional | String,
        },
        spec | {
          destination | {
            name | optional | String,
            namespace | optional | String,
            server | optional | String,
          },
          ignoreDifferences | optional | Array {
            group | optional | String,
            jqPathExpressions | optional | Array String,
            jsonPointers | optional | Array String,
            kind | String,
            managedFieldsManagers | optional | Array String,
            name | optional | String,
            namespace | optional | String,
          },
          info | optional | Array {
            name | String,
            value | String,
          },
          project | String,
          revisionHistoryLimit | optional | Number,
          source | optional | {
            chart | optional | String,
            directory | optional | {
              exclude | optional | String,
              include | optional | String,
              jsonnet | optional | {
                extVars | optional | Array {
                  code | optional | Bool,
                  name | String,
                  value | String,
                },
                libs | optional | Array String,
                tlas | optional | Array {
                  code | optional | Bool,
                  name | String,
                  value | String,
                },
              },
              recurse | optional | Bool,
            },
            helm | optional | {
              apiVersions | optional | Array String,
              fileParameters | optional | Array {
                name | optional | String,
                path | optional | String,
              },
              ignoreMissingValueFiles | optional | Bool,
              kubeVersion | optional | String,
              namespace | optional | String,
              parameters | optional | Array {
                forceString | optional | Bool,
                name | optional | String,
                value | optional | String,
              },
              passCredentials | optional | Bool,
              releaseName | optional | String,
              skipCrds | optional | Bool,
              skipSchemaValidation | optional | Bool,
              skipTests | optional | Bool,
              valueFiles | optional | Array String,
              values | optional | String,
              valuesObject | optional | {
              },
              version | optional | String,
            },
            kustomize | optional | {
              apiVersions | optional | Array String,
              commonAnnotations | optional | {
              },
              commonAnnotationsEnvsubst | optional | Bool,
              commonLabels | optional | {
              },
              components | optional | Array String,
              forceCommonAnnotations | optional | Bool,
              forceCommonLabels | optional | Bool,
              ignoreMissingComponents | optional | Bool,
              images | optional | Array String,
              kubeVersion | optional | String,
              labelIncludeTemplates | optional | Bool,
              labelWithoutSelector | optional | Bool,
              namePrefix | optional | String,
              nameSuffix | optional | String,
              namespace | optional | String,
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
              },
              replicas | optional | Array {
                count | Number | String,
                name | String,
              },
              version | optional | String,
            },
            name | optional | String,
            path | optional | String,
            plugin | optional | {
              env | optional | Array k8s_io_objectmeta.EnvVar,
              name | optional | String,
              parameters | optional | Array {
                array | optional | Array String,
                map | optional | {
                },
                name | optional | String,
                string | optional | String,
              },
            },
            ref | optional | String,
            repoURL | String,
            targetRevision | optional | String,
          },
          sourceHydrator | optional | {
            drySource | {
              path | String,
              repoURL | String,
              targetRevision | String,
            },
            hydrateTo | optional | {
              targetBranch | String,
            },
            syncSource | {
              path | String,
              targetBranch | String,
            },
          },
          sources | optional | Array {
            chart | optional | String,
            directory | optional | {
              exclude | optional | String,
              include | optional | String,
              jsonnet | optional | {
                extVars | optional | Array {
                  code | optional | Bool,
                  name | String,
                  value | String,
                },
                libs | optional | Array String,
                tlas | optional | Array {
                  code | optional | Bool,
                  name | String,
                  value | String,
                },
              },
              recurse | optional | Bool,
            },
            helm | optional | {
              apiVersions | optional | Array String,
              fileParameters | optional | Array {
                name | optional | String,
                path | optional | String,
              },
              ignoreMissingValueFiles | optional | Bool,
              kubeVersion | optional | String,
              namespace | optional | String,
              parameters | optional | Array {
                forceString | optional | Bool,
                name | optional | String,
                value | optional | String,
              },
              passCredentials | optional | Bool,
              releaseName | optional | String,
              skipCrds | optional | Bool,
              skipSchemaValidation | optional | Bool,
              skipTests | optional | Bool,
              valueFiles | optional | Array String,
              values | optional | String,
              valuesObject | optional | {
              },
              version | optional | String,
            },
            kustomize | optional | {
              apiVersions | optional | Array String,
              commonAnnotations | optional | {
              },
              commonAnnotationsEnvsubst | optional | Bool,
              commonLabels | optional | {
              },
              components | optional | Array String,
              forceCommonAnnotations | optional | Bool,
              forceCommonLabels | optional | Bool,
              ignoreMissingComponents | optional | Bool,
              images | optional | Array String,
              kubeVersion | optional | String,
              labelIncludeTemplates | optional | Bool,
              labelWithoutSelector | optional | Bool,
              namePrefix | optional | String,
              nameSuffix | optional | String,
              namespace | optional | String,
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
              },
              replicas | optional | Array {
                count | Number | String,
                name | String,
              },
              version | optional | String,
            },
            name | optional | String,
            path | optional | String,
            plugin | optional | {
              env | optional | Array k8s_io_objectmeta.EnvVar,
              name | optional | String,
              parameters | optional | Array {
                array | optional | Array String,
                map | optional | {
                },
                name | optional | String,
                string | optional | String,
              },
            },
            ref | optional | String,
            repoURL | String,
            targetRevision | optional | String,
          },
          syncPolicy | optional | {
            automated | optional | {
              allowEmpty | optional | Bool,
              enabled | optional | Bool,
              prune | optional | Bool,
              selfHeal | optional | Bool,
            },
            managedNamespaceMetadata | optional | {
              annotations | optional | {
              },
              labels | optional | {
              },
            },
            retry | optional | {
              backoff | optional | {
                duration | optional | String,
                factor | optional | Number,
                maxDuration | optional | String,
              },
              limit | optional | Number,
            },
            syncOptions | optional | Array String,
          },
        },
      },
      templatePatch | optional | String,
    },
    status | optional | {
      applicationStatus | optional | Array {
        application | String,
        lastTransitionTime | optional | String,
        message | String,
        status | String,
        step | String,
        targetRevisions | Array String,
      },
      conditions | optional | Array {
        lastTransitionTime | optional | String,
        message | String,
        reason | String,
        status | String,
        type | String,
      },
      resources | optional | Array {
        group | optional | String,
        health | optional | {
          lastTransitionTime | optional | String,
          message | optional | String,
          status | optional | String,
        },
        hook | optional | Bool,
        kind | optional | String,
        name | optional | String,
        namespace | optional | String,
        requiresDeletionConfirmation | optional | Bool,
        requiresPruning | optional | Bool,
        status | optional | String,
        syncWave | optional | Number,
        version | optional | String,
      },
    },
  },
}
