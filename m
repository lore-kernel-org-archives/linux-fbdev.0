From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fix warning in fbmem.c
Date: Thu, 17 Jun 2004 10:16:38 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406171015270.21503@waterleaf.sonytel.be>
References: <8A43C34093B3D5119F7D0004AC56F4BC082C7F93@difpst1a.dif.dk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bas4r-000849-B9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 01:16:53 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bas4q-0001y7-Kx
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 01:16:52 -0700
In-Reply-To: <8A43C34093B3D5119F7D0004AC56F4BC082C7F93@difpst1a.dif.dk>
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
To: Jesper Juhl <juhl-lkml@dif.dk>, Andrew Morton <akpm@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Thu, 17 Jun 2004, Jesper Juhl wrote:
> Here are two proposed patches to fix the following warning in fbmem.c :
> drivers/video/fbmem.c:933: warning: passing arg 1 of `copy_from_user' discards qualifiers from pointer target type
>
> The cause of the warning is that the .data member of struct fb_image is of
> type 'const char *' and copy_from_user() takes a 'void *' as it's first
> 'to' argument.
> I see two ways to fix it;
> a) use a simple cast to hide the warning
> b) rewrite the code to copy into a buffer pointed to by a non-const
> pointer, then assign the pointer to cursor.image.data

Here is a variant of b, which avoids the cast and makes cursor.mask const as
well.

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
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
