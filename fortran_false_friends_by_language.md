# Fortran false friends by programming background

This note highlights common stumbling blocks for researchers learning modern
Fortran after using C, C++, Python, R, MATLAB, or Julia. The goal is not to
compare languages in general, but to point out places where familiar habits can
lead to incorrect, inefficient, or unnecessarily complicated Fortran.

The examples assume modern Fortran: prefer explicit interfaces, modules,
procedures with clear `intent`, allocatable arrays, array syntax where it helps,
and compiler diagnostics over old fixed-form, implicit-typing Fortran habits.

## General Fortran habits that help everyone

- Use `implicit none` in every program unit. Do not rely on historical implicit
  typing.
- Put reusable procedures in modules so callers get explicit interfaces.
- Declare procedure arguments with `intent(in)`, `intent(out)`, or
  `intent(inout)` whenever possible.
- Prefer `allocatable` arrays for owned dynamic data. Use pointers only when
  pointer semantics are actually needed.
- Fortran arrays are one-based by default and column-major. Both indexing and
  loop order matter.
- Array syntax can make numerical intent clear, but it can also create
  temporaries. Benchmark kernels before assuming a form is faster.
- Use kind parameters for numerical precision rather than assuming that
  `real`, `double precision`, or compiler flags mean the same thing everywhere.
- Distinguish modules, submodules, procedures, derived types, and programs.
  They play different roles in code organization.
- Learn the compiler's warning and checking options early, especially for
  bounds, uninitialized variables, interfaces, and floating-point exceptions.
- Avoid old Fortran features such as `common`, `equivalence`, implicit typing,
  fixed-form source, and `goto` unless you are maintaining legacy code.

## From C

C programmers often expect explicit memory and pointer control. Modern Fortran
can be explicit too, but arrays, procedure interfaces, and allocation semantics
are different.

### False friends

- **Zero-based indexing**: C arrays are zero-based; Fortran arrays are one-based
  by default. Lower bounds can be changed, so use `lbound`, `ubound`, and `size`
  when writing generic array code.
- **Row-major layout**: C arrays are commonly row-major; Fortran arrays are
  column-major. This affects loop order and C interoperability.
- **Pointers as ordinary dynamic arrays**: In Fortran, prefer `allocatable`
  arrays for owned dynamic storage. Use `pointer` only for aliasing,
  target-associated data, or data structures that require pointer semantics.
- **Manual allocation style**: Fortran has `allocate` and `deallocate`, but
  allocatable local variables are automatically deallocated when they go out of
  scope.
- **Header-file thinking**: Fortran modules provide interfaces and namespaces.
  There are no C-style header files for ordinary Fortran module use.
- **Null-terminated strings**: Fortran character variables carry length
  information and are padded with blanks. C string interoperability needs
  explicit care.
- **Preprocessor-first habits**: Fortran code can be preprocessed, but
  parameters, modules, generic interfaces, and build-system configuration are
  usually clearer for ordinary code.
- **Assuming casts are routine**: Fortran type conversion uses intrinsics such as
  `real`, `int`, and `cmplx`. Be explicit about kind when precision matters.

### Practical advice

Treat arrays and procedures as first-class Fortran concepts rather than
translating C pointer patterns. When interoperating with C, isolate the boundary
and document layout, ownership, and string conventions.

## From C++

C++ programmers often bring good habits around abstraction, value semantics, and
resource management. The main surprise is that Fortran's abstractions are
centered on procedures, modules, arrays, and derived types rather than templates
and class-heavy designs.

### False friends

- **Classes as the default abstraction**: Fortran has derived types and
  type-bound procedures, but many scientific designs are clearer with modules
  and ordinary procedures operating on arrays or derived types.
- **RAII expectations**: Allocatable variables are automatically finalized and
  deallocated in many cases, but resource-management patterns differ from C++.
  External resources such as files still need clear open/close or finalization
  logic.
- **Templates and generic programming**: Fortran generic interfaces are not C++
  templates. Parametric polymorphism is more limited, and many generic designs
  are expressed through specific procedures, interfaces, modules, or
  preprocessor/build choices.
- **References and const references**: Fortran arguments can often feel
  reference-like, but `intent` is the important contract. Use `intent(in)` to
  express read-only arguments.
- **Operator overloading everywhere**: Fortran supports defined operators, but
  overuse can hide allocation and performance costs in numerical code.
- **Namespace and file model**: Fortran modules are not C++ namespaces plus
  headers. Module files are compiler-generated build artifacts and affect build
  order.
- **Object-oriented inheritance habits**: Fortran supports extensible derived
  types and dynamic dispatch, but deep class hierarchies are uncommon in
  numerical Fortran. Composition and modules are often simpler.
- **Assuming standard containers**: Fortran has arrays but no standard-library
  equivalent of `std::vector`, `std::map`, or `std::string` with the same
  behavior. Choose or implement data structures deliberately.
