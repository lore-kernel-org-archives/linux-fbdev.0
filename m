From: Timur Tabi <timur@freescale.com>
Date: Wed, 28 Sep 2011 21:19:47 +0000
Subject: [PATCH 1/9] drivers/video: fsl-diu-fb: fix some ioctls
Message-Id: <1317244795-24671-1-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the _IOx macros to define the ioctl commands, instead of hard-coded
numbers.  Unfortunately, the original definitions of MFB_SET_PIXFMT and
MFB_GET_PIXFMT used the wrong value for the size, so this will break
binary compatibility with older applications.

Also remove the FBIOGET_GWINFO and FBIOPUT_GWINFO ioctls.  FBIOPUT_GWINFO
was never implemented, and FBIOGET_GWINFO was never used by any
application.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |    8 --------
 include/linux/fsl-diu-fb.h |   20 ++++++++------------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 5137fbb..e5905b7 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1030,14 +1030,6 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 			ad->ckmin_b = ck.blue_min;
 		}
 		break;
-	case FBIOGET_GWINFO:
-		if (mfbi->type = MFB_TYPE_OFF)
-			return -ENODEV;
-		/* get graphic window information */
-		if (copy_to_user(buf, ad, sizeof(*ad)))
-			return -EFAULT;
-		break;
-
 	default:
 		dev_err(info->dev, "unknown ioctl command (0x%08X)\n", cmd);
 		return -ENOIOCTLCMD;
diff --git a/include/linux/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
index df23f59..5efb407 100644
--- a/include/linux/fsl-diu-fb.h
+++ b/include/linux/fsl-diu-fb.h
@@ -33,22 +33,18 @@ struct mfb_chroma_key {
 };
 
 struct aoi_display_offset {
-	int x_aoi_d;
-	int y_aoi_d;
+	__s32 x_aoi_d;
+	__s32 y_aoi_d;
 };
 
 #define MFB_SET_CHROMA_KEY	_IOW('M', 1, struct mfb_chroma_key)
 #define MFB_SET_BRIGHTNESS	_IOW('M', 3, __u8)
-
-#define MFB_SET_ALPHA		0x80014d00
-#define MFB_GET_ALPHA		0x40014d00
-#define MFB_SET_AOID		0x80084d04
-#define MFB_GET_AOID		0x40084d04
-#define MFB_SET_PIXFMT		0x80014d08
-#define MFB_GET_PIXFMT		0x40014d08
-
-#define FBIOGET_GWINFO		0x46E0
-#define FBIOPUT_GWINFO		0x46E1
+#define MFB_SET_ALPHA		_IOW('M', 0, __u8)
+#define MFB_GET_ALPHA		_IOR('M', 0, __u8)
+#define MFB_SET_AOID		_IOW('M', 4, struct aoi_display_offset)
+#define MFB_GET_AOID		_IOR('M', 4, struct aoi_display_offset)
+#define MFB_SET_PIXFMT		_IOW('M', 8, __u32)
+#define MFB_GET_PIXFMT		_IOR('M', 8, __u32)
 
 #ifdef __KERNEL__
 #include <linux/spinlock.h>
-- 
1.7.3.4


