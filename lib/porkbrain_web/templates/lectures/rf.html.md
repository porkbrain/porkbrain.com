# Reinforcement learning
This body is diary which I keep while studying reinforcement learning resources.

## Lessons
Lessons are structured around some center point which is iconic during my self-study. I include here passages I consider crucial and my own notes and thoughts.

### Tic-tac-toe
I use a [textbook by Sutton and Barto][sutton-barto-book] and series of [lectures by David Silver][david-silver-lectures] as guidance. From now on when I refer to "the textbook" I refer to [1][sutton-barto-book].

The textbook commands supplementary readings which are more of a mathematical nature, namely a) [Bertsekas and Tsitsiklis 1996][neuro-dyn-programming] b) [Szepesvari 2010][rl-algorithms].

> Learning from interaction is a foundational idea underlying nearly all theories of learning and intelligence.
\
\
[the textbook, p. 1][sutton-barto-book]

In my PAM project the fundamental idea is an interaction with a _peer_. The interactions are based on observing the environment.

**Closed-loop problem** is such problem where an agent's actions influence its _later_ inputs. Closed-loop property is one of the three distinguishing features of reinforcement learning. The second feature is that  consequences of agent's actions are not always immediately reflected in the inputs, but rather stretch over time. The third feature is that the agent is not directly instructed on which actions to take.

There's a distinction between supervised, unsupervised and reinforcement learning. While the difference between RL and SL is clear, between it's more subtle UL and RL. While the goal of UL is to uncover hidden structure in data without being given examples, the goal of RL is to maximize a reward signal (this goal _might_ involve uncovering hidden structure in process).

One of challenges of RL is striking balance between _exploitation_ and _exploration_. That is how often to take the best action known to an agent, and how often to try out new actions to see whether there's something better out there. Exploitation is presented here as a way of escaping local maxima.

We can identify four main elements in RL besides an agent and the environment.

A **policy** is a function that when given current state _S_, it commands what action _A_ to take. There's one important property we leverage: agent given _S_ at _t_ acts the same as if it was replayed the whole history _H<sub>t<sub>_. There always exists an optimal policy, i.e. a way how to behave optimally in an environment

A **reward**, or reward signal, defines the goal of the agent. Agent's goal is to maximize the reward over time in the environment. The signal indicates what is good in an immediate sense.

A **value function** is agent's estimate of what is good in a long run. Over time agent learn that state _S_ is followed by _S'_ if _A_ is taken, and then followed by _S''_ if _A'_ is taken and so on. The value of the latter states propagate to _S_. I like to think about the value function as of agent's intuition. It gives estimates based on current reward signal and what it feels is likely to follow. For example an amateur chess agent's value function would estimate a value of each state to be the material advantage. It's over time, as the agent builds the intuition, that it learns the more nuanced aspects of the game.

The example to work on in the first chapter of the textbook is tic-tac-toe. I have an [implementation][bausano-tic-tac-toe] of this introductory problem. It's solved with dynamic programming.

I have a map which connects each of the `3^9 = 19683` states with a number. The number defaults to `1` for all states where the agent has won (there are 3 `X`s in a row), `0` for all states that the agent lost or drew, `0.5` for all other states.

Every time the agent made an exploitation move, I update the value of the state to be a fraction of the difference between the next state value and current state value. This is called the _temporal difference_. The fraction _step size_, denoted _α_, is akin to a learning rate.

```
V(s) += α[V(s') - V(s)]
```

This has the property that the value of the terminal states, which we assigned to be `1` iff agent won, otherwise `0`, propagates up.

To end this lecture on a more ambitious note, let me quote a passage which resonated with me:
> Reinforcement learning can be used at both high and low levels in a system.  Although the tic-tac-toe player learned only about the basic moves of the game, nothing prevents reinforcement learning from working at higher levels where each of the “actions” may itself be the application of a possibly elaborate problem-solving method.  In hierarchical learning systems, reinforcement learning can work simultaneously on several levels.
\
\
[the textbook, p. 15][sutton-barto-book]

## References
1. [Reinforcement Learning: An Introduction; Richard S. Sutton and Andrew G. Barto ©2014, 2015][sutton-barto-book]
2. [Algorithms for Reinforcement Learning; Csaba Szepesvari][rl-algorithms]
3. [Neuro-Dynamic Programming; Dimitri P. Bertsekas and John N. Tsitsiklis][neuro-dyn-programming]


<!-- Invisible List of References -->
[sutton-barto-book]: https://web.stanford.edu/class/psych209/Readings/SuttonBartoIPRLBook2ndEd.pdf
[david-silver-lecture-1]: https://www.davidsilver.uk/wp-content/uploads/2020/03/intro_RL.pdf
[david-silver-videolecture-1]: https://www.youtube.com/watch?v=2pWv7GOvuf0
[david-silver-lectures]: https://www.davidsilver.uk/teaching
[neuro-dyn-programming]: https://www.researchgate.net/publication/216722122_Neuro-Dynamic_Programming
[rl-algorithms]: https://sites.ualberta.ca/~szepesva/rlbook.html
[bausano-tic-tac-toe]: https://github.com/bausano/rl-algorithms/tree/master/tic-tac-toe
