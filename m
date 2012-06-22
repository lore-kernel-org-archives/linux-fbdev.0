From: Rajendra Nayak <rnayak@ti.com>
Date: Fri, 22 Jun 2012 13:51:54 +0000
Subject: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
Message-Id: <1340372890-10091-6-git-send-email-rnayak@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
In-Reply-To: <1340372890-10091-1-git-send-email-rnayak@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
and clk_unprepare() for the omapdss clocks.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: <linux-fbdev@vger.kernel.org>
---
 drivers/video/omap2/dss/dsi.c  |    5 ++++-
 drivers/video/omap2/dss/hdmi.c |    5 ++++-
 drivers/video/omap2/dss/venc.c |    5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index ca8382d..81b474d 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4776,6 +4776,7 @@ static int dsi_get_clocks(struct platform_device *dsidev)
 	}
 
 	dsi->sys_clk = clk;
+	clk_prepare(dsi->sys_clk);
 
 	return 0;
 }
@@ -4786,8 +4787,10 @@ static void dsi_put_clocks(struct platform_device *dsidev)
 
 	if (dsi->dss_clk)
 		clk_put(dsi->dss_clk);
-	if (dsi->sys_clk)
+	if (dsi->sys_clk) {
+		clk_unprepare(dsi->sys_clk);
 		clk_put(dsi->sys_clk);
+	}
 }
 
 static void __init dsi_probe_pdata(struct platform_device *dsidev)
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 8195c71..0b7ded3 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -544,14 +544,17 @@ static int hdmi_get_clocks(struct platform_device *pdev)
 	}
 
 	hdmi.sys_clk = clk;
+	clk_prepare(hdmi.sys_clk);
 
 	return 0;
 }
 
 static void hdmi_put_clocks(void)
 {
-	if (hdmi.sys_clk)
+	if (hdmi.sys_clk) {
+		clk_unprepare(hdmi.sys_clk);
 		clk_put(hdmi.sys_clk);
+	}
 }
 
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 2b89739..62f395d 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -818,14 +818,17 @@ static int venc_get_clocks(struct platform_device *pdev)
 	}
 
 	venc.tv_dac_clk = clk;
+	clk_prepare(venc.tv_dac_clk);
 
 	return 0;
 }
 
 static void venc_put_clocks(void)
 {
-	if (venc.tv_dac_clk)
+	if (venc.tv_dac_clk) {
+		clk_unprepare(venc.tv_dac_clk);
 		clk_put(venc.tv_dac_clk);
+	}
 }
 
 static void __init venc_probe_pdata(struct platform_device *pdev)
-- 
1.7.1

