# Claude Container

Run [Claude Code](https://claude.com/claude-code) inside a Podman container. Your working directory is mounted at the same path inside the container, so Claude's project-keyed state (memory, history) stays consistent in and out of the container.

## Usage

```bash
claudec                 # run Claude Code in $PWD (builds the image first if needed)
claudec update          # force-rebuild the container image
claudec chat            # conversation-only, no files mounted, no memory
claudec chat <topic>    # conversation-only, memory persisted under ~/.local/share/claude-chats/<topic>/
```
