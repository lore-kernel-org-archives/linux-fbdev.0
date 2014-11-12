From: Marek Belisko <marek@goldelico.com>
Date: Wed, 12 Nov 2014 22:10:42 +0000
Subject: [PATCH v2 0/5] omapdss: Add video output support for gta04 board
Message-Id: <1415830247-31633-1-git-send-email-marek@goldelico.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch series adds support for video output on gta04 board. It consist
of opa362 video amplifier driver + DT bindings, adding venc -> opa362 -> svideo-connecor
setup in DT and finally static setup for tvbypass anc acbias in devconf1 register
via pinctrl subsystem.

Changes from v1:
- fix opa362 compilation error
- fix opa362 DT documentation
- move devconf1 definition to omap3.dtsi

Marek Belisko (5):
  video: omapdss: Add opa362 driver
  Documentation: DT: Add documentation for ti,opa362 bindings
  arm: dts: omap3-gta04: Add handling for tv output
  arm: dts: omap3: Add definition for devconf1 register
  arm: dts: omap3-gta04: Add static configuration for devconf1 register

 .../devicetree/bindings/video/ti,opa362.txt        |  38 +++
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  59 ++++
 arch/arm/boot/dts/omap3.dtsi                       |  13 +
 arch/arm/boot/dts/omap34xx.dtsi                    |   4 +
 arch/arm/boot/dts/omap36xx.dtsi                    |   4 +
 drivers/video/fbdev/omap2/displays-new/Kconfig     |   6 +
 drivers/video/fbdev/omap2/displays-new/Makefile    |   1 +
 .../fbdev/omap2/displays-new/amplifier-opa362.c    | 343 +++++++++++++++++++++
 include/video/omap-panel-data.h                    |  12 +
 9 files changed, 480 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,opa362.txt
 create mode 100644 drivers/video/fbdev/omap2/displays-new/amplifier-opa362.c

-- 
1.9.1

