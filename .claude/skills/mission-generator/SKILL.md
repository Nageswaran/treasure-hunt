---
name: mission-generator
description: "Generates a complete, ready-to-play 'Internet Detective Academy' mission: an educational detective-mystery/treasure-hunt/escape-room adventure for a 10-year-old (Dutch Group 6 level) that teaches real skills (math, language, geography, science, logic, cryptography, internet research, financial literacy, history, internet safety) through 6-8 difficulty-curved missions with hints and exactly one correct, verified answer per puzzle. Produces one folder per mission (named after the theme, e.g. broken-bicycle/) containing exactly two files inside it: mission.html (kid-facing) and answer.html (parent-only answer key) — this matches the Nageswaran/treasure-hunt repo layout so the folder can be dropped straight in and pushed. Use whenever the user says 'generate a mission,' asks for an Internet Detective Academy adventure, or asks to build any detective mystery, treasure hunt, escape-room game, secret-agent mission, or educational scavenger hunt for a child, even phrased casually ('make my kid another puzzle adventure', 'a fun screen-time activity that's actually educational'). Also use for making an existing mission harder/easier, a new theme, or more puzzles."
---

# Internet Detective Academy — Mission Generator

## Why this exists

A 10-year-old playing this should feel like a real investigator who cracked the case themselves — not like they're filling out a worksheet. Every choice below (the story framing, the hints that nudge instead of tell, the fact-checking) exists to protect that feeling. The single biggest way to break it is a puzzle with two possible answers, or a "fact" that turns out to be wrong when the curious kid Googles it five minutes later — so the verification step later in this doc is not optional polish, it's the thing that makes the whole format work.

## When you're invoked

- **Default case** ("Generate a mission," or no extra detail given): just go. Pick everything yourself — theme, domains, puzzles — using the defaults below. Don't ask clarifying questions for the default case; the whole point is a surprise adventure.
- **User gives constraints** (a preferred theme, a subject they want reinforced, "make it harder," a different mission count): fold these in directly, no need to ask permission first.
- **Genuinely ambiguous** (e.g. a much younger/older child, a different language entirely than the defaults below): ask one quick question. Otherwise assume a 10-year-old, Dutch Group 6 reading level, English instructions.
- **Check for themes already used** both in this conversation *and* on disk: `ls` the mission folders already in the `treasure-hunt` repo (see Output Files) and skip any theme that matches an existing folder name, not just ones mentioned earlier in this chat.

## Step-by-step process

1. **Pick a story theme.** Pull from `references/puzzle-library.md` or invent one in the same spirit (mystery / treasure hunt / escape room / secret agent / archaeological dig / science expedition). Never repeat a theme already used earlier in this conversation or already present as a folder in the repo (see "When you're invoked" above).
2. **Pick 4-6 learning domains** for this mission set from `references/learning-domains.md`. Spread them across missions rather than clustering — don't reuse the exact same 4-6 combo two missions in a row.
3. **Build 6-8 missions** following this difficulty curve: Easy, Easy, Medium, Medium, Hard, Hard, Big "Aha!" moment, Grand Finale. (6 missions is fine for a shorter session — drop two of the middle ones, keep the curve shape.)
4. **Check the full set covers:**
   - At least 1 dedicated logical-reasoning puzzle (sequence, elimination, logic grid, truth/lies, deduction, spatial reasoning...)
   - At least 3 missions requiring active internet use (search, read an article, compare two sites, Google Maps/Street View, a museum site, Wikipedia)
   - At least 1 mission solved mainly by close observation of a real image
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

## Hint system

- **Hint 1** (every mission): points toward *where* or *how* to look, never *what* you'll find.
- **Hint 2** (medium/hard/finale only): narrower and more specific, but still stops short of the answer.

## Skill balance (across the whole set, not per-mission)

