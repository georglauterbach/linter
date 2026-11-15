# linter - Agent Guide

A container image & GitHub Action that you can use to run multiple linters.

The container image is defined in [`Dockerfile`](./Dockerfile). It aims at being small and it does not contain programming-language-specific linters except for ShellCheck.

## Repository Layout

|Path|Purpose|
|:-|:-|
|`.github/`|GitHub-related content like CI/CD, issues, etc.|
|`CHANGELOG.md`|Keep a Changelog history|
|`cspell.config.yaml`|Spell-check configuration|
|`README.md`|Project description|

## Linters

Read through this repository's [`README.md`](./README.md) to find a description of all linters this project employs.
