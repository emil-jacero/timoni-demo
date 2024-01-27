package clusters

import (
	// "encoding/yaml"
	"path"
	"tool/cli"
	"tool/exec"
	// "tool/file"
	"text/tabwriter"

	// kubernetes "k8s.io/apimachinery/pkg/runtime"

	// timoniv1 "timoni.sh/core/v1alpha1"
	// derpv1 "github.com/emil-jacero/timoni-ext/v1alpha1"
)

clusters: [...]
instances: {...}
for cl in clusters {
	for k,v in cl.instances {
		instances: {"\(k)": v}
	}
}

command: build: {
	outDir: ".output"
	for k,v in instances {
		instDir: path.Join([outDir, "bundles"])
		"\(k)": {
			print: cli.Print & {
				text: "Building bundle \(k) with version \(v.bundle.tag)"
			}
			getBundle: exec.Run & {
				cmd: [ "timoni", "artifact", "pull", "\(v.bundle.url):\(v.bundle.tag)", "-o", "\(instDir)/"]
			}
			buildBundle: exec.Run & {
				cmd: [ "timoni", "bundle", "build", "-f", "\(instDir)/\(k).bundle.cue", "-f", "cl1.cluster.cue"]
			}
		}
	}
}

// The ls command prints a table with the Kubernetes resources kind, namespace, name and version of all releases.
command: ls: {
	task: print: cli.Print & {
		text: tabwriter.Write([
			"INSTANCE \tVERSION",
			for k,v in instances { // TODO: implement some form of "if isinstance" check
				if v.bundle != _|_ {
					"\(k) \t\(v.bundle.tag)"
				}
			}
		])
	}
}
