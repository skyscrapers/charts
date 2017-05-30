## A Helm Chart for CoreOS Dex

Originates from https://github.com/samsung-cnct/k2-charts

## Installation
Install this in your cluster with [Helm](https://github.com/kubernetes/helm):

```
helm repo add cnct http://atlas.cnct.io
```
```
helm install cnct/dex
```

Get Helm [here](https://github.com/kubernetes/helm/blob/master/docs/install.md).

Or add the following to your [K2](https://github.com/samsung-cnct/k2) configuration template:
```
helmConfigs:
  - &defaultHelm
    name: defaultHelm
    kind: helm
    repos:
      -
        name: atlas
        url: http://atlas.cnct.io
    charts:
      -
        name: dex
        repo: atlas
        chart: dex
        version: 0.1.0
        namespace: kube-auth
        values:
          Dex:
            Issuer: <Your Dex Issuer URI, browser should accessiable on it, DexApp either.>
            Connector:
              OIDC:

                ClientId: <Your Client ID>
                ClientSecret: <Your Client Secret>
          DexApp:
            RedirectUri: <Your DexApp Redirect URI, browser should be accessible on it.>
```

Get [K2](https://github.com/samsung-cnct/k2) to help you deploy a Kubernetes cluster.

## Assets

Kubernetes Assets in this chart.

**Dex**
oidc provider.
can support various connector backend like
  - LDAP
  - OIDC (including Google)
  - GitHub OAuth
  - Facebook OAuth

see details in [official site](https://github.com/coreos/dex)

default values below

```
Dex:
  Image: "quay.io/coreos/dex"
  ImageTag: "v2.0.0-beta.1"
  ImagePullPolicy: "Always"
  Component: "dex"

  NodePort: 30443
  Issuer: "https://kube-1.local.io:30443"

  Tls:
    Ca: <Your TLS CA Cert, base64 encoded PEM>
    Cert: <Your TLS Cert, base64 encoded PEM>
    Key: <Your TLS Key, base64 encoded PEM>

  Connector:
    MockCallback: true
    GitHub:
      Name: GitHub
      ClientId: <Your Client ID>
      ClientSecret: <Your Client Secret>
    Oidc:
      Name: Google
      Issuer: <Your OIDC Issuer>
      ClientId: <Your OIDC Client ID>
      ClientSecret: <Your OIDC Client Secret>
    Ldap:
      Name: LDAP
      Host: <Your LDAP endpoint>
      InsecureNoSsl: true
      InsecureSkipVerify: true
      BindDn: <Your LDAP Bind DN>
      BindPw: <Your LDAP Bind PW>
      UserSearch:
        BaseDn: <Your User Base DN>
        Filter: <Your User Search Filter>
        Username: <User Attribute>
        IdAttr: <User Attribute>
        EmailAttr: <User Attribute>
        NameAttr: <User Attribute>
      GroupSearch:
        BaseDn: <Your Group Base DN>
        Filter: <Your Group Search Filter>
        UserAttr: <Group Attribute>
        GroupAttr: <Group Attribute>
        NameAttr: <Group Attribute>

  StaticPassword:
    Email: <Your Email Account>
    Password: <Password, bcrypted hash>
    Username: <Your Username>

  Memory: "200Mi"
  Cpu: "512m"
  ServicePort: 443
  Replicas: 1
```

**DexApp**
example-app for using dex.
enduser should access the app first to use ODIC authentication with.
it will access to Dex.

default values below

```
DexApp:
  Image: "quay.io/keyolk/dex-app"
  ImageTag: "0.0.1"
  ImagePullPolicy: "Always"
  Component: "dex-app"

  NodePort: 30080
  RedirectUri: http://kube-1.local.io:30080/callback

  Memory: "200Mi"
  Cpu: "512m"
  Replicas: 1
```

## Test
1. Access to DexApp using browser.
2. Push login button.
3. Select auth option.
4. Here you get auth info like below.

```
Token:

eyJhbGciOiJSUzI1NiIsImtpZCI6IjNlNWM4MjA4ZTMxYzY2ZDJkOTIzODI1ZjNhOTEwMWU0ZDhjOWY3M2EifQ.eyJpc3MiOiJodHRwczovL2RleC5rZXlvbGsua3ViZS5jbHVzdGVyLmlvOjMwNDQzIiwic3ViIjoiMTA4MjIxMTM1MDU3MjY4MDI5NzMyIiwiYXVkIjoiZXhhbXBsZS1hcHAiLCJleHAiOjE0ODMwNDEyNTUsImlhdCI6MTQ4Mjk1NDg1NSwiZW1haWwiOiJrZXlvbGtAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiLsoJXssKztm4gifQ.jRl6x2UshoFBIpHm2UqmsliORLn2aQ_Zk1BLAjWwmmBsA8dhvL1CbEWNRuBUBWeadXR4D-CWe7g6mR3pwvUntOTzoLzfo5RecVOdqa3A8bTtBR9gmqhy_bObg9a9looFOWxeVEDMy5CrJEh9TLIkSbj5ITDjRClp6xPgIa-qQDDog0w5IcLuNJOrjuwDiI8KaYMj1bvIXvVsBYXLmZKe9MGWNsgF4XYY3jm9ShVnjP46bmokE16sB4VjQi6kR0oYkIdljT9rF7jmyupVaBMfgiWRD5-yAr0jVy-42IvXN9W01CSJtN5xqWYljQEbrBDmLbJh4nulNTJftNMR-_wm9g
Claims:

{
  "iss": "https://kube-1.local.io:30443",
  "sub": "108221135057268029732",
  "aud": "example-app",
  "exp": 1483041255,
  "iat": 1482954855,
  "email": "keyolk@gmail.com",
  "email_verified": true,
  "name": "keyolk"
}
Refresh Token:

lsuhkxpt6sfcdtsxeh2wsxlqiu
Redeem refresh token
```

now you can  use the token. kubectl example below.
```
$ kubectl config set-credentials keyolk --token=$THE_TOKEN_USE_GET
$ kubectl config set-context dex-test --namespace=default --user=keyolk --cluster=kraken
$ kubectl config use-context dex-test
$ kubectl get node
```

## To Do
- Support GRPC endpoints for registering client dynamically(Currently support static client only : example-app)
- Support various Storage Backend : SQL, SQLite3, Postgres(Currently support kubernetes third party resources only)
- Support multiple oidc connector
- Support facebook oauth connector

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Credit

Created and maintained by the Samsung Cloud Native Computing Team.
