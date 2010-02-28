From: "sun york-R58495" <R58495@freescale.com>
Date: Sun, 28 Feb 2010 14:32:06 +0000
Subject: RE: [PATCH 0/3] Rework MPC5121 DIU support (for 2.6.34)
Message-Id: <10cb201cab882$d0026955$0c23400a@fsl.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1267307902-31939-1-git-send-email-agust@denx.de>
In-Reply-To: <1267307902-31939-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, jrigby@gmail.com, linuxppc-dev@ozlabs.org

I agree device tree is the right direction to go.

Sent from my Android phone
----- Original Message -----
From:"Anatolij Gustschin" <agust@denx.de>
To:"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Cc:"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "yorksun@freescale.com" <yorksun@freescale.com>, "dzu@denx.de" <dzu@denx.de>, "wd@denx.de" <wd@denx.de>, "jrigby@gmail.com" <jrigby@gmail.com>, "Anatolij Gustschin" <agust@denx.de>
Sent:02-27-2010 16:00
Subject:[PATCH 0/3] Rework MPC5121 DIU support (for 2.6.34)


This patch series rework DIU support patch submitted
previously with the patch series for updating MPC5121
support in mainline. It doesn't add new panel timing data
to the framebuffer driver anymore. Instead we now allow
encoding this data in the device tree. First two patches
add this support.

The third patch for DIU support is rebased, but still
depends on patches for adding MPC5121 USB support (because
it touches shared platform code).

It is intended for inclusion in 2.6.34, since without
DIU support patch framebuffer doesn't work on mpc5121.

Anatolij Gustschin (3):
  video: add support for getting video mode from device tree
  fbdev: fsl-diu-fb.c: allow setting panel video mode from DT
  powerpc/mpc5121: shared DIU framebuffer support

 arch/powerpc/platforms/512x/mpc5121_ads.c     |    7 +
 arch/powerpc/platforms/512x/mpc5121_generic.c |   13 ++
 arch/powerpc/platforms/512x/mpc512x.h         |    3 +
 arch/powerpc/platforms/512x/mpc512x_shared.c  |  282 +++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h                 |    1 +
 drivers/video/Kconfig                         |    6 +
 drivers/video/Makefile                        |    1 +
 drivers/video/fsl-diu-fb.c                    |   88 +++++---
 drivers/video/fsl-diu-fb.h                    |  223 -------------------
 drivers/video/ofmode.c                        |   95 +++++++++
 drivers/video/ofmode.h                        |    6 +
 include/linux/fsl-diu-fb.h                    |  223 +++++++++++++++++++
 12 files changed, 693 insertions(+), 255 deletions(-)
 delete mode 100644 drivers/video/fsl-diu-fb.h
 create mode 100644 drivers/video/ofmode.c
 create mode 100644 drivers/video/ofmode.h
 create mode 100644 include/linux/fsl-diu-fb.h


