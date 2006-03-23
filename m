From: Mardy <mardy@users.sourceforge.net>
Subject: [PATCH] Add acceleration support to ATI Imageon (new patch)
Date: Thu, 23 Mar 2006 18:18:55 +0100
Message-ID: <20060323171855.GB15382@pupilla>
References: <20060323112930.GA10090@pupilla> <4422987A.7030900@pol.net> <44229A2E.1040109@pol.net> <20060323132825.GB10824@pupilla>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMTSw-00022g-JB
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 09:19:18 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1FMTSu-0001VE-7y
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 09:19:18 -0800
Content-Disposition: inline
In-Reply-To: <20060323132825.GB10824@pupilla>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@pol.net>, Richard Purdie <rpurdie@rpsys.net>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
  Here's the patch; I changed w100_wait_complete() in w100fb_sync(), and
it works correctly.
I'm a bit uncertain about the return value of w100fb_sync(); it should
be an int, but by grepping the sources I couldn't find any place where
its return value is checked. Anyway, I choose to return 0 if everything
is OK, or -EBUSY for timeout.


Signed-off-by: Alberto Mardegan <mardy@users.sourceforge.net>

-- 
Saluti,
    Mardy
http://interlingua.altervista.org

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="w100fb.patch"

Index: linux-2.6.15/drivers/video/w100fb.c
===================================================================
--- linux-2.6.15.orig/drivers/video/w100fb.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/drivers/video/w100fb.c	2006-03-23 17:15:57.000000000 +0100
@@ -4,8 +4,9 @@
  * Frame Buffer Device for ATI Imageon w100 (Wallaby)
  *
  * Copyright (C) 2002, ATI Corp.
- * Copyright (C) 2004-2005 Richard Purdie
+ * Copyright (C) 2004-2006 Richard Purdie
  * Copyright (c) 2005 Ian Molton
+ * Copyright (c) 2006 Alberto Mardegan
  *
  * Rewritten for 2.6 by Richard Purdie <rpurdie@rpsys.net>
  *
@@ -14,6 +15,9 @@
  *
  * w32xx support by Ian Molton
  *
+ * Hardware acceleration support by Alberto Mardegan
+ * <mardy@users.sourceforge.net>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -47,6 +51,7 @@
 static void w100_update_enable(void);
 static void w100_update_disable(void);
 static void calc_hsync(struct w100fb_par *par);
+static void w100_init_graphic_engine(struct w100fb_par *par);
 struct w100_pll_info *w100_get_xtal_table(unsigned int freq);
 
 /* Pseudo palette size */
@@ -248,6 +253,152 @@
 }
 
 
