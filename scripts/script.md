# Download Script

A quick way to pull only the `.claude/` skills folder from this repository into your project.

## What gets downloaded

```
.claude/
└── skills/
    ├── code-review/SKILL.md
    ├── create-automation/SKILL.md
    ├── implement/SKILL.md
    ├── plan-fix/SKILL.md
    ├── reproduce/SKILL.md
    ├── review-plan/SKILL.md
    └── send-pr/SKILL.md
```

## Prerequisites

One of the following must be installed:

- **git** (preferred — uses sparse checkout, only fetches the `.claude` folder)
- **curl** + **tar** (fallback)
- **wget** + **tar** (fallback)

## Usage

```bash
# Download the script
curl -O https://raw.githubusercontent.com/Tharsanan1/wso2-se-agent-skills/main/script.sh

# Make it executable
chmod +x script.sh

# Run — downloads .claude/ into the current directory
bash script.sh

# Or specify a target directory
bash script.sh /path/to/your/project
```

## How it works

1. Checks for available download tools (`git` → `curl` → `wget`) in priority order.
2. Uses **git sparse checkout** (if git is available) to fetch only the `.claude/` directory without cloning the full repo.
3. Falls back to downloading the tarball and extracting just the `.claude/` path.
4. Places the `.claude/` folder in your target directory (defaults to `.`).
