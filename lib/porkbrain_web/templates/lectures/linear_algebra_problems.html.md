<script>
// Left aligns all figures.
MathJax = {
  chtml: { displayAlign: 'left' }
}
</script>

<!-- Includes tex2html which draws mathematical notation from LaTex online. -->
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js"></script>

# Linear algebra (problems)

## Rank

### 4.6/3.
Assume that the matrix `A` is row equivalent to `B`. Without calculations, list `rank A` and `dim Nul A`. Then find bases for `Col A`, `Row A`, and `Nul A`.
<figure>
\begin{equation}
    A =
    \begin{bmatrix}
        2 & -3 & 6 & 2 & 5\\
        -2 & 3 & -3 & -3 & -4\\
        4 & -6 & 9 & 5 & 9\\
        -2 & 3 & 3 & -4 & 1
    \end{bmatrix}
\end{equation}
\begin{equation}
    B =
    \begin{bmatrix}
        2 & -3 & 6 & 2 & 5\\
        0 & 0 & 3 & -1 & 1\\
        0 & 0 & 0 & 1 & 3\\
        0 & 0 & 0 & 0 & 0\\
    \end{bmatrix}
\end{equation}
</figure>

#### Solution
<figure>
\begin{equation}
    B_{Col A} =
    \set{
        \begin{bmatrix}
            2\\ -2\\ 4\\ -2
        \end{bmatrix};
        \begin{bmatrix}
            6\\ -3\\ 9\\ 3
        \end{bmatrix};
        \begin{bmatrix}
            2\\ -3\\ 5\\ -4
        \end{bmatrix}
    }
\end{equation}
</figure>

<figure>
\begin{equation}
    B_{Row A} =
    \set{
        (2, -3, 6, 2, 5);
        (0, 0, 3, -1, 1);
        (0, 0, 0, 1, -3)
    }
\end{equation}
</figure>

`rank A = dim Col A = dim Row A = card B`<sub>`[Col A]`</sub>` = card B`<sub>`[Row A]`</sub>` = `**`3`**

`rank A + dim Nul A = 5  =>  dim Nul A = 5 - rank A = 5 - 3 = `**`2`**

To find the basis of `Nul A`, let's start with `Bx = 0` and find dependencies between the variables.
<figure>
\begin{equation}
    \begin{bmatrix}
        \frac{3}{2}x_2 - 3x_3 - x_4 - \frac{5}{2}x_5\\
        x_2\\
        \frac{1}{3}x_4 - \frac{1}{3}x_5\\
        -3x_5\\
        x_5
    \end{bmatrix}
    =
    \begin{bmatrix}
        \frac{3}{2}x_2 + \frac{9}{2}x_5\\
        x_2\\
        -\frac{4}{3}x_5\\
        -3x_5\\
        x_5
    \end{bmatrix}
    =
    x_2
    \begin{bmatrix}
        \frac{3}{2}\\ 1\\ 0\\ -0\\ 0
    \end{bmatrix} +
    x_5
    \begin{bmatrix}
        \frac{9}{2}\\ 0\\ -\frac{4}{3}\\ -3\\ 1
    \end{bmatrix}
    \implies
    B_{Nul A} =
    \set{
        \begin{bmatrix}
            \frac{3}{2}\\ 1\\ 0\\ 0\\ 0
        \end{bmatrix};
        \begin{bmatrix}
            \frac{9}{2}\\ 0\\ -\frac{4}{3}\\ -3\\ 1
        \end{bmatrix}
    }
\end{equation}
</figure>

### 4.6/5.
If a 3⨯8 matrix `A` has rank 3, find `dim Nul A`, `dim Row A` and `rank A`<sup>`T`</sup>.

#### Solution
`dim Row A = rank A`<sup>`T`</sup>` = rank A = 3`

`dim Nul A + dim Col A = n  =>  dim Nul A = 8 - dim Col A = 8 - 3 = 5`

### 4.6/7.
Suppose a 4⨯7 matrix `A` has four pivot columns. Is `Col A = ℝ`<sup>`4`</sup>? Is `Nul A = ℝ`<sup>`3`</sup>?

#### Solution
Four pivot columns mean `dim Col A = 4`. `Col A` is in `ℝ`<sup>`4`</sup> because the matrix has 4 rows.

The  `Nul A` represents 3 dimensional space embedded in `ℝ`<sup>`4`</sup>, hence it's not in `ℝ`<sup>`3`</sup>.

