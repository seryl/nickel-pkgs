# Module: certificaterequest.cert-manager.io

let k8s_io_objectmeta = import "k8s_io" in

{
  CertificateRequest = {
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
      duration | optional | String | doc m%"
Requested 'duration' (i.e. lifetime) of the Certificate. Note that the
issuer may choose to ignore the requested duration, just like any other
requested attribute.
"%,
      extra | optional | {
      } | doc m%"
Extra contains extra attributes of the user that created the CertificateRequest.
Populated by the cert-manager webhook on creation and immutable.
"%,
      groups | optional | Array String | doc m%"
Groups contains group membership of the user that created the CertificateRequest.
Populated by the cert-manager webhook on creation and immutable.
"%,
      isCA | optional | Bool | doc m%"
Requested basic constraints isCA value. Note that the issuer may choose
to ignore the requested isCA value, just like any other requested attribute.

NOTE: If the CSR in the `Request` field has a BasicConstraints extension,
it must have the same isCA value as specified here.

If true, this will automatically add the `cert sign` usage to the list
of requested `usages`.
"%,
      issuerRef | {
        group | optional | String | doc "Group of the resource being referred to.",
        kind | optional | String | doc "Kind of the resource being referred to.",
        name | String | doc "Name of the resource being referred to.",
      } | doc m%"
Reference to the issuer responsible for issuing the certificate.
If the issuer is namespace-scoped, it must be in the same namespace
as the Certificate. If the issuer is cluster-scoped, it can be used
from any namespace.

The `name` field of the reference must always be specified.
"%,
      request | String | doc m%"
The PEM-encoded X.509 certificate signing request to be submitted to the
issuer for signing.

If the CSR has a BasicConstraints extension, its isCA attribute must
match the `isCA` value of this CertificateRequest.
If the CSR has a KeyUsage extension, its key usages must match the
key usages in the `usages` field of this CertificateRequest.
If the CSR has a ExtKeyUsage extension, its extended key usages
must match the extended key usages in the `usages` field of this
CertificateRequest.
"%,
      uid | optional | String | doc m%"
UID contains the uid of the user that created the CertificateRequest.
Populated by the cert-manager webhook on creation and immutable.
"%,
      usages | optional | Array String | doc m%"
Requested key usages and extended key usages.

NOTE: If the CSR in the `Request` field has uses the KeyUsage or
ExtKeyUsage extension, these extensions must have the same values
as specified here without any additional values.

If unset, defaults to `digital signature` and `key encipherment`.
"%,
      username | optional | String | doc m%"
Username contains the name of the user that created the CertificateRequest.
Populated by the cert-manager webhook on creation and immutable.
"%,
    } | doc m%"
Specification of the desired state of the CertificateRequest resource.
https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
"%,
    status | optional | {
      ca | optional | String | doc m%"
The PEM encoded X.509 certificate of the signer, also known as the CA
(Certificate Authority).
This is set on a best-effort basis by different issuers.
If not set, the CA is assumed to be unknown/not available.
"%,
      certificate | optional | String | doc m%"
The PEM encoded X.509 certificate resulting from the certificate
signing request.
If not set, the CertificateRequest has either not been completed or has
failed. More information on failure can be found by checking the
`conditions` field.
"%,
      conditions | optional | Array {
        lastTransitionTime | optional | String | doc m%"
LastTransitionTime is the timestamp corresponding to the last status
change of this condition.
"%,
        message | optional | String | doc m%"
Message is a human readable description of the details of the last
transition, complementing reason.
"%,
        reason | optional | String | doc m%"
Reason is a brief machine readable explanation for the condition's last
transition.
"%,
        status | String | doc "Status of the condition, one of (`True`, `False`, `Unknown`).",
        type | String | doc m%"
Type of the condition, known values are (`Ready`, `InvalidRequest`,
`Approved`, `Denied`).
"%,
      } | doc m%"
List of status conditions to indicate the status of a CertificateRequest.
Known condition types are `Ready`, `InvalidRequest`, `Approved` and `Denied`.
"%,
      failureTime | optional | String | doc m%"
FailureTime stores the time that this CertificateRequest failed. This is
used to influence garbage collection and back-off.
"%,
    } | doc m%"
Status of the CertificateRequest.
This is set and managed automatically.
Read-only.
More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
"%,
  },
}
