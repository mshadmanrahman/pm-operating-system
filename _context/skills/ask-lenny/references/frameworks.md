# PM Framework Reference

Detailed guide for selecting and applying product management frameworks. Use this when the user needs help choosing the right framework or understanding how to apply one.

## Framework Selection Matrix

| Situation | Recommended Framework | Why |
|-----------|----------------------|-----|
| "Too many feature requests" | RICE or ICE | Quantifies competing priorities objectively |
| "Users churn after signup" | AARRR + Retention curves | Pinpoints where the funnel breaks |
| "What should our strategy be?" | Good Strategy / Bad Strategy | Forces diagnosis before action |
| "How do we find PMF?" | JTBD + Continuous Discovery | Connects user needs to product decisions |
| "Teams are misaligned" | North Star Metric + OKRs | Creates shared definition of success |
| "Feature X: build or skip?" | Kano Model | Distinguishes must-haves from delighters |
| "New product idea" | Working Backwards | Tests value proposition before building |
| "Shipping too slowly" | Shape Up | Constrains scope via appetite, not estimates |
| "Which user problem matters most?" | Opportunity Solution Trees | Maps outcomes to discoverable opportunities |
| "Entering a new market" | TAM/SAM/SOM + Blue Ocean | Sizes opportunity and finds uncontested space |

## Frameworks in Detail

### Jobs-to-be-Done (JTBD)

**Origin**: Clayton Christensen, refined by Bob Moesta and Alan Klement.

**Core idea**: People do not buy products; they hire them to make progress in a specific circumstance. Understanding the "job" unlocks better product decisions than demographic segmentation.

**When to use**:
- Exploring a new problem space
- Understanding why users switch to or from your product
- Defining positioning and messaging
- Identifying underserved segments

