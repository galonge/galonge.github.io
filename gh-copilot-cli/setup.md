
# Github Copilot CLI

## Description
A CLI experience for github copilot.

- To help you with remembering shell commands and flags for common tasks.
- Translates natural language to terminal commands.
- Provides contextual explanation on what the commands will do.
- Still in technical preview (expect glitches).
- Use revisions to fine tune the query to your needs 

## Waitlist
[Join the Copilot Waitlist](https://githubnext.com/projects/copilot-cli/)

## Requirement
- Need to have an active github copilot subscription.

## Before Copilot CLI
- Find info using `--help` flag.
- Linux man pages.
- Google search - stackoverflow.


## Modes of Interaction
- `??`: Goto for arbitrary shell commands.
- `git?`: More specifically for git invocations  or 
- `gh?`: Combines the `??` and `git?` commands in a single query interface.


## Requirements
- npm >= 16.0

# Installation

```sh

  # Install the Copilot CLI globally
  npm install -g @githubnext/github-copilot-cli
  
  # Authenticate with github
  github-copilot-cli auth

  # Setup alias convenience methods (??, git? and gh?)
  eval "$(github-copilot-cli alias -- "$0")"

  # Update your .zshrc or .bashrc file with the above to persist alias
```


## Examples 
```shell
  # ??
  ?? find all .txt files in this directory
  ?? create an empty node js project in this directory - revise: create in a directory called test.
  ?? create a file called sample.txt with the content 'Hello from the sample copilot test'

  # git?
  git? create a new branch called copilot-test. - revise: checkout from current branch
  git? how do i squash 5 commits into one
  git? how do i remove a committed file from git

  # gh?
  gh? create a new tag for my app
  gh? rebase the main branch of my current repo into this one

  git? rebase the main branch of my current repo into this one
  

```

## Limitations
- platforms support - bias towards zsh and linux shells for now.

## Recommendations
- Use for learning and getting used to linux commands.
- Don't run on your production / live systems yet - it may make mistakes.
- Don't use for sensitive/highly secure / private information

