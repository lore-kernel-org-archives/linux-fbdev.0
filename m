From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 13 Jan 2015 16:58:59 +0000
Subject: [PATCH] OMAPDSS: hdmi5: remove unneeded check
Message-Id: <1421167620-17290-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

prior to this check we are checking for word_length_16b and if word_length_16b
is false then we are returning with -EINVAL.
So at this point word_length_16b can only be true.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/video/fbdev/omap2/dss/hdmi5_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
index a3cfe3d..6bf4b75 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
@@ -858,10 +858,7 @@ int hdmi5_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 		core_cfg.layout = HDMI_AUDIO_LAYOUT_8CH;
 
 	/* DMA settings */
-	if (word_length_16b)
-		audio_dma.transfer_size = 0x10;
-	else
-		audio_dma.transfer_size = 0x20;
+	audio_dma.transfer_size = 0x10;
 	audio_dma.block_size = 0xC0;
 	audio_dma.mode = HDMI_AUDIO_TRANSF_DMA;
 	audio_dma.fifo_threshold = 0x20; /* in number of samples */
-- 
1.8.1.2

