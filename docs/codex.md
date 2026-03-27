# OpenAI Codex

## Background

[OpenAI Codex](https://developers.openai.com/codex/overview) is a coding agent that can 
work inside your editor or terminal. On an HPC system such as Biowulf, Codex is useful 
for exploring a repository, drafting scripts, debugging, writing documentation, 
and helping build reproducible workflows.

## Installation

For NIH HPC users, installing Codex in a dedicated Conda environment makes 
upgrades, troubleshooting, and removal much simpler than mixing it into an analysis 
environment.

On Biowulf, first make sure Conda or Mamba is available in your shell. If you
have not already configured it, see the [Anaconda](anaconda.md) page for the
local setup pattern.

Once Conda is active, create and activate a small environment for Codex:

```bash
# Log in to Helix. It's faster to install packages via Conda on Helix than on Biowulf.
(base) [USER@helix]$ conda create -n codex nodejs -y
(base) [USER@helix]$ conda activate codex
```

This installs Codex and Node.js inside an isolated environment named `codex`. 
Then verify that the command is available:

```bash
(codex) [USER@helix]$ codex --help
```

Repeat the same installation steps on your local computer.

```bash
[desktop:~]$ conda create -n codex nodejs -y
[desktop:~]$ conda activate codex
```

If you use [VSCode](vscode.md) rather than the terminal, install the Codex
extension in both your local VSCode and the VSCode app offered through
[HPC OnDemand (login required)](https://hpcondemand.nih.gov/).

![codex extension vscode](images/codex_extension.png)

At this point, Codex should be installed on both your local computer and
Biowulf.

## Authentication

OpenAI provides several [workarounds](https://developers.openai.com/codex/auth#login-on-headless-devices)
for HPC users. A practical approach is to authenticate on your local computer
and then copy the credentials to Biowulf.

### Local Computer

Make sure **the Conda environment where Codex is installed is activated**, then run
the following command:

```bash
(codex) [desktop:~]$ codex login
```

This command will direct you to the login page shown below:

![codex login page](images/codex_login.png)

Continue through the authentication steps until you see the following page:

![codex signed in](images/codex_signedin.png)

After a successful login, an `auth.json` file is created in the `~/.codex` folder.

```bash
(codex) [desktop:~]$ ls ~/.codex | grep auth
auth.json
```

Treat `~/.codex/auth.json` like a password. **Do not share it with anyone or post
it publicly.**

If you plan to use Codex on Biowulf, copy the credentials over SSH:

```bash
(codex) [desktop:~]$ scp ~/.codex/auth.json <username>@helix.nih.gov:~/.codex/auth.json
```

### HPC

After you log in to Biowulf, confirm that the credentials were copied 
successfully:

```bash
[USER@biowulf]$ ls ~/.codex | grep auth
auth.json
```

If the file is missing, repeat the copy step from your local computer. 
If this authentication method keeps failing, review the additional
[workarounds](https://developers.openai.com/codex/auth#login-on-headless-devices)
suggested by OpenAI. If none of the approaches work, consult with HPC
(staff@hpc.nih.gov).

Once your `~/.codex/auth.json` file has been copied, you do not need 
to take any additional steps to authenticate on Biowulf. Proceed by allocating
an interactive node with a GPU.

```bash
[USER@biowulf]$ sinteractive --cpus-per-task=2 --mem=10g --gres=lscratch:5,gpu:v100x:1
```

Call the `freen` command if you need more information about resource (node) 
availability on Biowulf. Refer to the 
[Biowulf Cheat Sheet](https://hpc.nih.gov/docs/biowulf-cheat-sheet.pdf) for detailed
information about parameter settings.

In practice, you should start Codex from the directory you want to limit Codex's access.
That usually means a directory tree that is safe for Codex to inspect and modify.
Avoid launching it from a broad or sensitive location unless you intend to give it 
access to those files and you accept unintended changes to your files.


```bash
[USER@cn0001]$ cd /<path>/<lab>/<project>
[USER@cn0001] /<path>/<lab>/<project>$ codex
[USER@cn0001] /<path>/<lab>/<project>$ conda activate codex
```
