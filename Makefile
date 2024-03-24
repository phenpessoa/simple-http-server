build:
	GOOS=linux GOARCH=amd64 go build -o dist/simple-http-server

send-exe-to-remote-server:
	rsync dist/simple-http-server root@$(HOSTINGER_REMOTE_SERVER_IP):~

send-service-file-to-remote-server:
	rsync http-server.service root@$(HOSTINGER_REMOTE_SERVER_IP):~

deploy: build send-exe-to-remote-server send-service-file-to-remote-server
	ssh -t root@$(HOSTINGER_REMOTE_SERVER_IP) '\
		sudo mv ~/http-server.service /etc/systemd/system/ \
		&& sudo systemctl enable http-server \
		&& sudo systemctl restart http-server \
	'
