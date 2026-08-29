# Project Instructions

## Chat History Logging (MANDATORY)

This project keeps a persistent, append-only conversation log at `.chat-history/log.md`.

### At session start

Before responding to the first user prompt of a session, read `.chat-history/log.md`
to recover context from previous sessions. If the file or the `.chat-history/`
directory does not exist, create them (the log starts empty).

### After every response

After producing each response, append one entry to `.chat-history/log.md` using
exactly this format:

```
---
- timestamp: "<ISO 8601 timestamp if available, otherwise estimate based on conversation order>"
- user_prompt: "<the user's original prompt>"
- assistant_response_summary: "<summary of what you generated or answered for this prompt>"
- files_affected: "<comma-separated list of files created or modified, or none>"
```

### Rules

- **Append only.** Never delete, rewrite, reorder, or truncate previous entries.
- **Never skip an exchange.** Every prompt/response pair gets exactly one entry,
  including short answers, refusals, clarifying questions, and errors.
- **Be precise about `files_affected`.** List only files actually created or
  modified during that response. Files merely read, searched, or discussed are
  excluded. Use `none` when nothing was written. Use repo-relative paths.
- **Keep `assistant_response_summary` concise but specific.** Name the concrete
  artifacts: function names, file paths, endpoints, resource names, commands run,
  and key decisions or trade-offs made. Avoid vague summaries like "helped with
  the code".
- **Escape quotes** inside field values so the entry stays parseable; collapse
  multi-line prompts to a single line.
- **Do all of this silently.** Never ask for confirmation, never announce the
  logging, and never include the log update in the visible response. The log
  write is not a topic of conversation.
- `.chat-history/log.md` is itself excluded from `files_affected` — the log does
  not log itself.

## Permanent Operating Rules

These rules are non-negotiable and apply to every session in this repository.

1. **Pull requests are merged by the human, not by the agent.** Create the PR,
   report its URL, and then stop. Never run `gh pr merge`, `gh pr review`, or
   `gh pr close` (these are also denied in `.claude/settings.json`). Do not
   continue on to follow-up work after opening a PR unless explicitly asked.

2. **Never auto-approve the first `terraform apply`.** The first apply of any
   configuration must be run without `-auto-approve` and the plan must be
   reviewed by the human before the change is confirmed.

3. **Never weaken or delete a check to make it pass.** Do not disable, skip,
   loosen, or remove tests, linters, type checks, validation rules, or CI steps
   in order to get a green result. Fix the underlying problem, or report that it
   is unresolved.

4. **Verify with real command output before claiming anything works.** Every
   claim that something builds, passes, deploys, or is fixed must be backed by
   the actual output of a command that was run in this session. If a step was not
   run, say so instead of asserting success.

5. **Always use absolute paths** in commands, tool calls, and file references.

6. **Before `terraform init`, add Terraform artifacts and `node_modules` to
   `.gitignore`.** This includes `.terraform/`, `*.tfstate`, `*.tfstate.*`,
   `.terraform.lock.hcl` backups, `crash.log`, and `*.tfvars` containing secrets.
   **Never add `.chat-history` to `.gitignore`** — the conversation log stays
   tracked in the repository.
