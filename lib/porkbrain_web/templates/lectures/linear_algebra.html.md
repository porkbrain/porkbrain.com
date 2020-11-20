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
This body contains resources, notes and programs concerned with linear algebra. The LaTex rendering is handled by [MathJax][mathjax].

Problems can be found [here](problems).

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

## Ax = b, Ax = 0

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

Vectors v<sub>1</sub>, ⋯, v<sub>p</sub> are said to be _linearly independent_ if the equation x<sub>1</sub>v<sub>1</sub> + ⋯ + x<sub>p</sub>v<sub>p</sub> = 0 has only the trivial solution, that is vector x is a null vector. If there exist some constants which aren't all zeros and give solution to the equation, the vectors are _linearly dependent_.

`Ax = 0` can be written as x<sub>1</sub>a<sub>1</sub> + ⋯ + x<sub>n</sub>a<sub>n</sub> = 0. Each linear dependence between columns of `A` contributes a non trivial solution. Hence columns of `A` are independent iff `Ax = 0` has only a trivial solution.

A zero vector is linearly dependent because x<sub>1</sub>0 = 0 has non trivial solutions. Therefore any column set including a zero vector in dependent.

> **Theorem.** A set `S` of 2+ vectors is linearly dependent iff at least one of the vectors in `S` is a linear combination of the others. In fact, if `S` is linearly dependent and v<sub>1</sub> ≠ 0, then some v<sub>j</sub> (with j > 1) is a linear combination of the preceding vectors, v<sub>1</sub>, …, v<sub>j-1</sub>.

## Transformations

A _transformation_ from ℝ<sub>n</sub> to ℝ<sub>m</sub> is a rule which assigns to each vector x in ℝ<sub>n</sub> vector T(x) (also called an image) in ℝ<sub>m</sub>. The set ℝ<sub>n</sub> is called _domain_ of T and ℝ<sub>m</sub> a _codomain_ of T. The set of all images T(x) is called the _range_ of T.

<img
    alt="Transformation of a plane in R3 into R3."
    src="<%= Routes.static_path(@conn, "/images/linear-algebra/range.jpeg") %>"
>

A transformation can be expressed as a matrix times a vector, i.e. `Ax = b` where `b` is the image of `x` under `T`.

As an example, let's take some shear transformation.

<figure>
\begin{equation}
    T(x) =
    \begin{bmatrix}
        1 & 3 \\
        0 & 1
    \end{bmatrix}
    \begin{bmatrix}
        x_1\\
        x_2
    \end{bmatrix}
    =
    \begin{bmatrix}
        x_1\\
        0
    \end{bmatrix}
    +
    \begin{bmatrix}
        3x_2\\
        x_2
    \end{bmatrix}
    =
    \begin{bmatrix}
        x1 + 3x_2\\
        x_2
    \end{bmatrix}
\end{equation}
</figure>

<img
    alt="Transformation of a square in ℝ2 to a parallelogram in ℝ2."
    src="<%= Routes.static_path(@conn, "/images/linear-algebra/shear.jpeg") %>"
>

> **Definition.** Transformation `T` is linear if
- `T(u + v) = T(u) + T(v)` for all vectors `u`, `v` in domain of `T`
- `T(cu) = cT(u)` for all scalars `c` and vectors `u` in domain of `T`

A generalization of above is referred to as the _superposition principle_, where one can think about v<sub>1</sub>, ⋯, v<sub>p</sub> as signals coming into a system, and T(v<sub>1</sub>), ⋯, T(v<sub>p</sub>) as responses to those signals.

T(c<sub>1</sub>v<sub>1</sub>, ⋯, c<sub>p</sub>v<sub>p</sub>) =
c<sub>1</sub>T(v<sub>1</sub>) + ⋯ + c<sub>p</sub>T(v<sub>p</sub>)

<img
    alt="Various transformations in ℝ2."
    src="<%= Routes.static_path(@conn, "/images/linear-algebra/transformations.jpeg") %>"
>

A mapping is said to be _onto_ if each `b` is an image of at least one `x`. In another words the whole output space is covered by the transformation. If `T(x) = b` has no solution for some `b` it is not onto. This can only be true if we map from same or higher dimension.

A mapping is said to be _one-to-one_ if each `b` is the solution to at most one `T(x)`. That is no two vectors are mapped into the same image. This can only be true if we map from same or lower dimension. To determine whether a transformation is onto, we can check whether `Ax = 0` has only the trivial solution.

