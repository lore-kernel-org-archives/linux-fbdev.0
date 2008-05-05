From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 6/8] tridentfb: convert is_blade and
 is_xp macros into functions
Date: Mon, 5 May 2008 18:57:40 +0200
Message-ID: <20080505185740.82c65e02.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jt40d-0007nW-UJ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 09:57:52 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jt40c-0006jy-Gb
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 09:57:51 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: adaplas@pol.net, akpm@linux-foundation.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch converts the is_blade() and is_xp() macros
into local functions.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-old/drivers/video/tridentfb.c linux-pc/drivers/video/tridentfb.c
diff -urp linux-old/drivers/video/tridentfb.c linux-pc/drivers/video/tridentfb.c
--- linux-old/drivers/video/tridentfb.c	2008-05-02 13:38:12.000000000 +0200
+++ linux-pc/drivers/video/tridentfb.c	2008-05-02 13:40:51.000000000 +0200
@@ -78,6 +78,25 @@ MODULE_PARM_DESC(fp, "Define if flatpane
 module_param(crt, int, 0);
 MODULE_PARM_DESC(crt, "Define if CRT is connected");
 
+static int is_blade(int id)
+{
+	return	(id == BLADE3D) ||
+		(id == CYBERBLADEE4) ||
+		(id == CYBERBLADEi7) ||
+		(id == CYBERBLADEi7D) ||
+		(id == CYBERBLADEi1) ||
+		(id == CYBERBLADEi1D) ||
+		(id == CYBERBLADEAi1) ||
+		(id == CYBERBLADEAi1D);
+}
+
+static int is_xp(int id)
+{
+	return	(id == CYBERBLADEXPAi1) ||
+		(id == CYBERBLADEXPm8) ||
+		(id == CYBERBLADEXPm16);
+}
+
 static int is3Dchip(int id)
 {
 	return ((id == BLADE3D) || (id == CYBERBLADEE4) ||
diff -urp linux-old/include/video/trident.h linux-pc/include/video/trident.h
--- linux-old/include/video/trident.h	2008-05-02 13:38:12.000000000 +0200
+++ linux-pc/include/video/trident.h	2008-05-02 13:40:51.000000000 +0200
@@ -39,25 +39,6 @@
 #define CYBERBLADEXPm8  0x9910
 #define CYBERBLADEXPm16 0x9930
 
-/* acceleration families */
-#define IMAGE	0
-#define BLADE	1
-#define XP	2
-
-#define is_image(id)	
-#define is_xp(id)	((id == CYBERBLADEXPAi1) ||\
-			 (id == CYBERBLADEXPm8) ||\
-			 (id == CYBERBLADEXPm16)) 
-
-#define is_blade(id)	((id == BLADE3D) ||\
-			 (id == CYBERBLADEE4) ||\
-			 (id == CYBERBLADEi7) ||\
-			 (id == CYBERBLADEi7D) ||\
-			 (id == CYBERBLADEi1) ||\
-			 (id == CYBERBLADEi1D) ||\
-			 (id ==	CYBERBLADEAi1) ||\
-			 (id ==	CYBERBLADEAi1D))
-
 /* these defines are for 'lcd' variable */
 #define LCD_STRETCH	0
 #define LCD_CENTER	1

----------------------------------------------------------------------
Sprawdz, czy jestes prawdziwym internauta!
Kliknij http://link.interia.pl/f1d6e


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
