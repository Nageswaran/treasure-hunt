#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

cat > index.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Internet Detective Academy Missions</title>
  <style>
    * {
      box-sizing: border-box;
    }

    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 40px 20px 56px;
      background: #f3ecda;
      color: #2b2a24;
    }

    .page {
      max-width: 1080px;
      margin: 0 auto;
    }

    header {
      margin-bottom: 28px;
    }

    .eyebrow {
      color: #7a4f2a;
      font-size: 13px;
      font-weight: 700;
      letter-spacing: 0.08em;
      text-transform: uppercase;
    }

    h1 {
      color: #222;
      font-size: clamp(32px, 6vw, 54px);
      line-height: 1;
      margin: 8px 0 12px;
    }

    .intro {
      max-width: 680px;
      color: #5c5548;
      font-size: 17px;
      line-height: 1.5;
      margin: 0;
    }

    .mission-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
      gap: 18px;
    }

    .mission-card {
      background: #fffdf7;
      border: 1px solid rgba(0,0,0,0.08);
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 6px 18px rgba(0,0,0,0.08);
    }

    .mission-card h2 {
      margin: 0 0 6px;
      color: #2b2a24;
      font-size: 22px;
      text-transform: capitalize;
    }

    .mission-card p {
      color: #6b6254;
      margin: 0 0 18px;
      font-size: 14px;
    }

    .actions {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
    }

    .button {
      border-radius: 6px;
      display: inline-block;
      font-weight: 700;
      padding: 10px 14px;
      text-decoration: none;
    }

    .button.primary {
      background: #2d6a4f;
      color: #fff;
    }

    .button.secondary {
      background: #e8dec4;
      color: #4e3d20;
    }

    .button:hover {
      filter: brightness(0.96);
    }
  </style>
</head>
<body>
  <main class="page">
    <header>
      <div class="eyebrow">Internet Detective Academy</div>
      <h1>Mission Library</h1>
      <p class="intro">Choose a case file to start the kid-facing mission. Parent answer keys are listed second so the mission link always comes first.</p>
    </header>
    <section class="mission-grid">
EOF

while IFS= read -r dir; do
  display=$(basename "$dir" | tr '-' ' ')
  mission_path="$dir/mission.html"
  answer_path="$dir/answer.html"

  echo "<article class=\"mission-card\">" >> index.html
  echo "<h2>$display</h2>" >> index.html
  echo "<p>Case folder: $dir</p>" >> index.html
  echo "<div class=\"actions\">" >> index.html

  if [ -f "$mission_path" ]; then
    echo "<a class=\"button primary\" href=\"$mission_path\">Start mission</a>" >> index.html
  fi

  if [ -f "$answer_path" ]; then
    echo "<a class=\"button secondary\" href=\"$answer_path\">Parent answer key</a>" >> index.html
  fi

  while IFS= read -r file; do
    filename=$(basename "$file")
    echo "<a class=\"button secondary\" href=\"$file\">$filename</a>" >> index.html
  done < <(
    find "$dir" \
      -maxdepth 1 \
      -type f \
      -name "*.html" \
      ! -name "mission.html" \
      ! -name "answer.html" \
      | sort
  )

  echo "</div>" >> index.html
  echo "</article>" >> index.html
done < <(
  find . \
    -mindepth 2 \
    -maxdepth 2 \
    -type f \
    -name "mission.html" \
    ! -path "./.github/*" \
    -exec dirname {} \; \
    | sed 's|^\./||' \
    | while IFS= read -r d; do
        added=$(git log --follow --diff-filter=A --format=%aI -- "$d/mission.html" 2>/dev/null | tail -1)
        if [ -z "$added" ]; then
          added=$(date -u +%Y-%m-%dT%H:%M:%SZ)
        fi
        printf '%s\t%s\n' "$added" "$d"
      done \
    | sort \
    | cut -f2
)

cat >> index.html <<'EOF'
    </section>
  </main>
</body>
</html>
EOF
