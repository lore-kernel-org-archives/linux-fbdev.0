From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [TRIVIAL PATCH 2.4] rivafb & 16 bit (fwd)
Date: Tue, 23 Dec 2003 13:20:25 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0312231320030.1139@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="Boundary-00=_A625/uxvEBaZ9x6"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYlWb-00026o-On
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 04:20:33 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AYlWb-000169-8r
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 04:20:33 -0800
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id hBNCKOQG027528
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Dec 2003 13:20:24 +0100 (MET)
Content-ID: <Pine.GSO.4.58.0312231320031.1139@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary-00=_A625/uxvEBaZ9x6
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.58.0312231320032.1139@waterleaf.sonytel.be>
Content-Disposition: INLINE

---------- Forwarded message ----------
Date: Mon, 22 Dec 2003 23:21:52 +0100
From: "[iso-8859-2] Pawe? Goleniowski" <pawelg@dabrowa.pl>
To: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.4] rivafb & 16 bit

There is a problem with 16 bit mode with rivafb. Colors are sometimes broken
(specialy under Midnight Commander). This small patch fixes it. I've been
using it for last months and it works without any problems.

Pawel 'Goldi' Goleniowski
--Boundary-00=_A625/uxvEBaZ9x6
Content-Type: TEXT/X-DIFF; CHARSET=iso-8859-2; NAME="patch-rivafb.diff"
Content-ID: <Pine.GSO.4.58.0312231320033.1139@waterleaf.sonytel.be>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="patch-rivafb.diff"

--- linux/drivers/video/riva/accel.c	2003-12-22 22:46:27.000000000 +0100
+++ linux/drivers/video/riva/accel.c	2003-12-22 19:47:19.000000000 +0100
@@ -300,8 +300,8 @@
 
 static inline void convert_bgcolor_16(u32 *col)
 {
-	*col = ((*col & 0x00007C00) << 9)
-             | ((*col & 0x000003E0) << 6)
+	*col = ((*col & 0x0000F800) << 8)
+             | ((*col & 0x000007E0) << 5)
              | ((*col & 0x0000001F) << 3)
              |          0xFF000000;
 }

--Boundary-00=_A625/uxvEBaZ9x6--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
