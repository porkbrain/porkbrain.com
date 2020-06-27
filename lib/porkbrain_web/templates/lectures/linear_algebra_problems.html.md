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

### 3.
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
        0 & 0 & 0 & 0 & 0\\
    \end{bmatrix}
\end{equation}
</figure>

#### Solution
<figure>
\begin{equation}
    B_{[Col A]} =
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
    B_{[Row A]} =
    \set{
        (2, -3, 6, 2, 5);
        (0, 0, 3, -1, 1);
        (0, 0, 0, 1, -3)
    }
\end{equation}
</figure>

`rank A = dim Col A = dim Row A = card B`<sub>`[Col A]`</sub>` = card B`<sub>`[Row A]`</sub>` = `**`3`**

`rank A + dim Nul A = 5  =>  dim Nul A = 5 - rank A = 5 - 3 = `**`2`**

<figure>
\begin{equation}
    B_{[Nul A]} =
    \set{
        \begin{bmatrix}
            -3\\ 0\\ 0\\ 0
        \end{bmatrix};
        \begin{bmatrix}
            5\\ 1\\ 3\\ 0
        \end{bmatrix}
    }
\end{equation}
</figure>

### 5.
If a 3⨯8 matrix `A` has rank 3, find `dim Nul A`, `dim Row A` and `rank A`<sup>`T`</sup>.

#### Solution
`dim Row A = rank A`<sup>`T`</sup>` = rank A = 3`

`dim Nul A + dim Col A = n  =>  dim Nul A = 8 - dim Col A = 8 - 3 = 5`

### 7.
Suppose a 4⨯7 matrix `A` has four pivot columns. Is `Col A = ℝ`<sup>`4`</sup>? Is `Nul A = ℝ`<sup>`3`</sup>?

#### Solution
Four pivot columns mean `dim Col A = 4`. `Col A` is in `ℝ`<sup>`4`</sup> because the matrix has 4 rows.

The  `Nul A` represents 3 dimensional space embedded in `ℝ`<sup>`4`</sup>, hence it's not in `ℝ`<sup>`3`</sup>.

### 24.
A homogeneous system of twelve linear equations in eight unknowns has two fixed solutions that are not multiples of each other, and all other solutions are linear combinations of these two solutions. Can the set of all solutions be described with fewer than twelve homogenous linear equations? If so, how many?

#### Solution
In another words, the null space (homogenous system) spans a plane (2 independent solutions). Therefore the `dim Nul A = 2`. Using following formula `dim Row A + dim Nul A = #unknowns` we can say that `dim Row A = 8 - 2 = 6`. Therefore there are 6 rows with a pivot element and 6 rows without a pivot element in the row space. The set of all solutions can be expressed with 6 equations.

### 27.
Which of the subspaces `Row A`, `Col A`, `Nul A`, `Row A`<sup>`T`</sup>, `Col A`<sup>`T`</sup>, and `Nul A`<sup>`T`</sup>, are in `ℝ`<sup>`m`</sup> and which are in `ℝ`<sup>`n`</sup>? How many distinct subspaces are in this list?

#### Solution
|  `ℝ`<sup>`m`</sup>    | `ℝ`<sup>`n`</sup>     |
|:-:                    |:-:                    |
| `Row A`               | `Row A`<sup>`T`</sup> |
| `Col A`<sup>`T`</sup> | `Col A`               |
| `Nul A`<sup>`T`</sup> | `Nul A`               |

There are 4 distinct spaces: `Row A = Col A`<sup>`T`</sup>; `Col A = Row A`<sup>`T`</sup>; `Nul A`; `Nul A`<sup>`T`</sup>.

### 29.
Why the equation `Ax = b` has a solution for all `b` in `ℝ`<sup>`m`</sup> iff the equation `A`<sup>`T`</sup>`x = 0` has only the trivial solution?

#### Solution
**a)** `A`<sup>`T`</sup>`x = 0` having only trivial solution means that there's only the null vector in the `Nul A`, hence `dim Nul A = 0`. Then we can say that `dim Col A + dim Nul A`<sup>`T`</sup>` = m  =>  dim Col A = m`. This means that the `Col A` spans the whole `ℝ`<sup>`m`</sup>.

**b)** If all vectors `b` in `ℝ`<sup>`m`</sup> are represented in the output of `A`, that means that the `col A` spans `ℝ`<sup>`m`</sup>. Therefore the `dim Col A = m`.

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
-->
