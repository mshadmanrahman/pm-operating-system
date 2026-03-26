# Data Sources

Documents where the underlying data lives and how to search it effectively.

## 1. Episode Transcripts

**Location**: `_context/lennys-podcast-transcripts/episodes/{guest-name}/transcript.md`

**Count**: 303 transcripts across 269+ episodes (some guests have multiple episodes)

**Format**: YAML frontmatter (guest, title, youtube_url, video_id, publish_date, description, duration, view_count, keywords) followed by timestamped speaker dialogue.

**Size warning**: Individual transcripts often exceed 25,000 tokens. Never read a full transcript without first confirming relevance.

### How to search transcripts

**Step 1: Find relevant episodes by topic**
```
Read file_path="_context/lennys-podcast-transcripts/index/{topic}.md"
```
The 94 topic files map episodes to keywords. Start here to narrow your search.

**Step 2: Grep across transcripts for specific terms**
```
Grep pattern="product.market fit" path="_context/lennys-podcast-transcripts/episodes/" output_mode="content" -C=5
```
This searches all 303 transcripts and returns matching lines with context. Preferred method for targeted queries.

**Step 3: Read frontmatter to confirm relevance**
```
Read file_path="_context/lennys-podcast-transcripts/episodes/{guest}/transcript.md" limit=15
```
Check guest name, title, publish date, and keywords before committing to reading more.

**Step 4: Read transcript chunks if needed**
```
Read file_path="..." offset=1 limit=500
Read file_path="..." offset=500 limit=500
```
Only when you need surrounding context that Grep did not capture.

**Step 5: Handle persisted output**
When Read returns `Output saved to: ~/.claude/.../xxx.txt`, read that path to get the full content.

### Multi-episode guests

Some guests appear multiple times. Their folders use suffixes:
- `elena-verna/` (first appearance)
- `elena-verna-20/` (second)
- `elena-verna-30/` (third)
- `elena-verna-40/` (fourth)

Same pattern for: `april-dunford`, `bob-moesta`, `casey-winters`, `andy-raskin`, `dylan-field`, `ethan-evans`.

## 2. Topic Index

**Location**: `_context/lennys-podcast-transcripts/index/`

**Entry point**: `_context/lennys-podcast-transcripts/index/README.md` (lists all 94 topics with episode counts)

**Format**: Each topic file (e.g., `growth-strategy.md`) lists episodes tagged with that keyword, including guest name and episode title.

**94 topics include**: Ab Testing, Agile, AI, Airbnb, Analytics, Brand Building, Business Strategy, Career Development, Communication, Company Culture, Customer Research, Decision Making, Entrepreneurship, Experimentation, Growth Strategy, Hiring, Leadership, Machine Learning, Marketing, Marketplaces, Network Effects, OKRs, Product Development, Product Led Growth, Product Management, Product Market Fit, Product Strategy, Retention, Team Building, User Experience, and more.

## 3. Guest CSV (Structured Data)

**Location**: `_context/skills/ask-kenny/AskLenny Lenny's Podcast Guests 2ed384a934dc81d9b853c6a95d4069a6.csv`

**Also at**: `_context/skills/ask-kenny/db/` (may contain an indexed SQLite version)

**Fields**: Name, Background, Key Quotes, Mental Models, Frameworks, Core Philosophy, Expertise, Keywords, Examples

**When to use**: When you need structured lookups (all guests who discuss "growth", or a specific person's mental models). Faster than grepping transcripts for broad topic discovery.

**How to search**:
```
Grep pattern="growth" path="_context/skills/ask-kenny/AskLenny Lenny's Podcast Guests 2ed384a934dc81d9b853c6a95d4069a6.csv" output_mode="content"
```

## 4. Framework References (from ask-kenny)

**Location**: `_context/skills/ask-kenny/references/`

| File | Contents |
|------|----------|
| `pm_frameworks.md` | 50+ frameworks: RICE, JTBD, OKRs, North Star, MoSCoW, Value vs Effort, etc. |
| `product_strategy.md` | Strategic thinking, market analysis (TAM/SAM/SOM, Five Forces), positioning, GTM, growth |
| `user_research.md` | Interview techniques, usability testing, surveys, synthesis (affinity mapping, thematic analysis), UX artifacts |
| `lenny_wisdom.md` | Guide to using the guest CSV data effectively |

These are the original ask-kenny reference files. They remain the canonical source for detailed framework descriptions beyond what `references/frameworks.md` covers.

## Citation Format

When citing Lenny's Podcast content in responses, use this format:

**For direct quotes**:
> "Quote text here" -- Guest Name, Lenny's Podcast

**For paraphrased insights**:
Guest Name discussed [topic] on Lenny's Podcast, noting that [insight].

**For episode references**:
- Guest Name on [topic] (Lenny's Podcast)

Never fabricate episode numbers, guest names, or quotes. If a search does not return relevant results, say so rather than inventing citations.
