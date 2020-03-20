#!/system/bin/sh

# mknod /dev/net/tun c 10 200

sleep 0.7

# /system/bin/unshare -p -m --fork --mount-proc /system/bin/criu restore -D /data/criu/dump -j --ext-unix-sk -o /data/criu/dump/restore.log &
# /system/bin/unshare -p -m --fork --mount-proc --propagation slave /system/bin/criu restore -D /data/criu/dump -j --ext-unix-sk -o /data/criu/dump/restore.log &
/system/bin/unshare -p -m --fork --mount-proc /system/bin/criu restore -D /data/criu/dump -j --ext-unix-sk -o /data/criu/dump/restore.log &

touch /data/criu/flags/restored
