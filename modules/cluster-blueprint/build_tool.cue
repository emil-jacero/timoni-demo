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
	// timoniextv1 "github.com/emil-jacero/timoni-ext/v1alpha1"
)

clusters: [...]
instances: {...}
for cl in clusters {
	for k,v in cl.instances {
		instances: {"\(k)": v}
	}
}

// TODO: Output the bundles into folders with uniqe names
command: build: {
	outDir: ".output"
	for k,v in instances {
		instDir: path.Join([outDir, "bundles"])
		"\(k)": {
			print: cli.Print & {
				text: "Building bundle \(k) with version \(v.source.tag)"
			}
			getBundle: exec.Run & {
				cmd: [ "timoni", "artifact", "pull", "\(v.source.url):\(v.source.tag)", "-o", "\(instDir)/"]
			}
			buildBundle: exec.Run & {
				cmd: [ "timoni", "bundle", "build", "-f", "\(instDir)/bundle.cue", "-f", "config.cue"]
			}
		}
	}
}

command: ls: {
	task: print: cli.Print & {
		text: tabwriter.Write([
			"INSTANCE \tVERSION",
			for k,v in instances {
				if v.instanceType == "bundle" {
					"\(k) \t\(v.source.tag)"
				}
			}
		])
	}
}
