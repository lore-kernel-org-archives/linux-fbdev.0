From: Jyri Sarha <jsarha@ti.com>
Date: Tue, 14 Oct 2014 17:29:31 +0000
Subject: [PATCH v6 12/18] OMAPDSS: hdmi.h: Add members to hdmi drvdata for audio implementation
Message-Id: <3811cd4b435ab6bff3697a690af0af9070378c9c.1413306131.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1413306131.git.jsarha@ti.com>
In-Reply-To: <cover.1413306131.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Adds display_enabled flag and audio_abort_cb callback to struct hdmi.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 6d129f2..bfaaf2f 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -366,10 +366,12 @@ struct omap_hdmi {
 	struct regulator *vdda_reg;
 
 	bool core_enabled;
+	bool display_enabled;
 
 	struct omap_dss_device output;
 
 	struct platform_device *audio_pdev;
+	void (*audio_abort_cb)(struct device *dev);
 };
 
 #endif
-- 
1.7.9.5

