FROM ghcr.io/dbt-labs/dbt-postgres:1.9.0

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY . .
WORKDIR /usr/src/app/ipify
CMD [ "run", "--profiles-dir", "profiles", "--fail-fast", "--full-refresh" ]