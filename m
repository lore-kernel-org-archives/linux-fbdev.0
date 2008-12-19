From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/05] video: fix deferred io fsync()
Date: Fri, 19 Dec 2008 15:34:09 +0900
Message-ID: <20081219063409.2703.3880.sendpatchset@rx1.opensource.se>
References: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, adaplas@gmail.com, linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

If CONFIG_FB_DEFERRED_IO is set, but there are framebuffers 
registered that does not make use of deferred io, then fsync()
on those framebuffers will result in a crash. Fix that.

This is needed for sh_mobile_lcdcfb since we always enable
deferred io at compile time but we may disable deferred io
for some types of hardware configurations.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/fb_defio.c |    4 ++++
 1 file changed, 4 insertions(+)

--- 0001/drivers/video/fb_defio.c
+++ work/drivers/video/fb_defio.c	2008-12-17 15:27:44.000000000 +0900
@@ -60,6 +60,10 @@ int fb_deferred_io_fsync(struct file *fi
 {
 	struct fb_info *info = file->private_data;
 
+	/* Skip if deferred io is complied-in but disabled on this fbdev */
+	if (!info->fbdefio)
+		return 0;
+
 	/* Kill off the delayed work */
 	cancel_rearming_delayed_work(&info->deferred_work);
 
