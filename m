From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/3] [FBDEV]: Video mode change notify (fbset)
Date: Tue, 22 Jun 2004 06:39:20 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406220639.20791.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BcXPm-0002sI-IG
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Jun 2004 15:37:22 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BcXPm-0001Yz-2Y
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Jun 2004 15:37:22 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id EA118632925
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Jun 2004 21:57:48 +0000 (UTC)
Content-Disposition: inline
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
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

This patch allows fbset to change the video mode and the console
window size via the notifier call chain.  It will only notify fbcon of
mode changes from user space.  Changes coming from
upstream will be ignored.

The code will only update the current console.

Tony

Against linux-2.6.7-mm1

Signed-off-by: Antonino Daplas <adaplas@pol.net>

diff -Naur linux-2.6.7-mm1-orig/drivers/video/console/fbcon.c linux-2.6.7-mm1/drivers/video/console/fbcon.c
--- linux-2.6.7-mm1-orig/drivers/video/console/fbcon.c	2004-06-21 16:49:22.000000000 +0000
+++ linux-2.6.7-mm1/drivers/video/console/fbcon.c	2004-06-21 17:12:20.896035296 +0000
@@ -2358,6 +2358,56 @@
 	update_screen(vc->vc_num);
 }
 
+static void fbcon_modechanged(struct fb_info *info)
+{
+	struct vc_data *vc = vc_cons[info->currcon].d;
+	struct display *p;
+	int rows, cols;
+
+	if (info->currcon < 0 || vt_cons[info->currcon]->vc_mode !=
+	    KD_TEXT) 
+		return;
+	p = &fb_display[vc->vc_num];
+
+	info->var.xoffset = info->var.yoffset = p->yscroll = 0;
+	vc->vc_can_do_color = info->var.bits_per_pixel != 1;
+	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
+
+	if (CON_IS_VISIBLE(vc)) {
+		cols = info->var.xres / vc->vc_font.width;
+		rows = info->var.yres / vc->vc_font.height;
+		vc_resize(vc->vc_num, cols, rows);
+		switch (p->scrollmode) {
+		case SCROLL_WRAP:
+			scrollback_phys_max = p->vrows - vc->vc_rows;
+			break;
+		case SCROLL_PAN:
+			scrollback_phys_max = p->vrows - 2 * vc->vc_rows;
+			if (scrollback_phys_max < 0)
+				scrollback_phys_max = 0;
+			break;
+		default:
+			scrollback_phys_max = 0;
+			break;
+		}	
+		scrollback_max = 0;
+		scrollback_current = 0;
+		update_var(vc->vc_num, info);
+		fbcon_set_palette(vc, color_table); 	
+		update_screen(vc->vc_num);
+		if (softback_buf) { 
+			int l = fbcon_softback_size / vc->vc_size_row;
+			if (l > 5)
+				softback_end = softback_buf + l * vc->vc_size_row;
+			else {
+				/* Smaller scrollback makes no sense, and 0 
+				   would screw the operation totally */
+				softback_top = 0;
+			}
+		}
+	}
+}
+
 static int fbcon_event_notify(struct notifier_block *self, 
 			      unsigned long action, void *data)
 {
@@ -2370,6 +2420,9 @@
 	case FB_EVENT_RESUME:
 		fbcon_resumed(info);
 		break;
+	case FB_EVENT_MODE_CHANGE:
+		fbcon_modechanged(info);
+		break;
 	}
 	    
 	return 0;
diff -Naur linux-2.6.7-mm1-orig/drivers/video/fbmem.c linux-2.6.7-mm1/drivers/video/fbmem.c
--- linux-2.6.7-mm1-orig/drivers/video/fbmem.c	2004-06-21 16:49:22.000000000 +0000
+++ linux-2.6.7-mm1/drivers/video/fbmem.c	2004-06-21 17:12:07.429082584 +0000
@@ -1005,7 +1005,11 @@
 
 			fb_set_cmap(&info->cmap, 1, info);
 
-			notifier_call_chain(&fb_notifier_list, FB_EVENT_MODE_CHANGE, info);
+			if (info->flags & FBINFO_MISC_MODECHANGEUSER) {
+				notifier_call_chain(&fb_notifier_list, 
+						    FB_EVENT_MODE_CHANGE, info);
+				info->flags &= ~FBINFO_MISC_MODECHANGEUSER;
+			}
 		}
 	}
 	return 0;
@@ -1056,7 +1060,9 @@
 		if (copy_from_user(&var, (void *) arg, sizeof(var)))
 			return -EFAULT;
 		acquire_console_sem();
+		info->flags |= FBINFO_MISC_MODECHANGEUSER;
 		i = fb_set_var(info, &var);
+		info->flags &= ~FBINFO_MISC_MODECHANGEUSER;
 		release_console_sem();
 		if (i) return i;
 		if (copy_to_user((void *) arg, &var, sizeof(var)))
diff -Naur linux-2.6.7-mm1-orig/include/linux/fb.h linux-2.6.7-mm1/include/linux/fb.h
--- linux-2.6.7-mm1-orig/include/linux/fb.h	2004-06-21 16:49:23.000000000 +0000
+++ linux-2.6.7-mm1/include/linux/fb.h	2004-06-21 17:12:36.452670328 +0000
@@ -530,6 +530,8 @@
 #define FBINFO_HWACCEL_YPAN		0x2000 /* optional */
 #define FBINFO_HWACCEL_YWRAP		0x4000 /* optional */
 
+#define FBINFO_MISC_MODECHANGEUSER     0x10000 /* mode change request
+						  from userspace */
 
 struct fb_info {
 	int node;




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
