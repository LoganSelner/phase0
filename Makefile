POETRY ?= poetry
PYTEST  ?= $(POETRY) run pytest
BLACK   ?= $(POETRY) run black
RUFF    ?= $(POETRY) run ruff
ISORT   ?= $(POETRY) run isort

.PHONY: setup fmt lint test coverage build run clean

setup:
	$(POETRY) install --with dev
	pre-commit install

fmt:
	$(BLACK) .
	$(ISORT) .

lint:
	$(RUFF) check .

test:
	$(PYTEST) -q

coverage:
	$(PYTEST) --cov=src --cov-report=term-missing

build:
	docker build -t phase0:latest .

run:
	docker run --rm phase0:latest

clean:
	rm -rf .pytest_cache .ruff_cache .mypy_cache
