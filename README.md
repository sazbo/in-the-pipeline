# in-the-pipeline
This repository is a merge of two teamwork projects.

Deploying a Kotlin application from zero:
- Infrastucture is managed by Terraform
- Pipelines are in EC2 instances running Jenkins and Gitlab CI runner
- Used GitHub webhooks to automate trigger pipelines


Contents:

1. Deployment

    - Application with Dockerfile
    - Helm chart to deploy the app to a cluster
    - Prometheus and Grafana
    - Additional scripts for pipelines

2. Pipeline

    - Terraform infrastructure
    - Jenkins pipeline
    - GitLab pipeline



```

### 1. deployment (tinker-tailor docker spy)

1.

- Dockerized a freshly written Kotlin/Ktor application. It's a backend project with an endpoint, that can handle requests, and gives back a response.

- The application runs successfully inside the container.
Uploaded the image to a registry.

- The image can be found in the registry.
Created a k8s yaml config file for the application, and deployed it to a cluster, along with Prometheus and Grafana.

- The application, Prometheus, Grafana were in a running state inside the cluster.
Configured metrics stack to monitor your application, and check it along with your app.

- The monitoring information about the application can be successfully checked, and the app also returns a response after calling the endpoint.
Upgraded the k8s config files to use Helm

- The application, Prometheus, Grafana were in a running state inside the cluster.



### 2. pipeline (in-the-pipeline, terraforming-solar-system)

2. Created a Multibranch Jenkins project to deploy the application in an automated way
    - Usage of Helm
    - Usage of Multibranch project feature of Jenkins
    - The application deployed with Helm by the Jenkins CI/CD Pipeline
    - The application running on the cluster which can be checked with a web browser

 ... and same with GitLab CI

```



The task descriptions are in the docs folder

Used GitHub projects for planning.

Contributors: "The Geeky Blinders": 
@martingrant01 @sazbo @toth-b