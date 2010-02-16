From: James Simmons <jsimmons@infradead.org>
Date: Tue, 16 Feb 2010 18:19:21 +0000
Subject: radeonfb backlight fix
Message-Id: <alpine.LFD.2.00.1002161817570.23940@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


A simple patch to allow radeonfb to compile if the backlight option is 
set.

diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 6c37e8e..2c01726 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -276,7 +276,7 @@ static int nomtrr = 0;
 #endif
 static int force_sleep;
 static int ignore_devlist;
-#ifdef CONFIG_PMAC_BACKLIGHT
+#ifdef CONFIG_FB_RADEON_BACKLIGHT
 static int backlight = 1;
 #else
 static int backlight = 0;
