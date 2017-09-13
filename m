From: Colin King <colin.king@canonical.com>
Date: Wed, 13 Sep 2017 15:41:37 +0000
Subject: [PATCH] video: fbdev: sis: make const array specialtv static, reduces object code size
Message-Id: <20170913154137.6886-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Winischhofer <thomas@winischhofer.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const array specialtv on the stack, instead make it
static.  Makes the object code smaller by over 1100 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
 179899	   7504	      0	 187403	  2dc0b	drivers/video/fbdev/sis/init301.o

After:
   text	   data	    bss	    dec	    hex	filename
 178720	   7568	      0	 186288	  2d7b0	drivers/video/fbdev/sis/init301.o

(gcc version 7.2.0, x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/sis/init301.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sis/init301.c b/drivers/video/fbdev/sis/init301.c
index 1ec9c3e0e1d8..02ee752d5000 100644
--- a/drivers/video/fbdev/sis/init301.c
+++ b/drivers/video/fbdev/sis/init301.c
@@ -6486,7 +6486,7 @@ SiS_SetTVSpecial(struct SiS_Private *SiS_Pr, unsigned short ModeNo)
 
   if(!(SiS_Pr->SiS_TVMode & TVSetPAL)) {
      if(SiS_Pr->SiS_TVMode & TVSetNTSC1024) {
-        const unsigned char specialtv[] = {
+        static const unsigned char specialtv[] = {
 		0xa7,0x07,0xf2,0x6e,0x17,0x8b,0x73,0x53,
 		0x13,0x40,0x34,0xf4,0x63,0xbb,0xcc,0x7a,
 		0x58,0xe4,0x73,0xda,0x13
-- 
2.14.1

