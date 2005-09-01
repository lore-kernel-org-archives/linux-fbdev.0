From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/10] fbdev: Add VESA Coordinated Video Timings (CVT) support
Date: Fri, 02 Sep 2005 06:09:04 +0800
Message-ID: <43177C00.9040805@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAxFO-0005EI-Gc
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 15:09:26 -0700
Received: from wproxy.gmail.com ([64.233.184.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EAxFL-0007P4-QU
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 15:09:26 -0700
Received: by wproxy.gmail.com with SMTP id 37so420539wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 Sep 2005 15:09:17 -0700 (PDT)
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Knut Petersen <Knut_Petersen@t-online.de>

Mistakenly CC'ed Knut instead of linux-fbdev devel.  Sorry Knut.

Tony 

   The Coordinated Video Timings (CVT) is the latest standard approved by VESA
    concerning video timings generation.  It addresses the limitation of GTF
    which is designed mainly for CRT displays. CRT's have a high blanking
    requirement (as much as 25% of the horizontal frame length) which
    artificially increases the pixelclock. Digital displays, on the other hand,
    needs to conserve the pixelclock as much as possible.  The GTF also does
    not take into account the different aspect ratios in its calculation.
    
    The new function added is fb_find_mode_cvt(). It is called by
    fb_find_mode() if it recognizes a mode option string formatted for CVT.
    The format is:
    
    <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][m]
    
    The 'M' tells the function to calculate using CVT. On it's own, it will
    compute a timing for CRT displays at 60Hz.  If the 'R' is specified,
    'reduced blanking' computation will be used, best for flatpanels.  The 'i'
    and the 'm' is for 'interlaced mode' and 'with margins' respectively.
    
    To determine if CVT was used, check for dmesg for something like this:
    
    CVT Mode - <pix>M<n>[-R], ie: .480M3-R  (800x600 reduced blanking)
    
    where: pix - product of xres and yres, in MB
    M   - is a CVT mode
    n   - the aspect ratio (3 - 4:3; 4 - 5:4; 9 - 16:9, 15:9; A - 16:10)
    -R   - reduced blanking
    
    Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 Documentation/fb/modedb.txt |   73 ++++++++
 drivers/video/Makefile      |    3 
 drivers/video/fbcvt.c       |  380 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/video/fbmem.c       |   12 -
 drivers/video/modedb.c      |   62 ++++++-
 include/linux/fb.h          |    1 
 6 files changed, 519 insertions(+), 12 deletions(-)


diff --git a/Documentation/fb/modedb.txt b/Documentation/fb/modedb.txt
--- a/Documentation/fb/modedb.txt
+++ b/Documentation/fb/modedb.txt
@@ -20,12 +20,83 @@ in a video= option, fbmem considers that
 
 Valid mode specifiers (mode_option argument):
 
-    <xres>x<yres>[-<bpp>][@<refresh>]
+    <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][m]
     <name>[-<bpp>][@<refresh>]
 
 with <xres>, <yres>, <bpp> and <refresh> decimal numbers and <name> a string.
 Things between square brackets are optional.
 
