#!/system/bin/sh

rm /data/criu/dump/*

process_id=`pidof zygote`

/system/bin/criu dump -t ${process_id} -D /data/criu/dump -j --ext-unix-sk -o /data/criu/dump/dump.log --external 'mnt[]:m' --root /

touch /data/criu/flags/dumped