From: Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH] fb: nvidiafb: Try harder at initial
	mode setting.
Date: Wed, 9 Jan 2008 19:51:55 +0900
Message-ID: <20080109105155.GA534@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCYXj-00005e-N7 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 02:52:20 -0800
Received: from pip10.gyao.ne.jp ([61.122.117.248] helo=mx.gate01.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JCYXi-000568-8I
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 02:52:19 -0800
Content-Disposition: inline
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
To: adaplas@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

The current nvidiafb_check_var() simply bails out if the selected mode is
out of range of the panel dimensions. A good question would be why the
bogus mode is being selected in the first place -- the panel dimensions
that are read back are certainly bogus, but alas, I have no idea where to
even begin looking at the i2c/EDID/DDC mess:

nvidiafb: Device ID: 10de0165
nvidiafb: CRTC0 analog not found
nvidiafb: CRTC1 analog not found
nvidiafb: EDID found from BUS1
nvidiafb: CRTC 0 is currently programmed for DFP
nvidiafb: Using DFP on CRTC 0
nvidiafb: Panel size is 1280 x 1024
nvidiafb: Panel is TMDS
nvidiafb: unable to setup MTRR
nvidiafb: Flat panel dithering disabled
nvidiafb: PCI nVidia NV16 framebuffer (64MB @ 0xC0000000)

In my .config I presently have:

CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=y
CONFIG_FB_NVIDIA_I2C=y

I've not tried fiddling with these options, as I haven't the vaguest idea
what I should be looking at.

As a workaround, simply groveling for a new mode based on the probed
dimensions seems to work ok. While it would be nice to debug this further
and sort out why the panel information is bogus, I think it's still worth
retrying the mode based on the panel information at hand as a last-ditch
effort, rather than simply bailing out completely.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 drivers/video/nvidia/nvidia.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 30e14eb..74517b1 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -849,9 +849,27 @@ static int nvidiafb_check_var(struct fb_var_screeninfo *var,
 	if (!mode_valid && info->monspecs.modedb_len)
 		return -EINVAL;
 
+	/*
+	 * If we're on a flat panel, check if the mode is outside of the
+	 * panel dimensions. If so, cap it and try for the next best mode
+	 * before bailing out.
+	 */
 	if (par->fpWidth && par->fpHeight && (par->fpWidth < var->xres ||
-					      par->fpHeight < var->yres))
-		return -EINVAL;
+					      par->fpHeight < var->yres)) {
+		const struct fb_videomode *mode;
+
+		var->xres = par->fpWidth;
+		var->yres = par->fpHeight;
+
+		mode = fb_find_best_mode(var, &info->modelist);
+		if (!mode) {
+			printk(KERN_ERR PFX "mode out of range of flat "
+			       "panel dimensions\n");
+			return -EINVAL;
+		}
+
+		fb_videomode_to_var(var, mode);
+	}
 
 	if (var->yres_virtual < var->yres)
 		var->yres_virtual = var->yres;

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