+static void w100_fifo_wait(int entries)
+{
+	union rbbm_status_u status;
+	int i;
+
+	for (i = 0; i < 2000000; i++) {
+		status.val = readl(remapped_regs + mmRBBM_STATUS);
+		if (status.f.cmdfifo_avail >= entries)
+			return;
+		udelay(1);
+	}
+	printk(KERN_ERR "w100fb: FIFO Timeout!\n");
+}
+
+
+static int w100fb_sync(struct fb_info *info)
+{
+	union rbbm_status_u status;
+	int i;
+
+	for (i = 0; i < 2000000; i++) {
+		status.val = readl(remapped_regs + mmRBBM_STATUS);
+		if (!status.f.gui_active)
+			return 0;
+		udelay(1);
+	}
+	printk(KERN_ERR "w100fb: Graphic engine timeout!\n");
+	return -EBUSY;
+}
+
+
+static void w100_init_graphic_engine(struct w100fb_par *par)
+{
+	union dp_gui_master_cntl_u gmc;
+	union dp_mix_u dp_mix;
+	union dp_datatype_u dp_datatype;
+	union dp_cntl_u dp_cntl;
+
+	w100_fifo_wait(4);
+	writel(W100_FB_BASE, remapped_regs + mmDST_OFFSET);
+	writel(par->xres, remapped_regs + mmDST_PITCH);
+	writel(W100_FB_BASE, remapped_regs + mmSRC_OFFSET);
+	writel(par->xres, remapped_regs + mmSRC_PITCH);
+
+	w100_fifo_wait(3);
+	writel(0, remapped_regs + mmSC_TOP_LEFT);
+	writel((par->yres << 16) | par->xres, remapped_regs + mmSC_BOTTOM_RIGHT);
+	writel(0x1fff1fff, remapped_regs + mmSRC_SC_BOTTOM_RIGHT);
+
+	w100_fifo_wait(4);
+	dp_cntl.val = 0;
+	dp_cntl.f.dst_x_dir = 1;
+	dp_cntl.f.dst_y_dir = 1;
+	dp_cntl.f.src_x_dir = 1;
+	dp_cntl.f.src_y_dir = 1;
+	dp_cntl.f.dst_major_x = 1;
+	dp_cntl.f.src_major_x = 1;
+	writel(dp_cntl.val, remapped_regs + mmDP_CNTL);
+
+	gmc.val = 0;
+	gmc.f.gmc_src_pitch_offset_cntl = 1;
+	gmc.f.gmc_dst_pitch_offset_cntl = 1;
+	gmc.f.gmc_src_clipping = 1;
+	gmc.f.gmc_dst_clipping = 1;
+	gmc.f.gmc_brush_datatype = GMC_BRUSH_NONE;
+	gmc.f.gmc_dst_datatype = 3; /* from DstType_16Bpp_444 */
+	gmc.f.gmc_src_datatype = SRC_DATATYPE_EQU_DST;
+	gmc.f.gmc_byte_pix_order = 1;
+	gmc.f.gmc_default_sel = 0;
+	gmc.f.gmc_rop3 = ROP3_SRCCOPY;
+	gmc.f.gmc_dp_src_source = DP_SRC_MEM_RECTANGULAR;
+	gmc.f.gmc_clr_cmp_fcn_dis = 1;
+	gmc.f.gmc_wr_msk_dis = 1;
+	gmc.f.gmc_dp_op = DP_OP_ROP;
+	writel(gmc.val, remapped_regs + mmDP_GUI_MASTER_CNTL);
+
+	dp_datatype.val = dp_mix.val = 0;
+	dp_datatype.f.dp_dst_datatype = gmc.f.gmc_dst_datatype;
+	dp_datatype.f.dp_brush_datatype = gmc.f.gmc_brush_datatype;
+	dp_datatype.f.dp_src2_type = 0;
+	dp_datatype.f.dp_src2_datatype = gmc.f.gmc_src_datatype;
+	dp_datatype.f.dp_src_datatype = gmc.f.gmc_src_datatype;
+	dp_datatype.f.dp_byte_pix_order = gmc.f.gmc_byte_pix_order;
+	writel(dp_datatype.val, remapped_regs + mmDP_DATATYPE);
+
+	dp_mix.f.dp_src_source = gmc.f.gmc_dp_src_source;
+	dp_mix.f.dp_src2_source = 1;
+	dp_mix.f.dp_rop3 = gmc.f.gmc_rop3;
+	dp_mix.f.dp_op = gmc.f.gmc_dp_op;
+	writel(dp_mix.val, remapped_regs + mmDP_MIX);
+}
+
+
+static void w100fb_fillrect(struct fb_info *info,
+                            const struct fb_fillrect *rect)
+{
+	union dp_gui_master_cntl_u gmc;
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+	if (info->flags & FBINFO_HWACCEL_DISABLED) {
+		cfb_fillrect(info, rect);
+		return;
+	}
+
+	gmc.val = readl(remapped_regs + mmDP_GUI_MASTER_CNTL);
+	gmc.f.gmc_rop3 = ROP3_PATCOPY;
+	gmc.f.gmc_brush_datatype = GMC_BRUSH_SOLID_COLOR;
+	w100_fifo_wait(2);
+	writel(gmc.val, remapped_regs + mmDP_GUI_MASTER_CNTL);
+	writel(rect->color, remapped_regs + mmDP_BRUSH_FRGD_CLR);
+
+	w100_fifo_wait(2);
+	writel((rect->dy << 16) | (rect->dx & 0xffff), remapped_regs + mmDST_Y_X);
+	writel((rect->width << 16) | (rect->height & 0xffff),
+	       remapped_regs + mmDST_WIDTH_HEIGHT);
+}
+
+
+static void w100fb_copyarea(struct fb_info *info,
+                            const struct fb_copyarea *area)
+{
+	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy;
+	u32 h = area->height, w = area->width;
+	union dp_gui_master_cntl_u gmc;
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+	if (info->flags & FBINFO_HWACCEL_DISABLED) {
+		cfb_copyarea(info, area);
+		return;
+	}
+
+	gmc.val = readl(remapped_regs + mmDP_GUI_MASTER_CNTL);
+	gmc.f.gmc_rop3 = ROP3_SRCCOPY;
+	gmc.f.gmc_brush_datatype = GMC_BRUSH_NONE;
+	w100_fifo_wait(1);
+	writel(gmc.val, remapped_regs + mmDP_GUI_MASTER_CNTL);
+
+	w100_fifo_wait(3);
+	writel((sy << 16) | (sx & 0xffff), remapped_regs + mmSRC_Y_X);
+	writel((dy << 16) | (dx & 0xffff), remapped_regs + mmDST_Y_X);
+	writel((w << 16) | (h & 0xffff), remapped_regs + mmDST_WIDTH_HEIGHT);
+}
+
+
 /*
  *  Change the resolution by calling the appropriate hardware functions
  */
