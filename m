From: Jesper Juhl <juhl-lkml@dif.dk>
Subject: [PATCH][resend] drivers/video/kyro/fbdev.c ignoring return value of
 copy_*_user
Date: Fri, 4 Mar 2005 15:26:33 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0503041514110.2794@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@chaoticdreams.org>
Cc: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>


Hi, 

2.6.11 still contain these warnings :

drivers/video/kyro/fbdev.c:597: warning: ignoring return value of `copy_from_user', declared with attribute warn_unused_result
drivers/video/kyro/fbdev.c:607: warning: ignoring return value of `copy_from_user', declared with attribute warn_unused_result
drivers/video/kyro/fbdev.c:628: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result
drivers/video/kyro/fbdev.c:631: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result
drivers/video/kyro/fbdev.c:634: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result

Here's a patch that has been send before but obviously didn't make it in. 
re-diff'ed against 2.6.11


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-orig/drivers/video/kyro/fbdev.c	2005-03-02 08:37:31.000000000 +0100
+++ linux-2.6.11/drivers/video/kyro/fbdev.c	2005-03-04 15:12:54.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/video/kyro/kyrofb.c
+ *  linux/drivers/video/kyro/fbdev.c
  *
  *  Copyright (C) 2002 STMicroelectronics
  *  Copyright (C) 2003, 2004 Paul Mundt
@@ -594,7 +594,8 @@ static int kyrofb_ioctl(struct inode *in
 
 	switch (cmd) {
 	case KYRO_IOCTL_OVERLAY_CREATE:
-		copy_from_user(&ol_create, argp, sizeof(overlay_create));
+		if (copy_from_user(&ol_create, argp, sizeof(overlay_create)))
+			return -EFAULT;
 
 		if (kyro_dev_overlay_create(ol_create.ulWidth,
 					    ol_create.ulHeight, 0) < 0) {
@@ -604,8 +605,9 @@ static int kyrofb_ioctl(struct inode *in
 		}
 		break;
 	case KYRO_IOCTL_OVERLAY_VIEWPORT_SET:
-		copy_from_user(&ol_viewport_set, argp,
-			       sizeof(overlay_viewport_set));
+		if (copy_from_user(&ol_viewport_set, argp,
+			       sizeof(overlay_viewport_set)))
+			return -EFAULT;
 
 		if (kyro_dev_overlay_viewport_set(ol_viewport_set.xOrgin,
 						  ol_viewport_set.yOrgin,
@@ -625,13 +627,16 @@ static int kyrofb_ioctl(struct inode *in
 		}
 		break;
 	case KYRO_IOCTL_UVSTRIDE:
-		copy_to_user(argp, &deviceInfo.ulOverlayUVStride, sizeof(unsigned long));
+		if (copy_to_user(argp, &deviceInfo.ulOverlayUVStride, sizeof(unsigned long)))
+			return -EFAULT;
 		break;
 	case KYRO_IOCTL_STRIDE:
-		copy_to_user(argp, &deviceInfo.ulOverlayStride, sizeof(unsigned long));
+		if (copy_to_user(argp, &deviceInfo.ulOverlayStride, sizeof(unsigned long)))
+			return -EFAULT;
 		break;
 	case KYRO_IOCTL_OVERLAY_OFFSET:
-		copy_to_user(argp, &deviceInfo.ulOverlayOffset, sizeof(unsigned long));
+		if (copy_to_user(argp, &deviceInfo.ulOverlayOffset, sizeof(unsigned long)))
+			return -EFAULT;
 		break;
 	}
 
