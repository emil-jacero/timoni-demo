# Timoni Demo

## Prerequisite

Download go modules.
(These modules can later be used to generate CUE schemas)

```shell
go get -d k8s.io/api/core/v1
go get -d github.com/fluxcd/helm-controller
go get -d github.com/fluxcd/source-controller
go get -d github.com/fluxcd/kustomize-controller
go get -d github.com/fluxcd/image-automation-controller
go get -d github.com/fluxcd/image-reflector-controller
go get -d github.com/fluxcd/notification-controller
```

Optional: Generate cue schema from go modules

```shell
cue get go k8s.io/api/core/v1
cue get go github.com/fluxcd/helm-controller/api/v2beta2
cue get go github.com/fluxcd/source-controller/api/v1
cue get go github.com/fluxcd/source-controller/api/v1beta2
cue get go github.com/fluxcd/kustomize-controller/api/v1
cue get go github.com/fluxcd/image-automation-controller/api/v1beta1
cue get go github.com/fluxcd/image-reflector-controller/api/v1beta1
cue get go github.com/fluxcd/notification-controller/api/v1
```

Pull and run a docker registry

```shell
docker run -d -p 5000:5000 --restart always --name registry registry:2
```

Upload modules to the local OCI registry

```shell
timoni mod push ./modules/grafana oci://localhost:5000/modules/grafana \
  --latest=true \
  --version=1.0.0
```

Upload bundles to the local OCI registry

```shell
timoni artifact push oci://localhost:5000/bundles/podinfo-redis \
  -f ./bundles/podinfo-redis/ \
  --tag=1.0.0
```

## Build Example 1

List bundles

```shell
cd  cluster-cfg/cfg/
cue ls
```

Test the build script

```shell
cd  cluster-cfg/cfg/
cue build
```
