From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH trivial atyfb] swith debug off
Date: Sat, 6 Nov 2004 19:00:12 +0100
Message-ID: <200411061900.12827.alex.kern@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sERjBv1PD/HnFfo"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQUrW-0000qL-I9
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Nov 2004 10:00:30 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CQUrS-0008SG-Kf
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Nov 2004 10:00:30 -0800
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
To: "Antonino A. Daplas" <adaplas@hotpop.com>, Linus Torvalds <torvalds@osdl.org>
Cc: fbdev mail-list <linux-fbdev-devel@lists.sourceforge.net>

--Boundary-00=_sERjBv1PD/HnFfo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, 

it's out of interest for normally user to debug atyfb driver

Signed-off-by: Alexander Kern <alex.kern@gmx.de>


--Boundary-00=_sERjBv1PD/HnFfo
Content-Type: text/x-diff;
  charset="us-ascii";
  name="atyfb_undef_debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="atyfb_undef_debug.patch"

--- linux-2.6.head/drivers/video/aty/atyfb_base.c.orig	2004-11-06 10:35:59.282703296 +0100
+++ linux-2.6.head/drivers/video/aty/atyfb_base.c	2004-11-06 10:40:11.857306120 +0100
@@ -100,8 +100,7 @@
 /*
  * Debug flags.
  */
-/*#undef DEBUG*/
-#define DEBUG
+#undef DEBUG
 
 /* Make sure n * PAGE_SIZE is protected at end of Aperture for GUI-regs */
 /*  - must be large enough to catch all GUI-Regs   */

--Boundary-00=_sERjBv1PD/HnFfo--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
