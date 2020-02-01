from debian

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y wget

RUN TF=`mktemp` &&\
	wget "https://hndl.urbackup.org/Client/latest/update/UrBackupUpdateLinux.sh" -O $TF &&\ 
	sh $TF silent &&\ 
	rm $TF

EXPOSE 35621/TCP 35622/UDP 35623/TCP

HEALTHCHECK CMD urbackupclientbackend status

WORKDIR /app
COPY run.sh /app

CMD ["sh", "run.sh"]
