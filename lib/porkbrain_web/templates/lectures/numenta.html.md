# Numenta
[Numenta][numenta-homepage] is a research lab co-founded by Jeff Hawkins. Numenta consists of theoretical neuroscientists and machine learning experts. I've heard Jeff [interview][ai-podcast-jeff-hawkins] with Lex Fridman. Their ideas resonated with me, and some were a more mature versions of ideas I had before (or they at least shared similar underlying believes).

This body contains notes produced when reviewing the Numenta material. How do I decide which extracts from the book to include here?

```rust
fn should_body_include(b: MarkDownDocument, p: Paragraph) -> bool {
     I.have_something_to_say_about(p) || (is_illustrative(p) && !is_trivial())
}
```

## HIERARCHICAL TEMPORAL MEMORY
Paper titled [HIERARCHICAL TEMPORAL MEMORY including HTM Cortical Learning Algorithms][htm-paper] is the first paper presented by the Numenta lab. I highlight interesting points from the paper, concepts I have thought about independently before, parts which are confusing to me and statements I find harder to believe without further inspection.

> As you ascend the hierarchy there is always convergence, multiple elements in a child region converge onto an element in a parent region. However, due to feedback connections, information also diverges as you descend the hierarchy.
\
\
(page 8)

This is somewhat similar to what I conceptually wanted to achieve with visual cortex of PAM machines. [SOM][som]-like hierarchical structure which on lower level recognizes common details and puts them together into higher levels. The advantage I saw in this is that already learned structures can be reused, which is also what this paper hints.⌋

HTM is inspired by the columns of neocortex. Since this is an important observation, that brain is structured into self-similar columns, it seems to inspire all Numenta algorithms in some way.

_Sparse Distributed Representations_ is another key concept taken from the brain. Sparse refers to the fact that there are about 2% of neurons are active at a time when brain operates. Since there are a lot of neurons, there are a lot of ways to pick 2% of them with minimal overlap. This gives the network robustness.
Distributed refers to the need of many neurons activations to convey some full concept.

> [...] The first thing an HTM region does is to convert its input into a sparse distributed representation.For example, a region might receive 20,000 input bits. The percentage of input bits that are “1” and “0” might vary significantly over time. One time there might be 5,000 “1” bits and another time there might be 9,000 “1” bits. The HTM region could convert this input into an internal representation of 10,000 bits of which 2%, or 200, are active at once, regardless of how many of the input bits are “1”. As the input to the HTM region varies over time, the internal representation also will change, but there always will be about 200 bits out of 10,000 active.
\
It may seem that this process generates a large loss of information as the number of possible input patterns is much greater than the number of possible representations in the region. However, both numbers are incredibly big. The actual inputs seen by a region will be a miniscule fraction of all possible inputs. Later we will describe how a region creates a sparse representation from its input. The theoretical loss of information will not have a practical effect.
\
\
(page 11-12)

Maybe another reason this process doesn't lose a lot of information could come from the fact that we're trying to predict a non random stream of data. Therefore one [binary number conveys less than one bit of information][info-theory], the input can be compressed.

### Prediction
Some key properties of HTM prediction as described by the paper
1. **Prediction is continuous.**
2. **Prediction occurs in every region at every level of the hierarchy.**
3. **Predictions are context sensitive.** Hence short term memory is important. One of the properties which makes the algorithm temporal. This ability is known as “variable order” memory.
4. **Prediction leads to stability.** The higher in hierarchy we go, the more stable the outputs are. When I was thinking about the algorithm for visual cortex for PAM, this was one of the key properties I was looking for.
5. **A prediction tells us if a new input is expected or unexpected.** We can then model the algorithm in a way where it seeks novelty.
6. **Prediction helps make the system more robust to noise.**

> [...] It was discovered that most or all regions in the neocortex have a motor output, even low level sensory regions.
\
\
(page 18)

I wonder how do we have long conscious sequences of thoughts. Since a thought does not require a motor output. Maybe there could be a region in the machine which gets fed inputs from other regions. If the input is language, the machine has an internal dialog. If the input is kind of visual, it would be imagining what something looks like.

> The proximal dendrite segment receives feed-forward input and the distal dendrite segments receive lateral input from nearby cells.
\
\
(page 19)

> One is the concept of “potential synapses”. This represents all the axons that pass close enough to a dendrite segment that they could potentially form a synapse. The second is called “permanence”. This is a scalar value assigned to each potential synapse. The permanence of a synapse represents a range of connectedness between an axon and a dendrite. Biologically, the range would go from completely unconnected, to starting to form a synapse but not connected yet, to a minimally connected synapse, to a large fully connected synapse. The permanence of a synapse is a scalar value ranging from 0.0 to 1.0. Learning involves incrementing and decrementing a synapse’s permanence. When a synapse’s permanence is above a threshold, it is connected with a weight of “1”. When it is below the threshold, it is unconnected with a weight of “0”.
\
\
(page 20)

How to model inhibition? Either on neuron level or on synapse level. For example if I made 80% of synapses exhibitory and 20% inhibitory, how would that translate to the final number of neurons which are active. If I want to have simple learning rules, how would inhibition be trained? Could you use inhibition to convert input into its sparse representation?

### Region

_Spatial Pooler_ refers a process of matching patterns which are spatially similar, that is the position of their on and off bits are close. It's a way of compressing the input information. The process has following steps:
1. learning the connections to each column from a subset of the inputs
2. determining the level of input to each column
3. using inhibition to select a sparse set of active columns

