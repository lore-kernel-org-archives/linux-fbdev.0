From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: writing a framebuffer driver and font
 problem..
Date: Fri, 31 Oct 2003 13:16:16 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0310311315450.17237-100000@waterleaf.sonytel.be>
References: <1067600060.30097.1.camel@toriamos.abo.fi>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFYCR-00044I-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 Oct 2003 04:16:19 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AFYCR-0005CA-1i
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 31 Oct 2003 04:16:19 -0800
In-Reply-To: <1067600060.30097.1.camel@toriamos.abo.fi>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kaj-Michael Lang <milang@tal.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 31 Oct 2003, Kaj-Michael Lang wrote:
> On Fri, 2003-10-31 at 12:41, Geert Uytterhoeven wrote:
> > Are you using 2.4 or 2.6?
> 
> 2.4 for now, but I'm going to port it over to 2.6.
> 
> > You have to swap the character data in
> > drivers/video/fbcon-mfb.c:fbcon_mfb_putc{,s}() (2.4.x) or
> > drivers/video/cfbimgblt.c.
> 
> Ok.. stupid question.. how do I do that ?

This (untested) patch should do the trick...

--- linux-2.4.x/drivers/video/fbcon-mfb.c.orig	2001-10-02 11:47:46.000000000 +0200
+++ linux-2.4.x/drivers/video/fbcon-mfb.c	2003-10-31 13:14:47.000000000 +0100
@@ -19,6 +19,15 @@
 #include <video/fbcon-mfb.h>
 
 
+static inline u8 swap_byte(u8 in)
+{
+    in = ((in & 0xf0) >> 4) | ((in & 0x0f) << 4);
+    in = ((in & 0xcc) >> 2) | ((in & 0x33) << 2);
+    in = ((in & 0xaa) >> 1) | ((in & 0x55) << 1);
+    return in;
+}
+
+
     /*
      *  Monochrome
      */
@@ -97,7 +106,7 @@
     underl = attr_underline(p,c);
 
     for (rows = fontheight(p); rows--; dest += p->next_line) {
-	d = *cdat++;
+	d = swap_byte(*cdat++);
 	if (underl && !rows)
 	    d = 0xff;
 	else if (bold)
@@ -127,7 +136,7 @@
 	dest = dest0++;
 	cdat = p->fontdata+c*fontheight(p);
 	for (rows = fontheight(p); rows--; dest += p->next_line) {
-	    d = *cdat++;
+	    d = swap_byte(*cdat++);
 	    if (underl && !rows)
 		d = 0xff;
 	    else if (bold)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
