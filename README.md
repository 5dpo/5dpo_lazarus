# 5dpo_lazarus

This repository contains all the [Lazarus](https://www.lazarus-ide.org/)-based
projects developed within the scope of the 5DPO's participation in robotics
competitions.

## Installation

### Lazarus IDE

Delphi compatible cross-platform IDE. Available in this
[link](https://www.lazarus-ide.org/).

**Ubuntu/Debian**

1. Go to the webpage https://www.lazarus-ide.org/
2. Download the latest version of the Lazarus IDE
   - Download the 3 `.deb` files
3. Install the Lazarus IDE
   ```sh
   cd Downloads/
   sudo apt install ./fpc-laz_3.2.2-210709_amd64.deb
   sudo apt install ./fpc-src_3.2.2-210709_amd64.deb
   sudo apt install ./lazarus-project_2.2.4-0_amd64.deb
   ```

### 5dpo Component Library

Set of components released by the
[5dpo Robotics Team](https://web.fe.up.pt/~robosoc/) for
[Lazarus](https://www.lazarus-ide.org/). Available in this
[link](https://wiki.freepascal.org/5dpo) and also available in this
[repository](pkg/sdpo-0.4.0/).

The installation instructions for installing the components is available in the
[INSTALL](pkg/sdpo-0.4.0/INSTALL) file. Please note that not all packages are
cross-platform compatible (check that in the
[wiki](https://wiki.freepascal.org/5dpo)).

**Requirements:**

- [freenect](https://github.com/OpenKinect/libfreenect)
  ```sh
  sudo apt install freenect
  ```
- LNet
  1. Start Lazarus
  2. Package > Online Package Manage
  3. Search for `lnet` and select the package
  4. Compile and install the package
  5. Restart and rebuild the Lazarus IDE
  6. Fix a bug in the package:
     1. Open the file `/usr/share/fpcsrc/3.2.2/utils/fppkg/lnet/lnet.pp`
     2. TBC
- [PvAPI](https://www.alliedvision.com/en/support/software-downloads/)
  1. Go to the [5dpo_msl_scripts](sh/5dpo_msl_scripts/) folder
  2. Install the camera SDK
     ```sh
     cd install/
     chmod +x 5dpo_install_camera.sh
     sudo ./5dpo_install_camera.sh
     ```

**Bugs identified:**

- Package `sdpofpseriallaz.lpk` error when installing it

## Contacts

If you have any questions or you want to know more about this work, please
contact one of the contributors of this package:

- [Faculty of Engineering of the University of Porto](https://sigarra.up.pt/feup/en)
  - [Team Supervisor] Professor António Paulo Moreira
    ([github](https://github.com/apaulomoreira),
    [feup](mailto:amoreira@fe.up.pt))
  - Professor Paulo Costa
  - João Costa
  - José Carvalho
  - João G. Martins
  - Maria Lopes
  - Sandro Magalhães
  - Ricardo B. Sousa ([github](https://github.com/sousarbarb/),
    [gitlab](https://gitlab.com/sousarbarb/),
    [personal](mailto:sousa.ricardob@outlook.com),
    [feup:professor](mailto:rbs@fe.up.pt),
    [feup:student](mailto:up201503004@edu.fe.up.pt),
    [inesctec](mailto:ricardo.b.sousa@inesctec.pt))
- [INESC TEC - Institute for Systems and Computer Engineering, Technology and Science](https://www.inesctec.pt/en)
  - [Team Leader] Cláudia Daniela Rocha
    ([github](https://github.com/rochaclaudia),
    [gitlab](https://gitlab.inesctec.pt/cdrocha),
    [inesctec](claudia.d.rocha@inesctec.pt))
  - Professor José Magalhães Lima
  - José Maria Sarmento
  - TBC
- External Members
  - Jorge Filipe Ferreira
  - TBC
- Alumni
  - Héber Miguel Sobreira
    ([gitlab](https://gitlab.inesctec.pt/heber.m.sobreira),
    [inesctec](mailto:heber.m.sobreira@inesctec.pt))
  - TBC
