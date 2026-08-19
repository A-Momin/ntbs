#!bin/bash


install_data(){
    : 'Install data into a Notebook instance of GCP Virtual Machine
    '

    echo "MAKE SURE KAGGLE API IS INSTALLED AND WEB TOKEN IS IN YOUR HOME DIRECTORY!"
    kaggle datasets download gpiosenka/100-bird-species -p /home/jupyter/
    mkdir /home/jupyter/Data/birds
    unzip /home/jupyter/100-bird-species -d /home/jupyter/Data/birds/
    rm -fr 100-bird-species.zip

    wget https://s3.amazonaws.com/content.udacity-data.com/nd089/flower_data.tar.gz -P /home/jupyter/
    mkdir /home/jupyter/Data/flower_data/
    tar xvf /home/jupyter/flower_data.tar.gz -C /home/jupyter/Data/flower_data/
    rm -fr /home/jupyter/flower_data.tar.gz

    wget https://download.pytorch.org/tutorial/hymenoptera_data.zip -P /home/jupyter/
    unzip /home/jupyter/hymenoptera_data.zip -d /home/jupyter/Data/
    rm -fr /home/jupyter/hymenoptera_data.zip
}

get_gcp_external_ip(){
    : ' NOT COMPLETE !!
    It is intended to be run on Google Cloud Platform Only

    Reference: https://cloud.google.com/compute/docs/instances/view-ip-address#gcloud
    '

    gcloud compute instances describe instance-name --format='get(networkInterfaces[0].accessConfigs[0].natIP)' 

}

create_ds_env(){
    : 'process to create Data Science Environment: 
    https://jupyter.readthedocs.io/en/latest/install/notebook-classic.html' 

    # 1. install Anaconda
    wget https://repo.continuum.io/archive/Anaconda3-2018.12-Linux-x86_64.sh -P ~/
    bash Anaconda3-2018.12-Linux-x86_64.sh
    rm -fr ~/Anaconda3-2018.12-Linux-x86_64.sh

    # 2. install jupyter lab
    conda install -c conda-forge jupyterlab

    # 3. install kaggle API; DON'T FORGET TO 'SCP' YOUR 'JSON WEB TOKEN' FOR KAGGLE INTO HOME DIRACTORY OF THIS MACHINE.
    pip install kaggle
    
    # Assuming '~/kaggle.json' has been 'scp'ed from local machine into home directory of this VM.
    mv ~/kaggle.json ~/.kaggle/ 

}

update_sm_ip(){
    # Update ip addres of simple virtual machine in ~/.ssh/config
    folder=~/.ssh/
    sed -i .bak "2s/.*/HostName $1/" $folder/config
    rm $folder/*.bak
}

scp_to_vm(){
    # Copy files from local machine to virtual machine using secure-copy (scp).
    # It assumes that '~/.ssh/config' file is properly configured for VM named 'sm'

    paths="$SD/WORKSPACE_SETUP/workspace_funcs.sh
    ~/.kaggle/kaggle.json
    $SD/WORKSPACE_SETUP/hadoop-cluster/*"

    
    for file in $paths; do
        if [[ -r "$file" && -f "$file" ]]; then
            scp "$file" sm:~/
        fi
        
        echo "$file"
        # [ -r "$file" ] && [ -f "$file" ] && scp "$file" ds:~/;
    done;
    
    # unset file; unset PATHS
    unset paths;
}

create_sql_kernel(){
    # It install a mysql kernel for jupyter notebook. 
    # NOTE: It's recommanded to install it in a perticular conda environment.

    pip install mysql-kernel #
    python -m mysql_kernel.install
    pip install --user --upgrade "sqlalchemy<2.0"
}

create_bash_kernel(){
    # It install a bash kernel for jupyter notebook. 
    # NOTE: It's recommanded to install it in a perticular conda environment.

    pip install bash_kernel
    python -m bash_kernel.install
    rm -fr bash_kernel
}

create_conda_env(){
    conda create -n $1 python=3.8.2 -y
    conda activate $1
    # conda install matplotlib==3.1.1
    # pip install PDPbox==0.2.1 plotnine==0.8.0
    # pip install graphviz waterfallcharts treeinterpreter
    pip install matplotlib numpy pandas pandas-summary==0.0.7 scikit-learn 
}

create_pip_env(){
    python -m venv .venv
    source .venv/bin/activate
    ipython kernel install --user --name=.venv
    pip install numpy PDPbox plotnine pandas pandas-summary scikit-learn sklearn_pandas graphviz waterfallcharts treeinterpreter
}
