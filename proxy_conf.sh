#!/bin/bash

# Proxy details
proxy_url="http://proxy.server.com:port"  # Replace with your proxy URL
proxy_user="username"                     # Replace with your proxy username, if needed
proxy_password="password"                 # Replace with your proxy password, if needed

# Set up environment variables
export http_proxy="$proxy_url"
export https_proxy="$proxy_url"
export ftp_proxy="$proxy_url"
export no_proxy="localhost,127.0.0.1,::1" # Add other domains that don't need the proxy

# Configure apt to use the proxy
echo "Acquire::http::Proxy \"$http_proxy\";" | sudo tee /etc/apt/apt.conf.d/95proxies
echo "Acquire::https::Proxy \"$https_proxy\";" | sudo tee -a /etc/apt/apt.conf.d/95proxies

# Configure git to use the proxy
git config --global http.proxy $http_proxy
git config --global https.proxy $https_proxy

# Configure wget to use the proxy
echo "use_proxy=on" | sudo tee -a /etc/wgetrc
echo "http_proxy=$http_proxy" | sudo tee -a /etc/wgetrc
echo "https_proxy=$https_proxy" | sudo tee -a /etc/wgetrc

# Configure curl to use the proxy
echo "proxy=\"$proxy_url\"" | sudo tee -a ~/.curlrc

# Configure pip to use the proxy
mkdir -p ~/.pip
echo "[global]" > ~/.pip/pip.conf
echo "proxy = $http_proxy" >> ~/.pip/pip.conf

# Add proxy configuration to bashrc for persistent use
echo "export http_proxy=\"$http_proxy\"" >> ~/.bashrc
echo "export https_proxy=\"$https_proxy\"" >> ~/.bashrc
echo "export ftp_proxy=\"$ftp_proxy\"" >> ~/.bashrc
echo "export no_proxy=\"localhost,127.0.0.1,::1\"" >> ~/.bashrc
