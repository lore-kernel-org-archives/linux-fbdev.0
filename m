From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 10/10] ps3: ps3av/fb defconfig updates
Date: Tue, 30 Jan 2007 18:03:29 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701301803100.29487@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBwPL-000859-08 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 09:04:35 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBwPA-0000cz-Rx
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 09:04:25 -0800
In-Reply-To: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

PS3: defconfig updates for ps3av and ps3fb

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/powerpc/configs/ps3_defconfig |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletion(-)

--- ps3-linux-2.6.20-rc6.orig/arch/powerpc/configs/ps3_defconfig
+++ ps3-linux-2.6.20-rc6/arch/powerpc/configs/ps3_defconfig
@@ -163,6 +163,7 @@ CONFIG_PS3_HTAB_SIZE=20
 # CONFIG_PS3_DYNAMIC_DMA is not set
 CONFIG_PS3_USE_LPAR_ADDR=y
 CONFIG_PS3_VUART=y
+CONFIG_PS3_PS3AV=y
 
 #
 # Kernel options
@@ -611,14 +612,40 @@ CONFIG_GEN_RTC=y
 # Graphics support
 #
 # CONFIG_FIRMWARE_EDID is not set
-# CONFIG_FB is not set
+CONFIG_FB=y
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+# CONFIG_FB_OF is not set
+# CONFIG_FB_VGA16 is not set
+# CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_IBM_GXT4500 is not set
+CONFIG_FB_PS3=y
+CONFIG_FB_PS3_DEFAULT_SIZE_M=18
+# CONFIG_FB_VIRTUAL is not set
 
 #
 # Console display driver support
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+
+#
+# Logo configuration
+#
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
