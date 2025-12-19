# Hallucination as Non-Identifiability Under Forced Action

## Scope

This document presents a minimal structural result explaining why hallucination is unavoidable in next-token language models under specific assumptions.

The goal is conceptual clarity, not architectural critique or policy advocacy.

---

## Definitions

**Next-token model**  
A conditional language model that estimates a distribution  
\( P(x_{t+1} \mid x_{\le t}) \) and generates text by sampling or decoding from it.

**World state**  
A complete specification of facts external to the text that determines factual correctness.

**Hallucination**  
A generated continuation that asserts a specific factual proposition that is false in at least one world consistent with the model’s training distribution and the given prompt.

---

## Assumptions

1. **Text-only supervision**  
   The model is trained solely on text, without access to external ground-truth referents at inference time.

2. **Underspecified prompts**  
   Some prompts do not uniquely determine the underlying world state.

3. **Forced emission**  
   The model is required to emit a continuation asserting a factual proposition. Abstention is not available.

---

## The Two Indistinguishable Worlds Construction

### Setup

Let:

- \( W = \{w_1, w_2\} \) be two distinct world states.
- \( X \) be the space of all finite text sequences.

Assume:

**(S1) Identical observational channel**  
For all \( x \in X \):

\[
P(x \mid w_1) = P(x \mid w_2)
\]

The worlds differ in at least one factual property, but that difference is never expressed in text.

**(S2) World-differentiating proposition**  
There exists a proposition \( \phi \) such that:

- \( \phi \) is true in \( w_1 \)
- \( \phi \) is false in \( w_2 \)
- the prompt \( x_{\le t} \) does not encode which world holds

**(S3) Next-token learner**  
A model \( M \) is trained to approximate  
\( P(x_{t+1} \mid x_{\le t}) \) from samples of the observational channel.

**(S4) Forced emission**  
Given \( x_{\le t} \), the model must emit a continuation asserting either \( \phi \) or \( \neg \phi \).

---

### Lemma 1: Irreducible posterior uncertainty

Because the observational channel is identical,

\[
P(w_1 \mid x_{\le t}) = P(w_2 \mid x_{\le t})
\]

for all prompts \( x_{\le t} \).

This holds even with infinite data, so long as the observational channel is fixed.

---

### Lemma 2: Any factual commitment is false in at least one world

If the model asserts \( \phi \):

- correct in \( w_1 \)
- false in \( w_2 \)

If the model asserts \( \neg \phi \):

- correct in \( w_2 \)
- false in \( w_1 \)

Thus, every deterministic factual assertion is incorrect in at least one admissible world.

---

### Lemma 3: Probabilistic decoding does not resolve the contradiction

Sampling produces an assertion with probability 1.  
That assertion is false in at least one world consistent with the prompt and training data.

Calibration does not imply correctness under non-identifiability.

---

## Proposition

**Proposition**  
A next-token model trained solely on text and required to emit factual assertions on underspecified prompts must, for some prompts, produce assertions that are false in at least one world consistent with its training data.

This satisfies the definition of hallucination.

---

## Diagram (Structural Proof)

```

```
    World w₁                     World w₂
```

(φ is true)                  (φ is false)
│                            │
└───────────┬────────────────┘
│
Identical Text Channel
P(x | w₁) = P(x | w₂)
│
▼
Next-Token Model
│
Forced Emission
┌────────────┴────────────┐
assert φ                assert ¬φ

```

---

## Consequences

- Scaling model size or compute improves approximation of  
  \( P(x_{t+1} \mid x_{\le t}) \) but does not restore identifiability.
- Calibration changes confidence estimates, not truth conditions.
- Retrieval or oracle access changes the observational channel and breaks the result.
- Allowing abstention removes the necessity of false assertion.

---

## Spoken Proof (Recording Script)

I will show that hallucination is unavoidable in next-token models under three assumptions: text-only learning, underspecified prompts, and forced emission.

Consider two distinct world states, \( w_1 \) and \( w_2 \), which differ in a factual property but induce identical text distributions.  
For all observable texts \( x \), \( P(x \mid w_1) = P(x \mid w_2) \).  
No amount of text alone can distinguish which world is true, even with infinite data, so long as the observational channel is fixed.

A next-token model trained on this data learns \( P(x_{t+1} \mid x_{\le t}) \).  
Because the observational channel is identical, the posterior over worlds remains equal for every prompt.

Now consider an underspecified prompt and a proposition \( \phi \) that is true in \( w_1 \) and false in \( w_2 \).  
At inference time, the model must answer.  
If it asserts \( \phi \), it is wrong in \( w_2 \).  
If it asserts \( \neg \phi \), it is wrong in \( w_1 \).

Sampling does not help.  
Some assertion is always produced, and that assertion is false in at least one admissible world.

Therefore, under text-only supervision, underspecification, and forced emission, hallucination is unavoidable.

---

## Open Research Question

How should a system optimally trade off abstention against usefulness when operating under non-identifiable uncertainty?

---

## Selected References

- **Underspecification Presents Challenges for Credibility in Modern Machine Learning**  
  D’Amour et al., NeurIPS 2020  
  https://arxiv.org/abs/2011.03395

- **A Neural Probabilistic Language Model**  
  Bengio et al., Journal of Machine Learning Research, 2003  
  https://www.jmlr.org/papers/volume3/bengio03a/bengio03a.pdf

- **Language Models are Unsupervised Multitask Learners**  
  Radford et al., 2019  
  https://cdn.openai.com/better-language-models/language_models_are_unsupervised_multitask_learners.pdf

- **Planning and Acting in Partially Observable Stochastic Domains**  
  Kaelbling, Littman, Cassandra, Artificial Intelligence Journal, 1998  
  https://www.cs.cmu.edu/~ggordon/780-fall07/kaelbling98.pdf

- **On Calibration of Modern Neural Networks**  
  Guo et al., ICML 2017  
  https://arxiv.org/abs/1706.04599

- **Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks**  
  Lewis et al., NeurIPS 2020  
  https://arxiv.org/abs/2005.11401
```
