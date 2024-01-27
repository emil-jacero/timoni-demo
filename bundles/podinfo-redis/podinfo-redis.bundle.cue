_namespace: "podinfo"

bundle: {
    apiVersion: "v1alpha1"
    name:       "podinfo"
    instances: {
        redis: {
            module: {
                url:     "oci://ghcr.io/stefanprodan/modules/redis"
                version: "7.2.3"
            }
            namespace: _namespace
            values: maxmemory: 256
        }
        podinfo: {
            module: url:     "oci://ghcr.io/stefanprodan/modules/podinfo"
            module: version: "6.5.4"
            namespace: _namespace
            values: caching: {
                enabled:  true
                redisURL: "tcp://redis:6379"
            }
        }
    }
}