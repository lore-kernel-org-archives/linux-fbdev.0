From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 4/7] fbdev: move logo externs to header
	file
Date: Wed, 31 Jan 2007 13:44:07 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701311339110.15066@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701311325480.14996@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HCEox-0007kj-W2 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 04:44:16 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HCEow-0002jn-5Y
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 04:44:15 -0800
In-Reply-To: <Pine.LNX.4.62.0701311325480.14996@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Move the external declarations for the various linux logo structures to
<linux/linux_logo.h>. As a consequence, I had to remove the `const', as `const'
is incompatible with `__initdata'.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/powerpc/kernel/prom_init.c |    3 ---
 drivers/video/logo/logo.c       |   13 -------------
 include/linux/linux_logo.h      |   13 +++++++++++++
 3 files changed, 13 insertions(+), 16 deletions(-)

--- ps3-linux-2.6.20-rc7.orig/arch/powerpc/kernel/prom_init.c
+++ ps3-linux-2.6.20-rc7/arch/powerpc/kernel/prom_init.c
@@ -44,10 +44,7 @@
 #include <asm/sections.h>
 #include <asm/machdep.h>
 
-#ifdef CONFIG_LOGO_LINUX_CLUT224
 #include <linux/linux_logo.h>
-extern const struct linux_logo logo_linux_clut224;
-#endif
 
 /*
  * Properties whose value is longer than this get excluded from our
--- ps3-linux-2.6.20-rc7.orig/drivers/video/logo/logo.c
+++ ps3-linux-2.6.20-rc7/drivers/video/logo/logo.c
@@ -21,19 +21,6 @@
 #include <asm/bootinfo.h>
 #endif
 
-extern const struct linux_logo logo_linux_mono;
-extern const struct linux_logo logo_linux_vga16;
-extern const struct linux_logo logo_linux_clut224;
-extern const struct linux_logo logo_dec_clut224;
-extern const struct linux_logo logo_mac_clut224;
-extern const struct linux_logo logo_parisc_clut224;
-extern const struct linux_logo logo_sgi_clut224;
-extern const struct linux_logo logo_sun_clut224;
-extern const struct linux_logo logo_superh_mono;
-extern const struct linux_logo logo_superh_vga16;
-extern const struct linux_logo logo_superh_clut224;
-extern const struct linux_logo logo_m32r_clut224;
-
 
 const struct linux_logo *fb_find_logo(int depth)
 {
--- ps3-linux-2.6.20-rc7.orig/include/linux/linux_logo.h
+++ ps3-linux-2.6.20-rc7/include/linux/linux_logo.h
@@ -32,6 +32,19 @@ struct linux_logo {
 	const unsigned char *data;
 };
 
+extern struct linux_logo logo_linux_mono;
+extern struct linux_logo logo_linux_vga16;
+extern struct linux_logo logo_linux_clut224;
+extern struct linux_logo logo_dec_clut224;
+extern struct linux_logo logo_mac_clut224;
+extern struct linux_logo logo_parisc_clut224;
+extern struct linux_logo logo_sgi_clut224;
+extern struct linux_logo logo_sun_clut224;
+extern struct linux_logo logo_superh_mono;
+extern struct linux_logo logo_superh_vga16;
+extern struct linux_logo logo_superh_clut224;
+extern struct linux_logo logo_m32r_clut224;
+
 extern const struct linux_logo *fb_find_logo(int depth);
 
 #endif /* _LINUX_LINUX_LOGO_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