@@ -265,6 +416,7 @@
 	w100_init_lcd(par);
 	w100_set_dispregs(par);
 	w100_update_enable();
+	w100_init_graphic_engine(par);
 
 	calc_hsync(par);
 
@@ -394,9 +546,10 @@
 	.fb_set_par   = w100fb_set_par,
 	.fb_setcolreg = w100fb_setcolreg,
 	.fb_blank     = w100fb_blank,
-	.fb_fillrect  = cfb_fillrect,
-	.fb_copyarea  = cfb_copyarea,
+	.fb_fillrect  = w100fb_fillrect,
+	.fb_copyarea  = w100fb_copyarea,
 	.fb_imageblit = cfb_imageblit,
+	.fb_sync      = w100fb_sync,
 };
 
 #ifdef CONFIG_PM
@@ -543,7 +696,8 @@
 	}
 
 	info->fbops = &w100fb_ops;
-	info->flags = FBINFO_DEFAULT;
+	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_COPYAREA |
+		FBINFO_HWACCEL_FILLRECT;
 	info->node = -1;
 	info->screen_base = remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE);
 	info->screen_size = REMAPPED_FB_LEN;
Index: linux-2.6.15/drivers/video/w100fb.h
===================================================================
--- linux-2.6.15.orig/drivers/video/w100fb.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/drivers/video/w100fb.h	2006-03-23 17:24:40.000000000 +0100
@@ -122,15 +122,32 @@
 /* Block DISPLAY End: */
 
 /* Block GFX Start: */
+#define mmDST_OFFSET          0x1004
+#define mmDST_PITCH           0x1008
+#define mmDST_Y_X             0x1038
+#define mmDST_WIDTH_HEIGHT    0x1198
+#define mmDP_GUI_MASTER_CNTL  0x106C
 #define mmBRUSH_OFFSET        0x108C
 #define mmBRUSH_Y_X           0x1074
+#define mmDP_BRUSH_FRGD_CLR   0x107C
+#define mmSRC_OFFSET          0x11AC
+#define mmSRC_PITCH           0x11B0
+#define mmSRC_Y_X             0x1034
 #define mmDEFAULT_PITCH_OFFSET      0x10A0
 #define mmDEFAULT_SC_BOTTOM_RIGHT   0x10A8
 #define mmDEFAULT2_SC_BOTTOM_RIGHT  0x10AC
+#define mmSC_TOP_LEFT         0x11BC
+#define mmSC_BOTTOM_RIGHT     0x11C0
+#define mmSRC_SC_BOTTOM_RIGHT 0x11C4
 #define mmGLOBAL_ALPHA        0x1210
 #define mmFILTER_COEF         0x1214
 #define mmMVC_CNTL_START      0x11E0
 #define mmE2_ARITHMETIC_CNTL  0x1220
+#define mmDP_CNTL             0x11C8
+#define mmDP_CNTL_DST_DIR     0x11CC
+#define mmDP_DATATYPE         0x12C4
+#define mmDP_MIX              0x12C8
+#define mmDP_WRITE_MSK        0x12CC
 #define mmENG_CNTL            0x13E8
 #define mmENG_PERF_CNT        0x13F0
 /* Block GFX End: */
@@ -179,6 +196,7 @@
 /* Block RBBM Start: */
 #define mmWAIT_UNTIL        0x1400
 #define mmISYNC_CNTL        0x1404
+#define mmRBBM_STATUS       0x0140
 #define mmRBBM_CNTL         0x0144
 #define mmNQWAIT_UNTIL      0x0150
 /* Block RBBM End: */
@@ -766,5 +784,145 @@
 	struct pwrmgt_cntl_t f;
 } __attribute__((packed));
 
