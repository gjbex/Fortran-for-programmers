# Fortran standard support in HPC compilers

**Reviewed:** 2026-11-18 (Europe/Brussels)  
**Scope:** Fortran 2003, 2008, 2018, and 2023; GNU Fortran, Intel oneAPI Fortran, NVIDIA HPC SDK, upstream LLVM Flang, and AMD AOCC.  
**Evidence:** Primarily vendor/project documentation accessible on the review date. This is a **documentation review**, not a compiler conformance test suite. Exact results depend on compiler version, platform, runtime, flags, and (for coarrays) the runtime configuration.

## Executive summary

| Compiler | F2003 | F2008 | F2018 | F2023 | Interpretation |
|---|---|---|---|---|---|
| Intel **ifx** (2026.2) | Full (vendor claim) | Full (vendor claim) | Full (vendor claim) | Partial | Intel explicitly claims full implementation through F2018; new F2023 features continue to arrive. |
| GNU **gfortran** (GCC 16 series) | Almost complete | Almost complete | Partial | Partial | Its manual enumerates residual F2003/F2008 omissions; recent GCC releases add F2018/F2023 features. |
| NVIDIA **nvfortran** (HPC SDK 26.9 documentation) | Supported (vendor claim) | Partial | Not claimed full | Not claimed full | NVIDIA explicitly describes F2008 as “many features,” not complete coverage. |
| **LLVM Flang** (upstream documentation, updated 2026-11-14) | Partial | Partial | Partial | Partial | Coarrays and length-parameterized derived types are major gaps; its feature tables are unusually detailed. |
| AMD **AOCC flang** (6.0) | Supported (vendor claim) | Partial | Not claimed | Not claimed | AOCC `flang` is not upstream LLVM Flang; F2008 coarrays are absent. |
| AMD **AOCC aof** (6.0) | Supported (vendor claim) | Partial | Partial | Not claimed full | Separate newer AOCC Fortran frontend; do not combine the two AMD compilers' feature claims. |

**Meaning of “full”:** a *vendor claim*, not independent certification. **Partial** does not mean most everyday codes fail. “Not claimed full” is **not** proof that every newer-standard feature is absent.

## GNU Fortran (`gfortran`): documented incomplete or missing language features

These are **gaps by the standard that introduced the feature**, not a guarantee that they are the *only* unimplemented corner cases. The GNU manual's status pages sometimes lag release notes and its broad descriptions should not be interpreted as an exhaustive conformance matrix.

### Fortran 2003

- **Finalization of derived-type objects:** GNU's current Fortran 2003 status page explicitly says finalization support is **incomplete**. [G1]
- **Parameterized derived types (especially LEN parameters):** GCC 16 release notes report improved LEN-parameter handling but say a further representation change is required. This is a **remaining implementation caveat**, rather than a claim that every PDT with a LEN parameter fails. [G5]

No other specific missing F2003 feature is asserted by the current GNU standards-status summary. [G1]

### Fortran 2008

The GNU manual explicitly lists these outstanding items: [G2]

- **Type specification in a `DO CONCURRENT` or `FORALL` loop header** is not recognized.
- **Any constant expression in subscripts and nested implied-DO limits in a `DATA` statement:** the relaxed F2008 rule remains unimplemented.

GNU describes its implementation as supporting *almost all* of F2008, not as completely conforming. [G2]

### Fortran 2018

The GNU manual gives a **supported-feature list**, not a complete list of unsupported features. Documented limitations or qualifications include: [G3]

- **Coarray collective procedures:** `CO_BROADCAST` and `CO_REDUCE` (and documented reduction operations) have limitations for **polymorphic objects** and **types containing allocatable, pointer, or polymorphic components**.
- **Broader multi-image features:** the manual describes support for a **subset** of the parallel features introduced via TS 18508. Do not infer full F2018 coarray/teams semantics from successful compilation. GCC 16 introduced more native shared-memory coarray and `TEAM` support, so older “teams unsupported” statements are now stale. [G3, G5]

GCC 16 also adds F2018 `IMPORT` extensions, `REDUCE` and the new `GENERIC` statement. **These should not be listed as missing in GCC 16.** [G5]

### Fortran 2023

**Incomplete, but there is no authoritative, exhaustive current GNU “missing F2023 features” table in the documentation reviewed.** Relevant status facts:

