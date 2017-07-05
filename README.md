# CSMO for Kubernates based Cloud Native Reference Application

*This project is part of the 'IBM Cloud Native Reference Architecture for Kubernetes' suite, available at
https://github.com/ibm-cloud-architecture/refarch-cloudnative-kubernetes*

## Table of Contents
- **[Introduction](#introduction)**


## Introduction
DevOps, specifically Cloud Service Management & Operations (CSMO), is important for Cloud Native Microservice style applications. This project is developed to demonstrate how to use tools and services available on IBM Bluemix to implement CSMO for the BlueCompute reference application.

The full CSMO documentation is found at **[[TBD]]** 

This project deploys a self contained and independent monitoring stack into the Kubernetes Cluster. [**Helm**](https://github.com/kubernetes/helm) is Kubernetes's package manager, which facilitates deployment of prepackaged Kubernetes resources that are reusable. With the aid of Helm, the monitoring component **Prometheus** and the display component **Grafana** are deployed.

Let's get started.

## Architecture & CSMO toolchain
Here is the High Level DevOps Architecture Diagram for the CSMO setup on Kubernetes.

This guide will install the following resources on a lite/free cluster:
* 1 x Grafana pod
* 3 x Prometheus pods
* 1 x Prometheus service for above Prometheus pods with only internal cluster IPs exposed.
* 1 x Grafana service for above Grafana pod with a port exposed to the external internet.
* All using Kubernetes Resources.

## Pre-Requisites
1. **CLIs for Bluemix, Kubernetes, Helm, JQ, and YAML:** Run the following script to install the CLIs:

    `$ ./install_cli.sh`

2. **Bluemix Account.**
    * Login to your Bluemix account or register for a new account [here](https://bluemix.net/registration).
    * Once you have logged in, create a new space for hosting the application.
3. **Lite Kubernetes Cluster:** If you don't already have a paid Kubernetes Cluster in Bluemix, please go to the following links and follow the steps to create one.
    
## Install Prometheus & Grafana on Kubernetes
### Step 1: Install Prometheus & Grafana on Kubernetes Cluster
As mentioned in the [**Introduction Section**](#introduction), we will be using a Prometheus Helm Chart to deploy Prometheus into a Bluemix Kubernetes Cluster. Before you do so, make sure that you installed all the required CLIs as indicated in the [**Pre-Requisites**](#pre-requisites).

Here is the script that installs the charts for you:
    On Windows :  
    ```
    install_csmo.bat <cluster-name> <bluemix-space-name> <bluemix-api-key> <region id> 
    ```
    On Linkux/Mac:
    ```
    ./install_csmo.sh <cluster-name> <bluemix-space-name> <bluemix-api-key> <region id>
    ```
    
Upon completion you will be presented with the Grafana URL and admin password

**Note** that Prometheus and Grafana may take a few minutes to initialize even after showing installation success

The `install_csmo.sh` script does the following:
* **Log into Bluemix.**
* **Set Terminal Context to Kubernetes Cluster.**
* **Initialize Helm Client and Server (Tiller).**
* **Install Prometheus Chart on Kubernetes Cluster using Helm.**
* **Install Grafana Chart on Kubernetes Cluster using Helm.**
* **Configure a Datasource in Grafana to access Prometheus.**
* **Retreives password and IP:PORT information to access Grafana.**

### Step 2: Import Prometheus-specific dashboards to Grafana
This is a quick and easy way to see information in Grafana quickly and easily. Note that you may only run the following script after Grafana has finished initializing, so check that you can login before running the script (there is no problem with running the script multiple times).

Here is the script that installs the Prometheus dashboards for you:

On Windows :  

    ```
    import_dashboards.bat <grafana_url> <grafana_password>
    ```
On Linkux/Mac:

    ```
    ./import_dashboards.sh <grafana_url> <grafana_password>
    ```

That's it! You now have a fully working version of Prometheus and Grafana on your Kubernetes Deployment
