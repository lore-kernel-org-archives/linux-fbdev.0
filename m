From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.30] nvidiafb: fix missing space in log message
Date: Tue, 16 Jun 2009 17:51:14 +0200
Message-ID: <18999.49010.127368.554600@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758927AbZFPPv1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On bootup nvidiafb prints the following on my Apple G5:

	nvidiafb: CRTC 1appears to have a CRT attached

There should be a space between the '1' and the 'appears'.

Fix: add the space

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

diff -rupN linux-2.6.30/drivers/video/nvidia/nv_setup.c linux-2.6.30.nvidiafb-logmsg-missing-space/drivers/video/nvidia/nv_setup.c
--- linux-2.6.30/drivers/video/nvidia/nv_setup.c	2009-06-10 12:00:46.000000000 +0200
+++ linux-2.6.30.nvidiafb-logmsg-missing-space/drivers/video/nvidia/nv_setup.c	2009-06-16 17:41:21.000000000 +0200
@@ -543,7 +543,7 @@ int NVCommonSetup(struct fb_info *info)
 		} else if (analog_on_B) {
 			CRTCnumber = outputBfromCRTC;
 			FlatPanel = 0;
-			printk("nvidiafb: CRTC %i"
+			printk("nvidiafb: CRTC %i "
 			       "appears to have a "
 			       "CRT attached\n", CRTCnumber);
 		} else if (slaved_on_A) {
