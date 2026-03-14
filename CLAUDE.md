# Lightpanda Homebrew Tap

Homebrew tap for the [Lightpanda browser](https://github.com/lightpanda-io/browser).

## Structure

- `Formula/lightpanda.rb` — stable Homebrew formula
- `Formula/lightpanda-nightly.rb` — nightly Homebrew formula
- `update.sh` — local script to update both formulas to their latest versions
- `.github/workflows/update-stable.yml` — GitHub Actions workflow to update the stable formula (manual trigger)
- `.github/workflows/update-nightly.yml` — GitHub Actions workflow to update the nightly formula (automatic daily + manual trigger)

## Formulas

Both formulas install pre-built binaries from the Lightpanda GitHub releases:
- `lightpanda-aarch64-macos` for Apple Silicon
- `lightpanda-x86_64-macos` for Intel

The binary is installed as `lightpanda` in the Homebrew bin directory. The two formulas conflict and cannot be installed at the same time.

| Formula | Install command | Version |
|---|---|---|
| `lightpanda` | `brew install lightpanda-io/lightpanda` | Latest stable release |
| `lightpanda-nightly` | `brew install lightpanda-io/lightpanda/lightpanda-nightly` | Nightly build (versioned by publish date) |

## Updating the formulas

Run `./update.sh` locally to update both formulas at once. It will:
1. Fetch the latest stable version from the GitHub API
2. Fetch the nightly release date from the GitHub API
3. Skip each formula if already up to date
4. Download both binaries, compute SHA256 checksums, and patch the formula

Or trigger the GitHub Actions workflows manually from the GitHub Actions UI. The nightly workflow also runs automatically every day at 2:10 AM UTC.

Both workflows open a pull request and merge it automatically if all checks pass. This requires **"Allow auto-merge"** to be enabled in the repo settings (Settings → General → Allow auto-merge).

## Auditing

To verify a formula passes Homebrew's strict linting rules before submitting to homebrew-core:

```sh
brew tap local/lightpanda
cp Formula/lightpanda.rb $(brew --repository)/Library/Taps/local/homebrew-lightpanda/Formula/lightpanda.rb
brew audit --strict --formula local/lightpanda/lightpanda
brew untap local/lightpanda
```

## Path to homebrew-core

To allow `brew install lightpanda`, the stable formula can be submitted to homebrew-core:
- The formula already passes `brew audit --strict`
- Ensure the project has stable versioned releases and an open-source license
- Follow the [Homebrew contribution guide](https://docs.brew.sh/How-To-Open-a-Homebrew-Pull-Request)
