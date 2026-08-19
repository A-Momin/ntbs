install_neovim_ubuntu(){
    ## Source: https://www.youtube.com/watch?v=ZjMzBd1Dqz8&t=1649s
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage --appimage-extract
    ./squashfs-root/AppRun --version

    # Optional: exposing nvim globally.
    sudo mv squashfs-root /
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

    sudo apt update
    sudo apt install make gcc g++ alacritty nodejs npm
    sudo apt install alacritty nodejs npm

    ### FAILD TO ACCIVE THE GOAL !!
}


lnx_load_dotfiles(){
    : ' Install short version 'notes_hub' into home directory
        NOTE:
    '
    mkdir -p $HOME/.my_dotfiles
    
    endpoint="https://raw.githubusercontent.com/Aminul-Momin/notes_hub/master/dotfiles/lnx"
    
    files=(bash_profile aliases git-completion.bash git-prompt.sh git-aliases.bash)
    for file in "${files[@]}"; do
        if [! -f $HOME/.my_dotfiles/$file ]; then
            touch $HOME/.my_dotfiles/$file
        fi
        curl $endpoint/.$file > $HOME/.my_dotfiles/$file
        ln -sf $HOME/.my_dotfiles/$file $HOME/.$file
    done
}


install_nginx_ubuntu(){
    sudo apt install python3-pip    # Install pip
    sudo apt-get install nginx      # Install Nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
}


install_java_ubuntu(){
    sudo apt-get update -y
    sudo apt install openjdk-17-jre -y  # Install Open JDK
    sudo apt-get update -y              # Update the System
    echo "Your java package is installed in '/usr/lib/jvm'"
    # export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/
}


install_jenkins_ubuntu(){
    sudo apt-get update -y

    ## Source: https://www.jenkins.io/doc/book/installing/linux/#long-term-support-release
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

    sudo apt-get update
    sudo apt-get install jenkins -y

    sudo systemctl daemon-reload
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
    sudo systemctl status jenkins
}


uninstall_jenkins_ubuntu(){
    : ' Uninstall Jenkins from Ubuntu '

    ## Stops the Jenkins service
    sudo systemctl stop jenkins
    ## Uninstalls the Jenkins package
    sudo apt-get purge jenkins
    ## Removes the Jenkins repository
    sudo rm /etc/apt/sources.list.d/jenkins.list
    ## Deletes Jenkins configuration and job directories
    sudo rm -rf /var/lib/jenkins/
    ## Deletes the Jenkins cache directory
    sudo rm -rf /var/cache/jenkins
    ## Updates the package database
    sudo apt-get update
}


uninstall_docker_ubuntu(){
    ## Uninstall From: https://docs.docker.com/engine/install/ubuntu/#uninstall-old-versions
    
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do 
        sudo apt-get remove $pkg; 
    done
    
    # Stops all running Docker containers.
    # sudo docker stop $(sudo docker ps -aq)
    # Removes Docker packages.
    sudo apt-get purge docker-ce docker-ce-cli containerd.io
    # Deletes Docker configurations, images, and volumes.
    sudo rm -rf /var/lib/docker
    # Removes unused dependencies.
    sudo apt-get autoremove
    # Removes Docker’s GPG key.
    sudo apt-key del $(sudo apt-key list | grep Docker | awk '{print $2}')

}


install_docker_ubuntu_main(){
    # Install From: https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
    : '
        Installation procedures provided by the link avobe FAILD miserably !!
    '
    # Add Docker's official GPG key:
    sudo apt-get update -y
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    # Install the latest verion of the Docker packages
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y


    ## After installing Docker, you will need to start the Docker service
    sudo systemctl start docker

    sleep 20

    ## To start the Docker service automatically when the instance starts, you can use the following command
    sudo systemctl enable docker
    
    
    ## Add your user to the Docker group  to be able to run Docker commands without 'sudo'.
    sudo usermod -aG docker $(whoami)
    
    ## Add user 'Jenkins' to the Docker group to be able to run Docker commands without 'sudo'.
    # sudo usermod -aG docker jenkins

    sudo systemctl restart docker


    # ## Add jenkins user to the Docker group to run Docker commands without 'sudo'.
    # ## Only if Jenkins is also installed in this machine
    # sudo usermod -aG docker jenkins
    
    # You can log out and log back in to apply the changes or use the following command to activate the changes without logging out:
    newgrp docker

    # Verify that the Docker Engine installation is successful by running the hello-world image.
    sudo docker run hello-world

    echo "Docker Verion: $(docker --version)"

    sudo apt  install docker-compose -y
}

## ChatGPT: how to install and configure Jupyter Notebook in a remote AWS EC2 of Ubuntu Machine?
install_jupyter_notebook(){
    sudo apt upgrade -y
    # sudo apt install python3 python3-pip python3-venv -y
    cd $HOME
    python3 -m venv .venv
    source .venv/bin/activate
    pip3 install jupyterlab notebook

    jupyter notebook --generate-config # Generate a Jupyter configuration file
    # jupyter notebook password # Set a password for Jupyter Notebook
    # jupyter-lab --ip 0.0.0.0 --no-browser --allow-root
    # vim ~/.jupyter/jupyter_notebook_config.py 
    echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py # Allow access from any IP address
    echo "c.NotebookApp.port = 8888" >> ~/.jupyter/jupyter_notebook_config.py # Specify the port (default is 8888)
    echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py # Prevent Jupyter from opening a browser window by default
    # echo "c.NotebookApp.password = 'admin'" >> ~/.jupyter/jupyter_notebook_config.py # Prevent Jupyter from opening a browser window by default

    jupyter notebook # Start Jupyter Notebook

    ## http://your-ec2-public-dns:8888 --> Access Jupyter Notebook
}


install_spark(){
    : ' 
    -   [Youtube](https://www.youtube.com/watch?v=ei_d4v9c2iA)
    STATUS: Developing ....

    1. Install Java.
    2. Download Spark
    3. Setting up environment variable
    4. Veryfy Spark Installation
    '
    sudo apt-get update -y
    sudo apt install python3 python3-pip python3-venv -y
    sudo apt-get update -y
    sudo mkdir -p /opt/spark
    sudo wget -P /opt/spark/ https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz
    sudo tar xvf /opt/spark/spark-3.5.1-bin-hadoop3.tgz -C /opt/spark ## → Untar `spark-3.5.1-bin-hadoop3.tgz` and save it into `~/Download` directory.
    sudo rm -fr /opt/spark/spark-3.5.1-bin-hadoop3.tgz

    # Add required environment variable
    echo "export SPARK_HOME=/opt/spark" >> ~/.bash_profile
    # Add Spark into your `PATH` variable
    echo "export PATH=\$SPARK_HOME/bin:\$PATH" >> ~/.bash_profile

    ## Open Interactive Spark Shell
    ## `$ spark-shell`

    install_jupyter_notebook

    source $HOME/.venv/bin/activate
    pip install numpy pandas pyspark
}


uninstall_spark(){
    sudo rm -fr /opt/spark
}



# install_java_ubuntu
# install_jenkins_ubuntu
# install_docker_ubuntu_main