gen_c_pro
----------

**gen_c_pro** is shell tool for generating C project.

Developed in `bash <https://en.wikipedia.org/wiki/Bash_(Unix_shell)>`_ code: **100%**.

|GitHub shell checker|

.. |GitHub shell checker| image:: https://github.com/vroncevic/gen_c_pro/workflows/gen_c_pro%20shell%20checker/badge.svg
   :target: https://github.com/vroncevic/gen_c_pro/actions?query=workflow%3A%22gen_c_pro+shell+checker%22

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

|GitHub issues| |Documentation Status| |GitHub contributors|

.. |GitHub issues| image:: https://img.shields.io/github/issues/vroncevic/gen_c_pro.svg
   :target: https://github.com/vroncevic/gen_c_pro/issues

.. |GitHub contributors| image:: https://img.shields.io/github/contributors/vroncevic/gen_c_pro.svg
   :target: https://github.com/vroncevic/gen_c_pro/graphs/contributors

.. |Documentation Status| image:: https://readthedocs.org/projects/gen_c_pro/badge/?version=latest
   :target: https://gen_c_pro.readthedocs.io/projects/gen_c_pro/en/latest/?badge=latest

.. toctree::
    :hidden:

    self

Installation
-------------

Navigate to release `page`_ download and extract release archive.

.. _page: https://github.com/vroncevic/gen_c_pro/releases

To install **gen_c_pro** type the following:

.. code-block:: bash

   tar xvzf gen_c_pro-x.y.tar.gz
   cd gen_c_pro-x.y
   cp -R ~/sh_tool/bin/   /root/scripts/gen_c_pro/ver.x.y/
   cp -R ~/sh_tool/conf/  /root/scripts/gen_c_pro/ver.x.y/
   cp -R ~/sh_tool/log/   /root/scripts/gen_c_pro/ver.x.y/

Or You can use Docker to create image/container.

|GitHub docker checker|

.. |GitHub docker checker| image:: https://github.com/vroncevic/gen_c_pro/workflows/gen_c_pro%20docker%20checker/badge.svg
   :target: https://github.com/vroncevic/gen_c_pro/actions?query=workflow%3A%22gen_c_pro+docker+checker%22

Dependencies
-------------

**gen_c_pro** requires next modules and libraries:
    sh_util `https://github.com/vroncevic/sh_util <https://github.com/vroncevic/sh_util>`_

Shell tool structure
---------------------

**gen_c_pro** is based on MOP.

Code structure:

.. code-block:: bash

   sh_tool/
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

Copyright and licence
----------------------

|License: GPL v3| |License: Apache 2.0|

.. |License: GPL v3| image:: https://img.shields.io/badge/License-GPLv3-blue.svg
   :target: https://www.gnu.org/licenses/gpl-3.0

.. |License: Apache 2.0| image:: https://img.shields.io/badge/License-Apache%202.0-blue.svg
   :target: https://opensource.org/licenses/Apache-2.0

Copyright (C) 2017 by `vroncevic.github.io/gen_c_pro <https://vroncevic.github.io/gen_c_pro>`_

**gen_c_pro** is free software; you can redistribute it and/or modify it
under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

**gen_c_pro** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

Lets help and support FSF.

[![Free Software Foundation](https://raw.githubusercontent.com/vroncevic/gen_c_pro/dev/docs/fsf-logo_1.png)](https://my.fsf.org/)

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://my.fsf.org/donate/)
