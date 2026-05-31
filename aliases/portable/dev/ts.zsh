# ===============================
# Typescript
# ===============================

tsn() {
  npx tsc --noEmit
}

tesa() {
  npx tsc --noEmit && npx eslint --quiet "src/**/*.{ts,tsx,js,jsx}"
}
