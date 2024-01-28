package clusters

import (
	// "encoding/yaml"
	// "strings"
	// "path"
	"tool/cli"
	// "tool/exec"
	// "tool/file"
	"text/tabwriter"

	// kubernetes "k8s.io/apimachinery/pkg/runtime"

	// timoniv1 "timoni.sh/core/v1alpha1"
	// timoniextv1 "github.com/emil-jacero/timoni-ext/v1alpha1"
)

command: ls: {
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
