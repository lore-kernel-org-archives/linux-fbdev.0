From: Axel Lin <axel.lin@gmail.com>
Date: Fri, 14 Jan 2011 09:39:11 +0000
Subject: [PATCH] video: pxa3xx-gcu: Return -EFAULT when copy_from_user()
Message-Id: <1294997951.12295.1.camel@mola>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@caiaq.de>, Janine Kropp <nin@directfb.org>, Denis Oliver Kropp <dok@directfb.org>, Eric Miao <eric.y.miao@gmail.com>, linux-fbdev@vger.kernel.org

Return -EFAULT instead of number of bytes that could not be copied if
copy_from_user() fails.

Also fix a typo in the comments.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/pxa3xx-gcu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/pxa3xx-gcu.c b/drivers/video/pxa3xx-gcu.c
index b81168d..cf4beb9 100644
--- a/drivers/video/pxa3xx-gcu.c
+++ b/drivers/video/pxa3xx-gcu.c
@@ -1,5 +1,5 @@
 /*
- *  pxa3xx-gc.c - Linux kernel module for PXA3xx graphics controllers
+ *  pxa3xx-gcu.c - Linux kernel module for PXA3xx graphics controllers
  *
  *  This driver needs a DirectFB counterpart in user space, communication
  *  is handled via mmap()ed memory areas and an ioctl.
@@ -421,7 +421,7 @@ pxa3xx_gcu_misc_write(struct file *filp, const char *buff,
 		buffer->next = priv->free;
 		priv->free = buffer;
 		spin_unlock_irqrestore(&priv->spinlock, flags);
-		return ret;
+		return -EFAULT;
 	}
 
 	buffer->length = words;
-- 
1.7.2