- GCC supports `-std=f2023`, which selects language constraints; the option **does not certify complete implementation**. [G4]
- GCC 16 adds the F2023 `SPLIT` intrinsic, an optional lower-bound argument to `C_F_POINTER`, and half-revolution trigonometric intrinsics. **These are implemented in GCC 16 and should not be listed as missing.** [G5]
- **Remaining unimplemented F2023 features:** not reliably enumerable from the GNU sources reviewed; an item-by-item comparison against the standard and compiler tests is needed before publishing a categorical list. In particular, do **not** infer that every unmentioned feature is unsupported.

### Recommended GNU validation commands

```bash
gfortran --version
gfortran -std=f2008 -pedantic-errors -Wall -Wextra -fcheck=all sample.f90
gfortran -std=f2018 -pedantic-errors -Wall -Wextra -fcheck=all sample.f90
gfortran -std=f2023 -pedantic-errors -Wall -Wextra -fcheck=all sample.f90
```

`-std=` controls accepted syntax/extensions; successful compilation is **not** evidence of complete runtime semantics or all standard requirements. For coarrays, record `-fcoarray=` mode and the installed coarray runtime separately.

## Intel oneAPI Fortran (`ifx`): documented incomplete or missing features

**Version assessed:** Intel Fortran Compiler **2026.2**, released 2026-10-30. Intel explicitly claims full support through F2018. [I1]

### Fortran 2003

- **No outstanding standard-language features reported by Intel.** Intel claims full F2003 implementation. [I1, I2]

### Fortran 2008

- **No outstanding standard-language features reported by Intel.** Intel claims full F2008 implementation. [I1, I2]

### Fortran 2018

- **No outstanding standard-language features reported by Intel.** Intel claims full F2018 implementation. [I1, I2]
- This is a conformance claim, **not** a promise of defect-free behavior in every build, or that GPU offloading works for every conforming construct.

### Fortran 2023

Intel's detailed feature table is for **2025.3**, so it **must be reconciled against 2026 release notes**. The following were marked **No** in Intel's 2025.3 table and were **not found among the F2023 implementations announced in the 2026.0–2026.2 notes reviewed**. Thus they are **likely outstanding / not confirmed as implemented for 2026.2**; this is *not* a definitive 2026.2 negative test result. [I2, I1]

- **Simple procedures**.
- **Integer-array subscripts and section subscripts** (new F2023 forms).
- **Integer arrays to specify array rank and bounds** (new F2023 forms; distinguish from the separately supported `RANK` clause).
- **New enumeration and enum-type facilities**.
- **Conditional expressions used as actual arguments:** listed separately from conditional expressions in the 2025.3 table; later notes confirm conditional expressions in general, not explicitly every argument form. **Needs direct testing**.

**Do not reproduce the 2025.3 list unchanged.** Intel's **2026.0** release added **leading-zero output control**, **`NOTIFY`/`NOTIFY WAIT`**, and **conditional expressions**; **2026.2** added **`CLASSOF`/`TYPEOF`** and automatic reallocation of certain deferred-length character results. These are **not current missing-feature examples**. [I1]

The older 2025.3 table is best treated as a **starting checklist**. For a fully defensible negative list, compile minimal F2023 programs with the exact installed 2026.2 release, or request a current feature matrix from Intel.

### Recommended Intel validation commands

```bash
ifx --version
ifx -stand f18 -warn all -check all sample.f90
ifx -stand f23 -warn all -check all sample.f90
```

`-stand` is a diagnostic/conformance option; consult the installed compiler's options reference for exact behavior. Do not treat a standards-mode diagnostic as a substitute for positive and negative tests.

## The other compilers

### NVIDIA HPC SDK (`nvfortran`)

NVIDIA's HPC SDK 26.9 documentation says `nvfortran` supports ISO Fortran 2003 and **many** Fortran 2008 features; it does not claim full Fortran 2008, 2018 or 2023 support. It adds important HPC features outside the language standards (CUDA Fortran, OpenACC and OpenMP). [N1, N2]

**Conclusion:** F2008 is **not a guaranteed universal baseline** for NVIDIA simply because the compiler supports many of its constructs. Use feature-level tests, particularly for less commonly used language facilities and GPU execution.

### Upstream LLVM Flang (`flang`)

LLVM's live feature matrix (last updated **2026-11-14**) identifies major missing pieces: [L1]

