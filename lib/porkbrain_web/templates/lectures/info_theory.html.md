# Information theory
This body is a diary which I update as I study information theory. I use a textbook [Information theory: A Tutorial Introduction][textbook-jim-stone] by Jim stone. When I reference a figure from this textbook, it can be found in the [associated resources][textbook-jim-stone-figures] on author's page.

## Lessons

### H(X) = &Sigma; -p(x<sub>i</sub>) log p(x<sub>i</sub>)
We begin the study of information theory by developing a rudimentary intuition about entropy. The goal is to show where is the central equation of entropy, as seen in the lesson title, coming from.

Information theory works with a unit of information called a bit. A bit is like an answer to a single yes/no question.

There's a distinction between a bit and a binary digit. The distinction is best understood by an example:

We're on a cross road. We can either take the route to the left or to the right. Left is (by some arbitrary convention) represented as 0, and right is represented by 1. Consider following scenarios:
1. We know we ought to take left to get to the goal. When we're given binary digit 0, we learned nothing new. We've got still the same amount of information, same amount of bits.
2. We don't know at all which route to take to get to the goal. We've got a 50% probability to take the correct route, i.e. we consider both routes to lead is to the goal equally likely. We're presented with binary number 0. We've obtained one bit since now we can resolve our uncertainty. Unlike in the _1._ scenario, we learned something new.
3. We forgot which route we should take, however we're about 75% sure that the goal is to the left. We've been presented with 0. Although we've got one binary digit, we received less than one bit of information. One cannot be given half a binary digit, but they can be given e.g. half a bit of information.

In general, to choose between _`m`_ equally probable alternatives, we need _`log(m)`_ bits.

> How can we tell if a communication channel is being used as efficiently as possible?

This is a fundamental question which information theory asks.

#### Encodings examples

_Run-length encoding_ would transmit information by stating how long until a change in structure. In another words, after how many repetitions of last element do we switch to another element. One scenario this might be useful in is transmission of black and white images. Since only two colours are possible, there are likely going to be long sequences of each colour.

_Difference coding_ assumes that the difference between adjacent elements (e.g. pixels if we have an image as example) is going to be low. Let's see how this for images with 256 shades of grey (see [page 10][textbook-jim-stone-figures]). From the original, we produce an image which only considers the difference between the grey levels of adjacent pixels. In the example image, 99% of the difference values are in a span of +-63. This allows us to reduce the size of a 99% pixel from 8 bits to 7 bits. Similar method called [_differential pulse code modulation_][differential-pulse-code-modulation] is used to transmit voices over phone.

#### Information pipeline

```
+--------+       +---------+       +---------+       +---------+       +--------+
|        |   s   |         |   x   |         |   y   |         |   s'  |        |
| source | ----> | encoder | ----> | channel | ----> | decoder | ----> | target |
|        |       |   g(s)  |       | y = x+n |       |         |       |        |
+--------+       +---------+       +---------+       +---------+       +--------+

```

A source generates messages. A message _`s`_ is a sequence of symbols. An encoder encodes the message into an input _`x = g(s)`_ communicates the input over a channel. The input is a sequence of codewords. The channel spits out an output _`y = x + n`_. The channel may add noise _`n`_, inducing error. A decoder then converts the output to a reconstructed message _`s'`_.

The _channel capacity_ is the maximum amount of information which can be communicated. it can be measured in terms of information per symbol, or information per second.

#### Shannon's desiderata

1. **Continuity**. The amount of information associated with an outcome changes smoothly as the probability of that outcome changes. I can see how this is paramount, but I struggle to put it to words. If this property didn't hold, we would have to work with intervals and bunch of algebraic operations wouldn't be suitable?
2. **Symmetry**. The amount of information associated with a sequence of outcomes does not depend on the order in which those outcomes occur. I find this phrased oddly. I don't understand to what does this refer to. Does this refer to commutativity of multiplication? It surely cannot refer to saying that order in which I am presented with outcomes doesn't matter, because the outcomes might affect my expectations, which changes the amount of information of future outcomes. [Symmetry and information theory][symmetry-in-information-theory] is a paper which might illuminate this property better than the textbook has so far.
3. **Maximal value**. The most information we can get from an outcome is if we're deciding between equally probable outcomes. E.g. we will show that a fair coin always gives us more bits on average than a biased coin.
4. **Additive**. The information associated with a set of outcomes is obtained by summing their probabilities. Since `log(x`<sub>`1`</sub>` x`<sub>`2`</sub>`) = log(x`<sub>`1`</sub>`) + log(x`<sub>`2`</sub>`)`, logarithms convey this property.

_Shannon's information_ is a measure of _surprise_. The more we are certain about an outcome, the more surprised we are when it doesn't occur. To address the need for larger surprise for outcomes with lower probability, we can work with `p(x)`<sup>`-1`</sup>. The amount of surprise we get from an outcome `x` occurring is `h(x) = -log p(x)` bits. The less likely the outcome, the more surprised we are. For example, event with probability of `0.25` results in `-log(0.5) = 2` bits.

> **Entropy** is an average surprise of a variable `X` with distribution `p(X)`, denoted by `H(X)`.

