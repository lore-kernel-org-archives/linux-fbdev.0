From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 07/12] fbdev: Update
	Documentation/fb/00-INDEX
Date: Sat, 15 Sep 2007 08:04:37 +0800
Message-ID: <46EB2195.3060202@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IWLEn-0007mA-Ar for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:10:18 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IWLEn-0003jU-01
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:10:17 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3286302rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 14 Sep 2007 17:10:16 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Jesper Juhl <jesper.juhl@gmail.com>

An update to Documentation/fb/00-INDEX is long overdue.
This patch adds entries for new files in the directory
and removes entries for files that no longer exist. The
files are now also sorted alphabetically.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 Documentation/fb/00-INDEX |   46 ++++++++++++++++++++++++++++++++++++---------
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
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
