From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [PATCH 1/1: 2.6.15-rc6] Fix framebuffer console upside-down ywrap
 scrolling
Date: Tue, 20 Dec 2005 08:18:09 +0100
Message-ID: <43A7B031.6070609@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EobkM-0006Wt-Fp
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Dec 2005 23:17:18 -0800
Received: from mailout08.sul.t-online.com ([194.25.134.20])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EobkL-00029p-2A
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Dec 2005 23:17:18 -0800
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

Whenever ywrap scrolling is selected together with 180 degree
screen rotation, 2.6.15-rc6 and earlier versions are broken. 
fb_pan_display() expects non-negative yoffsets, but
ud_update_start() calls it with yoffsets down to -(yres - font height).
This patch transforms yoffset to the correct range 0 ... vyres-1.

Some obviously unneeded parentheses are removed, too.

Verified with cyblafb, should be applied before 2.6.15-final
because  it does fix the framebuffer rotation code introduced
early in the 2.6.15 release cycle.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>

diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/drivers/video/console/fbcon_ud.c linux/drivers/video/console/fbcon_ud.c
--- linuxorig/drivers/video/console/fbcon_ud.c	2005-12-15 10:34:06.000000000 +0100
+++ linux/drivers/video/console/fbcon_ud.c	2005-12-20 06:59:19.000000000 +0100
@@ -420,13 +420,15 @@ static void ud_cursor(struct vc_data *vc
 int ud_update_start(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
-	u32 xoffset, yoffset;
+	int xoffset, yoffset;
 	u32 vyres = GETVYRES(ops->p->scrollmode, info);
 	u32 vxres = GETVXRES(ops->p->scrollmode, info);
 	int err;
 
-	xoffset = (vxres - info->var.xres) - ops->var.xoffset;
-	yoffset = (vyres - info->var.yres) - ops->var.yoffset;
+	xoffset = vxres - info->var.xres - ops->var.xoffset;
+	yoffset = vyres - info->var.yres - ops->var.yoffset;
+	if (yoffset < 0)
+		yoffset += vyres;
 	ops->var.xoffset = xoffset;
 	ops->var.yoffset = yoffset;
 	err = fb_pan_display(info, &ops->var);




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
