From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH] fbdev: fix framebuffer memory calculation for vesafb
Date: Mon, 4 Oct 2004 09:23:49 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410040923.49817.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEHas-0003Zf-Uf
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 03 Oct 2004 18:24:50 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CEHaf-0007rL-R5
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 03 Oct 2004 18:24:50 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 457688ACC83
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  4 Oct 2004 01:24:31 +0000 (UTC)
Content-Disposition: inline
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Gerd Knorr <kraxel@bytesex.org>, Aurelien Jacobs <aurel@gnuage.org>Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- use vesafb_fix.line_length * vesafb_defined.yres to calculate the minimum
  memory required for a video mode. From Aurelien Jacobs <aurel@gnuage.org>.

- separately calculate the memory required for a video mode, memory to be
  remapped, and total memory (for MTRR). From Gerd Knorr
  <kraxel@bytesex.org>.

- the 'vram' option is for memory to be remapped, not total memory.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 vesafb.c |   54 ++++++++++++++++++++++++++++++++----------------------
 1 files changed, 32 insertions(+), 22 deletions(-)

diff -uprN linux-2.6.9-rc3-mm1-orig/drivers/video/vesafb.c linux-2.6.9-rc3-mm1/drivers/video/vesafb.c
--- linux-2.6.9-rc3-mm1-orig/drivers/video/vesafb.c	2004-10-04 09:08:54.000000000 +0800
+++ linux-2.6.9-rc3-mm1/drivers/video/vesafb.c	2004-10-04 09:09:14.557736296 +0800
@@ -220,6 +220,9 @@ static int __init vesafb_probe(struct de
 	struct platform_device *dev = to_platform_device(device);
 	struct fb_info *info;
 	int i, err;
+	unsigned int size_vmode;
+	unsigned int size_remap;
+	unsigned int size_total;
 
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_VLFB)
 		return -ENXIO;
@@ -231,32 +234,37 @@ static int __init vesafb_probe(struct de
 	vesafb_defined.xres = screen_info.lfb_width;
 	vesafb_defined.yres = screen_info.lfb_height;
 	vesafb_fix.line_length = screen_info.lfb_linelength;
-
-	/* Allocate enough memory for double buffering */
-	vesafb_fix.smem_len = screen_info.lfb_width * screen_info.lfb_height * vesafb_defined.bits_per_pixel >> 2;
-
-	/* check that we don't remap more memory than old cards have */
-	if (vesafb_fix.smem_len > (screen_info.lfb_size * 65536))
-		vesafb_fix.smem_len = screen_info.lfb_size * 65536;
-
-	/* Set video size according to vram boot option */
-	if (vram)
-		vesafb_fix.smem_len = vram * 1024 * 1024;
-
 	vesafb_fix.visual   = (vesafb_defined.bits_per_pixel == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 
-	/* limit framebuffer size to 16 MB.  Otherwise we'll eat tons of
-	 * kernel address space for nothing if the gfx card has alot of
-	 * memory (>= 128 MB isn't uncommon these days ...) */
-	if (vesafb_fix.smem_len > 16 * 1024 * 1024)
-		vesafb_fix.smem_len = 16 * 1024 * 1024;
+	/*   size_vmode -- that is the amount of memory needed for the
+	 *                 used video mode, i.e. the minimum amount of
+	 *                 memory we need. */
+	size_vmode = vesafb_fix.line_length * vesafb_defined.yres;
+
+	/*   size_total -- all video memory we have. Used for mtrr
+	 *                 entries and bounds checking. */
+	size_total = screen_info.lfb_size * 65536;
+	if (size_total < size_vmode)
+		size_total = size_vmode;
+
+	/*   size_remap -- the amount of video memory we are going to
+	 *                 use for vesafb.  With modern cards it is no
+	 *                 option to simply use size_total as that
+	 *                 wastes plenty of kernel address space. */
+	size_remap = size_vmode * 2;
+	if (vram)
+		size_remap = vram * 1024 * 1024;
+
+	if (size_remap > size_total)
+		size_remap = size_total;
+	vesafb_fix.smem_len = size_remap;
 
 #ifndef __i386__
 	screen_info.vesapm_seg = 0;
 #endif
 
-	if (!request_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len, "vesafb")) {
+	if (!request_mem_region(vesafb_fix.smem_start, size_total, "vesafb")) {
 		printk(KERN_WARNING
 		       "vesafb: abort, cannot reserve video memory at 0x%lx\n",
 			vesafb_fix.smem_start);
@@ -281,8 +289,10 @@ static int __init vesafb_probe(struct de
 		goto err;
 	}
 
-	printk(KERN_INFO "vesafb: framebuffer at 0x%lx, mapped to 0x%p, size %dk\n",
-	       vesafb_fix.smem_start, info->screen_base, vesafb_fix.smem_len/1024);
+	printk(KERN_INFO "vesafb: framebuffer at 0x%lx, mapped to 0x%p, "
+	       "using %dk, total %dk\n",
+	       vesafb_fix.smem_start, info->screen_base,
+	       size_remap/1024, size_total/1024);
 	printk(KERN_INFO "vesafb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
 	       vesafb_defined.xres, vesafb_defined.yres, vesafb_defined.bits_per_pixel, vesafb_fix.line_length, screen_info.pages);
 
@@ -362,7 +372,7 @@ static int __init vesafb_probe(struct de
 	request_region(0x3c0, 32, "vesafb");
 
 	if (mtrr) {
-		int temp_size = vesafb_fix.smem_len;
+		int temp_size = size_total;
 		/* Find the largest power-of-two */
 		while (temp_size & (temp_size - 1))
                 	temp_size &= (temp_size - 1);
@@ -393,7 +403,7 @@ static int __init vesafb_probe(struct de
 	return 0;
 err:
 	framebuffer_release(info);
-	release_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len);
+	release_mem_region(vesafb_fix.smem_start, size_total);
 	return err;
 }
 




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
