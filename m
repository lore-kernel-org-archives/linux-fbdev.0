From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Detect switching to X?
Date: Mon, 28 Nov 2005 16:50:33 +0800
Message-ID: <438AC4D9.9040603@gmail.com>
References: <43894E39.9080902@t-online.de> <438A3568.50100@gmail.com> <438A9BA8.3070600@t-online.de> <438AB24C.60405@gmail.com> <438ABBF3.20104@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgejG-0001Ma-9z
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Nov 2005 00:51:18 -0800
Received: from xproxy.gmail.com ([66.249.82.199])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EgejF-0006I0-6x
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Nov 2005 00:51:18 -0800
Received: by xproxy.gmail.com with SMTP id s6so923558wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 28 Nov 2005 00:51:16 -0800 (PST)
In-Reply-To: <438ABBF3.20104@t-online.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Hi Tony,
> 
> Today framebuffer drivers are limited by the fact that they need to
> leave the graphics
> engine in a state that current and older (but still used) X drivers can
> handle. That
> unreasonable limitation should be removed, and it can be removed by
> those optional
> fb_save_state() and fb_restore_state() hooks.
> 

Try this patch.

fb_save_state() will be called when going from KD_GRAPHICS to KD_TEXT. The
driver has the opportunity here to save the current state of the hardware
before it's touched by fbdev.

fb_restore_state() will be called when going from KD_TEXT to KD_GRAPHICS
mode.  The driver has the opportunity to set the hardware back to something
recognizable by the graphics application.

The state saving and restoration methods are up to driver author. It can
range from a simple hack, a single register save and restore to a full
blown total hardware state save and restore.

Tony 

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 1a8f0ea..9678045 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -2181,11 +2181,14 @@ static int fbcon_blank(struct vc_data *v
 		ops->graphics = 1;
 
 		if (!blank) {
+			if (info->fbops->fb_save_state)
+				info->fbops->fb_save_state(info);
 			var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE;
 			fb_set_var(info, &var);
 			ops->graphics = 0;
 			ops->var = info->var;
-		}
+		} else if (info->fbops->fb_restore_state)
+			info->fbops->fb_restore_state(info);
 	}
 
  	if (!fbcon_is_inactive(vc, info)) {
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 58e6c21..7d6d970 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -617,6 +617,12 @@ struct fb_ops {
 
 	/* perform fb specific mmap */
 	int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
+
+	/* save current hardware state */
+	void (*fb_save_state)(struct fb_info *info);
+
+	/* restore saved state */
+	void (*fb_restore_state)(struct fb_info *info);
 };
 
 #ifdef CONFIG_FB_TILEBLITTING


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
