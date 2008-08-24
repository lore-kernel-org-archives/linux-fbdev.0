From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] vga16fb: remove open_lock mutex
Date: Sun, 24 Aug 2008 08:29:51 +0200
Message-ID: <20080824082951.d344dea0.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KX9J1-00055h-Hf for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Aug 2008 23:42:31 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KX9J0-0008Sg-3M
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Aug 2008 23:42:31 -0700
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove mutex from the fb_open/fb_release functions
as these operations are mutexed at fb layer.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-ref/drivers/video/vga16fb.c linux-2.6/drivers/video/vga16fb.c
--- linux-ref/drivers/video/vga16fb.c	2008-08-09 05:09:05.000000000 +0200
+++ linux-2.6/drivers/video/vga16fb.c	2008-08-25 03:10:07.000000000 +0200
@@ -58,7 +58,6 @@ struct vga16fb_par {
 		unsigned char	ClockingMode;	  /* Seq-Controller:01h */
 	} vga_state;
 	struct vgastate state;
-	struct mutex open_lock;
 	unsigned int ref_count;
 	int palette_blanked, vesa_blanked, mode, isVGA;
 	u8 misc, pel_msk, vss, clkdiv;
@@ -286,7 +285,6 @@ static int vga16fb_open(struct fb_info *
 {
 	struct vga16fb_par *par = info->par;
 
-	mutex_lock(&par->open_lock);
 	if (!par->ref_count) {
 		memset(&par->state, 0, sizeof(struct vgastate));
 		par->state.flags = VGA_SAVE_FONTS | VGA_SAVE_MODE |
@@ -294,7 +292,6 @@ static int vga16fb_open(struct fb_info *
 		save_vga(&par->state);
 	}
 	par->ref_count++;
-	mutex_unlock(&par->open_lock);
 
 	return 0;
 }
@@ -303,15 +300,12 @@ static int vga16fb_release(struct fb_inf
 {
 	struct vga16fb_par *par = info->par;
 
-	mutex_lock(&par->open_lock);
-	if (!par->ref_count) {
-		mutex_unlock(&par->open_lock);
+	if (!par->ref_count)
 		return -EINVAL;
-	}
+
 	if (par->ref_count == 1)
 		restore_vga(&par->state);
 	par->ref_count--;
-	mutex_unlock(&par->open_lock);
 
 	return 0;
 }
@@ -1326,7 +1320,6 @@ static int __init vga16fb_probe(struct p
 	printk(KERN_INFO "vga16fb: mapped to 0x%p\n", info->screen_base);
 	par = info->par;
 
-	mutex_init(&par->open_lock);
 	par->isVGA = screen_info.orig_video_isVGA;
 	par->palette_blanked = 0;
 	par->vesa_blanked = 0;

----------------------------------------------------------------------
Alergia na seks?
>> http://link.interia.pl/f1eec


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