### 4.6/24.
A homogeneous system of twelve linear equations in eight unknowns has two fixed solutions that are not multiples of each other, and all other solutions are linear combinations of these two solutions. Can the set of all solutions be described with fewer than twelve homogenous linear equations? If so, how many?

#### Solution
In another words, the null space (homogenous system) spans a plane (2 independent solutions). Therefore the `dim Nul A = 2`. Using following formula `dim Row A + dim Nul A = #unknowns` we can say that `dim Row A = 8 - 2 = 6`. Therefore there are 6 rows with a pivot element and 6 rows without a pivot element in the row space. The set of all solutions can be expressed with 6 equations.

### 4.6/27.
Which of the subspaces `Row A`, `Col A`, `Nul A`, `Row A`<sup>`T`</sup>, `Col A`<sup>`T`</sup>, and `Nul A`<sup>`T`</sup>, are in `ℝ`<sup>`m`</sup> and which are in `ℝ`<sup>`n`</sup>? How many distinct subspaces are in this list?

#### Solution
|  `ℝ`<sup>`m`</sup>    | `ℝ`<sup>`n`</sup>     |
|:-:                    |:-:                    |
| `Row A`<sup>`T`</sup> | `Row A`               |
| `Col A`               | `Col A`<sup>`T`</sup> |
| `Nul A`<sup>`T`</sup> | `Nul A`               |

There are 4 distinct spaces: `Row A = Col A`<sup>`T`</sup>; `Col A = Row A`<sup>`T`</sup>; `Nul A`; `Nul A`<sup>`T`</sup>.

### 4.6/29.
Why the equation `Ax = b` has a solution for all `b` in `ℝ`<sup>`m`</sup> iff the equation `A`<sup>`T`</sup>`x = 0` has only the trivial solution?

#### Solution
**a)** `A`<sup>`T`</sup>`x = 0` having only trivial solution means that there's only the null vector in the `Nul A`, hence `dim Nul A = 0`. Then we can say that `dim Col A + dim Nul A`<sup>`T`</sup>` = m  =>  dim Col A = m`. This means that the `Col A` spans the whole `ℝ`<sup>`m`</sup>.

**b)** If all vectors `b` in `ℝ`<sup>`m`</sup> are represented in the output of `A`, that means that the `col A` spans `ℝ`<sup>`m`</sup>. Therefore the `dim Col A = m`.

### 4/37., 4/38.
In alloys of titanium, additional atoms may be inserted at octahedral or tetrahedral sites. The basis of a crystal lattice for titanium in `ℝ`<sup>`3`</sup> is

<figure>
\begin{equation}
    B =
    \set{
        \begin{bmatrix}
            2.6\\ -1.5\\ 0
        \end{bmatrix};
        \begin{bmatrix}
            0\\ 3\\ 0
        \end{bmatrix};
        \begin{bmatrix}
            0\\ 0\\ 4.8
        \end{bmatrix}
    }
\end{equation}
</figure>

#### 37.
One of the octahedral sites is at **`[x]`**<sub>`B`</sub>. Determine the coordinates of this sites relative to the standard basis of `ℝ`<sup>`3`</sup>.
<figure>
\begin{equation}
    [x]_B =
    \begin{bmatrix}
        \frac{1}{2}\\ \frac{1}{4}\\ \frac{1}{6} \\
    \end{bmatrix}
\end{equation}
</figure>

##### Solution
<figure>
\begin{equation}
    P_{B} [x]_{B} =
    \frac{1}{2}
    \begin{bmatrix}
        2.6\\ -1.5\\ 0
    \end{bmatrix} +
    \frac{1}{4}
    \begin{bmatrix}
        0\\ 3\\ 0
    \end{bmatrix} +
    \frac{1}{6}
    \begin{bmatrix}
        0\\ 0\\ 4.8
    \end{bmatrix}
    =
    \begin{bmatrix}
        1.3\\ 0\\ 0.8
    \end{bmatrix}
\end{equation}
</figure>

#### 38.
One of the tetrahedral sites is at **`[x]`**<sub>`B`</sub>. Determine the coordinates of this sites relative to the standard basis of `ℝ`<sup>`3`</sup>.
<figure>
\begin{equation}
    [x]_B =
    \begin{bmatrix}
        \frac{1}{2}\\ \frac{1}{2}\\ \frac{1}{3} \\
    \end{bmatrix}
\end{equation}
</figure>

