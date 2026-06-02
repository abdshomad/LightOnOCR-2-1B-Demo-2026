#!/bin/bash
export GRADIO_ALLOWED_PATHS="$(pwd)/LightOnOCR-2-1B-Demo"
uv run python app.py
