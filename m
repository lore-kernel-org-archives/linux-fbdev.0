From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH v2] fbdev: ignore VESA modes if framebuffer does not
	support them
Date: Wed, 24 Sep 2008 21:08:32 +0200
Message-ID: <20080924190832.GA19141@spock.one.pl>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755205AbYIXTKA@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, krzysztof.h1@poczta.fm, Andrew Morton <akpm@linux-foundation.org>, bonbons@linux-vserver.org

Currently, it is possible to set a graphics VESA mode at boot time via
the vga= parameter even when no framebuffer driver supporting this is
configured.  This could lead to the system booting with a black screen,
without a usable console.

Fix this problem by only allowing to set graphics modes at boot time
if a supporting framebuffer driver is configured.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
diff --git a/arch/x86/boot/video-vesa.c b/arch/x86/boot/video-vesa.c
index 401ad99..961a163 100644
--- a/arch/x86/boot/video-vesa.c
+++ b/arch/x86/boot/video-vesa.c
@@ -88,14 +88,11 @@ static int vesa_probe(void)
 			   (vminfo.memory_layout == 4 ||
 			    vminfo.memory_layout == 6) &&
 			   vminfo.memory_planes == 1) {
-#ifdef CONFIG_FB
+#if FB_SUPPORTS_BOOT_VESA
 			/* Graphics mode, color, linear frame buffer
 			   supported.  Only register the mode if
 			   if framebuffer is configured, however,
-			   otherwise the user will be left without a screen.
-			   We don't require CONFIG_FB_VESA, however, since
-			   some of the other framebuffer drivers can use
-			   this mode-setting, too. */
+			   otherwise the user will be left without a screen. */
 			mi = GET_HEAP(struct mode_info, 1);
 			mi->mode = mode + VIDEO_FIRST_VESA;
 			mi->depth = vminfo.bpp;
@@ -133,10 +130,12 @@ static int vesa_set_mode(struct mode_info *mode)
 	if ((vminfo.mode_attr & 0x15) == 0x05) {
 		/* It's a supported text mode */
 		is_graphic = 0;
+#if FB_SUPPORTS_BOOT_VESA
 	} else if ((vminfo.mode_attr & 0x99) == 0x99) {
 		/* It's a graphics mode with linear frame buffer */
 		is_graphic = 1;
 		vesa_mode |= 0x4000; /* Request linear frame buffer */
+#endif
 	} else {
 		return -1;	/* Invalid mode */
 	}
diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
index 1ee2c05..20fdc2f 100644
--- a/include/linux/screen_info.h
+++ b/include/linux/screen_info.h
@@ -76,6 +76,10 @@ extern struct screen_info screen_info;
 #define ORIG_VIDEO_LINES	(screen_info.orig_video_lines)
 #define ORIG_VIDEO_ISVGA	(screen_info.orig_video_isVGA)
 #define ORIG_VIDEO_POINTS       (screen_info.orig_video_points)
+
+#define FB_SUPPORTS_BOOT_VESA (defined(CONFIG_FB_VESA) || \
+		defined(CONFIG_FB_SIS) || defined(CONFIG_FB_IMAC) || \
+		defined(CONFIG_FB_INTEL))
 #endif /* __KERNEL__ */
 
 #endif /* _SCREEN_INFO_H */
