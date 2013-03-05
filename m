From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 05 Mar 2013 04:44:39 +0000
Subject: [PATCH] fbdev: sh_mobile_lcdc: fixup B side hsync adjust settings
Message-Id: <87wqtmmp59.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


The lcdc B side horizon output is shifted if sh_mobile_lcdc_pan() was called,
since driver didn't care LDHAJR mirror.
This patch fixup this issue

Reported-by: Osamu Fukushima <osamu.fukushima.wr@renesas.com>
Signed-off-by: Hideyuki Sano <hideyuki.sano.dn@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 63203ac..0264704 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -858,6 +858,7 @@ static void sh_mobile_lcdc_geometry(struct sh_mobile_lcdc_chan *ch)
 	tmp = ((mode->xres & 7) << 24) | ((display_h_total & 7) << 16)
 	    | ((mode->hsync_len & 7) << 8) | (hsync_pos & 7);
 	lcdc_write_chan(ch, LDHAJR, tmp);
+	lcdc_write_chan_mirror(ch, LDHAJR, tmp);
 }
 
 static void sh_mobile_lcdc_overlay_setup(struct sh_mobile_lcdc_overlay *ovl)
-- 
1.7.9.5

