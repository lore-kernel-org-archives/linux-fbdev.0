From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: [PATCH, 2.4] static-ify some variables in drivers/video/hpfb.c
Date: Sun, 27 Apr 2003 01:48:57 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030426234857.GG31642@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 199ZQB-00059B-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 26 Apr 2003 16:49:31 -0700
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

this declares some variables as static, they aren't used outside
of this file.


Thiemo


diff -BurpNX /bigdisk/src/dontdiff linux-orig/drivers/video/hpfb.c linux/drivers/video/hpfb.c
--- linux-orig/drivers/video/hpfb.c	Wed Sep 11 14:45:21 2002
+++ linux/drivers/video/hpfb.c	Sat Apr 12 15:44:11 2003
@@ -31,9 +31,11 @@
 static struct display disp;
 static struct fb_info fb_info;
 
-unsigned long fb_start, fb_size = 1024*768, fb_line_length = 1024;
-unsigned long fb_regs;
-unsigned char fb_bitmask;
+static unsigned long fb_start;
+static unsigned long fb_size = 1024*768;
+static unsigned long fb_line_length = 1024;
+static unsigned long fb_regs;
+static unsigned char fb_bitmask;
 
 #define TC_WEN		0x4088
 #define TC_REN		0x408c


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
