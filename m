From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 08 Mar 2017 10:14:33 +0000
Subject: [PATCH] video/logo: tidyup fb_logo_late_init initcall timing
Message-Id: <87h934oz7j.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent <laurent.pinchart@ideasonboard.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Fabian Frederick <fabf@skynet.be>, Andrew Morton <akpm@linux-foundation.org>, shimoda <yoshihiro.shimoda.uh@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, shiiba <naoya.shiiba.nx@renesas.com>, sakato <ryusuke.sakato.bx@renesas.com>, Hosoya <yoshifumi.hosoya.wj@renesas.com>, Fukawa <tomoharu.fukawa.eb@renesas.com>, Hien Dang <hien.dang.eb@renesas.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kouei Abe <kouei.abe.cp@renesas.com>, Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Some video driver might returns -EPROBE_DEFER when probe timing,
but logo init function doesn't care it.
Thus, such kernel can't have logo when boot time.

This patch solves this issue by exchanging current
late_initcall to late_initcall_sync

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/video/logo/logo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index b6bc4a0..4d50bfd 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -34,7 +34,7 @@ static int __init fb_logo_late_init(void)
 	return 0;
 }
 
-late_initcall(fb_logo_late_init);
+late_initcall_sync(fb_logo_late_init);
 
 /* logo's are marked __initdata. Use __ref to tell
  * modpost that it is intended that this function uses data
-- 
1.9.1

