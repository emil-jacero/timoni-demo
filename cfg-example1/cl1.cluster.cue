package clusters

// import (timoniextv1 "github.com/emil-jacero/timoni-ext/v1alpha1")

#Clusters: [cl1Devel,cl1Staging,cl1Production]


cl1Devel: {
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
        "observability-aio": {
            instanceType: "bundle"
            source: {
                url: "oci://localhost:5000/bundles/observability-aio"
                tag: "0.1.0"
            }
            namespace: "obs"
            values: {...}
        }
    }

    // clusterConfig: timoniextv1.#ClusterConfig & _ClusterConfig
}

cl1Staging: {
    apiVersion: "v1alpha1"
    name: "cl1"
    group: "staging"
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
        "observability-aio": {
            instanceType: "bundle"
            source: {
                url: "oci://localhost:5000/bundles/observability-aio"
                tag: "0.1.0"
            }
            namespace: "obs"
            values: {...}
        }
    }

    // clusterConfig: timoniextv1.#ClusterConfig & _ClusterConfig
}

cl1Production: {
    apiVersion: "v1alpha1"
    name: "cl1"
    group: "production"
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
        "observability-aio": {
            instanceType: "bundle"
            source: {
                url: "oci://localhost:5000/bundles/observability-aio"
                tag: "0.1.0"
            }
            namespace: "obs"
            values: {...}
        }
    }

    // clusterConfig: timoniextv1.#ClusterConfig & _ClusterConfig
}
