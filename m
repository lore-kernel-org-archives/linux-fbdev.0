From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: patch fixing background next to penguin logo in monochrome
Date: Thu, 12 Aug 2004 22:30:05 +0000 (UTC)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409130625.07250.adaplas@hotpop.com>
References: <1092254183.4209.16.camel@joy.home> <1092312171.27772.73.camel@joy.sophics> <Pine.GSO.4.58.0408122158550.18214@waterleaf.sonytel.be>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BvO1i-00085t-QL
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Aug 2004 15:26:26 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BvO1i-0000lW-70
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Aug 2004 15:26:26 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 8D063790591
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 12 Aug 2004 21:31:53 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.58.0408122158550.18214@waterleaf.sonytel.be>
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
Date: Mon, 13 Sep 2004 06:25:05 +0800
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>, Petr Stehlik <pstehlik@sophics.cz>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Christian T. Steigies" <cts@debian.org>

On Friday 13 August 2004 04:01, Geert Uytterhoeven wrote:
>
> P.S. There are still problems when switching from color to monochrome
>      (underlines appear everywhere) or vice versa (text becomes blue), but
> I cannot expect you to fix all old bugs in one week ;-)

This one is a little difficult since there is currently no method to convert
monochrome attributes to color and vice versa.  The best one can do is to
clear all attributes when switching from mono<->color.

When switching, one will get plain text only.  This is  probably better than
having text with incorrect attributes.

Attached patch is completely untested, but it's the same one in 2.6.

Tony

diff -uprN linux-2.4-orig/drivers/char/console.c linux-2.4/drivers/char/console.c
--- linux-2.4-orig/drivers/char/console.c	2004-09-13 06:09:05.000000000 +0800
+++ linux-2.4/drivers/char/console.c	2004-09-13 06:13:40.072568112 +0800
@@ -693,6 +693,17 @@ static inline void save_screen(int currc
  *	Redrawing of screen
  */
 
+static void clear_buffer_attributes(int currcons)
+{
+	unsigned short *p = (unsigned short *) origin;
+	int count = screenbuf_size/2;
+	int mask = hi_font_mask | 0xff;
+
+	for (; count > 0; count--, p++) {
+		scr_writew((scr_readw(p)&mask) | (video_erase_char&~mask), p);
+	}
+}
+
 void redraw_screen(int new_console, int is_switch)
 {
 	int redraw = 1;
@@ -728,9 +739,21 @@ void redraw_screen(int new_console, int 
 
 	if (redraw) {
 		int update;
+		int old_was_color = vc_cons[currcons].d->vc_can_do_color;
+
 		set_origin(currcons);
 		update = sw->con_switch(vc_cons[currcons].d);
 		set_palette(currcons);
+		/*
+		 * If console changed from mono<->color, the best we can do
+		 * is to clear the buffer attributes. As it currently stands,
+		 * rebuilding new attributes from the old buffer is not doable
+		 * without overly complex code.
+		 */
+		if (old_was_color != vc_cons[currcons].d->vc_can_do_color) {
+			update_attr(currcons);
+			clear_buffer_attributes(currcons);
+		}
 		if (update && vcmode != KD_GRAPHICS)
 			do_update_region(currcons, origin, screenbuf_size/2);
 	}
@@ -2750,18 +2773,6 @@ void __init con_init(void)
 }
 
 #ifndef VT_SINGLE_DRIVER
-
-static void clear_buffer_attributes(int currcons)
-{
-	unsigned short *p = (unsigned short *) origin;
-	int count = screenbuf_size/2;
-	int mask = hi_font_mask | 0xff;
-
-	for (; count > 0; count--, p++) {
-		scr_writew((scr_readw(p)&mask) | (video_erase_char&~mask), p);
-	}
-}
-
 /*
  *	If we support more console drivers, this function is used
  *	when a driver wants to take over some existing consoles







-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
