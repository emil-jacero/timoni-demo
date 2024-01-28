#namespace: "podinfo"

bundle: {
    apiVersion: "v1alpha1"
    name:       "podinfo"
    instances: {
        redis: {
            module: {
                url:     "oci://ghcr.io/stefanprodan/modules/redis"
                version: "7.2.3"
            }
            namespace: #namespace
            values: maxmemory: 256
        }
        podinfo: {
            module: url:     "oci://ghcr.io/stefanprodan/modules/podinfo"
            module: version: "6.5.4"
            namespace: #namespace
            values: caching: {
                enabled:  true
                // redisURL: "tcp://redis:6379"
                redisURL: "tcp://\(_ClusterConfig.clusterDomain):6379"
            }
        }
    }
}