From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.28 2/2] broadsheetfb: add damage
	handling
Date: Thu, 15 Jan 2009 08:06:02 +0800
Message-ID: <12319779672729-git-send-email-jayakumar.lkml@gmail.com>
References: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LNFkY-00072K-7E
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Jan 2009 00:06:18 +0000
Received: from ti-out-0910.google.com ([209.85.142.190])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LNFkT-0007Ej-Q3 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Jan 2009 00:06:18 +0000
Received: by ti-out-0910.google.com with SMTP id y6so529428tia.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 14 Jan 2009 16:06:11 -0800 (PST)
In-Reply-To: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Magnus Damm <magnus.damm@gmail.com>, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

This patch adds support within broadsheetfb to process damage information
provided by userspace in order to perform more accurate partial updates.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: armbru@redhat.com
Cc: lethal@linux-sh.org
Cc: adaplas@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net
---
 drivers/video/broadsheetfb.c |  106 +++++++++++++++++++++++++++++++++++++++++-
 include/video/broadsheetfb.h |    2 +
 2 files changed, 107 insertions(+), 1 deletions(-)

diff --git a/drivers/video/broadsheetfb.c b/drivers/video/broadsheetfb.c
index 69788b9..98b02ef 100644
--- a/drivers/video/broadsheetfb.c
+++ b/drivers/video/broadsheetfb.c
@@ -293,6 +293,83 @@ static void broadsheetfb_dpy_update(struct broadsheetfb_par *par)
 
 }
 
+static void broadsheetfb_upd_full(struct broadsheetfb_par *par)
+{
+	u16 args[5];
+	args[0] = 0x4300;
+	broadsheet_send_cmdargs(par, BS_CMD_UPD_FULL, 1, args);
+
+	broadsheet_send_command(par, BS_CMD_WAIT_DSPE_TRG);
+
+	broadsheet_send_command(par, BS_CMD_WAIT_DSPE_FREND);
+
+	par->board->wait_for_rdy(par);
+}
+
+static void broadsheetfb_load_image_area(struct broadsheetfb_par *par, u16 x,
+						u16 y, u16 w, u16 h)
+{
+	u16 args[5];
+	unsigned char *sbuf = (unsigned char *)par->info->screen_base;
+	unsigned char *buf;
+	int j;
+
+	/* x must be a multiple of 4 so drop the lower bits */
+	x &= 0xFFFC;
+
+	/* y must be a multiple of 4 so drop the lower bits */
+	y &= 0xFFFC;
+
+	args[0] = 0x3 << 4;
+	args[1] = x;
+	args[2] = y;
+	args[3] = w;
+	args[4] = h;
+	broadsheet_send_cmdargs(par, BS_CMD_LD_IMG_AREA, 5, args);
+
+	args[0] = 0x154;
+	broadsheet_send_cmdargs(par, BS_CMD_WR_REG, 1, args);
+
+	for (j = y; j < y + h; j++) {
+		buf = sbuf + x + (j * par->info->var.xres);
+		broadsheet_burst_write(par, (w+1)/2, (u16 *) buf);
+	}
+	broadsheet_send_command(par, BS_CMD_LD_IMG_END);
+}
+
+static int broadsheetfb_process_damage(struct fb_info *info)
+{
+	struct broadsheetfb_par *par = info->par;
+	struct fb_damage *cur, *next;
+	int ret = -EINVAL;
+	int i;
+	struct fb_damage_rect *rect;
+
+	mutex_lock(&par->damage_lock);
+	/* if there is no damage, then caller has to do work to figure out
+	 * the changes on its own */
+	if (list_empty(&par->damagelist))
+		goto finish;
+
+	list_for_each_entry_safe(cur, next, &par->damagelist, list) {
+		for (i = 0; i < cur->len; i++) {
+			rect = &(cur->rects[i]);
+			broadsheetfb_load_image_area(par, rect->x, rect->y,
+							rect->w, rect->h);
+		}
+		list_del(&cur->list);
+		kfree(cur->rects);
+		kfree(cur);
+	}
+
+	broadsheetfb_upd_full(par);
+	ret = 0;
+finish:
+	mutex_unlock(&par->damage_lock);
+	return ret;
+}
+
+
 /* this is called back from the deferred io workqueue */
 static void broadsheetfb_dpy_deferred_io(struct fb_info *info,
 				struct list_head *pagelist)
