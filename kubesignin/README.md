# A Helm Chart for Kubesignin

Originates from https://github.com/skyscrapers/kubesignin

## Installation

Install this in your cluster with [Helm](https://github.com/kubernetes/helm):
Get Helm [here](https://github.com/kubernetes/helm/blob/master/docs/install.md).

```
helm repo add skyscrapers https://skyscrapers.github.io/charts
```
```
helm install skyscrapers/kubesignin
```

## Assets

Kubernetes Assets in this chart.

### Kubesignin

Kubesignin is an OpenID Connect client that will use dex.
This is the application which the end user should access to authenticate.

Default values below. Check the `values.yaml` file to see the possible configuration values.

```
Kubesignin:
  Image: "skyscrapers/kubesignin"
  ImageTag: "latest"
  ImagePullPolicy: "Always"

  Memory: "200Mi"
  Cpu: "512m"
  Replicas: 1
```

### Dex

Dex is an OIDC provider.
Can support various connector backends like
  - LDAP
  - OIDC (including Google)
  - GitHub OAuth
  - Facebook OAuth

See details in [official site](https://github.com/coreos/dex)

Default values below. Check the `values.yaml` file to see the possible configuration values.

```
Dex:
  Image: "quay.io/coreos/dex"
  ImageTag: "v2.4.1"
  ImagePullPolicy: "Always"

  Memory: "200Mi"
  Cpu: "512m"
  ServicePort: 443
  Replicas: 1
```

## Usage

1. Access Kubesignin using the browser, normally this will be `https://kubesignin.yourdomain.com/login`
2. Select auth option.
3. Here you get auth info like below.

```
Token:

eyJhbGciOiJSUzI1NiIsImtpZCI6IjBjZmRmMWE4MDgxOWUwZTkyOTA4ZjU0Y2M0M2E1Yzk2OTg0YWU1YzgifQ.eyJpc3MiOiJodHRwczovL2t1YmVzaWduaW4udGVzdC5za3lzY3JhcGUucnMvZGV4Iiwic3ViIjoiQ2dZMU1UQTRNRGtTQm1kcGRHaDFZZyIsImF1ZCI6Imt1YmVzaWduaW4iLCJleHAiOjE0OTY0MjMzNzIsImlhdCI6MTQ5NjMzNjk3MiwiYXRfaGFzaCI6InpwWjVvMVJVSktEQkl4aTZncVR3eUEiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZ3JvdXBzIjpbInNreXNjcmFwZXJzIiwidGVhbWxlYWRlci1ib3RzIl0sIm5hbWUiOiJpdXJpIGFyYW5kYSJ9.yTLYCC1KG_-XuR745olYIQWCvGBtOp5W3vYsmXQGUVV0BG60GfSNDwuc8ZiD64iPe0ZTmvpjhjvMT-pw69SIRDZiu2ETU03roNNtQX9nmSEF2lih8YI15IM8wutpE6gkayiWIz_LGbOF9pISTou1XZ-yuAEZj0c9BYmIzMa7RzWmsEYfrXCkgaxrTmhbp6Nkz4ruyrynp0uIoOc24VjIU9A6llX_R8Y75oup6-_hEo30BfumgDUq6CIqmC2640vSAyckrXxOsNPMzTKYHZZkM6v0JLKzyboTEUtPVobhjlkVJb_rsKpLfeDW_UUvWc3BwUdBGuVIzExPx_I1_PnTXQ
Claims:

{
  "iss": "https://kubesignin.yourdomain.com/dex",
  "sub": "CgY1MTA4MDkSBmdpdGh1Yg",
  "aud": "kubesignin",
  "exp": 1496423372,
  "iat": 1496336972,
  "at_hash": "zpZ5o1RUJKDBIxi6gqTwyA",
  "email_verified": true,
  "groups": [
    "skyscrapers"
  ],
  "name": "iuri aranda"
}
```

Now you can use the token to access your Kubernetes cluster. kubectl example below.
```
$ kubectl config set-credentials iuri --token=$THE_TOKEN_USE_GET
$ kubectl config set-context mycluster --namespace=default --user=iuri --cluster=mycluster
$ kubectl config use-context mycluster
$ kubectl get node
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Credit

Created and maintained by Skyscrapers.
