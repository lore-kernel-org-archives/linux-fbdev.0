From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/7] w100fb: Add acceleration support to ATI Imageon
Date: Mon, 27 Mar 2006 20:59:54 +0800
Message-ID: <4427E1CA.6040505@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNrXQ-0002YO-JL
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Mar 2006 05:13:40 -0800
Received: from xproxy.gmail.com ([66.249.82.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FNrXO-0007zZ-5I
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Mar 2006 05:13:40 -0800
Received: by xproxy.gmail.com with SMTP id t4so937073wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 27 Mar 2006 05:13:37 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Alberto Mardegan <mardy@users.sourceforge.net>, Richard Purdie <rpurdie@rpsys.net>

From: Alberto Mardegan <mardy@users.sourceforge.net>

Add acceleration support in w100fb.c (i.e. ATI Imageons) for the copyarea and
fillrect operations.

Signed-off-by: Alberto Mardegan <mardy@users.sourceforge.net>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/w100fb.c |  162 ++++++++++
 drivers/video/w100fb.h |  748 +++++++++++++++++++++++++++++-------------------
 2 files changed, 611 insertions(+), 299 deletions(-)

diff --git a/drivers/video/w100fb.c b/drivers/video/w100fb.c
index f6e24ee..5fc86ea 100644
--- a/drivers/video/w100fb.c
+++ b/drivers/video/w100fb.c
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
@@ -47,6 +51,7 @@ static void w100_set_dispregs(struct w10
 static void w100_update_enable(void);
 static void w100_update_disable(void);
 static void calc_hsync(struct w100fb_par *par);
+static void w100_init_graphic_engine(struct w100fb_par *par);
 struct w100_pll_info *w100_get_xtal_table(unsigned int freq);
 
 /* Pseudo palette size */
@@ -248,6 +253,152 @@ static int w100fb_blank(int blank_mode, 
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
@@ -265,6 +416,7 @@ static void w100fb_activate_var(struct w
 	w100_init_lcd(par);
 	w100_set_dispregs(par);
 	w100_update_enable();
+	w100_init_graphic_engine(par);
 
 	calc_hsync(par);
 
@@ -394,9 +546,10 @@ static struct fb_ops w100fb_ops = {
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
@@ -543,7 +696,8 @@ int __init w100fb_probe(struct platform_
 	}
 
 	info->fbops = &w100fb_ops;
-	info->flags = FBINFO_DEFAULT;
+	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_COPYAREA |
+		FBINFO_HWACCEL_FILLRECT;
 	info->node = -1;
 	info->screen_base = remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE);
 	info->screen_size = REMAPPED_FB_LEN;
diff --git a/drivers/video/w100fb.h b/drivers/video/w100fb.h
index 7a58a1e..fffae7b 100644
--- a/drivers/video/w100fb.h
+++ b/drivers/video/w100fb.h
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
@@ -225,147 +243,147 @@
 /* Register structure definitions */
 
 struct wrap_top_dir_t {
-	unsigned long top_addr  : 23;
-	unsigned long           : 9;
+	u32 top_addr  : 23;
+	u32           : 9;
 } __attribute__((packed));
 
 union wrap_top_dir_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct wrap_top_dir_t f;
 } __attribute__((packed));
 
 struct wrap_start_dir_t {
-	unsigned long start_addr : 23;
-	unsigned long            : 9;
+	u32 start_addr : 23;
+	u32            : 9;
 } __attribute__((packed));
 
 union wrap_start_dir_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct wrap_start_dir_t f;
 } __attribute__((packed));
 
 struct cif_cntl_t {
-	unsigned long swap_reg                 : 2;
-	unsigned long swap_fbuf_1              : 2;
-	unsigned long swap_fbuf_2              : 2;
-	unsigned long swap_fbuf_3              : 2;
-	unsigned long pmi_int_disable          : 1;
-	unsigned long pmi_schmen_disable       : 1;
-	unsigned long intb_oe                  : 1;
-	unsigned long en_wait_to_compensate_dq_prop_dly  : 1;
-	unsigned long compensate_wait_rd_size  : 2;
-	unsigned long wait_asserted_timeout_val  : 2;
-	unsigned long wait_masked_val          : 2;
-	unsigned long en_wait_timeout          : 1;
-	unsigned long en_one_clk_setup_before_wait  : 1;
-	unsigned long interrupt_active_high    : 1;
-	unsigned long en_overwrite_straps      : 1;
-	unsigned long strap_wait_active_hi     : 1;
-	unsigned long lat_busy_count           : 2;
-	unsigned long lat_rd_pm4_sclk_busy     : 1;
-	unsigned long dis_system_bits          : 1;
-	unsigned long dis_mr                   : 1;
-	unsigned long cif_spare_1              : 4;
+	u32 swap_reg                 : 2;
+	u32 swap_fbuf_1              : 2;
+	u32 swap_fbuf_2              : 2;
+	u32 swap_fbuf_3              : 2;
+	u32 pmi_int_disable          : 1;
+	u32 pmi_schmen_disable       : 1;
+	u32 intb_oe                  : 1;
+	u32 en_wait_to_compensate_dq_prop_dly  : 1;
+	u32 compensate_wait_rd_size  : 2;
+	u32 wait_asserted_timeout_val  : 2;
+	u32 wait_masked_val          : 2;
+	u32 en_wait_timeout          : 1;
+	u32 en_one_clk_setup_before_wait  : 1;
+	u32 interrupt_active_high    : 1;
+	u32 en_overwrite_straps      : 1;
+	u32 strap_wait_active_hi     : 1;
+	u32 lat_busy_count           : 2;
+	u32 lat_rd_pm4_sclk_busy     : 1;
+	u32 dis_system_bits          : 1;
+	u32 dis_mr                   : 1;
+	u32 cif_spare_1              : 4;
 } __attribute__((packed));
 
 union cif_cntl_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct cif_cntl_t f;
 } __attribute__((packed));
 
 struct cfgreg_base_t {
-	unsigned long cfgreg_base  : 24;
-	unsigned long              : 8;
+	u32 cfgreg_base  : 24;
+	u32              : 8;
 } __attribute__((packed));
 
 union cfgreg_base_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct cfgreg_base_t f;
 } __attribute__((packed));
 
 struct cif_io_t {
-	unsigned long dq_srp     : 1;
-	unsigned long dq_srn     : 1;
-	unsigned long dq_sp      : 4;
-	unsigned long dq_sn      : 4;
-	unsigned long waitb_srp  : 1;
-	unsigned long waitb_srn  : 1;
-	unsigned long waitb_sp   : 4;
-	unsigned long waitb_sn   : 4;
-	unsigned long intb_srp   : 1;
-	unsigned long intb_srn   : 1;
-	unsigned long intb_sp    : 4;
-	unsigned long intb_sn    : 4;
-	unsigned long            : 2;
+	u32 dq_srp     : 1;
+	u32 dq_srn     : 1;
+	u32 dq_sp      : 4;
+	u32 dq_sn      : 4;
+	u32 waitb_srp  : 1;
+	u32 waitb_srn  : 1;
+	u32 waitb_sp   : 4;
+	u32 waitb_sn   : 4;
+	u32 intb_srp   : 1;
+	u32 intb_srn   : 1;
+	u32 intb_sp    : 4;
+	u32 intb_sn    : 4;
+	u32            : 2;
 } __attribute__((packed));
 
 union cif_io_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct cif_io_t f;
 } __attribute__((packed));
 
 struct cif_read_dbg_t {
-	unsigned long unpacker_pre_fetch_trig_gen  : 2;
-	unsigned long dly_second_rd_fetch_trig     : 1;
-	unsigned long rst_rd_burst_id              : 1;
-	unsigned long dis_rd_burst_id              : 1;
-	unsigned long en_block_rd_when_packer_is_not_emp : 1;
-	unsigned long dis_pre_fetch_cntl_sm        : 1;
-	unsigned long rbbm_chrncy_dis              : 1;
-	unsigned long rbbm_rd_after_wr_lat         : 2;
-	unsigned long dis_be_during_rd             : 1;
-	unsigned long one_clk_invalidate_pulse     : 1;
-	unsigned long dis_chnl_priority            : 1;
-	unsigned long rst_read_path_a_pls          : 1;
-	unsigned long rst_read_path_b_pls          : 1;
-	unsigned long dis_reg_rd_fetch_trig        : 1;
-	unsigned long dis_rd_fetch_trig_from_ind_addr : 1;
-	unsigned long dis_rd_same_byte_to_trig_fetch : 1;
-	unsigned long dis_dir_wrap                 : 1;
-	unsigned long dis_ring_buf_to_force_dec    : 1;
-	unsigned long dis_addr_comp_in_16bit       : 1;
-	unsigned long clr_w                        : 1;
-	unsigned long err_rd_tag_is_3              : 1;
-	unsigned long err_load_when_ful_a          : 1;
-	unsigned long err_load_when_ful_b          : 1;
-	unsigned long                              : 7;
+	u32 unpacker_pre_fetch_trig_gen  : 2;
+	u32 dly_second_rd_fetch_trig     : 1;
+	u32 rst_rd_burst_id              : 1;
+	u32 dis_rd_burst_id              : 1;
+	u32 en_block_rd_when_packer_is_not_emp : 1;
+	u32 dis_pre_fetch_cntl_sm        : 1;
+	u32 rbbm_chrncy_dis              : 1;
+	u32 rbbm_rd_after_wr_lat         : 2;
+	u32 dis_be_during_rd             : 1;
+	u32 one_clk_invalidate_pulse     : 1;
+	u32 dis_chnl_priority            : 1;
+	u32 rst_read_path_a_pls          : 1;
+	u32 rst_read_path_b_pls          : 1;
+	u32 dis_reg_rd_fetch_trig        : 1;
+	u32 dis_rd_fetch_trig_from_ind_addr : 1;
+	u32 dis_rd_same_byte_to_trig_fetch : 1;
+	u32 dis_dir_wrap                 : 1;
+	u32 dis_ring_buf_to_force_dec    : 1;
+	u32 dis_addr_comp_in_16bit       : 1;
+	u32 clr_w                        : 1;
+	u32 err_rd_tag_is_3              : 1;
+	u32 err_load_when_ful_a          : 1;
+	u32 err_load_when_ful_b          : 1;
+	u32                              : 7;
 } __attribute__((packed));
 
 union cif_read_dbg_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct cif_read_dbg_t f;
 } __attribute__((packed));
 
 struct cif_write_dbg_t {
-	unsigned long packer_timeout_count          : 2;
-	unsigned long en_upper_load_cond            : 1;
-	unsigned long en_chnl_change_cond           : 1;
-	unsigned long dis_addr_comp_cond            : 1;
-	unsigned long dis_load_same_byte_addr_cond  : 1;
-	unsigned long dis_timeout_cond              : 1;
-	unsigned long dis_timeout_during_rbbm       : 1;
-	unsigned long dis_packer_ful_during_rbbm_timeout : 1;
-	unsigned long en_dword_split_to_rbbm        : 1;
-	unsigned long en_dummy_val                  : 1;
-	unsigned long dummy_val_sel                 : 1;
-	unsigned long mask_pm4_wrptr_dec            : 1;
-	unsigned long dis_mc_clean_cond             : 1;
-	unsigned long err_two_reqi_during_ful       : 1;
-	unsigned long err_reqi_during_idle_clk      : 1;
-	unsigned long err_global                    : 1;
-	unsigned long en_wr_buf_dbg_load            : 1;
-	unsigned long en_wr_buf_dbg_path            : 1;
-	unsigned long sel_wr_buf_byte               : 3;
-	unsigned long dis_rd_flush_wr               : 1;
-	unsigned long dis_packer_ful_cond           : 1;
-	unsigned long dis_invalidate_by_ops_chnl    : 1;
-	unsigned long en_halt_when_reqi_err         : 1;
-	unsigned long cif_spare_2                   : 5;
-	unsigned long                               : 1;
+	u32 packer_timeout_count          : 2;
+	u32 en_upper_load_cond            : 1;
+	u32 en_chnl_change_cond           : 1;
+	u32 dis_addr_comp_cond            : 1;
+	u32 dis_load_same_byte_addr_cond  : 1;
+	u32 dis_timeout_cond              : 1;
+	u32 dis_timeout_during_rbbm       : 1;
+	u32 dis_packer_ful_during_rbbm_timeout : 1;
+	u32 en_dword_split_to_rbbm        : 1;
+	u32 en_dummy_val                  : 1;
+	u32 dummy_val_sel                 : 1;
+	u32 mask_pm4_wrptr_dec            : 1;
+	u32 dis_mc_clean_cond             : 1;
+	u32 err_two_reqi_during_ful       : 1;
+	u32 err_reqi_during_idle_clk      : 1;
+	u32 err_global                    : 1;
+	u32 en_wr_buf_dbg_load            : 1;
+	u32 en_wr_buf_dbg_path            : 1;
+	u32 sel_wr_buf_byte               : 3;
+	u32 dis_rd_flush_wr               : 1;
+	u32 dis_packer_ful_cond           : 1;
+	u32 dis_invalidate_by_ops_chnl    : 1;
+	u32 en_halt_when_reqi_err         : 1;
+	u32 cif_spare_2                   : 5;
+	u32                               : 1;
 } __attribute__((packed));
 
 union cif_write_dbg_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct cif_write_dbg_t f;
 } __attribute__((packed));
 
