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

A matrix `A`<sub>`m` &Cross; `n`</sub> has `m` rows and `n` columns.

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

If v<sub>1</sub>, &ctdot;, v<sub>p</sub> are in &reals;<sup>n</sup>, then set of all linear combinations of those vectors is denoted Span {v<sub>1</sub>, &ctdot;, v<sub>p</sub>}. The set is a subset of &reals;<sup>n</sup> spanned by the vectors. In another words, Span {v<sub>1</sub>, &ctdot;, v<sub>p</sub>} is the collection of all vectors in form c<sub>1</sub>v<sub>1</sub> + &ctdot; + c<sub>p</sub>v<sub>p</sub> where c<sub>1</sub>, &ctdot;, c<sub>p</sub> are scalars.

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

> **Theorem.** If `A` is an <sub>`m` &Cross; `n`</sub> matrix with columns a<sub>1</sub>, &ctdot;, a<sub>n</sub> and `b` is in &reals;<sup>n</sup>, then following has the same solution set:

<figure>
\begin{gather*}
    Ax = b\\
    x_1 a_1 + x_2 a_2 + ⋯ + x_n a_n = b\\
    \begin{bmatrix}
        a_1 & a_2 & ⋯ & a_n && b
    \end{bmatrix}
\end{gather*}
</figure>

> **Theorem.** Let `A` be an <sub>`m` &Cross; `n`</sub> matrix. Then the following statements are logically equivalent:
- For each `b` in &reals;<sup>m</sup>, the equation `Ax = b` has a solution.
- Each `b` in &reals;<sup>m</sup> is a linear combination of the columns of `A`.
- The column of `A` span &reals;<sup>m</sup>. If they didn't we could find a vector `b` which the columns of `A` couldn't reach.
- `A` has a pivot position in every row.

> **Theorem.**  If `A` is <sub>`m` &Cross; `n`</sub> matrix, `u` and `v` are vectors in &reals;<sup>n</sup>, and `c` is a scalar, then a) `A(u + v) = Au + Av`; b) `A(cu) = c(Au)`.

<figure>
Proof for a)
\begin{equation}
    A(u + v)
    = a_1(u_1 + v_1) + ⋯ + a_n(u_n + v_n)\\
    = a_1 u_1 + a_1 v_1 + ⋯ + a_n u_n + a_n v_n\\
    = (a_1 u_1 + ⋯ + a_n u_n) + (a_1 v_1 + ⋯ + a_n v_n)\\
    = Au + Av
\end{equation}
</figure>

<figure>
Proof for b)
\begin{equation}
    A(cu)
    = (cu_1)a_1 + ⋯ + (cu_n)a_n\\
    = c(u_1 a_1) + ⋯ + c(u_n a_n)\\
    = c(u_1 a_1 + ⋯ + u_n a_n)\\
    = c(Au)\\
\end{equation}
</figure>

<!-- Invisible List of References -->
[mathjax]: https://github.com/mathjax/MathJax
