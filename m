From: Alex Bennee <kernel-hacker@bennee.com>
Subject: [PATCH] Export fbcon_font functions
Date: 20 Aug 2003 11:22:22 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <11205.5462239825$1061380570@news.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from host81-152-26-251.range81-152.btcentralplus.com ([81.152.26.251] helo=cambridge.braddahead)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19pQUr-00031y-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 20 Aug 2003 03:47:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by cambridge.braddahead (Postfix) with ESMTP id E92C01C1E2
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 20 Aug 2003 11:22:22 +0100 (BST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

I've added these exports as modulerised console drivers need to have
some way of getting the fonts they need (and it seemed cleane than
exporting all the actualy font defs themselves).

diff -ru linux-2.4.21.ref/drivers/video/fonts.c
linux-2.4.21/drivers/video/fonts.c
--- linux-2.4.21.ref/drivers/video/fonts.c	2001-03-03 02:38:39.000000000
+0000
+++ linux-2.4.21/drivers/video/fonts.c	2003-08-19 10:42:54.000000000
+0100
@@ -20,6 +20,7 @@
 #include <asm/setup.h>
 #endif
 #include <video/font.h>
+#include <linux/module.h>	/* EXPORT_SYMBOL def */
 
 #define NO_FONTS
 
@@ -86,6 +87,7 @@
    return NULL;
 }
 
+EXPORT_SYMBOL(fbcon_find_font);
 
 /**
  *	fbcon_get_default_font - get default font
@@ -129,3 +131,5 @@
     }
     return g;
 }
+
+EXPORT_SYMBOL(fbcon_get_default_font);
diff -ru linux-2.4.21.ref/drivers/video/Makefile
linux-2.4.21/drivers/video/Makefile
--- linux-2.4.21.ref/drivers/video/Makefile	2003-06-13
15:51:37.000000000 +0100
+++ linux-2.4.21/drivers/video/Makefile	2003-08-18 18:43:53.000000000
+0100
@@ -15,7 +15,7 @@
 		  fbcon-iplan2p8.o fbcon-vga-planes.o fbcon-cfb16.o \
 		  fbcon-cfb2.o fbcon-cfb24.o fbcon-cfb32.o fbcon-cfb4.o \
 		  fbcon-cfb8.o fbcon-mac.o fbcon-mfb.o \
-		  cyber2000fb.o sa1100fb.o fbcon-hga.o fbgen.o
+		  cyber2000fb.o sa1100fb.o fbcon-hga.o fbgen.o fonts.o
 
 # Each configuration option enables a list of files.
 

-- 
Alex, homepage: http://www.bennee.com/~alex/
Meskimen's Law:
	There's never time to do it right, but there's always time to
	do it over.



-------------------------------------------------------
This SF.net email is sponsored by Dice.com.
Did you know that Dice has over 25,000 tech jobs available today? From
careers in IT to Engineering to Tech Sales, Dice has tech jobs from the
best hiring companies. http://www.dice.com/index.epl?rel_code=104
