#!/usr/bin/env ash

function stop() {
    echo "termination ..."

    echo "done."
}

trap stop SIGTERM SIGINT

touch /etc/exports
if [ ! -s "/etc/exports" ]; then
    echo "$NFS_DEFAULT_DIR $NFS_DEFAULT_DOMAIN($NFS_DEFAULT_OPTIONS)" > /etc/exports
fi

touch /etc/idmapd.conf
if [ ! -s "/etc/idmapd.conf" ]; then
cat <<EOF > /etc/idmapd.conf
[General]

Verbosity = 0
Pipefs-Directory = /run/rpc_pipefs
# set your own domain here, if it differs from FQDN minus hostname
# Domain = localdomain

[Mapping]

Nobody-User = nobody
Nobody-Group = nogroup

#[Static]
#dominik = dominik

EOF
fi

/usr/sbin/exportfs -r
/sbin/rpcbind -s
/usr/sbin/rpc.idmapd -v -S
#/usr/sbin/rpc.nfsd -N 2 -N 3 8 |:
/usr/sbin/rpc.nfsd 8 |:
/usr/sbin/rpc.mountd -F
