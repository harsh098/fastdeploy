## Install for production
install:
	python -m pip install --upgrade pip
	python -m pip install -e .

## Install for development 
install-dev: install
	python -m pip install -e ".[dev]"

## Build dependencies
build: 
	pip-compile --resolver=backtracking --output-file=requirements.txt pyproject.toml
	pip-compile --resolver=backtracking --extra=dev --output-file=requirements-dev.txt pyproject.toml

## Run checks (ruff + test)
check:
	ruff check .
	isort --check .
	black --diff --check .

## Fix Formatting if any
fix:
	ruff check --fix .
	isort .
	black .