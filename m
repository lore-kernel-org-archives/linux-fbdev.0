From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: [PATCH, 2.4] Fix maxinefb_init prototype
Date: Sun, 27 Apr 2003 01:13:48 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030426231348.GD31642@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 199YsD-0002RP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 26 Apr 2003 16:14:25 -0700
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hello Geert,

this fixes the maxinefb_init prototype.


Thiemo


diff -BurpNX /bigdisk/src/dontdiff linux-orig/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linux-orig/drivers/video/fbmem.c	Sat Mar 29 03:44:24 2003
+++ linux/drivers/video/fbmem.c	Sat Apr 12 15:44:11 2003
@@ -124,7 +124,7 @@ extern int sisfb_init(void);
 extern int stifb_setup(char*);
 extern int pmagbafb_init(void);
 extern int pmagbbfb_init(void);
-extern void maxinefb_init(void);
+extern int maxinefb_init(void);
 extern int tx3912fb_init(void);
 extern int radeonfb_init(void);
 extern int radeonfb_setup(char*);


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
