From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Fix dependencies for DECstation framebuffers
Date: Sat, 15 Oct 2005 00:11:08 +0100
Message-ID: <20051014231108.GA15204@linux-mips.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERRyB-0004Fl-EQ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Oct 2005 03:11:51 -0700
Received: from extgw-uk.mips.com ([62.254.210.129] helo=bacchus.net.dhis.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1ERRy9-0000pn-Pi
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Oct 2005 03:11:51 -0700
Resent-Message-Id: <200510142313.j9ENDHXu015258@dea.linux-mips.net>
Content-Disposition: inline
Resent-To: linux-fbdev-devel@lists.sourceforge.net,
	Andrew Morton <akpm@osdl.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>

For reviewing pleassure.  Fix dependencies for DECstation framebuffers;
they're really Turbochannel drivers and not DECstation specific.  If
nobody objects I'd like to submit this one as part of my pile of MIPS
patches, too.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>


 drivers/video/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: manual.git/drivers/video/Kconfig
===================================================================
--- manual.git.orig/drivers/video/Kconfig
+++ manual.git/drivers/video/Kconfig
@@ -1376,7 +1376,7 @@ config FB_HIT
 
 config FB_PMAG_AA
 	bool "PMAG-AA TURBOchannel framebuffer support"
-	depends on (FB = y) && MACH_DECSTATION && TC
+	depends on (FB = y) && TC
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
@@ -1387,7 +1387,7 @@ config FB_PMAG_AA
 
 config FB_PMAG_BA
 	bool "PMAG-BA TURBOchannel framebuffer support"
-	depends on (FB = y) && MACH_DECSTATION && TC
+	depends on (FB = y) && TC
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
@@ -1398,7 +1398,7 @@ config FB_PMAG_BA
 
 config FB_PMAGB_B
 	bool "PMAGB-B TURBOchannel framebuffer support"
-	depends on (FB = y) && MACH_DECSTATION && TC
+	depends on (FB = y) && TC
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
@@ -1410,7 +1410,7 @@ config FB_PMAGB_B
 
 config FB_MAXINE
 	bool "Maxine (Personal DECstation) onboard framebuffer support"
-	depends on (FB = y) && MACH_DECSTATION && TC
+	depends on (FB = y) && MACH_DECSTATION
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
