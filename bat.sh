MAX="$(cat /sys/class/power_supply/BAT0/charge_full)"
CAP="$(cat /sys/class/power_supply/BAT0/charge_now)"

BAT="$(echo "100*(${CAP})/(${MAX})" | bc)"

echo $BAT%
