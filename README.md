# Titanic Model Project

This repository demonstrates predictive modeling for the Titanic dataset using both Python and R. Each environment is containerized with Docker and runs independently.

---

## Repository Structure

titanic_model/
│
├─ src/
│ ├─ run/ # Python model scripts
│ │ └─ predict.py
│ │
│ ├─ r_run/ # R model scripts and Docker container
│ │ ├─ Dockerfile
│ │ ├─ install_packages.R
│ │ ├─ predict.R
│ │ └─ data/ # R requires train.csv and test.csv here (not included)
│ │ ├─ train.csv
│ │ └─ test.csv
│ │
│ └─ data/ # Python requires train.csv and test.csv here (not included)
│ ├─ train.csv
│ └─ test.csv
├─ .gitignore
├─ CODEOWNERS
├─ Dockerfile # Python Dockerfile
├─ requirements.txt # Python dependencies
└─ README.md


## Dataset Instructions

The Titanic dataset can be downloaded from Kaggle:

[Titanic – Machine Learning from Disaster](https://www.kaggle.com/competitions/titanic/data)

**Required files:**
- `train.csv`
- `test.csv`

**Placement for Python container:**  
Download the files and place them in `src/data/`.

**Placement for R container:**  
Download the files and place them in `src/r_run/data/`.

---

## Requirements

- Docker must be installed.

Check Docker installation with:

docker --version


Running the Python Model
Navigate to Python scripts:
cd src/run

Build the Docker image:
docker build -t titanic-python-model .

Run the container:
docker run --rm -v "%cd%:/app" titanic-python-model

The Python script (predict.py) will execute inside the container and print results in the terminal.

Running the R Model
Navigate to the R container folder:
cd src/r_run

Build the Docker image:
docker build -t titanic-r-model .

Run the container:
docker run --rm titanic-r-model

The R script (predict.R) will execute inside the container and print results in the terminal.
