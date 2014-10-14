From: Jyri Sarha <jsarha@ti.com>
Date: Tue, 14 Oct 2014 17:29:22 +0000
Subject: [PATCH v6 03/18] OMAPDSS: hdmi4_core: Remove unused hdmi4_audio_get_dma_port()
Message-Id: <87a848e28ba91aeede8e3cf37f41f4df354b096d.1413306131.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1413306131.git.jsarha@ti.com>
In-Reply-To: <cover.1413306131.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

hdmi4_audio_get_dma_port() is unused and and broken.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi4_core.c |    9 ---------
 drivers/video/fbdev/omap2/dss/hdmi4_core.h |    2 --
 2 files changed, 11 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4_core.c b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
index 3b448d9..7eafea5 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4_core.c
@@ -874,15 +874,6 @@ void hdmi4_audio_stop(struct hdmi_core_data *core, struct hdmi_wp_data *wp)
 	hdmi_wp_audio_core_req_enable(wp, false);
 }
 
-int hdmi4_audio_get_dma_port(u32 *offset, u32 *size)
-{
-	if (!offset || !size)
-		return -EINVAL;
-	*offset = HDMI_WP_AUDIO_DATA;
-	*size = 4;
-	return 0;
-}
-
 int hdmi4_core_init(struct platform_device *pdev, struct hdmi_core_data *core)
 {
 	struct resource *res;
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4_core.h b/drivers/video/fbdev/omap2/dss/hdmi4_core.h
index c1959f7..a069f96 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4_core.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi4_core.h
@@ -270,6 +270,4 @@ int hdmi4_audio_start(struct hdmi_core_data *core, struct hdmi_wp_data *wp);
 void hdmi4_audio_stop(struct hdmi_core_data *core, struct hdmi_wp_data *wp);
 int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 		struct omap_dss_audio *audio, u32 pclk);
-int hdmi4_audio_get_dma_port(u32 *offset, u32 *size);
-
 #endif
-- 
1.7.9.5

