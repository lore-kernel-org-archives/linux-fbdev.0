From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: PATCH: 2.6.7-rc3 drivers/video/fbmem.c:
 user/kernel pointer bugs
Date: Thu, 10 Jun 2004 11:15:56 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406101114480.14266@waterleaf.sonytel.be>
References: <1086821199.32054.111.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BYLfT-0004qV-Qb
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Jun 2004 02:16:15 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BYLfQ-0006he-TD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Jun 2004 02:16:13 -0700
In-Reply-To: <1086821199.32054.111.camel@dooby.cs.berkeley.edu>
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
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel <linux-kernel@vger.kernel.org>

On Thu, 9 Jun 2004, Robert T. Johnson wrote:
> Since sprite is a user pointer, reading sprite->mask or sprite->image.data
> requires unsafe dereferences.  Let me know if you have any questions or if
> I've made a mistake.

I sent this one (untested, except for a compile test) to linux-fbdev-devel a
few days ago.

It also makes cursor.mask const, just like image.data.

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
