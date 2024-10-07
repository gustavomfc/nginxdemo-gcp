from diagrams import Cluster, Diagram
from diagrams.gcp.network import DNS, FirewallRules, NAT, VPC, Router
from diagrams.gcp.network import Network, LoadBalancing
from diagrams.gcp.compute import GKE, ComputeEngine
from diagrams.onprem.network import Internet
from diagrams.onprem.queue import Emqx as DNSZone
from diagrams.onprem.client import User, Users

from diagrams.k8s.network import SVC, Ingress
from diagrams.k8s.others import CRD
from diagrams.k8s.rbac import ServiceAccount
from diagrams.k8s.compute import Deployment, Pod, ReplicaSet
from diagrams.k8s.group import Namespace

with Diagram("NGINX Hello GCP k8s Infra", show=False, direction="TB"):
    with Cluster("Management User"):
        management_user = User("Management User")
        iap_proxy = Internet("IAP Proxy")

    with Cluster("Project"):
        with Cluster("VPC"):
            vpc = VPC("VPC")
            with Cluster("DNS"):
                dns = DNS("Cloud DNS")
                dns_zone = DNSZone("task1-external-zone")
            with Cluster("Firewall Rules"):
                firewall = FirewallRules("Firewall Rules")

            with Cluster("NAT Gateway"):
                router = Router("vpc-router-us-east1")
                nat = NAT("vpc-router-nat-us-east1")

            with Cluster("Bastion IAP Proxy"):
                bastion_subnet = Network("bastion-subnet")
                bastion = ComputeEngine("bastion")

            with Cluster("GKE"):
                gke = GKE("task1-cluster")

    with Cluster("Internet"):
        internet = Internet("Internet")

    management_user >> iap_proxy >> bastion

    vpc - dns
    vpc - gke
    vpc - firewall
    vpc - bastion_subnet
    vpc >> router >> nat >> internet

with Diagram("Task 1 Cluster 1 Deployment", show=False):
    with Cluster("Internet"):
        internet = Internet("Internet")
        users = Users("Users")

    with Cluster("GCP Project"):
        gke = GKE("task1-cluster")
        with Cluster("task1-cluster"):
            namespace = Namespace("task1-app")
            with Cluster("task1-app namespace"):
                service_account = ServiceAccount("task1-app-sa")
                deployment = Deployment("task1-app-deployment")
                service = SVC("task1-app-svc")
                network_policies = CRD("task1-app-network-policies")
                with Cluster("task1-app-deployment"):
                    replica_set = ReplicaSet("task1-app-replica-set")
                    with Cluster("task1-app-replica-set"):
                        pod = [
                            Pod("task1-app-replica"),
                            Pod("task1-app-replica"),
                            Pod("task1-app-replica"),
                        ]
                with Cluster("GKE Ingress"):
                    ingress = Ingress("task1-app-ingress")
                    https_redirect = CRD("task1-app-https-redirect")
                    lb = LoadBalancing("task1-app-lb")
                    ssl_certificate = CRD("task1-app-ssl-certificate")

    users >> internet >> lb
    lb >> ingress >> service
    ssl_certificate - lb
    https_redirect - lb

    service >> deployment >> replica_set >> network_policies >> pod
    pod >> network_policies >> internet
    service_account - pod
