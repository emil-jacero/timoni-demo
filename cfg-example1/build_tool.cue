package clusters

import (
	"strings"
	"text/tabwriter"
	"tool/cli"
	"tool/exec"
	"tool/file"
	"path"
	// "encoding/yaml"

	// kubernetes "k8s.io/apimachinery/pkg/runtime"

	// timoniv1 "timoni.sh/core/v1alpha1"
	timoniextv1 "github.com/emil-jacero/timoni-ext/v1alpha1"
)

#Clusters: [timoniextv1.#Cluster, ...]

command: build: {
	outDir: ".output"
	for cl in #Clusters {
		for k,v in cl.instances {
			"\(cl.name)-\(cl.group)-\(k)": { // This is done to make it unique :)
				clInstDir: path.Join([outDir, "\(cl.name)-\(cl.group)", "bundles"])
				#splitS: strings.Split(url, "/")
				name: #splitS[len(#splitS) - 1]
				url: "\(v.source.url)"
				tag: "\(v.source.tag)"
				yamlFile: path.Join([clInstDir, "\(name).resources.yaml"])
				bundleFile: path.Join([clInstDir, "\(name).bundle.cue"])

				print: cli.Print & {
					text: "Building bundle \(name) with version \(tag) to path (\(bundleFile))"
				}
				publishBundle: {
					get: exec.Run & {
						cmd: [ "timoni", "artifact", "pull", "\(url):\(tag)", "-o", "\(clInstDir)/"]
					}
					build: exec.Run & {
						$dep: get.$done
						cmd: [ "timoni", "bundle", "build", "-f", bundleFile, "-f", "config.cue"]
						stdout: string
						Out:    stdout
					}
					write: file.Create & {
						$dep: build
						filename: yamlFile
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

command: ls: {
    task: {
        gather: {
            items: [for cl in #Clusters for k, v in cl.instances {
				_url: "\(v.source.url)"
				_tag: "\(v.source.tag)"
				_splitURL: strings.Split(_url, "/")
				_name: _splitURL[len(_splitURL) - 1]
				"\(cl.name)-\(cl.group) \t\(_name) \t\(_tag) \t\(_url)"
            }]
        }
        print: cli.Print & {
            $dep: gather
            text: tabwriter.Write([
                "CLUSTER \tINSTANCE \tVERSION \tURL",
                for a in gather.items {
                    "\(a)"
                }
            ])
        }
    }
}


cl1Devel: timoniextv1.#Cluster & {
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
}

cl1Staging: timoniextv1.#Cluster & {
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
}

clustersTest: [cl1Devel,cl1Staging]


command: lstest: {
    task: {
        gather: {
            items: [for cl in clustersTest for k, v in cl.instances {
				_url: v.source.url
				_tag: v.source.tag
				_splitURL: strings.Split(_url, "/")
				_name: _splitURL[len(_splitURL) - 1]
				"\(cl.name)-\(cl.group) \t\(_name) \t\(_tag) \t\(_url)"
            }]
        }
        print: cli.Print & {
            $dep: gather
            text: tabwriter.Write([
                "CLUSTER \tINSTANCE \tVERSION \tURL",
                for a in gather.items {
                    "\(a)"
                }
            ])
        }
    }
}
