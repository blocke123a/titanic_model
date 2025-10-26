FROM r-base:latest

WORKDIR /app

COPY install_packages.R .
RUN Rscript install_packages.R

COPY predict.R .
COPY data/train.csv ./data/train.csv
COPY data/test.csv ./data/test.csv

CMD ["Rscript", "predict.R"]