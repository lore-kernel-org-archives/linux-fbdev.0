From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] neofb: remove open_lock mutex
Date: Sun, 24 Aug 2008 08:30:03 +0200
Message-ID: <20080824083003.4837596d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KX9U1-000651-2g for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Aug 2008 23:53:53 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KX9U0-0001Dl-Mj
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Aug 2008 23:53:53 -0700
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
diff -urp linux-ref/drivers/video/neofb.c linux-2.6/drivers/video/neofb.c
--- linux-ref/drivers/video/neofb.c	2008-08-25 03:08:04.000000000 +0200
+++ linux-2.6/drivers/video/neofb.c	2008-08-25 03:09:38.000000000 +0200
@@ -557,14 +557,12 @@ neofb_open(struct fb_info *info, int use
 {
 	struct neofb_par *par = info->par;
 
-	mutex_lock(&par->open_lock);
 	if (!par->ref_count) {
 		memset(&par->state, 0, sizeof(struct vgastate));
 		par->state.flags = VGA_SAVE_MODE | VGA_SAVE_FONTS;
 		save_vga(&par->state);
 	}
 	par->ref_count++;
-	mutex_unlock(&par->open_lock);
 
 	return 0;
 }
@@ -574,16 +572,13 @@ neofb_release(struct fb_info *info, int 
 {
 	struct neofb_par *par = info->par;
 
-	mutex_lock(&par->open_lock);
-	if (!par->ref_count) {
-		mutex_unlock(&par->open_lock);
+	if (!par->ref_count)
 		return -EINVAL;
-	}
+
 	if (par->ref_count == 1) {
 		restore_vga(&par->state);
 	}
 	par->ref_count--;
-	mutex_unlock(&par->open_lock);
 
 	return 0;
 }
@@ -1957,7 +1952,6 @@ static struct fb_info *__devinit neo_all
 
 	info->fix.accel = id->driver_data;
 
-	mutex_init(&par->open_lock);
 	par->pci_burst = !nopciburst;
 	par->lcd_stretch = !nostretch;
 	par->libretto = libretto;
diff -urp linux-ref/include/video/neomagic.h linux-2.6/include/video/neomagic.h
--- linux-ref/include/video/neomagic.h	2008-08-09 05:09:31.000000000 +0200
+++ linux-2.6/include/video/neomagic.h	2008-08-25 03:09:07.000000000 +0200
@@ -123,7 +123,6 @@ typedef volatile struct {
 
 struct neofb_par {
 	struct vgastate state;
-	struct mutex open_lock;
 	unsigned int ref_count;
 
 	unsigned char MiscOutReg;	/* Misc */

----------------------------------------------------------------------
Nie szukam kochanka!
>> http://link.interia.pl/f1eeb


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
