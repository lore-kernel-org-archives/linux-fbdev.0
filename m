From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/7] fbdev: Logo code fixes
Date: Thu, 17 Feb 2005 20:45:21 +0800
Message-ID: <200502172045.21040.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1l4p-0000hv-GI
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 04:48:15 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D1l4n-0008TY-Pd
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 04:48:15 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E1F9FE5BE40
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Feb 2005 12:48:07 +0000 (UTC)
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@www.infradead.org>

  This patch fixes a few bugs with the low level logo code.

  1. Allow DEC Alpha machines to draw the DEC logo
  2. Cleanup the logo directory on a make clean
  3. Some makefile cleanups.

  I have tested on my local machines. I like to be able to create the C
  files from the logos for only the ones we want to compile but I haven't
  figured out how to do that. That can wait. Please apply.

Signed-off-by: James Simmons <jsimmons@www.infradead.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Kconfig  |    2 +-
 Makefile |   41 +++++++++++++++++++----------------------
 logo.c   |    4 +++-
 3 files changed, 23 insertions(+), 24 deletions(-)

diff -Nru a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
--- a/drivers/video/logo/Kconfig	2005-02-01 23:21:28 +08:00
+++ b/drivers/video/logo/Kconfig	2005-02-15 00:40:04 +08:00
@@ -25,7 +25,7 @@
 
 config LOGO_DEC_CLUT224
 	bool "224-color Digital Equipment Corporation Linux logo"
-	depends on LOGO && MACH_DECSTATION
+	depends on LOGO && (MACH_DECSTATION || ALPHA)
 	default y
 
 config LOGO_MAC_CLUT224
diff -Nru a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
--- a/drivers/video/logo/Makefile	2004-10-19 20:23:35 +08:00
+++ b/drivers/video/logo/Makefile	2005-02-15 00:41:49 +08:00
@@ -23,35 +23,32 @@
 # Mono logos
 extra-y += $(call logo-cfiles,_mono,pbm)
 
-quiet_cmd_logo_mono    = MONO    $@
-      cmd_logo_mono    = scripts/pnmtologo -t mono -n $*_mono -o $@ $<
-
-$(obj)/%_mono.c: $(src)/%_mono.pbm FORCE
-	$(call if_changed,logo_mono)
-
 # VGA16 logos
 extra-y += $(call logo-cfiles,_vga16,ppm)
 
-quiet_cmd_logo_vga16   = VGA16   $@
-      cmd_logo_vga16   = scripts/pnmtologo -t vga16 -n $*_vga16 -o $@ $<
-
-$(obj)/%_vga16.c: $(src)/%_vga16.ppm FORCE
-	$(call if_changed,logo_vga16)
-
-#224 Logos
+# 224 Logos
 extra-y += $(call logo-cfiles,_clut224,ppm)
 
-quiet_cmd_logo_clut224 = CLUT224 $@
-      cmd_logo_clut224 = scripts/pnmtologo -t clut224 -n $*_clut224 -o $@ $<
-
-$(obj)/%_clut224.c: $(src)/%_clut224.ppm FORCE
-	$(call if_changed,logo_clut224)
-
 # Gray 256
 extra-y += $(call logo-cfiles,_gray256,pgm)
 
-quiet_cmd_logo_gray256 = GRAY256 $@
-      cmd_logo_gray256 = scripts/pnmtologo -t gray256 -n $*_gray256 -o $@ $<
+# Create commands like "pnmtologo -t mono -n logo_mac_mono -o ..."
+quiet_cmd_logo = LOGO	$@
+	cmd_logo = scripts/pnmtologo \
+			-t $(patsubst $*_%,%,$(notdir $(basename $<))) \
+			-n $(notdir $(basename $<)) -o $@ $<
+
+$(obj)/%_mono.c: $(src)/%_mono.pbm FORCE
+	$(call if_changed,logo)
+
+$(obj)/%_vga16.c: $(src)/%_vga16.ppm FORCE
+	$(call if_changed,logo)
+
+$(obj)/%_clut224.c: $(src)/%_clut224.ppm FORCE
+	$(call if_changed,logo)
 
 $(obj)/%_gray256.c: $(src)/%_gray256.pgm FORCE
-	$(call if_changed,logo_gray256)
+	$(call if_changed,logo)
+
+# Files generated that shall be removed upon make clean
+clean-files := *.o *_mono.c *_vga16.c *_clut224.c *_gray256.c
diff -Nru a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
--- a/drivers/video/logo/logo.c	2004-10-19 20:23:37 +08:00
+++ b/drivers/video/logo/logo.c	2005-02-15 02:19:21 +08:00
@@ -66,8 +66,10 @@
 		logo = &logo_linux_clut224;
 #endif
 #ifdef CONFIG_LOGO_DEC_CLUT224
-		/* DEC Linux logo on MIPS/MIPS64 */
+		/* DEC Linux logo on MIPS/MIPS64 or ALPHA */
+#ifndef CONFIG_ALPHA
 		if (mips_machgroup == MACH_GROUP_DEC)
+#endif
 			logo = &logo_dec_clut224;
 #endif
 #ifdef CONFIG_LOGO_MAC_CLUT224




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
