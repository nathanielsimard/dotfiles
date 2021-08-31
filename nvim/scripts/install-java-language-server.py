import argparse
import os


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--java-path",
        help="Path the java binary.",
        type=str,
        default="/usr/bin/java",
    )
    parser.add_argument(
        "--java-home",
        help="Path to the java home used to build the language server.",
        type=str,
        required=False,
    )
    return parser.parse_args()


def exe(cmd, root="~/.local/share/java-language-server"):
    os.system(f"cd {root} && " + cmd)


def install_lsp(java_path):
    exe(
        "git clone https://github.com/georgewfraser/java-language-server",
        root="~/.local/share",
    )
    exe("git pull")
    exe("echo $JAVA_HOME")
    exe("mvn package -DskipTests")
    exe("mkdir -p dist/linux")
    exe("mkdir -p dist/linux/bin")
    exe(f"ln -s {java_path} dist/linux/bin/java")


def create_bin():
    executable = "#!/bin/sh"
    executable += "\ncd ~/.local/share/java-language-server/dist/"
    executable += "\n./lang_server_linux.sh"

    file_path = f"{os.environ['HOME']}/.local/bin/java-language-server"
    with open(file_path, "w") as file:
        file.write(executable)

    exe("chmod +x java-language-server", root="~/.local/bin")


def main():
    args = parse_args()

    if args.java_home is not None:
        os.environ["JAVA_HOME"] = args.java_home

    install_lsp(args.java_path)
    create_bin()


main()
