From: Oleg Drokin <green@linuxhacker.ru>
Date: Sat, 27 Aug 2016 03:05:37 +0000
Subject: [PATCH] mx3fb: Fix print format string
Message-Id: <1472267137-810445-1-git-send-email-green@linuxhacker.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Oleg Drokin <green@linuxhacker.ru>

%ul was probably meant as %lu since the former would print
an unsigned value and a letter l.

But in fact the whole value we are printing in u32 anyway, so
we don't need the format to be long. Therefore just drop the l
altogether.

Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
Also do we really need 1000UL specification if we
cast to u32 anyway? Or should we drop away the cast instead?
Are pixelclocks over 4GHz possible here?

 drivers/video/fbdev/mx3fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
index f91b1db..8778e01 100644
--- a/drivers/video/fbdev/mx3fb.c
+++ b/drivers/video/fbdev/mx3fb.c
@@ -845,7 +845,7 @@ static int __set_par(struct fb_info *fbi, bool lock)
 		if (fbi->var.sync & FB_SYNC_SHARP_MODE)
 			mode = IPU_PANEL_SHARP_TFT;
 
-		dev_dbg(fbi->device, "pixclock = %ul Hz\n",
+		dev_dbg(fbi->device, "pixclock = %u Hz\n",
 			(u32) (PICOS2KHZ(fbi->var.pixclock) * 1000UL));
 
 		if (sdc_init_panel(mx3fb, mode,
-- 
2.7.4

