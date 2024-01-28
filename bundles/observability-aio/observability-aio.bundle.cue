

#ClusterConfig: {
    clusterDomain: string
}

#namespace: "obs"

bundle: {
    apiVersion: "v1alpha1"
    name:       "observability-aio"
    instances: {
        grafana: {
            module: {
                url:     "oci://localhost:5000/modules/grafana"
                version: "0.1.0"
            }
            namespace: #namespace
            // values: 
        }
        prometheus: {
            module: url:     "oci://localhost:5000/modules/prometheus"
            module: version: "0.1.0"
            namespace: #namespace
            // values: 
        }
        loki: {
            module: {
                url:     "oci://localhost:5000/modules/loki"
                version: "0.1.0"
            }
            namespace: #namespace
            // values: 
        }
    }
}