From: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: [PATCH] Framebuffer mode required for PowerBook Titanium
Date: Sun, 6 Nov 2005 00:49:39 +0100
Message-ID: <20051105234938.GA18608@hansmi.ch>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932213AbVKEXtq@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

This patch adds the framebuffer mode required for an Apple PowerBook G4
Titanium.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

---
--- linux-2.6.14/drivers/video/modedb.c.orig	2005-11-05 22:29:02.000000000 +0100
+++ linux-2.6.14/drivers/video/modedb.c	2005-11-05 22:31:15.000000000 +0100
@@ -251,6 +251,10 @@ static const struct fb_videomode modedb[
 	NULL, 60, 1920, 1200, 5177, 128, 336, 1, 38, 208, 3,
 	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	FB_VMODE_NONINTERLACED
+    }, {
+	/* 1152x768, 60 Hz, PowerBook G4 Titanium I and II */
+	"mac21", 60, 1152, 768, 15386, 158, 26, 29, 3, 136, 6,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
     },
 };
