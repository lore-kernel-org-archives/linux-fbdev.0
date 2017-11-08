From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Wed, 08 Nov 2017 17:10:59 +0000
Subject: [PATCH] video: fbdev: sis_main: mark expected switch fall-throughs
Message-Id: <20171108171059.GA7495@embeddedor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Winischhofer <thomas@winischhofer.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 115025
Addresses-Coverity-ID: 115026
Addresses-Coverity-ID: 115027
Addresses-Coverity-ID: 115028
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/video/fbdev/sis/sis_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index e923038..ecdd054 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -1702,6 +1702,7 @@ static int	sisfb_ioctl(struct fb_info *info, unsigned int cmd,
 		if(ivideo->warncount++ < 10)
 			printk(KERN_INFO
 				"sisfb: Deprecated ioctl call received - update your application!\n");
+		/* fall through */
 	   case SISFB_GET_INFO:  /* For communication with X driver */
 		ivideo->sisfb_infoblock.sisfb_id         = SISFB_ID;
 		ivideo->sisfb_infoblock.sisfb_version    = VER_MAJOR;
@@ -1755,6 +1756,7 @@ static int	sisfb_ioctl(struct fb_info *info, unsigned int cmd,
 		if(ivideo->warncount++ < 10)
 			printk(KERN_INFO
 				"sisfb: Deprecated ioctl call received - update your application!\n");
+		/* fall through */
 	   case SISFB_GET_VBRSTATUS:
 		if(sisfb_CheckVBRetrace(ivideo))
 			return put_user((u32)1, argp);
@@ -1765,6 +1767,7 @@ static int	sisfb_ioctl(struct fb_info *info, unsigned int cmd,
 		if(ivideo->warncount++ < 10)
 			printk(KERN_INFO
 				"sisfb: Deprecated ioctl call received - update your application!\n");
+		/* fall through */
 	   case SISFB_GET_AUTOMAXIMIZE:
 		if(ivideo->sisfb_max)
 			return put_user((u32)1, argp);
@@ -1775,6 +1778,7 @@ static int	sisfb_ioctl(struct fb_info *info, unsigned int cmd,
 		if(ivideo->warncount++ < 10)
 			printk(KERN_INFO
 				"sisfb: Deprecated ioctl call received - update your application!\n");
+		/* fall through */
 	   case SISFB_SET_AUTOMAXIMIZE:
 		if(get_user(gpu32, argp))
 			return -EFAULT;
-- 
2.7.4

