From: Antonino Daplas <adaplas@gmail.com>
Subject: [PATCH 12/15] s3fb: do not allow incorrect
	pixclock settings
Date: Sat, 13 Oct 2007 08:31:17 +0800
Message-ID: <471011D5.20501@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgVTD-0008Ds-L2 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 18:07:11 -0700
Received: from rv-out-0910.google.com ([209.85.198.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IgUyo-0002xt-5J
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 17:35:46 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3588679rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 12 Oct 2007 17:35:46 -0700 (PDT)
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
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds check if selected pixclock
is valid (is in the PLL range).

Previously, if the pixclock could not be set,
the new mode resolution was set but pixclock
was not set which led to incorrect timings sent
to monitor.

[adaplas]
Fixed a few misplaced curly braces.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/s3fb.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index a96ac43..7d53bc2 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -400,6 +400,7 @@ static int s3fb_check_var(struct fb_var_
 {
 	struct s3fb_info *par = info->par;
 	int rv, mem, step;
+	u16 m, n, r;
 
 	/* Find appropriate format */
 	rv = svga_match_format (s3fb_formats, var, NULL);
@@ -427,20 +428,26 @@ static int s3fb_check_var(struct fb_var_
 
 	/* Check whether have enough memory */
 	mem = ((var->bits_per_pixel * var->xres_virtual) >> 3) * var->yres_virtual;
-	if (mem > info->screen_size)
-	{
+	if (mem > info->screen_size) {
 		printk(KERN_ERR "fb%d: not enough framebuffer memory (%d kB requested , %d kB available)\n",
 			info->node, mem >> 10, (unsigned int) (info->screen_size >> 10));
 		return -EINVAL;
 	}
 
 	rv = svga_check_timings (&s3_timing_regs, var, info->node);
-	if (rv < 0)
-	{
+	if (rv < 0) {
 		printk(KERN_ERR "fb%d: invalid timings requested\n", info->node);
 		return rv;
 	}
 
+	rv = svga_compute_pll(&s3_pll, PICOS2KHZ(var->pixclock), &m, &n, &r,
+				info->node);
+	if (rv < 0) {
+		printk(KERN_ERR "fb%d: invalid pixclock value requested\n",
+			info->node);
+		return rv;
+	}
+
 	return 0;
 }
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