@@ -403,327 +421,327 @@ union cpu_defaults_u {
 } __attribute__((packed));
 
 struct crtc_total_t {
-	unsigned long crtc_h_total : 10;
-	unsigned long              : 6;
-	unsigned long crtc_v_total : 10;
-	unsigned long              : 6;
+	u32 crtc_h_total : 10;
+	u32              : 6;
+	u32 crtc_v_total : 10;
+	u32              : 6;
 } __attribute__((packed));
 
 union crtc_total_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct crtc_total_t f;
 } __attribute__((packed));
 
 struct crtc_ss_t {
-	unsigned long ss_start    : 10;
-	unsigned long             : 6;
-	unsigned long ss_end      : 10;
-	unsigned long             : 2;
-	unsigned long ss_align    : 1;
-	unsigned long ss_pol      : 1;
-	unsigned long ss_run_mode : 1;
-	unsigned long ss_en       : 1;
+	u32 ss_start    : 10;
+	u32             : 6;
+	u32 ss_end      : 10;
+	u32             : 2;
+	u32 ss_align    : 1;
+	u32 ss_pol      : 1;
+	u32 ss_run_mode : 1;
+	u32 ss_en       : 1;
 } __attribute__((packed));
 
 union crtc_ss_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct crtc_ss_t f;
 } __attribute__((packed));
 
 struct active_h_disp_t {
-	unsigned long active_h_start  : 10;
-	unsigned long                 : 6;
-	unsigned long active_h_end    : 10;
-	unsigned long                 : 6;
+	u32 active_h_start  : 10;
+	u32                 : 6;
+	u32 active_h_end    : 10;
+	u32                 : 6;
 } __attribute__((packed));
 
 union active_h_disp_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct active_h_disp_t f;
 } __attribute__((packed));
 
 struct active_v_disp_t {
-	unsigned long active_v_start  : 10;
-	unsigned long                 : 6;
-	unsigned long active_v_end    : 10;
-	unsigned long                 : 6;
+	u32 active_v_start  : 10;
+	u32                 : 6;
+	u32 active_v_end    : 10;
+	u32                 : 6;
 } __attribute__((packed));
 
 union active_v_disp_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct active_v_disp_t f;
 } __attribute__((packed));
 
 struct graphic_h_disp_t {
-	unsigned long graphic_h_start : 10;
-	unsigned long                 : 6;
-	unsigned long graphic_h_end   : 10;
-	unsigned long                 : 6;
+	u32 graphic_h_start : 10;
+	u32                 : 6;
+	u32 graphic_h_end   : 10;
+	u32                 : 6;
 } __attribute__((packed));
 
 union graphic_h_disp_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct graphic_h_disp_t f;
 } __attribute__((packed));
 
 struct graphic_v_disp_t {
-	unsigned long graphic_v_start : 10;
-	unsigned long                 : 6;
-	unsigned long graphic_v_end   : 10;
-	unsigned long                 : 6;
+	u32 graphic_v_start : 10;
+	u32                 : 6;
+	u32 graphic_v_end   : 10;
+	u32                 : 6;
 } __attribute__((packed));
 
 union graphic_v_disp_u{
-	unsigned long val : 32;
+	u32 val : 32;
 	struct graphic_v_disp_t f;
 } __attribute__((packed));
 
 struct graphic_ctrl_t_w100 {
-	unsigned long color_depth       : 3;
-	unsigned long portrait_mode     : 2;
-	unsigned long low_power_on      : 1;
-	unsigned long req_freq          : 4;
-	unsigned long en_crtc           : 1;
-	unsigned long en_graphic_req    : 1;
-	unsigned long en_graphic_crtc   : 1;
-	unsigned long total_req_graphic : 9;
-	unsigned long lcd_pclk_on       : 1;
-	unsigned long lcd_sclk_on       : 1;
-	unsigned long pclk_running      : 1;
-	unsigned long sclk_running      : 1;
-	unsigned long                   : 6;
+	u32 color_depth       : 3;
+	u32 portrait_mode     : 2;
+	u32 low_power_on      : 1;
+	u32 req_freq          : 4;
+	u32 en_crtc           : 1;
+	u32 en_graphic_req    : 1;
+	u32 en_graphic_crtc   : 1;
+	u32 total_req_graphic : 9;
+	u32 lcd_pclk_on       : 1;
+	u32 lcd_sclk_on       : 1;
+	u32 pclk_running      : 1;
+	u32 sclk_running      : 1;
+	u32                   : 6;
 } __attribute__((packed));
 
 struct graphic_ctrl_t_w32xx {
-	unsigned long color_depth       : 3;
-	unsigned long portrait_mode     : 2;
-	unsigned long low_power_on      : 1;
-	unsigned long req_freq          : 4;
-	unsigned long en_crtc           : 1;
-	unsigned long en_graphic_req    : 1;
-	unsigned long en_graphic_crtc   : 1;
-	unsigned long total_req_graphic : 10;
-	unsigned long lcd_pclk_on       : 1;
-	unsigned long lcd_sclk_on       : 1;
-	unsigned long pclk_running      : 1;
-	unsigned long sclk_running      : 1;
-	unsigned long                   : 5;
+	u32 color_depth       : 3;
+	u32 portrait_mode     : 2;
+	u32 low_power_on      : 1;
+	u32 req_freq          : 4;
+	u32 en_crtc           : 1;
+	u32 en_graphic_req    : 1;
+	u32 en_graphic_crtc   : 1;
+	u32 total_req_graphic : 10;
+	u32 lcd_pclk_on       : 1;
+	u32 lcd_sclk_on       : 1;
+	u32 pclk_running      : 1;
+	u32 sclk_running      : 1;
+	u32                   : 5;
 } __attribute__((packed));
 
 union graphic_ctrl_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct graphic_ctrl_t_w100 f_w100;
 	struct graphic_ctrl_t_w32xx f_w32xx;
 } __attribute__((packed));
 
 struct video_ctrl_t {
-	unsigned long video_mode       : 1;
-	unsigned long keyer_en         : 1;
-	unsigned long en_video_req     : 1;
-	unsigned long en_graphic_req_video  : 1;
-	unsigned long en_video_crtc    : 1;
-	unsigned long video_hor_exp    : 2;
-	unsigned long video_ver_exp    : 2;
-	unsigned long uv_combine       : 1;
-	unsigned long total_req_video  : 9;
-	unsigned long video_ch_sel     : 1;
-	unsigned long video_portrait   : 2;
-	unsigned long yuv2rgb_en       : 1;
-	unsigned long yuv2rgb_option   : 1;
-	unsigned long video_inv_hor    : 1;
-	unsigned long video_inv_ver    : 1;
-	unsigned long gamma_sel        : 2;
-	unsigned long dis_limit        : 1;
-	unsigned long en_uv_hblend     : 1;
-	unsigned long rgb_gamma_sel    : 2;
+	u32 video_mode       : 1;
+	u32 keyer_en         : 1;
+	u32 en_video_req     : 1;
+	u32 en_graphic_req_video  : 1;
+	u32 en_video_crtc    : 1;
+	u32 video_hor_exp    : 2;
+	u32 video_ver_exp    : 2;
+	u32 uv_combine       : 1;
+	u32 total_req_video  : 9;
+	u32 video_ch_sel     : 1;
+	u32 video_portrait   : 2;
+	u32 yuv2rgb_en       : 1;
+	u32 yuv2rgb_option   : 1;
+	u32 video_inv_hor    : 1;
+	u32 video_inv_ver    : 1;
+	u32 gamma_sel        : 2;
+	u32 dis_limit        : 1;
+	u32 en_uv_hblend     : 1;
+	u32 rgb_gamma_sel    : 2;
 } __attribute__((packed));
 
 union video_ctrl_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct video_ctrl_t f;
 } __attribute__((packed));
 
 struct disp_db_buf_cntl_rd_t {
-	unsigned long en_db_buf           : 1;
-	unsigned long update_db_buf_done  : 1;
-	unsigned long db_buf_cntl         : 6;
-	unsigned long                     : 24;
+	u32 en_db_buf           : 1;
+	u32 update_db_buf_done  : 1;
+	u32 db_buf_cntl         : 6;
+	u32                     : 24;
 } __attribute__((packed));
 
 union disp_db_buf_cntl_rd_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct disp_db_buf_cntl_rd_t f;
 } __attribute__((packed));
 
 struct disp_db_buf_cntl_wr_t {
-	unsigned long en_db_buf      : 1;
-	unsigned long update_db_buf  : 1;
-	unsigned long db_buf_cntl    : 6;
-	unsigned long                : 24;
+	u32 en_db_buf      : 1;
+	u32 update_db_buf  : 1;
+	u32 db_buf_cntl    : 6;
+	u32                : 24;
 } __attribute__((packed));
 
 union disp_db_buf_cntl_wr_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct disp_db_buf_cntl_wr_t f;
 } __attribute__((packed));
 
 struct gamma_value1_t {
-	unsigned long gamma1   : 8;
-	unsigned long gamma2   : 8;
-	unsigned long gamma3   : 8;
-	unsigned long gamma4   : 8;
+	u32 gamma1   : 8;
+	u32 gamma2   : 8;
+	u32 gamma3   : 8;
+	u32 gamma4   : 8;
 } __attribute__((packed));
 
 union gamma_value1_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct gamma_value1_t f;
 } __attribute__((packed));
 
 struct gamma_value2_t {
-	unsigned long gamma5   : 8;
-	unsigned long gamma6   : 8;
-	unsigned long gamma7   : 8;
-	unsigned long gamma8   : 8;
+	u32 gamma5   : 8;
+	u32 gamma6   : 8;
+	u32 gamma7   : 8;
+	u32 gamma8   : 8;
 } __attribute__((packed));
 
 union gamma_value2_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct gamma_value2_t f;
 } __attribute__((packed));
 
 struct gamma_slope_t {
-	unsigned long slope1   : 3;
-	unsigned long slope2   : 3;
-	unsigned long slope3   : 3;
-	unsigned long slope4   : 3;
-	unsigned long slope5   : 3;
-	unsigned long slope6   : 3;
-	unsigned long slope7   : 3;
-	unsigned long slope8   : 3;
-	unsigned long          : 8;
+	u32 slope1   : 3;
+	u32 slope2   : 3;
+	u32 slope3   : 3;
+	u32 slope4   : 3;
+	u32 slope5   : 3;
+	u32 slope6   : 3;
+	u32 slope7   : 3;
+	u32 slope8   : 3;
+	u32          : 8;
 } __attribute__((packed));
 
 union gamma_slope_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct gamma_slope_t f;
 } __attribute__((packed));
 
 struct mc_ext_mem_location_t {
-	unsigned long mc_ext_mem_start : 16;
-	unsigned long mc_ext_mem_top   : 16;
+	u32 mc_ext_mem_start : 16;
+	u32 mc_ext_mem_top   : 16;
 } __attribute__((packed));
 
 union mc_ext_mem_location_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct mc_ext_mem_location_t f;
 } __attribute__((packed));
 
 struct mc_fb_location_t {
-	unsigned long mc_fb_start      : 16;
-	unsigned long mc_fb_top        : 16;
+	u32 mc_fb_start      : 16;
+	u32 mc_fb_top        : 16;
 } __attribute__((packed));
 
 union mc_fb_location_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct mc_fb_location_t f;
 } __attribute__((packed));
 
 struct clk_pin_cntl_t {
-	unsigned long osc_en           : 1;
-	unsigned long osc_gain         : 5;
-	unsigned long dont_use_xtalin  : 1;
-	unsigned long xtalin_pm_en     : 1;
-	unsigned long xtalin_dbl_en    : 1;
-	unsigned long                  : 7;
-	unsigned long cg_debug         : 16;
+	u32 osc_en           : 1;
+	u32 osc_gain         : 5;
+	u32 dont_use_xtalin  : 1;
+	u32 xtalin_pm_en     : 1;
+	u32 xtalin_dbl_en    : 1;
+	u32                  : 7;
+	u32 cg_debug         : 16;
 } __attribute__((packed));
 
 union clk_pin_cntl_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct clk_pin_cntl_t f;
 } __attribute__((packed));
 
 struct pll_ref_fb_div_t {
-	unsigned long pll_ref_div      : 4;
-	unsigned long                  : 4;
-	unsigned long pll_fb_div_int   : 6;
-	unsigned long                  : 2;
-	unsigned long pll_fb_div_frac  : 3;
-	unsigned long                  : 1;
-	unsigned long pll_reset_time   : 4;
-	unsigned long pll_lock_time    : 8;
+	u32 pll_ref_div      : 4;
+	u32                  : 4;
+	u32 pll_fb_div_int   : 6;
+	u32                  : 2;
+	u32 pll_fb_div_frac  : 3;
+	u32                  : 1;
+	u32 pll_reset_time   : 4;
+	u32 pll_lock_time    : 8;
 } __attribute__((packed));
 
 union pll_ref_fb_div_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct pll_ref_fb_div_t f;
 } __attribute__((packed));
 
 struct pll_cntl_t {
-	unsigned long pll_pwdn        : 1;
-	unsigned long pll_reset       : 1;
-	unsigned long pll_pm_en       : 1;
-	unsigned long pll_mode        : 1;
-	unsigned long pll_refclk_sel  : 1;
-	unsigned long pll_fbclk_sel   : 1;
-	unsigned long pll_tcpoff      : 1;
-	unsigned long pll_pcp         : 3;
-	unsigned long pll_pvg         : 3;
-	unsigned long pll_vcofr       : 1;
-	unsigned long pll_ioffset     : 2;
-	unsigned long pll_pecc_mode   : 2;
-	unsigned long pll_pecc_scon   : 2;
-	unsigned long pll_dactal      : 4;
-	unsigned long pll_cp_clip     : 2;
-	unsigned long pll_conf        : 3;
-	unsigned long pll_mbctrl      : 2;
-	unsigned long pll_ring_off    : 1;
+	u32 pll_pwdn        : 1;
+	u32 pll_reset       : 1;
+	u32 pll_pm_en       : 1;
+	u32 pll_mode        : 1;
+	u32 pll_refclk_sel  : 1;
+	u32 pll_fbclk_sel   : 1;
+	u32 pll_tcpoff      : 1;
+	u32 pll_pcp         : 3;
+	u32 pll_pvg         : 3;
+	u32 pll_vcofr       : 1;
+	u32 pll_ioffset     : 2;
+	u32 pll_pecc_mode   : 2;
+	u32 pll_pecc_scon   : 2;
+	u32 pll_dactal      : 4;
+	u32 pll_cp_clip     : 2;
+	u32 pll_conf        : 3;
+	u32 pll_mbctrl      : 2;
+	u32 pll_ring_off    : 1;
 } __attribute__((packed));
 
 union pll_cntl_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct pll_cntl_t f;
 } __attribute__((packed));
 
 struct sclk_cntl_t {
-	unsigned long sclk_src_sel         : 2;
-	unsigned long                      : 2;
-	unsigned long sclk_post_div_fast   : 4;
-	unsigned long sclk_clkon_hys       : 3;
-	unsigned long sclk_post_div_slow   : 4;
-	unsigned long disp_cg_ok2switch_en : 1;
-	unsigned long sclk_force_reg       : 1;
-	unsigned long sclk_force_disp      : 1;
-	unsigned long sclk_force_mc        : 1;
-	unsigned long sclk_force_extmc     : 1;
-	unsigned long sclk_force_cp        : 1;
-	unsigned long sclk_force_e2        : 1;
-	unsigned long sclk_force_e3        : 1;
-	unsigned long sclk_force_idct      : 1;
-	unsigned long sclk_force_bist      : 1;
-	unsigned long busy_extend_cp       : 1;
-	unsigned long busy_extend_e2       : 1;
-	unsigned long busy_extend_e3       : 1;
-	unsigned long busy_extend_idct     : 1;
-	unsigned long                      : 3;
+	u32 sclk_src_sel         : 2;
+	u32                      : 2;
+	u32 sclk_post_div_fast   : 4;
+	u32 sclk_clkon_hys       : 3;
+	u32 sclk_post_div_slow   : 4;
+	u32 disp_cg_ok2switch_en : 1;
+	u32 sclk_force_reg       : 1;
+	u32 sclk_force_disp      : 1;
+	u32 sclk_force_mc        : 1;
+	u32 sclk_force_extmc     : 1;
+	u32 sclk_force_cp        : 1;
+	u32 sclk_force_e2        : 1;
+	u32 sclk_force_e3        : 1;
+	u32 sclk_force_idct      : 1;
+	u32 sclk_force_bist      : 1;
+	u32 busy_extend_cp       : 1;
+	u32 busy_extend_e2       : 1;
+	u32 busy_extend_e3       : 1;
+	u32 busy_extend_idct     : 1;
+	u32                      : 3;
 } __attribute__((packed));
 
 union sclk_cntl_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct sclk_cntl_t f;
 } __attribute__((packed));
 
 struct pclk_cntl_t {
-	unsigned long pclk_src_sel     : 2;
-	unsigned long                  : 2;
-	unsigned long pclk_post_div    : 4;
-	unsigned long                  : 8;
-	unsigned long pclk_force_disp  : 1;
-	unsigned long                  : 15;
+	u32 pclk_src_sel     : 2;
+	u32                  : 2;
+	u32 pclk_post_div    : 4;
+	u32                  : 8;
+	u32 pclk_force_disp  : 1;
+	u32                  : 15;
 } __attribute__((packed));
 
 union pclk_cntl_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct pclk_cntl_t f;
 } __attribute__((packed));
 