@@ -304,6 +381,14 @@ static void broadsheetfb_dpy_deferred_io(struct fb_info *info,
 	int h_inc;
 	u16 yres = info->var.yres;
 	u16 xres = info->var.xres;
+	int ret;
+
+	/* if we have damage data then use it exclusively */
+	ret = broadsheetfb_process_damage(info);
+	if (!ret)
+		return;
+
+	/* if no damage then rely on page information */
 
 	/* height increment is fixed per page */
 	h_inc = DIV_ROUND_UP(PAGE_SIZE , xres);
@@ -414,6 +499,18 @@ static ssize_t broadsheetfb_write(struct fb_info *info, const char __user *buf,
 	return (err) ? err : count;
 }
 
+static int broadsheetfb_set_damage(struct fb_info *info,
+					struct fb_damage *damage)
+{
+	struct broadsheetfb_par *par = info->par;
+
+	mutex_lock(&par->damage_lock);
+	list_add_tail(&damage->list, &par->damagelist);
+	mutex_unlock(&par->damage_lock);
+
+	return 0;
+}
+
 static struct fb_ops broadsheetfb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_read        = fb_sys_read,
@@ -421,6 +518,7 @@ static struct fb_ops broadsheetfb_ops = {
 	.fb_fillrect	= broadsheetfb_fillrect,
 	.fb_copyarea	= broadsheetfb_copyarea,
 	.fb_imageblit	= broadsheetfb_imageblit,
+	.fb_set_damage	= broadsheetfb_set_damage,
 };
 
 static struct fb_deferred_io broadsheetfb_defio = {
@@ -499,6 +597,9 @@ static int __devinit broadsheetfb_probe(struct platform_device *dev)
 
 	broadsheet_init(par);
 
+	INIT_LIST_HEAD(&par->damagelist);
+	mutex_init(&par->damage_lock);
+
 	retval = register_framebuffer(info);
 	if (retval < 0)
 		goto err_free_irq;
@@ -513,8 +614,10 @@ static int __devinit broadsheetfb_probe(struct platform_device *dev)
 
 err_free_irq:
 	board->cleanup(par);
+	mutex_destroy(&par->damage_lock);
 err_cmap:
 	fb_dealloc_cmap(&info->cmap);
+	fb_deferred_io_cleanup(info);
 err_vfree:
 	vfree(videomemory);
 err_fb_rel:
@@ -532,9 +635,10 @@ static int __devexit broadsheetfb_remove(struct platform_device *dev)
 	if (info) {
 		struct broadsheetfb_par *par = info->par;
 		unregister_framebuffer(info);
-		fb_deferred_io_cleanup(info);
 		par->board->cleanup(par);
+		mutex_destroy(&par->damage_lock);
 		fb_dealloc_cmap(&info->cmap);
+		fb_deferred_io_cleanup(info);
 		vfree((void *)info->screen_base);
 		module_put(par->board->owner);
 		framebuffer_release(info);
diff --git a/include/video/broadsheetfb.h b/include/video/broadsheetfb.h
index a758534..5320a04 100644
--- a/include/video/broadsheetfb.h
+++ b/include/video/broadsheetfb.h
@@ -41,6 +41,8 @@ struct broadsheetfb_par {
 	void (*write_reg)(struct broadsheetfb_par *, u16 reg, u16 val);
 	u16 (*read_reg)(struct broadsheetfb_par *, u16 reg);
 	wait_queue_head_t waitq;
+	struct mutex damage_lock;
+	struct list_head damagelist;
 };
 
 /* board specific routines */
-- 
1.5.2.3


------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
