From: Finn Thain <fthain@telegraphics.com.au>
Date: Sun, 17 Feb 2019 23:25:27 +0000
Subject: [PATCH] video/macfb: Call fb_invert_cmaps()
Message-Id: <80cf1394f099ced17bd5075be88cf33c1232086a.1550445927.git.fthain@telegraphics.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The 'inverse' parameter has no effect otherwise. Remove set-but-unused
variable.

Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/video/fbdev/macfb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/macfb.c b/drivers/video/fbdev/macfb.c
index 00671055a611..37c56c45ee39 100644
--- a/drivers/video/fbdev/macfb.c
+++ b/drivers/video/fbdev/macfb.c
@@ -136,7 +136,6 @@ static struct fb_fix_screeninfo macfb_fix = {
 static void *slot_addr;
 static struct fb_info fb_info;
 static u32 pseudo_palette[16];
-static int inverse;
 static int vidtest;
 
 /*
@@ -520,7 +519,7 @@ static void __init macfb_setup(char *options)
 			continue;
 
 		if (!strcmp(this_opt, "inverse"))
-			inverse = 1;
+			fb_invert_cmaps();
 		else
 			if (!strcmp(this_opt, "vidtest"))
 				vidtest = 1; /* enable experimental CLUT code */
-- 
2.19.2
