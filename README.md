# LightOnOCR-2-1B Online Demo Deployment

This repository containerizes and deploys the [LightOnOCR-2-1B-Demo](https://huggingface.co/spaces/lightonai/LightOnOCR-2-1B-Demo) online demo using a GPU-accelerated containerized architecture.

## Architecture Overview

The system is deployed using Docker Compose to orchestrate two services:
1. **Nginx Frontend Reverse Proxy**: Serves as the single ingress point on the custom port configured in `.env` (default is `7872`). It reverse proxies connections to the Gradio interface and handles WebSocket protocols (used for streaming output).
2. **Gradio UI Server (`lightonocr-demo`)**: Runs the LightOnOCR application, loading the chosen VLM (e.g. `LightOnOCR-2-1B`, `LightOnOCR-2-1B-bbox`) with PyTorch, transformers, and GPU acceleration.

## Directory Structure

*   [AGENTS.md](AGENTS.md) - Agent guidelines and command references.
*   [docker-compose.yml](docker-compose.yml) - Main multi-container orchestrator.
*   [Dockerfile](Dockerfile) - CUDA-enabled build instruction for the python runtime.
*   [nginx.conf](nginx.conf) - Ingress reverse proxy configuration.
*   [install.sh](install.sh) - Local setup script (uses `uv`).
*   [run.sh](run.sh) - Local runtime script (uses `uv`).

## Prerequisites

- **NVIDIA GPU** with CUDA support.
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) (to pass GPUs to Docker containers).
- [Docker](https://docs.docker.com/) and **Docker Compose v2**.
- Python 3.12+ and [uv](https://github.com/astral-sh/uv) (for running locally without Docker).

## Getting Started

### 1. Configure the Environment
Create or edit the `.env` file in the root directory:
```env
PORT=7872
```

### 2. Run via Docker Compose
Build and run the GPU-accelerated services:
```bash
docker compose up -d --build
```
This launches the Gradio OCR app container and the Nginx proxy. You can access the interface on the port configured in `.env` (e.g. `http://localhost:7872`).

### 3. Run Locally (Development)
To run the Gradio interface locally without Docker:
```bash
# Set up dependencies
./install.sh

# Run the app
./run.sh
```