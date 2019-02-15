From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 Feb 2019 08:58:58 +0000
Subject: [PATCH 1/4] fbdev: atafb: Stop printing virtual screen_base
Message-Id: <20190215085901.21479-2-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190215085901.21479-1-geert@linux-m68k.org>
In-Reply-To: <20190215085901.21479-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Michael Schmitz <schmitzmic@gmail.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, dri-devel@lists.freedesktop.org

Printing (hashed) virtual addresses is useless.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/atafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index fcd2dd670a658fe3..e9d31a4299ee9901 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -3175,8 +3175,8 @@ int __init atafb_init(void)
 			kernel_set_cachemode(screen_base, screen_len,
 					     IOMAP_WRITETHROUGH);
 		}
-		printk("atafb: screen_base %p phys_screen_base %lx screen_len %d\n",
-			screen_base, phys_screen_base, screen_len);
+		printk("atafb: phys_screen_base %lx screen_len %d\n",
+		       phys_screen_base, screen_len);
 #ifdef ATAFB_EXT
 	} else {
 		/* Map the video memory (physical address given) to somewhere
-- 
2.17.1
