From: Jianjun Kong <jianjun@zeuux.org>
Subject: [PATCH] drivers: process failure of sysfs_create_group()
Date: Mon, 10 Nov 2008 18:53:32 +0800
Message-ID: <20081110105332.GA19358@ubuntu>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754923AbYKJKx1@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spock@gentoo.org
Cc: Linux-Kernel-Mailing-List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net


drivers: drivers/video/uvesafb.c:
When fail to call sysfs_create_group(), it should recycle resources and return the error.
This patch fix for processing failure of sysfs_create_group().

Signed-off-by: Jianjun Kong <jianjun@zeuux.org>
---
 drivers/video/uvesafb.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index 6c2d37f..a78d4d9 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -1811,12 +1811,16 @@ static int __devinit uvesafb_probe(struct platform_device *dev)
 			info->fix.id);
 
 	err = sysfs_create_group(&dev->dev.kobj, &uvesafb_dev_attgrp);
-	if (err != 0)
+	if (err != 0) {
 		printk(KERN_WARNING "fb%d: failed to register attributes\n",
 			info->node);
+		goto out_frame;
+	}
 
 	return 0;
 
+our_frame:
+	unregister_framebuffer(info);
 out_reg:
 	release_region(0x3c0, 32);
 out_unmap:
-- 
1.5.6.3
