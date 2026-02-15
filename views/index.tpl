<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="icon" type="image/x-icon" href="/static/favicon.ico" />
        <title>UpBoard - {{server_name}}</title>

        <link
            href="https://fonts.googleapis.com/css2?family=Inter:ital,wght@0,400;1,300&display=swap"
            rel="stylesheet"
        />

        <style>
            :root {
                --bg: #282828;
                --bg-soft: #32302f;
                --fg: #ebdbb2;
                --fg-muted: #a89984;
                --green: #b8bb26;
                --red: #fb4934;
                --border: #3c3836;
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: "Inter", sans-serif;
            }
            body {
                background-color: var(--bg);
                color: var(--fg);
                height: 100vh;
                display: flex;
                flex-direction: column;
            }

            .topbar {
                height: 70px;
                background-color: var(--bg-soft);
                border-bottom: 1px solid var(--border);
                position: relative;
                display: flex;
                align-items: center;
                padding: 0 24px;
            }
            .brand {
                display: flex;
                align-items: center;
                gap: 10px;
                font-style: italic;
                font-weight: 300;
            }
            .title {
                position: absolute;
                left: 50%;
                transform: translateX(-50%);
                font-weight: 400;
                letter-spacing: 1px;
            }
            .version {
                margin-left: auto;
                font-style: italic;
                font-weight: 300;
                color: var(--fg-muted);
            }

            .main {
                flex: 1;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 24px;
                gap: 20px;
            }

            .card {
                background-color: var(--bg-soft);
                border: 1px solid var(--border);
                border-radius: 12px;
                padding: 32px;
                width: 100%;
                max-width: 500px;
                text-align: center;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.4);
            }

            .card h2 {
                margin-bottom: 16px;
                font-weight: 400;
            }
            .status {
                margin-top: 12px;
                padding: 12px;
                border-radius: 8px;
                font-weight: 500;
            }

            .status.online {
                background-color: rgba(184, 187, 38, 0.15);
                border: 1px solid var(--green);
                color: var(--green);
            }
            .status.offline {
                background-color: rgba(251, 73, 52, 0.15);
                border: 1px solid var(--red);
                color: var(--red);
            }

            .server-icon {
                max-width: 200px;
                margin-bottom: 10px;
            }
            .check-output {
                margin-top: 6px;
                font-size: 0.9em;
                color: var(--fg-muted);
                word-break: break-word;
            }
        </style>
    </head>

    <body>
        <div class="topbar">
            <div class="brand">
                <img src="/static/logo.svg" height="45px" alt="Logo" />
                <span>UpBoard</span>
            </div>

            <div class="title">Server Status</div>

            <div class="version">v1.0.0</div>
        </div>

        <div class="main">
            <!-- Main Server Card -->
            <div class="card">
                <img class="server-icon" src="{{server_icon}}" />
                <h2>{{server_name}} Status</h2>
                <div class="status online">● Server is Online</div>
            </div>

            <!-- Dynamic Checks -->
            % for check in checks:
            <div class="card">
                <h2>{{check["name"]}}</h2>
                % if check["status"]:
                <div class="status online">● Online</div>
                % else:
                <div class="status offline">● Offline</div>
                % end
                % if check["output"]:
                <div class="check-output">{{check["output"]}}</div>
                % end
            </div>
            % end
        </div>
    </body>
</html>
