From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Fri, 19 Nov 2010 21:58:42 +0000
Subject: [PATCH 0/9] sisfb: remove cruft code
Message-Id: <1290203931-25188-1-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: thomas@winischhofer.net, aaro.koskinen@iki.fi

This series deletes unused/unneeded code from sisfb, while not changing
the functionality.

Aaro Koskinen (9):
  sisfb: delete obsolete PCI ROM bug workaround
  sisfb: delete fallback code for pci_map_rom()
  sisfb: delete dead SIS_XORG_XF86 code
  sisfb: delete redudant #define SIS_LINUX_KERNEL
  sisfb: use CONFIG_FB_SIS_301/315 instead of SIS301/315H
  sisfb: remove InPort/OutPort wrappers
  sisfb: replace SiS_SetMemory with memset_io
  sisfb: move the CONFIG warning to sis_main.c
  sisfb: delete osdef.h

 drivers/video/sis/init.c       |  685 +++-------------------------------------
 drivers/video/sis/init.h       |   63 +----
 drivers/video/sis/init301.c    |  467 ++++++++-------------------
 drivers/video/sis/init301.h    |   43 +--
 drivers/video/sis/initextlfb.c |    7 +-
 drivers/video/sis/osdef.h      |  133 --------
 drivers/video/sis/sis.h        |    1 -
 drivers/video/sis/sis_main.c   |   30 +--
 drivers/video/sis/vgatypes.h   |   11 -
 drivers/video/sis/vstruct.h    |   12 -
 10 files changed, 209 insertions(+), 1243 deletions(-)
 delete mode 100644 drivers/video/sis/osdef.h

