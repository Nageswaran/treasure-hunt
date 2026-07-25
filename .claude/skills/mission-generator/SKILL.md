---
name: mission-generator
description: "Generates a complete, ready-to-play 'Internet Detective Academy' mission: an educational detective-mystery/treasure-hunt/escape-room adventure for a 10-year-old (Dutch Group 6 level) that teaches real skills (math, geometry/measurement, logical reasoning, language, geography, science, cryptography, internet research, financial literacy, history, internet safety) through 6-10 difficulty-curved missions with hints and exactly one correct, verified answer per puzzle. Can draw its own shape diagrams (inline SVG) for area/perimeter/measurement puzzles instead of relying on external images. Produces one folder per mission (named after the theme, e.g. broken-bicycle/) containing exactly two files inside it: mission.html (kid-facing) and answer.html (parent-only answer key) — this matches the Nageswaran/treasure-hunt repo layout so the folder can be dropped straight in and pushed. Use whenever the user says 'generate a mission,' asks for an Internet Detective Academy adventure, or asks to build any detective mystery, treasure hunt, escape-room game, secret-agent mission, or educational scavenger hunt for a child, even phrased casually ('make my kid another puzzle adventure', 'a fun screen-time activity that's actually educational'). Also use for making an existing mission harder/easier, a new theme, or more puzzles."
---

# Internet Detective Academy — Mission Generator

## Why this exists

A 10-year-old playing this should feel like a real investigator who cracked the case themselves — not like they're filling out a worksheet. Every choice below (the story framing, the hints that nudge instead of tell, the fact-checking) exists to protect that feeling. The single biggest way to break it is a puzzle with two possible answers, or a "fact" that turns out to be wrong when the curious kid Googles it five minutes later — so the verification step later in this doc is not optional polish, it's the thing that makes the whole format work.

## Structural variety — don't let mission sets become a reskinned template

This skill often runs unattended (a daily cron generates 3 sets with nobody reviewing the shape before it ships). The single biggest failure mode in that setup isn't a wrong fact — it's every set quietly having the *same skeleton* with a new theme painted over it: same domain-to-slot mapping, always exactly one image mission, always the same kind of finale. A new title and story intro do not count as variety if the underlying puzzle shapes repeat.

Before designing a new set:

- **Look at the most recently added mission folders** (2-3 of them — `index.html` is sorted oldest-first, so check the end of the list, or `git log --oneline` for the newest "Add..." commits) and skim their `mission.html`. Note: which mission number had the image, what the finale mechanic was, how many images they used, which domains sat in which slots.
- **Deliberately choose a different shape this time.** If the last set's image (if any) was in Mission 3, don't put this set's in Mission 3 again. If the last finale was a combine-the-clues puzzle, make this one a multi-stage calculation or a logic puzzle instead. If recent sets all leaned on internet-research-then-type-the-answer, make this one lean harder on pen-and-paper math or pure logic instead.
- **Vary image count freely — it is not a quota.** Some sets should have zero images (pure logic/math/cryptography/text puzzles), some should have one, some should have three or four. Let each puzzle decide for itself whether a real image is the right vehicle; never add or omit one just to hit a round number.
- **Vary the interaction mode, not just the topic.** Across a set, mix genuinely different modes of engagement: searching the internet for a fact, working out a calculation with pen and paper, reasoning through a logic puzzle with no lookup at all, and recalling something planted earlier without being told where to look (see "Multi-stage puzzles" and the delayed-recall mechanic in `references/puzzle-library.md`). A set that is 80% "search the internet, type the answer" is exactly the homogeneity to avoid, regardless of how different the cover story is.

## When you're invoked

- **Default case** ("Generate a mission," or no extra detail given): just go. Pick everything yourself — theme, domains, puzzles — using the defaults below. Don't ask clarifying questions for the default case; the whole point is a surprise adventure.
- **User gives constraints** (a preferred theme, a subject they want reinforced, "make it harder," a different mission count): fold these in directly, no need to ask permission first.
- **Genuinely ambiguous** (e.g. a much younger/older child, a different language entirely than the defaults below): ask one quick question. Otherwise assume a 10-year-old, Dutch Group 6 reading level, English instructions.
- **Check for themes already used** both in this conversation *and* on disk: `ls` the mission folders already in the `treasure-hunt` repo (see Output Files) and skip any theme that matches an existing folder name, not just ones mentioned earlier in this chat.

