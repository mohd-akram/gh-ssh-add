# gh-ssh-add

A wrapper around `ssh-add` to manage GitHub [deploy
keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/managing-deploy-keys)
and add them to a separate SSH agent for use on remote servers.

## Install

Run `make install` to install `gh-ssh-add` to `/usr/local/bin` or simply copy
the file to your desired directory.

## Requirements

- [GitHub CLI](https://cli.github.com)
- OpenSSH

## Usage

```
usage: gh-ssh-add [-d] [repo]
       gh-ssh-add -l
       gh-ssh-add -D
```

### Adding a key

To add an SSH key to the agent, run `gh-ssh-add` in that repository's
directory. You can also add a key for another repository via `gh-ssh-add
owner/repo`.

`gh-ssh-add` looks for a key at `~/.ssh/github/$owner/$repo`. If it does not
exist, one will be created using `ssh-keygen`.

If the local key isn't listed in the repository's deploy keys, it will be added
to the list using the GitHub API (via `gh`).

### Removing a key

To remove a key from the agent, pass the `-d` flag. To remove all keys, pass
`-D`. This does not remove keys from the repository's list of deploy keys; you
can do so using the GitHub API via `gh repo deploy-key delete` or from the
repository's settings on the GitHub website. You can list the current deploy
keys via `gh repo deploy-key list`.

### Using the agent

`gh-ssh-add` creates a separate agent for better access control, and to allow
you to forward it only to the hosts that you need access to your GitHub SSH
keys on.

To use it, simply add `ForwardAgent ~/.ssh/github.com/.agent` to the host's
configuration in `~/.ssh/config`. For one-off use, pass the
`-oForwardAgent=~/.ssh/github.com/.agent` option to the `ssh` command.
