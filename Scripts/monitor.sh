#!/bin/bash
# Monitor controller

APPNAME=$( basename "$0" | sed "s/\.sh$//" )

intern="eDP-1"
extern=""

verbose="false"

m_log_debug() {
    if $verbose
    then
        echo "$APPNAME: DEBUG: $1" > /dev/tty
    fi
}

m_log_info() {
    echo "$APPNAME: $1" > /dev/tty
}

m_log_error() {
    echo "$APPNAME: ERROR: $1" > /dev/tty
}

m_get_connected() {
    local out=$(xrandr | grep " connected " | awk '{ print$1 }')
    m_log_debug "Connected: ${out}"
    echo $out
}

m_get_disconnected() {
    local out=$(xrandr | grep " disconnected " | awk '{ print$1 }')
    echo $out
}

m_penmap() {
    m_log_debug "Run m_penmap"
    xinput --map-to-output 'Wacom Pen and multitouch sensor Finger touch' $intern
    xinput --map-to-output 'Wacom Pen and multitouch sensor Pen stylus' $intern
    xinput --map-to-output 'Wacom Pen and multitouch sensor Pen eraser' $intern
}

m_usage() {
    local txt=(
        "Utility $APPNAME for setting monitors."
        "Usage: $APPNAME [options]"
        ""
        "Options:"
        "  --help, -h      Print help."
        "  --internal, -i  Internal Monitor Only."
        "  --external, -E  External Monitor Only."
        "  --extend, -e    Extend Internal Monitor."
        "  --clone, -c     Cline Internal Monitor."
        "  --verbose, -v   Verbose Output."
    )

    printf "%s\\n" "${txt[@]}"
}

m_set() {

    connected=$(m_get_connected)
    extern=${connected/"$intern"/}

    m_log_debug "Called m_set with $1"

    cmd="xrandr"

    # Enable correct monitors
    case "$1" in
        internal)
            m_log_info "Enable internal monitor only"
            #cmd="${cmd} --output ${intern} --primary --auto --pos 0x0 --rotate normal --output ${extern} --off"
            cmd="${cmd} --output ${intern} --primary --auto --pos 0x0 --rotate normal"
            ;;
        external)
            m_log_info "Enalbe external monitor only"
            cmd="${cmd} --output ${intern} --off  --output ${extern} --primary --auto --scale 2.5x2.5 --rotate normal"
            ;;
        extend)
            m_log_info "Extend internal monitor"
            cmd="${cmd} --output ${intern} --primary --auto --pos 432x2700 --rotate normal --output ${extern} --auto --scale 2x2 --pos 0x0 --rotate normal"
            ;;
        clone)
            m_log_info "Clone internal monitor"
            cmd="${cmd} --output ${intern} --primary --auto --pos 432x2700 --rotate normal --output "$extern" --auto --scale 2x2 --pos 0x0 --rotate normal --same-as ${intern}"
            ;;
    esac

    # Disable unused monitors
    for d in $(m_get_disconnected)
    do
        cmd="${cmd} --output ${d} --off"
    done

    m_log_debug "Run ${cmd}"
    eval "$cmd"

    m_penmap
    ~/.fehbg
}

if [[ $# -eq 0 ]]
then
   m_usage
fi

while (( $# ))
do
    m_log_debug "Parse Arg $1"
    case "$1" in
        --internal | -i)
            mode="internal"
            shift
            ;;
        --external | -E)
            mode="external"
            shift
            ;;
        --extend | -e)
            mode="extend"
            shift
            ;;
        --clone | -c)
            mode="clone"
            shift
            ;;
        --verbose | -v)
            verbose="true"
            shift
            ;;
        --help | -h | *)
            m_usage
            exit 0
            ;;
    esac
done

m_set "$mode"