Why is surprise an information? Because information is novelty we didn't expect before, so the more surprised we are the more information we got to adjust our believes/expectations. I wonder what's an optimal amount of entropy for a news article about topic `T`. What's an optimal amount of entropy when we learn? Can a situation where I try to understand moderately alien topic, such as neurogenesis, be apriori deemed as waste of energy, because I lack prerequisite believes/expectations, hence the entropy of such topic is too high? Can this be quantified in some simulation with some artificial agent? Can this be estimated to a degree of usefulness with humans?

Entropy of a variable is the logarithm of _`m`_ equally probable outcomes, i.e. `H(X) = log m` bits. For a fair coin flip, it's `log 2 = 1`. We can raise `2`<sup>`H(X)`</sup> to get the number of equally possible outcomes.

This gets more interesting with a biased coin. There's less uncertainty than with a fair coin flip. Say the chances are 90% head. Even though seeing tail amounts to a lot of surprise, entropy is an _average_ of Shannon's information. On total, averaged, a biased coin flip has always less bits than a fair one.

```
h(xh) = -log(0.9) = 0.15 bits
h(xt) = -log(0.1) = 3.32 bits

For n = 100 flips with 90 heads and 10 tails

H(X) = (90 * (-log 0.9) + 10 * (-log 0.1)) / 100
     = 0.469 bits per coin flip
```

This can be more succinctly written as

> `H(X) = Σ -p(x`<sub>`i`</sub>`) log p(x`<sub>`i`</sub>`)`

Entropy of 0.469 bits implies that the information in 1000 flips could be represented with as little as 469 binary digits. Now we can calculate between how many equally probable outcomes are we choosing when flipping the biased coin described above.

`m = 2`<sup>`H(X)`</sup>` = 2`<sup>`0.469`</sup>` = 1.38`

We can use extend following code to calculate entropy of a random variable `X`, be it a fair coin flip or a biased die roll, etc.
```javascript
const FAIR_COIN = 'fairCoin'
const BIASED_COIN = 'biasedCoin'
const FAIR_DIE = 'fairDie'
const BIASED_DIE = 'biasedDie'

function p(X) {
     return {
          [FAIR_COIN]: [0.5, 0.5],
          [BIASED_COIN]: [0.9, 0.1],
          [FAIR_DIE]: [1/6, 1/6, 1/6, 1/6, 1/6, 1/6],
          [BIASED_DIE]: [0.1, 0.1, 0.1, 0.1, 0.5, 0.1],
     }[X]
}

function H(X) {
     return p(X).reduce((sum, px) => sum - px * Math.log2(px), 0)
}

console.table(
     [FAIR_COIN, BIASED_COIN, FAIR_DIE, BIASED_DIE]
          .map(X => ({ X, pX: p(X), HX: H(X), m: Math.pow(2, H(X)) })),
     ['X', 'pX', 'HX', 'm']
)
```






we can estimate entropy from n samples instead by

x = (x1, ..., xn)

```
H(X) ~= ^h(x) = SUM i=1 to n of -log(p(xi))
```

in essence entropy is measure of uncertaity. reducing uncertainty gives information.

if the likelihookd of an outcome is not dependend on other outcomes, it's said to be independent and identically distributed, iid. the source which generates values from such distribution that is constant over over time is called stationary

if the information is like a sentence, then each outcome (let's say a word) has less entropy than the sequence (sentence) has less entropy than the sum of its individual components entropy.

the unit of informations we use are dependent on the root of the logatithm. with log of 2, we get bits or Shannons. with log of e, we get nats. with log of 10, we get bans.

fun fact about bans - comes from english town of Banburry and was named like that by bletchle park cryptographers. data was tabulated using specil cards banburies printed in Banbury. the method was called banbarismus

## something do to with source
natural signals conveys little info in lots of data. there's a lot of similar values (i.e. image pixels) or information duplication (ie english sentense has lots of word constructs - slovni spojeni, idioms).

the optimal distribution depends on constrains that apply.

on page 45 is something I dont undestand.

> Second, more suble, reason involves the distibution of values in a single. The optiomal distubution for a given comm channel depends on the contrants that apply. For example, if a channel has afixed lower and upper bounds the recoding and iid signl so that all its values occur equally often guarantees that each binary digits carries as much info as possible. This for a channle with fixed bounds the optiomal distubution is uniform.

Why is this a reason that natural signals such as images are dilute? maybe because they don't have a clear bound and some values are much more common than others?

shannons theorem is great because is applies to both independent sequences (such as die rolls) and dependent sequences, such as language.

shannons source coding theorem guarantees that for any message there is an encoding of symbols such that each channel input of C binary digits can convey on average close to C bits of informaiton

## References
1. [Information theory: A Tutorial Introduction by Jim Stone][textbook-jim-stone]
2. [Explain Differential Pulse Code Modulation][differential-pulse-code-modulation]
3. [Symmetry and information theory, Aleks Jakulin][symmetry-in-information-theory]

<!-- Invisible List of References -->
[textbook-jim-stone]: http://jim-stone.staff.shef.ac.uk/BookInfoTheory/InfoTheoryBookMain.html
[textbook-jim-stone-figures]: http://jim-stone.staff.shef.ac.uk/BookInfoTheory/bookInformationTheoryJVS_Figures_v2.pdf
[differential-pulse-code-modulation]: https://electronicspost.com/explain-differential-pulse-code-modulation/
[symmetry-in-information-theory]: https://www.researchgate.net/publication/228753847_Symmetry_and_information_theory
