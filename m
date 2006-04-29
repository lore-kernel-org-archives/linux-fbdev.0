From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/12] atyfb: Remove unneeded calls to wait_for_idle
Date: Sat, 29 Apr 2006 08:32:34 +0800
Message-ID: <4452B422.2080907@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZdhv-0003kp-PB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:11 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZdhv-00016I-KJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:11 -0700
Received: from xproxy.gmail.com ([66.249.82.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZdhv-0006gw-7Z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 17:53:11 -0700
Received: by xproxy.gmail.com with SMTP id t4so1463996wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Apr 2006 17:53:10 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Alexander Kern <alex.kern@gmx.de>, =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>

The drawing functions of atyfb is unecessary syncing the GPU which is affecting
performance.  Remove the calls, any direct access by fbcon to the framebuffer
will always be preceeded by a call to atyfb_sync().

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/mach64_accel.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/video/aty/mach64_accel.c b/drivers/video/aty/mach64_accel.c
index c98f4a4..1490e5e 100644
--- a/drivers/video/aty/mach64_accel.c
+++ b/drivers/video/aty/mach64_accel.c
@@ -200,8 +200,6 @@ void atyfb_copyarea(struct fb_info *info
 	if (!area->width || !area->height)
 		return;
 	if (!par->accel_flags) {
-		if (par->blitter_may_be_busy)
-			wait_for_idle(par);
 		cfb_copyarea(info, area);
 		return;
 	}
@@ -248,8 +246,6 @@ void atyfb_fillrect(struct fb_info *info
 	if (!rect->width || !rect->height)
 		return;
 	if (!par->accel_flags) {
-		if (par->blitter_may_be_busy)
-			wait_for_idle(par);
 		cfb_fillrect(info, rect);
 		return;
 	}
@@ -288,14 +284,10 @@ void atyfb_imageblit(struct fb_info *inf
 		return;
 	if (!par->accel_flags ||
 	    (image->depth != 1 && info->var.bits_per_pixel != image->depth)) {
-		if (par->blitter_may_be_busy)
-			wait_for_idle(par);
-
 		cfb_imageblit(info, image);
 		return;
 	}
 
-	wait_for_idle(par);
 	pix_width = pix_width_save = aty_ld_le32(DP_PIX_WIDTH, par);
 	host_cntl = aty_ld_le32(HOST_CNTL, par) | HOST_BYTE_ALIGN;
 
@@ -425,8 +417,6 @@ void atyfb_imageblit(struct fb_info *inf
 		}
 	}
 
-	wait_for_idle(par);
-
 	/* restore pix_width */
 	wait_for_fifo(1, par);
 	aty_st_le32(DP_PIX_WIDTH, pix_width_save, par);



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
