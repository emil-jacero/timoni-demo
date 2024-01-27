package clusters

import (derpv1 "github.com/emil-jacero/timoni-ext/v1alpha1")

clusters: [cl1Devel]

cl1Devel: derpv1.#Cluster & {
    apiVersion: "v1alpha1"
    name: "cl1"
    group: "devel"
    instances: {
        "podinfo-redis": {
            bundle: {
                url: "oci://localhost:5000/bundles/podinfo-redis"
                tag: "1.0.0"
            }
            namespace: "podinfo-redis"
        }
    }
    clusterConfig: {
        clusterDomain: "devel.cl1.example.com"
    }
}
