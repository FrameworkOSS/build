module github.com/FrameworkOSS/build

go 1.25.4

replace github.com/FrameworkOSS/portal => ../portal/engine

replace github.com/FrameworkOSS/event => ../portal/event

replace github.com/FrameworkOSS/feature => ../portal/feature

replace github.com/FrameworkOSS/feature_commands => ../features/commands

replace github.com/FrameworkOSS/feature_debugger => ../features/debugger

replace github.com/FrameworkOSS/feature_files => ../features/files

replace github.com/FrameworkOSS/feature_hellodolly => ../features/hellodolly

replace github.com/FrameworkOSS/feature_shell => ../features/shell

replace github.com/FrameworkOSS/feature_stdlib => ../features/stdlib

replace github.com/FrameworkOSS/feature_telegram => ../features/telegram

replace github.com/FrameworkOSS/feature_wires => ../features/wires

require (
	github.com/FrameworkOSS/feature v0.0.0-20260130034214-92ef30b17585
	github.com/FrameworkOSS/feature_shell v0.0.0-20260130063015-df9323e9b4c9
	github.com/FrameworkOSS/feature_stdlib v0.0.0-20260130063250-e5288c598a69
	github.com/FrameworkOSS/portal v0.0.0-20260212050449-3ae3f180c6ae
)

require (
	github.com/FrameworkOSS/event v0.0.0-20260130041338-d5173e641b01 // indirect
	github.com/FrameworkOSS/feature_commands v0.0.0-20260130034245-8edb1c0a4cbb // indirect
	github.com/FrameworkOSS/feature_debugger v0.0.0-20260130030221-e6cd2a71f036 // indirect
	github.com/FrameworkOSS/feature_files v0.0.0-20260130030300-ab21aab45c5c // indirect
	github.com/FrameworkOSS/feature_hellodolly v0.0.0-20260130030326-2110e71a6e24 // indirect
	github.com/FrameworkOSS/feature_wires v0.0.0-20260130030430-bb17c84ca0c6 // indirect
	github.com/FrameworkOSS/wire v0.0.0-20260130033327-5e2cbf86a333 // indirect
	github.com/JoshuaDoes/crunchio v0.0.4 // indirect
	github.com/fatih/color v1.18.0 // indirect
	github.com/mattn/go-colorable v0.1.14 // indirect
	github.com/mattn/go-isatty v0.0.20 // indirect
	github.com/superwhiskers/crunch/v3 v3.5.7 // indirect
	golang.org/x/sys v0.40.0 // indirect
)
