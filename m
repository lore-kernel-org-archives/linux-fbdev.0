From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/5] backlight: Fix Kconfig dependency
Date: Sun, 28 May 2006 08:42:07 +0800
Message-ID: <4478F1DF.9080804@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fk9NV-0001qQ-Mi
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 17:43:33 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fk9NV-0008KM-Jl
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 17:43:33 -0700
Received: by py-out-1112.google.com with SMTP id b29so208814pya
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 May 2006 17:43:33 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Zabolotny <zap@homelink.ru>, Richard Purdie <rpurdie@rpsys.net>

CONFIG_FB = m and CONFIG_{BACKLIGHT:LCD}_CLASS_DEVICE = y is possible
resulting in link errors. Fix by making backlight and lcd class also
depend on FB

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/backlight/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 02f1529..022f9d3 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -10,7 +10,7 @@ menuconfig BACKLIGHT_LCD_SUPPORT
 
 config BACKLIGHT_CLASS_DEVICE
         tristate "Lowlevel Backlight controls"
-	depends on BACKLIGHT_LCD_SUPPORT
+	depends on BACKLIGHT_LCD_SUPPORT && FB
 	default m
 	help
 	  This framework adds support for low-level control of the LCD
@@ -26,7 +26,7 @@ config BACKLIGHT_DEVICE
 
 config LCD_CLASS_DEVICE
         tristate "Lowlevel LCD controls"
-	depends on BACKLIGHT_LCD_SUPPORT
+	depends on BACKLIGHT_LCD_SUPPORT && FB
 	default m
 	help
 	  This framework adds support for low-level control of LCD.



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
