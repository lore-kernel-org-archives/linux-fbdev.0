From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] font selection logic
Date: Sat, 28 Dec 2002 00:50:54 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0212280047280.17067-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18S4HK-0005yo-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 27 Dec 2002 15:52:35 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


Doesn't this look better?

--- linux-2.5.53/drivers/video/console/Makefile	Fri Dec 20 11:42:38 2002
+++ linux-geert-2.5.53/drivers/video/console/Makefile	Sat Dec 28 00:51:12 2002
@@ -10,30 +10,16 @@
 # Font handling
 font-objs := fonts.o
 
-ifeq ($(CONFIG_FONT_SUN8x16),y)
-	font-objs += font_sun8x16.o
-endif
-ifeq ($(CONFIG_FONT_SUN12x22),y)
-	font-objs += font_sun12x22.o
-endif	
-ifeq ($(CONFIG_FONT_8x8),y)
-	font-objs += font_8x8.o
-endif	
-ifeq ($(CONFIG_FONT_8x16),y)
-	font-objs += font_8x16.o
-endif	
-ifeq ($(CONFIG_FONT_6x11),y)
-	font-objs += font_6x11.o
-endif	
-ifeq ($(CONFIG_FONT_PEARL_8x8),y)
-	font-objs += font_pearl_8x8.o
-endif	
-ifeq ($(CONFIG_FONT_ACORN_8x8),y)
-	font-objs += font_acorn_8x8.o
-endif	
-ifeq ($(CONFIG_FONT_MINI_4x6),y)
-	font-objs += font_mini_4x6.o
-endif	
+font-objs-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
+font-objs-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
+font-objs-$(CONFIG_FONT_8x8)       += font_8x8.o
+font-objs-$(CONFIG_FONT_8x16)      += font_8x16.o
+font-objs-$(CONFIG_FONT_6x11)      += font_6x11.o
+font-objs-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
+font-objs-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
+font-objs-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
+
+font-objs += $(font-objs-y)
 
 # Each configuration option enables a list of files.
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
