# AST-Grep

Use `ast-grep` (if installed) instead of regex for structural code patterns, language-aware refactoring, and cross-language searches.

```bash
# Check availability first
command -v ast-grep >/dev/null 2>&1 || echo "Not installed, using grep"

# Basic pattern
ast-grep --pattern '$PATTERN' --lang $LANG $PATH

# Pattern syntax: $VAR (single node), $$$ (zero+), $$ (one+)
```

Common patterns:
- Functions: `ast-grep --pattern 'functionName($$$)' --lang js .`
- Classes: `ast-grep --pattern 'class $NAME { $$$ }' --lang ts .`
- Imports: `ast-grep --pattern 'import { $$$ } from "$MODULE"' --lang js .`
- React hooks: `ast-grep --pattern 'const [$S, $SET] = useState($$$)' --lang tsx .`

Decision: Use Grep for text matching, ast-grep for code structure, both for refactoring.
