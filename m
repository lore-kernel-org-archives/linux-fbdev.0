From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] Fix get_std_timing
Date: Sat, 27 Sep 2003 19:28:43 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030927172843.GA14088@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A43ma-0000lN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 29 Sep 2003 12:34:08 -0700
Received: from mail-6.tiscali.it ([195.130.225.152])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A43mZ-00068a-WA
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Sep 2003 12:34:08 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@infradead.org>

Hi James,
it seems  that you  lost the  following patch. It  fixes get_std_timing.
Current code doesn't search the  VESA modedb. Instead it exits after the
first  iteration  with  mode calculated  by  calc_mode_timings. Bug  was
spotted by Antonino Daplas. Please apply:

===== drivers/video/fbmon.c 1.9 vs edited =====
--- 1.9/drivers/video/fbmon.c	Wed Jun  4 07:55:19 2003
+++ edited/drivers/video/fbmon.c	Mon Sep 15 17:59:28 2003
@@ -566,17 +566,19 @@
 	}
 	refresh = (block[1] & 0x3f) + 60;
 
+	/* First find standard mode from the table of VESA modes */
 	for (i = 0; i < VESA_MODEDB_SIZE; i++) {
 		if (vesa_modes[i].xres == xres && 
 		    vesa_modes[i].yres == yres &&
 		    vesa_modes[i].refresh == refresh) {
 			*mode = vesa_modes[i];
-			break;
-		} else {
-			calc_mode_timings(xres, yres, refresh, mode);
-			break;
+			return 1;
 		}
 	}
+
+	/* If mode is not found in table, calculate it using GTF */
+	calc_mode_timings(xres, yres, refresh, mode);
+	
 	return 1;
 }
 

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Windows /win'dohz/ n. : thirty-two  bit extension and graphical shell to
a sixteen  bit patch to an  eight bit operating system  originally coded
for a  four bit microprocessor  which was  written by a  two-bit company
that can't stand a bit of competition.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