If a transformation is ℝ<sub>n</sub> ⟶ ℝ<sub>n</sub>, then if a transformation is onto, it also is one-to-one.

> **Theorem.** Let ℝ<sub>n</sub> ⟶ ℝ<sub>m</sub> be a linear transformation and `A` its standard matrix. Then `T` is onto iif the columns of `A` span ℝ<sub>m</sub>. `T` is one-to-one if the columns of `A` are independent.

## Matrix operations

<figure>
\begin{equation}
    \begin{bmatrix}
    a_{11}    & ⋯     & a_{1j}      & ⋯     & a_{1n}\\
    ⋮       &       & ⋮         &       & ⋮\\
    a_{i1}    & ⋯     & a_{ij}      & ⋯     & a_{in}\\
    ⋮       &       & ⋮         &       & ⋮\\
    a_{m1}    & ⋯     & a_{mj}      & ⋯     & a_{mn}\\
    \end{bmatrix}
    = A_{m⨯n}
\end{equation}
</figure>

Let `A` and `B` be matrices of the same size and `r` and `s` scalars. Then
1. `A + B` = `B + A`
2. `r(A + B) = rA + rB`
3. `0 + A = A`
4. `(r + s)A = rA + sA`
5. `A + (B + C) = (A + B) + C`
6. `A(BC) = (AB)C`
7. `A(B + C) = AB + AC`
8. `(A + C)B = AB + CB`
9. `r(AB) = (rA)B = A(rB)`

<img
    alt="Matrix multiplication is transformation."
    src="<%= Routes.static_path(@conn, "/images/linear-algebra/matrix_multiplication.jpeg") %>"
>

In general `AB ≠ BA`. The cancellation laws do not apply, that is `AB = AC` is not the same as `B = C`. If `AB = 0`, in general we cannot conclude that `A = 0` or `B = 0`.

A matrix transpose is a matrix where columns are rows and rows are columns.

<figure>
\begin{equation}
    \begin{bmatrix}
    a & b & c\\
    d & e & f\\
    g & h & i\\
    \end{bmatrix}
    =
    \begin{bmatrix}
    a & d & g\\
    b & e & h\\
    c & f & i\\
    \end{bmatrix}^T
\end{equation}
</figure>

- `(A`<sup>`T`</sup>`)`<sup>`T`</sup>` = A`
- `(A + B)`<sup>`T`</sup>` = A`<sup>`T`</sup>` + B`<sup>`T`</sup>
- `(rA)`<sup>`T`</sup>` = rA`<sup>`T`</sup>
- `(AB)`<sup>`T`</sup>` =B`<sup>`T`</sup>`A`<sup>`T`</sup>

Matrix `A` is said to be invertible if there exists matrix `C` for which it's true that `CA = I` and `AC = I`. In this case `C` is the inverse of `A`. Since `C` is uniquely defined, we name it `A`<sup>`-1`</sup>.

Proof: `B = BI = (BA)C = IC = C`

We can find an inverse of a `2⨯2` matrix using following formula:

<figure>
\begin{align*}
        &A =
        \begin{bmatrix}
            a & b\\
            c & d\\
        \end{bmatrix}

        \\

        &A^{-1} =
        \frac{1}{ad - bc}
        \begin{bmatrix}
            d & -b\\
            -c & a\\
        \end{bmatrix}
\end{align*}
</figure>

If `ad - bc = 0`, then the matrix has no inverse. This quantity is called the determinant and is written as `detA`.

> **Theorem.** If `A` is an invertible matrix then each `x` in `Ax = b` has a unique solution `A`<sup>`-1`</sup>`b`.

Proof: `Ax = (AA`<sup>`-1`</sup>`)b = Ib = b`

> **Theorem.** If `A` and `B` are invertible matrices:
1. `A = (A`<sup>`-1`</sup>`)`<sup>`-1`</sup>
2. `(AB)`<sup>`-1`</sup>` = B`<sup>`-1`</sup>`A`<sup>`-1`</sup>

Proof: `B`<sup>`-1`</sup>`A`<sup>`-1`</sup>`(AB) = B`<sup>`-1`</sup>`(A`<sup>`-1`</sup>`A)B = B`<sup>`-1`</sup>`B = I`

3. `(A`<sup>`T`</sup>`)`<sup>`-1`</sup>` = (A`<sup>`-1`</sup>`)`<sup>`T`</sup>



<!-- Invisible List of References -->
[mathjax]: https://github.com/mathjax/MathJax

<!--
    List of special characters used:
    ⨯
    ⋯
    ⋮
    ℝ
-->
