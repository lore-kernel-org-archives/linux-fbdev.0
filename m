From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 14 Mar 2013 05:53:24 +0000
Subject: [PATCH 0/6] Remove mxsfb auxdata
Message-Id: <1363240410-16865-1-git-send-email-shawn.guo@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The mxsfb driver was converted to device tree by asking platform to
pass mxsfb_platform_data with auxdata.  We did this to have mach-mxs
be DT only platform when there was no videomode bindings.  Now with
the videomode bindings and helpers in place, the series changes mxsfb
driver to get display_timings from device tree, and removes mxsfb
platform_data and auxdata completely.

To maintain the bisectability, the series needs to go via single tree,
and I prefer to arm-soc tree.

Shawn Guo (6):
  video: mxsfb: use devm_* managed functions
  video: mxsfb: remove fb_phys/fb_size from platform_data
  video: mxsfb: remove dotclk_delay from platform_data
  video: mxsfb: get display timings from device tree
  ARM: mxs: move display timing configurations into device tree
  video: mxsfb: remove mxsfb_platform_data

 Documentation/devicetree/bindings/fb/mxsfb.txt |   34 ++++
 arch/arm/boot/dts/imx23-evk.dts                |   25 +++
 arch/arm/boot/dts/imx28-apf28dev.dts           |   25 +++
 arch/arm/boot/dts/imx28-apx4devkit.dts         |   25 +++
 arch/arm/boot/dts/imx28-cfa10049.dts           |   25 +++
 arch/arm/boot/dts/imx28-evk.dts                |   25 +++
 arch/arm/boot/dts/imx28-m28evk.dts             |   25 +++
 arch/arm/mach-mxs/mach-mxs.c                   |  153 -----------------
 drivers/video/Kconfig                          |    2 +
 drivers/video/mxsfb.c                          |  219 +++++++++++++++---------
 include/linux/mxsfb.h                          |   49 ------
 11 files changed, 320 insertions(+), 287 deletions(-)
 delete mode 100644 include/linux/mxsfb.h

-- 
1.7.9.5


