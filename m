From: Colin King <colin.king@canonical.com>
Date: Wed, 13 Sep 2017 15:03:09 +0000
Subject: [PATCH] drivers/video/fbdev/atyfb: make const arrays static, reduces object code size
Message-Id: <20170913150309.6250-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const arrays ragepro_tbl and ragexl_tbl on the stack,
instead make them static.  Makes the object code smaller by over 380 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  41089	  10592	    768	  52449	   cce1 atyfb_base.o

After:
   text	   data	    bss	    dec	    hex	filename
  40544	  10752	    768	  52064	   cb60	atyfb_base.o

(gcc version 7.2.0, x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/aty/atyfb_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 3ec72f19114b..a9a8272f7a6e 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -2272,10 +2272,10 @@ static void aty_bl_exit(struct backlight_device *bd)
 
 static void aty_calc_mem_refresh(struct atyfb_par *par, int xclk)
 {
-	const int ragepro_tbl[] = {
+	static const int ragepro_tbl[] = {
 		44, 50, 55, 66, 75, 80, 100
 	};
-	const int ragexl_tbl[] = {
+	static const int ragexl_tbl[] = {
 		50, 66, 75, 83, 90, 95, 100, 105,
 		110, 115, 120, 125, 133, 143, 166
 	};
-- 
2.14.1

