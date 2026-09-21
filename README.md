# packet 📦

Package files and mirror Docker images to GHCR — just open an issue.

## Features

### 📦 Package files from URLs

1. Open an issue → **Package Request**
2. Fill in one or more **Download URLs** (one per line), optional **tag** and **SHA256 checksums**
3. All files are downloaded, verified, packaged into a minimal `scratch` Docker image (`/file/...`), and pushed to GHCR

### 🪞 Mirror a Docker image

1. Open an issue → **Mirror Request**
2. Fill in the **Source image** (e.g., `postgres:18.6`)
3. The image is mirrored to GHCR with **all architectures preserved**

Both templates will comment back on the issue with the `docker pull` command when done.

## Issue Templates

**Package Request:**

| Field                | Required | Description                                                   |
| -------------------- | -------- | ------------------------------------------------------------- |
| **Download URLs**    | ✅       | One or more HTTP(S) URLs (one per line)                       |
| **Image tag**        | ❌       | Custom tag (defaults to issue number)                         |
| **SHA256 checksums** | ❌       | Expected hashes (one per line or standard `sha256sum` format) |

**Mirror Request:**

| Field            | Required | Description                                                      |
| ---------------- | -------- | ---------------------------------------------------------------- |
| **Source image** | ✅       | Image reference (e.g., `postgres:18.6`, `ghcr.io/org/image:tag`) |
| **Image tag**    | ❌       | Custom tag (defaults to sanitized source, e.g., `postgres-18.6`) |

## Status Labels

| Label             | Meaning                                    |
| ----------------- | ------------------------------------------ |
| `package-request` | File packaging request                     |
| `mirror-request`  | Image mirror request                       |
| `processing`      | Workflow is running                        |
| `published`       | Image successfully pushed to GHCR          |
| `failed`          | Something went wrong (check workflow logs) |

## Image Details

**Packaged files:**

| Property   | Value                                       |
| ---------- | ------------------------------------------- |
| Base image | `scratch` (empty, ~0 bytes overhead)        |
| File path  | `/file/<original-filename>`                 |
| Platforms  | `linux/amd64`, `linux/arm64`                |
| Tag        | `ghcr.io/<owner>/packet:<tag-or-issue-num>` |

**Mirrored images:** Saved as OCI archives inside `scratch` at `/file/<tag>.tar` with multi-arch support.

## Extracting Files

### Extract packaged file

```bash
docker create --name tmp ghcr.io/<owner>/packet:42
docker cp tmp:/file/ ./output/
docker rm tmp
```

### Extract and load mirrored image

```bash
docker create --name tmp ghcr.io/<owner>/packet:postgres-18.6
docker cp tmp:/file/postgres-18.6.tar .
docker rm tmp
docker load < postgres-18.6.tar
```

## Setup

1. Create a repository from this template (or fork it)
2. Go to **Settings → Actions → General → Workflow permissions** and select **Read and write permissions**
3. Create the labels: `package-request`, `mirror-request`, `processing`, `published`, `failed`
4. Open an issue — the action handles the rest!

## License

MIT
