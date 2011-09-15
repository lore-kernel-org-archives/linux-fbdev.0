From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Sep 2011 21:44:48 +0000
Subject: [PATCH 03/13] drivers/video: fsl-diu-fb: remove unused ioctls
Message-Id: <1316123098-30967-4-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Remove some unused ioctl commands, and treat those commands as unsupported
instead of ignored.

Also remove struct mfb_alpha, which isn't used by any ioctl.  It may have
been once intended for MFB_SET_ALPHA, but that ioctl uses a different
data structure.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   12 ------------
 include/linux/fsl-diu-fb.h |    5 -----
 2 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 10ee411..226f4bc 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -902,9 +902,6 @@ static int fsl_diu_setcolreg(unsigned int regno, unsigned int red,
 			ret = 0;
 		}
 		break;
-	case FB_VISUAL_STATIC_PSEUDOCOLOR:
-	case FB_VISUAL_PSEUDOCOLOR:
-		break;
 	}
 
 	return ret;
@@ -1056,15 +1053,6 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 		if (copy_to_user(buf, ad, sizeof(*ad)))
 			return -EFAULT;
 		break;
-	case FBIOGET_HWCINFO:
-		pr_debug("FBIOGET_HWCINFO:0x%08x\n", FBIOGET_HWCINFO);
-		break;
-	case FBIOPUT_MODEINFO:
-		pr_debug("FBIOPUT_MODEINFO:0x%08x\n", FBIOPUT_MODEINFO);
-		break;
-	case FBIOGET_DISPINFO:
-		pr_debug("FBIOGET_DISPINFO:0x%08x\n", FBIOGET_DISPINFO);
-		break;
 
 	default:
 		dev_err(info->dev, "unknown ioctl command (0x%08X)\n", cmd);
diff --git a/include/linux/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
index daa9952..5ebffa6 100644
--- a/include/linux/fsl-diu-fb.h
+++ b/include/linux/fsl-diu-fb.h
@@ -27,11 +27,6 @@
 
 #include <linux/types.h>
 
-struct mfb_alpha {
-	int enable;
-	int alpha;
-};
-
 struct mfb_chroma_key {
 	int enable;
 	__u8  red_max;
-- 
1.7.3.4


