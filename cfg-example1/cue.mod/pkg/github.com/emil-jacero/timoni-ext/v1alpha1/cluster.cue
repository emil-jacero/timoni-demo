package v1alpha1

import (
    "strings"
    // timoniv1 "timoni.sh/core/v1alpha1"
)

#GroupOptions: *"devel" | "staging" | "production"

#InstanceOptions: #InstanceBundle | #InstanceFlavor

// #Instances: {...}
#Instances: [string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)]: #InstanceOptions

#Cluster: {
	apiVersion:    string & =~"^v1alpha1$"
	name:          string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)
    group:         string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)
    group:         #GroupOptions
    instances:     #Instances
    clusterConfig: #ClusterConfig
}
