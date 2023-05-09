FROM alpine:latest

RUN apk --update --no-cache add nfs-utils && \
    rm -v /etc/idmapd.conf && \
    rm -v /etc/exports

# http://wiki.linux-nfs.org/wiki/index.php/Nfsv4_configuration

ENV NFS_DEFAULT_DIR /data
ENV NFS_DEFAULT_DOMAIN *
ENV NFS_DEFAULT_OPTIONS rw,fsid=0,sync,no_subtree_check,no_auth_nlm,insecure,no_root_squash,crossmnt,no_acl

RUN \ 
    echo "rpc_pipefs /var/lib/nfs/rpc_pipefs rpc_pipefs defaults 0 0" >> /etc/fstab && \
    echo "nfsd       /proc/fs/nfsd           nfsd       defaults 0 0" >> /etc/fstab && \
    mkdir -p /var/lib/nfs/rpc_pipefs && \
    mkdir -p /var/lib/nfs/v4recovery

EXPOSE 111/tcp 111/udp 2049/tcp 2049/tcp

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
