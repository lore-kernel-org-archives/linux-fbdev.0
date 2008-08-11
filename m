From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] neofb: reduce panning function
Date: Mon, 11 Aug 2008 22:53:04 +0200
Message-ID: <20080811225304.ee133455.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSeIe-0006ix-7N for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 13:47:32 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSeIc-0008E4-QI
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 13:47:32 -0700
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

Reduce panning function by deleting checks done 
by higher layer and folding remaining function
into the called one.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-old/drivers/video/neofb.c linux-2.6.26/drivers/video/neofb.c
--- linux-old/drivers/video/neofb.c	2008-08-11 21:44:29.000000000 +0200
+++ linux-2.6.26/drivers/video/neofb.c	2008-08-12 21:24:26.000000000 +0200
@@ -1186,8 +1186,11 @@ static int neofb_set_par(struct fb_info 
 	return 0;
 }
 
-static void neofb_update_start(struct fb_info *info,
-			       struct fb_var_screeninfo *var)
+/*
+ *    Pan or Wrap the Display
+ */
+static int neofb_pan_display(struct fb_var_screeninfo *var,
+			     struct fb_info *info)
 {
 	struct neofb_par *par = info->par;
 	struct vgastate *state = &par->state;
@@ -1216,35 +1219,7 @@ static void neofb_update_start(struct fb
 	vga_wgfx(state->vgabase, 0x0E, (((Base >> 16) & 0x0f) | (oldExtCRTDispAddr & 0xf0)));
 
 	neoLock(state);
-}
-
-/*
- *    Pan or Wrap the Display
- */
-static int neofb_pan_display(struct fb_var_screeninfo *var,
-			     struct fb_info *info)
-{
-	u_int y_bottom;
-
-	y_bottom = var->yoffset;
-
-	if (!(var->vmode & FB_VMODE_YWRAP))
-		y_bottom += var->yres;
-
-	if (var->xoffset > (var->xres_virtual - var->xres))
-		return -EINVAL;
-	if (y_bottom > info->var.yres_virtual)
-		return -EINVAL;
-
-	neofb_update_start(info, var);
-
-	info->var.xoffset = var->xoffset;
-	info->var.yoffset = var->yoffset;
 
-	if (var->vmode & FB_VMODE_YWRAP)
-		info->var.vmode |= FB_VMODE_YWRAP;
-	else
-		info->var.vmode &= ~FB_VMODE_YWRAP;
 	return 0;
 }
 

----------------------------------------------------------------------
Taniej na zagraniczne komorki!
Sprawdz >>> http://link.interia.pl/f1ece


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