## Step-by-step process

1. **Pick a story theme.** Pull from `references/puzzle-library.md` or invent one in the same spirit (mystery / treasure hunt / escape room / secret agent / archaeological dig / science expedition). Never repeat a theme already used earlier in this conversation or already present as a folder in the repo (see "When you're invoked" above).
2. **Pick 4-6 learning domains** for this mission set from `references/learning-domains.md`. Spread them across missions rather than clustering — don't reuse the exact same 4-6 combo two missions in a row.
3. **Build 6, 8, or 10 missions** following this difficulty curve, choosing the length based on the user's request (default 8 if unspecified):
   - **6** (shorter session): Easy, Easy, Medium, Medium, Hard, Grand Finale.
   - **8** (default): Easy, Easy, Medium, Medium, Hard, Hard, Big "Aha!" moment, Grand Finale.
   - **10** (longer session): Easy, Easy, Medium, Medium, Medium, Hard, Hard, Hard, Big "Aha!" moment, Grand Finale.
4. **Check the full set covers:**
   - At least 1 dedicated logical-reasoning puzzle for a 6-mission set, **at least 2** (from different tiers or mechanics) for an 8-mission set, **at least 3** (spanning at least 2 of the Foundational/Intermediate/Advanced tiers) for a 10-mission set. See the Logical Reasoning domain for the full tiered list — these must be solvable purely by reasoning from the clues given, never by looking anything up, with the single carved-out exception noted there (self-referential paradoxes are a no-answer-box aside, never a numbered mission).
   - If Mathematics is one of the chosen domains, consider at least one geometry/measurement puzzle: a shape (or combination of shapes) you draw yourself as a labeled diagram, where the child finds the area, perimeter, or a missing measurement (see "Diagrams" below).
   - At least 3 missions requiring active internet use (search, read an article, compare two sites, Google Maps/Street View, a museum site, Wikipedia)
   - **Images are optional, not a quota.** Use however many real images the puzzles genuinely call for — zero, one, three, whatever fits. Don't force exactly one in just to satisfy a checklist (see "Structural variety" above).
   - At least 1 mission meant to be worked out with pen and paper rather than mental math — something gnarly enough (multi-digit arithmetic, tallying several clues into a table, a longer step-by-step calculation) that it's genuinely easier on scratch paper. Say so in the puzzle text (e.g. "grab a pencil for this one").
   - For an 8- or 10-mission set: at least 1 multi-stage mission (2-3 sequential stages where each stage's result feeds the next) — see "Multi-stage puzzles" below. Optional for a 6-mission set (too short to spare the room).
   - For an 8- or 10-mission set: at least 1 delayed-recall pair — an early mission plants a memorable detail (flagged in-story as worth remembering, e.g. "jot this down"), and a *non-adjacent* later mission needs it again without restating it or pointing back to where it came from. Skip for a 6-mission set (not enough missions for a meaningful gap). See `references/puzzle-library.md`.
   - Roughly the spread in **Skill balance** below across the whole set (it's fine for one mission to satisfy two categories at once)
5. **Write hints** for every mission: Hint 1 always (gentle nudge), Hint 2 for medium/hard/finale missions (stronger clue). Never write a hint that states the answer or makes it the only possible next guess.
6. **Weave in 2-3 "Did you know?" facts** between missions — verified, not invented (see Red-Team Validation).
7. **Pick a final reward value** the last mission's answer reveals: curiosity, courage, discovery, creativity, teamwork, kindness, wisdom, or perseverance.
8. **Red-team validate everything** (next section) before writing anything to a file.
9. **Fill in the two templates** in `assets/` and save both files into a new `<theme-slug>/` folder (see Output Files).
10. **Grep both output files for leftover `{{` template markers.** Any hit means a placeholder didn't get filled in — fix it before telling the user you're done.
11. **Regenerate the local index page**: run `./scripts/generate-index.sh` from the `treasure-hunt` repo root so `index.html` includes the new mission immediately for local testing (GitHub CI also regenerates it again on push, but don't skip the local run).

## Red-team validation — do this before writing the output files

Solve every puzzle yourself, the same way the child would: do the actual search, read the actual page, do the actual math.

- For every factual claim or trivia answer (capitals, dates, scientific facts, historical figures, etc.), verify it with the `web_search` tool rather than trusting memory — even things you're sure of. A wrong "Did you know?" fact is exactly the kind of thing a sharp 10-year-old catches.
- For anything you're sending the child to search for, run that search yourself first. Check that the obvious search terms land on one clear answer, not a forum argument or several competing answers.
- **Prefer kid-safe destination sites.** When a puzzle sends the child to click through to a page (not just search), prefer reputable, curated sources (Wikipedia, official museum/government/tourism sites, Wikimedia Commons, kids'-encyclopedia sites) over random blogs, forums, or news sites — those can carry unrelated ads, comment sections, or off-topic content a step away from the clue. Skim the destination page itself, not just the fact on it.
- These verification searches are independent across puzzles/missions — run them as parallel tool calls (multiple `web_search`/`image_search` calls in one turn) rather than one puzzle at a time in sequence. It's the single biggest lever on how long a mission takes to generate, and it doesn't cost any rigor.
- For image-based puzzles, use the `image_search` tool to find a real image, actually look at it, and confirm the clue is genuinely visible and solvable in it. Never invent a fictional image or describe one that doesn't exist. Decide there whether it'll be linked externally or downloaded into `images/` (see Images section) — either way, the URL or local path in the final HTML must point at the exact image you actually looked at.
- Rewrite or replace any puzzle that has ambiguous wording, more than one defensible answer, an answer that depends on opinion, or that relies on information that changes (news, sports results, rankings, prices, anything "current").
- For each answer, sanity-check uniqueness: would any other reasonable reading of the clue lead somewhere else? If yes, tighten the wording.
- Double-check no puzzle's story/flavor text accidentally leaks its own answer.
- For any math/geometry puzzle (including diagram-based ones), actually recompute the answer from the same numbers stated in the puzzle — don't eyeball it. For a diagram, also check that every coordinate you drew is mutually consistent with the labeled dimensions (e.g. in an L-shaped figure, the two rectangles' shared edges must actually add up), so the picture never contradicts the numbers.
- For a logical-reasoning puzzle, actually work it yourself from only the clues given (no answer key, no shortcuts) to confirm it's solvable and has exactly one forced solution — if you find yourself needing to guess or check multiple branches, tighten the clue set.

## Hint system

- **Hint 1** (every mission): points toward *where* or *how* to look, never *what* you'll find.
- **Hint 2** (medium/hard/finale only): narrower and more specific, but still stops short of the answer.

## Skill balance (across the whole set, not per-mission)

For a 6- or 8-mission set:
- 1 mathematics challenge
- 1 language challenge (Dutch only when the puzzle is specifically testing Dutch — see Language Rules)
- 1 logical-reasoning challenge
- 1 internet-research challenge
- 1 challenge from geography, science, history, or technology
- 1 creative "aha" challenge

For a 10-mission set, weight it toward logic and math instead of just adding filler:
- 2 mathematics challenges (if Mathematics is a chosen domain, make at least one of these a geometry/measurement diagram puzzle)
- 3 logical-reasoning challenges, spanning at least 2 tiers (e.g. one Foundational sequence puzzle, one Intermediate logic grid, one Advanced working-backward or multi-constraint grid) — this is deliberately the largest category for a 10-mission set
- 1 language challenge
- 1 internet-research challenge
- 1 challenge from geography, science, history, or technology
- 1 creative "aha" challenge

## Language rules

- Write all story text and instructions in English.
- Use Dutch only inside a puzzle that specifically tests Dutch-language knowledge (de/het, spelling, synonyms/antonyms, word categories). Surrounding instructions for that puzzle stay in English.
- Keep sentences short and vocabulary at a level a 10-year-old can read independently: aim for under ~15 words per sentence, and briefly explain inline any word longer than 3 syllables that a Group 6 student might not know.

## Output: one folder per mission, two files inside

Every mission lives in its own folder, named after the theme in kebab-case (e.g. `broken-bicycle`, `missing-birthday-present`), saved at the root of the `treasure-hunt` repo checkout you're already working in — the same level as the existing `broken-bicycle/`, `museum-heist/`, and `mummys-warning/` folders there. On the primary local machine that repo lives at `/Users/nageswaran/github/treasure-hunt/`; if you're instead running from a different checkout (a fresh clone, a cloud/CI sandbox), use that checkout's root instead of the absolute local path — don't assume `/Users/nageswaran/...` exists. If no `treasure-hunt` checkout is available at all, say so and confirm with the user where to save.

Inside the folder, always exactly two files, with these exact names (not `mission-<theme>.html` — just `mission.html`, since the folder name already carries the theme):

1. **`mission.html`** — built from `assets/kid-mission-template.html`. Title, story intro, an estimated total play time, every mission (puzzle, hints, images, answer box), the easter-egg facts, and the final reward reveal. No answers anywhere in this file — not in comments, not in hidden elements, and not decodable from the answer-check hashes either (see Answer Checking below). Assume a curious kid opens dev tools.
2. **`answer.html`** — built from `assets/parent-answer-template.html`. For every mission: the exact answer, a step-by-step explanation, a one-line note on why that answer is the *only* one, and the source or fact it relies on.

The answer key must never be visible to the child — the moment they can peek, the puzzle (and the magic) is gone. These stay two separate files, never one document with a hidden section.

Read both templates fully before writing — match their structure and CSS, swap in fresh content, and adjust only the accent color/imagery to suit the theme (keep the overall case-file look consistent across missions so it stays recognizable as "Internet Detective Academy").

Save to (relative to the repo checkout root, see above):
- `<theme-slug>/mission.html`
- `<theme-slug>/answer.html`
- `<theme-slug>/images/` — only if any images were downloaded locally (see Images below); omit this folder entirely if every image is linked externally.

After writing both files, regenerate the index (see step 11 of the process above) before telling the user you're done. When you present the files, say plainly which one is for the parent and suggest they keep it closed unless the child is stuck or done.

## Answer checking: hashed, not plaintext

Each answer box gets a "Check my answer" button that gives the child instant right/wrong feedback in `mission.html`, without ever putting the plaintext answer in that file:

- Normalize the answer the same way every time: lowercase, trim leading/trailing whitespace, collapse internal whitespace to single spaces.
- Hash the normalized answer with the small inline hash function already in `assets/kid-mission-template.html` (a plain-JS string hash — no server, no external crypto library, works offline from a local file).
- Store only the resulting hash in the mission's `data-answer-hash` attribute. The button re-normalizes and re-hashes whatever the child typed and compares hashes — the correct answer itself never appears in the page's HTML or JS.
- This is a casual-peeking deterrent, not real cryptography — proportionate to a home project, not a security boundary. Don't reach for `crypto.subtle` or a real hash library over it.
- To compute each `data-answer-hash` value, run the exact `hashAnswer()` function from the template through `node -e` (copy it verbatim) rather than reimplementing the hash in another language — a subtly different reimplementation (e.g. different integer-overflow behavior) will produce different hashes and silently break every check button.
- If a puzzle's answer could reasonably be typed several equivalent ways (e.g. "12" vs "twelve", "Paris" vs "paris, france"), say so explicitly in the puzzle text so the child types the form that matches, or normalize further (strip punctuation, accept digits-only) as needed for that specific answer.

## Images: link externally by default, download only when it actually works

How many images a set uses is entirely driven by the puzzles, not a fixed target — a set can have zero real images (all logic/math/cipher/text puzzles), one, or several across different missions; a single mission can even use more than one image (e.g. "spot the difference" between two photos) if that's what the puzzle needs. See "Structural variety" above.

Two ways an image can end up in a mission, and when to use each:

1. **Default — link directly to a real external URL.** Use `image_search` to find a real image, actually look at it to confirm the clue is genuinely visible, and put that URL straight into the `<img src="...">`. This is the simplest option and needs no extra steps. Always write a solid `alt` description too, so the mission still makes sense in the rare case the link ever breaks.
2. **Optional — download the image into the mission's own `images/` folder**, if the person asks for locally-hosted images (so nothing depends on a third-party link staying alive) or if you're re-processing an image (cropping, combining). Use `curl`/`Bash` or `WebFetch` to save it under the mission's own `images/` folder in the repo (see path above) — this is a local machine, not a restricted hosted sandbox, so most image hosts should work directly. If a particular download does fail (paywall, bot-blocking, rate limit), don't fight it: fall back to linking that image externally instead, and tell the person plainly which images could be downloaded and which had to stay linked.

Either way, run the same verification: an image-based puzzle only ships if you've actually looked at the image and confirmed the clue is unambiguous in it.

## Diagrams: drawing your own shapes for measurement puzzles

For area/perimeter/measurement puzzles, don't go looking for a stock image — draw the shape yourself, since you control the exact numbers and can guarantee the diagram and the math agree.

- **Default: plain inline SVG, no external library.** Draw the shape directly in `mission.html` as an inline `<svg>...</svg>` (see the geometry example in `assets/kid-mission-template.html`), styled with the `.clue-diagram` class already in the template's CSS. This needs no network access, works offline from a local file, and keeps the mission fully self-contained — consistent with everything else in this file.
- **Build it to scale.** Pick a consistent unit-to-pixel scale (e.g. 1 cm = 20px) and use it for every shape in that puzzle, so the diagram is genuinely proportioned, not just decorative. Label each side length directly on the diagram with SVG `<text>` elements — the child should be able to read every dimension they need straight off the picture.
- **Optional polish:** if you want a hand-drawn/sketched look (fitting the case-file paper aesthetic), a small permissively-licensed drawing library loaded from a CDN (e.g. a sketchy-rendering library for canvas/SVG) is fine to use — the user has explicitly OK'd this. Treat it as optional visual polish only, though: it's an external network dependency like the Google Fonts link already in the template, so it can fail to load if the page is ever opened offline. Never make a puzzle depend on it rendering correctly — the plain SVG shape and its labeled dimensions must already be fully solvable without it.
- **Composite shapes are the interesting case.** An L-shaped garden, a room with a rectangular alcove, two rectangles joined at an edge — these test whether the child can decompose a shape into simpler pieces. Give enough dimensions to solve it (not necessarily every side — a classic composite-shape puzzle gives you the outer dimensions plus one notch, and the child derives the rest), and verify in Red-Team Validation that the given numbers are actually sufficient and self-consistent.

## Multi-stage puzzles: one mission, several dependent steps

Most missions are one lookup or one calculation → one answer. A multi-stage mission is deliberately deeper: 2-3 sequential stages where each stage's result is genuinely needed to attempt the next, instead of one clue leading straight to the finish.

- **No template changes needed.** Reuse the existing `.answer-box`/`hashAnswer()`/`checkAnswer()` pattern once per stage, inside the same `.mission-body` — just give each stage its own input `id` and its own `data-answer-hash`, and label them "Stage 1 of 2," "Stage 2 of 2," etc. Each stage checks independently with the same button pattern already in the template.
- **Make the dependency real.** Stage 2's puzzle text should require Stage 1's actual result (e.g. Stage 1's answer is a number of steps to walk on a described map, a year to look up, a shift amount for a cipher; Stage 2 then uses that number/word as an input). If Stage 2 is solvable without knowing Stage 1's answer, it isn't really multi-stage — tighten it.
- **Hints stay per-stage.** Stage 1 gets its own Hint 1 (and Hint 2 if it's the harder half); don't let one hint block cover both stages.
- **In `answer.html`**, document every stage's answer and explanation under that mission's card (e.g. "Stage 1 answer: ...", "Stage 2 (final) answer: ..."), each with its own reasoning and source, same as any other answer.
- **Red-team both stages separately, then the chain as a whole**: solve Stage 1 for real, feed that exact result into Stage 2, and confirm it actually produces one forced answer — not just that each stage is individually fine in isolation.
- Good candidates for multi-stage: the Hard slot, the "Aha!" moment, or the finale — the extra depth suits missions already meant to feel like the set's high point.

## Reference files

- `references/learning-domains.md` — the full list of learning domains with example puzzle seeds for each. Pick 4-6 per mission set; rotate which ones you use.
- `references/puzzle-library.md` — story theme ideas (don't repeat one already used this conversation), puzzle-mechanic ideas, example verified-style "Did you know?" facts, and the reward-value list.
