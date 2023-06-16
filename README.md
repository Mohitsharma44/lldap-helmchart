# lldap

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for installing LLDAP

## TL;DR

* Installing LLDAP using K8s volumes and volumeClaims

```
helm install lldap . --namespace auth -f example_values/values_using_volume.yaml
```

* Installing LLDAP along with MariaDB

WIP

* Installing LLDAP with an already installed MariaDB/ SQL DB

WIP

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraVolumeMounts | object | `{}` | If using volume to store data |
| extraVolumes | object | `{}` | If using volume to store data |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"nitnelave/lldap"` | Image to use for deploying LLDAP |
| image.tag | string | `"stable"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.enabled | bool | `true` | Whether liveness probe should be used |
| lldap.base_dn | string | `""` |  |
| lldap.extra_env_vars | object | `{}` |  |
| lldap.http_port | int | `17170` |  |
| lldap.ldap_port | int | `3890` |  |
| lldap.ldaps.cert_file_secret | string | `""` |  |
| lldap.ldaps.create_cert_file_secret | bool | `true` |  |
| lldap.ldaps.create_key_file_secret | bool | `true` |  |
| lldap.ldaps.key_file_secret | string | `""` |  |
| lldap.timezone | string | `""` |  |
| nameOverride | string | `""` |  |
| persistentVolumeClaims | object | `{}` | If using volume to store data |
| podAnnotations | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1001` |  |
| readinessProbe.enabled | bool | `true` | Whether readiness probe should be used |
| replicaCount | int | `1` | If you are not using an external DB, do not increase this to more than one |
| service.http.annotations | object | `{}` |  |
| service.http.type | string | `"ClusterIP"` |  |
| service.ldap.annotations | object | `{}` |  |
| service.ldap.loadBalancerIP | string | `""` |  |
| service.ldap.type | string | `"LoadBalancer"` | default is LoadBalancer so that services can reach the LDAP service  |
