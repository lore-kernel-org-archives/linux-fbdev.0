From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 04/18] savagefb: Trim savagefb_pan_display
Date: Sat, 10 Dec 2005 14:10:19 +0800
Message-ID: <439A714B.7020109@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eky4A-0002oF-Qv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:18:42 -0800
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eky4A-00040H-IH
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:18:42 -0800
Received: by zproxy.gmail.com with SMTP id r28so1046970nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 22:18:41 -0800 (PST)
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

Remove error checking and updating from savagefb_pan_display. This is
guaranteed to be done by the core layer.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/savage/savagefb_driver.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index baddd2b..ab727ea 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -1382,28 +1382,8 @@ static int savagefb_pan_display (struct 
 				 struct fb_info           *info)
 {
 	struct savagefb_par *par = info->par;
-	u_int y_bottom;
-
-	y_bottom = var->yoffset;
-
-	if (!(var->vmode & FB_VMODE_YWRAP))
-		y_bottom += var->yres;
-
-	if (var->xoffset > (var->xres_virtual - var->xres))
-		return -EINVAL;
-	if (y_bottom > info->var.yres_virtual)
-		return -EINVAL;
 
 	savagefb_update_start (par, var);
-
-	info->var.xoffset = var->xoffset;
-	info->var.yoffset = var->yoffset;
-
-	if (var->vmode & FB_VMODE_YWRAP)
-		info->var.vmode |= FB_VMODE_YWRAP;
-	else
-		info->var.vmode &= ~FB_VMODE_YWRAP;
-
 	return 0;
 }
 




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
