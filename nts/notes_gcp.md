- [Compute Engine](#compute-engine)
  - [Create Basic Virtual Machine Instance](#create-basic-virtual-machine-instance)
- [Notebook](#notebook)
- [Google Cloud Platform (GCP) - Firewall Rules](#google-cloud-platform-gcp---firewall-rules)
  - [Remarks](#remarks)
- [GPU](#gpu)

-------------------------------------------------------------------------------

### Compute Engine

- [Connecting using third-party tools](https://cloud.google.com/compute/docs/instances/connecting-advanced#thirdpartytools)
- [Managing SSH keys in metadata](https://cloud.google.com/compute/docs/instances/adding-removing-ssh-keys#locatesshkeys)
- [Troubleshooting SSH](https://cloud.google.com/compute/docs/troubleshooting/troubleshooting-ssh)
- [Assign a static external IP address to a new VM instance](https://cloud.google.com/compute/docs/ip-addresses/reserve-static-external-ip-address#assign_new_instance)
- [Progrmatically Locating IP addresses for an instance](https://cloud.google.com/compute/docs/instances/view-ip-address#gcloud)
  - > gcloud compute instances describe vm-testing \
      --zone=us-central1-a \
      --format='get(networkInterfaces[0].accessConfigs[0].natIP)'
- [gcloud](https://cloud.google.com/sdk/gcloud/reference/compute?hl=en_US)

#### Create Basic Virtual Machine Instance

```bash
gcloud compute instances create ds \
  --project=data-science-330201 \
  --zone=us-east1-b \
  --machine-type=e2-medium \
  --network-interface=address=34.139.107.187,network-tier=PREMIUM,subnet=default \
  --no-restart-on-failure \
  --maintenance-policy=TERMINATE \
  --preemptible \
  --service-account=498106001917-compute@developer.gserviceaccount.com \
  --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
  --tags=http-server,https-server \
  --create-disk=auto-delete=yes,boot=yes,device-name=ds,image=projects/ubuntu-os-cloud/global/images/ubuntu-1604-xenial-v20210928,mode=rw,size=20,type=projects/data-science-330201/zones/us-east1-b/diskTypes/pd-balanced \
  --no-shielded-secure-boot \
  --shielded-vtpm \
  --shielded-integrity-monitoring \
  --reservation-affinity=any
```

```bash
gcloud compute instances create vm-testing \
  --project=data-science-330201 \
  --zone=us-central1-a \
  --machine-type=e2-micro \
  --network-interface=network-tier=PREMIUM,subnet=default \
  --maintenance-policy=MIGRATE \
  --service-account=498106001917-compute@developer.gserviceaccount.com \
  --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
  --create-disk=auto-delete=yes,boot=yes,device-name=instance-1,image=projects/debian-cloud/global/images/debian-10-buster-v20211105,mode=rw,size=10,type=projects/data-science-330201/zones/us-central1-a/diskTypes/pd-balanced \
  --no-shielded-secure-boot \
  --shielded-vtpm \
  --shielded-integrity-monitoring \
  --reservation-affinity=any
```

- [Creating VMs with attached GPUs](https://cloud.google.com/compute/docs/gpus/create-vm-with-gpus)

```bash
gcloud compute instances create VM_NAME \
    --machine-type MACHINE_TYPE \
    --zone ZONE \
    --boot-disk-size DISK_SIZE \
    --accelerator type=ACCELERATOR_TYPE,count=ACCELERATOR_COUNT \
    [--image IMAGE | --image-family IMAGE_FAMILY] \
    --image-project IMAGE_PROJECT \
    --maintenance-policy TERMINATE --restart-on-failure \
    [--preemptible]
```

```bash
gcloud compute instances create depplearning \
    --machine-type n1-standard-4 \
    --zone us-central1-a \
    --boot-disk-size 100GB \
    --accelerator type=nvidia-tesla-t4,count=1 \
    --image-family debian-11 \
    --image-project debian-cloud \
    --maintenance-policy TERMINATE --restart-on-failure \
    --metadata "install-nvidia-driver=True,proxy-mode=project_editors"
```

-------------------------------------------------------------------------------

### Notebook

- [Create a `user-managed` notebooks instance](https://cloud.google.com/vertex-ai/docs/workbench/user-managed/quickstart-create-console)
- [Create a user-managed notebooks instance from the command line](https://cloud.google.com/vertex-ai/docs/workbench/user-managed/create-new)
  - > gcloud notebooks instances create INSTANCE_NAME \
    --vm-image-project=deeplearning-platform-release \
    --vm-image-family=VM_IMAGE_FAMILY \
    --machine-type=MACHINE_TYPE \
    --location=LOCATION

  - > gcloud notebooks instances create dl1 \
    --vm-image-project=deeplearning-platform-release \
    --vm-image-family=pytorch-1-10-cu110-notebooks \
    --machine-type=n1-standard-4 \
    --location=us-central1-a

-------------------------------------------------------------------------------

### Google Cloud Platform (GCP) - [Firewall Rules](https://www.youtube.com/watch?v=F1pWN3Lk7og&t=702s)

#### Remarks

- In order to release an previously created __External IP Address__, it must not be associated with any VM
- How to associate an external IP to VM:
  - Reserve an ip address first. Then

-------------------------------------------------------------------------------

### GPU

- [Creating VMs with attached GPUs](https://cloud.google.com/compute/docs/gpus/create-vm-with-gpus)
- [Adding or removing GPUs](https://cloud.google.com/compute/docs/gpus/add-remove-gpus)
- [GPU Pricing](https://cloud.google.com/compute/gpus-pricing)
- [GPUs on Compute Engine](https://cloud.google.com/compute/docs/gpus)

-------------------------------------------------------------------------------
















