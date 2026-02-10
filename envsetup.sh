cleanup() {
  unset log logerr initlog LOGFILE
  unset info error fatal
  unset ROOT PORTAL ENGINE APPS FEAT OUT APPS_OUT FEAT_OUT BUILD BUILDER LOGS APPS_LOG FEAT_LOG
  unset hidelog hide cd mkdir rm
  unset gobuild
}
cleanup

log() {
  ls="$@"
  if [ -f "$LOGFILE" ]; then echo "$ls" >> "$LOGFILE"; fi
}
logerr() {
  ls="$@"
  if [ -f "$LOGFILE" ]; then echo "$ls" >> "$LOGFILE"; fi
}
initlog() {
  export LOGFILE="$1"; rm $LOGFILE; touch $LOGFILE
}

info() {
  ls="[*] $@"
  log "$ls"
  echo "$ls"
}
error() {
  ls="[!] $@"
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

portalenv() {
  info "       Source tree:  $ROOT"
  info "           Builder:  $BUILD"
  info "       Builder bin:  $BUILDER"
  info "            Portal:  $PORTAL"
  info "            Engine:  $ENGINE"
  info "              Apps:  $APPS"
  info "          Features:  $FEAT"
  info "           Landing:  $OUT"
  info "      Landing apps:  $APPS_OUT"
  info "  Landing features:  $FEAT_OUT"
  info "              Logs:  $LOGS"
  info "          App logs:  $APPS_LOG"
  info "      Feature logs:  $FEAT_LOG"
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
  hidelog rm "$@"
}

gobuild() {
  if [ -f "$2" ]; then
    rm "$2" || return 1
  fi
  cd "$1" || return 2
  go build -ldflags="-s -w" -o "$2" || return 3
  cd - || return 4
}

mkdir "$LOGS"
initlog "$LOGS/envsetup.log"

portalenv

if ! gobuild "$BUILD" "$BUILDER"; then
  fatal "Got $? when building the builder"
  return 1 || exit 1
fi
"$BUILDER"
