From: Petr Stehlik <pstehlik@sophics.cz>
Subject: patch fixing background next to penguin logo in monochrome
Date: Wed, 11 Aug 2004 21:56:23 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1092254183.4209.16.camel@joy.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BuzDK-0004ov-Qc
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Aug 2004 12:56:46 -0700
Received: from ns1.avonet.cz ([217.112.162.41])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BuzDK-0007mM-3z
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Aug 2004 12:56:46 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Christian T. Steigies" <cts@debian.org>

Hi all,

I have developed a simple workaround for a problem existing in
framebuffer when it interprets VGA attribute bits in monochrome mode.
Instead of empty chars we get underlines - you can see what I mean at
http://joy.sophics.cz/horizlines.jpg - the image shows the background
where the penguin logo will appear during linux kernel boot up. The logo
then looks like incorrectly drawn (due to the horizontal lines) and
people are complaining or reporting this as a sign of a kernel problems
with their hardware setup or something.

When Geert told me in linux-m68k that this issue was a years known
problem and a quite complicated thing to fix I tried to come up with a
simpler solution and here it is: the patch attached below simply erases
the background next to the penguin(s) while it paints them. The result
is clear screen with just the penguin logo. 

The patch has been tested on my Atari Falcon both in normal and inverse
monochrome mode. It's so simple that I hope it gets accepted in the
kernel.

Please CC: me in replies as I am not subscribed to this list.

Thanks.

Petr

Index: drivers/video/fbcon.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/drivers/video/Attic/fbcon.c,v
retrieving revision 1.1.1.2.2.6
diff -u -r1.1.1.2.2.6 fbcon.c
--- drivers/video/fbcon.c	26 Aug 2003 03:13:09 -0000	1.1.1.2.2.6
+++ drivers/video/fbcon.c	11 Aug 2004 19:50:16 -0000
@@ -2433,12 +2433,16 @@
 		    dst = fb + (y1%4)*8192 + (y1>>2)*line + x/8;
 		else
 		    dst = fb + y1*line + x/8;
-		for( x1 = 0; x1 < LOGO_LINE; ++x1 ) {
+		for( x1 = 0; x1 < (p->var.xres-x)/8; ++x1 ) {
+		    char c;
+		    if (x1 < LOGO_LINE)
+			c = *src++ ^ inverse; /* logo data */
+		    else
+			c = ~inverse; /* erase background to end of line */
 #ifndef CONFIG_HP300
-		    fb_writeb(*src++ ^ inverse, dst++);
+		    fb_writeb(c, dst++);
 #else /* CONFIG_HP300 */
 		    /* hack hack -- make it work with topcat in pseudomono mode */
-		    char c = *src++ ^ inverse;
 		    fb_writeb((c >> 7) & 1, dst++);
 		    fb_writeb((c >> 6) & 1, dst++);
 		    fb_writeb((c >> 5) & 1, dst++);




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
