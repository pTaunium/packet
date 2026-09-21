# packet 📦

Turn any URL into a minimal Docker image on GHCR — just open an issue.

## How It Works

1. **Open an issue** using the "Package Request" template
2. Fill in the **Download URL** (and an optional custom tag)
3. **GitHub Actions** downloads the file, packages it into a `scratch` Docker image, and pushes to GHCR
4. The bot **comments back** on the issue with the `docker pull` command

## Issue Template

When you click "New Issue", you'll see a form:

| Field            | Required | Description                            |
| ---------------- | -------- | -------------------------------------- |
| **Download URL** | ✅       | The HTTP(S) URL of the file to package |
| **Image tag**    | ❌       | Custom tag (defaults to issue number)  |

## Status Labels

| Label             | Meaning                                    |
| ----------------- | ------------------------------------------ |
| `package-request` | Submitted, waiting for processing          |
| `processing`      | Workflow is running                        |
| `published`       | Image successfully pushed to GHCR          |
| `failed`          | Something went wrong (check workflow logs) |

## Image Details

| Property   | Value                                       |
| ---------- | ------------------------------------------- |
| Base image | `scratch` (empty, ~0 bytes overhead)        |
| File path  | `/file/<original-filename>`                 |
| Entrypoint | None                                        |
| Tag        | `ghcr.io/<owner>/packet:<tag-or-issue-num>` |

## Extracting Files

Since the image has no shell, extract files with:

```bash
# Copy from the image
docker create --name tmp ghcr.io/<owner>/packet:42
docker cp tmp:/file/ ./output/
docker rm tmp
```

## Setup

1. Create a repository from this template (or fork it)
2. Go to **Settings → Actions → General → Workflow permissions** and select **Read and write permissions**
3. Create the labels: `package-request`, `processing`, `published`, `failed`
4. Open an issue — the action handles the rest!

## Limitations

- **Single URL**: Each issue packages one file.
- **No entrypoint**: The image is a file container only — use `docker cp` to extract files.

## License

MIT