- **Overlooking hidden copies**: Array sections, non-contiguous data, and
  overloaded operators may create temporaries. This matters in large kernels.

### Practical advice

Start from the numerical data layout and procedure interfaces. Use derived
types and type-bound procedures when they improve invariants or API clarity, not
because every concept needs a class analogue.

## From Python

Python programmers often expect dynamic behavior, quick feedback, and automatic
memory management. Fortran asks for more explicit declarations and compilation,
but rewards clear array-oriented numerical code.

### False friends

- **Dynamic names and types**: Fortran variables have declared types. With
  `implicit none`, misspelled variable names become compiler errors rather than
  new variables.
- **Lists versus arrays**: Python lists are heterogeneous references. Fortran
  arrays are homogeneous numerical or typed storage with fixed rank.
- **Zero-based indexing**: Python sequences are zero-based; Fortran arrays are
  one-based by default.
- **Assignment and aliasing**: Array assignment usually copies values. Pointer
  assignment uses `=>` and has different semantics from ordinary assignment.
- **Exceptions**: Fortran has no Python-like exception mechanism. Use status
  values such as `iostat`, explicit error handling, and project conventions.
- **Interactive workflow**: Fortran is usually compiled. Fast iteration comes
  from small programs, good compiler flags, tests, and incremental builds.
- **Duck typing**: Fortran procedure interfaces are explicit. Generic behavior
  requires interfaces, modules, optional arguments, or specific procedure
  variants.
- **Automatic big integers and flexible numerics**: Fortran integer and real
  kinds have fixed ranges and precision. Choose kinds deliberately.
- **NumPy equivalence**: Fortran arrays are central to the language, but
  broadcasting, slicing, and library conventions are not the same as NumPy.

### Practical advice

Think of Fortran as a compiled array language with explicit interfaces. Put
reusable work in procedures, let the compiler check declarations, and use array
syntax where it clarifies the numerical intent.

## From R

R programmers often come from a vectorized, data-analysis-oriented environment.
Fortran is more explicit about types, shapes, missing values, and compilation.

### False friends

- **Vectorization as the only fast style**: Fortran array syntax can be clear
  and efficient, but explicit loops are also normal and often fastest.
- **One-based indexing means everything transfers**: R and Fortran are both
  one-based by default, but array shape, slicing, recycling, and missing-value
  behavior differ.
- **Recycling rules**: Fortran does not recycle shorter arrays in expressions.
  Shape conformity is checked by language rules or must be checked explicitly.
- **Missing values**: Fortran has no universal `NA`. Use masks, sentinel values,
  IEEE NaNs where appropriate, or explicit validity arrays.
- **Copy-on-modify intuition**: Fortran assignment and argument passing have
  their own rules. Use `intent` and clear interfaces to communicate mutation.
- **Data frames**: Fortran has no built-in data-frame abstraction. Model tabular
  data with arrays, derived types, or external libraries depending on the task.
- **Formula interfaces**: Statistical formula syntax is not a Fortran language
  feature. Numerical models are usually expressed through procedures and data
  structures.
- **Interactive package workflow**: Fortran projects rely on compilers, build
  systems, modules, and linked libraries rather than an R-session package
  workflow.

### Practical advice

Make data layout, shape, and missing-value policy explicit. Fortran is often a
good target for numerical kernels that are called from R, but the boundary
should document ownership, layout, and error conventions.

## From MATLAB

MATLAB programmers often find Fortran's numerical focus familiar. The false
friends are mostly around interactivity, array syntax, and the fact that modern
Fortran is a compiled modular language.

### False friends

- **Matrix as the only default abstraction**: Fortran supports arrays directly,
  but also has modules, procedures, derived types, and explicit interfaces.
- **One-based indexing means direct translation is safe**: Both languages are
  commonly one-based, but lower bounds, array sections, and shape rules differ.
- **Element-wise versus matrix operations**: MATLAB distinguishes `*` and `.*`.
  Fortran has intrinsic array element-wise operations and `matmul` for matrix
  multiplication. Do not translate operators mechanically.
- **Implicit expansion and broadcasting**: Fortran has elemental operations and
  array syntax, but not MATLAB's full implicit expansion model.
- **Growing arrays in loops**: Repeated reallocation is expensive. Allocate
  arrays with known shape or use a deliberate dynamic data structure.
- **Scripts and shared workspace state**: Fortran programs should express data
  flow through procedures, modules, arguments, and return values.
- **Plotting as part of the language environment**: Fortran has no standard
  plotting environment. Scientific workflows often compute in Fortran and
  visualize with Python, R, MATLAB, gnuplot, ParaView, or another tool.
- **Runtime convenience over compile-time checks**: Fortran requires compilation
  and benefits strongly from compiler warnings, bounds checks, and tests.

### Practical advice

