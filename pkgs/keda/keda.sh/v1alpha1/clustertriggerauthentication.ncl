# Module: clustertriggerauthentication.keda.sh

let k8s_io_objectmeta = import "k8s_io" in
let k8s_io_envvar = import "k8s_io" in

{
  ClusterTriggerAuthentication = {
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
      awsSecretManager | optional | {
        credentials | optional | {
          accessKey | {
            valueFrom | {
              secretKeyRef | {
                key | String,
                name | String,
              },
            },
          },
          accessSecretKey | {
            valueFrom | {
              secretKeyRef | {
                key | String,
                name | String,
              },
            },
          },
          accessToken | optional | {
            valueFrom | {
              secretKeyRef | {
                key | String,
                name | String,
              },
            },
          },
        },
        podIdentity | optional | {
          identityAuthorityHost | optional | String | doc m%"
Set identityAuthorityHost to override the default Azure authority host. If this is set, then the IdentityTenantID must also be set
"%,
          identityId | optional | String,
          identityOwner | optional | String | doc m%"
IdentityOwner configures which identity has to be used during auto discovery, keda or the scaled workload. Mutually exclusive with roleArn
"%,
          identityTenantId | optional | String | doc m%"
Set identityTenantId to override the default Azure tenant id. If this is set, then the IdentityID must also be set
"%,
          provider | String | doc "PodIdentityProvider contains the list of providers",
          roleArn | optional | String | doc "RoleArn sets the AWS RoleArn to be used. Mutually exclusive with IdentityOwner",
        } | doc m%"
AuthPodIdentity allows users to select the platform native identity
mechanism
"%,
        region | optional | String,
        secrets | Array {
          name | String,
          parameter | String,
          secretKey | optional | String,
          versionId | optional | String,
          versionStage | optional | String,
        },
      } | doc "AwsSecretManager is used to authenticate using AwsSecretManager",
      azureKeyVault | optional | {
        cloud | optional | {
          activeDirectoryEndpoint | optional | String,
          keyVaultResourceURL | optional | String,
          type | String,
        },
        credentials | optional | {
          clientId | String,
          clientSecret | {
            valueFrom | {
              secretKeyRef | {
                key | String,
                name | String,
              },
            },
          },
          tenantId | String,
        },
        podIdentity | optional | {
          identityAuthorityHost | optional | String | doc m%"
Set identityAuthorityHost to override the default Azure authority host. If this is set, then the IdentityTenantID must also be set
"%,
          identityId | optional | String,
          identityOwner | optional | String | doc m%"
IdentityOwner configures which identity has to be used during auto discovery, keda or the scaled workload. Mutually exclusive with roleArn
"%,
          identityTenantId | optional | String | doc m%"
Set identityTenantId to override the default Azure tenant id. If this is set, then the IdentityID must also be set
"%,
          provider | String | doc "PodIdentityProvider contains the list of providers",
          roleArn | optional | String | doc "RoleArn sets the AWS RoleArn to be used. Mutually exclusive with IdentityOwner",
        } | doc m%"
AuthPodIdentity allows users to select the platform native identity
mechanism
"%,
        secrets | Array {
          name | String,
          parameter | String,
          version | optional | String,
        },
        vaultUri | String,
      } | doc "AzureKeyVault is used to authenticate using Azure Key Vault",
      boundServiceAccountToken | optional | Array {
        parameter | String,
        serviceAccountName | String,
      },
      configMapTargetRef | optional | Array {
        key | String,
        name | String,
        parameter | String,
      },
      env | optional | Array k8s_io_objectmeta.EnvVar,
      gcpSecretManager | optional | {
        credentials | optional | {
          clientSecret | {
            valueFrom | {
              secretKeyRef | {
                key | String,
                name | String,
              },
            },
          },
        },
        podIdentity | optional | {
          identityAuthorityHost | optional | String | doc m%"
Set identityAuthorityHost to override the default Azure authority host. If this is set, then the IdentityTenantID must also be set
"%,
          identityId | optional | String,
          identityOwner | optional | String | doc m%"
IdentityOwner configures which identity has to be used during auto discovery, keda or the scaled workload. Mutually exclusive with roleArn
"%,
          identityTenantId | optional | String | doc m%"
Set identityTenantId to override the default Azure tenant id. If this is set, then the IdentityID must also be set
"%,
          provider | String | doc "PodIdentityProvider contains the list of providers",
          roleArn | optional | String | doc "RoleArn sets the AWS RoleArn to be used. Mutually exclusive with IdentityOwner",
        } | doc m%"
AuthPodIdentity allows users to select the platform native identity
mechanism
"%,
        secrets | Array {
          id | String,
          parameter | String,
          version | optional | String,
        },
      },
      hashiCorpVault | optional | {
        address | String,
        authentication | String | doc "VaultAuthentication contains the list of Hashicorp Vault authentication methods",
        credential | optional | {
          serviceAccount | optional | String,
          token | optional | String,
        } | doc m%"
Credential defines the Hashicorp Vault credentials depending on the authentication method
"%,
        mount | optional | String,
        namespace | optional | String,
        role | optional | String,
        secrets | Array {
          key | String,
          parameter | String,
          path | String,
          pkiData | optional | {
            altNames | optional | String,
            commonName | optional | String,
            format | optional | String,
            ipSans | optional | String,
            otherSans | optional | String,
            ttl | optional | String,
            uriSans | optional | String,
          },
          type | optional | String | doc "VaultSecretType defines the type of vault secret",
        },
      } | doc "HashiCorpVault is used to authenticate using Hashicorp Vault",
      podIdentity | optional | {
        identityAuthorityHost | optional | String | doc m%"
Set identityAuthorityHost to override the default Azure authority host. If this is set, then the IdentityTenantID must also be set
"%,
        identityId | optional | String,
        identityOwner | optional | String | doc m%"
IdentityOwner configures which identity has to be used during auto discovery, keda or the scaled workload. Mutually exclusive with roleArn
"%,
        identityTenantId | optional | String | doc m%"
Set identityTenantId to override the default Azure tenant id. If this is set, then the IdentityID must also be set
"%,
        provider | String | doc "PodIdentityProvider contains the list of providers",
        roleArn | optional | String | doc "RoleArn sets the AWS RoleArn to be used. Mutually exclusive with IdentityOwner",
      } | doc m%"
AuthPodIdentity allows users to select the platform native identity
mechanism
"%,
      secretTargetRef | optional | Array {
        key | String,
        name | String,
        parameter | String,
      },
    } | doc "TriggerAuthenticationSpec defines the various ways to authenticate",
    status | optional | {
      scaledjobs | optional | String,
      scaledobjects | optional | String,
    } | doc "TriggerAuthenticationStatus defines the observed state of TriggerAuthentication",
  },
}