+#define SRC_DATATYPE_EQU_DST	3
+
+#define ROP3_SRCCOPY	0xcc
+#define ROP3_PATCOPY	0xf0
+
+#define GMC_BRUSH_SOLID_COLOR	13
+#define GMC_BRUSH_NONE			15
+
+#define DP_SRC_MEM_RECTANGULAR	2
+
+#define DP_OP_ROP	0
+
+struct dp_gui_master_cntl_t {
+	unsigned long gmc_src_pitch_offset_cntl : 1;
+	unsigned long gmc_dst_pitch_offset_cntl : 1;
+	unsigned long gmc_src_clipping          : 1;
+	unsigned long gmc_dst_clipping          : 1;
+	unsigned long gmc_brush_datatype        : 4;
+	unsigned long gmc_dst_datatype          : 4;
+	unsigned long gmc_src_datatype          : 3;
+	unsigned long gmc_byte_pix_order        : 1;
+	unsigned long gmc_default_sel           : 1;
+	unsigned long gmc_rop3                  : 8;
+	unsigned long gmc_dp_src_source         : 3;
+	unsigned long gmc_clr_cmp_fcn_dis       : 1;
+	unsigned long                           : 1;
+	unsigned long gmc_wr_msk_dis            : 1;
+	unsigned long gmc_dp_op                 : 1;
+} __attribute__((packed));
+
+union dp_gui_master_cntl_u {
+	unsigned long val : 32;
+	struct dp_gui_master_cntl_t f;
+} __attribute__((packed));
+
+struct rbbm_status_t {
+	unsigned long cmdfifo_avail   : 7;
+	unsigned long                 : 1;
+	unsigned long hirq_on_rbb     : 1;
+	unsigned long cprq_on_rbb     : 1;
+	unsigned long cfrq_on_rbb     : 1;
+	unsigned long hirq_in_rtbuf   : 1;
+	unsigned long cprq_in_rtbuf   : 1;
+	unsigned long cfrq_in_rtbuf   : 1;
+	unsigned long cf_pipe_busy    : 1;
+	unsigned long eng_ev_busy     : 1;
+	unsigned long cp_cmdstrm_busy : 1;
+	unsigned long e2_busy         : 1;
+	unsigned long rb2d_busy       : 1;
+	unsigned long rb3d_busy       : 1;
+	unsigned long se_busy         : 1;
+	unsigned long re_busy         : 1;
+	unsigned long tam_busy        : 1;
+	unsigned long tdm_busy        : 1;
+	unsigned long pb_busy         : 1;
+	unsigned long                 : 6;
+	unsigned long gui_active      : 1;
+} __attribute__((packed));
+
+union rbbm_status_u {
+	unsigned long val : 32;
+	struct rbbm_status_t f;
+} __attribute__((packed));
+
+struct dp_datatype_t {
+	unsigned long dp_dst_datatype   : 4;
+	unsigned long                   : 4;
+	unsigned long dp_brush_datatype : 4;
+	unsigned long dp_src2_type      : 1;
+	unsigned long dp_src2_datatype  : 3;
+	unsigned long dp_src_datatype   : 3;
+	unsigned long                   : 11;
+	unsigned long dp_byte_pix_order : 1;
+	unsigned long                   : 1;
+} __attribute__((packed));
+
+union dp_datatype_u {
+	unsigned long val : 32;
+	struct dp_datatype_t f;
+} __attribute__((packed));
+
+struct dp_mix_t {
+	unsigned long                : 8;
+	unsigned long dp_src_source  : 3;
+	unsigned long dp_src2_source : 3;
+	unsigned long                : 2;
+	unsigned long dp_rop3        : 8;
+	unsigned long dp_op          : 1;
+	unsigned long                : 7;
+} __attribute__((packed));
+
+union dp_mix_u {
+	unsigned long val : 32;
+	struct dp_mix_t f;
+} __attribute__((packed));
+
+struct eng_cntl_t {
+	unsigned long erc_reg_rd_ws            : 1;
+	unsigned long erc_reg_wr_ws            : 1;
+	unsigned long erc_idle_reg_wr          : 1;
+	unsigned long dis_engine_triggers      : 1;
+	unsigned long dis_rop_src_uses_dst_w_h : 1;
+	unsigned long dis_src_uses_dst_dirmaj  : 1;
+	unsigned long                          : 6;
+	unsigned long force_3dclk_when_2dclk   : 1;
+	unsigned long                          : 19;
+} __attribute__((packed));
+
+union eng_cntl_u {
+	unsigned long val : 32;
+	struct eng_cntl_t f;
+} __attribute__((packed));
+
+struct dp_cntl_t {
+	unsigned long dst_x_dir   : 1;
+	unsigned long dst_y_dir   : 1;
+	unsigned long src_x_dir   : 1;
+	unsigned long src_y_dir   : 1;
+	unsigned long dst_major_x : 1;
+	unsigned long src_major_x : 1;
+	unsigned long             : 26;
+} __attribute__((packed));
+
+union dp_cntl_u {
+	unsigned long val : 32;
+	struct dp_cntl_t f;
+} __attribute__((packed));
+
+struct dp_cntl_dst_dir_t {
+	unsigned long           : 15;
+	unsigned long dst_y_dir : 1;
+	unsigned long           : 15;
+	unsigned long dst_x_dir : 1;
+} __attribute__((packed));
+
+union dp_cntl_dst_dir_u {
+	unsigned long val : 32;
+	struct dp_cntl_dst_dir_t f;
+} __attribute__((packed));
+
 #endif
 

--opJtzjQTFsWo+cga--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
