From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2.6.7-rc2] get rid of fbmem warning
Date: Mon, 7 Jun 2004 23:14:56 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406072314020.521@waterleaf.sonytel.be>
References: <20040607101025.2e30b001@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXRSa-0008Sa-Ur
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Jun 2004 14:15:12 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BXRSa-00055F-CN
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Jun 2004 14:15:12 -0700
In-Reply-To: <20040607101025.2e30b001@dell_ss3.pdx.osdl.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Hemminger <shemminger@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 7 Jun 2004, Stephen Hemminger wrote:
> Get rid of warning because fb_image data is declared 'const char *' but is
> being modified by the copy_from_user.

I prefer this (untested, except for a compile test) patch, which avoids the
cast and makes cursor.mask const as well.

--- linux-2.6.7-rc1/drivers/video/fbmem.c.orig	2004-05-24 11:38:04.000000000 +0200
+++ linux-2.6.7-rc1/drivers/video/fbmem.c	2004-06-07 22:38:42.000000000 +0200
@@ -916,26 +916,30 @@ fb_cursor(struct fb_info *info, struct f

 	if (cursor.set & FB_CUR_SETSHAPE) {
 		int size = ((cursor.image.width + 7) >> 3) * cursor.image.height;
+		char *data, *mask;
+
 		if ((cursor.image.height != info->cursor.image.height) ||
 		    (cursor.image.width != info->cursor.image.width))
 			cursor.set |= FB_CUR_SETSIZE;

-		cursor.image.data = kmalloc(size, GFP_KERNEL);
-		if (!cursor.image.data)
+		data = kmalloc(size, GFP_KERNEL);
+		if (!data)
 			return -ENOMEM;

-		cursor.mask = kmalloc(size, GFP_KERNEL);
-		if (!cursor.mask) {
-			kfree(cursor.image.data);
+		mask = kmalloc(size, GFP_KERNEL);
+		if (!mask) {
+			kfree(data);
 			return -ENOMEM;
 		}

-		if (copy_from_user(cursor.image.data, sprite->image.data, size) ||
-		    copy_from_user(cursor.mask, sprite->mask, size)) {
-			kfree(cursor.image.data);
-			kfree(cursor.mask);
+		if (copy_from_user(data, sprite->image.data, size) ||
+		    copy_from_user(mask, sprite->mask, size)) {
+			kfree(data);
+			kfree(mask);
 			return -EFAULT;
 		}
+		cursor.image.data = data;
+		cursor.mask = mask;
 	}
 	info->cursor.set = cursor.set;
 	info->cursor.rop = cursor.rop;
--- linux-2.6.7-rc1/include/linux/fb.h.orig	2004-05-24 11:14:01.000000000 +0200
+++ linux-2.6.7-rc1/include/linux/fb.h	2004-06-07 22:38:01.000000000 +0200
@@ -375,7 +375,7 @@ struct fb_cursor {
 	__u16 set;		/* what to set */
 	__u16 enable;		/* cursor on/off */
 	__u16 rop;		/* bitop operation */
-	char *mask;		/* cursor mask bits */
+	const char *mask;	/* cursor mask bits */
 	struct fbcurpos hot;	/* cursor hot spot */
 	struct fb_image	image;	/* Cursor image */
 };

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
