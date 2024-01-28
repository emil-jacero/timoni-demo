package v1alpha1

import "strings"

#InstanceBundle: {
	instanceType: string & "bundle"
	source: {
		url:     string & =~"^((oci|file)://.*)$"
		tag:     *"latest" | string
		digest?: string
	}
	namespace: string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)
	values: {...}
}

#InstanceFlavor: {
	instanceType: string & "flavor"
	source: {
		url:     string & =~"^((oci|file)://.*)$"
		tag:     *"latest" | string
		digest?: string
	}
}

#Flavor: {
	apiVersion: string & =~"^v1alpha1$"
	name:       string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)
	bundles: [string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)]: close(#InstanceBundle)
	namespace: string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)
}
