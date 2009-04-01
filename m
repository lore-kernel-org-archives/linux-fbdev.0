From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] efifb: Exit if framebuffer address is invalid
Date: Wed, 1 Apr 2009 19:57:58 +0100
Message-ID: <20090401185758.GA16163@srcf.ucam.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932609AbZDAS6Y@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, pjones@redhat.com

efifb will attempt to ioremap a framebuffer even if its starting address
is 0, failing and causing an ugly backtrace in the process. Exit before
probing if this is the case.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Acked-by: Peter Jones <pjones@redhat.com>
---
 drivers/video/efifb.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index 0c5b9a9..8dea2bc 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -210,12 +210,15 @@ static int __init efifb_probe(struct platform_device *dev)
 	unsigned int size_total;
 	int request_succeeded = 0;
 
-	printk(KERN_INFO "efifb: probing for efifb\n");
-
 	if (!screen_info.lfb_depth)
 		screen_info.lfb_depth = 32;
 	if (!screen_info.pages)
 		screen_info.pages = 1;
+	if (!screen_info.lfb_base) {
+		printk(KERN_DEBUG "efifb: invalid framebuffer address\n");
+		return -ENODEV;
+	}
+	printk(KERN_INFO "efifb: probing for efifb\n");
 
 	/* just assume they're all unset if any are */
 	if (!screen_info.blue_size) {

-- 
Matthew Garrett | mjg59@srcf.ucam.org
