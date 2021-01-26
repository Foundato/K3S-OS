# Important tipps for developing on remote hosts

### Detatching build shell session to stay alive after ssh-session closes

If you have long running tasks on a remote host which should be running reguardless you are connected via ssh or not, `screen` comes in quite handy!

Following commands show how to start and detach a screen session and how to reatach after logging back in via ssh:

```bash
# Install screen
sudo apt-get install screen

# Start screen session
screen

# Detach screen session (Afterwards you can logout from the ssh-session)
Press Keys: Ctrl+A -> Ctrl+D

# Reatach screen session
screen -r
```
