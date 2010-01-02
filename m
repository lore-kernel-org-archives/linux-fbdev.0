From: Erik-Jan <ej.lfs@xs4all.nl>
Date: Sat, 02 Jan 2010 22:25:48 +0000
Subject: Re: PROBLEM: loading viafb module turns screen to black on VN896
Message-Id: <4B3FC7EC.604@xs4all.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030702060108020002080402"
List-Id: <linux-fbdev.vger.kernel.org>
References: <4B2E133B.9060502@web.de>
In-Reply-To: <4B2E133B.9060502@web.de>
To: linux-fbdev@vger.kernel.org

This is a multi-part message in MIME format.
--------------030702060108020002080402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Julian Wollrath wrote:
 > Hi,
 >
 > since I switched from 2.6.31.8 to 2.6.32.2 loading the viafb module
 > turns the screen to black, there is no graphic output on the screen 
anymore.

I had the same sort of problem with CLE266. Only I didn't get a black 
screen, but a scrambled-up screen, as if the timings were wrong.
Not surprisingly, it all has to do with the 2D engine rewrite (around 
commit c3e25673843153ea75fda79a47cf12f10a25ca37) that has been done in 
2.6.32.

I found a few small things in the initialization of the framebuffer, 
that were present in 2.6.31 but removed in 2.6.32.
Attached a patch that puts these changes back in. I don't know if I've 
done some bad things (never done any kernel coding before) nor if it is 
OK for all the different VIA hardware out there, but on my CLE266 it now 
works as before.

The changes to accel.c are needed for a correct boot; the other changes 
are needed for changing the framebuffer mode with fbset.

Bye,
Erik-Jan




--------------030702060108020002080402
Content-Type: text/plain;
 name="linux-2.6.32.2-viafb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.32.2-viafb.patch"

diff -Naur linux-2.6.32.2-orig/drivers/video/via/accel.c linux-2.6.32.2/drivers/video/via/accel.c
--- linux-2.6.32.2-orig/drivers/video/via/accel.c	2009-12-31 00:38:03.000000000 +0100
+++ linux-2.6.32.2/drivers/video/via/accel.c	2009-12-31 00:38:23.000000000 +0100
@@ -137,7 +137,7 @@
 			tmp, dst_pitch);
 		return -EINVAL;
 	}
-	tmp = (tmp >> 3) | (dst_pitch << (16 - 3));
+	tmp = VIA_PITCH_ENABLE | (tmp >> 3) | (dst_pitch << (16 - 3));
 	writel(tmp, engine + 0x38);
 
 	if (op == VIA_BITBLT_FILL)
@@ -352,6 +352,9 @@
 	viapar->shared->vq_vram_addr = viapar->fbmem_free;
 	viapar->fbmem_used += VQ_SIZE;
 
+	/* Init 2D engine reg to reset 2D engine */
+	writel(0x0, engine + VIA_REG_KEYCONTROL);
+
 	/* Init AGP and VQ regs */
 	switch (chip_name) {
 	case UNICHROME_K8M890:
diff -Naur linux-2.6.32.2-orig/drivers/video/via/hw.c linux-2.6.32.2/drivers/video/via/hw.c
--- linux-2.6.32.2-orig/drivers/video/via/hw.c	2009-12-18 23:27:07.000000000 +0100
+++ linux-2.6.32.2/drivers/video/via/hw.c	2010-01-01 19:04:30.000000000 +0100
@@ -2348,6 +2348,7 @@
 		}
 	}
 
+	viafb_update_fix(viafbinfo);
 	viafb_set_primary_pitch(viafbinfo->fix.line_length);
 	viafb_set_secondary_pitch(viafb_dual_fb ? viafbinfo1->fix.line_length
 		: viafbinfo->fix.line_length);
diff -Naur linux-2.6.32.2-orig/drivers/video/via/viafbdev.c linux-2.6.32.2/drivers/video/via/viafbdev.c
--- linux-2.6.32.2-orig/drivers/video/via/viafbdev.c	2009-12-18 23:27:07.000000000 +0100
+++ linux-2.6.32.2/drivers/video/via/viafbdev.c	2010-01-01 19:03:21.000000000 +0100
@@ -54,7 +54,7 @@
 static struct fb_ops viafb_ops;
 
 
-static void viafb_update_fix(struct fb_info *info)
+void viafb_update_fix(struct fb_info *info)
 {
 	u32 bpp = info->var.bits_per_pixel;
 
diff -Naur linux-2.6.32.2-orig/drivers/video/via/viafbdev.h linux-2.6.32.2/drivers/video/via/viafbdev.h
--- linux-2.6.32.2-orig/drivers/video/via/viafbdev.h	2009-12-18 23:27:07.000000000 +0100
+++ linux-2.6.32.2/drivers/video/via/viafbdev.h	2010-01-01 19:03:42.000000000 +0100
@@ -99,6 +99,7 @@
 void viafb_fill_var_timing_info(struct fb_var_screeninfo *var, int refresh,
 			  int mode_index);
 int viafb_get_mode_index(int hres, int vres);
+void viafb_update_fix(struct fb_info *info);
 u8 viafb_gpio_i2c_read_lvds(struct lvds_setting_information
 	*plvds_setting_info, struct lvds_chip_information
 	*plvds_chip_info, u8 index);

--------------030702060108020002080402--