**How to apply**:
1. Conduct Switch Interviews (Bob Moesta's method): find the push, pull, anxiety, and habit forces
2. Map the functional, emotional, and social dimensions of the job
3. Identify competing solutions (including non-consumption)
4. Design around the full job, not just the functional task

**Anti-patterns**:
- Treating JTBD as just "user needs" rebranded
- Ignoring the emotional and social dimensions
- Skipping the "forces of progress" diagram (push, pull, anxiety, habit)
- Using JTBD for incremental feature work instead of strategic product decisions

**Lenny's guests on JTBD**: Bob Moesta (2 episodes), Teresa Torres, Jason Fried

---

### RICE Prioritization

**Origin**: Intercom (Sean McBride).

**Core idea**: Score features by Reach (how many users), Impact (how much per user), Confidence (how sure you are), divided by Effort (person-weeks).

**When to use**:
- Backlog has 20+ items competing for attention
- Need to justify priorities to stakeholders with data
- Want to reduce bias in prioritization discussions

**How to apply**:
1. Define a time period (quarter)
2. Estimate Reach: number of users affected per quarter
3. Estimate Impact: 3 (massive), 2 (high), 1 (medium), 0.5 (low), 0.25 (minimal)
4. Set Confidence: 100% (high), 80% (medium), 50% (low)
5. Estimate Effort: person-months
6. Score = (Reach x Impact x Confidence) / Effort

**Anti-patterns**:
- Gaming the confidence score to boost pet projects
- Using RICE for strategic bets (it favors incremental wins)
- Not revisiting scores after learning new information
- Treating the score as a final answer instead of a conversation starter

---

### Opportunity Solution Trees (Teresa Torres)

**Origin**: Teresa Torres, Continuous Discovery Habits.

**Core idea**: Start with a desired outcome, discover opportunities (unmet needs, pain points, desires) through continuous user research, then brainstorm solutions and test with experiments.

**When to use**:
- Building a discovery practice from scratch
- Team is shipping features without validating they solve real problems
- Need to connect business outcomes to user research
- Want to move from output-driven to outcome-driven roadmaps

**How to apply**:
1. Define the outcome (business metric you want to move)
2. Discover opportunities through weekly customer interviews
3. Map opportunities as branches under the outcome
4. Brainstorm multiple solutions per opportunity
5. Design assumption tests (not full MVPs) for the riskiest assumptions
6. Compare solutions, pick the strongest, build and measure

**Anti-patterns**:
- Treating the tree as a one-time exercise instead of a living document
- Skipping weekly interviews ("we already know our users")
- Jumping straight to solutions without mapping opportunities
- Testing only desirability, ignoring feasibility and viability assumptions

---

### North Star Metric

**Origin**: Sean Ellis / Growth Hacking community; popularized by Amplitude.

**Core idea**: A single metric that captures the core value your product delivers to users. Aligns every team around one definition of success.

**When to use**:
- Teams optimizing different metrics that conflict
- Need to align product, engineering, marketing, and sales
- Evaluating whether a feature actually matters

**How to apply**:
1. Identify what "value delivered" means for your product
2. Choose a metric that increases only when users get value (not just revenue)
3. Break it into input metrics that teams can influence directly
4. Review weekly; course-correct when inputs diverge from the North Star

**Examples**:
- Airbnb: Nights booked
- Spotify: Time spent listening
- Slack: Messages sent within teams
- For marketplaces: Qualified applications submitted (or matched leads)

**Anti-patterns**:
- Choosing revenue as the North Star (it is a lagging indicator)
- Picking a metric no single team can influence
- Changing the North Star every quarter
- Ignoring input metrics and only watching the top-level number

---

### ICE Scoring

**Origin**: Sean Ellis.

**Core idea**: Lightweight alternative to RICE. Score each idea on Impact, Confidence, and Ease (1-10 each). Average or multiply.

**When to use**:
- Quick triage of a short list (under 15 items)
- Growth experiments and A/B test prioritization
- Teams that find RICE too heavy

**Anti-patterns**:
- Using for strategic decisions (too simplistic)
- Letting one person score alone (calibrate as a team)
- Not recalibrating after experiments run

---

### Kano Model

**Origin**: Noriaki Kano (1984).

**Core idea**: Features fall into categories based on how their presence/absence affects satisfaction: Must-be (expected), One-dimensional (more is better), Attractive (delighters), Indifferent, Reverse.

**When to use**:
- Deciding what to cut from scope without losing users
- Understanding why a feature got no reaction (it might be Must-be)
- Planning a release that balances table-stakes with wow moments

**How to apply**:
1. Survey users with paired questions: "How would you feel if this feature existed?" / "How would you feel if it did not?"
2. Classify each feature into Kano categories based on response pairs
3. Prioritize: Must-be first (no launch without them), then One-dimensional, then Attractive

**Anti-patterns**:
- Assuming Attractive features stay attractive forever (they decay to Must-be over time)
- Skipping the survey and guessing categories
- Ignoring Must-be features because they are "boring"

---

### Working Backwards (Amazon)

**Origin**: Amazon (Colin Bryar, Bill Carr).

**Core idea**: Write the press release and FAQ before building anything. If you cannot write a compelling press release, the product idea is not clear enough.

**When to use**:
- New product or major new capability
- Aligning leadership on vision before committing resources
- Testing whether the value proposition is crisp

**How to apply**:
1. Write a one-page press release: headline, subheading, problem, solution, quote from a leader, quote from a customer, call to action
2. Write an internal FAQ: hard questions about feasibility, cost, competition
3. Write an external FAQ: user questions about how it works
4. Iterate until the press release is compelling and the FAQs have solid answers
5. Only then start building

**Lenny's guests on this**: Bill Carr (Amazon VP, 2 episodes)

**Anti-patterns**:
- Writing the press release after the product is built (defeats the purpose)
- Making the press release too long or technical
- Skipping the FAQ section

---

### Shape Up (Basecamp)

**Origin**: Ryan Singer / Basecamp.

**Core idea**: Work in 6-week cycles. Define appetite (how much time a problem is worth), shape the solution at the right level of abstraction, then let teams figure out scope within the constraint.

**When to use**:
- Tired of never-ending sprints and scope creep
- Want to give teams more autonomy
- Need to balance big bets with small improvements

**Key concepts**:
- **Appetite**: "This is worth 2 weeks, not 6" (scope follows time, not the reverse)
- **Shaping**: Define the approach at a medium fidelity; not wireframes, not just user stories
- **Betting table**: Leadership picks what to bet on each cycle
- **Circuit breaker**: If it is not done in 6 weeks, it does not automatically continue
- **Cool-down**: 2 weeks between cycles for cleanup and exploration

**Anti-patterns**:
- Running Shape Up as rebranded sprints (missing the betting table and circuit breaker)
- Shaping too concretely (turns into a spec) or too abstractly (teams flounder)
- Skipping cool-down periods

---

### AARRR (Pirate Metrics)

**Origin**: Dave McClure.

**Core idea**: Measure the user lifecycle in five stages: Acquisition, Activation, Retention, Revenue, Referral. Fix the leakiest stage first.

**When to use**:
- Diagnosing where growth is broken
- Building a metrics dashboard from scratch
- Aligning teams on which funnel stage to focus

**Key insight from Lenny's guests**: Fix retention before acquisition. Pouring users into a leaky bucket wastes money. (Brian Balfour, Casey Winters, Elena Verna all emphasize this.)

**Anti-patterns**:
- Optimizing acquisition while retention is broken
- Measuring all five equally instead of focusing on the constraint
- Confusing activation with signup (activation = user experiences core value)

---

### Good Strategy / Bad Strategy (Richard Rumelt)

**Origin**: Richard Rumelt.

**Core idea**: Good strategy has three parts: a diagnosis (what is going on), a guiding policy (the approach), and coherent actions (specific steps). Bad strategy is fluff, goals masquerading as strategy, or laundry lists.

**When to use**:
- Annual or quarterly strategy setting
- Evaluating whether your "strategy doc" is actually a strategy
- Diagnosing why execution feels scattered

**The kernel test**: Can you state your strategy as: "Our diagnosis is X. Our guiding policy is Y. Our coherent actions are Z"? If not, you do not have a strategy.

**Anti-patterns**:
- Calling a list of goals a strategy
- Using buzzwords without a clear diagnosis
- Setting a guiding policy that does not involve tradeoffs (if it does not say no to something, it is not a strategy)

## Choosing Between Frameworks

**Speed vs. rigor tradeoff**:
- Need an answer in 30 minutes: ICE
- Need stakeholder buy-in: RICE (numbers help)
- Need strategic clarity: Good Strategy kernel
- Need user insight: JTBD + OST
- Need team alignment: North Star + OKRs

**Stage-dependent selection**:
- Pre-PMF: JTBD, Working Backwards, Continuous Discovery
- Growth stage: AARRR, North Star, RICE
- Mature/enterprise: Kano, Good Strategy, Shape Up

**Common mistake**: Using a growth-stage framework (RICE) for a pre-PMF problem. At pre-PMF, you do not have enough data for Reach or Impact estimates. Use qualitative frameworks (JTBD, discovery interviews) instead.
