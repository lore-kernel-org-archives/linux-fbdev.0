From: Jani Jaakkola <jjaakkol@cs.Helsinki.FI>
Subject: [PATCH] fix for using >16 pixel wide font in fb console
Date: Mon, 8 Nov 2004 02:17:51 +0200 (EET)
Message-ID: <Pine.LNX.4.58.0411080202040.5524@glomgold-9.cs.helsinki.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQxFM-0002wV-Tp
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 16:19:00 -0800
Received: from courier.cs.helsinki.fi ([128.214.9.1] helo=mail.cs.helsinki.fi)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CQxFM-00061a-2z
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 16:19:00 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jjaakkol@cs.Helsinki.FI


[ Please, CC any replies to me, I am not a regular kernel hacker ]

I wrote a small tool to convert fonts understood by freetype to linux
console fonts, since I wanted to use larger fonts than the ones shipped
with kbd package on my console. This exposed (at least) two bugs in fb
console driver.

The first one was that fbcon_set_font() used one byte padding for fonts
having width 16 <= width < 24, which was wrong since the pieces of code
actually using the font did not use any padding. This is fixed in the
included patch and also fbcon_set_font() is made a little cleaner. After
the patch the following font is not garbled in fb console:
http://www.cs.helsinki.fi/u/jjaakkol/psf/bitstream_vera_sans_mono_roman.16x30.psf

The other bug is that fonts having height == 32 crash the kernel. I have
no fix for this (at least not yet), but it can be reproduced with font:
http://www.cs.helsinki.fi/u/jjaakkol/psf/bitstream_vera_sans_mono_roman.17x32.psf

The tool (unfinished and probably broken) and some other fonts are
available from http://www.cs.helsinki.fi/u/jjaakkol/psf/

Included patch is against vanilla 2.6.9 kernel.

- Jani

--- linux-2.6.9/drivers/video/console/fbcon.c	Tue Oct 19 00:54:39 2004
+++ linux-2.6.9-csl/drivers/video/console/fbcon.c	Mon Nov  8 01:32:38 2004
@@ -77,7 +77,7 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-
+#include <linux/crc32.h> /* For counting font checksums */
 #include <asm/irq.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -2352,6 +2352,12 @@
  *  User asked to set font; we are guaranteed that
  *	a) width and height are in range 1..32
  *	b) charcount does not exceed 512
+ *  but lets not assume that, since someone might someday want to use larger
+ *  fonts. And charcount of 512 is small for unicode support.
+ * 
+ *  However, user space gives the font in 32 rows , regardless of 
+ *  actual font height. So a new API is needed if support for larger fonts
+ *  is ever implemented.
  */
 
 static int fbcon_set_font(struct vc_data *vc, struct console_font *font, unsigned flags)
@@ -2359,20 +2365,17 @@
 	unsigned charcount = font->charcount;
 	int w = font->width;
 	int h = font->height;
-	int size = h;
-	int i, k;
-	u8 *new_data, *data = font->data, *p;
+	int size;
+	int i, csum;
+	u8 *new_data, *data = font->data;
+	int pitch = (font->width+7) >> 3;
 
+	/* Is there a reason why fbconsole couldn't handle any charcount >256?
+	 * If not this check should be changed to charcount < 256 */
 	if (charcount != 256 && charcount != 512)
 		return -EINVAL;
 
-	if (w > 8) {
-		if (w <= 16)
-			size *= 2;
-		else
-			size *= 4;
-	}
-	size *= charcount;
+	size = h * pitch * charcount;
 
 	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);
 
@@ -2383,55 +2386,22 @@
 	FNTSIZE(new_data) = size;
 	FNTCHARCNT(new_data) = charcount;
 	REFCOUNT(new_data) = 0;	/* usage counter */
-	p = new_data;
-	if (w <= 8) {
-		for (i = 0; i < charcount; i++) {
-			memcpy(p, data, h);
-			data += 32;
-			p += h;
-		}
-	} else if (w <= 16) {
-		h *= 2;
-		for (i = 0; i < charcount; i++) {
-			memcpy(p, data, h);
-			data += 64;
-			p += h;
-		}
-	} else if (w <= 24) {
-		for (i = 0; i < charcount; i++) {
-			int j;
-			for (j = 0; j < h; j++) {
-				memcpy(p, data, 3);
-				p[3] = 0;
-				data += 3;
-				p += sizeof(u32);
-			}
-			data += 3 * (32 - h);
-		}
-	} else {
-		h *= 4;
-		for (i = 0; i < charcount; i++) {
-			memcpy(p, data, h);
-			data += 128;
-			p += h;
-		}
+	for (i=0; i< charcount; i++) {
+		memcpy(new_data + i*h*pitch, data +  i*32*pitch, h*pitch);
 	}
-	/* we can do it in u32 chunks because of charcount is 256 or 512, so
-	   font length must be multiple of 256, at least. And 256 is multiple
-	   of 4 */
-	k = 0;
-	while (p > new_data) {
-		p = (u8 *)((u32 *)p - 1);
-		k += *(u32 *) p;
-	}
-	FNTSUM(new_data) = k;
+
+	/* Since linux has a nice crc32 function use it for counting font
+	 * checksums. */
+	csum = crc32(0, new_data, size);
+
+	FNTSUM(new_data) = csum;
 	/* Check if the same font is on some other console already */
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		struct vc_data *tmp = vc_cons[i].d;
 		
 		if (fb_display[i].userfont &&
 		    fb_display[i].fontdata &&
-		    FNTSUM(fb_display[i].fontdata) == k &&
+		    FNTSUM(fb_display[i].fontdata) == csum &&
 		    FNTSIZE(fb_display[i].fontdata) == size &&
 		    tmp->vc_font.width == w &&
 		    !memcmp(fb_display[i].fontdata, new_data, size)) {


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
