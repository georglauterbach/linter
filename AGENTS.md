# linter - Agent Guide

This project defines a container image & GitHub Action that you can use to run multiple linters.

The container image is defined in [`Dockerfile`](./Dockerfile). It aims at being small and it does not contain programming-language-specific linters except for ShellCheck.

## Associated Projects

1. [`github.com/georglauterbach/hermes`](https://github.com/georglauterbach/hermes): Like desktop, but for the command line
2. [`github.com/georglauterbach/desktop`](https://github.com/georglauterbach/desktop): Like hermes, but for the GUI
2. [`github.com/georglauterbach/evergruv`](https://github.com/georglauterbach/evergruv): My color scheme for everything

## Repository Layout

| Path             | Purpose                                                |
| :--------------- | :----------------------------------------------------- |
| `.github/`       | GitHub-related content like CI/CD, issues, etc.        |
| `configuration/` | default configurations for all linters in this project |

## Linters

Read through this repository's [`README.md`](./README.md) to find a description of all linters this project employs.
