From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 09 Nov 2011 04:33:29 +0000
Subject: [PATCH 01/15] fbdev: sh_mobile_lcdcfb: fixup LDHAJR :: HSYNPAJ needs mask
Message-Id: <8739dxc3u1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

LDHAJR register will be broken by hsync_pos without this patch

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index facffc2..1f49ab4 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -420,7 +420,7 @@ static void sh_mobile_lcdc_geometry(struct sh_mobile_lcdc_chan *ch)
 	tmp = ((display_var->xres & 7) << 24) |
 		((display_h_total & 7) << 16) |
 		((display_var->hsync_len & 7) << 8) |
-		hsync_pos;
+		(hsync_pos & 7);
 	lcdc_write_chan(ch, LDHAJR, tmp);
 }
 
-- 
1.7.5.4

