From: Andrew Zabolotny <zap@homelink.ru>
Subject: [Bugme-new] [Bug 4047] New: kerenl failt to kompile
Date: Mon, 17 Jan 2005 00:41:41 +0300
Message-ID: <20050117004141.2dcb1e0f.zap@homelink.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__17_Jan_2005_00_41_41_+0300_HMAW3btY=X=Y1MVQ"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CqI9d-0000xp-F2
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 Jan 2005 13:41:49 -0800
Received: from mail.homelink.ru ([81.9.33.123] helo=eltel.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CqI9b-0005jH-A6
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 Jan 2005 13:41:49 -0800
Received: from [217.170.93.9] (account zap@homelink.ru HELO zap.sh.nu)
  by eltel.net (CommuniGate Pro SMTP 4.2.8)
  with ESMTP-TLS id 24065888 for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Jan 2005 00:41:15 +0300
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
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--Multipart=_Mon__17_Jan_2005_00_41_41_+0300_HMAW3btY=X=Y1MVQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello!

> Date: Sun, 16 Jan 2005 03:14:57 -0800
> From: bugme-daemon@osdl.org
> To: bugme-new@lists.osdl.org
> Subject: [Bugme-new] [Bug 4047] New: kerenl failt to kompile
>
> http://bugme.osdl.org/show_bug.cgi?id=4047
>
>           Summary: kerenl failt to kompile
>    Kernel Version: 2.6.11-rc1-mm1
>            Status: NEW
>          Severity: blocking
>             Owner: jsimmons@infradead.org
>         Submitter: bug-track@fisher-privat.net
>
>
> Distribution:Debian Sarge
>
> Problem Description:
> LD      init/built-in.o
>  LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x9bfa): In function `lcd_device_register':
> : undefined reference to `fb_register_client'
Here's an obvious fix plus a minor enhancement.

-- 
Greetings,
   Andrew

--Multipart=_Mon__17_Jan_2005_00_41_41_+0300_HMAW3btY=X=Y1MVQ
Content-Type: text/x-patch;
 name="tiny-fix.diff"
Content-Disposition: attachment;
 filename="tiny-fix.diff"
Content-Transfer-Encoding: 7bit

Index: Kconfig
===================================================================
RCS file: /cvs/linux/kernel26/drivers/video/Kconfig,v
retrieving revision 1.37
diff -u -r1.37 Kconfig
--- Kconfig	2 Jan 2005 20:17:25 -0000	1.37
+++ Kconfig	16 Jan 2005 21:41:40 -0000
@@ -1168,7 +1168,7 @@
 	source "drivers/video/logo/Kconfig"
 endif
 
-if SYSFS
+if FB && SYSFS
 	source "drivers/video/backlight/Kconfig"
 endif
 
Index: backlight/Kconfig
===================================================================
RCS file: /cvs/linux/kernel26/drivers/video/backlight/Kconfig,v
retrieving revision 1.1
diff -u -r1.1 Kconfig
--- backlight/Kconfig	2 Jan 2005 20:17:25 -0000	1.1
+++ backlight/Kconfig	16 Jan 2005 21:41:40 -0000
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

--Multipart=_Mon__17_Jan_2005_00_41_41_+0300_HMAW3btY=X=Y1MVQ--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
