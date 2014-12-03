From: Xiubo Li <Li.Xiubo@freescale.com>
Date: Wed, 03 Dec 2014 09:15:58 +0000
Subject: [PATCHv2 0/4] LS1021A: Add dcfb framebuffer driver support.
Message-Id: <1417598162-40433-1-git-send-email-Li.Xiubo@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Framebuffer driver for the Freescale SoC Display Controller.


Change in V2:
- Use the native-mode timing as default.
- Add to_fsl_private().


Xiubo Li (4):
  video: fsl-dcfb: Add dcfb framebuffer driver for LS1021A platform
  video: fsl-dcfb: Add devicetree binding support
  ARM: ls1021a: dtsi: Add dt node support for dcfb.
  ARM: ls1021a: dts: Add and enable dt node for dcfb.

 .../devicetree/bindings/video/fsl,dcfb.txt         |  52 ++
 arch/arm/boot/dts/ls1021a-twr.dts                  |  26 +
 arch/arm/boot/dts/ls1021a.dtsi                     |  10 +
 drivers/video/fbdev/Kconfig                        |  19 +
 drivers/video/fbdev/Makefile                       |   1 +
 drivers/video/fbdev/fsl-dcfb.c                     | 814 +++++++++++++++++++++
 6 files changed, 922 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/fsl,dcfb.txt
 create mode 100644 drivers/video/fbdev/fsl-dcfb.c

-- 
2.1.0.27.g96db324

