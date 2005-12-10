From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 03/18] rivafb: Trim rivafb_pan_display
Date: Sat, 10 Dec 2005 14:10:02 +0800
Message-ID: <439A713A.70807@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eky3s-0002o5-A8
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:18:24 -0800
Received: from zproxy.gmail.com ([64.233.162.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eky3r-0003od-1H
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:18:24 -0800
Received: by zproxy.gmail.com with SMTP id z3so1046282nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 22:18:22 -0800 (PST)
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

Remove error checking and updating from rivafb_pan_display.  This is
guaranteed to be done by the core layer.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/riva/fbdev.c |   24 ------------------------
 1 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index dd7b2cc..6c19ab6 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -1209,32 +1209,8 @@ static int rivafb_pan_display(struct fb_
 	unsigned int base;
 
 	NVTRACE_ENTER();
-	if (var->xoffset > (var->xres_virtual - var->xres))
-		return -EINVAL;
-	if (var->yoffset > (var->yres_virtual - var->yres))
-		return -EINVAL;
-
-	if (var->vmode & FB_VMODE_YWRAP) {
-		if (var->yoffset < 0
-		    || var->yoffset >= info->var.yres_virtual
-		    || var->xoffset) return -EINVAL;
-	} else {
-		if (var->xoffset + info->var.xres > info->var.xres_virtual ||
-		    var->yoffset + info->var.yres > info->var.yres_virtual)
-			return -EINVAL;
-	}
-
 	base = var->yoffset * info->fix.line_length + var->xoffset;
-
 	par->riva.SetStartAddress(&par->riva, base);
-
-	info->var.xoffset = var->xoffset;
-	info->var.yoffset = var->yoffset;
-
-	if (var->vmode & FB_VMODE_YWRAP)
-		info->var.vmode |= FB_VMODE_YWRAP;
-	else
-		info->var.vmode &= ~FB_VMODE_YWRAP;
 	NVTRACE_LEAVE();
 	return 0;
 }




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
