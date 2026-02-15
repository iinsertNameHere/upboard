import yaml
import os
import subprocess

class Config:
    def __init__(self, path: str) -> None:
        if not os.path.exists(path):
            raise ValueError(f"{path} - Path dose not exist!")

        self.path = path
        self.raw: dict
        self.server_name = "UpBoard Server"
        self.server_icon = "/static/logo.svg"
        self.checks: list

    def load(self) -> None:
        # Load YAML
        with open(self.path, 'r') as file:
            self.raw = yaml.safe_load(file)

        # Server info
        server = self.raw.get("server", {})
        self.server_name = server.get("name", "UpBoard Server")
        self.server_icon = server.get("icon", "/static/logo.svg")

        # Load checks
        self.checks = self.raw.get("checks", [])

        # Validate checks
        for idx, check in enumerate(self.checks):
            if "name" not in check or not isinstance(check["name"], str):
                raise ValueError(f"Check at index {idx} missing 'name' or it's not a string")

            if "command" not in check or not isinstance(check["command"], list) or not all(isinstance(c, str) for c in check["command"]):
                raise ValueError(f"Check '{check['name']}' must have a 'command' as a list of strings")


    def run_checks(self):
        results = []

        for check in self.checks:
            status = False
            output = ""

            try:
                result = subprocess.run(
                    check["command"],
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                    timeout=5
                )

                output = result.stdout.decode().strip().lower()

                if output == "true":
                    status = True
                elif output == "false":
                    status = False
                else:
                    status = False
                    output = f"Invalid output: {output}"

            except Exception as e:
                status = False
                output = str(e)

            results.append({
                "name": check["name"],
                "status": status,
                "output": output if output not in ["true", "false"] else None
            })

        return results
