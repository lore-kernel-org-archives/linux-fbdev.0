From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 14 Nov 2011 15:01:43 +0000
Subject: [PATCH 1/3] OMAPDSS: HDMI: fix returned HDMI pixel clock
Message-Id: <1321282905-12939-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321282905-12939-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321282905-12939-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

hdmi_get_pixel_clock() returns the pixel clock in Hz, but the pck is
stored as kHz. This means the return value has to be multiplied by 1000,
not by 10000 as the code did.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 3262f0f..c56378c 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -269,7 +269,7 @@ static void update_hdmi_timings(struct hdmi_config *cfg,
 unsigned long hdmi_get_pixel_clock(void)
 {
 	/* HDMI Pixel Clock in Mhz */
-	return hdmi.ip_data.cfg.timings.timings.pixel_clock * 10000;
+	return hdmi.ip_data.cfg.timings.timings.pixel_clock * 1000;
 }
 
 static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
-- 
1.7.4.1

