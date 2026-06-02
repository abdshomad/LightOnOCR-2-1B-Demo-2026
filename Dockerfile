FROM nvidia/cuda:12.6.0-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.local/bin:$PATH"

# Install system dependencies (git is needed for GitHub repository dependencies, libgl for Pillow/image processing)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

WORKDIR /app

# Copy pyproject.toml first for package dependency caching
COPY pyproject.toml ./

# Initialize venv and install dependencies
RUN uv python pin 3.12 && uv sync --no-dev

# Copy all repository files (including the submodule code under LightOnOCR-2-1B-Demo)
COPY . /app

# Expose the default Gradio interface port
EXPOSE 7860

# Run the app directly using the virtual environment's python with unbuffered logs
CMD [".venv/bin/python", "-u", "app.py"]
