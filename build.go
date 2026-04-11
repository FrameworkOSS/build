package main

import (
	"os"
	"strings"
	"time"

	"github.com/FrameworkOSS/feature"
	shell "github.com/FrameworkOSS/feature_shell"
	stdlib "github.com/FrameworkOSS/feature_stdlib"
	"github.com/FrameworkOSS/portal"
)

func main() {
	host, err := os.Hostname()
	if err != nil {
		host = "builder"
	}

	opts := portal.NewPortalOptions().SetLog(true).SetExport(false)
	p := portal.NewPortal(opts)

	initCmds := make([]string, 0)
	if args := os.Args; len(args) > 1 {
		args = args[1:]
		initStr := strings.Join(args, " ")
		initCmds = strings.Split(initStr, ";")
		for i := range initCmds {
			initCmds[i] = strings.TrimSpace(initCmds[i])
		}
		initCmds = append(initCmds, "sleep 100")
		initCmds = append(initCmds, "exit -code 0") //Terminate the shell instead of prompting for input!
	}
	sh := shell.NewShell(p, host, false, true, initCmds...)
	if err := p.BatchFeatureAdd(sh); err != nil {
		panic(err)
	}

	std := stdlib.NewStdlib(p, false, false, false)
	features := []feature.Feature{std}

	if err := p.BatchFeatureAdd(features...); err != nil {
		panic(err)
	}

	if err := p.Open(); err != nil {
		panic(err)
	}

	featureWait := []string{sh.ID()}
	for i := 0; i < len(features); i++ {
		featureWait = append(featureWait, features[i].ID())
	}

	//Wait for the shell and all of our installed features to open.
	for {
		time.Sleep(p.OptionsGet().GetPollTimeOut())
		if p.FeatureIsReady(featureWait...) {
			break
		}
	}

	//Wait for the shell or one of our installed features to close.
	for {
		time.Sleep(p.OptionsGet().GetPollTimeOut())
		if !p.FeatureIsReady(featureWait...) {
			break
		}
	}

	//Wait for the portal to attempt an exit.
	for {
		time.Sleep(p.OptionsGet().GetPollTimeOut())
	}
}
