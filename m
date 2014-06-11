From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 11 Jun 2014 06:45:35 +0000
Subject: [patch] video/mbx: indent some if statements
Message-Id: <20140611064535.GA16443@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Checkpatch.pl worries that we have left off the conditional bit because
it isn't indented correctly.

WARNING: suspect code indent for conditional statements (24, 24)

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/mbx/mbxfb.c b/drivers/video/fbdev/mbx/mbxfb.c
index 2bd52ed..698df954 100644
--- a/drivers/video/fbdev/mbx/mbxfb.c
+++ b/drivers/video/fbdev/mbx/mbxfb.c
@@ -628,14 +628,14 @@ static int mbxfb_ioctl(struct fb_info *info, unsigned int cmd,
 		case MBXFB_IOCS_PLANEORDER:
 			if (copy_from_user(&porder, (void __user*)arg,
 					sizeof(struct mbxfb_planeorder)))
-			return -EFAULT;
+				return -EFAULT;
 
 			return mbxfb_ioctl_planeorder(&porder);
 
 		case MBXFB_IOCS_ALPHA:
 			if (copy_from_user(&alpha, (void __user*)arg,
 					sizeof(struct mbxfb_alphaCtl)))
-			return -EFAULT;
+				return -EFAULT;
 
 			return mbxfb_ioctl_alphactl(&alpha);
 
