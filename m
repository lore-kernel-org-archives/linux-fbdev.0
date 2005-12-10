From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 06/18] vga16fb: Trim vga16fb_pan_display
Date: Sat, 10 Dec 2005 14:10:49 +0800
Message-ID: <439A7169.5090504@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eky4U-0002oq-OW
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:19:02 -0800
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eky4U-00040H-5J
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:19:02 -0800
Received: by zproxy.gmail.com with SMTP id r28so1046970nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 22:19:01 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Remove error checking and updating from vga16fb_pan_display.  This is
guaranteed to be done by the core layer.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/vga16fb.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 226ae8a..f3f16fd 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -705,15 +705,7 @@ static int vga16fb_setcolreg(unsigned re
 static int vga16fb_pan_display(struct fb_var_screeninfo *var,
 			       struct fb_info *info) 
 {
-	if (var->xoffset + info->var.xres > info->var.xres_virtual ||
-	    var->yoffset + info->var.yres > info->var.yres_virtual)
-		return -EINVAL;
-
 	vga16fb_pan_var(info, var);
-
-	info->var.xoffset = var->xoffset;
-	info->var.yoffset = var->yoffset;
-	info->var.vmode &= ~FB_VMODE_YWRAP;
 	return 0;
 }
 




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
