from debian:stretch

ARG SERVER_NAME=urbackup-server
ARG CLIENT_NAME=urbackup-client
ARG CLIENT_KEY=secret_key

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y mktemp wget

RUN TF=`mktemp` &&\
	wget "https://hndl.urbackup.org/Client/latest/update/UrBackupUpdateLinux.sh" -O $TF &&\ 
	sh $TF &&\ 
	rm $TF &&\ 
	urbackupclientctl wait-for-backend &&\
	urbackupclientctl set-settings -k internet_mode_enabled -v true -k internet_server -v ${SERVER_NAME} -k internet_server_port -v 55415 -k computername -v "${CLIENT_NAME}" -k internet_authkey -v ${CLIENT_KEY} &&\
	urbackupclientctl add-backupdir --path /backup

RUN ( [ ! -e /etc/default/urbackupclient ] || sed -i 's/INTERNET_ONLY=false/INTERNET_ONLY=true/' /etc/default/urbackupclient ) &&\
	( [ ! -e /etc/default/urbackupclient ] || sed -i 's/LOGLEVEL=warn/LOGLEVEL=info/' /etc/default/urbackupclient ) &&\
	( [ ! -e /etc/default/urbackupclient ] || sed -i 's/RESTORE=disabled/RESTORE=server-confirms/' /etc/default/urbackupclient )

EXPOSE 35621/TCP 35622/UDP 35623/TCP

CMD ["urbackupclientbackend", "--config", "/etc/default/urbackupclient"]
