From: Johannes Thumshirn <jthumshirn@suse.de>
Date: Sat, 10 Jun 2017 09:05:31 +0000
Subject: [PATCH 2/7] video: fbdev: don't use KERNEL_VERSION macro for MEDIA_REVISION
Message-Id: <20170610090536.12472-3-jthumshirn@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170610090536.12472-1-jthumshirn@suse.de>
In-Reply-To: <20170610090536.12472-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>

Don't use the KERNEL_VERSION() macro for the v4l2 capabilities, use
MEDIA_REVISION instead.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/video/fbdev/matrox/matroxfb_base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index 11eb094396ae..eb92a325033c 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -113,6 +113,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/media.h>
 
 #ifdef CONFIG_PPC_PMAC
 #include <asm/machdep.h>
@@ -1091,7 +1092,7 @@ static int matroxfb_ioctl(struct fb_info *info,
 				strcpy(r.driver, "matroxfb");
 				strcpy(r.card, "Matrox");
 				sprintf(r.bus_info, "PCI:%s", pci_name(minfo->pcidev));
-				r.version = KERNEL_VERSION(1,0,0);
+				r.version = MEDIA_REVISION(1, 0, 0);
 				r.capabilities = V4L2_CAP_VIDEO_OUTPUT;
 				if (copy_to_user(argp, &r, sizeof(r)))
 					return -EFAULT;
-- 
2.12.3

