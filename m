From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 10/20] s3c2410fb: make use of
	default_display settings
Date: Sun, 26 Aug 2007 22:03:59 +0800
Message-ID: <46D1884F.3090400@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPJ1t-0005CA-N6 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:23:53 -0700
Received: from nz-out-0506.google.com ([64.233.162.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPJ1t-00088d-BK
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:23:53 -0700
Received: by nz-out-0506.google.com with SMTP id f1so2918589nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 26 Aug 2007 07:23:53 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch changes mode selection to always prefer default
mode if possible and always honor type of display
set by default mode settings.

This patch is required in case the same display modes
were defined for different panels (e.g. STN and TFT).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/s3c2410fb.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index b2ba7a0..98da79c 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -172,19 +172,28 @@ static int s3c2410fb_check_var(struct fb
 	struct s3c2410fb_info *fbi = info->par;
 	struct s3c2410fb_mach_info *mach_info = fbi->dev->platform_data;
 	struct s3c2410fb_display *display = NULL;
+	struct s3c2410fb_display *default_display = mach_info->displays +
+						    mach_info->default_display;
+	int type = default_display->type;
 	unsigned i;
 
 	dprintk("check_var(var=%p, info=%p)\n", var, info);
 
 	/* validate x/y resolution */
-
-	for (i = 0; i < mach_info->num_displays; i++)
-		if (var->yres == mach_info->displays[i].yres &&
-		    var->xres == mach_info->displays[i].xres &&
-		    var->bits_per_pixel == mach_info->displays[i].bpp) {
-			display = mach_info->displays + i;
-			break;
-		}
+	/* choose default mode if possible */
+	if (var->yres == default_display->yres &&
+	    var->xres == default_display->xres &&
+	    var->bits_per_pixel == default_display->bpp)
+		display = default_display;
+	else
+		for (i = 0; i < mach_info->num_displays; i++)
+			if (type == mach_info->displays[i].type &&
+			    var->yres == mach_info->displays[i].yres &&
+			    var->xres == mach_info->displays[i].xres &&
+			    var->bits_per_pixel == mach_info->displays[i].bpp) {
+				display = mach_info->displays + i;
+				break;
+			}
 
 	if (!display) {
 		dprintk("wrong resolution or depth %dx%d at %d bpp\n",


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
