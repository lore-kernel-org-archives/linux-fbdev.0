From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 20 Jul 2011 11:24:26 +0000
Subject: [PATCH v2 3/6] fbdev: sh_mobile_lcdc: Compute clock pattern using divider denominator
Message-Id: <1311161069-11918-4-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The clock divider pattern is computed based on the dot clock register
value which stores the divider denumerator. However, when using a 1:1
divider ratio, the register is programmed with a value that must not be
interpreted as a denominator. This results in a shift left operation
with a value of 32, which produces undefined behaviour.

Compute the clock pattern using the divider denominator, not the dot
clock register value.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index ba946f4..31aef60 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -481,13 +481,15 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 		if (!m)
 			continue;
 
+		/* FIXME: sh7724 can only use 42, 48, 54 and 60 for the divider
+		 * denominator.
+		 */
+		lcdc_write_chan(ch, LDDCKPAT1R, 0);
+		lcdc_write_chan(ch, LDDCKPAT2R, (1 << (m/2)) - 1);
+
 		if (m = 1)
 			m = LDDCKR_MOSEL;
 		tmp |= m << (lcdc_chan_is_sublcd(ch) ? 8 : 0);
-
-		/* FIXME: sh7724 can only use 42, 48, 54 and 60 for the divider denominator */
-		lcdc_write_chan(ch, LDDCKPAT1R, 0);
-		lcdc_write_chan(ch, LDDCKPAT2R, (1 << (m/2)) - 1);
 	}
 
 	lcdc_write(priv, _LDDCKR, tmp);
-- 
1.7.3.4