- **F2003:** parameterized derived types with **LEN** parameters (partial); additional partial cases involving allocatable assignment, asynchronous I/O, character `MIN`/`MAX`.
- **F2008:** coarray data objects and coindexed accesses, atomic procedures and locking remain incomplete or absent; some synchronization and image intrinsics have only experimental support.
- **F2018:** numerous multi-image/coarray features are partial or missing, including events, certain collectives and teams functionality.
- **F2023:** several features are still absent or partial, including conditional expressions, simple procedures, new array-subscripting forms and some enumeration facilities (consult the live matrix for the changing full list).

Do **not** equate upstream LLVM Flang with AMD AOCC's older `flang` frontend.

### AMD AOCC 6.0 (`flang` and `aof`)

AMD's **2026-11-10** AOCC 6.0 standards table distinguishes two Fortran frontends: [A1]

- **AOCC `flang`:** F2003 supported; F2008 **partial**, specifically lacking F2008 coarrays; no full F2018 claim.
- **AOCC `aof`:** F2003 supported; F2008 and F2018 **partial**; no full F2023 claim.

AOCC optimizes for AMD x86 CPUs; consult the AOCC release notes for compiler-specific behavior rather than assuming upstream LLVM Flang's feature matrix applies unchanged. [A1, A2]

## Suggested HPC policy

1. **Training baseline:** teach portable Fortran 2008 constructs but publish an explicit feature-compatibility policy; treat coarrays and advanced PDT/finalization cases separately.
2. **CI matrix:** test with `gfortran` and `ifx`; add `nvfortran`, upstream LLVM Flang and AOCC where relevant to the target cluster.
3. **Feature tests over standard labels:** include small compile-and-run checks for PDT finalization, `DO CONCURRENT`, `SELECT RANK`, coarray constructs, and F2023 features before using them in portable lessons.
4. **Record compiler build, module environment, runtime, architecture and flags** in reproducibility reports. Language standard conformance, OpenMP feature support and GPU offload are **separate questions**.

## Primary documentation and release notes

### GNU

- **[G1]** [GNU Fortran — Fortran 2003 status](https://gcc.gnu.org/onlinedocs/gfortran/Fortran-2003-status.html).
- **[G2]** [GNU Fortran — Fortran 2008 status](https://gcc.gnu.org/onlinedocs/gfortran/Fortran-2008-status.html).
- **[G3]** [GNU Fortran — Fortran 2018 status](https://gcc.gnu.org/onlinedocs/gfortran/Fortran-2018-status.html).
- **[G4]** [GNU Fortran — Fortran dialect options](https://gcc.gnu.org/onlinedocs/gfortran/Fortran-Dialect-Options.html).
- **[G5]** [GCC 16 release notes — Fortran](https://gcc.gnu.org/gcc-16/changes.html).
- [GNU Fortran overview](https://gcc.gnu.org/fortran/).

### Intel

- **[I1]** [Intel Fortran Compiler 2026 release notes (through 2026.2)](https://www.intel.com/content/www/us/en/developer/articles/release-notes/fortran-compiler/2026.html).
- **[I2]** [Intel Fortran language features by version and F2023 feature matrix (2025.3)](https://www.intel.com/content/www/us/en/developer/articles/technical/fortran-language-and-openmp-features-in-ifx.html). **Caution:** F2023 matrix predates the 2026.0–2026.2 additions.
- [Intel Fortran 2026.1 developer guide](https://www.intel.com/content/www/us/en/docs/fortran-compiler/developer-guide-reference/2026-1/overview.html).

### NVIDIA

- **[N1]** [NVIDIA HPC SDK 26.9 documentation](https://docs.nvidia.com/hpc-sdk/index.html).
- **[N2]** [NVIDIA HPC Compilers Reference Guide 26.9](https://docs.nvidia.com/hpc-sdk/compilers/hpc-compilers-ref-guide/index.html).

### LLVM

- **[L1]** [LLVM Flang — Fortran Standards Support](https://flang.llvm.org/docs/FortranStandardsSupport.html) (page updated 2026-11-14).

### AMD

- **[A1]** [AOCC User Guide 6.0 — Compatibility / Conformance to Standards](https://docs.amd.com/r/en-US/57222-AOCC-user-guide/Compatibility/Conformance-to-Standards) (released 2026-11-10).
- **[A2]** [AMD AOCC product and downloads](https://www.amd.com/en/developer/aocc.html).

---

*Maintenance note:* Recheck the compiler feature tables before reusing this document in a future academic year. In particular, GNU's incomplete features and Intel's Fortran 2023 list are version-sensitive; a documentation-only review cannot establish an exhaustive inventory of missing language semantics.
