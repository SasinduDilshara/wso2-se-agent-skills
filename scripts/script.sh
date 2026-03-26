#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────
# download-skills.sh
# Downloads only the .claude/ skills folder from the
# wso2-se-agent-skills repo into the current working directory.
# Usage:  bash script.sh [target-directory]
# ──────────────────────────────────────────────────────────────

set -euo pipefail

REPO="Tharsanan1/wso2-se-agent-skills"
BRANCH="main"
TARGET_DIR="${1:-.}"

echo "⏳ Downloading .claude skills into: ${TARGET_DIR}"
mkdir -p "${TARGET_DIR}"

# ── Method 1: git sparse checkout (preferred) ────────────────
if command -v git &>/dev/null; then
    echo "📦 Using git sparse checkout..."
    TEMP_DIR=$(mktemp -d)
    git clone --depth 1 --filter=blob:none --sparse \
        "https://github.com/${REPO}.git" "${TEMP_DIR}/repo" 2>&1
    cd "${TEMP_DIR}/repo"
    git sparse-checkout set .claude
    cp -r .claude "${TARGET_DIR}/.claude"
    rm -rf "${TEMP_DIR}"
    echo "✅ Done! Skills downloaded to: ${TARGET_DIR}/.claude"

# ── Method 2: curl + tar with path filter ─────────────────────
elif command -v curl &>/dev/null; then
    echo "📦 git not found — falling back to curl..."
    curl -sL "https://github.com/${REPO}/archive/refs/heads/${BRANCH}.tar.gz" \
        | tar -xz --strip-components=1 -C "${TARGET_DIR}" \
              "wso2-se-agent-skills-${BRANCH}/.claude"
    echo "✅ Done! Skills downloaded to: ${TARGET_DIR}/.claude"

# ── Method 3: wget + tar with path filter ─────────────────────
elif command -v wget &>/dev/null; then
    echo "📦 git not found — falling back to wget..."
    wget -qO- "https://github.com/${REPO}/archive/refs/heads/${BRANCH}.tar.gz" \
        | tar -xz --strip-components=1 -C "${TARGET_DIR}" \
              "wso2-se-agent-skills-${BRANCH}/.claude"
    echo "✅ Done! Skills downloaded to: ${TARGET_DIR}/.claude"

else
    echo "❌ Error: git, curl, or wget is required but none were found."
    exit 1
fi
