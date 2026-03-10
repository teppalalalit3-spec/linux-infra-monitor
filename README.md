# Linux Infrastructure Health Monitor

A lightweight Bash-based monitoring system for Linux servers.

## Features

- CPU usage monitoring
- Memory usage monitoring
- Disk usage monitoring
- System uptime tracking
- Service health checks (SSH, Nginx)
- Docker container monitoring
- Automated reporting

## Automation

Scripts can be scheduled using cron for periodic monitoring.

Example:

*/5 * * * * scripts/infra_health_check.sh

0 * * * * scripts/infra_email_report.sh

## Requirements

Linux (Ubuntu recommended)

mailutils (for email reports)

Docker (optional for container monitoring)

## Usage

Make script executable:

chmod +x scripts/*.sh

Run manually:

./scripts/infra_health_check.sh
