From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 02/18] fbdev: Pan display fixes
Date: Sat, 10 Dec 2005 14:09:42 +0800
Message-ID: <439A7126.7010107@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eky3i-0002nt-Om
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:18:14 -0800
Received: from zproxy.gmail.com ([64.233.162.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eky3i-0005h5-FV
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:18:14 -0800
Received: by zproxy.gmail.com with SMTP id 40so1075086nzk
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 22:18:13 -0800 (PST)
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

- Fix fb_pan_display rejecting yoffsets that are valid if panning mode
  is ywrap.
- Add more robust error checking in fb_pan_display specially since this
  function is accessible by userland apps.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbmem.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 6240aed..10dfdf0 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -722,14 +722,30 @@ static void try_to_load(int fb)
 int
 fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
 {
+	struct fb_fix_screeninfo *fix = &info->fix;
         int xoffset = var->xoffset;
         int yoffset = var->yoffset;
-        int err;
+        int err = 0, yres = info->var.yres;
+
+	if (var->yoffset > 0) {
+		if (var->vmode & FB_VMODE_YWRAP) {
+			if (!fix->ywrapstep || (var->yoffset % fix->ywrapstep))
+				err = -EINVAL;
+			else
+				yres = 0;
+		} else if (!fix->ypanstep || (var->yoffset % fix->ypanstep))
+			err = -EINVAL;
+	}
+
+	if (var->xoffset > 0 && (!fix->xpanstep ||
+				 (var->xoffset % fix->xpanstep)))
+		err = -EINVAL;
+
+        if (err || !info->fbops->fb_pan_display || xoffset < 0 ||
+	    yoffset < 0 || var->yoffset + yres > info->var.yres_virtual ||
+	    var->xoffset + info->var.xres > info->var.xres_virtual)
+		return -EINVAL;
 
-        if (xoffset < 0 || yoffset < 0 || !info->fbops->fb_pan_display ||
-            xoffset + info->var.xres > info->var.xres_virtual ||
-            yoffset + info->var.yres > info->var.yres_virtual)
-                return -EINVAL;
 	if ((err = info->fbops->fb_pan_display(var, info)))
 		return err;
         info->var.xoffset = var->xoffset;




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
