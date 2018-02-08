From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 08 Feb 2018 13:24:54 +0000
Subject: [PATCH] video: omapfb: fix missing #includes
Message-Id: <1518096294-14427-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Something has changed with the include files and omapfb no longer
compiles as it is not explicitly including linux/pinctrl/consumer.h and
linux/seq_file.h.

Add the missing #includes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---

This is on top of today's Linus' master branch.


 drivers/video/fbdev/omap2/omapfb/dss/dss.c      | 1 +
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c | 1 +
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c | 1 +
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
index 39fe7247ff98..f0cac9e0eb94 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
@@ -40,6 +40,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/suspend.h>
 #include <linux/component.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <video/omapfb_dss.h>
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
index eee09b4bdcf6..964474b65b8b 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <video/omapfb_dss.h>
+#include <linux/seq_file.h>
 
 #include "dss.h"
 #include "hdmi.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
index eac3665aba6c..bc591fc12aef 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/seq_file.h>
 
 #include <video/omapfb_dss.h>
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
index 705373e4cf38..e93e7a703299 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <video/omapfb_dss.h>
+#include <linux/seq_file.h>
 
 #include "dss.h"
 #include "hdmi.h"
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

