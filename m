From: James Simmons <jsimmons@www.infradead.org>
Subject: [PATCH] Logo code fixes part 2.
Date: Mon, 14 Feb 2005 18:24:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502141821240.7796@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0ktY-0000iZ-1j
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 10:24:28 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D0ktW-00080i-5f
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 10:24:27 -0800
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Sorry but please ignore the first patch. This patch uses stricter logic in 
logo.c for when to display the DEC logo. For Alpha machines always allow 
the DEC logo. For MIPS machines only allow it for DEC Stations.

Signed-off-by: James Simmons <jsimmons@www.infradead.org>

This patch fixes a few bugs with the low level logo code. 

1. Allow DEC Alpha machines to draw the DEC logo
2. Cleanup the logo directory on a make clean
3. Some makefile cleanups.

I have tested on my local machines. I like to be able to create the C 
files from the logos for only the ones we want to compile but I haven't 
figured out how to do that. That can wait. Please apply.

diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/logo/Kconfig fbdev-2.6/drivers/video/logo/Kconfig
--- linus-2.6/drivers/video/logo/Kconfig	2005-02-11 16:55:28.000000000 -0800
+++ fbdev-2.6/drivers/video/logo/Kconfig	2005-02-14 08:40:04.000000000 -0800
@@ -25,7 +25,7 @@
 
 config LOGO_DEC_CLUT224
 	bool "224-color Digital Equipment Corporation Linux logo"
-	depends on LOGO && MACH_DECSTATION
+	depends on LOGO && (MACH_DECSTATION || ALPHA)
 	default y
 
 config LOGO_MAC_CLUT224
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/logo/Makefile fbdev-2.6/drivers/video/logo/Makefile
--- linus-2.6/drivers/video/logo/Makefile	2005-02-11 16:55:28.000000000 -0800
+++ fbdev-2.6/drivers/video/logo/Makefile	2005-02-14 08:41:49.000000000 -0800
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
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/logo/logo.c fbdev-2.6/drivers/video/logo/logo.c
--- linus-2.6/drivers/video/logo/logo.c	2005-02-11 16:55:28.000000000 -0800
+++ fbdev-2.6/drivers/video/logo/logo.c	2005-02-14 10:19:21.000000000 -0800
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
