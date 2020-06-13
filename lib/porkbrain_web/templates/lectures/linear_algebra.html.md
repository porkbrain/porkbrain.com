<script>
// Left aligns all figures.
MathJax = {
  chtml: { displayAlign: 'left' }
}
</script>

<!-- Includes tex2html which draws mathematical notation from LaTex online. -->
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js"></script>

<header class="header">
    <img
        class="logo"
        alt="a human on a grid with their head slice up"
        src="<%= Routes.static_path(@conn, "/images/brain_1125x1134.jpeg") %>"
    >
</header>

# Linear algebra
This body contains resources, notes, exercises of interest and programs concerned with linear algebra. The LaTex rendering is handled by [MathJax][mathjax].
---

System of linear equations can have
- one solution;
- infinitely many solutions;
- no solution.

A system is said to be _consistent_ if it has at least one solution.

A _coefficient matrix_ is array of data which corresponds to coefficients of variables in system of linear equations. An _augmented matrix_ has extra column representing the constants on the RHS.

A matrix `A`<sub>`m⨯n`</sub> has `m` rows and `n` columns.

A matrix is in an _echelon form_ if it has following properties:
1. Rows with all zeros come last.
2. Each leading entry of **a row** (that is first non zero entry) is to the right of the leading entry of the row above it. This implies that all entries in **a column** below a leading entry are zero.

<figure>
\begin{bmatrix}
    1 & 0 & 0 && 1\\
    0 & 0 & 2 && 1\\
    0 & 0 & 0 && 1\\
    0 & 0 & 0 && 0
\end{bmatrix}
</figure>

A matrix which further satisfies following conditions is called _reduced echelon form_:
1. Leading entry in each row is `1`.
2. Each leading `1` is the only nonzero entry in its column.

> **Theorem.** Uniqueness of the Reduced Echelon Form: Each matrix is row equivalent to one and only one reduced echelon matrix.

&square; Write a program to find reduced echelon form and let it generate LaTex for each step.

## `Ax = b`

If v<sub>1</sub>, ⋯, v<sub>p</sub> are in ℝ<sup>n</sup>, then set of all linear combinations of those vectors is denoted Span {v<sub>1</sub>, ⋯, v<sub>p</sub>}. The set is a subset of ℝ<sup>n</sup> spanned by the vectors. In another words, Span {v<sub>1</sub>, ⋯, v<sub>p</sub>} is the collection of all vectors in form c<sub>1</sub>v<sub>1</sub> + ⋯ + c<sub>p</sub>v<sub>p</sub> where c<sub>1</sub>, ⋯, c<sub>p</sub> are scalars.

<figure>
\begin{equation}
    Ax =
    \begin{bmatrix}
        a_1 & a_2 & ⋯ & a_n
    \end{bmatrix}
    \begin{bmatrix}
        x_1\\
        x_2\\
        ⋮\\
        x_n
    \end{bmatrix}
    = x_1 a_1 + x_2 a_2 + ⋯ + x_n a_n
\end{equation}
</figure>

> **Theorem.** If `A` is an <sub>`m⨯n`</sub> matrix with columns a<sub>1</sub>, ⋯, a<sub>n</sub> and `b` is in ℝ<sup>n</sup>, then following has the same solution set:

<figure>
\begin{gather*}
    &\textit{a)}  &  Ax = b\\
    &\textit{b)}  &  x_1 a_1 + x_2 a_2 + ⋯ + x_n a_n = b\\
    &\textit{c)}  &
    \begin{bmatrix}
        a_1 & a_2 & ⋯ & a_n && b
    \end{bmatrix}
\end{gather*}
</figure>

> **Theorem.** Let `A` be an <sub>`m⨯n`</sub> matrix. Then the following statements are logically equivalent:
- For each `b` in ℝ<sup>m</sup>, the equation `Ax = b` has a solution.
- Each `b` in ℝ<sup>m</sup> is a linear combination of the columns of `A`.
- The column of `A` span ℝ<sup>m</sup>. If they didn't we could find a vector `b` which the columns of `A` couldn't reach.
- `A` has a pivot position in every row.

> **Theorem.**  If `A` is <sub>`m⨯n`</sub> matrix, `u` and `v` are vectors in ℝ<sup>n</sup>, and `c` is a scalar, then a) `A(u + v) = Au + Av`; b) `A(cu) = c(Au)`.

<figure>
Proof for a)
\begin{align*}
    A(u + v)
    &= a_1(u_1 + v_1) + ⋯ + a_n(u_n + v_n)\\
    &= a_1 u_1 + a_1 v_1 + ⋯ + a_n u_n + a_n v_n\\
    &= (a_1 u_1 + ⋯ + a_n u_n) + (a_1 v_1 + ⋯ + a_n v_n)\\
    &= Au + Av
\end{align*}
</figure>

<figure>
Proof for b)
\begin{align*}
    A(cu)
    &= (cu_1)a_1 + ⋯ + (cu_n)a_n\\
    &= c(u_1 a_1) + ⋯ + c(u_n a_n)\\
    &= c(u_1 a_1 + ⋯ + u_n a_n)\\
    &= c(Au)\\
\end{align*}
</figure>

## `Ax = 0`

Vectors v<sub>1</sub>, ⋯, v<sub>p</sub> are said to be _linearly independent_ if the equation x<sub>1</sub>v<sub>1</sub> + ⋯ + x<sub>p</sub>v<sub>p</sub> = 0 has only the trivial solution, that is vector x is a null vector. If there exist some constants which aren't all zeros and give solution to the equation, the vectors are _linearly dependent_.

`Ax = 0` can be written as x<sub>1</sub>a<sub>1</sub> + ⋯ + x<sub>n</sub>a<sub>n</sub> = 0. Each linear dependence between columns of `A` contributes a non trivial solution. Hence columns of `A` are independent iff `Ax = 0` has only a trivial solution.

A zero vector is linearly dependent because x<sub>1</sub>0 = 0 has non trivial solutions. Therefore any column set including a zero vector in dependent.

> **Theorem.** A set `S` of 2+ vectors is linearly dependent iff at least one of the vectors in `S` is a linear combination of the others. In fact, if `S` is linearly dependent and v<sub>1</sub> ≠ 0, then some v<sub>j</sub> (with j > 1) is a linear combination of the preceding vectors, v<sub>1</sub>, …, v<sub>j-1</sub>.

<!-- Invisible List of References -->
[mathjax]: https://github.com/mathjax/MathJax
