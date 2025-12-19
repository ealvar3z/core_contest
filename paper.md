## Goal

A short, graduate-level, structurally complete explanation showing:

> **Proposition.** A next-token model trained solely on text and required to emit factual assertions on underspecified prompts must, for some prompts, produce assertions that are false in at least one world consistent with its training data.

No metaphors. No anthropomorphism. No empirical claims required.

---

## Scope and non-goals

### In scope
- Precise definitions (next-token model, world state, hallucination).
- Minimal assumption set (text-only supervision, underspecification, forced emission).
- Two indistinguishable worlds construction.
- Proof sketch + spoken proof.
- One structural diagram.
- Tight boundaries: what breaks the result (abstention, oracle access, closed-world restriction).
- Minimal reference list with URLs.

### Out of scope
- Benchmarks, failure case compilations, “AI safety” commentary.
- Transformer internals, scaling laws, optimization details beyond cross-entropy.
- Claims about human psychology, beliefs, intent, or “making things up.”
- Claims that RLHF or RAG “solves” hallucination.

---

## Diagram (Mermaid, GitHub rendering)

**Constraint:** must render cleanly in GitHub Markdown and show terminal “false in …” labels fully.

**Label alignment rule:** diagram text must match proposition vocabulary:
- “trained solely on text”
- “underspecified prompt”
- “forced emission”
- “assert φ / assert ¬φ”
- “false in at least one world consistent with training data”


```mermaid
%%{init: {"flowchart": {"nodeSpacing": 70, "rankSpacing": 90}, "themeVariables": {"fontSize": "14px"}}}%%
flowchart LR
  %% Non-Identifiability Under Forced Action

  subgraph W1["World w1"]
    W1F["phi is true"]
  end

  subgraph W2["World w2"]
    W2F["phi is false"]
  end

  CH["Identical observational channel<br/>P(x | w1) = P(x | w2)"]

  M["Next-token model trained solely on text<br/>learns P(x_{t+1} | x_{<=t})"]

  P["Underspecified prompt x_{<=t}<br/>(does not encode which world holds)"]

  F["Forced emission<br/>must emit a factual assertion"]

  A["assert phi"]
  B["assert not phi"]

  E1["false in w2<br/>(world consistent with training data)"]
  E2["false in w1<br/>(world consistent with training data)"]

  W1F --> CH
  W2F --> CH
  CH --> M
  M --> P
  P --> F
  F --> A
  F --> B
  A --> E1
  B --> E2
