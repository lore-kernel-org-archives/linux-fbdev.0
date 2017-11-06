From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Mon, 06 Nov 2017 22:40:01 +0000
Subject: [PATCH] video: fbdev: aty: radeon_pm: mark expected switch fall-throughs
Message-Id: <20171106224001.GA1754@embeddedor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/video/fbdev/aty/radeon_pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/aty/radeon_pm.c b/drivers/video/fbdev/aty/radeon_pm.c
index f7c253d..7137c12 100644
--- a/drivers/video/fbdev/aty/radeon_pm.c
+++ b/drivers/video/fbdev/aty/radeon_pm.c
@@ -1208,9 +1208,11 @@ static void radeon_pm_enable_dll_m10(struct radeonfb_info *rinfo)
 	case 1:
 		if (mc & 0x4)
 			break;
+		/* fall through */
 	case 2:
 		dll_sleep_mask |= MDLL_R300_RDCK__MRDCKB_SLEEP;
 		dll_reset_mask |= MDLL_R300_RDCK__MRDCKB_RESET;
+		/* fall through */
 	case 0:
 		dll_sleep_mask |= MDLL_R300_RDCK__MRDCKA_SLEEP;
 		dll_reset_mask |= MDLL_R300_RDCK__MRDCKA_RESET;
@@ -1219,6 +1221,7 @@ static void radeon_pm_enable_dll_m10(struct radeonfb_info *rinfo)
 	case 1:
 		if (!(mc & 0x4))
 			break;
+		/* fall through */
 	case 2:
 		dll_sleep_mask |= MDLL_R300_RDCK__MRDCKD_SLEEP;
 		dll_reset_mask |= MDLL_R300_RDCK__MRDCKD_RESET;
-- 
2.7.4

