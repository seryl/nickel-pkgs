# Module: appproject.argoproj.io

let k8s_io_objectmeta = import "k8s_io" in

{
  AppProject = {
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
    metadata | k8s_io_objectmeta.ObjectMeta,
    spec | {
      clusterResourceBlacklist | optional | Array {
        group | String,
        kind | String,
      } | doc "ClusterResourceBlacklist contains list of blacklisted cluster level resources",
      clusterResourceWhitelist | optional | Array {
        group | String,
        kind | String,
      } | doc "ClusterResourceWhitelist contains list of whitelisted cluster level resources",
      description | optional | String | doc "Description contains optional project description",
      destinationServiceAccounts | optional | Array {
        defaultServiceAccount | String | doc "DefaultServiceAccount to be used for impersonation during the sync operation",
        namespace | optional | String | doc "Namespace specifies the target namespace for the application's resources.",
        server | String | doc "Server specifies the URL of the target cluster's Kubernetes control plane API.",
      } | doc m%"
DestinationServiceAccounts holds information about the service accounts to be impersonated for the application sync operation for each destination.
"%,
      destinations | optional | Array {
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
      } | doc "Destinations contains list of destinations available for deployment",
      namespaceResourceBlacklist | optional | Array {
        group | String,
        kind | String,
      } | doc m%"
NamespaceResourceBlacklist contains list of blacklisted namespace level resources
"%,
      namespaceResourceWhitelist | optional | Array {
        group | String,
        kind | String,
      } | doc m%"
NamespaceResourceWhitelist contains list of whitelisted namespace level resources
"%,
      orphanedResources | optional | {
        ignore | optional | Array {
          group | optional | String,
          kind | optional | String,
          name | optional | String,
        } | doc m%"
Ignore contains a list of resources that are to be excluded from orphaned resources monitoring
"%,
        warn | optional | Bool | doc m%"
Warn indicates if warning condition should be created for apps which have orphaned resources
"%,
      } | doc m%"
OrphanedResources specifies if controller should monitor orphaned resources of apps in this project
"%,
      permitOnlyProjectScopedClusters | optional | Bool | doc m%"
PermitOnlyProjectScopedClusters determines whether destinations can only reference clusters which are project-scoped
"%,
      roles | optional | Array {
        description | optional | String | doc "Description is a description of the role",
        groups | optional | Array String | doc "Groups are a list of OIDC group claims bound to this role",
        jwtTokens | optional | Array {
          exp | optional | Number,
          iat | Number,
          id | optional | String,
        } | doc "JWTTokens are a list of generated JWT tokens bound to this role",
        name | String | doc "Name is a name for this role",
        policies | optional | Array String | doc m%"
Policies Stores a list of casbin formatted strings that define access policies for the role in the project
"%,
      } | doc "Roles are user defined RBAC roles associated with this project",
      signatureKeys | optional | Array {
        keyID | String | doc "The ID of the key in hexadecimal notation",
      } | doc m%"
SignatureKeys contains a list of PGP key IDs that commits in Git must be signed with in order to be allowed for sync
"%,
      sourceNamespaces | optional | Array String | doc m%"
SourceNamespaces defines the namespaces application resources are allowed to be created in
"%,
      sourceRepos | optional | Array String | doc "SourceRepos contains list of repository URLs which can be used for deployment",
      syncWindows | optional | Array {
        andOperator | optional | Bool | doc m%"
UseAndOperator use AND operator for matching applications, namespaces and clusters instead of the default OR operator
"%,
        applications | optional | Array String | doc "Applications contains a list of applications that the window will apply to",
        clusters | optional | Array String | doc "Clusters contains a list of clusters that the window will apply to",
        description | optional | String | doc m%"
Description of the sync that will be applied to the schedule, can be used to add any information such as a ticket number for example
"%,
        duration | optional | String | doc "Duration is the amount of time the sync window will be open",
        kind | optional | String | doc "Kind defines if the window allows or blocks syncs",
        manualSync | optional | Bool | doc "ManualSync enables manual syncs when they would otherwise be blocked",
        namespaces | optional | Array String | doc "Namespaces contains a list of namespaces that the window will apply to",
        schedule | optional | String | doc "Schedule is the time the window will begin, specified in cron format",
        timeZone | optional | String | doc "TimeZone of the sync that will be applied to the schedule",
      } | doc "SyncWindows controls when syncs can be run for apps in this project",
    } | doc "AppProjectSpec is the specification of an AppProject",
    status | optional | {
      jwtTokensByRole | optional | {
      } | doc "JWTTokensByRole contains a list of JWT tokens issued for a given role",
    } | doc "AppProjectStatus contains status information for AppProject CRs",
  },
}
