From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/5] fbdev: Make BIOS EDID reading configurable
Date: Thu, 23 Feb 2006 20:00:02 +0800
Message-ID: <43FDA3C2.2010109@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCpyR-0005ZR-Tn
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Feb 2006 19:19:59 -0800
Received: from wproxy.gmail.com ([64.233.184.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FCpyR-0007oz-2G
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Feb 2006 19:19:59 -0800
Received: by wproxy.gmail.com with SMTP id i20so428049wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Feb 2006 19:19:58 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

DDC reading via the Video BIOS may take several tens of seconds with
some combination of display cards and monitors.

Make this option configurable and select only for drivers that need it.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 arch/i386/boot/video.S |    2 ++
 drivers/video/Kconfig  |   12 ++++++++++++
 drivers/video/fbmon.c  |    6 +++---
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/i386/boot/video.S b/arch/i386/boot/video.S
index 2ac40c8..0000a26 100644
--- a/arch/i386/boot/video.S
+++ b/arch/i386/boot/video.S
@@ -1924,6 +1924,7 @@ skip10:	movb	%ah, %al
 	ret
 
 store_edid:
+#ifdef CONFIG_FB_FIRMWARE_EDID
 	pushw	%es				# just save all registers
 	pushw	%ax
 	pushw	%bx
@@ -1954,6 +1955,7 @@ store_edid:
 	popw	%bx
 	popw	%ax
 	popw	%es
+#endif
 	ret
 
 # VIDEO_SELECT-only variables
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e31390a..87384d3 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -70,6 +70,18 @@ config FB_MACMODES
        depends on FB
        default n
 
+config FB_FIRMWARE_EDID
+       bool "Enable firmware EDID"
+       depends on FB
+       default n
+       ---help---
+         This enables access to the EDID transferred from the firmware.
+	 On the i386, this is from the Video BIOS. Enable this if DDC/I2C
+	 transfers do not work for your driver and if you are using
+	 nvidiafb, i810fb or savagefb.
+
+	 If unsure, say N.
+
 config FB_MODE_HELPERS
         bool "Enable Video Mode Handling Helpers"
         depends on FB
diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 7c74e73..53beeb4 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -1281,7 +1281,7 @@ int fb_validate_mode(const struct fb_var
 		-EINVAL : 0;
 }
 
-#if defined(__i386__)
+#if defined(CONFIG_FB_FIRMWARE_EDID) && defined(__i386__)
 #include <linux/pci.h>
 
 /*
@@ -1311,11 +1311,11 @@ const unsigned char *fb_firmware_edid(st
 {
 	return NULL;
 }
-#endif /* _i386_ */
+#endif
+EXPORT_SYMBOL(fb_firmware_edid);
 
 EXPORT_SYMBOL(fb_parse_edid);
 EXPORT_SYMBOL(fb_edid_to_monspecs);
-EXPORT_SYMBOL(fb_firmware_edid);
 EXPORT_SYMBOL(fb_get_mode);
 EXPORT_SYMBOL(fb_validate_mode);
 EXPORT_SYMBOL(fb_destroy_modedb);



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
