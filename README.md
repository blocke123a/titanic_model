# Titanic Model Project

This repository demonstrates predictive modeling for the Titanic dataset using both Python and R. Each environment is containerized with Docker and runs independently.

Disclaimer: The commands used in this readme are Windows commands. If using a different OS, ensure you use the equivalent commands.

---

## Repository Structure

```
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
│ │ ├─ R_predictions_test.csv  # Output generated when R container runs
│ │ └─ data/ # R requires train.csv and test.csv here (not included)
│ │ ├─ .gitkeep # Ensures the empty data file is included
│ │ ├─ train.csv
│ │ └─ test.csv
│ │
│ └─ data/ # Python requires train.csv and test.csv here (not included)
│ ├─ .gitkeep # Ensures the empty data file is included
│ ├─ train.csv
│ └─ test.csv
├─ .gitignore
├─ python_predictions_test.csv  # Output generated when Python container runs
├─ CODEOWNERS
├─ Dockerfile # Python Dockerfile
├─ requirements.txt # Python dependencies
└─ README.md
```

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

These files are not included in this repository due to ```.gitignore``` rules.

---

## Requirements

- Docker must be installed and running.

Check Docker installation with:

```docker --version```


**Running the Python Model**
Navigate to the folder environment:
```cd your_file_path/titanic_model```

**Build the Docker image:**
```docker build -t titanic-python-model .```

**Run the container:**
```docker run --rm -v "${PWD}:/app" titanic-python-model```

The Python script (predict.py) will execute inside the container and output results to python_predictions_test.csv.

**Running the R Model**
Navigate to the R container folder:
```cd src/r_run```

**Build the Docker image:**
```docker build -t titanic-r-model .```

**Run the container:**
```docker run --rm -v "${PWD}:/app" titanic-r-model ```

The R script (predict.R) will execute inside the container and output results to R_predictions_test.csv.
