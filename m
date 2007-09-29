From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 17/17] imxfb: fast read flag and
	nonstandard field configurable
Date: Sat, 29 Sep 2007 09:42:50 +0800
Message-ID: <46FDAD9A.40707@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbSPd-0008Hi-1D for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:50:37 -0700
Received: from wa-out-1112.google.com ([209.85.146.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbSPc-0003f6-Ps
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:50:37 -0700
Received: by wa-out-1112.google.com with SMTP id k22so5645170waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 28 Sep 2007 19:50:36 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

The i.MX frame-buffer read operation should be faster for all
configurations then drawing each individual character again
in response to scroll events.

The nonstandard fields allows to configure frame-buffer special
options flags for different display configurations by board
specific initialization code.

One of such specific options is reversed order of pixels
in each individual byte. i.MX frame-buffer seems to be designed
for big-endian use first. The byte order is correctly configured
for little-endian ordering, but if 1, 2 or 4 bits per pixel
are used, pixels ordering is incompatible to Linux generic
frame-buffer drawing functions.

The patch "Allow generic BitBLT functions to work with swapped
pixel order in bytes" introduces required functionality into
FBDEV core. The pixels ordering selection has to be enabled
at compile time CONFIG_FB_CFB_REV_PIXELS_IN_BYTE and for
each display configuration which requires it by flag
FB_NONSTD_REV_PIX_IN_B in "nonstd" field of info structure.

This patch provides way for board specific code to select
this option.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/imxfb.c            |    3 ++-
 include/asm-arm/arch-imx/imxfb.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 986ffa6..1160955 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -466,7 +466,7 @@ static int __init imxfb_init_fbinfo(stru
 	info->var.vmode	= FB_VMODE_NONINTERLACED;
 
 	info->fbops			= &imxfb_ops;
-	info->flags			= FBINFO_FLAG_DEFAULT;
+	info->flags			= FBINFO_FLAG_DEFAULT | FBINFO_READS_FAST;
 
 	fbi->rgb[RGB_16]		= &def_rgb_16;
 	fbi->rgb[RGB_8]			= &def_rgb_8;
@@ -479,6 +479,7 @@ static int __init imxfb_init_fbinfo(stru
 	info->var.yres_virtual		= inf->yres;
 	fbi->max_bpp			= inf->bpp;
 	info->var.bits_per_pixel	= inf->bpp;
+	info->var.nonstd		= inf->nonstd;
 	info->var.pixclock		= inf->pixclock;
 	info->var.hsync_len		= inf->hsync_len;
 	info->var.left_margin		= inf->left_margin;
diff --git a/include/asm-arm/arch-imx/imxfb.h b/include/asm-arm/arch-imx/imxfb.h
index 7dbc7bb..3ed9ec8 100644
--- a/include/asm-arm/arch-imx/imxfb.h
+++ b/include/asm-arm/arch-imx/imxfb.h
@@ -7,6 +7,7 @@ struct imxfb_mach_info {
 	u_short		xres;
 	u_short		yres;
 
+	u_int		nonstd;
 	u_char		bpp;
 	u_char		hsync_len;
 	u_char		left_margin;


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