##### Solution
<figure>
\begin{equation}
    P_{B} [x]_{B} =
    \frac{1}{2}
    \begin{bmatrix}
        2.6\\ -1.5\\ 0
    \end{bmatrix} +
    \frac{1}{2}
    \begin{bmatrix}
        0\\ 3\\ 0
    \end{bmatrix} +
    \frac{1}{3}
    \begin{bmatrix}
        0\\ 0\\ 4.8
    \end{bmatrix}
    =
    \begin{bmatrix}
        1.3\\ 0.75\\ 1.6
    \end{bmatrix}
\end{equation}
</figure>

## Change of basis
### 4.7/7.
Let `B` and `C` be bases for `ℝ`<sup>`2`</sup>. Find the change-of-coordinates matrix from `B` to `C` and from `C` to `B`.

<figure>
\begin{equation}
    B =
    \begin{bmatrix}
        7 & -3\\
        5 & -1\\
    \end{bmatrix}
    \hspace{1cm}
    C =
    \begin{bmatrix}
        1 & -2\\
        -5 & -2\\
    \end{bmatrix}
\end{equation}
</figure>

#### Solution

<figure>
\begin{equation}
    \begin{bmatrix}
        1 & -2 && 7 & -3\\
        -5 & -2 && 5 & -1\\
    \end{bmatrix}
    =
    \begin{bmatrix}
        1 & -2 && 7 & -3\\
        0 & -8 && -40 & -16\\
    \end{bmatrix}
    =
    \begin{bmatrix}
        1 & -2 && 7 & -3\\
        0 & 1 && -5 & 2\\
    \end{bmatrix}
    =
    \begin{bmatrix}
        1 & 0 && -3 & 1\\
        0 & 1 && -5 & 2\\
    \end{bmatrix}
\end{equation}
</figure>

Hence the change-of-coordinates matrix from `B` to `C` is
<figure>
\begin{bmatrix}
    -3 & 1\\
    -5 & 2\\
\end{bmatrix}
</figure>

To find the change-of-coordinates matrix from `C` to `B`, we take an inverse
<figure>
\begin{equation}
    \frac{1}{-3*2 - (-5)*1}
    \begin{bmatrix}
        2 & -1\\
        5 & -3\\
    \end{bmatrix}
    =
    \begin{bmatrix}
        -2 & 1\\
        -5 & 3\\
    \end{bmatrix}
\end{equation}
</figure>

## Eigenvalues, eigenspaces and eigenvetors
### 5.1/25.
Let λ be an eigenvalue of an invertible matrix `A`. Show that λ<sup>-1</sup> is an eigenvalue of `A`<sup>`-1`</sup>.

#### Solution
1. `Ax = λx`
2. `x = A`<sup>`-1`</sup>`λx`
3. `λ`<sup>`-1`</sup>`x = A`<sup>`-1`</sup>`x`

### 5.1/26.
Show that if `A`<sup>`2`</sup> is the zero matrix, then the only eigenvalue of `A` is 0.

#### Solution
1. `Ax = λx` multiplied by `A` from right
2. `AAx = Aλx` since `AA = A`<sup>`2`</sup>` = 0`
3. `0 = λAx` using first equation to substitute `Ax` for `λA`
4. `0 = λλx`since `x` is an eigenvector it cannot be `0`, so `λ` must be zero

### 5.1/32.
`T` is the transformation on `ℝ`<sup>`3`</sup> that rotates points about some line through the origin. Find an λ and describe eigenspace.

#### Solution
Let vector `u` represent the line about which all points rotate.

The points on the line `u` will stay in their place and won't be rotated. Therefore the line `u` is an eigenspace with `λ = 1`.

## Markov chains
### 1.
A small remote village receives radio broadcasts from two radio stations, a news station and a music station. Of the listeners who are tuned to the news station, 70% will remain listening to the news after the station break that occurs each half hour, while 30% will switch to the music station at the station break. Of the listeners who are tuned to the music station, 60% will switch to the news station at the station break, while 40% will remain listening to the music, Suppose everyone is listening to the news at 8: 15 A.M.


1. Give the stochastic matrix that describes how the radio listeners tend to change stations at each station break. Label the rows and columns.
<figure>
\begin{bmatrix}
    & N & M \\
    N & .7 & .6\\
    M & .3 & .4\\
\end{bmatrix}
</figure>

2. Give the initial state vector.

