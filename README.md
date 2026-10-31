## Project Setup & Initialization Checklist

Follow these steps to initialize this project locally and link it to a new remote repository on GitHub.

### 1. Create the Remote Repository on GitHub
- [ ] Go to [GitHub](https://github.com) and click the **"+"** icon in the top right -> **New repository**.
- [ ] Name your repository (e.g., `pytest-demo`).
- [ ] Choose **Public** (Recommended) or **Private**.
- [ ] **Important:** Leave "Add a README file", "Add .gitignore", and "Choose a license" **unchecked** (we will build these locally first).
- [ ] Click **Create repository**.
- [ ] Copy the repository HTTPS or SSH URL provided on the next page.

### 2. Initialize Git Locally
- [ ] Open your terminal and navigate to your project's root directory:
  - cd path/to/your/project-folder
- [ ] Initialize a local Git repository:
  - git init
- [ ] Ensure your default branch is set to main:
  - git branch -M main (only necessary if not default branch)
- [ ] Create baseline folder structure
  - `mkdir -p src tests .github/workflows`
  - `touch .gitignore .dockerignore requirements.txt Dockerfile .github/workflows/ci.yml run.sh`

### 3. Configure your .gitignore
- [ ] Ensure environment artifacts never get pushed:
```
# Node / JavaScript
node_modules/
dist/
dist-ssr/
build/
coverage/
*.tsbuildinfo
.vite/

# Python / Pytest
__pycache__/
.pytest_cache/
venv/
.venv/

# Docker / environment
.env
.env.*
!.env.example
```

### 4. Configure your .dockerignore
- [ ] Ensure Local Documentation & Scripts don't enter container:
```
# Documentation & Local Scripts
README.md
run.sh

# Git artifacts
.git
.gitignore

# Python artifacts
__pycache__/
.pytest_cache/
venv/
.venv/
```
### 5. Create your core files
- [ ] Create and populate your requirements.txt with testing dependency:
  - echo "pytest" > requirements.txt
- [ ] Create your Dockerfile in project root with container blueprint:
```
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "-m", "pytest"]
```
- [ ] Create your GitHub Actions workflow file at .github/workflows/ci.yml for automated cloud testing:
```
name: Python CI Pipeline

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository Code
        uses: actions/checkout@v4

      - name: Set up Python Environment
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Install Project Dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt

      - name: Run Pytest Suite
        run: python -m pytest
```
### 6. Shell Script Automation: Docker Build & Test
- [ ] In the project root, create a file named run.sh:
  - touch run.sh
- [ ] Inside run.sh:
```
#!/bin/bash

# Exit immediately if any command fails
set -e

IMAGE_NAME="pytest-env"

echo "----------------------------------------"
echo "Building Docker image: $IMAGE_NAME..."
echo "----------------------------------------"
docker build -t $IMAGE_NAME .

echo "----------------------------------------"
echo "Running containerized tests..."
echo "----------------------------------------"
docker run --rm $IMAGE_NAME

echo "----------------------------------------"
echo "Done!"
```
- [ ] Grant Execution Permissions:
  - chmod +x run.sh
- [ ] Execute Pipeline
  - ./run.sh

### 7. Connect to GitHub and Push
- [ ] Link your local repository to your remote GitHub repository:
  - git remote add origin <GITHUB_REPO_URL>
- [ ] Stage your files:
  - git add .
- [ ] Commit your baseline code:
  - git commit -m "Initial commit: project structure and setup"
- [ ] Push your code and set the upstream tracking branch:
  - git push -u origin main

### 8. Establish Git Branching & Feature Workflow
- [ ] Create and switch to a long-lived integration branch named `dev`:
  - `git checkout -b dev`
  - `git push -u origin dev`
- [ ] For every new feature, branch off `dev` using a descriptive prefix:
  - `git checkout dev`
  - `git pull origin dev`
  - `git checkout -b feature/factorial`
- [ ] Write your test, code your solution, run `./run.sh` locally, and commit your work:
  - `git add .`
  - `git commit -m "feat: complete factorial kata implementation"`
- [ ] Push your feature branch up to GitHub:
  - `git push -u origin feature/factorial-kata`
- [ ] Go to GitHub, open a **Pull Request (PR)** from `feature/factorial` **into `dev`**. 
- [ ] Verify that your GitHub Actions CI pipeline runs and passes (Green Checkmark) inside the PR interface.
- [ ] Merge the PR into `dev`, then delete the feature branch. Once ready for release, merge `dev` into `main`.

### 9. Execute Automated TDD Pipeline
- [ ] Run script to test baseline environment:
  - ./run.sh
- [ ] Go to repo on GitHub, click the Actions tab, verify that Python CI Pipeline ran successfully (Green Checkmark)
- [ ] Begin Red, Green, Refactor development by writing first test in:
  - tests/test_main.py