From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Jun 2014 10:03:56 +0000
Subject: [PATCH 11/15] OMAPDSS: HDMI: add infoframe and hdmi_dvi_mode fields
Message-Id: <1403604240-16738-12-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add infoframe and hdmi_dvi_mode fields to 'struct hdmi_config' which
will be used in the following patches for OMAP4 and OMAP5 HDMI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index e20fe5f70479..e3956defc1c3 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -193,6 +193,8 @@ struct hdmi_video_format {
 struct hdmi_config {
 	struct omap_video_timings timings;
 	struct hdmi_cm cm;
+	struct hdmi_avi_infoframe infoframe;
+	enum hdmi_core_hdmi_dvi hdmi_dvi_mode;
 };
 
 /* HDMI PLL structure */
-- 
1.9.1

