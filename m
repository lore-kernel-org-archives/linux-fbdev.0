From: Colin King <colin.king@canonical.com>
Date: Fri, 06 Sep 2019 18:11:14 +0000
Subject: [PATCH] fbdev: matrox: make array wtst_xlat static const, makes object smaller
Message-Id: <20190906181114.31414-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array wtst_xlat on the stack but instead make it
static const. Makes the object code smaller by 89 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  14347	    840	      0	  15187	   3b53	fbdev/matrox/matroxfb_misc.o

After:
   text	   data	    bss	    dec	    hex	filename
  14162	    936	      0	  15098	   3afa	fbdev/matrox/matroxfb_misc.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/matrox/matroxfb_misc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_misc.c b/drivers/video/fbdev/matrox/matroxfb_misc.c
index c7aaca12805e..feb0977c82eb 100644
--- a/drivers/video/fbdev/matrox/matroxfb_misc.c
+++ b/drivers/video/fbdev/matrox/matroxfb_misc.c
@@ -673,7 +673,10 @@ static int parse_pins5(struct matrox_fb_info *minfo,
 	if (bd->pins[115] & 4) {
 		minfo->values.reg.mctlwtst_core = minfo->values.reg.mctlwtst;
 	} else {
-		u_int32_t wtst_xlat[] = { 0, 1, 5, 6, 7, 5, 2, 3 };
+		static const u_int32_t wtst_xlat[] = {
+			0, 1, 5, 6, 7, 5, 2, 3
+		};
+
 		minfo->values.reg.mctlwtst_core = (minfo->values.reg.mctlwtst & ~7) |
 						  wtst_xlat[minfo->values.reg.mctlwtst & 7];
 	}
-- 
2.20.1
