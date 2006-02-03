From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] from drivers/video/Kconfig: remove unused BUS_I2C option
Date: Fri, 3 Feb 2006 22:17:28 +0100
Message-ID: <20060203211728.GQ4408@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1945972AbWBCVRa@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>

The BUS_I2C option is neither available (since there is no VISWS option 
in the kernel) nor does it have any effect - so why not remove it?

Based on a report by Jean-Luc Leger <reiga@dspnet.fr.eu.org>.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 11 Jan 2006

--- linux-2.6.15-mm2-full/drivers/video/Kconfig.old	2006-01-11 01:23:37.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/video/Kconfig	2006-01-11 01:23:49.000000000 +0100
@@ -525,11 +525,6 @@
 	  This is the amount of memory reserved for the framebuffer,
 	  which can be any value between 1MB and 8MB.
 
-config BUS_I2C
-	bool
-	depends on (FB = y) && VISWS
-	default y
-
 config FB_SUN3
 	bool "Sun3 framebuffer support"
 	depends on (FB = y) && (SUN3 || SUN3X) && BROKEN
