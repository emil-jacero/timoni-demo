package clusters

import (timoniextv1 "github.com/emil-jacero/timoni-ext/v1alpha1")

clusters: [cl1Devel]

cl1Devel: timoniextv1.#Cluster & {
    apiVersion: "v1alpha1"
    name: "cl1"
    group: "devel"
    instances: {
        "podinfo-redis": {
            instanceType: "bundle"
            source: {
                url: "oci://localhost:5000/bundles/podinfo-redis"
                tag: "1.0.0"
            }
            namespace: "podinfo-redis"
            values: {...}
        }
        "obs-aio": {
            instanceType: "bundle"
            source: {
                url: "oci://localhost:5000/bundles/observability-aio"
                tag: "0.1.0"
            }
            namespace: "podinfo-redis"
            values: {...}
        }
    }
    // clusterConfig: timoniextv1.#ClusterConfig & _ClusterConfig
}
