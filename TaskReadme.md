# Fullstack deployment by provision the following

Coding Assessment

You want to design a scalable and secure continuous delivery architecture for a full-stack web application. Since the app itself is not going to be scored, you can use any of the implemented technology available for Real World applications available at https://github.com/gothinkster/realworld. Please pick any technology combination that suits you. You should fork the repository and use it as the base for your system.

    The architecture needs to be broken down into the relevant tiers (application, database, etc.).
    The architecture should be completely provisioned via Chef/Puppet/Ansible/similar.
    The deployment of new code and execution of tests should be completely automated. (Bonus points if you can catch performance regressions).
    The database and any mutable storage need to be backed up at least daily.
    All relevant logs for all tiers need to be easily accessible (having them on the hosts is not an option).
    Implement monitoring and logging using self-provisioned tools. Usage of managed services for monitoring/logging is not permitted.
    You should fork the repository and use it as the base for your system.
    You should be able to deploy it on one larger Cloud provider: AWS / Google Cloud / Azure / DigitalOcean / RackSpace.
    The system should present relevant historical metrics to spot and debug bottlenecks.

As a solution, please commit to a github repo and send a link as the solution:

    An architectural diagram / PPT to explain your architecture during the interview.
    All the relevant configuration scripts (Chef/Puppet/cfengine/ansible/cloud formation)
    All the relevant runtime handling scripts (start/stop/scale nodes).
    All the relevant backup scripts.
    The forked version of the app you are going to use.

### Solutions 1

To design a scalable and secure continuous delivery architecture for the full-stack web application using AWS, you can consider the following solution:

    Architecture Tiers:
        Application Tier: Use AWS Elastic Beanstalk or AWS ECS (Elastic Container Service) to deploy and manage the web application. These services provide auto-scaling capabilities and easy deployment options.
        Database Tier: Utilize Amazon RDS (Relational Database Service) for the database layer. It offers managed database instances for various engines like MySQL, PostgreSQL, etc. This allows you to easily scale and automate backups.

    Infrastructure Provisioning:
        Use AWS CloudFormation or AWS CDK (Cloud Development Kit) to define and provision the entire infrastructure as code. These tools enable you to define templates that capture the desired AWS resources and configurations.

    Automated Deployment and Testing:
        Integrate your code repository (forked from the RealWorld application) with AWS CodePipeline. Set up a pipeline that triggers on every code commit, pulling the latest changes, and deploying the application using AWS CodeDeploy.
        Incorporate automated testing into the pipeline using AWS CodeBuild. Configure the pipeline to execute unit tests, integration tests, and performance tests to catch any regressions.

    Database and Storage Backups:
        Utilize the built-in backup functionality of Amazon RDS to create automated backups of the database at least daily. Configure the backup retention period and automate the process using AWS Backup.
        For mutable storage or file uploads, consider using Amazon S3 (Simple Storage Service) with versioning enabled. This allows you to retain and restore previous versions of files.

    Centralized Logging:
        Set up an Amazon CloudWatch Logs agent on each EC2 instance or container to collect logs. Configure the agent to stream the logs to Amazon CloudWatch Logs.
        Use AWS CloudWatch Logs to create log groups and define retention periods. You can also set up alarms and notifications based on log events.

    Monitoring and Logging:
        For monitoring, use Amazon CloudWatch to collect and visualize metrics for your application, database, and infrastructure. Configure custom CloudWatch dashboards to display relevant historical metrics for debugging bottlenecks.
        Implement application-level monitoring using AWS X-Ray to trace requests and identify performance bottlenecks within your application code.

### solution 2 using aws eks

Architecture Tiers:
Application Tier: Deploy your application as containerized workloads on AWS EKS. EKS provides a managed Kubernetes control plane and makes it easier to scale and manage containerized applications.
Database Tier: Use Amazon RDS or consider using Amazon Aurora as a managed database service for your application's database layer. Aurora is compatible with MySQL and PostgreSQL and can be integrated with EKS.

    Infrastructure Provisioning:
        Use AWS CloudFormation or AWS CDK to define and provision the necessary EKS cluster resources, including worker nodes, networking, and security groups. You can define and manage the infrastructure as code.

    Automated Deployment and Testing:
        Set up a CI/CD pipeline using AWS CodePipeline. Configure the pipeline to build your containerized application using AWS CodeBuild, push the Docker images to Amazon ECR (Elastic Container Registry), and deploy the application to EKS using tools like AWS App Runner or Kubernetes manifests.
        Incorporate automated testing into the pipeline by integrating tools like AWS CodeBuild or Jenkins to execute unit tests, integration tests, and performance tests.

    Database and Storage Backups:
        Follow the same approach as in the previous solution. Use Amazon RDS or Aurora for the database tier, and configure automated backups using AWS Backup. For mutable storage, consider using Amazon S3 with versioning.

    Centralized Logging:
        Utilize the logging capabilities of Kubernetes and EKS. Configure Fluentd or other log collection agents as Kubernetes DaemonSets to collect container logs and forward them to a centralized log management solution like the ELK stack (Elasticsearch, Logstash, Kibana) or a tool like Fluent Bit. You can also leverage AWS services like Amazon CloudWatch Logs or Amazon Elasticsearch Service for log aggregation and analysis.

    Monitoring and Logging:
        Utilize Kubernetes-native monitoring and observability tools like Prometheus and Grafana. Deploy Prometheus for collecting metrics from your EKS cluster, applications, and services, and use Grafana to visualize and create custom dashboards.
        Additionally, consider using AWS CloudWatch Container Insights to gain insights into the performance and health of your containers, nodes, and clusters. It provides metrics, logs, and automated dashboards specifically designed for containerized workloads.

Remember to implement proper security measures such as secure network access, encryption at rest and in transit, and IAM roles and policies to control access to your EKS cluster and AWS resources.

With this updated approach, your application will be deployed as containerized workloads on EKS, leveraging the benefits of Kubernetes orchestration and scalability while utilizing managed AWS services for databases, backups, logging, monitoring, and logging analysis.
