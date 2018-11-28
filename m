From: Colin King <colin.king@canonical.com>
Date: Wed, 28 Nov 2018 15:37:35 +0000
Subject: [PATCH] fbdev: uvesafb: fix spelling mistake "memoery" -> "memory"
Message-Id: <20181128153735.14083-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Januszewski <spock@gentoo.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the module parameter description, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/uvesafb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 440a6636d8f0..34dc8e53a1e9 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1979,7 +1979,7 @@ MODULE_PARM_DESC(noedid,
 module_param(vram_remap, uint, 0);
 MODULE_PARM_DESC(vram_remap, "Set amount of video memory to be used [MiB]");
 module_param(vram_total, uint, 0);
-MODULE_PARM_DESC(vram_total, "Set total amount of video memoery [MiB]");
+MODULE_PARM_DESC(vram_total, "Set total amount of video memory [MiB]");
 module_param(maxclk, ushort, 0);
 MODULE_PARM_DESC(maxclk, "Maximum pixelclock [MHz], overrides EDID data");
 module_param(maxhf, ushort, 0);
-- 
2.19.1
