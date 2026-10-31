# - Go to: https://hub.docker.com/_/python to see official tags.
FROM python:3.11-slim

# - This acts like running 'cd /app' inside the container. 
WORKDIR /app

# - 'COPY' & 'RUN' INSTRUCTIONS (Dependencies)
# Decision: Why copy requirements.txt BEFORE copying the rest of your code?
# - Docker caches layers. By copying ONLY requirements.txt first and installing 
#   dependencies, Docker skips reinstalling packages every time you change a line 
#   of your source code. It only reinstalls if requirements.txt changes.
COPY requirements.txt .

# - Use RUN for commands executed during the *build* phase (like installing packages).
# - '--no-cache-dir' keeps the image size down by not storing local pip download caches.
RUN pip install --no-cache-dir -r requirements.txt

# - COPYING THE REST OF THE APPLICATION
# Decision: Now that dependencies are installed, copy your actual source code.
# - Format: COPY <host_directory_or_file> <container_destination>
COPY . .

# Decision: What command should run automatically when the container starts up?
# - Format: ["executable", "parameter1", "parameter2"] (Exec form is preferred).
# - This tells the container to run your main script using Python.
# - Decision: Running a python file?
# → CMD ["python", "src/main.py"]
# - Decision: Running a Pytest? No specified test file, runs everything in ./tests/
# → CMD ["pytest"]
CMD ["python", "-m", "pytest"]