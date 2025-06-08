# Data Quality Analysis with dbt (Dockerized)

## Overview

This repository contains a **dbt (Data Build Tool)** project designed to answer the following business question:

> “Per country, which product is the most frequently purchased?”

We use a Dockerized dbt workflow to transform and model the data and produce a final table with the required results.

---

## Problem Statement

### Goal

Produce a small table that answers:

> “Per country, which product is the most frequently purchased?”

**Expected Output:**

| Country | Product | Order Count |
| ------- | ------- | ----------- |

---

### Provided Files

1. `clients.txt` – 10 rows, pipe-`|` delimited

   * Columns: `Client Name`, `Street Address`, `City`, `Country`

2. `orders.csv` – 20 rows, comma-separated

   * Columns: `order_id`, `client_name`, `product`, `quantity`, `price`
   * Note: `quantity` is always **1** (can be ignored)

> ⚠️ Note: The source files were not consistently separated using a standard delimiter. This issue was resolved manually by adjusting the files directly, instead of overengineering a solution using Python.

---

## Repository Structure

```
.
├── dbt_project/            # Main dbt project folder
│   ├── models/
│   ├── seeds/              # Processed input files
|   ├──   ├── clients.csv
│   ├──   └── orders.csv
|   ├── snapshots/
│   └── dbt_project.yml
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
└── README.md
```

---

## Getting Started

This section helps **non-technical users** install Docker and run this dbt project to reproduce the final results.

### Step 1: Install Docker

#### For Windows

1. Download Docker Desktop for Windows: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
2. Run the installer and follow on-screen instructions
3. Ensure **WSL 2** feature is enabled (installer will guide you if not)
4. After installation, restart your computer
5. Launch Docker Desktop to verify it's running

#### For Mac

1. Download Docker Desktop for Mac: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
2. Open the downloaded `.dmg` file and drag Docker into your `Applications`
3. Launch Docker from `Applications`
4. Follow the setup process
5. Ensure Docker is running (you'll see the whale icon in your top menu bar)

---

### Step 2: Clone the Repository

Open your terminal (Command Prompt or Terminal app) and run:

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
cd YOUR_REPO_NAME
```

> Replace `YOUR_USERNAME` and `YOUR_REPO_NAME` with the actual repo details.

---

### Step 3: Run dbt Using Docker

From inside the cloned repo folder, run:

```bash
docker-compose up --build
```

This will:

* Build the Postgres database on localhost listing on port 5432.

From inside the cloned repo folder, run:

```bash
docker build -t dbt .
docker run --net=host dbt
```

This will:

* Run the dbt project and populate the Postgres database with both the initial and transformed data

Once completed, the final table will be available as 'public.solution' inside the Postgres database.

---

## Project Logic

The dbt project performs the following:

1. Loads `clients.csv` and `orders.csv` as seed data
2. Joins clients with orders using `client_name`
3. Groups orders by `Country` and `Product`
4. Counts number of purchases per product per country
5. Selects the most frequently purchased product per country

---

## Output

<details>
<summary>Click to expand the results table</summary>

<div style="overflow-x: auto;">

| Country       | Product       | Order Count |
| ------------- | ------------- | ----------- |
| Australia     | Backpack      | 1           |
| Australia     | Notebook      | 1           |
| Belgium       | Backpack      | 1           |
| Belgium       | Coffee Mug    | 1           |
| Brazil        | Coffee Mug    | 1           |
| Brazil        | Notebook      | 1           |
| China         | Coffee Mug    | 1           |
| China         | Laptop Sleeve | 1           |
| Germany       | Notebook      | 1           |
| Germany       | Water Bottle  | 1           |
| Ireland       | Backpack      | 1           |
| Ireland       | Coffee Mug    | 1           |
| Norway        | Laptop Sleeve | 1           |
| Norway        | Water Bottle  | 1           |
| Switzerland   | Backpack      | 1           |
| Switzerland   | Water Bottle  | 1           |
| United States | Water Bottle  | 2           |

</div>

</details>

> You can find the exact output by looking at the final model in `models/example/solution.sql`

---

## Notes

* All code and configuration is contained within the dbt project
* No manual SQL writing is necessary beyond the included models
* The Docker container encapsulates everything needed to run this project, avoiding environment issues

---

## Questions or Issues?

Please feel free to open an issue or contact the repo owner.