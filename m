From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: [RFC] fbcon: fb_set_par error handling
Date: Thu, 20 Aug 2009 11:59:56 +0000
Message-ID: <1250769597-14861-1-git-send-email-FlorianSchandinat@gmx.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754145AbZHTL53@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org


Hi all,

at the moment about half of the framebuffer drivers can return an error
code in fb_set_par. Until now it would be silently ignored by fbmem.c
and fbcon.c. The following patch fixes fbmem.c to pass it on but I have
no idea what the right behaviour in fbcon.c would look like.
Any comments?

The following files might return a non-zero value:
(false positives are possible as I scanned them only superficial)

drivers/gpu/drm/i915/intel_fb.c
drivers/gpu/drm/radeon/radeon_fb.c
drivers/video/matrox/matroxfb_crtc2.c
drivers/video/matrox/matroxfb_base.c
drivers/video/vt8623fb.c
drivers/video/vermilion/vermilion.c
drivers/video/uvesafb.c
drivers/video/neofb.c
drivers/video/aty/radeon_base.c
drivers/video/aty/atyfb_base.c
drivers/video/aty/aty128fb.c
drivers/video/platinumfb.c
drivers/video/intelfb/intelfbdrv.c
drivers/video/omap/omapfb_main.c
drivers/video/skeletonfb.c
drivers/video/s3fb.c
drivers/video/savage/savagefb_driver.c
drivers/video/gxt4500.c
drivers/video/tmiofb.c
drivers/video/pxafb.c
drivers/video/mbx/mbxfb.c
drivers/video/sis/sis_main.c
drivers/video/mx3fb.c
drivers/video/arkfb.c
drivers/video/fsl-diu-fb.c
drivers/video/valkyriefb.c
drivers/video/pm2fb.c
drivers/video/sstfb.c
drivers/video/imsttfb.c
drivers/video/carminefb.c
drivers/video/riva/fbdev.c
drivers/video/sh7760fb.c
drivers/video/sm501fb.c
drivers/video/ps3fb.c
drivers/video/controlfb.c