<figure>
\begin{equation}
    Ps =
    \begin{bmatrix}
        .7 & .6\\
        .3 & .4\\
    \end{bmatrix}
    \begin{bmatrix}
        1\\
        0\\
    \end{bmatrix}
\end{equation}
</figure>

3. What percentage of the listeners will be listening to the music station at 9:25 A.M. (after the station breaks at 8:30 and 9:00 A.M.)?

<figure>
\begin{equation}
    P^2s =
    \begin{bmatrix}
        .67 \\
        .33\\
    \end{bmatrix}
\end{equation}
</figure>
33% of listener will be listening to the music station.

### 2.
A laboratory animal max eat any one of three foods each day. Laboratory records show that if the animal chooses one food on one trial , it will choose the same food on the next trial with a probability of 50%, and it will choose the other roods on the next trial with equal probabilities of 25%.

1. What is the stochastic matrix for this situation?
<figure>
\begin{bmatrix}
    & A & B & C \\
    A & .5 & .25 & .25\\
    B & .25 & .5 & .25\\
    C & .25 & .25 & .5\\
\end{bmatrix}
</figure>

2. If the animal chooses food #1 on an initial trial, what is the probability that it will choose food #2 on the second trial after the initial trial?
<figure>
\begin{equation}
    P^3
    \begin{bmatrix}
        1\\
        0\\
        0\\
    \end{bmatrix}
    =
    \begin{bmatrix}
        \frac{11}{32}\\
        \frac{21}{64}\\
        \frac{21}{64}\\
    \end{bmatrix}
\end{equation}
</figure>

There is ~32% chance it will pick another food.

## Characteristic equation
### 5/13.
Find characteristic equation, eigenvalues and eigenspace.
<figure>
\begin{equation}
    A =
    \begin{bmatrix}
        6   &   -2  &   0\\
        -2  &   9   &   0\\
        5   &   8   &   3
    \end{bmatrix}
\end{equation}
</figure>

#### Solution
The eigenvalues of `A` are the same as of `A`<sup>`T`</sup>.

<figure>
\begin{align*}
    det
    \begin{bmatrix}
        6 - λ   &   -2  &   5\\
        -2  &   9 - λ   &   8\\
        0   &   0   &   3 - λ
    \end{bmatrix}
    = 0\\[2ex]
    (3 - λ)
    \begin{vmatrix}
        6 - λ   &   -2\\
        -2  &   9 - λ
    \end{vmatrix}
    = 0\\[2ex]
    (3 - λ)((6 - λ)(9 - λ) - 4) = 0\\[2ex]
    λ^3 - 18λ^2 + 95λ - 150 = 0
\end{align*}
</figure>

The roots of the polynomial above are 3, 5 and 10. Let's use the roots to find eigenspace.

1. λ = 3
<figure>
\begin{aligned}
    &\begin{bmatrix}
        6 - 3   &   -2  &   5   &&  0\\
        -2  &   9 - 3   &   8   &&  0\\
        0   &   0   &   3 - 3   &&  0
    \end{bmatrix}
    \\[2ex]
    &\begin{bmatrix}
        6   &   -4  &   10   &&  0\\
        -2  &   6   &   8   &&  0\\
        0   &   0   &   0   &&  0
    \end{bmatrix}
    \\[2ex]
    &\begin{bmatrix}
        0   &   14  &   34  &&  0\\
        -2  &   6   &   8   &&  0\\
        0   &   0   &   0   &&  0
    \end{bmatrix}
    \\[2ex]
    &\begin{bmatrix}
        0   &   1  &   \frac{17}{7}  &&  0\\
        -2  &   0   &   -\frac{46}{7}   &&  0\\
        0   &   0   &   0   &&  0
    \end{bmatrix}
    \implies
    \begin{bmatrix}
        \frac{23}{7}\\
        \frac{17}{7}\\
        1
    \end{bmatrix}
\end{aligned}
</figure>

2. λ = 5
<figure>
\begin{aligned}
    &\begin{bmatrix}
        6 - 5   &   -2  &   5   &&  0\\
        -2  &   9 - 5   &   8   &&  0\\
        0   &   0   &   3 - 5   &&  0
    \end{bmatrix}
    \\[2ex]
    &\begin{bmatrix}
        1   &   -2  &   0  &&  0\\
        -2  &   4   &   0   &&  0\\
        0   &   0   &   -2   &&  0
    \end{bmatrix}
    \\[2ex]
    &\begin{bmatrix}
        1   &   -2  &   0  &&  0\\
        0  &   0   &   0   &&  0\\
        0   &   0   &   -2   &&  0
    \end{bmatrix}
    \implies
    \begin{bmatrix}
        2\\
        1\\
        0
    \end{bmatrix}
