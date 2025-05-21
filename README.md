# Stealth Domain Scanner

This script performs a **stealthy TCP + UDP port scan** on a list of domain names. It is designed to avoid triggering WAFs and rate-limiting defenses while collecting meaningful service/banner information.

---

## 🛡 Features

- Resolves domains to IPv4 addresses.
- Scans **all TCP ports** and top 100 **UDP ports**.
- Performs **banner grabbing** and **default Nmap scripting**.
- Uses **stealthy scan settings** (`-T2`, `-sS`, randomized host order).
- Outputs results in Nmap’s 3 standard formats for compatibility.

---

## 📂 Input

A file called `targets.txt`, containing one domain per line:

```
example.com
api.example.com
```

---

## 📤 Output

Three files with scan results:
- `stealth_scan.nmap` – normal human-readable output
- `stealth_scan.gnmap` – grepable output
- `stealth_scan.xml` – XML (for tools like Metasploit, Burp, Dradis, etc.)

---

## 🚀 Usage

1. Place your domains in `targets.txt`.
2. Run the script:

```bash
chmod +x resolve_and_stealth_scan.sh
./resolve_and_stealth_scan.sh
```

---

## ⚙ Scan Options Used

- `-Pn` – no ping (assumes hosts are up)
- `-n` – no DNS resolution during scan (uses resolved IPs)
- `-sS` – stealthy SYN scan
- `-sU --top-ports 100` – top 100 UDP ports
- `-sV` – banner grabbing / version detection
- `--script=default` – safe Nmap scripts
- `-T2` – slower, stealthy timing
- `--randomize-hosts` – prevents scan pattern detection
- `--defeat-rst-ratelimit` – evades some firewall throttling

---

## 🔒 Disclaimer

Use only on systems and domains you have **explicit permission** to scan.
