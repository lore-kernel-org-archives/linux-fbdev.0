From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 03/11] pvr2fb: Consolidated cleanup of
	pvr2fb.c
Date: Wed, 01 Aug 2007 15:36:12 +0800
Message-ID: <46B037EC.3050005@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IG9NU-0003F2-NC for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 01:16:20 -0700
Received: from rv-out-0910.google.com ([209.85.198.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IG9NT-0000Mg-CN
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 01:16:20 -0700
Received: by rv-out-0910.google.com with SMTP id g11so308468rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 01 Aug 2007 01:16:19 -0700 (PDT)
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
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, Paul Mundt <lethal@linux-sh.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Adrian McMenamin <adrian@mcmen.demon.co.uk>

- better handling of the pvr2 registers based on more up to date information.

Testing shows that it seems to work pretty well at 16bpp, 24bpp and
32bpp - including proper rendering of the boot logo at all levels
(previously this was a bit broken even at 16bpp) and giving white
against black text. Really detailed testing (eg with X11) requires
support for the maple bus - which isn't (currently - next project
assuming this is okay) available, but I have no reason to think this
is broken.

Signed-off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pvr2fb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
index a72921b..7d6c298 100644
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -94,6 +94,7 @@ #define DISP_BRDRVERT (DISP_BASE + 0xdc)
 #define DISP_DIWCONF (DISP_BASE + 0xe8)
 #define DISP_DIWHSTRT (DISP_BASE + 0xec)
 #define DISP_DIWVSTRT (DISP_BASE + 0xf0)
+#define DISP_PIXDEPTH (DISP_BASE + 0x108)
 
 /* Pixel clocks, one for TV output, doubled for VGA output */
 #define TV_CLK 74239
@@ -600,6 +601,7 @@ static void pvr2_init_display(struct fb_
 
 	/* bits per pixel */
 	fb_writel(fb_readl(DISP_DIWMODE) | (--bytesperpixel << 2), DISP_DIWMODE);
+	fb_writel(bytesperpixel << 2, DISP_PIXDEPTH);
 
 	/* video enable, color sync, interlace,
 	 * hsync and vsync polarity (currently unused) */
@@ -808,6 +810,8 @@ static int __devinit pvr2fb_common_init(
 
 	if (register_framebuffer(fb_info) < 0)
 		goto out_err;
+	/*Must write PIXDEPTH to register before anything is displayed - so force init */
+	pvr2_init_display(fb_info);
 
 	modememused = get_line_length(fb_info->var.xres_virtual,
 				      fb_info->var.bits_per_pixel);


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
