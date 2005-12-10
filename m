From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 01/18] fbcon: Add ability to save/restore graphics state
Date: Sat, 10 Dec 2005 14:09:26 +0800
Message-ID: <439A7116.6070807@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eky3c-0002nm-2M
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:18:08 -0800
Received: from zproxy.gmail.com ([64.233.162.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eky3b-0003od-Pl
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:18:08 -0800
Received: by zproxy.gmail.com with SMTP id z3so1046282nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 22:18:06 -0800 (PST)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Add hooks to save and restore the graphics state.  These hooks are called
in fbcon_blank() when entering/leaving KD_GRAPHICS mode.  This is needed
by savagefb at least so it can cooperate with savage_dri and by cyblafb.

State save/restoration can be full or partial.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |    5 ++++-
 include/linux/fb.h            |    6 ++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

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
