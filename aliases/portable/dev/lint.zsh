# ===============================
# Lint
# ===============================

erra() {
  npx eslint --quiet "src/**/*.{ts,tsx,js,jsx}"
}

fixa() {
  npx eslint --fix --fix-type layout "src/**/*.{ts,tsx,js,jsx}"
}

_changed_js_files() {
  {
    git diff --name-only --cached --diff-filter=ACMR
    git diff --name-only --diff-filter=ACMR
    git ls-files --others --exclude-standard
  } | grep -E '^src/.*\.(ts|tsx|js|jsx)$' | sort -u
}

fix() {
  local files
  files=("${(@f)$(_changed_js_files)}")

  if (( ${#files} == 0 )) || [[ -z "${files[1]}" ]]; then
    echo "No staged JS/TS files."
    return 0
  fi

  npx eslint --quiet --fix --fix-type layout -- "${files[@]}" || return 1
  # git add -- "${files[@]}"
}

err() {
  local files
  files=("${(@f)$(_changed_js_files)}")

  if (( ${#files} == 0 )) || [[ -z "${files[1]}" ]]; then
    echo "No staged JS/TS files."
    return 0
  fi

  npx eslint --quiet -- "${files[@]}"
}

tes() {
  fixs && errs && tsn
}

lintab() {
  npx eslint "$@" -f json | node -e '
    let input = "";

    process.stdin.on("data", chunk => input += chunk);

    process.stdin.on("end", () => {
      const results = JSON.parse(input || "[]");
      const grouped = {};

      for (const file of results) {
        for (const msg of file.messages) {
          const rule = msg.ruleId || "fatal/parsing";
          const severity = msg.severity === 2 ? "error" : "warning";

          if (!grouped[rule]) {
            grouped[rule] = {
              rule,
              errors: 0,
              warnings: 0,
              total: 0,
            };
          }

          grouped[rule][severity === "error" ? "errors" : "warnings"]++;
          grouped[rule].total++;
        }
      }

      const table = Object.values(grouped)
        .sort((a, b) => b.total - a.total);

      console.table(table);
    });
  '
}

lintabun () {
  bunx eslint "$@" -f json | bun -e '
    let input = "";

    process.stdin.on("data", chunk => input += chunk);

    process.stdin.on("end", () => {
      const results = JSON.parse(input || "[]");
      const grouped = {};

      for (const file of results) {
        for (const msg of file.messages) {
          const rule = msg.ruleId || "fatal/parsing";
          const severity = msg.severity === 2 ? "error" : "warning";

          if (!grouped[rule]) {
            grouped[rule] = {
              rule,
              errors: 0,
              warnings: 0,
              total: 0,
            };
          }

          grouped[rule][severity === "error" ? "errors" : "warnings"]++;
          grouped[rule].total++;
        }
      }

      const table = Object.values(grouped)
        .sort((a, b) => b.total - a.total);

      console.table(table);
    });
  '
}

