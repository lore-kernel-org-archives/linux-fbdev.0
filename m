From: Aurelien Jacobs <aurel@gnuage.org>
Subject: Re: Re: [PATCH] vesafb memory size mismatch
Date: Sun, 3 Oct 2004 02:53:23 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041003025323.11efa1b5@homer.gnuage.org>
References: <20041001153624.267a808b@homer.gnuage.org>
	<87acv6l9ru.fsf@bytesex.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__3_Oct_2004_02_53_23_+0200_m+/gS5rUpjD.KIQy"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CDv85-00035i-I5
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 02 Oct 2004 18:25:37 -0700
Received: from postfix4-2.free.fr ([213.228.0.176])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CDv83-0007ie-Ny
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 02 Oct 2004 18:25:37 -0700
In-Reply-To: <87acv6l9ru.fsf@bytesex.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

This is a multi-part message in MIME format.

--Multipart=_Sun__3_Oct_2004_02_53_23_+0200_m+/gS5rUpjD.KIQy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 01 Oct 2004 17:48:21 +0200
Gerd Knorr <kraxel@bytesex.org> wrote:

> Aurelien Jacobs <aurel@gnuage.org> writes:
> 
> > Hi,
> > 
> > I found a bug in the vesafb driver. The video memory size which is
> > reserved by vesafb do not correspond to the really needed memory.
> 
> Oh, while we are at it, I've hacked a patch as well some time ago.
> All the size calculation in vesafb is a bit tricky.  I've tried to
> cleanup that a bit and fix some bugs along the way, but never managed
> to submit it.  I think the boundary check cleanups should also fix the
> bug you've seen.

Unfortunately not :-(
Your patch still keep the same way to calculate minimum memory
required for the video mode (based on xres*bytes_per_pixel). It's
wrong ! With video cards such as 3dfx in 24 bits mode, line_length
is bigger than xres*bytes_per_pixel (probably for alignment pupose).
So not enough memory is allocated, leading to a crash.

Here is an updated version of your patch with the right way to
calculate size_vmode.

Aurel

--Multipart=_Sun__3_Oct_2004_02_53_23_+0200_m+/gS5rUpjD.KIQy
Content-Type: text/plain;
 name="vesafb-memory.diff"
Content-Disposition: attachment;
 filename="vesafb-memory.diff"
Content-Transfer-Encoding: 7bit

diff -aur linux-2.6.8.1.orig/drivers/video/vesafb.c linux-2.6.8.1/drivers/video/vesafb.c
--- linux-2.6.8.1.orig/drivers/video/vesafb.c	2004-10-03 02:34:53.652872688 +0200
+++ linux-2.6.8.1/drivers/video/vesafb.c	2004-10-03 02:39:23.401864608 +0200
@@ -218,6 +218,9 @@
 	struct platform_device *dev = to_platform_device(device);
 	struct fb_info *info;
 	int i, err;
+	unsigned int size_vmode;
+	unsigned int size_remap;
+	unsigned int size_total;
 
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_VLFB)
 		return -ENXIO;
@@ -229,32 +232,36 @@
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
+	if (vram)
+		size_total = vram * 1024 * 1024;
+
+	/*   size_remap -- the amount of video memory we are going to
+	 *                 use for vesafb.  With modern cards it is no
+	 *                 option to simply use size_total as that
+	 *                 wastes plenty of kernel address space. */
+	size_remap  = size_vmode * 2;
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
@@ -279,8 +286,10 @@
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
 
@@ -364,7 +373,7 @@
 	request_region(0x3c0, 32, "vesafb");
 
 	if (mtrr) {
-		int temp_size = vesafb_fix.smem_len;
+		int temp_size = size_total;
 		/* Find the largest power-of-two */
 		while (temp_size & (temp_size - 1))
                 	temp_size &= (temp_size - 1);
@@ -395,7 +404,7 @@
 	return 0;
 err:
 	framebuffer_release(info);
-	release_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len);
+	release_mem_region(vesafb_fix.smem_start, size_total);
 	return err;
 }
 

--Multipart=_Sun__3_Oct_2004_02_53_23_+0200_m+/gS5rUpjD.KIQy--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
