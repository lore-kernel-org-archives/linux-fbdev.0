From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/8] fbdev: Fix for using >16 pixel wide font in fb console
Date: Thu, 11 Nov 2004 10:15:08 +0800
Message-ID: <20041111022429.2C1541A022D@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CS4dm-00051v-DS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:24:50 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CS4dk-0006i0-N7
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:24:49 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9C2069D821A
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 11 Nov 2004 02:24:40 +0000 (UTC)
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jani Jaakkola <jjaakkol@cs.Helsinki.FI>

From: Jani Jaakkola <jjaakkol@cs.Helsinki.FI>:

...The first one was that fbcon_set_font() used one byte padding for fonts
having width 16 <= width < 24, which was wrong since the pieces of code
actually using the font did not use any padding. This is fixed in the
included patch and also fbcon_set_font() is made a little cleaner. After
the patch the following font is not garbled in fb console:
http://www.cs.helsinki.fi/u/jjaakkol/psf/bitstream_vera_sans_mono_roman.16x30.psf

The other bug is that fonts having height == 32 crash the kernel. I have
no fix for this (at least not yet), but it can be reproduced with font:
http://www.cs.helsinki.fi/u/jjaakkol/psf/bitstream_vera_sans_mono_roman.17x32.psf...

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbcon.c |   76 +++++++++++++++++++---------------------------------------------
 1 files changed, 23 insertions(+), 53 deletions(-)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2004-11-10 06:15:06 +08:00
+++ b/drivers/video/console/fbcon.c	2004-11-08 09:32:38 +08:00
@@ -77,7 +77,7 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-
+#include <linux/crc32.h> /* For counting font checksums */
 #include <asm/irq.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -2257,6 +2257,12 @@
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
@@ -2264,20 +2270,17 @@
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
 
@@ -2288,55 +2291,22 @@
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
-	}
-	/* we can do it in u32 chunks because of charcount is 256 or 512, so
-	   font length must be multiple of 256, at least. And 256 is multiple
-	   of 4 */
-	k = 0;
-	while (p > new_data) {
-		p = (u8 *)((u32 *)p - 1);
-		k += *(u32 *) p;
+	for (i=0; i< charcount; i++) {
+		memcpy(new_data + i*h*pitch, data +  i*32*pitch, h*pitch);
 	}
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
