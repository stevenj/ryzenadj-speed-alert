# ryzenadj-speed-alert

A hacky set of scripts to tell me when ryzenadj detects a power setting change.

Expects you already have ryzenadj installed.

This DOES NOT change the power of the SOC, only monitors it for changes.

## Install

Log in as root.

```sh
git clone https://github.com/stevenj/ryzenadj-speed-alert.git
ln -s /root/ryzenadj-speed-alert/speed-change-alert.timer /etc/systemd/system/speed-change-alert.timer
ln -s /root/ryzenadj-speed-alert/speed-change-alert.service /etc/systemd/system/speed-change-alert.service
systemctl daemon-reload
systemctl enable --now speed-change-alert.timer
systemctl start speed-change-alert.timer
```

## Changing the sounds

You can change the sounds in the `check-power.sh` script.

## Changing the interval it checks

Change the interval the speed change is checked in `speed-change-alert.timer`

*NOTE:* For some reason, I experience very unreliable and erratic behavior from systemd timers.
So while the script says 10 seconds,  it seems to be any random number between 10 seconds and 10 minutes.
If anyone has an explanation for this I would love to hear it.