@@ -735,36 +753,176 @@ union pclk_cntl_u {
 #define TESTCLK_SRC_XTAL  0x06
 
 struct clk_test_cntl_t {
-	unsigned long testclk_sel      : 4;
-	unsigned long                  : 3;
-	unsigned long start_check_freq : 1;
-	unsigned long tstcount_rst     : 1;
-	unsigned long                  : 15;
-	unsigned long test_count       : 8;
+	u32 testclk_sel      : 4;
+	u32                  : 3;
+	u32 start_check_freq : 1;
+	u32 tstcount_rst     : 1;
+	u32                  : 15;
+	u32 test_count       : 8;
 } __attribute__((packed));
 
 union clk_test_cntl_u {
-	unsigned long val : 32;
+	u32 val : 32;
 	struct clk_test_cntl_t f;
 } __attribute__((packed));
 
 struct pwrmgt_cntl_t {
-	unsigned long pwm_enable           : 1;
-	unsigned long                      : 1;
-	unsigned long pwm_mode_req         : 2;
-	unsigned long pwm_wakeup_cond      : 2;
-	unsigned long pwm_fast_noml_hw_en  : 1;
-	unsigned long pwm_noml_fast_hw_en  : 1;
-	unsigned long pwm_fast_noml_cond   : 4;
-	unsigned long pwm_noml_fast_cond   : 4;
-	unsigned long pwm_idle_timer       : 8;
-	unsigned long pwm_busy_timer       : 8;
+	u32 pwm_enable           : 1;
+	u32                      : 1;
+	u32 pwm_mode_req         : 2;
+	u32 pwm_wakeup_cond      : 2;
+	u32 pwm_fast_noml_hw_en  : 1;
+	u32 pwm_noml_fast_hw_en  : 1;
+	u32 pwm_fast_noml_cond   : 4;
+	u32 pwm_noml_fast_cond   : 4;
+	u32 pwm_idle_timer       : 8;
+	u32 pwm_busy_timer       : 8;
 } __attribute__((packed));
 
 union pwrmgt_cntl_u {
-	unsigned long val : 32;
+	u32 val : 32;
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
+	u32 gmc_src_pitch_offset_cntl : 1;
+	u32 gmc_dst_pitch_offset_cntl : 1;
+	u32 gmc_src_clipping          : 1;
+	u32 gmc_dst_clipping          : 1;
+	u32 gmc_brush_datatype        : 4;
+	u32 gmc_dst_datatype          : 4;
+	u32 gmc_src_datatype          : 3;
+	u32 gmc_byte_pix_order        : 1;
+	u32 gmc_default_sel           : 1;
+	u32 gmc_rop3                  : 8;
+	u32 gmc_dp_src_source         : 3;
+	u32 gmc_clr_cmp_fcn_dis       : 1;
+	u32                           : 1;
+	u32 gmc_wr_msk_dis            : 1;
+	u32 gmc_dp_op                 : 1;
+} __attribute__((packed));
+
+union dp_gui_master_cntl_u {
+	u32 val : 32;
+	struct dp_gui_master_cntl_t f;
+} __attribute__((packed));
+
+struct rbbm_status_t {
+	u32 cmdfifo_avail   : 7;
+	u32                 : 1;
+	u32 hirq_on_rbb     : 1;
+	u32 cprq_on_rbb     : 1;
+	u32 cfrq_on_rbb     : 1;
+	u32 hirq_in_rtbuf   : 1;
+	u32 cprq_in_rtbuf   : 1;
+	u32 cfrq_in_rtbuf   : 1;
+	u32 cf_pipe_busy    : 1;
+	u32 eng_ev_busy     : 1;
+	u32 cp_cmdstrm_busy : 1;
+	u32 e2_busy         : 1;
+	u32 rb2d_busy       : 1;
+	u32 rb3d_busy       : 1;
+	u32 se_busy         : 1;
+	u32 re_busy         : 1;
+	u32 tam_busy        : 1;
+	u32 tdm_busy        : 1;
+	u32 pb_busy         : 1;
+	u32                 : 6;
+	u32 gui_active      : 1;
+} __attribute__((packed));
+
+union rbbm_status_u {
+	u32 val : 32;
+	struct rbbm_status_t f;
+} __attribute__((packed));
+
+struct dp_datatype_t {
+	u32 dp_dst_datatype   : 4;
+	u32                   : 4;
+	u32 dp_brush_datatype : 4;
+	u32 dp_src2_type      : 1;
+	u32 dp_src2_datatype  : 3;
+	u32 dp_src_datatype   : 3;
+	u32                   : 11;
+	u32 dp_byte_pix_order : 1;
+	u32                   : 1;
+} __attribute__((packed));
+
+union dp_datatype_u {
+	u32 val : 32;
+	struct dp_datatype_t f;
+} __attribute__((packed));
+
+struct dp_mix_t {
+	u32                : 8;
+	u32 dp_src_source  : 3;
+	u32 dp_src2_source : 3;
+	u32                : 2;
+	u32 dp_rop3        : 8;
+	u32 dp_op          : 1;
+	u32                : 7;
+} __attribute__((packed));
+
+union dp_mix_u {
+	u32 val : 32;
+	struct dp_mix_t f;
+} __attribute__((packed));
+
+struct eng_cntl_t {
+	u32 erc_reg_rd_ws            : 1;
+	u32 erc_reg_wr_ws            : 1;
+	u32 erc_idle_reg_wr          : 1;
+	u32 dis_engine_triggers      : 1;
+	u32 dis_rop_src_uses_dst_w_h : 1;
+	u32 dis_src_uses_dst_dirmaj  : 1;
+	u32                          : 6;
+	u32 force_3dclk_when_2dclk   : 1;
+	u32                          : 19;
+} __attribute__((packed));
+
+union eng_cntl_u {
+	u32 val : 32;
+	struct eng_cntl_t f;
+} __attribute__((packed));
+
+struct dp_cntl_t {
+	u32 dst_x_dir   : 1;
+	u32 dst_y_dir   : 1;
+	u32 src_x_dir   : 1;
+	u32 src_y_dir   : 1;
+	u32 dst_major_x : 1;
+	u32 src_major_x : 1;
+	u32             : 26;
+} __attribute__((packed));
+
+union dp_cntl_u {
+	u32 val : 32;
+	struct dp_cntl_t f;
+} __attribute__((packed));
+
+struct dp_cntl_dst_dir_t {
+	u32           : 15;
+	u32 dst_y_dir : 1;
+	u32           : 15;
+	u32 dst_x_dir : 1;
+} __attribute__((packed));
+
+union dp_cntl_dst_dir_u {
+	u32 val : 32;
+	struct dp_cntl_dst_dir_t f;
+} __attribute__((packed));
+
 #endif
 



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
