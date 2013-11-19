From: Sasha Levin <sasha.levin@oracle.com>
Date: Tue, 19 Nov 2013 19:25:36 +0000
Subject: [PATCH] video: kyro: fix incorrect sizes when copying to userspace
Message-Id: <1384889136-15516-1-git-send-email-sasha.levin@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sasha Levin <sasha.levin@oracle.com>

kyro would copy u32s and specify sizeof(unsigned long) as the size to copy.

This would copy more data than intended and cause memory corruption and might
leak kernel memory.

Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 drivers/video/kyro/fbdev.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
index 50c8574..65041e1 100644
--- a/drivers/video/kyro/fbdev.c
+++ b/drivers/video/kyro/fbdev.c
@@ -624,15 +624,15 @@ static int kyrofb_ioctl(struct fb_info *info,
 			return -EINVAL;
 		}
 	case KYRO_IOCTL_UVSTRIDE:
-		if (copy_to_user(argp, &deviceInfo.ulOverlayUVStride, sizeof(unsigned long)))
+		if (copy_to_user(argp, &deviceInfo.ulOverlayUVStride, sizeof(deviceInfo.ulOverlayUVStride)))
 			return -EFAULT;
 		break;
 	case KYRO_IOCTL_STRIDE:
-		if (copy_to_user(argp, &deviceInfo.ulOverlayStride, sizeof(unsigned long)))
+		if (copy_to_user(argp, &deviceInfo.ulOverlayStride, sizeof(deviceInfo.ulOverlayStride)))
 			return -EFAULT;
 		break;
 	case KYRO_IOCTL_OVERLAY_OFFSET:
-		if (copy_to_user(argp, &deviceInfo.ulOverlayOffset, sizeof(unsigned long)))
+		if (copy_to_user(argp, &deviceInfo.ulOverlayOffset, sizeof(deviceInfo.ulOverlayOffset)))
 			return -EFAULT;
 		break;
 	}
-- 
1.7.10.4

