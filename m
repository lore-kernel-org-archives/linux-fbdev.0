From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 03 Mar 2015 10:51:25 +0000
Subject: [PATCH 0/2] add SM750 framebuffer driver
Message-Id: <1425379867-2176-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org

Hi Greg,
As discussed with you previously, this series contains the SM750
driver. This driver was given to me by Silicon Motion and has been
modified so that it compiles with the current kernel version and has
been tested with next-20150303.
I have a demo board (given by Silicon Motion) and it has been tested
before sending to you.
as of now, it has lots of checkpatch warnings and errors. if checked
with --strict option then i get -
total: 3682 errors, 1905 warnings, 1832 checks, 9974 lines checked

as it is a vendor driver crud, so will take some time to clear all
warnings.

regards
sudip

Sudip Mukherjee (2):
  staging: sm750fb: add sm750 to staging
  MAINTAINERS: update for sm750fb driver

 MAINTAINERS                              |    8 +
 drivers/staging/Kconfig                  |    2 +
 drivers/staging/Makefile                 |    1 +
 drivers/staging/sm750fb/Kconfig          |   10 +
 drivers/staging/sm750fb/Makefile         |    4 +
 drivers/staging/sm750fb/TODO             |   15 +
 drivers/staging/sm750fb/ddk750.h         |   24 +
 drivers/staging/sm750fb/ddk750_chip.c    |  639 ++++++++
 drivers/staging/sm750fb/ddk750_chip.h    |   83 +
 drivers/staging/sm750fb/ddk750_display.c |  318 ++++
 drivers/staging/sm750fb/ddk750_display.h |  160 ++
 drivers/staging/sm750fb/ddk750_dvi.c     |   99 ++
 drivers/staging/sm750fb/ddk750_dvi.h     |   67 +
 drivers/staging/sm750fb/ddk750_help.c    |   19 +
 drivers/staging/sm750fb/ddk750_help.h    |   29 +
 drivers/staging/sm750fb/ddk750_hwi2c.c   |  271 ++++
 drivers/staging/sm750fb/ddk750_hwi2c.h   |   10 +
 drivers/staging/sm750fb/ddk750_mode.c    |  205 +++
 drivers/staging/sm750fb/ddk750_mode.h    |   43 +
 drivers/staging/sm750fb/ddk750_power.c   |  239 +++
 drivers/staging/sm750fb/ddk750_power.h   |   71 +
 drivers/staging/sm750fb/ddk750_reg.h     | 2616 ++++++++++++++++++++++++++++++
 drivers/staging/sm750fb/ddk750_sii164.c  |  425 +++++
 drivers/staging/sm750fb/ddk750_sii164.h  |  172 ++
 drivers/staging/sm750fb/ddk750_swi2c.c   |  535 ++++++
 drivers/staging/sm750fb/ddk750_swi2c.h   |   92 ++
 drivers/staging/sm750fb/modedb.h         |  221 +++
 drivers/staging/sm750fb/readme           |   38 +
 drivers/staging/sm750fb/sm750.c          | 1451 +++++++++++++++++
 drivers/staging/sm750fb/sm750.h          |  185 +++
 drivers/staging/sm750fb/sm750_accel.c    |  516 ++++++
 drivers/staging/sm750fb/sm750_accel.h    |  276 ++++
 drivers/staging/sm750fb/sm750_cursor.c   |  254 +++
 drivers/staging/sm750fb/sm750_cursor.h   |   17 +
 drivers/staging/sm750fb/sm750_help.h     |  111 ++
 drivers/staging/sm750fb/sm750_hw.c       |  640 ++++++++
 drivers/staging/sm750fb/sm750_hw.h       |  104 ++
 37 files changed, 9970 insertions(+)
 create mode 100644 drivers/staging/sm750fb/Kconfig
 create mode 100644 drivers/staging/sm750fb/Makefile
 create mode 100644 drivers/staging/sm750fb/TODO
 create mode 100644 drivers/staging/sm750fb/ddk750.h
 create mode 100644 drivers/staging/sm750fb/ddk750_chip.c
 create mode 100644 drivers/staging/sm750fb/ddk750_chip.h
 create mode 100644 drivers/staging/sm750fb/ddk750_display.c
 create mode 100644 drivers/staging/sm750fb/ddk750_display.h
 create mode 100644 drivers/staging/sm750fb/ddk750_dvi.c
 create mode 100644 drivers/staging/sm750fb/ddk750_dvi.h
 create mode 100644 drivers/staging/sm750fb/ddk750_help.c
 create mode 100644 drivers/staging/sm750fb/ddk750_help.h
 create mode 100644 drivers/staging/sm750fb/ddk750_hwi2c.c
 create mode 100644 drivers/staging/sm750fb/ddk750_hwi2c.h
 create mode 100644 drivers/staging/sm750fb/ddk750_mode.c
 create mode 100644 drivers/staging/sm750fb/ddk750_mode.h
 create mode 100644 drivers/staging/sm750fb/ddk750_power.c
 create mode 100644 drivers/staging/sm750fb/ddk750_power.h
 create mode 100644 drivers/staging/sm750fb/ddk750_reg.h
 create mode 100644 drivers/staging/sm750fb/ddk750_sii164.c
 create mode 100644 drivers/staging/sm750fb/ddk750_sii164.h
 create mode 100644 drivers/staging/sm750fb/ddk750_swi2c.c
 create mode 100644 drivers/staging/sm750fb/ddk750_swi2c.h
 create mode 100644 drivers/staging/sm750fb/modedb.h
 create mode 100644 drivers/staging/sm750fb/readme
 create mode 100644 drivers/staging/sm750fb/sm750.c
 create mode 100644 drivers/staging/sm750fb/sm750.h
 create mode 100644 drivers/staging/sm750fb/sm750_accel.c
 create mode 100644 drivers/staging/sm750fb/sm750_accel.h
 create mode 100644 drivers/staging/sm750fb/sm750_cursor.c
 create mode 100644 drivers/staging/sm750fb/sm750_cursor.h
 create mode 100644 drivers/staging/sm750fb/sm750_help.h
 create mode 100644 drivers/staging/sm750fb/sm750_hw.c
 create mode 100644 drivers/staging/sm750fb/sm750_hw.h

-- 
1.8.1.2

