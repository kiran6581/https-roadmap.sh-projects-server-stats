#!/bin/bash

echo "=========================="
echo "📊 Server Performance Stats"
echo "=========================="

# CPU Usage
echo ""
echo "===== 🖥️ CPU Usage ====="
if command -v top &> /dev/null; then
    top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'
else
    echo "Command 'top' not found"
fi

# Memory Usage
echo ""
echo "===== 🧠 Memory Usage ====="
if command -v free &> /dev/null; then
    free -m | awk 'NR==2{printf "Used: %sMB | Free: %sMB | Usage: %.2f%%\n", $3, $4, $3*100/$2 }'
else
    echo "Command 'free' not found"
fi

# Disk Usage
echo ""
echo "===== 💾 Disk Usage ====="
if command -v df &> /dev/null; then
    df -h --total | grep total | awk '{print "Used: "$3 " | Free: "$4 " | Usage: "$5}'
else
    echo "Command 'df' not found"
fi

# Top 5 Processes by CPU Usage
echo ""
echo "===== 🔝 Top 5 Processes by CPU Usage ====="
if command -v ps &> /dev/null; then
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
else
    echo "Command 'ps' not found"
fi

# Top 5 Processes by Memory Usage
echo ""
echo "===== 🔝 Top 5 Processes by Memory Usage ====="
if command -v ps &> /dev/null; then
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
else
    echo "Command 'ps' not found"
fi

# OS Version
echo ""
echo "===== 🧾 OS Version ====="
if [ -f /etc/os-release ]; then
    grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"'
else
    echo "OS version info not found"
fi

# Uptime
echo ""
echo "===== ⏱️ Uptime ====="
if command -v uptime &> /dev/null; then
    uptime -p
else
    echo "Command 'uptime' not found"
fi

# Load Average
echo ""
echo "===== 📈 Load Average ====="
if command -v uptime &> /dev/null; then
    uptime | awk -F'load average:' '{ print "Load Average:" $2 }'
else
    echo "Command 'uptime' not found"
fi

# Logged In Users
echo ""
echo "===== 👥 Logged In Users ====="
if command -v who &> /dev/null; then
    who
else
    echo "Command 'who' not found"
fi

# Failed Login Attempts
echo ""
echo "===== ❌ Failed Login Attempts ====="
if command -v lastb &> /dev/null; then
    sudo lastb | head -n 5
else
    echo "Command 'lastb' not found or permission denied"
fi

echo ""
echo "✅ Server stats collection complete."
