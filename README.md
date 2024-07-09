# ModelSim Docker Container

Instructions on how to build and run a Docker container for ModelSim using the provided Dockerfile and scripts.

### Building the Docker Image

Clone the repository containing the Dockerfile and scripts.

Make the scripts executable:

```bash
chmod +x build.sh run.sh
```

Run the build.sh script to build the Docker image:

```bash
./build.sh
```

### Running the Docker Container

Use the `run.sh` script to run the Docker container. You need to provide the path to your project as an argument.

```bash
./run.sh <project_path>
```

Replace <project_path> with the absolute path to your ModelSim project directory. For example:

```bash
./run.sh /home/user/Projects/fpga
```

### Notes

- Ensure the provided project path is an absolute path.
- The container will be run with the same UID and GID as the current user to ensure proper permissions for accessing files in the mounted project directory.
- X11 forwarding is set up to allow ModelSim's GUI to run on the host's display.

Feel free to modify the Dockerfile or scripts to suit your specific requirements.