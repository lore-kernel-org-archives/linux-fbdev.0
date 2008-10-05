From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] x86: replace a magic number with a named constant in the
	VESA boot code
Date: Sun, 5 Oct 2008 12:16:04 +0200
Message-ID: <20081005101604.GA1995@spock.one.pl>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755295AbYJEKRn@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Replace a magic number with a named constant in the VESA boot code.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/arch/x86/boot/video-vesa.c b/arch/x86/boot/video-vesa.c
index 401ad99..1e6fe02 100644
--- a/arch/x86/boot/video-vesa.c
+++ b/arch/x86/boot/video-vesa.c
@@ -224,7 +224,7 @@ static void vesa_store_pm_info(void)
 static void vesa_store_mode_params_graphics(void)
 {
 	/* Tell the kernel we're in VESA graphics mode */
-	boot_params.screen_info.orig_video_isVGA = 0x23;
+	boot_params.screen_info.orig_video_isVGA = VIDEO_TYPE_VLFB;
 
 	/* Mode parameters */
 	boot_params.screen_info.vesa_attributes = vminfo.mode_attr;
