![CI](https://github.com/LoganSelner/phase0-v2/actions/workflows/ci.yml/badge.svg)

# FastAPI + uv template

A minimal, modern FastAPI starter that uses **[uv](https://github.com/astral-sh/uv)** for dependency and virtualenv management, **pre-commit** for quality gates, and a clean `src/` layout. Ships with a Dockerfile and a small health-check route.

---

## Features

* ⚡ **FastAPI** app at `src/app/main.py` with a `/health` endpoint
* 🧪 **Tests** via `pytest` (see `tests/test_app.py`)
* 🧰 **uv** for fast, reproducible installs (`pyproject.toml` + `uv.lock`)
* 🧹 **pre-commit** hooks: ruff, black, and more
* 🐳 **Dockerfile** for production-like images (multi-stage, small runtime)
* 🗂️ `src/` layout with `app` package (`app.main:app`)

---

## Prerequisites

* **Python 3.13** (a `.python-version` file is included if you use pyenv)
* **uv** (recommended). Install options:

  * macOS/Linux: `curl -LsSf https://astral.sh/uv/install.sh | sh`
  * Windows (PowerShell): `irm https://astral.sh/uv/install.ps1 | iex`

> Don’t want uv? You can use `pip`/`venv`, but this repo assumes uv for commands and Docker.

---

## Quickstart (local dev)

```bash
make bootstrap
make dev
# http://localhost:8000
# Visit: http://localhost:8000/health
# Docs:  http://localhost:8000/docs  (Swagger UI)
#        http://localhost:8000/redoc
```

### One-liners you’ll use a lot

```bash
# Run tests
uv run pytest -q

# Type-check
uv run mypy

# Lint + format (non-destructive checks)
uv run ruff check . && uv run black --check .

# Apply fixes (imports -> ruff, then black)
uv run ruff check --fix . && uv run black .

```

---

## Makefile shortcuts

Run `make help` to see everything. Common targets:

| Target                | What it does                                             |
| --------------------- | -------------------------------------------------------- |
| `make bootstrap`      | Install Python (if needed), sync deps, install git hooks |
| `make update`         | Upgrade locked package versions (respecting constraints) |
| `make env`            | Print tool versions                                      |
| `make dev`            | Start FastAPI with auto-reload                           |
| `make serve`          | Start FastAPI like prod (no reload)                      |
| `make test`           | Run pytest                                               |
| `make fmt`            | Apply formatting fixes (ruff imports → black)            |
| `make fmt-check`      | Non-mutating QA check for CI/local                       |
| `make lint`           | Ruff lint                                                |
| `make typecheck`      | Mypy                                                     |
| `make qa`             | Full quality gate (lint+format+types+tests)              |
| `make docker-build`   | Build Docker image (cached)                              |
| `make docker-rebuild` | Build without cache                                      |
| `make docker-run`     | Run in foreground (maps port 8000)                       |
| `make docker-run-d`   | Run detached                                             |
| `make docker-stop`    | Stop detached container                                  |
| `make docker-logs`    | Follow logs                                              |
| `make docker-shell`   | Shell into the image                                     |
| `make clean`          | Remove caches                                            |
| `make deep-clean`     | Also remove build artifacts                              |

> If a target isn’t available on your machine, run `make help` to confirm the list and descriptions.

---

## Rename this template

Prefer simple search/replace? Do this once and you’re done:

1. pyproject.toml → in [project], change name = "phase0-v2" to your project name.

2. README.md → replace the few occurrences of phase0-v2 in examples.

3. Makefile → if it mentions phase0-v2, replace those occurrences too.

---

## Docker

Build a compact image with a prebuilt virtualenv and run it:

```bash
# Build
make docker-build

# Run
make docker-run
# App will listen on 0.0.0.0:8000 → http://localhost:8000
```

The image’s default command is:

```
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

---

## Project layout

```
.
├── Dockerfile
├── Makefile
├── README.md
├── pyproject.toml
├── src
│   └── app
│       ├── __init__.py
│       └── main.py
├── tests
│   └── test_app.py
└── uv.lock
```

* **App entrypoint**: `app.main:app`
* **Health check**: `GET /health` → `{ "ok": true }`

---

## pre-commit (quality gates)

This repo is configured to run a suite of checks (ruff, black, etc.).

* Run once on all files:

  ```bash
  uv run pre-commit run --all-files
  ```
* Install into your git hooks (so it runs automatically on commit):

  ```bash
  uv run pre-commit install
  ```


---

## Running without uv (optional)

If you must use `pip`:

```bash
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -U pip wheel
pip install -e .[dev]       # if you expose dev deps, or install individually
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

---

## Troubleshooting

* **Port already in use**

  * Change `--port` or stop the other process.
* **Python version mismatch**

  * This project targets **Python 3.13**. If you’re on another version, use pyenv or update your interpreter.