\end{aligned}
</figure>

2. λ = 10
<figure>
\begin{aligned}
    &\begin{bmatrix}
        6 - 10   &   -2  &   5   &&  0\\
        -2  &   9 - 10   &   8   &&  0\\
        0   &   0   &   3 - 10   &&  0
    \end{bmatrix}
    \\[2ex]
    &\begin{bmatrix}
        2   &   1  &   0  &&  0\\
        0  &   0   &   0   &&  0\\
        0   &   0   &   -7   &&  0
    \end{bmatrix}
    \implies
    \begin{bmatrix}
        -\frac{1}{2}\\
        1\\
        0
    \end{bmatrix}
\end{aligned}
</figure>

### 5/18.
It can be shown that algebraic multiplicity of an eigenvalue λ is always greter than or equal to the dimention of the eigenspace corresponding to λ. Find _h_ in the matrix `A` below such that the eigenspace for `λ = 5` is two-dimensional.
<figure>
\begin{equation}
    A =
    \begin{bmatrix}
        5   &   -2  &   6   &   -1\\
        0   &   3   &   h   &   0\\
        0   &   0   &   5   &   4\\
        0   &   0   &   0   &   1
    \end{bmatrix}
\end{equation}
</figure>

#### Solution

<figure>
\begin{aligned}
    \begin{bmatrix}
        0   &   -2  &   6   &   -1  &&  0\\
        0   &   -2   &   h   &   0  &&  0\\
        0   &   0   &   0   &   4   &&  0\\
        0   &   0   &   0   &   -4  &&  0\\
    \end{bmatrix}
    \\[2ex]
    \begin{bmatrix}
        0   &   -2  &   6   &   -1  &&  0\\
        0   &   0   &   h - 6   &   0   &&  0\\
        0   &   0   &   0   &   4   &&  0\\
        0   &   0   &   0   &   -4  &&  0\\
    \end{bmatrix}
\end{aligned}
</figure>

To get another free variable we need `h = 6`.

### 5/23.
Show that if `A = QR` with `Q` invertible, then `A` is similar to `A' = RQ`.

#### Solution
<figure>
\begin{aligned}
    QR &= P^{-1}RQP\\
    R &= Q^{-1}P^{-1}RQP\\
    C &= QP\\
    R &= C^{-1}RC\\
    \\[2ex]
    C &= I \implies QP = I\\
    P &= Q^-1
\end{aligned}
</figure>

We've shown that `R` is similar to itself via matrix `C`. We've shown one solution to self similarity being an identity matrix, which implied that a solution to similarity between `A` and `A'` can be `Q`<sup>`-1`</sup>.

### Show similarity
Show that matrices `A` and `B` are similar to each other by showing that `PA = BP` has a solution with `P`.

<figure>
\begin{aligned}
    A =
    \begin{bmatrix}
        1 & 2\\
        3 & 4
    \end{bmatrix}
    &&B =
    \begin{bmatrix}
        6 & -1\\
        4 & -1
    \end{bmatrix}
    &&P =
    \begin{bmatrix}
        a & b\\
        c & d
    \end{bmatrix}
\end{aligned}
</figure>

#### Solution
<figure>
\begin{equation}
    \begin{bmatrix}
        a + 3b  &   2a + 4b\\
        c + 3b  &   2c + 4d
    \end{bmatrix}
    =
    \begin{bmatrix}
        6a - c  &   6b - d\\
        4a - c  &   4b - d\\
    \end{bmatrix}
\end{equation}
</figure>

When we convert this into a system of equations:

<figure>
\begin{aligned}
    -5a + 3b - c + 0 &= 0\\
    2a - 2b + 0 + d &= 0\\
    -4a + 0 + 2c + 3d &= 0\\
    0 - 4b + 2c + 5d &= 0\\
\end{aligned}
</figure>

