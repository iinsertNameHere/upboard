<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/x-icon" href="/static/favicon.ico">
        <title>UpBoard - 404</title>

        <link href="https://fonts.googleapis.com/css2?family=Inter:ital,wght@0,400;1,300&display=swap" rel="stylesheet">

        <style>
            :root {
            /* Gruvbox Dark Palette */
            --bg: #282828;
            --bg-soft: #32302f;
            --fg: #ebdbb2;
            --fg-muted: #a89984;
            --green: #b8bb26;
            --border: #3c3836;
            }

            * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
            }

            body {
            background-color: var(--bg);
            color: var(--fg);
            height: 100vh;
            display: flex;
            flex-direction: column;
            }

            /* Top Bar */
            .topbar {
              height: 70px;
              background-color: var(--bg-soft);
              border-bottom: 1px solid var(--border);
              position: relative;
              display: flex;
              align-items: center;
              padding: 0 24px;
            }

            /* Left */
            .brand {
              display: flex;
              align-items: center;
              gap: 10px;
              font-style: italic;
              font-weight: 300;
            }

            /* Perfect center */
            .title {
              position: absolute;
              left: 50%;
              transform: translateX(-50%);
              font-weight: 400;
              letter-spacing: 1px;
            }

            /* Right */
            .version {
              margin-left: auto;
              font-style: italic;
              font-weight: 300;
              color: var(--fg-muted);
            }

            /* Main Content */
            .main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
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
            margin-top: 20px;
            padding: 12px;
            border-radius: 8px;
            background-color: rgba(184, 187, 38, 0.15);
            border: 1px solid var(--green);
            color: var(--green);
            font-weight: 500;
            }
        </style>
    </head>

    <body>
        <div class="topbar">
            <div class="brand">
            <img src="/static/logo.svg" height="45px" alt="Logo">
            <span>UpBoard</span>
            </div>

            <div class="title">
                {{server_name}}
            </div>

            <div class="version">
            v1.0.0
            </div>
        </div>

        <div class="main">
        <div class="card">
            <h1>404</h1>
            <p>The page you are trying to access dose not exist!</p>
            </div>
        </div>
        </div>
    </body>
</html>
