From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 5/5] Update Documentation/fb/00-INDEX -
 add new files, remove entries for deleted ones (fwd)
Date: Sun, 2 Sep 2007 10:08:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0709021008010.21147@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IRkW3-00064t-Fl for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 02 Sep 2007 01:09:07 -0700
Received: from astra.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IRkW0-0000R6-Jn
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 02 Sep 2007 01:09:07 -0700
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

---------- Forwarded message ----------
Date: Fri, 31 Aug 2007 23:21:41 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-doc@vger.kernel.org
Cc: Rob Landley <rob@landley.net>, Randy Dunlap <rdunlap@xenotime.net>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Jesper Juhl <jesper.juhl@gmail.com>,
    Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/5] Update Documentation/fb/00-INDEX - add new files,
    remove entries for deleted ones


An update to Documentation/fb/00-INDEX is long overdue.
This patch adds entries for new files in the directory 
and removes entries for files that no longer exist. The
files are now also sorted alphabetically.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/fb/00-INDEX |   46 ++++++++++++++++++++++++++++++++++++--------
 1 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/Documentation/fb/00-INDEX b/Documentation/fb/00-INDEX
index 92e89ae..caabbd3 100644
--- a/Documentation/fb/00-INDEX
+++ b/Documentation/fb/00-INDEX
@@ -5,21 +5,49 @@ please mail me.
 
 00-INDEX
 	- this file
+arkfb.txt
+	- info on the fbdev driver for ARK Logic chips.
+aty128fb.txt
+	- info on the ATI Rage128 frame buffer driver.
+cirrusfb.txt
+	- info on the driver for Cirrus Logic chipsets.
+cyblafb/
+	- directory with documentation files related to the cyblafb driver.
+deferred_io.txt
+	- an introduction to deferred IO.
+fbcon.txt
+	- intro to and usage guide for the framebuffer console (fbcon).
 framebuffer.txt
-	- introduction to frame buffer devices
+	- introduction to frame buffer devices.
+imacfb.txt
+	- info on the generic EFI platform driver for Intel based Macs.
+intel810.txt
+	- documentation for the Intel 810/815 framebuffer driver.
+intelfb.txt
+	- docs for Intel 830M/845G/852GM/855GM/865G/915G/945G fb driver.
 internals.txt
-	- quick overview of frame buffer device internals
+	- quick overview of frame buffer device internals.
+matroxfb.txt
+	- info on the Matrox framebuffer driver for Alpha, Intel and PPC.
 modedb.txt
-	- info on the video mode database
-aty128fb.txt
-	- info on the ATI Rage128 frame buffer driver
-clgenfb.txt
-	- info on the Cirrus Logic frame buffer driver
+	- info on the video mode database.
 matroxfb.txt
-	- info on the Matrox frame buffer driver
+	- info on the Matrox frame buffer driver.
 pvr2fb.txt
-	- info on the PowerVR 2 frame buffer driver
+	- info on the PowerVR 2 frame buffer driver.
+pxafb.txt
+	- info on the driver for the PXA25x LCD controller.
+s3fb.txt
+	- info on the fbdev driver for S3 Trio/Virge chips.
+sa1100fb.txt
+	- information about the driver for the SA-1100 LCD controller.
+sisfb.txt
+	- info on the framebuffer device driver for various SiS chips.
+sstfb.txt
+	- info on the frame buffer driver for 3dfx' Voodoo Graphics boards.
 tgafb.txt
 	- info on the TGA (DECChip 21030) frame buffer driver
 vesafb.txt
 	- info on the VESA frame buffer device
+vt8623fb.txt
+	- info on the fb driver for the graphics core in VIA VT8623 chipsets.




-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
