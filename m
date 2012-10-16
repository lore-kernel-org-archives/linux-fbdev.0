From: Timur Tabi <timur@freescale.com>
Date: Tue, 16 Oct 2012 22:33:44 +0000
Subject: [PATCH 3/9] drivers/video: fsl-diu-fb: add support for set_gamma ioctls
Message-Id: <1350426830-12140-3-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The MPC5121 BSP comes with a gamma_set utility that initializes the gamma
table via an ioctl.  Unfortunately, the ioctl number that utility uses
is defined improperly, but we can still support it.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   17 +++++++++++++++++
 include/linux/fsl-diu-fb.h |    9 +++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 5b12e17..9c40547 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1181,6 +1181,23 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 			ad->ckmin_b = ck.blue_min;
 		}
 		break;
+#ifdef CONFIG_PPC_MPC512x
+	case MFB_SET_GAMMA: {
+		struct fsl_diu_data *data = mfbi->parent;
+
+		if (copy_from_user(data->gamma, buf, sizeof(data->gamma)))
+			return -EFAULT;
+		setbits32(&data->diu_reg->gamma, 0); /* Force table reload */
+		break;
+	}
+	case MFB_GET_GAMMA: {
+		struct fsl_diu_data *data = mfbi->parent;
+
+		if (copy_to_user(buf, data->gamma, sizeof(data->gamma)))
+			return -EFAULT;
+		break;
+	}
+#endif
 	default:
 		dev_err(info->dev, "unknown ioctl command (0x%08X)\n", cmd);
 		return -ENOIOCTLCMD;
diff --git a/include/linux/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
index 11c16a1..a1e8277 100644
--- a/include/linux/fsl-diu-fb.h
+++ b/include/linux/fsl-diu-fb.h
@@ -47,6 +47,15 @@ struct aoi_display_offset {
 #define MFB_GET_PIXFMT		_IOR('M', 8, __u32)
 
 /*
+ * The MPC5121 BSP comes with a gamma_set utility that initializes the
+ * gamma table.  Unfortunately, it uses bad values for the IOCTL commands,
+ * but there's nothing we can do about it now.  These ioctls are only
+ * supported on the MPC5121.
+ */
+#define MFB_SET_GAMMA		_IOW('M', 1, __u8)
+#define MFB_GET_GAMMA		_IOR('M', 1, __u8)
+
+/*
  * The original definitions of MFB_SET_PIXFMT and MFB_GET_PIXFMT used the
  * wrong value for 'size' field of the ioctl.  The current macros above use the
  * right size, but we still need to provide backwards compatibility, at least
-- 
1.7.3.4