+If 'M' is specified in the mode_option argument (after <yres> and before
+<bpp> and <refresh>, if specified) the timings will be calculated using
+VESA(TM) Coordinated Video Timings instead of looking up the mode from a table.
+If 'R' is specified, do a 'reduced blanking' calculation for digital displays.
+If 'i' is specified, calculate for an interlaced mode.  And if 'm' is
+specified, add margins to the calculation (1.8% of xres rounded down to 8
+pixels and 1.8% of yres).
+
+       Sample usage: 1024x768M@60m - CVT timing with margins
+
+***** oOo ***** oOo ***** oOo ***** oOo ***** oOo ***** oOo ***** oOo *****
+
+What is the VESA(TM) Coordinated Video Timings (CVT)?
+
+From the VESA(TM) Website: 
+
+     "The purpose of CVT is to provide a method for generating a consistent
+      and coordinated set of standard formats, display refresh rates, and
+      timing specifications for computer display products, both those
+      employing CRTs, and those using other display technologies. The
+      intention of CVT is to give both source and display manufacturers a
+      common set of tools to enable new timings to be developed in a
+      consistent manner that ensures greater compatibility."
+
+This is the third standard approved by VESA(TM) concerning video timings.  The
+first was the Discrete Video Timings (DVT) which is  a collection of
+pre-defined modes approved by VESA(TM).  The second is the Generalized Timing
+Formula (GTF) which is an algorithm to calculate the timings, given the
+pixelclock, the horizontal sync frequency, or the vertical refresh rate. 
+
+The GTF is limited by the fact that it is designed mainly for CRT displays.
+It artificially increases the pixelclock because of its high blanking
+requirement. This is inappropriate for digital display interface with its high
+data rate which requires that it conserves the pixelclock as much as possible.
+Also, GTF does not take into account the aspect ratio of the display.
+
+The CVT addresses these limitations.  If used with CRT's, the formula used
+is a derivation of GTF with a few modifications.  If used with digital
+displays, the "reduced blanking" calculation can be used.
+
+From the framebuffer subsystem perspective, new formats need not be added
+to the global mode database whenever a new mode is released by display
+manufacturers. Specifying for CVT will work for most, if not all, relatively
+new CRT displays and probably with most flatpanels, if 'reduced blanking'
+calculation is specified.  (The CVT compatibility of the display can be
+determined from its EDID. The version 1.3 of the EDID has extra 128-byte
+blocks where additional timing information is placed.  As of this time, there
+is no support yet in the layer to parse this additional blocks.)
+
+CVT also introduced a new naming convention (should be seen from dmesg output):
+
+    <pix>M<a>[-R]
+
+    where: pix = total amount of pixels in MB (xres x yres)
+           M   = always present
+           a   = aspect ratio (3 - 4:3; 4 - 5:4; 9 - 15:9, 16:9; A - 16:10)
+          -R   = reduced blanking
+
+	  example:  .48M3-R - 800x600 with reduced blanking
+
+Note: VESA(TM) has restrictions on what is a standard CVT timing:
+
+      - aspect ratio can only be one of the above values
+      - acceptable refresh rates are 50, 60, 70 or 85 Hz only
+      - if reduced blanking, the refresh rate must be at 60Hz
+
+If one of the above are not satisfied, the kernel will print a warning but the
+timings will still be calculated.
+
+***** oOo ***** oOo ***** oOo ***** oOo ***** oOo ***** oOo ***** oOo *****
+
 To find a suitable video mode, you just call
 
 int __init fb_find_mode(struct fb_var_screeninfo *var,
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -9,7 +9,8 @@ obj-$(CONFIG_LOGO)		  += logo/
 obj-$(CONFIG_SYSFS)		  += backlight/
 
 obj-$(CONFIG_FB)                  += fb.o
-fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o modedb.o
+fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o \
+                                     modedb.o fbcvt.o
 fb-objs                           := $(fb-y)
 
 obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
diff --git a/drivers/video/fbcvt.c b/drivers/video/fbcvt.c
new file mode 100644
--- /dev/null
+++ b/drivers/video/fbcvt.c
@@ -0,0 +1,380 @@
+/*
+ * linux/drivers/video/fbcvt.c - VESA(TM) Coordinated Video Timings
+ *
+ * Copyright (C) 2005 Antonino Daplas <adaplas@pol.net>
+ *
+ *      Based from the VESA(TM) Coordinated Video Timing Generator by
+ *      Graham Loveridge April 9, 2003 available at
+ *      http://www.vesa.org/public/CVT/CVTd6r1.xls
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ *
+ */
+#include <linux/fb.h>
+
+#define FB_CVT_CELLSIZE               8
+#define FB_CVT_GTF_C                 40
+#define FB_CVT_GTF_J                 20
+#define FB_CVT_GTF_K                128
+#define FB_CVT_GTF_M                600
+#define FB_CVT_MIN_VSYNC_BP         550
+#define FB_CVT_MIN_VPORCH             3
+#define FB_CVT_MIN_BPORCH             6
+
+#define FB_CVT_RB_MIN_VBLANK        460
+#define FB_CVT_RB_HBLANK            160  
+#define FB_CVT_RB_V_FPORCH            3
+ 
+#define FB_CVT_FLAG_REDUCED_BLANK 1
+#define FB_CVT_FLAG_MARGINS       2
+#define FB_CVT_FLAG_INTERLACED    4
+
+struct fb_cvt_data {
+	u32 xres;
+	u32 yres;
+	u32 refresh;
+	u32 f_refresh;
+	u32 pixclock;
+	u32 hperiod;
+	u32 hblank;
+	u32 hfreq;
+	u32 htotal;
+	u32 vtotal;
+	u32 vsync;
+	u32 hsync;
+	u32 h_front_porch;
+	u32 h_back_porch;
+	u32 v_front_porch;
+	u32 v_back_porch;
+	u32 h_margin;
+	u32 v_margin;
+	u32 interlace;
+	u32 aspect_ratio;
+	u32 active_pixels;
+	u32 flags;
+	u32 status;
+};
+
+static int fb_cvt_vbi_tab[] = {
+	4,        /* 4:3      */
+	5,        /* 16:9     */ 
+	6,        /* 16:10    */
+	7,        /* 5:4      */
+	7,        /* 15:9     */
+	8,        /* reserved */
+	9,        /* reserved */
+	10        /* custom   */
+};
+
+/* returns hperiod * 1000 */
+static u32 fb_cvt_hperiod(struct fb_cvt_data *cvt)
+{
+	u32 num = 1000000000/cvt->f_refresh;
+	u32 den;
+	
+	if (cvt->flags & FB_CVT_FLAG_REDUCED_BLANK) {
+		num -= FB_CVT_RB_MIN_VBLANK * 1000;
+		den = 2 * (cvt->yres/cvt->interlace + 2 * cvt->v_margin);
+	} else {
+		num -= FB_CVT_MIN_VSYNC_BP * 1000;
+		den = 2 * (cvt->yres/cvt->interlace + cvt->v_margin * 2
+			   + FB_CVT_MIN_VPORCH + cvt->interlace/2);
+	}
+
+	return 2 * (num/den);
+}
+    
+/* returns ideal duty cycle * 1000 */
+static u32 fb_cvt_ideal_duty_cycle(struct fb_cvt_data *cvt)
+{
+	u32 c_prime = (FB_CVT_GTF_C - FB_CVT_GTF_J) *
+		(FB_CVT_GTF_K) + 256 * FB_CVT_GTF_J;
+	u32 m_prime = (FB_CVT_GTF_K * FB_CVT_GTF_M);
+	u32 h_period_est = cvt->hperiod;
+
+	return (1000 * c_prime  - ((m_prime * h_period_est)/1000))/256;
+}
+
+static u32 fb_cvt_hblank(struct fb_cvt_data *cvt)
+{
+	u32 hblank = 0;
+
+	if (cvt->flags & FB_CVT_FLAG_REDUCED_BLANK)
+		hblank = FB_CVT_RB_HBLANK;
+	else {
+		u32 ideal_duty_cycle = fb_cvt_ideal_duty_cycle(cvt);
+		u32 active_pixels = cvt->active_pixels;
+
+		if (ideal_duty_cycle < 20000)
+			hblank = (active_pixels * 20000)/
+				(100000 - 20000);
+		else {
+			hblank = (active_pixels * ideal_duty_cycle)/
+				(100000 - ideal_duty_cycle);
+		}
+	}
+
+	hblank &= ~((2 * FB_CVT_CELLSIZE) - 1);
+
+	return hblank;
+}
+
+static u32 fb_cvt_hsync(struct fb_cvt_data *cvt)
+{
+	u32 hsync;
+
+	if (cvt->flags & FB_CVT_FLAG_REDUCED_BLANK)
+		hsync = 32;
+	else 
+		hsync = (FB_CVT_CELLSIZE * cvt->htotal)/100;
+
+	hsync &= ~(FB_CVT_CELLSIZE - 1);
+	return hsync;
+}
+
+static u32 fb_cvt_vbi_lines(struct fb_cvt_data *cvt)
+{
+	u32 vbi_lines, min_vbi_lines, act_vbi_lines;
+
+	if (cvt->flags & FB_CVT_FLAG_REDUCED_BLANK) {
+		vbi_lines = (1000 * FB_CVT_RB_MIN_VBLANK)/cvt->hperiod + 1;
+		min_vbi_lines =  FB_CVT_RB_V_FPORCH + cvt->vsync +
+			FB_CVT_MIN_BPORCH;
+
+	} else {
+		vbi_lines = (FB_CVT_MIN_VSYNC_BP * 1000)/cvt->hperiod + 1 +
+			 FB_CVT_MIN_VPORCH;
+		min_vbi_lines = cvt->vsync + FB_CVT_MIN_BPORCH +
+			FB_CVT_MIN_VPORCH;
+	}
+
+	if (vbi_lines < min_vbi_lines)
+		act_vbi_lines = min_vbi_lines;
+	else
+		act_vbi_lines = vbi_lines;
+
+	return act_vbi_lines;
+}
+
+static u32 fb_cvt_vtotal(struct fb_cvt_data *cvt)
+{
+	u32 vtotal = cvt->yres/cvt->interlace;
+		
+	vtotal += 2 * cvt->v_margin + cvt->interlace/2 + fb_cvt_vbi_lines(cvt);
+	vtotal |= cvt->interlace/2;
+
+	return vtotal;
+}
+
+static u32 fb_cvt_pixclock(struct fb_cvt_data *cvt)
+{
+	u32 pixclock;
+	
+	if (cvt->flags & FB_CVT_FLAG_REDUCED_BLANK)
+		pixclock = (cvt->f_refresh * cvt->vtotal * cvt->htotal)/1000;
+	else 
+		pixclock = (cvt->htotal * 1000000)/cvt->hperiod;
+
+	pixclock /= 250;
+	pixclock *= 250;
+	pixclock *= 1000;
+
+	return pixclock;
+}
+
+static u32 fb_cvt_aspect_ratio(struct fb_cvt_data *cvt)
+{
+	u32 xres = cvt->xres;
+	u32 yres = cvt->yres;
+	u32 aspect = -1;
+
+	if (xres == (yres * 4)/3 && !((yres * 4) % 3))
+		aspect = 0;
+	else if (xres == (yres * 16)/9 && !((yres * 16) % 9))
+		aspect = 1;
+	else if (xres == (yres * 16)/10 && !((yres * 16) % 10))
+		aspect = 2;
+	else if (xres == (yres * 5)/4 && !((yres * 5) % 4))
+		aspect = 3;
+	else if (xres == (yres * 15)/9 && !((yres * 15) % 9))
+		aspect = 4;
+	else {
+		printk(KERN_INFO "fbcvt: Aspect ratio not CVT "
+		       "standard\n");
+		aspect = 7;
+		cvt->status = 1;
+	}
+
+	return aspect;
+}
+
+static void fb_cvt_print_name(struct fb_cvt_data *cvt)
+{
+	u32 pixcount, pixcount_mod;
+	int cnt = 255, offset = 0, read = 0;
+	u8 *buf = kmalloc(256, GFP_KERNEL);
+
+	if (!buf)
+		return;
+
+	memset(buf, 0, 256);
+	pixcount = (cvt->xres * (cvt->yres/cvt->interlace))/1000000;
+	pixcount_mod = (cvt->xres * (cvt->yres/cvt->interlace)) % 1000000;
+	pixcount_mod /= 1000;
+
+	read = snprintf(buf+offset, cnt, "fbcvt: %dx%d@%d: CVT Name - ",
+			cvt->xres, cvt->yres, cvt->refresh);
+	offset += read;
+	cnt -= read;
+
+	if (cvt->status)
+		snprintf(buf+offset, cnt, "Not a CVT standard - %d.%03d Mega "
+			 "Pixel Image\n", pixcount, pixcount_mod);
+	else {
+		if (pixcount) {
+			read = snprintf(buf+offset, cnt, "%d", pixcount);
+			cnt -= read;
+			offset += read;
+		}
+
+		read = snprintf(buf+offset, cnt, ".%03dM", pixcount_mod);
+		cnt -= read;
+		offset += read;
+
+		if (cvt->aspect_ratio == 0)
+			read = snprintf(buf+offset, cnt, "3");
+		else if (cvt->aspect_ratio == 3)
+			read = snprintf(buf+offset, cnt, "4");
+		else if (cvt->aspect_ratio == 1 || cvt->aspect_ratio == 4)
+			read = snprintf(buf+offset, cnt, "9");
+		else if (cvt->aspect_ratio == 2)
+			read = snprintf(buf+offset, cnt, "A");
+		else
+			read = 0;
+		cnt -= read;
+		offset += read;
+
+		if (cvt->flags & FB_CVT_FLAG_REDUCED_BLANK) {
+			read = snprintf(buf+offset, cnt, "-R");
+			cnt -= read;
+			offset += read;
+		}
+	}
+
+	printk(KERN_INFO "%s\n", buf);
+	kfree(buf);
+}
+
+static void fb_cvt_convert_to_mode(struct fb_cvt_data *cvt,
+				   struct fb_videomode *mode)
+{
+	mode->refresh = cvt->f_refresh;
+	mode->pixclock = KHZ2PICOS(cvt->pixclock/1000);
+	mode->left_margin = cvt->h_front_porch;
+	mode->right_margin = cvt->h_back_porch;
+	mode->hsync_len = cvt->hsync;
+	mode->upper_margin = cvt->v_front_porch;
+	mode->lower_margin = cvt->v_back_porch;
+	mode->vsync_len = cvt->vsync;
+	
+	mode->sync &= ~(FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT);
+
+	if (cvt->flags & FB_CVT_FLAG_REDUCED_BLANK)
+		mode->sync |= FB_SYNC_HOR_HIGH_ACT;
+	else
+		mode->sync |= FB_SYNC_VERT_HIGH_ACT;
+}
+
+/*
+ * fb_find_mode_cvt - calculate mode using VESA(TM) CVT
+ * @mode: pointer to fb_videomode; xres, yres, refresh and vmode must be
+ *        pre-filled with the desired values
+ * @margins: add margin to calculation (1.8% of xres and yres)
+ * @rb: compute with reduced blanking (for flatpanels)
+ *
+ * RETURNS:
+ * 0 for success
+ * @mode is filled with computed values.  If interlaced, the refresh field
+ * will be filled with the field rate (2x the frame rate)
+ *
+ * DESCRIPTION:
+ * Computes video timings using VESA(TM) Coordinated Video Timings
+ */
+int fb_find_mode_cvt(struct fb_videomode *mode, int margins, int rb)
+{
+	struct fb_cvt_data cvt;
+
+	memset(&cvt, 0, sizeof(cvt));
+
+	if (margins)
+	    cvt.flags |= FB_CVT_FLAG_MARGINS;
+
+	if (rb)
+	    cvt.flags |= FB_CVT_FLAG_REDUCED_BLANK;
+
+	if (mode->vmode & FB_VMODE_INTERLACED)
+	    cvt.flags |= FB_CVT_FLAG_INTERLACED;
+
+	cvt.xres = mode->xres;
+	cvt.yres = mode->yres;
+	cvt.refresh = mode->refresh;
+	cvt.f_refresh = cvt.refresh;
+	cvt.interlace = 1;
+
+	if (!cvt.xres || !cvt.yres || !cvt.refresh) {
+		printk(KERN_INFO "fbcvt: Invalid input parameters\n");
+		return 1;
+	}
+
+	if (!(cvt.refresh == 50 || cvt.refresh == 60 || cvt.refresh == 70 ||
+	      cvt.refresh == 85)) {
+		printk(KERN_INFO "fbcvt: Refresh rate not CVT "
+		       "standard\n");
+		cvt.status = 1;
+	}
+
+	cvt.xres &= ~(FB_CVT_CELLSIZE - 1);
+	
+	if (cvt.flags & FB_CVT_FLAG_INTERLACED) {
+		cvt.interlace = 2;
+		cvt.f_refresh *= 2;
+	}
+
+	if (cvt.flags & FB_CVT_FLAG_REDUCED_BLANK) {
+		if (cvt.refresh != 60) {
+			printk(KERN_INFO "fbcvt: 60Hz refresh rate "
+			       "advised for reduced blanking\n");
+			cvt.status = 1;
+		}
+	}
+
+	if (cvt.flags & FB_CVT_FLAG_MARGINS) {
+		cvt.h_margin = (cvt.xres * 18)/1000;
+		cvt.h_margin &= ~(FB_CVT_CELLSIZE - 1);
+		cvt.v_margin = ((cvt.yres/cvt.interlace)* 18)/1000;
+	}
+
+	cvt.aspect_ratio = fb_cvt_aspect_ratio(&cvt);
+	cvt.active_pixels = cvt.xres + 2 * cvt.h_margin;
+	cvt.hperiod = fb_cvt_hperiod(&cvt);
+	cvt.vsync = fb_cvt_vbi_tab[cvt.aspect_ratio];
+	cvt.vtotal = fb_cvt_vtotal(&cvt);
+	cvt.hblank = fb_cvt_hblank(&cvt);
+	cvt.htotal = cvt.active_pixels + cvt.hblank;
+	cvt.hsync = fb_cvt_hsync(&cvt);
+	cvt.pixclock = fb_cvt_pixclock(&cvt);
+	cvt.hfreq = cvt.pixclock/cvt.htotal;
+	cvt.h_back_porch = cvt.hblank/2 + cvt.h_margin;
+	cvt.h_front_porch = cvt.hblank - cvt.hsync - cvt.h_back_porch +
+		2 * cvt.h_margin;
+	cvt.v_back_porch = 3 + cvt.v_margin;
+	cvt.v_front_porch = cvt.vtotal - cvt.yres/cvt.interlace -
+	    cvt.v_back_porch - cvt.vsync;
+	fb_cvt_print_name(&cvt);
+	fb_cvt_convert_to_mode(&cvt, mode);
+
+	return 0;
+}
+EXPORT_SYMBOL(fb_find_mode_cvt);
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1029,6 +1029,7 @@ register_framebuffer(struct fb_info *fb_
 {
 	int i;
 	struct fb_event event;
+	struct fb_videomode mode;
 
 	if (num_registered_fb == FB_MAX)
 		return -ENXIO;
@@ -1059,16 +1060,11 @@ register_framebuffer(struct fb_info *fb_
 	}	
 	fb_info->pixmap.offset = 0;
 
-	if (!fb_info->modelist.prev ||
-	    !fb_info->modelist.next ||
-	    list_empty(&fb_info->modelist)) {
-	        struct fb_videomode mode;
-
+	if (!fb_info->modelist.prev || !fb_info->modelist.next)
 		INIT_LIST_HEAD(&fb_info->modelist);
-		fb_var_to_videomode(&mode, &fb_info->var);
-		fb_add_videomode(&mode, &fb_info->modelist);
-	}
 
+	fb_var_to_videomode(&mode, &fb_info->var);
+	fb_add_videomode(&mode, &fb_info->modelist);
 	registered_fb[i] = fb_info;
 
 	devfs_mk_cdev(MKDEV(FB_MAJOR, i),
diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -456,12 +456,22 @@ static int fb_try_mode(struct fb_var_scr
  *
  *	Valid mode specifiers for @mode_option:
  *
- *	<xres>x<yres>[-<bpp>][@<refresh>] or
+ *	<xres>x<yres>[M][R][-<bpp>][@<refresh>][i][m] or
  *	<name>[-<bpp>][@<refresh>]
  *
  *	with <xres>, <yres>, <bpp> and <refresh> decimal numbers and
  *	<name> a string.
  *
+ *      If 'M' is present after yres (and before refresh/bpp if present),
+ *      the function will compute the timings using VESA(tm) Coordinated
+ *      Video Timings (CVT).  If 'R' is present after 'M', will compute with
+ *      reduced blanking (for flatpanels).  If 'i' is present, compute
+ *      interlaced mode.  If 'm' is present, add margins equal to 1.8%
+ *      of xres rounded down to 8 pixels, and 1.8% of yres. The char
+ *      'i' and 'm' must be after 'M' and 'R'. Example:
+ *
+ *      1024x768MR-8@60m - Reduced blank with margins at 60Hz.
+ *
  *	NOTE: The passed struct @var is _not_ cleared!  This allows you
  *	to supply values for e.g. the grayscale and accel_flags fields.
  *
@@ -495,7 +505,7 @@ int fb_find_mode(struct fb_var_screeninf
 	unsigned int namelen = strlen(name);
 	int res_specified = 0, bpp_specified = 0, refresh_specified = 0;
 	unsigned int xres = 0, yres = 0, bpp = default_bpp, refresh = 0;
-	int yres_specified = 0;
+	int yres_specified = 0, cvt = 0, rb = 0, interlace = 0, margins = 0;
 	u32 best, diff;
 
 	for (i = namelen-1; i >= 0; i--) {
@@ -506,6 +516,8 @@ int fb_find_mode(struct fb_var_screeninf
 			!yres_specified) {
 			refresh = my_atoi(&name[i+1]);
 			refresh_specified = 1;
+			if (cvt || rb)
+			    cvt = 0;
 		    } else
 			goto done;
 		    break;
@@ -514,6 +526,8 @@ int fb_find_mode(struct fb_var_screeninf
 		    if (!bpp_specified && !yres_specified) {
 			bpp = my_atoi(&name[i+1]);
 			bpp_specified = 1;
+			if (cvt || rb)
+			    cvt = 0;
 		    } else
 			goto done;
 		    break;
@@ -526,6 +540,22 @@ int fb_find_mode(struct fb_var_screeninf
 		    break;
 		case '0'...'9':
 		    break;
+		case 'M':
+		    if (!yres_specified)
+			cvt = 1;
+		    break;
+		case 'R':
+		    if (!cvt)
+			rb = 1;
+		    break;
+		case 'm':
+		    if (!cvt)
+			margins = 1;
+		    break;
+		case 'i':
+		    if (!cvt)
+			interlace = 1;
+		    break;
 		default:
 		    goto done;
 	    }
@@ -535,6 +565,34 @@ int fb_find_mode(struct fb_var_screeninf
 	    res_specified = 1;
 	}
 done:
+	if (cvt) {
+	    struct fb_videomode cvt_mode;
+	    int ret;
+
+	    DPRINTK("CVT mode %dx%d@%dHz%s%s%s\n", xres, yres,
+		    (refresh) ? refresh : 60, (rb) ? " reduced blanking" :
+		    "", (margins) ? " with margins" : "", (interlace) ?
+		    " interlaced" : "");
+
+	    cvt_mode.xres = xres;
+	    cvt_mode.yres = yres;
+	    cvt_mode.refresh = (refresh) ? refresh : 60;
+
+	    if (interlace)
+		cvt_mode.vmode |= FB_VMODE_INTERLACED;
+	    else
+		cvt_mode.vmode &= ~FB_VMODE_INTERLACED;
+	    
+	    ret = fb_find_mode_cvt(&cvt_mode, margins, rb);
+	    
+	    if (!ret && !fb_try_mode(var, info, &cvt_mode, bpp)) {
+		DPRINTK("modedb CVT: CVT mode ok\n");
+		return 1;
+	    }
+
+	    DPRINTK("CVT mode invalid, getting mode from database\n");
+	}
+
 	DPRINTK("Trying specified video mode%s %ix%i\n",
 	    refresh_specified ? "" : " (ignoring refresh rate)", xres, yres);
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -866,6 +866,7 @@ extern const unsigned char *fb_firmware_
 extern void fb_edid_to_monspecs(unsigned char *edid,
 				struct fb_monspecs *specs);
 extern void fb_destroy_modedb(struct fb_videomode *modedb);
+extern int fb_find_mode_cvt(struct fb_videomode *mode, int margins, int rb);
 
 /* drivers/video/modedb.c */
 #define VESA_MODEDB_SIZE 34





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
