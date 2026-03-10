#!/bin/bash

# =====================================
# Infrastructure Health Check Script
# Author: Lalit Kumar
# =====================================

echo "========================================="
echo "      INFRASTRUCTURE HEALTH REPORT"
echo "========================================="

echo ""
echo "Server: $(hostname)"
echo "Date: $(date)"
echo ""

# -----------------------------
# CPU Usage
# -----------------------------

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

echo "CPU Usage: $CPU_USAGE %"

if (( $(echo "$CPU_USAGE > 80" | bc -l) )); then
    echo "WARNING: High CPU Usage"
fi

echo ""

# -----------------------------
# Memory Usage
# -----------------------------

echo "Memory Usage:"
free -h

MEMORY_USAGE=$(free | awk '/Mem:/ {printf("%.2f"), $3/$2 * 100}')

echo "RAM Utilization: $MEMORY_USAGE %"

echo ""

# -----------------------------
# Disk Usage
# -----------------------------

echo "Disk Usage (Root Partition):"

DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

echo "Root Partition Usage: $DISK_USAGE %"

if [ "$DISK_USAGE" -gt 80 ]; then
    echo "WARNING: Disk usage above 80%"
fi

echo ""

# -----------------------------
# System Load
# -----------------------------

echo "System Load Average:"
uptime

echo ""

# -----------------------------
# System Uptime
# -----------------------------

echo "Server Uptime:"
uptime -p

echo ""

# -----------------------------
# SSH Service Check
# -----------------------------

echo "Checking SSH Service..."

if systemctl is-active --quiet ssh; then
    echo "SSH Service: RUNNING"
else
    echo "SSH Service: DOWN"
fi

echo ""

# -----------------------------
# HTTP Service Check
# -----------------------------

echo "Checking HTTP Service..."

if systemctl is-active --quiet nginx; then
    echo "Nginx Service: RUNNING"
else
    echo "Nginx Service: DOWN"
fi

echo ""

# -----------------------------
# Internet Connectivity
# -----------------------------

echo "Checking Internet Connectivity..."

if ping -c 2 google.com > /dev/null 2>&1; then
    echo "Internet: CONNECTED"
else
    echo "Internet: NOT REACHABLE"
fi

echo ""

# -----------------------------
# Top Memory Processes
# -----------------------------

echo "Top 5 Memory Consuming Processes:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

echo ""

# -----------------------------
# Docker Status
# -----------------------------

if command -v docker &> /dev/null
then
    echo "Docker Status:"
    docker ps --format "table {{.Names}}\t{{.Status}}"
else
    echo "Docker not installed"
fi

echo ""

echo "========================================="
echo "      HEALTH CHECK COMPLETED"
echo "========================================="
