<div align="center">
    <img src="upboard.png" width="350px">
    <h1>UpBoard</h1>
    <p><i>A Simple status page for your silent servers</i></p>
</div>

---

## Installation

1. Clone or download the UpBoard repository.
2. Open a terminal in the repository directory.
3. Run the installer script:

```bash
./install.sh
```
4. The script will detect the current path and ask you to confirm it. If the path is incorrect, cancel and run the script from the correct repository directory.
5. The script will:
- Copy config/config.yml to the repository root.
- Copy service/start.sh to the repository root and make it executable.
- Copy and process service/upboard.service into /etc/systemd/system/ and replace {upboard_path} with the actual repository path.
6. Enable and start the systemd service:
- `sudo systemctl daemon-reload`
- `sudo systemctl enable upboard.service`
- `sudo systemctl start upboard.service`

Your UpBoard server should now be running at `http://0.0.0.0:8284`.

---

## Uninstall

To remove UpBoard completely:
```bash
./install.sh -R
```
or
```bash
./install.sh --remove
```

This will:
1. Stop and disable the systemd service.
2. Remove upboard.service from /etc/systemd/system/.
3. Remove start.sh from the repository root.

---

## Configuration

All configurable options are in config/config.yml.

### Server Info:
```yaml
server:
  name: UpBoard Server
  icon: /static/logo.svg # Put custom files in ./static or use external url.
```

### Custom Checks:
You can define services to be monitored. For this you must define a command that outputs true if the service is healthy or false if it is down. Example:

```yaml
checks:
  - name: SSH Service
    type: bool_command
    command: ["bash", "-c", "systemctl is-active ssh | grep -q active && echo true || echo false"]
```
