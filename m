From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 5/6] backlight: Fix compile error if CONFIG_FB is unset
Date: Tue, 18 Jan 2005 05:41:21 +0800
Message-ID: <200501180541.21349.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cqecx-00037J-5q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Jan 2005 13:41:35 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cqect-000704-JF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Jan 2005 13:41:35 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 3BB3B1348F7C
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Jan 2005 21:41:17 +0000 (UTC)
Content-Disposition: inline
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Zabolotny <zap@homelink.ru>

   LD      init/built-in.o
    LD      .tmp_vmlinux1
  drivers/built-in.o(.text+0x9bfa): In function `lcd_device_register':
  : undefined reference to `fb_register_client'
  drivers/built-in.o(.text+0x9ce3): In function `lcd_device_unregister':
  : undefined reference to `fb_unregister_client'
  drivers/built-in.o(.text+0xa16a): In function `backlight_device_register':
  : undefined reference to `fb_register_client'
  drivers/built-in.o(.text+0xa253): In function `backlight_device_unregister':
  : undefined reference to `fb_unregister_client'
  make: *** [.tmp_vmlinux1] Error 1

  Fix from Andrew Zabolotny <zap@homelink.ru>

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Kconfig           |    2 +-
 backlight/Kconfig |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2005-01-15 04:25:56 +08:00
+++ b/drivers/video/Kconfig	2005-01-18 05:04:55 +08:00
@@ -1107,7 +1107,7 @@
 	source "drivers/video/logo/Kconfig"
 endif
 
-if SYSFS
+if FB && SYSFS
 	source "drivers/video/backlight/Kconfig"
 endif
 
diff -Nru a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
--- a/drivers/video/backlight/Kconfig	2005-01-15 04:10:38 +08:00
+++ b/drivers/video/backlight/Kconfig	2005-01-18 05:04:55 +08:00
@@ -11,6 +11,7 @@
 config BACKLIGHT_CLASS_DEVICE
         tristate "Lowlevel Backlight controls"
 	depends on BACKLIGHT_LCD_SUPPORT
+	default m
 	help
 	  This framework adds support for low-level control of the LCD
           backlight. This includes support for brightness and power.
@@ -26,6 +27,7 @@
 config LCD_CLASS_DEVICE
         tristate "Lowlevel LCD controls"
 	depends on BACKLIGHT_LCD_SUPPORT
+	default m
 	help
 	  This framework adds support for low-level control of LCD.
 	  Some framebuffer devices connect to platform-specific LCD modules




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
