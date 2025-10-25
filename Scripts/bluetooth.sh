# Bluetooth status for i3blocks
set -e
set -u

# Bluetooth off
if ! systemctl is-active --quiet bluetooth; then
    echo "󰂲"
    return 0
fi

# No device connected
if [ -z "$(bluetoothctl devices Connected)" ]; then
    echo "󰂳"
    returh 0
fi

# Device but wrong sink
if pactl get-default-sink | grep --quiet --ignore-case bluetooth; then
    echo "󰂴 Sink"
    return 0
fi

# Connected and correct sink
echo ""
