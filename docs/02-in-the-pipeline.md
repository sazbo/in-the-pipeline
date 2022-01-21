# In The Pipeline

## Story

This is what it all came down to. You're already able to setup a whole infrastructure by hand. However, there's still room to improve. What if you could set up everything automatically? As you think this through, another question comes to your head. Which CI/CD tool is worthy for the deed? It's time to find out for yourself, so you will check out two different tools for a start.

## What are you going to learn?

- Being able to automate infrastructure setup with Jenkins Multibranching
- Being able to automate infrastructure setup with Gitlab CI
- Usage of Secrets with Gitlab CI

## Tasks

1. Create a Multibranch Jenkins project to deploy your application from last week (Tinker Tailor Docker Spy) in an automated way
    - Usage of Helm
    - Usage of Multibranch project feature of Jenkins
    - Your application deployed with Helm by the Jenkins CI/CD Pipeline
    - Your application running on the cluster which can be checked with a web browser

2. Create a Gitlab CI project to deploy your application
    - Usage of Helm
    - Your application deployed with Helm by Gitlab CI
    - Your application running on the cluster which can be checked with a web browser

3. Add a Prometheus Helm deployment to your pipeline
    - Usage of Helm
    - Prometheus deployed with Helm by Gitlab CI
    - The Prometheus UI being reachable through your browser

4. Add a Grafana Helm deployment to your pipeline
    - Usage of Helm
    - Grafana deployed with Helm by Gitlab CI
    - The Grafana UI being reachable through your browser

5. Store every secret that is needed to run your infrastructure (including your monitoring stack) in the CI variable section of Gitlab and use them in your CI
    - Your secrets stored inside the CI variables section of Gitlab
    - Your secrets being used inside the gitlab-ci.yml file
    - Your infrastructure still running without errors after the usage of secrets

6. Configure Grafana to use Prometheus as its data source
    - Grafana being able to retrieve data from Prometheus
    - Your monitoring stack still running without errors

## General requirements

None

## Hints

- The ```gitlab-ci.yml``` file should be at the top level of the repository
- There's a built in lint tool for checking your ```gitlab-ci.yml``` file in the Gitlab UI
- There are also predefined variables in Gitlab CI (check for future projects as it will certainly be useful)

## Background materials

- <i class="far fa-exclamation"></i> [Setting up multibranch pipeline in Jenkins](https://www.jenkins.io/doc/book/pipeline/multibranch/)
- <i class="far fa-exclamation"></i> [Setting up environment variables in Gitlab CI with the usage of Gitlab UI](https://docs.gitlab.com/ee/ci/variables/README.html#create-a-custom-variable-in-the-ui)
- <i class="far fa-video"></i> [Gitlab CI pipeline tutorial](https://www.youtube.com/watch?v=Jav4vbUrqII)
