From: Jyri Sarha <jsarha@ti.com>
Date: Tue, 14 Oct 2014 17:29:25 +0000
Subject: [PATCH v6 06/18] OMAPDSS: hdmi: Add pdev pointer for audio_pdev in HDMI DRV data
Message-Id: <edfccd85dbe95035c0b4ff1905ec16623fd38482.1413306131.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1413306131.git.jsarha@ti.com>
In-Reply-To: <cover.1413306131.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

This is used to store omap-hdmi-audio pdev for unregistering it.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 6bf077b..a6e08ff 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -368,6 +368,8 @@ struct omap_hdmi {
 	bool core_enabled;
 
 	struct omap_dss_device output;
+
+	struct platform_device *audio_pdev;
 };
 
 #endif
-- 
1.7.9.5