<figure>
\begin{aligned}
    \begin{bmatrix}
        -5 & 3 & 1 & 0  && 0\\
        2 & 2 & 0 & 1 && 0\\
        -4 & 0 & 2 & 3 && 0\\
        0 & -4 & 2 & 5 && 0
    \end{bmatrix}
    \\
    \begin{bmatrix}
        -5 & 3 & 1 & 0  && 0\\
        2 & 2 & 0 & 1 && 0\\
        0 & 4 & 2 & 5 && 0\\
        0 & -4 & 2 & 5 && 0
    \end{bmatrix}
    \\
    \begin{bmatrix}
        -5 & 0 & 1 & 0  && 0\\
        2 & 0 & 0 & 1 && 0\\
        0 & 4 & 0 & 0 && 0\\
        0 & 0 & 2 & 5 && 0
    \end{bmatrix}
    \\
    \begin{bmatrix}
        0 & 0 & 1 & \frac{5}{2}  && 0\\
        2 & 0 & 0 & 1 && 0\\
        0 & 4 & 0 & 0 && 0\\
        0 & 0 & 2 & 5 && 0
    \end{bmatrix}
    \\
    \begin{bmatrix}
        2 & 0 & 0 & 1 && 0\\
        0 & 4 & 0 & 0 && 0\\
        0 & 0 & 2 & 5 && 0\\
        0 & 0 & 0 & 0  && 0
    \end{bmatrix}
\end{aligned}
</figure>

Since the above has many solution, we can conclude that there will be at least one matrix `P` for which `AP = PB`. That means `A` and `B` are similar.

### 5/25.
<figure>
\begin{aligned}
    A =
    \begin{bmatrix}
        .6 & .3\\
        .4 & .7
    \end{bmatrix}
    &&v_1 =
    \begin{bmatrix}
        \frac{3}{7}\\
        \frac{4}{7}
    \end{bmatrix}
    &&x_0 =
    \begin{bmatrix}
        .5\\
        .5\\
    \end{bmatrix}
\end{aligned}
</figure>

1. Find a basis for `ℝ`<sup>`2`</sup> consisting of `v`<sub>`1`</sub> and another eigenvector `v`<sub>`2`</sub> of `A`.

We find characteristic equation by `det (A - λI)`. The equation is a quadratic `λ`<sup>`2`</sup>` - 1.3λ + 0.3 = 0`. The two roots are `1` and `0.3`. We've already got the eigenvector for `λ = 1`.

We find `v`<sub>`2`</sub> by finding `nul (A - 0.3I)`. The vector is `<-1, 1>`.

<figure>
\begin{equation}
    B =
    \set{
        \begin{bmatrix}
            \frac{3}{7}\\ \frac{4}{7}
        \end{bmatrix};
        \begin{bmatrix}
            -1 \\ 1
        \end{bmatrix}
    }
\end{equation}
</figure>

2. Verify that `x`<sub>`0`</sub> may be written in the form `x`<sub>`0`</sub>` = v`<sub>`1`</sub>` + cv`<sub>`2`</sub>.

<figure>
\begin{equation}
    \begin{bmatrix}
        .5\\.5
    \end{bmatrix}
    =
    \begin{bmatrix}
        \frac{3}{7} - c\\ \frac{4}{7} + c
    \end{bmatrix}
    \implies
    c = -\frac{1}{14}
\end{equation}
</figure>

3. For `k = 1, 2, ⋯`, define `x`<sub>`k`</sub>` = A`<sup>`k`</sup>`x`<sub>`0`</sub>. Compute `x`<sub>`1`</sub> and `x`<sub>`2`</sub> and write a formula for `x`<sub>`k`</sub>. Then show that `x`<sub>`k`</sub>` → v`<sub>`1`</sub> as `k` increases.

<figure>
\begin{aligned}
    x_1 =
    \begin{bmatrix}
        .6 & .3\\
        .4 & .7
    \end{bmatrix}
    \begin{bmatrix}
        .5\\ .5\\
    \end{bmatrix}
    =
    \begin{bmatrix}
        .45\\ .55\\
    \end{bmatrix}
\end{aligned}
</figure>

<figure>
\begin{aligned}
    x_2 =
    \begin{bmatrix}
        .6 & .3\\
        .4 & .7
    \end{bmatrix}
    \begin{bmatrix}
        .45\\ .55\\
    \end{bmatrix}
    =
    \begin{bmatrix}
        .435\\ .565\\
    \end{bmatrix}
\end{aligned}
</figure>

## Legend

- `dim` stands for dimensions of some space
- `card` stands for cardinality of some set

<!-- Invisible List of References -->
[mathjax]: https://github.com/mathjax/MathJax

<!--
    List of special characters used:
    ⨯
    ⋯
    ⋮
    ℝ
    λ
-->
