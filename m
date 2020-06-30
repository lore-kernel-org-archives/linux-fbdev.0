From: Evgeny Novikov <novikov@ispras.ru>
Date: Tue, 30 Jun 2020 19:54:51 +0000
Subject: [PATCH] video: fbdev: neofb: fix memory leak in neo_scan_monitor()
Message-Id: <20200630195451.18675-1-novikov@ispras.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: ldv-project@linuxtesting.org, linux-fbdev@vger.kernel.org, Evgeny Novikov <novikov@ispras.ru>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Mike Rapoport <rppt@linux.ibm.com>, Jani Nikula <jani.nikula@intel.com>, Andrew Morton <akpm@linux-foundation.org>

neofb_probe() calls neo_scan_monitor() that can successfully allocate a
memory for info->monspecs.modedb and proceed to case 0x03. There it does
not free the memory and returns -1. neofb_probe() goes to label
err_scan_monitor, thus, it does not free this memory through calling
fb_destroy_modedb() as well. We can not go to label err_init_hw since
neo_scan_monitor() can fail during memory allocation. So, the patch frees
the memory directly for case 0x03.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/video/fbdev/neofb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
index f5a676bfd67a..09a20d4ab35f 100644
--- a/drivers/video/fbdev/neofb.c
+++ b/drivers/video/fbdev/neofb.c
@@ -1819,6 +1819,7 @@ static int neo_scan_monitor(struct fb_info *info)
 #else
 		printk(KERN_ERR
 		       "neofb: Only 640x480, 800x600/480 and 1024x768 panels are currently supported\n");
+		kfree(info->monspecs.modedb);
 		return -1;
 #endif
 	default:
-- 
2.16.4
