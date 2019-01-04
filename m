From: Matteo Croce <mcroce@redhat.com>
Date: Fri, 04 Jan 2019 21:43:45 +0000
Subject: [PATCH] omapfb: fix typo
Message-Id: <20190104214345.29158-1-mcroce@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Fix spelling mistake: "lenght" -> "length"

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
index fa72e735dad2..d146793dd044 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
@@ -712,7 +712,7 @@ int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 	else
 		acore.i2s_cfg.justification = HDMI_AUDIO_JUSTIFY_RIGHT;
 	/*
-	 * The I2S input word length is twice the lenght given in the IEC-60958
+	 * The I2S input word length is twice the length given in the IEC-60958
 	 * status word. If the word size is greater than
 	 * 20 bits, increment by one.
 	 */
-- 
2.20.1
