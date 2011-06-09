From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 09 Jun 2011 13:56:25 +0000
Subject: [PATCHv2 03/28] OMAP: DSS2: Reset LANEx_ULPS_SIG2 bits after use
Message-Id: <1307627810-3768-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

LANEx_ULPS_SIG2 bits are left on after entering ULPS. This doesn't cause
any problems currently, as DSI HW is reset when it is enabled. However,
if the reset is not done, operation fails if the bits are still set.

So reset the bits after entering ULPS to ensure operation even without
HW reset.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 69c2d4f..4496d09 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3395,6 +3395,10 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
 	dsi_unregister_isr_cio(dsidev, dsi_completion_handler, &completion,
 			DSI_CIO_IRQ_ULPSACTIVENOT_ALL0);
 
+	/* Reset LANEx_ULPS_SIG2 */
+	REG_FLD_MOD(dsidev, DSI_COMPLEXIO_CFG2, (0 << 0) | (0 << 1) | (0 << 2),
+		7, 5);
+
 	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_ULPS);
 
 	dsi_if_enable(dsidev, false);
-- 
1.7.4.1

