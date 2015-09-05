# List of all OpenCMISS components (used in default config)
SET(OPENCMISS_COMPONENTS BLAS LAPACK PLAPACK SCALAPACK PARMETIS
    SUITESPARSE MUMPS SUPERLU SUPERLU_DIST
    SUNDIALS SCOTCH SOWING PTSCOTCH PASTIX HYPRE PETSC
    LIBCELLML CELLML SLEPC ZLIB BZIP2 SZIP HDF5 FIELDML-API LIBXML2
    CSIM LLVM GTEST JPEG NETGEN FTGL FREETYPE GLEW OPTPP
    PNG TIFF GDCM IMAGEMAGICK ITK ZINC IRON)

# Components using (any) MPI
# Used to determine when MPI compilers etc should be passed down to packages
SET(OPENCMISS_COMPONENTS_WITHMPI MUMPS PARMETIS PASTIX PETSC
    PLAPACK SCALAPACK SCOTCH SUITESPARSE
    SUNDIALS SUPERLU_DIST SLEPC HYPRE IRON)

# Components using OPENMP local threading
# Used to determine which dependencies get the WITH_OPENMP flag
SET(OPENCMISS_COMPONENTS_WITH_OPENMP HYPRE PARMETIS PASTIX
    PETSC PLAPACK SUITESPARSE SUPERLU_DIST)

# The opencmiss components that are looked for on the local system instead of building it
SET(OPENCMISS_COMPONENTS_SYSTEM_BY_DEFAULT BLAS LAPACK LLVM LIBXML2 JPEG FREETYPE TIFF)
# local ZLIB PNG wont work (too new) with current other zinc dependencies

# Disabled components - added but not compiling
# SCOTCH is disabled as PTSCOTCH is usually used.
SET(OPENCMISS_COMPONENTS_DISABLED_BY_DEFAULT CSIM LLVM SCOTCH)
#SET(OPENCMISS_COMPONENTS_DISABLED_BY_DEFAULT BLAS LAPACK PLAPACK SCALAPACK PARMETIS SUITESPARSE MUMPS SUPERLU SUPERLU_DIST SUNDIALS SCOTCH SOWING PASTIX HYPRE PETSC LIBCELLML CELLML SLEPC BZIP2 SZIP HDF5 FIELDML-API LIBXML2 IRON CSIM LLVM GTEST)

# Platform pre-checks
# No point in building ZINC if there's no OpenGL around
find_package(OpenGL QUIET)
if (NOT OPENGL_FOUND)
    list(APPEND OPENCMISS_COMPONENTS_DISABLED_BY_DEFAULT ZINC)
    message("OpenCMISS: No OpenGL found, disabling build of ZINC by default.")
endif()
# Currently, there's also little point to build IRON in Visual Studio
if (MSVC)
    list(APPEND OPENCMISS_COMPONENTS_DISABLED_BY_DEFAULT IRON)
    message("OpenCMISS: VisualStudio detected, not building IRON by default.")
endif()

set(OC_MANDATORY_COMPONENTS FIELDML-API LIBXML2)

# This is the support email for general enquiries and support about building opencmiss using the new CMake system.
set(OC_BUILD_SUPPORT_EMAIL "users@opencmiss.org")
# This is an email address being displayed for issues regarding (remote) installations.
# This needs to be set in either LocalConfig or Developer (better) in order to be useful.
# If not set, a warning will be issued 
set(OC_INSTALL_SUPPORT_EMAIL FALSE)
