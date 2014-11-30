From: Marek Belisko <marek@goldelico.com>
Date: Sun, 30 Nov 2014 13:07:44 +0000
Subject: [PATCH v3 0/3] omapdss: Add video output support for gta04
Message-Id: <1417352867-7436-1-git-send-email-marek@goldelico.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

changes from v2:
- rename amplifier-opa362.c to encoder-opa362
- drop inversion handlign from driver
- add ti,invert-polarity to venc node

I also drop devconf1 handling patches because discussion how to
properly implement is not yet finished and this part is independent
from video driver.

changes from v1:
- fix opa362 compilation error
- fix opa362 DT documentation
- move devconf1 definition to omap3.dtsi

Marek Belisko (3):
  video: omapdss: Add opa362 driver
  Documentation: DT: Add documentation for ti,opa362 bindings
  arm: dts: omap3-gta04: Add handling for tv output

 .../devicetree/bindings/video/ti,opa362.txt        |  38 +++
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  49 ++++
 drivers/video/fbdev/omap2/displays-new/Kconfig     |   6 +
 drivers/video/fbdev/omap2/displays-new/Makefile    |   1 +
 .../fbdev/omap2/displays-new/encoder-opa362.c      | 283 +++++++++++++++++++++
 5 files changed, 377 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,opa362.txt
 create mode 100644 drivers/video/fbdev/omap2/displays-new/encoder-opa362.c

-- 
1.9.1

