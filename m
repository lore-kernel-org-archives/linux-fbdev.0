From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 02/11] pvr2fb: Fix oops when
	pseudo_palette is written
Date: Wed, 01 Aug 2007 15:34:48 +0800
Message-ID: <46B03798.20506@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IG9NO-0003Ee-12 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 01:16:14 -0700
Received: from rv-out-0910.google.com ([209.85.198.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IG9NN-0000Mg-Ng
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 01:16:13 -0700
Received: by rv-out-0910.google.com with SMTP id g11so308468rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 01 Aug 2007 01:16:13 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Reported by: Adrian McMenamin <adrianmcmenamin@gmail.com>

This driver will oops when the pseudo_palette[] is written as u32 but not
when written as u16.  When written as u32, it corrupts the adjacent
'mmio_base' field of struct pvr2fb_par.  Fix by using  framebuffer_alloc()/release() to allocate struct fb_info and struct pvr2fb_par, and create the pseudo_palette[] as part of struct pvr2fb_par.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pvr2fb.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
index f930026..a72921b 100644
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -143,6 +143,7 @@ static struct pvr2fb_par {
 	unsigned char is_lowres;	/* Is horizontal pixel-doubling enabled? */
 
 	unsigned long mmio_base;	/* MMIO base */
+	u32 palette[16];
 } *currentpar;
 
 static struct fb_info *fb_info;
@@ -790,7 +791,7 @@ static int __devinit pvr2fb_common_init(
 	fb_info->fbops		= &pvr2fb_ops;
 	fb_info->fix		= pvr2_fix;
 	fb_info->par		= currentpar;
-	fb_info->pseudo_palette	= (void *)(fb_info->par + 1);
+	fb_info->pseudo_palette	= currentpar->palette;
 	fb_info->flags		= FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 
 	if (video_output == VO_VGA)
@@ -1082,14 +1083,15 @@ #ifndef MODULE
 #endif
 	size = sizeof(struct fb_info) + sizeof(struct pvr2fb_par) + 16 * sizeof(u32);
 
-	fb_info = kzalloc(size, GFP_KERNEL);
+	fb_info = framebuffer_alloc(sizeof(struct pvr2fb_par), NULL);
+
 	if (!fb_info) {
 		printk(KERN_ERR "Failed to allocate memory for fb_info\n");
 		return -ENOMEM;
 	}
 
 
-	currentpar = (struct pvr2fb_par *)(fb_info + 1);
+	currentpar = fb_info->par;
 
 	for (i = 0; i < ARRAY_SIZE(board_driver); i++) {
 		struct pvr2_board *pvr_board = board_driver + i;
@@ -1102,7 +1104,7 @@ #endif
 		if (ret != 0) {
 			printk(KERN_ERR "pvr2fb: Failed init of %s device\n",
 				pvr_board->name);
-			kfree(fb_info);
+			framebuffer_release(fb_info);
 			break;
 		}
 	}
@@ -1126,7 +1128,7 @@ #ifdef CONFIG_SH_STORE_QUEUES
 #endif
 
 	unregister_framebuffer(fb_info);
-	kfree(fb_info);
+	framebuffer_release(fb_info);
 }
 
 module_init(pvr2fb_init);


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
