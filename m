From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 12 Nov 2014 14:40:59 +0000
Subject: [PATCH v7.1 08/19] OMAPDSS: hdmi: Add pdev pointer for audio_pdev in HDMI DRV data
Message-Id: <268eca0e54dc22f1c1c648dfbd108e2f032be47a.1415803065.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1415803064.git.jsarha@ti.com>
In-Reply-To: <cover.1415803064.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

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