- 1 mathematics challenge
- 1 language challenge (Dutch only when the puzzle is specifically testing Dutch — see Language Rules)
- 1 logical-reasoning challenge
- 1 internet-research challenge
- 1 challenge from geography, science, history, or technology
- 1 creative "aha" challenge

## Language rules

- Write all story text and instructions in English.
- Use Dutch only inside a puzzle that specifically tests Dutch-language knowledge (de/het, spelling, synonyms/antonyms, word categories). Surrounding instructions for that puzzle stay in English.
- Keep sentences short and vocabulary at a level a 10-year-old can read independently: aim for under ~15 words per sentence, and briefly explain inline any word longer than 3 syllables that a Group 6 student might not know.

## Output: one folder per mission, two files inside

Every mission lives in its own folder, named after the theme in kebab-case (e.g. `broken-bicycle`, `missing-birthday-present`), saved directly inside the local `treasure-hunt` repo at `/Users/nageswaran/github/treasure-hunt/<theme-slug>/` — the same level as the existing `broken-bicycle/`, `museum-heist/`, and `mummys-warning/` folders there. If that path doesn't exist on this machine, search for a repo named `treasure-hunt` before falling back to anywhere else, and confirm with the user where to save.

Inside the folder, always exactly two files, with these exact names (not `mission-<theme>.html` — just `mission.html`, since the folder name already carries the theme):

1. **`mission.html`** — built from `assets/kid-mission-template.html`. Title, story intro, an estimated total play time, every mission (puzzle, hints, images, answer box), the easter-egg facts, and the final reward reveal. No answers anywhere in this file — not in comments, not in hidden elements, and not decodable from the answer-check hashes either (see Answer Checking below). Assume a curious kid opens dev tools.
2. **`answer.html`** — built from `assets/parent-answer-template.html`. For every mission: the exact answer, a step-by-step explanation, a one-line note on why that answer is the *only* one, and the source or fact it relies on.

The answer key must never be visible to the child — the moment they can peek, the puzzle (and the magic) is gone. These stay two separate files, never one document with a hidden section.

Read both templates fully before writing — match their structure and CSS, swap in fresh content, and adjust only the accent color/imagery to suit the theme (keep the overall case-file look consistent across missions so it stays recognizable as "Internet Detective Academy").

Save to:
- `/Users/nageswaran/github/treasure-hunt/<theme-slug>/mission.html`
- `/Users/nageswaran/github/treasure-hunt/<theme-slug>/answer.html`
- `/Users/nageswaran/github/treasure-hunt/<theme-slug>/images/` — only if any images were downloaded locally (see Images below); omit this folder entirely if every image is linked externally.

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

Two ways an image can end up in a mission, and when to use each:

1. **Default — link directly to a real external URL.** Use `image_search` to find a real image, actually look at it to confirm the clue is genuinely visible, and put that URL straight into the `<img src="...">`. This is the simplest option and needs no extra steps. Always write a solid `alt` description too, so the mission still makes sense in the rare case the link ever breaks.
2. **Optional — download the image into the mission's own `images/` folder**, if the person asks for locally-hosted images (so nothing depends on a third-party link staying alive) or if you're re-processing an image (cropping, combining). Use `curl`/`Bash` or `WebFetch` to save it under the mission's own `images/` folder in the repo (see path above) — this is a local machine, not a restricted hosted sandbox, so most image hosts should work directly. If a particular download does fail (paywall, bot-blocking, rate limit), don't fight it: fall back to linking that image externally instead, and tell the person plainly which images could be downloaded and which had to stay linked.

Either way, run the same verification: an image-based puzzle only ships if you've actually looked at the image and confirmed the clue is unambiguous in it.

## Reference files

- `references/learning-domains.md` — the full list of learning domains with example puzzle seeds for each. Pick 4-6 per mission set; rotate which ones you use.
- `references/puzzle-library.md` — story theme ideas (don't repeat one already used this conversation), puzzle-mechanic ideas, example verified-style "Did you know?" facts, and the reward-value list.
