package v1alpha1

import (
    "strings"
)

#GroupOptions: *"devel" | "staging" | "production"

#InstanceOptions: #InstanceBundle | #InstanceFlavor

#Cluster: {
	apiVersion:    string & =~"^v1alpha1$"
	name:          string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)
    group:         string
    group:         #GroupOptions
    instances:     {[string]: #InstanceOptions}
    clusterConfig: #ClusterConfig
}
