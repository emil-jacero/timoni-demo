package clusters

import (
	// "encoding/yaml"
	"strings"
	"path"
	"tool/cli"
	"tool/exec"
	"tool/file"
	"text/tabwriter"

	// kubernetes "k8s.io/apimachinery/pkg/runtime"

	// timoniv1 "timoni.sh/core/v1alpha1"
	// timoniextv1 "github.com/emil-jacero/timoni-ext/v1alpha1"
)

clusters: [...]
// instances: {...}
// for cl in clusters {
// 	for k,v in cl.instances {
// 		instances: {"\(k)": v}
// 	}
// }

// TODO: Output the bundles into folders with uniqe names
command: build: {
	outDir: ".output"
	for cl in clusters {
		for k,v in cl.instances {
			instDir: path.Join([outDir, "bundles"])
			"\(k)": {
				_splitS: strings.Split(_url, "/")
				_name: _splitS[len(_splitS) - 1]
				_url: "\(v.source.url)"
				_tag: "\(v.source.tag)"
				_yamlFile: path.Join([instDir, "\(_name).resources.yaml"])
				_bundleFile: path.Join([instDir, "\(_name).bundle.cue"])

				print: cli.Print & {
					text: "Building bundle \(_name) with version \(_tag) to path \(_bundleFile)"
				}
				writeBundle: {
					get: exec.Run & {
						cmd: [ "timoni", "artifact", "pull", "\(_url):\(_tag)", "-o", "\(instDir)/"]
					}
					build: exec.Run & {
						$dep: get.$done
						cmd: [ "timoni", "bundle", "build", "-f", _bundleFile, "-f", "config.cue"]
						stdout: string
						Out:    stdout
					}
					write: file.Create & {
						$dep: build
						filename: _yamlFile
						contents: build.Out
					}
					// publishArtifact exec.Run & {
					// 	$dep: build
					// 	cmd: [ "flux", "push", "artifact", "oci://localhost:5000/flux/:", "", "", "", "", "", ""]
					// 	stdout: string
					// 	Out:    stdout
					// }
				}
			}
		}
	}
}

// command: ls: {
// 	task: print: cli.Print & {
// 		text: tabwriter.Write([
// 			"CLUSTER \tINSTANCE \tVERSION \tURL",
// 			for k,v in instances {
// 				_url: "\(v.source.url)"
// 				if v.instanceType == "bundle" {
// 					_url: "\(v.source.url)"
// 					_splitURL: strings.Split(_url, "/")
// 					_name: _splitURL[len(_splitURL) - 1]
// 					_tag: "\(v.source.tag)"

// 					"\t\(_name) \t\(_tag) \t\(_url)"
// 				}
// 			}
// 		])
// 	}
// }

command: ls2: {
	task: print: cli.Print & {
		text: tabwriter.Write([
			"CLUSTER \tINSTANCE \tVERSION \tURL",
			for cl in clusters {
				_clName: cl.name
				_clGroup: cl.group
				_instances: cl.instances
				for k,v in _instances {
					_url: "\(v.source.url)"
					"\(_clName)-\(_clGroup)"
					// if v.instanceType == "bundle" {
					// 	// _url: "\(v.source.url)"
					// 	// _splitURL: strings.Split(_url, "/")
					// 	// _name: _splitURL[len(_splitURL) - 1]
					// 	// _tag: "\(v.source.tag)"

					// 	// "\t\(_name) \t\(_tag) \t\(_url)"
					// 	"\(_clName)-\(_clGroup) "
					// }
				}
			}
		])
	}
}