Translate mathematical intent rather than MATLAB syntax. Decide which arrays
own the data, which procedures mutate them, and where visualization or analysis
belongs outside the Fortran kernel.

## From Julia

Julia programmers often bring useful habits around multiple dispatch, array
programming, and scientific packages. Fortran shares some numerical DNA, but
its type system, compilation model, and abstraction mechanisms are different.

### False friends

- **Multiple dispatch everywhere**: Fortran has generic interfaces and
  type-bound procedures, but it does not have Julia-style dynamic multiple
  dispatch.
- **Parametric generic code**: Julia parametric methods are more flexible than
  Fortran's generic facilities. In Fortran, you often write specific procedures
  or use build-time generation for families of types.
- **Interactive-first workflow**: Fortran is normally edited, compiled, linked,
  and run. Use small drivers and tests for fast feedback.
- **Array slicing as familiar**: Both languages use one-based, column-major
  arrays by default, but Fortran array sections, contiguity, and copy-in/copy-out
  behavior need attention.
- **Broadcasting syntax**: Julia's dotted broadcasting has no direct syntax
  equivalent. Fortran uses array expressions, elemental procedures, and loops.
- **Package ecosystem assumptions**: Fortran depends heavily on compilers,
  build systems, and long-established external libraries such as BLAS, LAPACK,
  MPI, HDF5, and NetCDF.
- **Type annotations as optional performance hints**: Fortran declarations are
  required and define the program. They are not optional annotations layered on
  a dynamic language.
- **Garbage-collected resource expectations**: Fortran has automatic
  deallocation for many allocatables, but not Julia's garbage-collected object
  model. Be explicit about allocation, finalization, and external resources.

### Practical advice

Keep the array-programming strengths, but adopt Fortran's explicit procedure
interfaces and compilation model. Use modules to make contracts visible and
compiler-checkable.

## Cross-language traps in scientific Fortran

### Numeric types and precision

- Do not assume default `real` has the precision you need.
- Prefer named kind parameters, for example from `iso_fortran_env`, over magic
  kind numbers.
- Integer division truncates: `1 / 2` is `0`, while `1.0 / 2.0` is `0.5`.
- Floating-point equality is usually the wrong test for computed values; use
  tolerances appropriate to the problem.
- Compiler flags that change default real or integer sizes can affect
  interoperability and library calls. Use them with care.

### Arrays, shape, and layout

- Fortran arrays are column-major. The leftmost index varies fastest in memory.
- Use `size`, `shape`, `lbound`, and `ubound` instead of hard-coding dimensions
  when writing reusable procedures.
- Array sections may be non-contiguous. This can affect performance and
  interoperability.
- Whole-array expressions can allocate temporaries. This is often fine for
  clarity, but important in large kernels.
- Use `contiguous` and explicit interfaces when contiguity matters for
  performance or interoperability.

### Procedures and mutation

- Always specify `intent` for dummy arguments when possible.
- `intent(in)` protects against modification inside the procedure, but it is
  not the same as deep immutability for all possible objects.
- Prefer explicit interfaces through modules. They help the compiler catch
  shape, type, rank, and argument mismatches.
- Be cautious with optional arguments and generic interfaces; they are useful
  but can make APIs harder to understand if overused.

### Libraries and interoperability

- Fortran is often used with BLAS, LAPACK, MPI, OpenMP, HDF5, NetCDF, and C
  libraries. Learn the calling conventions, data layout, and build system early.
- Use `iso_c_binding` for C interoperability instead of relying on compiler- or
  platform-specific assumptions.
- When calling Fortran from Python, R, Julia, MATLAB, C, or C++, document array
  order, ownership, indexing convention, and error handling at the boundary.
- For HPC code, understand whether the project uses MPI, OpenMP, coarrays, GPU
  directives, or external accelerator libraries before designing abstractions.

## Summary table

| Background | Most likely false friend | Fortran habit to develop |
| --- | --- | --- |
| C | Treating Fortran as C with different array syntax | Use modules, explicit interfaces, allocatables, and column-major arrays |
| C++ | Translating classes, templates, RAII, and containers directly | Design around procedures, modules, arrays, derived types, and `intent` |
| Python | Expecting dynamic names and notebook-style feedback | Use declarations, compilation, compiler checks, and small test drivers |
| R | Expecting recycling, data frames, and missing-value conventions | Make shape, types, missing values, and mutation explicit |
| MATLAB | Expecting MATLAB syntax and workspace habits | Use procedures, modules, explicit allocation, and external visualization tools |
| Julia | Expecting multiple dispatch and interactive JIT workflow | Use generic interfaces selectively and rely on explicit compiled interfaces |

## Teaching tip

When participants ask "what is the Fortran equivalent of this feature?", first
identify whether they mean syntax, semantics, performance behavior, or workflow.
The best Fortran answer is often not a direct translation, but a design that
makes array layout, procedure interfaces, mutation, precision, and library
boundaries explicit.
