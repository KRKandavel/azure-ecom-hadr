#!/bin/bash

# This script is only tested on CentOS 6.5 and Ubuntu 12.04 LTS with Percona XtraDB Cluster 5.6.
# You can customize variables such as MOUNTPOINT, RAIDCHUNKSIZE and so on to your needs.
# You can also customize it to work with other Linux flavours and versions.
# If you customize it, copy it to either Azure blob storage or Github so that Azure
# custom script Linux VM extension can access it, and specify its location in the 
# parameters of DeployPXC powershell script or runbook or Azure Resource Manager CRP template.   

NODEID="1"
MYSQLDNS="hadr.southeastasia.cloudapp.azure.com"
NEWMASTERIP="10.0.1.5"
OLDMASTERIP="10.0.1.4"
NEWMASTERPORT="3307"
OLDMASTERPORT="3306"
RPLPWD="Pass@word123"
ROOTPWD="Pass@word123"

configure_mysql_failover() {
if [ ${NODEID} -eq 1 ];
then
    mysql -h "${MYSQLDNS}" -P "${OLDMASTERPORT}" -u admin -p"${ROOTPWD}" <<EOF
stop slave;
change master to master_host='${NEWMASTERIP}', master_port=3306, master_user='admin', master_password='${RPLPWD}', master_auto_position=1;
EOF

    mysql -h "${MYSQLDNS}" -P "${NEWMASTERPORT}" -u admin -p"${ROOTPWD}" <<EOF
stop slave;
change master to master_host='${NEWMASTERIP}', master_port=3306, master_user='admin', master_password='${RPLPWD}', master_auto_position=1;
START slave;
EOF

else
    mysql -h "${MYSQLDNS}" -P "${OLDMASTERPORT}" -u admin -p"${ROOTPWD}" <<EOF
stop slave;
change master to master_host='${OLDMASTERIP}', master_port=3306, master_user='admin', master_password='${RPLPWD}', master_auto_position=1;
EOF

    mysql -h "${MYSQLDNS}" -P "${NEWMASTERPORT}" -u admin -p"${ROOTPWD}" <<EOF
stop slave;
change master to master_host='${OLDMASTERIP}', master_port=3306, master_user='admin', master_password='${RPLPWD}', master_auto_position=1;
START slave;
EOF

fi
}

configure_mysql_failover

