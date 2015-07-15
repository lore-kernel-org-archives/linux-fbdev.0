From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 15 Jul 2015 08:41:46 +0000
Subject: [PATCH v2 2/2] staging: sm7xxfb: usr fb_read and fb_write
Message-Id: <1436948986-29664-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436948986-29664-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1436948986-29664-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Now since the Big-Endian and Little-Endian based calculations are moved
into a macro we can make fb_read() and fb_write() common for both
Little-Endian and Big-Endian.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 106465c..07c2199 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -946,7 +946,6 @@ static int smtc_setcolreg(unsigned regno, unsigned red, unsigned green,
 	return 0;
 }
 
-#ifdef __BIG_ENDIAN
 static ssize_t smtcfb_read(struct fb_info *info, char __user *buf,
 			   size_t count, loff_t *ppos)
 {
@@ -1107,7 +1106,6 @@ static ssize_t smtcfb_write(struct fb_info *info, const char __user *buf,
 
 	return (cnt) ? cnt : err;
 }
-#endif	/* ! __BIG_ENDIAN */
 
 static void sm7xx_set_timing(struct smtcfb_info *sfb)
 {
@@ -1303,10 +1301,8 @@ static struct fb_ops smtcfb_ops = {
 	.fb_fillrect  = cfb_fillrect,
 	.fb_imageblit = cfb_imageblit,
 	.fb_copyarea  = cfb_copyarea,
-#ifdef __BIG_ENDIAN
 	.fb_read      = smtcfb_read,
 	.fb_write     = smtcfb_write,
-#endif
 };
 
 /*
-- 
1.8.1.2

