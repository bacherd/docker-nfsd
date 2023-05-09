# docker-nfsd

A simple nfs deamon based on alpine.

## how to use

#### docker run
```
docker run --name websvn -d \
    -v ./data:/data \
    -v ./nfsd/exports:/etc/exports \
    -p 111:111/tcp \
    -p 111:111/udp \
    -p 2049:2049/tcp \
    -p 2049:2049/udp \
    bacherd/nfsd
```    

### docker-compose
```
websvn:
   image: bacherd/nfsd
   ports:
     - 111:111/tcp                                                                                                                                                          
     - 111:111/udp                                                                                                                                                          
     - 2049:2049/tcp                                                                                                                                                        
     - 2049:2049/udp                                                                                                                                                        
   cap_add:                                                                                                                                                                              
     - SYS_ADMIN                                                                                                                                                                         
     - SETPCAP        
   environment:
     - NFS_DEFAULT_DIR=/data/
     - NFS_DEFAULT_DOMAIN=*
     - NFS_DEFAULT_OPTIONS=rw,fsid=0,sync,no_subtree_check,no_auth_nlm,insecure,no_root_squash,crossmnt,no_acl
   volumes:
     - ./nfsd/exports:/etc/exports
     - /data:/data
   restart: always
```   

## configure

| Environment         | Default                                              |
|---------------------|------------------------------------------------------|
| NFS_DEFAULT_DIR     | /data/                                               |
| NFS_DEFAULT_DOMAIN  | *                                                    |
| NFS_DEFAULT_OPTIONS | rw,fsid=0,sync,no_subtree_check,no_auth_nlm, insecure,no_root_squash,crossmnt,no_acl |
