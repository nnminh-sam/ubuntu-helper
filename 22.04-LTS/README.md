# For Ubuntu 22.04-LTS Version

---

## Install Docker

1. Make installation script executable
    
    ```bash
    chmod +x install-docker.sh
    ```
1. Run installation script
    
    ```bash
    install-docker.sh
    ```
1. Check installation process

    - Check Docker version

        ```bash
        docker --version
        ```

    - Check Docker service status

        ```bash
        systemctl status docker
        ```

    - If cannot run Docker without `sudo`, run the below command

        ```bash
        sudo usermod -aG docker $USER
        ```

    - Run Hello world docker sample

        ```bash
        docker run hello-world
        ```

---





