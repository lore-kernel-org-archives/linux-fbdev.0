From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Nov 2011 13:29:30 +0000
Subject: [PATCH 02/13] OMAPDSS: DSI: flush posted write in send_bta
Message-Id: <1322141381-5395-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Flush posted write after setting the bit to send the BTA to ensure the
BTA is sent right away, as the code in dsi_vc_send_bta_sync() waits for
an interrupt caused indirectly by sending the BTA.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 1331f92..4b1c074 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2913,6 +2913,9 @@ static int dsi_vc_send_bta(struct platform_device *dsidev, int channel)
 
 	REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 1, 6, 6); /* BTA_EN */
 
+	/* flush posted write */
+	dsi_read_reg(dsidev, DSI_VC_CTRL(channel));
+
 	return 0;
 }
 
-- 
1.7.4.1

