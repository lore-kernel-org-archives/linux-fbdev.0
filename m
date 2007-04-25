From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 33/41] fbcon: Check if the character
	count can be handled
Date: Wed, 25 Apr 2007 15:13:28 +0800
Message-ID: <462EFF98.4090203@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcCG-0001ab-0x for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:45:52 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgcCF-0007Zm-NY
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:45:52 -0700
Received: by py-out-1112.google.com with SMTP id a29so117558pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:45:51 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Ondrej Zajicek <santiago@mail.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fontmaps can be 256 or 512 in length. The only driver that can do tileblitting
can only handle 256 characters.  Check for this when setting the font.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/console/fbcon.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index c71a88d..6fc3501 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -685,6 +685,17 @@ static void set_blitting_type(struct vc_
 		fbcon_set_bitops(ops);
 	}
 }
+
+static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
+{
+	int err = 0;
+
+	if (info->flags & FBINFO_MISC_TILEBLITTING &&
+	    info->tileops->fb_get_tilemax(info) < charcount)
+		err = 1;
+
+	return err;
+}
 #else
 static void set_blitting_type(struct vc_data *vc, struct fb_info *info)
 {
@@ -695,6 +706,12 @@ static void set_blitting_type(struct vc_
 	fbcon_set_rotation(info);
 	fbcon_set_bitops(ops);
 }
+
+static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
+{
+	return 0;
+}
+
 #endif /* CONFIG_MISC_TILEBLITTING */
 
 
@@ -2518,6 +2535,10 @@ static int fbcon_set_font(struct vc_data
 	    !(info->pixmap.blit_y & (1 << (font->height - 1))))
 		return -EINVAL;
 
+	/* Make sure driver can handle the font length */
+	if (fbcon_invalid_charcount(info, charcount))
+		return -EINVAL;
+
 	size = h * pitch * charcount;
 
 	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
