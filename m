From: Jesper Juhl <juhl-lkml@dif.dk>
Subject: [PATCH] fix warning in fbmem.c
Date: Thu, 17 Jun 2004 01:47:30 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC082C7F93@difpst1a.dif.dk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bak8r-0008El-R8
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 16:48:29 -0700
Received: from mail.dif.dk ([193.138.115.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bak8q-0007jh-5w
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 16:48:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.dif.dk (Postfix) with ESMTP id AB9C0FFC73
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Jun 2004 01:56:55 +0200 (CEST)
Received: from mail.dif.dk ([127.0.0.1])
 by localhost (saerimmer [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17246-06 for <linux-fbdev-devel@lists.sourceforge.net>;
 Thu, 17 Jun 2004 01:56:53 +0200 (CEST)
Received: from diftmgw2.backbone.dif.dk (diftmgw2.backbone.dif.dk [10.227.136.246])
	by mail.dif.dk (Postfix) with ESMTP id 9B063FFC67
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Jun 2004 01:56:51 +0200 (CEST)
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
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


Hi,

Here are two proposed patches to fix the following warning in fbmem.c :
drivers/video/fbmem.c:933: warning: passing arg 1 of `copy_from_user' discards qualifiers from pointer target type

The cause of the warning is that the .data member of struct fb_image is of
type 'const char *' and copy_from_user() takes a 'void *' as it's first
'to' argument.
I see two ways to fix it;
a) use a simple cast to hide the warning
b) rewrite the code to copy into a buffer pointed to by a non-const
pointer, then assign the pointer to cursor.image.data

Personally I prefer the second approach since just casting away const
defeats the whole purpose of having something const in the first place
(yes, I do realize it's quite safe in this case) and makes it look like it
could be hiding a bug on casual inspection. Better to make it completely
explicit that first we allocate a buffer and fill it, then we assign it to
this const member since it's not supposed to be changed again from this
point forward.
But, I've prepared patches implementing both solutions in case your
preference is different from mine.
Patching against 2.6.7


Here's first the patch that simply casts the pointer :

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.7-orig/drivers/video/fbmem.c	2004-06-16 07:18:37.000000000 +0200
+++ linux-2.6.7/drivers/video/fbmem.c	2004-06-17 00:59:48.000000000 +0200
@@ -930,7 +930,7 @@ fb_cursor(struct fb_info *info, struct f
 			return -ENOMEM;
 		}

-		if (copy_from_user(cursor.image.data, sprite->image.data, size) ||
+		if (copy_from_user((void *)cursor.image.data, sprite->image.data, size) ||
 		    copy_from_user(cursor.mask, sprite->mask, size)) {
 			kfree(cursor.image.data);
 			kfree(cursor.mask);


and here is the (in my oppinion better) patch that makes use of a
sepperate pointer and then assigns to cursor.image.data at the end :

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.7-orig/drivers/video/fbmem.c	2004-06-16 07:18:37.000000000 +0200
+++ linux-2.6.7/drivers/video/fbmem.c	2004-06-17 00:55:16.000000000 +0200
@@ -901,6 +901,7 @@ fb_cursor(struct fb_info *info, struct f
 {
 	struct fb_cursor cursor;
 	int err;
+	char *image_data;

 	if (copy_from_user(&cursor, sprite, sizeof(struct fb_cursor)))
 		return -EFAULT;
@@ -920,22 +921,23 @@ fb_cursor(struct fb_info *info, struct f
 		    (cursor.image.width != info->cursor.image.width))
 			cursor.set |= FB_CUR_SETSIZE;

-		cursor.image.data = kmalloc(size, GFP_KERNEL);
-		if (!cursor.image.data)
+		image_data = kmalloc(size, GFP_KERNEL);
+		if (!image_data)
 			return -ENOMEM;

 		cursor.mask = kmalloc(size, GFP_KERNEL);
 		if (!cursor.mask) {
-			kfree(cursor.image.data);
+			kfree(image_data);
 			return -ENOMEM;
 		}

-		if (copy_from_user(cursor.image.data, sprite->image.data, size) ||
+		if (copy_from_user(image_data, sprite->image.data, size) ||
 		    copy_from_user(cursor.mask, sprite->mask, size)) {
-			kfree(cursor.image.data);
+			kfree(image_data);
 			kfree(cursor.mask);
 			return -EFAULT;
 		}
+		cursor.image.data = image_data;
 	}
 	info->cursor.set = cursor.set;
 	info->cursor.rop = cursor.rop;


Notes:
I've only done compile testing of the first (simple cast) patch.
The second patch I've compile and boot tested and it seems to be OK.
If anyone on linux-fbdev-devel@lists.sourceforge.net want reply to this,
then please CC me as I'm not subscribed to that specific list.


--
Jesper Juhl <juhl-lkml@dif.dk>


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
