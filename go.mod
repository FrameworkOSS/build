module github.com/FrameworkOSS/build

go 1.25.4

replace github.com/FrameworkOSS/portal => ../portal/engine

replace github.com/FrameworkOSS/event => ../portal/event

replace github.com/FrameworkOSS/feature => ../portal/feature

replace github.com/FrameworkOSS/wire => ../portal/wire

replace github.com/FrameworkOSS/feature_commands => ../features/commands

replace github.com/FrameworkOSS/feature_files => ../features/files

require github.com/FrameworkOSS/feature_files v0.0.0-00010101000000-000000000000

require (
	github.com/FrameworkOSS/event v0.0.0-20260130041338-d5173e641b01 // indirect
	github.com/FrameworkOSS/feature v0.0.0-20260130034214-92ef30b17585 // indirect
	github.com/FrameworkOSS/feature_commands v0.0.0-20260130030137-d746cde1f5c5 // indirect
	github.com/FrameworkOSS/portal v0.0.0-20260130032744-63bf40947be4 // indirect
	github.com/FrameworkOSS/wire v0.0.0-20260130033327-5e2cbf86a333 // indirect
	github.com/JoshuaDoes/crunchio v0.0.4 // indirect
	github.com/fatih/color v1.18.0 // indirect
	github.com/mattn/go-colorable v0.1.14 // indirect
	github.com/mattn/go-isatty v0.0.20 // indirect
	github.com/superwhiskers/crunch/v3 v3.5.7 // indirect
	golang.org/x/sys v0.40.0 // indirect
)
