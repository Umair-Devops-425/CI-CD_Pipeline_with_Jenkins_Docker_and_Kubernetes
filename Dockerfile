# base image
FROM python:3.11-slim

# working directory
WORKDIR /app

# copying requirements.txt filr
COPY requirements.txt .

# installing dependencies 
RUN pip install -r requirements.txt

# copying code 
COPY . .

# exposing
EXPOSE 5000


CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "run:app"]
