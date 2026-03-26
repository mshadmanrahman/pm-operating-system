# CI Failure Patterns

Known CI failure patterns and whether they are retryable. Used by the babysit-pr skill to decide when to auto-retry failed checks.

## Pattern Classification

Each pattern has:
- **Match**: how to identify the failure (check name, log snippet, or error message)
- **Retryable**: yes/no
- **Max retries**: how many times to retry before declaring a real failure
- **Wait before retry**: how long to wait before retrying

## Retryable Patterns

### Vercel Preview Deploy Timeout
- **Match**: Check name contains `vercel` or `Preview`; conclusion is `TIMED_OUT` or `FAILURE` with "timeout" in logs
- **Retryable**: Yes
- **Max retries**: 2
- **Wait**: 60 seconds
- **Notes**: Vercel deploys can take 2-3 minutes. If the check is still pending and was created less than 3 minutes ago, it is not a failure yet; just wait.

### Playwright / E2E Flaky Tests
- **Match**: Check name contains `playwright`, `e2e`, `cypress`, or `integration`; failure is intermittent (passed on a previous commit)
- **Retryable**: Yes
- **Max retries**: 2
- **Wait**: 30 seconds
- **Notes**: Flaky tests are the most common cause of false CI failures. If the same test fails consistently across retries, treat as a real failure.

### npm / yarn / pnpm Install Failure
- **Match**: Log contains `ETIMEDOUT`, `ECONNRESET`, `ENOTFOUND`, `npm ERR! network`, `yarn error`, `fetch failed`
- **Retryable**: Yes
- **Max retries**: 2
- **Wait**: 30 seconds
- **Notes**: Network issues during dependency installation. Almost always transient.

### GitHub Actions Runner Issue
- **Match**: Conclusion is `CANCELLED` with no user cancellation; or log contains `Runner.Worker`, `job was cancelled`, `lost communication`
- **Retryable**: Yes
- **Max retries**: 1
- **Wait**: 60 seconds
- **Notes**: GitHub-side infrastructure issue. Usually resolves on retry.

### Docker Build Timeout
- **Match**: Check involves Docker; log contains `deadline exceeded`, `context deadline`, or `read tcp` errors
- **Retryable**: Yes
- **Max retries**: 1
- **Wait**: 120 seconds
- **Notes**: Docker layer caching can be cold after infrastructure changes.

### Rate Limit / API Throttle
- **Match**: Log contains `rate limit`, `429`, `too many requests`, `quota exceeded`
- **Retryable**: Yes
- **Max retries**: 1
- **Wait**: 300 seconds
- **Notes**: Wait longer before retrying. Usually GitHub API or third-party service rate limits.

## Non-Retryable Patterns

### ESLint / Linting Errors
- **Match**: Check name contains `lint`, `eslint`, `prettier`; log contains specific file/line errors
- **Retryable**: No
- **Action**: Report the specific lint errors. These require code changes.

### TypeScript Type Errors
- **Match**: Check name contains `typecheck`, `tsc`, `type-check`; log contains `TS2XXX` error codes
- **Retryable**: No
- **Action**: Report the type errors with file paths and line numbers. Requires code fixes.

### Build Compilation Errors
- **Match**: Check name contains `build`; log contains `Module not found`, `Cannot find module`, `SyntaxError`, `Unexpected token`
- **Retryable**: No
- **Action**: Report build errors. These are real code issues.

### Test Assertion Failures (Consistent)
- **Match**: Check name contains `test`, `jest`, `vitest`; same test fails on retry
- **Retryable**: No (after initial retry attempt)
- **Action**: Report failing test names and assertion messages. Requires code or test fixes.

### Security / Audit Failures
- **Match**: Check name contains `security`, `audit`, `snyk`, `dependabot`, `codeql`
- **Retryable**: No
- **Action**: Report security findings. These require dependency updates or code changes.

### Code Coverage Below Threshold
- **Match**: Log contains `coverage threshold`, `below minimum`, `Coverage for`
- **Retryable**: No
- **Action**: Report coverage gap. Requires additional tests.

### Permission / Secret Errors
- **Match**: Log contains `secret not found`, `permission denied`, `GITHUB_TOKEN`, `unauthorized`
- **Retryable**: No
- **Action**: Report to user. Likely a repo configuration issue.

## Decision Flowchart

```
Check failed
  |
  +--> Match against known patterns above
  |      |
  |      +--> Retryable pattern found
  |      |      |
  |      |      +--> Retry count < max retries?
  |      |      |      |
  |      |      |      +--> Yes: Wait, then retry
  |      |      |      +--> No: Report as real failure
  |      |      |
  |      +--> Non-retryable pattern found
  |      |      |
  |      |      +--> Report with actionable details
  |      |
  |      +--> Unknown pattern
  |             |
  |             +--> Report to user, suggest manual investigation
```

## Adding New Patterns

When you encounter a new CI failure pattern:
1. Check if it appeared in the last 5 CI runs for the same repo
2. If intermittent (sometimes passes, sometimes fails), classify as retryable
3. If consistent (always fails with same error), classify as non-retryable
4. Add to the appropriate section above with match criteria
