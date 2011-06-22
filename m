From: Mythri P K <mythripk@ti.com>
Date: Wed, 22 Jun 2011 11:55:16 +0000
Subject: [PATCH 8/8] OMAP4: DSS: Rename hdmi_omap4_panel.c to hdmi_panel.c
Message-Id: <1308742996-19230-9-git-send-email-mythripk@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

As the panel driver will remain generic across OMAP's renaming it to
hdmi_panel.c

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/Makefile                   |    2 +-
 .../omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/video/omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} (99%)

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 10d9d3b..37d537c 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -6,4 +6,4 @@ omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
 omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
 omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
 omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi.o \
-				    hdmi_omap4_panel.o
+				    hdmi_panel.o
diff --git a/drivers/video/omap2/dss/hdmi_omap4_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
similarity index 99%
rename from drivers/video/omap2/dss/hdmi_omap4_panel.c
rename to drivers/video/omap2/dss/hdmi_panel.c
index 7d4f2bd..e30182f 100644
--- a/drivers/video/omap2/dss/hdmi_omap4_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -1,5 +1,5 @@
 /*
- * hdmi_omap4_panel.c
+ * hdmi_panel.c
  *
  * HDMI library support functions for TI OMAP4 processors.
  *
-- 
1.7.5.4

