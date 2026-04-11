cleanup() {
  unset log logerr initlog LOGFILE
  unset info error fatal
  unset ROOT PORTAL ENGINE APPS FEAT OUT APPS_OUT FEAT_OUT BUILD BUILDER LOGS APPS_LOG FEAT_LOG
  unset hidelog hide cd mkdir rm
  unset init clean
  unset gobuild
  unset mkbuilder
}
cleanup

log() {
  ls="$@"
  if [ "$ls" == "" ]; then return; fi
  if [ -f "$LOGFILE" ]; then echo "$ls" >> "$LOGFILE"; fi
}
logerr() {
  ls="$@"
  if [ "$ls" == "" ]; then return; fi
  if [ -f "$LOGFILE" ]; then echo "$ls" >> "$LOGFILE"; fi
}
initlog() {
  export LOGFILE="$1"; rm $LOGFILE; touch $LOGFILE
}

info() {
  ls=" $@"
  log "$ls"
  echo "$ls"
}
error() {
  ls="!!! $@"
  logerr "$ls"
  echo "$ls" >&2
}
fatal() {
  error "FATAL: $@"
  cleanup
}

if [ ! -d build ] || \
   [ ! -d apps ] || \
   [ ! -d features ] || \
   [ ! -d portal ]; \
then
  fatal "Unable to find the build tree!"
  return 1 || exit 1
fi
export ROOT="$PWD"

export PORTAL="$ROOT/portal"
export ENGINE="$PORTAL/engine"

export APPS="$ROOT/apps"
export FEAT="$ROOT/features"
export OUT="$ROOT/landing"

export APPS_OUT="$OUT/apps"
export FEAT_OUT="$OUT/features"

export BUILD="$ROOT/build"
export BUILDER="$OUT/builder"

export LOGS="$BUILD/logs"
export APPS_LOG="$LOGS/apps"
export FEAT_LOG="$LOGS/features"

portalenv_println() {
  prefix="$1"
  path="$2"
  real="$2"
  if [ "$ROOT" != "$path" ]; then
    real=$(realpath -s --relative-to="$ROOT" "$path")
  fi
  info "$prefix: $real"
}
portalenv() {
  portalenv_println "     Source tree" "$ROOT"
  portalenv_println "         Builder" "$BUILD"
  portalenv_println "     Builder bin" "$BUILDER"
  portalenv_println "          Portal" "$PORTAL"
  portalenv_println "          Engine" "$ENGINE"
  portalenv_println "            Apps" "$APPS"
  portalenv_println "        Features" "$FEAT"
  portalenv_println "         Landing" "$OUT"
  portalenv_println "    Landing apps" "$APPS_OUT"
  portalenv_println "Landing features" "$FEAT_OUT"
  portalenv_println "            Logs" "$LOGS"
  portalenv_println "        App logs" "$APPS_LOG"
  portalenv_println "    Feature logs" "$FEAT_LOG"
}

hidelog() {
  FILE_ERR=$(mktemp)
  FILE_RET=$(mktemp)
  export STDOUT=$(command "$@" 2> "$FILE_ERR"; echo $? > "$FILE_RET")
  export STDERR=$(<"$FILE_ERR")
  RET=$(<"$FILE_RET")
  command rm "$FILE_ERR" "$FILE_RET"

  logstd() {
    log "$STDOUT"
    logerr "$STDERR"
    unset STDOUT STDERR
  }

  if [ $RET -gt 0 ]; then
    error "> $*"
    logstd
    return $CODE
  fi

  log "> $*"
  logstd
}
hide() {
  command "$@" >/dev/null 2>&1
}

cd() {
  hide cd "$@"
}
mkdir() {
  hidelog mkdir -p "$@"
}
rm() {
  hidelog rm -rf "$@"
}
pushd() {
  hide pushd "$@"
}
popd() {
  hide popd "$@"
}

gobuild() {
  if [ -f "$2" ]; then
    rm "$2" || return 1
  fi
  pushd "$1" || return 2
  if ! go build -ldflags="-s -w" -o "$2"; then popd; return 3; fi
  popd || return 4
}

mkbuilder() {
  if ! gobuild "$BUILD" "$BUILDER"; then
    fatal "Got $? when building the builder"
    return 1 || exit 1
  fi
}

init() {
  rm "$LOGS" && \
  mkdir "$OUT" && \
  mkdir "$APPS_OUT" && \
  mkdir "$FEAT_OUT" && \
  mkdir "$LOGS" && \
  mkdir "$APPS_LOG" && \
  mkdir "$FEAT_LOG" && \
  initlog "$LOGS/envsetup.log" || return 1
  portalenv
  mkbuilder || return 2
}
clean() {
  rm "$OUT" && \
  init || return 1
}

init || return 1 || exit 1

BUILDERPATH=$(dirname "$BUILDER")
if [[ "$PATH" != *"$BUILDERPATH"* ]]; then
  PATH="$BUILDERPATH:$PATH"
fi
