from bottle import route, run, error, template, static_file, request
import subprocess
import config
import time

config = config.Config("./config.yml")

# Track last reload timestamp
_last_config_reload = 0
RELOAD_COOLDOWN = 300  # 5 minutes

# Track last checks run
_last_checks_run = 0
CHECKS_COOLDOWN = 180  # 3 minutes
_cached_checks = []


@route('/')
def index():
    global _last_config_reload, _last_checks_run, _cached_checks

    now = time.time()
    force_reload = 'reload_config' in request.query
    force_checks = 'run_checks' in request.query

    # Reload config only on cooldown or forced
    if force_reload or (now - _last_config_reload > RELOAD_COOLDOWN):
        config.load()
        _last_config_reload = now

    # Run checks only if cooldown passed or forced
    if force_checks or (now - _last_checks_run > CHECKS_COOLDOWN):
        _cached_checks = config.run_checks()
        _last_checks_run = now

    return template(
        "index",
        server_name=config.server_name,
        server_icon=config.server_icon,
        checks=_cached_checks
    )


@route('/static/<filepath:path>')
def serve_static(filepath):
    return static_file(filepath, root='./static')


@error(404)
def error404(error):
    return template("404", server_name=config.server_name)


if __name__ == '__main__':
    run(host='0.0.0.0', port=8284, reloader=True, debug=True)
