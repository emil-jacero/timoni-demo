package v1alpha1

import (
    "strings"
    // timoniv1 "timoni.sh/core/v1alpha1"
)

#GroupOptions: *"devel" | "staging" | "production"

#Instances: {...}
// Removed Module as i don't know of a way to handle module.version and bundle.tag
// #Instances: [string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)]: {
// 		module: timoniv1.#InstanceModule
// 		namespace: string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)
// 		values: {...}
// 	} 
#Instances: [string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)]: {
		bundle: #InstanceBundle
		namespace: string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)
		values: {...}
	}
// #Instances: [string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)]: {
// 		flavor: #InstanceFlavor
// 		namespace?: string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)
// 		values?: {...}
// 	}

#Cluster: {
	apiVersion:    string & =~"^v1alpha1$"
	name:          string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)
    group:         string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)
    group:         #GroupOptions
    instances:     #Instances
    clusterConfig: #ClusterConfig
}