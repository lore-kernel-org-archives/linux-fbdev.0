From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH] au1100fb: convert to C99 inits.
Date: Mon, 14 Mar 2005 16:02:20 -0800
Message-ID: <20050314160220.1925b5c6.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAzaX-0002Zu-QZ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 16:07:09 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DAzaW-0000YC-A9
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 16:07:09 -0800
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
To: adaplas@pol.net, akpm <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

(resend)

au1100: use C99 struct init.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/au1100fb.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff -Naurp ./drivers/video/au1100fb.c~au1100_c99 ./drivers/video/au1100fb.c
--- ./drivers/video/au1100fb.c~au1100_c99	2005-02-21 15:21:17.447431120 -0800
+++ ./drivers/video/au1100fb.c	2005-02-21 15:40:03.901184120 -0800
@@ -111,15 +111,15 @@ static int au1100fb_ioctl(struct inode *
 void au1100_nocursor(struct display *p, int mode, int xx, int yy){};
 
 static struct fb_ops au1100fb_ops = {
-	owner:		THIS_MODULE,
-	fb_get_fix:	fbgen_get_fix,
-	fb_get_var:	fbgen_get_var,
-	fb_set_var:	fbgen_set_var,
-	fb_get_cmap:	fbgen_get_cmap,
-	fb_set_cmap:	fbgen_set_cmap,
-	fb_pan_display: fbgen_pan_display,
-        fb_ioctl:       au1100fb_ioctl,
-	fb_mmap:        au1100fb_mmap,
+	.owner		= THIS_MODULE,
+	.fb_get_fix	= fbgen_get_fix,
+	.fb_get_var	= fbgen_get_var,
+	.fb_set_var	= fbgen_set_var,
+	.fb_get_cmap	= fbgen_get_cmap,
+	.fb_set_cmap	= fbgen_set_cmap,
+	.fb_pan_display	= fbgen_pan_display,
+        .fb_ioctl	= au1100fb_ioctl,
+	.fb_mmap	= au1100fb_mmap,
 };
 
 static void au1100_detect(void)


---


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
