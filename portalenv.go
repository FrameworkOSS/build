package main

import (
	"fmt"
	"os"
)

var (
	pe *PortalEnv
)

type PortalEnv struct {
	ROOT,
	BUILD,
	BUILDER,
	PORTAL,
	ENGINE,
	APPS,
	FEAT,
	OUT,
	APPS_OUT,
	FEAT_OUT,
	LOGS,
	APPS_LOG,
	FEAT_LOG string
}

func NewPortalEnv() *PortalEnv {
	pe := new(PortalEnv)
	return pe
}
func (pe *PortalEnv) Load() error {
	return mapEnv(
		[]string{
			"ROOT",
			"BUILD",
			"BUILDER",
			"PORTAL",
			"ENGINE",
			"APPS",
			"FEAT",
			"OUT",
			"APPS_OUT",
			"FEAT_OUT",
			"LOGS",
			"APPS_LOG",
			"FEAT_LOG",
		},
		[]*string{
			&pe.ROOT,
			&pe.BUILD,
			&pe.BUILDER,
			&pe.PORTAL,
			&pe.ENGINE,
			&pe.APPS,
			&pe.FEAT,
			&pe.OUT,
			&pe.APPS_OUT,
			&pe.FEAT_OUT,
			&pe.LOGS,
			&pe.APPS_LOG,
			&pe.FEAT_LOG,
		},
	)
}

func mapEnv(keys []string, dsts []*string) error {
	l1 := len(keys)
	l2 := len(dsts)
	if l1 == 0 || l2 == 0 || l1 != l2 {
		return fmt.Errorf("mapEnv: invalid count; keys: %d, dsts: %d", l1, l2)
	}
	for i := 0; i < l1; i++ {
		v := os.Getenv(keys[i])
		if v == "" {
			return fmt.Errorf("mapEnv: empty string; key %d: %s", i, keys[i])
		}
		*dsts[i] = v
	}
	return nil
}

func init() {
	pe = NewPortalEnv()
	if err := pe.Load(); err != nil {
		panic(err)
	}
}
