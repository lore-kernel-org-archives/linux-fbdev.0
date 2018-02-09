From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 09 Feb 2018 14:00:47 +0000
Subject: [GIT PULL] fbdev fix for v4.16
Message-Id: <2724350.XWj4eWGWql@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180209140049epcas1p2f634bd4306a16e4cf7ee7b411b811f0b@epcas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>


Hi Linus,

Please pull fbdev fix for v4.16 (just a single fix to make
omapfb driver build again).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit f1517df8701c9f12dae9ce7f43a5d300a6917619:

  Merge tag 'nfsd-4.16' of git://linux-nfs.org/~bfields/linux (2018-02-08 15:18:32 -0800)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.16-fix

for you to fetch changes up to b9058afcd6c725a8d293bb0a1b30bad68113235e:

  video: omapfb: fix missing #includes (2018-02-09 14:43:49 +0100)

----------------------------------------------------------------
fbdev fix for v4.16:

- fix building of the omapfb driver (Tomi Valkeinen)

----------------------------------------------------------------
Tomi Valkeinen (1):
      video: omapfb: fix missing #includes

 drivers/video/fbdev/omap2/omapfb/dss/dss.c      | 1 +
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c | 2 ++
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c | 1 +
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c  | 2 ++
 4 files changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
index 39fe724..f0cac9e 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
@@ -40,6 +40,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/suspend.h>
 #include <linux/component.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <video/omapfb_dss.h>
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
index eee09b4b..11dbc05 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
@@ -13,6 +13,8 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/seq_file.h>
+
 #include <video/omapfb_dss.h>
 
 #include "dss.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
index eac3665..bc591fc 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/seq_file.h>
 
 #include <video/omapfb_dss.h>
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
index 705373e..4af6ba2 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
@@ -14,6 +14,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
+
 #include <video/omapfb_dss.h>
 
 #include "dss.h"

