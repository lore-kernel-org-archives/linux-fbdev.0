From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: (no subject)
Date: Mon, 19 Aug 2002 11:02:01 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0208191056040.12594-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17giQT-0007rR-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Aug 2002 02:02:18 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA19887
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Aug 2002 11:02:02 +0200 (MET DST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

	Hi,

In cfb_copyarea(), `tmp' must be unsigned long because it is used to store
unsigned long values (see patch at the end).

cfb_copyarea() also doesn't clear the bits to modify in the first and last
words of a line, e.g. it does

|	last = (FB_READ(src) & start_mask);
|
|	if (shift > 0) 
|		FB_WRITE(FB_READ(dst) | (last >> shift_right), dst);
                         ^^^^^^^^^^^^
After this read, the bits to modify must be cleared first, before the OR!

I'm working on a version of cfb_copyarea() that fixes this and handles _all_
possible values of var.bits_per_pixel (the current code assumes
var.bits_per_pixel is a multiple of 8). Stay tuned!

--- fbdev-2.5/drivers/video/cfbcopyarea.c	Mon Aug 19 10:49:58 2002
+++ geert-2.5/devivers/video/cfbcopyarea.c	Mon Aug 19 10:55:53 2002
@@ -40,10 +40,10 @@
 {
 	int x2, y2, lineincr, shift, shift_right, shift_left, old_dx, old_dy;
 	int j, linesize = p->fix.line_length, bpl = sizeof(unsigned long);
-	unsigned long start_index, end_index, start_mask, end_mask, last;
+	unsigned long start_index, end_index, start_mask, end_mask, last, tmp;
 	unsigned long *dst = NULL, *src = NULL;
 	char *src1, *dst1;
-	int tmp, height;
+	int height;
 
 	/* clip the destination */
 	old_dx = area->dx;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
