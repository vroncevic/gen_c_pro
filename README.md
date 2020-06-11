# Generate C Project.

***gen_c_pro*** is shell tool for generating C project.

Developed in bash code: ***100%***.

The README is used to introduce the modules and provide instructions on
how to install the modules, any machine dependencies it may have and any
other information that should be provided before the modules are installed.

[![GitHub issues open](https://img.shields.io/github/issues/vroncevic/gen_c_pro.svg)](https://github.com/vroncevic/gen_c_pro/issues)
 [![GitHub contributors](https://img.shields.io/github/contributors/vroncevic/gen_c_pro.svg)](https://github.com/vroncevic/gen_c_pro/graphs/contributors)

<!-- START doctoc -->
**Table of Contents**

- [Installation](https://github.com/vroncevic/gen_c_pro#installation)
- [Usage](https://github.com/vroncevic/gen_c_pro#usage)
- [Dependencies](https://github.com/vroncevic/gen_c_pro#dependencies)
- [Shell tool structure](https://github.com/vroncevic/gen_c_pro#shell-tool-structure)
- [Docs](https://github.com/vroncevic/gen_c_pro#docs)
- [Copyright and Licence](https://github.com/vroncevic/gen_c_pro#copyright-and-licence)
<!-- END doctoc -->

### INSTALLATION

Navigate to release [page](https://github.com/vroncevic/gen_c_pro/releases) download and extract release archive.

To install modules type the following:

```
tar xvzf gen_c_pro-x.y.z.tar.gz
cd gen_c_pro-x.y.z
cp -R ~/sh_tool/bin/   /root/scripts/gen_c_pro/ver.1.0/
cp -R ~/sh_tool/conf/  /root/scripts/gen_c_pro/ver.1.0/
cp -R ~/sh_tool/log/   /root/scripts/gen_c_pro/ver.1.0/
```

![alt tag](https://raw.githubusercontent.com/vroncevic/gen_c_pro/dev/docs/setup_tree.png)

Or You can use docker to create image/container.

### USAGE

```
# Create symlink for shell tool
ln -s /root/scripts/gen_c_pro/ver.1.0/bin/gen_c_pro.sh /root/bin/gen_c_pro

# Setting PATH
export PATH=${PATH}:/root/bin/

# Generating C project
gen_c_pro SimpleTest
```

### DEPENDENCIES

This module requires these other modules and libraries:

* sh_util https://github.com/vroncevic/sh_util

### SHELL TOOL STRUCTURE

***gen_c_pro*** is based on MOP.

Shell tool structure:
```
.
├── bin/
│   └── gen_c_pro.sh
├── conf/
│   ├── gen_c_pro.cfg
│   ├── gen_c_pro_util.cfg
│   ├── project_set.cfg
│   └── template/
│       ├── authors.template
│       ├── autogen.template
│       ├── c_editorconfig.template
│       ├── changelog.template
│       ├── configure_ac.template
│       ├── copying.template
│       ├── c_source.template
│       ├── makefile_am_root.template
│       ├── makefile_am_src.template
│       ├── news.template
│       └── readme.template
└── log/
    └── gen_c_pro.log
```

### DOCS

[![Documentation Status](https://readthedocs.org/projects/gen_c_pro/badge/?version=latest)](https://gen_c_pro.readthedocs.io/projects/gen_c_pro/en/latest/?badge=latest)

More documentation and info at:

* https://gen_c_pro.readthedocs.io/en/latest/

### COPYRIGHT AND LICENCE

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2018 by https://vroncevic.github.io/gen_c_pro

This tool is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

