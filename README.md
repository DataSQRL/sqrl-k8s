# SQRL Compiler Kubernetes Profile

This project provides a profile for the SQRL compiler to generate Helm charts and `values.yaml` files for deploying your SQRL pipeline to a Kubernetes cluster. Follow the instructions below to set up your Kubernetes cluster, compile your project, and deploy using Helm.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setting Up a Local Kubernetes Cluster](#setting-up-a-local-kubernetes-cluster)
  - [Using Minikube](#using-minikube)
  - [Using Docker Desktop](#using-docker-desktop)
- [Installing Required Operators](#installing-required-operators)
- [Compiling with SQRL Compiler](#compiling-with-sqrl-compiler)
- [Configuring Flink Upstream Image](#configuring-flink-upstream-image)
  - [Supporting User-Defined Functions (UDFs)](#supporting-user-defined-functions-udfs)
  - [Using the Default Upstream Flink Image](#using-the-default-upstream-flink-image)
  - [Creating a Custom Upstream Docker Image](#creating-a-custom-upstream-docker-image)
- [Deploying with Helm](#deploying-with-helm)
- [Introspecting the Running Flink Web UI](#introspecting-the-running-flink-web-ui)
- [Limitations](#limitations)
- [Support](#support)
- [License](#license)

## Prerequisites

Ensure you have the following installed:

- **Kubernetes Cluster**
- **kubectl** command-line tool
- **Helm**
- **SQRL**
- **Docker**

## Setting Up a Local Kubernetes Cluster

If you do not have access to a Kubernetes cluster, you can set up a local cluster using Minikube or Docker Desktop.

### Using Minikube

#### Install Minikube

For **macOS**:

```bash
brew install minikube
```

For other platforms, follow the [Minikube installation guide](https://minikube.sigs.k8s.io/docs/start/).

If using minikube, be aware that you must mount a local volume to access UDFs.

#### Start Minikube

```bash
minikube start
```

### Using Docker Desktop

Docker Desktop includes a built-in Kubernetes cluster.

1. **Install Docker Desktop:**

   [Download Docker Desktop](https://www.docker.com/products/docker-desktop) for your operating system.

2. **Enable Kubernetes:**

  - Open Docker Desktop Preferences.
  - Navigate to the **Kubernetes** tab.
  - Check **Enable Kubernetes**.
  - Click **Apply & Restart**.

## Installing Required Operators

Install the required operators using the instructions below.

**Note:** Install all operators in the same namespace (e.g., `sqrl`) to ensure proper service discovery and interaction.

Create the namespace:

```bash
kubectl create namespace sqrl
```

### Strimzi (Kafka Operator)

[Strimzi Documentation](https://strimzi.io/quickstarts/)

### CloudNativePG (PostgreSQL Operator)

[CloudNativePG Documentation](https://cloudnative-pg.io/documentation/1.16/quickstart/)

### Apache Flink Operator

[Flink Operator Documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-main/)

## Compiling with SQRL Compiler

Compile your project using the Kubernetes profile to generate the Helm charts and `values.yaml` file.

```bash
sqrl compile --profile k8s ...
```

This command generates Helm charts and a `values.yaml` file in the default `build/deploy` directory. 

## Configuring Flink Upstream Image

### Supporting User-Defined Functions (UDFs)

To include your custom UDFs in the Flink deployment, you have two options:

1. **Download UDFs from a Repository:**

   Configure your Flink job to download UDFs from the [DataSQRL repository](https://dev.datasqrl.com/) which would be accessible by your Kubernetes cluster.

2. **Include UDFs in a Custom Upstream Image:**

   Embed your UDFs directly into a custom Flink Docker image.

3. **Build a Flink job JAR as an uberjar:**
   
   Build your own flink job jar and place it in a place accessible in your k8s environment. The default job jar runner can be overridden. 

### Using the Default Upstream Flink Image

We provide a default upstream Flink image at `datasqrl/flink-1.19-v0.5`, which includes all standard connectors that datasqrl supports out of the box. Any UDFs can be resolved by the JAR launcher.

In your `package.json`, specify the default image under the `values` object:

```json
{
    "values": {
      "k8s": {
        "flink-upstream-image": "datasqrl/flink-1.19-v0.5"
      }
    }
}
```

### Creating a Custom Upstream Docker Image

If you need to include bespoke connectors or UDFs directly in the image, you can create a custom upstream Docker image.

1. **Modify the Dockerfile:**

   Navigate to the `flink-upstream-image` directory and edit the Dockerfile to include your UDFs or connectors.

2. **Build and Publish the Image:**

   ```bash
   docker build -t your-repo/your-flink-image:latest .
   docker push your-repo/your-flink-image:latest
   ```

3. **Specify the Custom Image in `package.json`:**

    Update your `package.json` under the `values` object:
    
    ```json
    {
     "values": {
       "k8s": {
         "flink-upstream-image": "your-repo/your-flink-image:latest"
       }
     }
    }
    ```

4. **Set UDF_PATH Argument (Optional):**

   If you're not embedding UDFs in the image, specify the path using the Flink bootstrapper's `UDF_PATH` argument:

   ```yaml
   args:
  - --UDF_PATH=/path/to/your/udfs
    ```

## Deploying with Helm

Deploy the generated Helm charts to your Kubernetes cluster:

```bash
helm install my-sqrl-project ./build/deploy -n sqrl
```

Replace `my-sqrl-project` with your desired release name. Ensure you're in the directory containing the `build/deploy` folder or provide the correct path.

## Introspecting the Running Flink Web UI

Access the Flink Web UI to monitor your Flink cluster:

1. **Port-Forward the Flink Service:**

   ```bash
   kubectl port-forward svc/flink-jobmanager 8081:8081 -n sqrl
   ```

2. **Access the Web UI:**

   Open your browser and navigate to `http://localhost:8081`.

## Accessing the GraphQL UI

1. **Port-Forward the GraphQL Service:**
    ```bash
    . kubectl port-forward svc/vertx-server 8888:8888 -n sqrl
    ```

2. **Access the Web UI:**

   Open your browser and navigate to `http://localhost:8888/graphiql/`.

## Limitations

- **Local UDFs:** Need to be uploaded to a repository or included in a custom Docker image.
- **Connectors:** SQRL assumes all connectors are streams by default. If you need to support a connector with a different changelog stream, please [open an issue](https://github.com/your-repo/issues).

## Structure
The helm charts take the following structure. Fork this repository and make changes and use it as your own default profile.
```
sqrl-helm-charts/
├── Chart.yaml
├── values.yaml
└── templates/
    ├── kafka/
    │   ├── deployment.yaml
    │   └── service.yaml
    ├── postgres/
    │   ├── configmap.yaml
    │   ├── deployment.yaml
    │   └── service.yaml
    ├── flink/
    │   ├── configmap.yaml
    │   ├── deployment.yaml
    │   └── service.yaml
    └── vertx/
        ├── configmap.yaml
        ├── deployment.yaml
        └── service.yaml
```

## Support

For issues or questions, please [open a ticket](https://github.com/your-repo/issues).

## License

This project is licensed under the [MIT License](LICENSE).

---

**Note:** Replace placeholders like `your-repo`, `your-flink-image`, and `your-target-directory` with your actual repository names and paths.
