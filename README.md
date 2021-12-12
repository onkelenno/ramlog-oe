# memory supported logging

This is a fork of Armbian's ramlog (https://github.com/armbian/build/blob/master/packages/bsp/common/usr/lib/armbian/armbian-ramlog).

The ramlog should decrease the write load to emmc/sd storages in moving the /var/log to a tmpfs.
Therefore the log folder is loaded on boot into memory and saved on shutdown to disk.

In Armbian's version, the logrotate process is also affected:
logrotate only rotates logs on the emmc/sd and not in memory. Therefore ramlog copies the logs from tmpfs to emmc/sd before logrotate starts, mostly every night. The logrotate service is expanded with a ExecStartPre and ExecStartPost entry and every logrotate config-file (/etc/logrotate.conf, /etc/logrotate.d/\*) is manipulated.

From my point of view this does not decrease the write load to the emmc/sd in any way so I decided to break down the mechanism of Armbian's ramlog to the really necessary.

What is done now:
- create the tmpfs
- copy the logs to tmpfs
- on shutdown or request copy the logs back to emmc/sd

Not more, not less.

It has the disadvantage that if the system hangs, no logs where ever written to disk and you only have the versions of the last boot.
The advantage is that no other processes are affected and no logrotate config files are manipulated without knowing. It now also can easily be used in other distros.

If Armbian's ramlog is installed, disabled it in /etc/default/armbian-ramlog
