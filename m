From: Anatolij Gustschin <agust@denx.de>
Date: Thu, 29 Apr 2010 23:49:33 +0000
Subject: [PATCH 0/5] Rework MPC5121 DIU support (for 2.6.35)
Message-Id: <1272584978-19063-1-git-send-email-agust@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, devicetree-discuss@lists.ozlabs.org, yorksun@freescale.com

This patch series rework DIU support patches submitted
previously. Comments to the previos patch series have
been addressed, not related changes are dropped and some
changes are split out to separate patches to simplify
review. Furthermore a patch has been added to support
setting display mode using EDID block in the device tree.

Anatolij Gustschin (5):
  fsl-diu-fb: fix issue with re-enabling DIU area descriptor on MPC5121
  fsl-diu-fb: move fsl-diu-fb.h to include/linux
  powerpc/mpc5121: shared DIU framebuffer support
  powerpc: doc/dts-bindings: update doc of FSL DIU bindings
  fsl-diu-fb: Support setting display mode using EDID

 Documentation/powerpc/dts-bindings/fsl/diu.txt |   20 ++-
 arch/powerpc/platforms/512x/mpc5121_ads.c      |    7 +
 arch/powerpc/platforms/512x/mpc5121_generic.c  |   12 +
 arch/powerpc/platforms/512x/mpc512x.h          |    2 +
 arch/powerpc/platforms/512x/mpc512x_shared.c   |  284 ++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h                  |    1 +
 drivers/video/Kconfig                          |    1 +
 drivers/video/fsl-diu-fb.c                     |  104 ++++++++-
 {drivers/video => include/linux}/fsl-diu-fb.h  |    0
 9 files changed, 419 insertions(+), 12 deletions(-)
 rename {drivers/video => include/linux}/fsl-diu-fb.h (100%)

