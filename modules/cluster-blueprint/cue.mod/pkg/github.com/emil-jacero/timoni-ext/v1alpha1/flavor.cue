package v1alpha1

import "strings"

#InstanceBundle: {
	url:     string & =~"^((oci|file)://.*)$"
	tag:     *"latest" | string
	digest?: string
}

#Flavor: {
	apiVersion: string & =~"^v1alpha1$"
	name:       string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)
	bundles: [string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)]: {
		bundle: close(#InstanceBundle)
		namespace?: string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63) & strings.MinRunes(1)
		values?: {...}
	}
}

#InstanceFlavor: {
	url:     string & =~"^((oci|file)://.*)$"
	tag:     *"latest" | string
	digest?: string
}