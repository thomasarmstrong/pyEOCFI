# pyEOCFI
Python wrapper for Earth Observation CFI Software (https://eop-cfi.esa.int/index.php/mission-cfi-software/eocfi-software) using ctypes


# Getting EOCFI Software

In order to run this wrapper, the EOCFI software library must be downloaded seperately from https://eop-cfi.esa.int/index.php/mission-cfi-software/eocfi-software, which requires the user to create an account for access. This wrapper makes use of the C library, version 4.26. The zip file must be downloaded and copied into the external_libraries folder. In addition to this, the OpenSF Integration Library (OSFI) is required and can be downloaded from https://eop-cfi.esa.int/index.php/opensf/download-installation-packages. This wrapper used version 3.9.2 and the rar file must also be copied into he external_libraries folder.