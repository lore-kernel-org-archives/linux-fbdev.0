From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 12 Nov 2014 14:41:03 +0000
Subject: [PATCH v7.1 12/19] OMAPDSS: hdmi.h: Add members to hdmi drvdata for audio implementation
Message-Id: <34f0cd3f1e273a702eb5e962d2eca93d8f34ff86.1415803065.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1415803064.git.jsarha@ti.com>
In-Reply-To: <cover.1415803064.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

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

