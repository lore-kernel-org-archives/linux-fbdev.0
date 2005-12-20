From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/9] fbcon: Code cleanups
Date: Tue, 20 Dec 2005 20:50:47 +0800
Message-ID: <43A7FE27.3020009@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoyFM-0002Ct-LA
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:18:48 -0800
Received: from zproxy.gmail.com ([64.233.162.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EoyFL-0005Kv-2z
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:18:48 -0800
Received: by zproxy.gmail.com with SMTP id z3so76970nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 Dec 2005 23:18:46 -0800 (PST)
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

- replace kmalloc with kzalloc
- remove repeated define (FONTCHHCNT)
- remove unneeded local variable (redraw) in ypan_{up|down}_redraw
- add and delete cursor timer in fbcon_switch() if old_info != info
    
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c        |   27 +++++++++++----------------
 drivers/video/console/fbcon_rotate.h |    2 --
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 9740a66..2edd58f 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -687,13 +687,12 @@ static int con2fb_acquire_newinfo(struct
 		err = -ENODEV;
 
 	if (!err) {
-		ops = kmalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
+		ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
 		if (!ops)
 			err = -ENOMEM;
 	}
 
 	if (!err) {
-		memset(ops, 0, sizeof(struct fbcon_ops));
 		info->fbcon_par = ops;
 		set_blitting_type(vc, info);
 	}
@@ -919,13 +918,12 @@ static const char *fbcon_startup(void)
 		return NULL;
 	}
 
-	ops = kmalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
+	ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
 	if (!ops) {
 		module_put(owner);
 		return NULL;
 	}
 
-	memset(ops, 0, sizeof(struct fbcon_ops));
 	ops->currcon = -1;
 	ops->graphics = 1;
 	ops->cur_rotate = -1;
@@ -1408,16 +1406,13 @@ static __inline__ void ypan_up_redraw(st
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct display *p = &fb_display[vc->vc_num];
-	int redraw = 0;
 
 	p->yscroll += count;
+
 	if (p->yscroll > p->vrows - vc->vc_rows) {
 		p->yscroll -= p->vrows - vc->vc_rows;
-		redraw = 1;
-	}
-
-	if (redraw)
 		fbcon_redraw_move(vc, p, t + count, vc->vc_rows - count, t);
+	}
 
 	ops->var.xoffset = 0;
 	ops->var.yoffset = p->yscroll * vc->vc_font.height;
@@ -1459,16 +1454,13 @@ static __inline__ void ypan_down_redraw(
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct display *p = &fb_display[vc->vc_num];
-	int redraw = 0;
 
 	p->yscroll -= count;
+
 	if (p->yscroll < 0) {
 		p->yscroll += p->vrows - vc->vc_rows;
-		redraw = 1;
-	}
-
-	if (redraw)
 		fbcon_redraw_move(vc, p, t, vc->vc_rows - count, t + count);
+	}
 
 	ops->var.xoffset = 0;
 	ops->var.yoffset = p->yscroll * vc->vc_font.height;
@@ -2105,8 +2097,11 @@ static int fbcon_switch(struct vc_data *
 				 info->flags & FBINFO_MISC_ALWAYS_SETPAR)) {
 		if (info->fbops->fb_set_par)
 			info->fbops->fb_set_par(info);
-		fbcon_del_cursor_timer(old_info);
-		fbcon_add_cursor_timer(info);
+
+		if (old_info != info) {
+			fbcon_del_cursor_timer(old_info);
+			fbcon_add_cursor_timer(info);
+		}
 	}
 
 	set_blitting_type(vc, info);
diff --git a/drivers/video/console/fbcon_rotate.h b/drivers/video/console/fbcon_rotate.h
index 1b8f92f..75be5ce 100644
--- a/drivers/video/console/fbcon_rotate.h
+++ b/drivers/video/console/fbcon_rotate.h
@@ -11,8 +11,6 @@
 #ifndef _FBCON_ROTATE_H
 #define _FBCON_ROTATE_H
 
-#define FNTCHARCNT(fd)	(((int *)(fd))[-3])
-
 #define GETVYRES(s,i) ({                           \
         (s == SCROLL_REDRAW || s == SCROLL_MOVE) ? \
         (i)->var.yres : (i)->var.yres_virtual; })




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
