From: Timur Tabi <timur@freescale.com>
Date: Wed, 05 Oct 2011 00:36:44 +0000
Subject: [PATCH 1/9] [v2] drivers/video: fsl-diu-fb: fix some ioctls
Message-Id: <1317775012-9797-1-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the _IOx macros to define the ioctl commands, instead of hard-coded
numbers.  Unfortunately, the original definitions of MFB_SET_PIXFMT and
MFB_GET_PIXFMT used the wrong value for the size, so these macros have
new values now.  To avoid breaking binary compatibility with older
applications, we retain support for the original values, but the driver
displays a warning message if they're used.

Also remove the FBIOGET_GWINFO and FBIOPUT_GWINFO ioctls.  FBIOPUT_GWINFO
was never implemented, and FBIOGET_GWINFO was never used by any
application.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   16 ++++++++--------
 include/linux/fsl-diu-fb.h |   27 ++++++++++++++++-----------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 5137fbb..9a1f6d2 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -966,11 +966,19 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 	if (!arg)
 		return -EINVAL;
 	switch (cmd) {
+	case MFB_SET_PIXFMT_OLD:
+		dev_warn(info->dev,
+			 "MFB_SET_PIXFMT value of 0x%08x is deprecated.\n",
+			 MFB_SET_PIXFMT_OLD);
 	case MFB_SET_PIXFMT:
 		if (copy_from_user(&pix_fmt, buf, sizeof(pix_fmt)))
 			return -EFAULT;
 		ad->pix_fmt = pix_fmt;
 		break;
+	case MFB_GET_PIXFMT_OLD:
+		dev_warn(info->dev,
+			 "MFB_GET_PIXFMT value of 0x%08x is deprecated.\n",
+			 MFB_GET_PIXFMT_OLD);
 	case MFB_GET_PIXFMT:
 		pix_fmt = ad->pix_fmt;
 		if (copy_to_user(buf, &pix_fmt, sizeof(pix_fmt)))
@@ -1030,14 +1038,6 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
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
index df23f59..e19c531 100644
--- a/include/linux/fsl-diu-fb.h
+++ b/include/linux/fsl-diu-fb.h
@@ -33,22 +33,27 @@ struct mfb_chroma_key {
 };
 
 struct aoi_display_offset {
-	int x_aoi_d;
-	int y_aoi_d;
+	__s32 x_aoi_d;
+	__s32 y_aoi_d;
 };
 
 #define MFB_SET_CHROMA_KEY	_IOW('M', 1, struct mfb_chroma_key)
 #define MFB_SET_BRIGHTNESS	_IOW('M', 3, __u8)
+#define MFB_SET_ALPHA		_IOW('M', 0, __u8)
+#define MFB_GET_ALPHA		_IOR('M', 0, __u8)
+#define MFB_SET_AOID		_IOW('M', 4, struct aoi_display_offset)
+#define MFB_GET_AOID		_IOR('M', 4, struct aoi_display_offset)
+#define MFB_SET_PIXFMT		_IOW('M', 8, __u32)
+#define MFB_GET_PIXFMT		_IOR('M', 8, __u32)
 
-#define MFB_SET_ALPHA		0x80014d00
-#define MFB_GET_ALPHA		0x40014d00
-#define MFB_SET_AOID		0x80084d04
-#define MFB_GET_AOID		0x40084d04
-#define MFB_SET_PIXFMT		0x80014d08
-#define MFB_GET_PIXFMT		0x40014d08
-
-#define FBIOGET_GWINFO		0x46E0
-#define FBIOPUT_GWINFO		0x46E1
+/*
+ * The original definitions of MFB_SET_PIXFMT and MFB_GET_PIXFMT used the
+ * wrong value for 'size' field of the ioctl.  The current macros above use the
+ * right size, but we still need to provide backwards compatibility, at least
+ * for a while.
+*/
+#define MFB_SET_PIXFMT_OLD	0x80014d08
+#define MFB_GET_PIXFMT_OLD	0x40014d08
 
 #ifdef __KERNEL__
 #include <linux/spinlock.h>
-- 
1.7.4.4