> This principle of encoding an input differently in different contexts is a universal feature of perception and action and is one of the most important functions of an HTM region. It is hard to overemphasize the importance of this capability.
\
\
(page 22)

> The general rule used by an HTM region is the following. When a column becomes active, it looks at all the cells in the column. If one or more cells in the column are already in the predictive state, only those cells become active. If no cells in the column are in the predictive state, then all the cells become active. You can think of it this way, if an input pattern is expected then the system confirms that expectation by activating only the cells in the predictive state. If the input pattern is unexpected then the system activates all cells in the column as if to say “the input occurred unexpectedly so all possible interpretations are valid”.
\
\
(page 23)

This is beautiful.

> We use the term “temporal pooler” to describe the two steps of adding context to the representation and predicting.  By creating slowly changing outputs for sequences of patterns,  we are in essence “pooling” together different patterns that follow each other in time.
\
\
(page 25)

The paper suggests using binary weights and permanence coefficient for each synapse, with a global threshold on when synapse is considered to be established. The idea of separating the lifetime into a scalar and then having on/off state sounds interesting. Although in the interview, Jeff gave the reason for binary weights to be that the brain did it, and therefore we shouldn't do scalars. I am not sure about the reasoning.

> We want all our columns to represent non-trivial patterns in the input.  This goal can be achieved by setting a minimum threshold of input for the column to be active.  For example, if we set the threshold to 50, it means that a column must have a least 50 active synapses on its dendrite segment to be active, guaranteeing a certain level of complexity to the pattern it represents.
\
\
(page 27)

An elaboration on how does the threshold guarantee non trivial patterns should follow. Maybe that's where the intuition guides, nonetheless some more robust explanation is needed.

In summary, the paper stress following:
1. **Use all columns.** Can be done by boosting activity of neurons which fire less than their neighbors.
2. **Maintain desired density.** Make a radius of inhibition around a neuron.
3. **Avoid trivial patterns.** As noted above, I am not sure about the advice.
4. **Avoid extra connections.** Maintain neuron ttl.
5. **Self adjust receptive fields.**

💡 Since each column is attached to a slice of the input, find out whether it is beneficial to make overlapping columns and whether they should be proximate or distributed.

### Appendix B: A Comparison of Layers in the Neocortex and an HTM Region

> There is variation in the thickness of the layers in different regions of the neocortex and some disagreement over the number of layers.  The variations depend on what animal is being studied, what region is being looked at, and who is doing the looking.  For example, in the image above, layer 2 and layer 3 look easily distinguished, but generally this is not the case.  Some scientists report that they cannot distinguish the two layers in the regions they study, so often layer 2 and layer 3 are grouped together and called “layer 2/3”.  Other scientists go the opposite direction, defining sub-layers such as 3A and 3B.
\
\
(page 56)

A disadvantage of naming your layers sequentially (e. g. 1-6) is that you cannot easily remove or add a layer later on due to novel research without making large volume of to-date literature confusing. The system works well only for immutable sequences (such as king's name ordinals). But how are they supposed to give they layers representative names when they don't know their function.

Also how do you define a sub-layer 3A and 3B, you still have 2 to deal with. Instead of squashing the two layers together, a new one is created.

> When scientists use probes to see what makes neurons become active, they find that neurons that are vertically aligned, across different layers, respond to roughly the same input.
\
\
(page 57)

No citation here. I understand that the paper targets computer science people, but that doesn't mean the citations wouldn't be useful.

> [...] Mini-columns are about 30um in diameter.
\
\
(page 58)

**μm**

> [...] On the right is a conceptual drawing of a mini-column (from Peters and Yilmez). In reality is skinnier than this.
\
\
(page 58)

The later sentence is redundant, as it's explicitly and implicitly asserted. (Also a tiny screen where a pixel size would be on a nm orders of magnitude, the actual neuron mini-column would be thicker.)

I propose a new naming for the layers based on the function I inscribe them:
1. layer receives a feedback from its parent, hence it's a _feedback layer_.
2. and 3. layer is the _direct output layer_.
4. layer receives an input from its child, forwards some of it to other layers and some of it to parent. It also goes away the further the column is to a sensory input. It's the _feedforward layer_.
5. layer is involved in motor generation, hence it's a _action layer_. Its output also goes to [thalamus][thalamus], which then decides whether to forward the output to parent. Wikipedia claims that thalamus control alertness and sleep.

What follows in the paper is an interpretation of the layers function.

## References
1. [Numenta - Advancing Machine Intelligence with Neuroscience][numenta-homepage]
2. [Jeff Hawkins: Thousand Brains Theory of Intelligence | Artificial Intelligence (AI) Podcast][ai-podcast-jeff-hawkins]
3. [HIERARCHICAL TEMPORAL MEMORY including HTM Cortical Learning Algorithms][htm-paper]
4. [Self-organizing map][som]
5. [Information theory][info-theory]
6. [Thalamus][thalamus]

<!-- Invisible List of References -->
[numenta-homepage]: https://numenta.com
[ai-podcast-jeff-hawkins]: https://www.youtube.com/watch?v=-EVqrDlAqYo
[htm-paper]: https://numenta.com/assets/pdf/whitepapers/hierarchical-temporal-memory-cortical-learning-algorithm-0.2.1-en.pdf
[som]: https://en.wikipedia.org/wiki/Self-organizing_map
[info-theory]: /lectures/info-theory
[thalamus]: https://en.wikipedia.org/wiki/Thalamus
