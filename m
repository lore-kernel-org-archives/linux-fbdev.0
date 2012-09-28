From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Date: Fri, 28 Sep 2012 10:35:18 +0000
Subject: [PATCH V3 1/3] OMAPDSS: Move definition of DEBUG flag to Makefile
Message-Id: <fbaf2825628b01a7b660993a83a8f3de37cfcd04.1348826106.git.cmahapatra@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1348636132.git.cmahapatra@ti.com> <cover.1348826106.git.cmahapatra@ti.com>
In-Reply-To: <cover.1348826106.git.cmahapatra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

In OMAPDSS the DEBUG flag is set only after the OMAPDSS module is called, for
which the debugging capabilities are available only after its proper
initialization. As a result of which tracking of bugs prior to or during initial
process becomes difficult. So, the definition of DEBUG is being moved to the
corresponding Makefile.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/Makefile |    1 +
 drivers/video/omap2/dss/dss.h    |    4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 4549869..86493e3 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -8,3 +8,4 @@ omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
 omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
 omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi.o \
 				    hdmi_panel.o ti_hdmi_4xxx_ip.o
+ccflags-$(CONFIG_OMAP2_DSS_DEBUG_SUPPORT) += -DDEBUG
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 6728892..ffbba7e 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -23,10 +23,6 @@
 #ifndef __OMAP2_DSS_H
 #define __OMAP2_DSS_H
 
-#ifdef CONFIG_OMAP2_DSS_DEBUG_SUPPORT
-#define DEBUG
-#endif
-
 #ifdef DEBUG
 extern bool dss_debug;
 #ifdef DSS_SUBSYS_NAME
-- 
1.7.10

