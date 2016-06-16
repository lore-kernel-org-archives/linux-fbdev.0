From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 16 Jun 2016 11:38:21 +0000
Subject: [PATCH 0/5] treewide: fix unused-but-set warnings
Message-Id: <20160616113831.4108439-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

I did some test-builds with W=1 and the -Wunused-but-set-variable
warnings appeared to be all fairly easy to address. In tons of
randconfig builds, I only found five instances.

The warning was originally disabled by Dave Jones when we hit
more instances with gcc-4.6, but apparently most of those have
gotten addressed anyway.

All five patches can be applied independently, and in each case,
the original code is not wrong, but the assignments are also useless,
so I'd consider this warning marginally useful.

I have a few other patch series for W=1 issues, and we can
consider turning those on by default once all the patches are
merged.

	Arnd

Arnd Bergmann (5):
  net: qlcnic: don't set unused function argument
  net: tlan: don't set unused function argument
  mic: remove unused function arg
  usb: pxa27x_udc: remove unused function argument
  fbmon: remove unused function argument

 drivers/misc/mic/scif/scif_dma.c                    | 6 ++----
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c | 1 -
 drivers/net/ethernet/ti/tlan.c                      | 1 -
 drivers/usb/gadget/udc/pxa27x_udc.c                 | 9 +++------
 drivers/video/fbdev/core/fbmon.c                    | 1 -
 5 files changed, 5 insertions(+), 13 deletions(-)

-- 
2.9.0
Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc: Dept-GELinuxNICDev@qlogic.com
Cc: Samuel Chessman <chessman@tux.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-usb@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: Dave Jones <davej@codemonkey.org.uk>

