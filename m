From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 10.1/12] viafb: Framebuffer driver for
 VIA UniChrome/Chrome9 HC (fwd)
Date: Mon, 30 Apr 2007 10:37:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704301037450.27246@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiROP-0006Xq-AO for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:37:57 -0700
Received: from assei1bl6.telenet-ops.be ([195.130.133.68])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiROO-000238-24
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:37:57 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by assei1bl6.telenet-ops.be (Postfix) with SMTP id E382F220096
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:54 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by assei1bl6.telenet-ops.be (Postfix) with ESMTP id 17F1E2200A4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:51 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l3U8boMN020443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:50 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l3U8boUe020440
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:50 +0200
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

---------- Forwarded message ----------
Date: Mon, 30 Apr 2007 13:20:48 +0800
From: EddyFu@via.com.tw
To: linux-fbdev-devel-bounces@lists.sourceforge.net
Subject: [Linux-fbdev-devel] [PATCH 10.1/12] viafb: Framebuffer driver for VIA
    UniChrome/Chrome9 HC

Dear All, 
 
Here is the part 10.1/12 of viafb.
 
Best Regards,
Eddy Fu 
 
diff -Nur linux-2.6.21-rc7/drivers/video/via/viafbdev.c linux-2.6.21-rc7.viafb/drivers/video/via/viafbdev.c
--- linux-2.6.21-rc7/drivers/video/via/viafbdev.c 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/viafbdev.c 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,4917 @@
+/*
+ * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
+ * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub license,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+#include <linux/version.h>
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
+#include <linux/config.h>
+#endif
+#ifdef MODULE
+#include <linux/module.h>
+#endif
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/uaccess.h>
+#include <linux/proc_fs.h>
+#include "viafbdev.h"
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+#include <video/fbcon.h>
+#include <video/fbcon-cfb8.h>
+#include <video/fbcon-cfb16.h>
+#include <video/fbcon-cfb24.h>
+#include <video/fbcon-cfb32.h>
+#endif
+#include "share.h"
+#include "chip.h"
+#include "debug.h"
+#include "ioctl.h"
+#include "accel.h"
+#include "via_utility.h"
+#include "hwcfig.h"
+static struct fb_cmap viafb_256_colors = {
+0,256,red256,green256,blue256,NULL
+};
+/*Add Accelerator ID for DirectFB*/
+/*#define DirectFB*/
+extern unsigned int get_memsize(void);
+extern int setmode(int vmode_index,int hor_res,int ver_res,int video_bpp,
+ int vmode_index1,int hor_res1,int ver_res1,int video_bpp1);
+extern inline void lock_crt(void);
+extern inline void unlock_crt(void);
+extern inline void write_reg(u8 index, u16 io_port, u8 data);
+extern void write_reg_mask(u8 index, int io_port, u8 data, u8 mask);
+extern void init_chip_info(void);
+extern u8 read_reg(int io_port, u8 index);
+extern void init_dac(int set_iga);
+extern int get_pixclock(int hres, int vres, int vmode_refresh);
+extern int get_refresh(int hres, int vres, int pixclock);
+extern void update_device_setting(int hres, int vres, int bpp, int vmode_refresh,int flag);
+extern unsigned long get_videobuf_addr(void);
+extern int ioctl_get_viafb_info(u_long arg);
+extern int ioctl_hotplug(int hres, int vres, int bpp);
+extern int ioctl_get_tv_type(u_long arg);
+extern void get_mmio_info(unsigned long *mmio_base, unsigned long *mmio_len);
+extern int init_integrated_tv_regs(void);
+extern void set_integrated_tv_size(u32 desired_hsize, u32 desired_vsize);
+extern void crt_enable(void);
+extern void crt_disable(void);
+extern void dvi_enable(void);
+extern void dvi_disable(void);
+extern void tv_enable(void);
+extern void tv_disable(void);
+extern void lcd_enable(void);
+extern void lcd_disable(void);
+extern void set_iga_path(void);
+extern void init_lcd_size(void);
+extern void set_start_addr(void);
+extern void tv_set_brightness(u32 value);
+extern void tv_set_contrast(u32 value);
+extern void tv_set_saturation(u32 value);
+extern void tv_set_tint(u32 value);
+extern void tv_set_ffilter(u32 state, u32 value);
+extern void tv_set_position(u32 HPos, u32 VPos);
+extern void tv_get_position(u32* HPos, u32* VPos);
+extern void tv_set_adaptive_ffilter(u32 status, u32 value);
+extern int tv_get_ffilter(int ffilter_type, int* ffilter_state);
+extern void tv_get_support_standard(u32* support_state);
+extern void tv_get_support_signal(u32* support_state);
+extern int tv_get_max_size(void);
+extern void tv_get_support_tuning_state(u32* support_state);
+extern void tv_get_tuning_max_value(u32 item, u32* value);
+extern void tv_get_support_setting_state(u32* support_state);
+extern int check_macrovision_enabled(void);
+extern void get_fb_info(unsigned int *fb_base, unsigned int *fb_len);
+void memory_pitch_patch(struct fb_info *info);
+void fill_var_timing_info(struct fb_var_screeninfo* var, int refresh, int mode_index);
+int apply_device_setting(struct viafb_ioctl_setting ViaSetting, struct fb_info *info);
+void retrieve_device_setting(struct viafb_ioctl_setting *ViaSetting);
+int get_primary_device(void);
+bool is_available_tv_system(int system_id);
+bool is_available_tv_out_signal(int tv_out_signal);
+void viafb_set_device(device_t active_dev);
+void viafb_set_video_device(u32 video_dev_info);
+void viafb_get_video_device(u32* video_dev_info);
+void apply_second_mode_setting(struct fb_var_screeninfo* sec_var);
+u8 gpio_i2c_read_lvds(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info, u8 index);
+void gpio_i2c_write_mask_lvds(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info, IODATA io_data);
+int __init viafb_setup(char *options);
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+extern void Init_Accel(void);
+extern void Init_2D_Engine(void);
+extern void Set_2D_Color_Depth(int);
+extern void HWCursorInit(void);
+extern void ShowHideHWCursor(struct fb_info *info, int Status);
+extern int WaitEngineIdle(void);
+#endif
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,16)
+extern int  soft_cursor(struct fb_info *info, struct fb_cursor *cursor);
+#endif
+int get_mode_index(int hres, int vres,int flag);
+struct chip_information         chip_info;
+struct crt_setting_information  crt_setting_info;
+struct tv_setting_information   tv_setting_info;
+struct tmds_setting_information tmds_setting_info;
+struct lvds_setting_information lvds_setting_info;
+struct lvds_setting_information lvds_setting_info2;
+static struct fb_ops viafb_ops;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+static struct viafb_info viafbinfo, viafbinfo1;
+static struct display disp, disp1;
+static struct { unsigned char red,green,blue,transp; } palette[256];
+#else
+static struct fb_info viafbinfo, viafbinfo1;
+struct viafb_par parinfo, parinfo1;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
+#define viacursor  info->cursor
+#else
+struct fb_cursor viacursor;
+#endif
+#endif
+static struct fb_var_screeninfo default_var;
+static char * viafb_name = "Via";
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+static int pseudo_pal[16];
+#else
+static u32 pseudo_pal[17];
+#endif
+/* video mode */
+static char *mode = "640x480";
+static char *mode1 = "640x480";
+int bpp = 32,bpp1=32;
+static int resMode = VIA_RES_640X480;
+int memsize=0;
+int second_size=0;
+unsigned int second_offset=0;
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
+    void __iomem *FB_MM;
+#else
+    unsigned long FB_MM;
+#endif
+int CRT_ON=1,DVI_ON=0,TV_ON=0,LCD_ON=0,LCD2_ON=0,SAMM_ON=0,dual_fb=0;
+int VIDEO_ON_CRT=0, VIDEO_ON_DVI=0, VIDEO_ON_LCD=0, VIDEO_ON_TV=0;
+unsigned int second_xres=640;
+unsigned int second_yres=480;
+unsigned int second_virtual_xres=0;
+unsigned int second_virtual_yres=0;
+int EPIA_DVI=STATE_OFF;
+int LCDDualEdge=STATE_OFF;
+int BusWidth=12;
+/* Added for specifying active devices. */
+char *active_dev = "";
+/* Added for specifying video on devices. */
+char *video_dev = "";
+/* Added for specify lcd output port */
+char *lcd_port = "";
+char *dvi_port = "";
+/* Add for determine hardware layout. */
+int display_hardware_layout = HW_LAYOUT_LCD_DVI;
+/* Keep the primary device, used in SAMM case. */
+int primary_dev = None_Device;
+/* Display Mode Information */
+int  refresh = 60,refresh1=60;
+/* TV Initilization */
+int tv_level = 0;
+int tv_system =  1; /*Clarification:This value will be convert to bitwise value 
+                               *TVTYPE_NTSC in via_pci_probe */
+int tv_out_signal = 5; /*This value will be convert to bitwise value 
+                                    *TV_OUTPUT_COMPOSITE_SVIDEO in via_pci_probe */
+int tv_dedotcrawl = 0;
+long tv_ffilter= 0;
+long tv_brightness = 0;
+long tv_contrast = 0;
+long tv_saturation = 0;
+long tv_tint= 0;
+/* Added for specify lcd output port */
+char *tv_port = "";
+long tv_pos_hor_current = TV_POS_DEFAULT_HOR_VALUE;
+long tv_pos_ver_current = TV_POS_DEFAULT_VER_VALUE;
+/* LCD Initilization */
+int lcd_panel_id = LCD_PANEL_ID_MAXIMUM+1;
+int lcd_dsp_method = LCD_EXPANDSION;
+int lcd_mode = LCD_OPENLDI; /* OPENLDI || SPWG mode */
+int DeviceStatus = CRT_Device;
+int HotPlug_TV = 0, HotPlug = 0;
+extern int HotPlug_Xres, HotPlug_Yres, HotPlug_bpp, HotPlug_refresh;
+/* 2D Hardware Acceleration */
+int accel = 0;
+
+unsigned char CrReadByte(unsigned char byIndex)
+{
+    return read_reg(VIACR, byIndex);  
+}
+
+void CrWriteByte(unsigned char byIndex, unsigned char byValue)
+{
+        write_reg(byIndex, VIACR, byValue);
+}
+
+unsigned char SrReadByte(unsigned char byIndex)
+{
+    MMIO_OUT8( 0x3c4, byIndex);
+    return MMIO_IN8(0x3c5);
+}
+
+void SrWriteByte(unsigned char byIndex, unsigned char byValue)
+{
+    MMIO_OUT8(0x3c4, byIndex);
+    MMIO_OUT8(0x3c5, byValue);
+}
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+static void via_bmove (struct display *p, int sy, int sx,
+                int dy, int dx, int height, int width)
+{
+}
+
+static void via_clear_helper (int c, struct display *p,
+                int sy, int sx, int height, int width)
+{
+}
+
+#ifdef FBCON_HAS_CFB8
+static void via_8bpp_clear (struct vc_data *conp, struct display *p,
+                int sy, int sx, int height, int width)
+{
+    int c;
+    c = attr_bgcol_ec(p,conp) & 0xFF;
+    c |= c<<8;
+    c |= c<<16;
+    via_clear_helper(c,p,sy,sx,height,width);
+}
+
+static struct display_switch via_8bpp = {
+    setup:      fbcon_cfb8_setup,
+    bmove:      via_bmove,
+    clear:      via_8bpp_clear,
+    putc:       fbcon_cfb8_putc,
+    putcs:      fbcon_cfb8_putcs,
+    revc:       fbcon_cfb8_revc,
+    clear_margins:  fbcon_cfb8_clear_margins,
+    fontwidthmask:  FONTWIDTH (4) | FONTWIDTH (8) | FONTWIDTH (12) | FONTWIDTH (16)
+};
+#endif
+#ifdef FBCON_HAS_CFB16
+static void via_16bpp_clear (struct vc_data *conp, struct display *p,
+                int sy, int sx, int height, int width)
+{
+    int c;
+    c = ((u16*)p->dispsw_data)[attr_bgcol_ec(p,conp)];
+    c = c | c<<16;
+    via_clear_helper(c,p,sy,sx,height,width);
+}
+static struct display_switch via_16bpp = {
+    setup:      fbcon_cfb16_setup,
+    bmove:      via_bmove,
+    clear:      via_16bpp_clear,
+    putc:       fbcon_cfb16_putc,
+    putcs:      fbcon_cfb16_putcs,
+    revc:       fbcon_cfb16_revc,
+    clear_margins:  fbcon_cfb16_clear_margins,
+    fontwidthmask:  FONTWIDTH (4) | FONTWIDTH (8) | FONTWIDTH (12) | FONTWIDTH (16)
+};
+#endif
+#ifdef FBCON_HAS_CFB32
+static void via_32bpp_clear (struct vc_data *conp, struct display *p,
+                int sy, int sx, int height, int width)
+{
+    int c;
+    c = ((u32*)p->dispsw_data)[attr_bgcol_ec(p,conp)];
+    via_clear_helper(c,p,sy,sx,height,width);
+}
+static struct display_switch via_32bpp = {
+    setup:      fbcon_cfb32_setup,
+    bmove:      via_bmove,
+    clear:      via_32bpp_clear,
+    putc:       fbcon_cfb32_putc,
+    putcs:      fbcon_cfb32_putcs,
+    revc:       fbcon_cfb32_revc,
+    clear_margins:  fbcon_cfb32_clear_margins,
+    fontwidthmask:  FONTWIDTH (4) | FONTWIDTH (8) | FONTWIDTH (12) | FONTWIDTH (16)
+};
+#endif
+
+/* Fill in fix */
+static int via_encode_fix(struct fb_fix_screeninfo *fix,
+                  const void *par,
+                  struct fb_info_gen *info)
+{
+    struct viafb_info * i = (struct viafb_info *)info;
+    struct viafb_par * p = (struct viafb_par *)par;
+
+    DEBUG_MSG(KERN_INFO "via_encode_fix!\n" );
+
+    memset(fix, 0, sizeof(struct fb_fix_screeninfo));
+    strcpy(fix->id,viafb_name);
+
+    fix->smem_start = i->fbmem;
+    fix->smem_len = i->memsize;
+
+    fix->type = FB_TYPE_PACKED_PIXELS;
+    fix->type_aux = 0;
+
+    fix->visual = p->bpp==8 ? FB_VISUAL_PSEUDOCOLOR:FB_VISUAL_TRUECOLOR;
+
+    fix->xpanstep = fix->ywrapstep = 0;
+    fix->ypanstep = 1;
+    fix->line_length = p->linelength;
+    fix->mmio_start = i->mmio_base;
+    fix->mmio_len = i->mmio_len;
+
+/* Add Accelerator ID for DirectFB */
+#ifdef DirectFB
+    fix->accel = FB_ACCEL_VIA_UNICHROME;
+#else
+    fix->accel = FB_ACCEL_NONE;
+#endif    
+    return 0;
+}
+
+/* Fill in par from var */
+static int via_decode_var(const struct fb_var_screeninfo *var,
+                  void *par,
+                  struct fb_info_gen *info)
+{
+    struct viafb_par * p = (struct viafb_par *)par;
+    struct viafb_info * i = (struct viafb_info *)info;
+    int vres,vfront,vback,vsync;
+    int vmode_index;
+
+    DEBUG_MSG(KERN_INFO "via_decode_var!\n" );
+    vmode_index = get_mode_index(var->xres, var->yres,0);
+    if (vmode_index == VIA_RES_INVALID)
+    {
+        DEBUG_MSG(KERN_INFO "viafb: Mode %dx%dx%d not supported!!\n", var->xres, var->yres, var->bits_per_pixel);
+        return -EINVAL;
+    }
+
+    p->var = *var;
+    p->bpp = var->bits_per_pixel;
+
+    if (p->bpp == 24 )
+        p->bpp = 32;
+
+    p->linelength = var->xres_virtual * p->bpp/8;
+
+    switch (p->bpp) {
+        case 8:
+            p->var.red.offset = 0;
+            p->var.green.offset = 0;
+            p->var.blue.offset = 0;
+            p->var.red.length = 6;
+            p->var.green.length = 6;
+            p->var.blue.length = 6;
+            break;
+        case 16:
+            p->var.red.offset = 11;
+            p->var.green.offset = 5;
+            p->var.blue.offset = 0;
+            p->var.red.length = 5;
+            p->var.green.length = 6;
+            p->var.blue.length = 5;
+            break;
+        case 32:
+            p->var.red.offset = 16;
+            p->var.green.offset = 8;
+            p->var.blue.offset = 0;
+            p->var.red.length = 8;
+            p->var.green.length = 8;
+            p->var.blue.length = 8;
+            break;
+        default:
+            return -EINVAL;
+    }
+
+    /* convert from picoseconds to MHz */
+    refresh= get_refresh(var->xres, var->yres, var->pixclock);
+    p->vclk = 1000000/var->pixclock;
+
+    if (p->bpp == 32)
+        p->vclk *=2;
+
+    p->hres = var->xres;
+    vres = p->vres = var->yres;
+
+    /* See if requested resolution fits in available memory */
+    if (p->hres * p->vres * p->bpp/8 > i->memsize) {
+        return -EINVAL;
+    }
+
+    vfront = var->upper_margin;
+    vback = var->lower_margin;
+    vsync = var->vsync_len;
+
+    /* Compute horizontal and vertical VGA CRTC timing values */
+    if (var->vmode & FB_VMODE_INTERLACED) {
+        vres /= 2;
+        vfront /=2;
+        vback /=2;
+        vsync /=2;
+    }
+
+    if (var->vmode & FB_VMODE_DOUBLE) {
+        vres *= 2;
+        vfront *=2;
+        vback *=2;
+        vsync *=2;
+    }
+
+    p->htotal = (p->hres + var->left_margin + var->right_margin + var->hsync_len)/8 - 10;
+    p->hdispend = p->hres/8 - 1;
+    p->hsyncstart = (p->hres + var->right_margin)/8;
+    p->hsyncend = var->hsync_len/8;
+    p->hblankstart = p->hdispend + 1;
+    p->hblankend = p->htotal + 5;
+
+    p->vtotal = vres + vfront + vback + vsync - 2;
+    p->vdispend = vres - 1;
+    p->vsyncstart = vres + vback;
+    p->vsyncend = vsync;
+    p->vblankstart = vres;
+    p->vblankend = p->vtotal + 2;
+    return 0;
+}
+
+/* Fill in var from info */
+static int via_encode_var(struct fb_var_screeninfo *var,
+                  const void *par,
+                  struct fb_info_gen *info)
+{
+    struct viafb_par * p = (struct viafb_par *)par;
+
+    DEBUG_MSG(KERN_INFO "via_encode_var!\n" );
+    *var = p->var;
+    var->bits_per_pixel = p->bpp;
+    return 0;
+}
+
+/* Fill in par from hardware */
+static void via_get_par(void *par, struct fb_info_gen *info)
+{
+    struct viafb_par * p = (struct viafb_par *)par;
+    struct viafb_info * i = (struct viafb_info *)info;
+
+    DEBUG_MSG(KERN_INFO "via_get_par!\n" );
+    *p = i->currentmode;
+}
+
+/* Pan the display */
+static int via_pan_display(const struct fb_var_screeninfo *var,
+                   struct fb_info_gen *info)
+{
+    unsigned int offset;
+    struct viafb_info * i = (struct viafb_info *)info;
+
+    DEBUG_MSG(KERN_INFO "via_pan_display!\n" );
+    #if 0
+    offset = (var->xoffset + (var->yoffset * var->xres))
+            * var->bits_per_pixel/32;
+    i->currentmode.var.xoffset = var->xoffset;
+    i->currentmode.var.yoffset = var->yoffset;
+  #endif
+    
+    /* Enable pan display function in viafb on cle266 and cn400 platform 
+       add by tzp 20041010 ,for flip i bp frame, set register   
+       1. Command hw to wait until engine idle
+       2. Command hw to wait until display end
+       3. Update start address */
+    if(chip_info.gfx_chip_name == UNICHROME_CLE266 || chip_info.gfx_chip_name == UNICHROME_P880)
+    {
+       offset = (var->xoffset + (var->yoffset * var->xres)) * var->bits_per_pixel/16;
+   
+       i->currentmode.var.xoffset = var->xoffset;
+       i->currentmode.var.yoffset = var->yoffset;
+   
+       write_reg_mask(0x48,0x3d4,((offset>>24) & 0x3),0x3);
+       write_reg_mask(0x34,0x3d4,((offset>>16) & 0xff),0xff);
+       write_reg_mask(0x0c,0x3d4,((offset>>8) & 0xff),0xff);
+       write_reg_mask(0x0d,0x3d4,(offset & 0xff),0xff);
+    }
+    return 0;
+}
+
+/* Set the hardware from par */
+static void via_set_par(const void *par, struct fb_info_gen *info)
+{
+    int vmode_index = 0;
+    int vmode_index1 = 0;
+    struct viafb_par * p = (struct viafb_par *)par;
+    struct viafb_info * i = (struct viafb_info *)info;
+
+    DEBUG_MSG(KERN_INFO "via_set_par!\n" );
+    i->currentmode = *p;
+
+    update_device_setting(i->currentmode.hres, i->currentmode.vres, i->currentmode.bpp, refresh,0);
+
+    vmode_index = get_mode_index(i->currentmode.hres, i->currentmode.vres,0);
+    DEBUG_MSG(KERN_INFO "->index=%d\n", vmode_index );
+    
+    if(SAMM_ON==1)
+    {
+        DEBUG_MSG(KERN_INFO "second_xres=%d, second_yres=%d, bpp=%d\n",second_xres, second_yres, bpp1);
+        vmode_index1 = get_mode_index(second_xres, second_yres,1);
+        DEBUG_MSG(KERN_INFO "->SAMM_ON: index=%d\n", vmode_index1 );
+       update_device_setting(second_xres, second_yres, bpp1, refresh1,1);
+    }
+    if (vmode_index != VIA_RES_INVALID)
+    {
+        setmode(vmode_index,i->currentmode.hres,i->currentmode.vres,i->currentmode.bpp,
+   vmode_index1,second_xres, second_yres, bpp1);
+        via_pan_display(&p->var,info);
+        bpp=i->currentmode.bpp;
+    }
+}
+
+/* Get value of one color register */
+static int via_getcolreg(unsigned regno, unsigned *red,
+                 unsigned *green, unsigned *blue,
+                 unsigned *transp, struct fb_info *info)
+{
+    struct viafb_info * i = (struct viafb_info *)info;
+    int m = i->currentmode.bpp==8?256:16;
+
+    DEBUG_MSG(KERN_INFO "via_getcolreg!\n" );
+    if (regno >= m)
+        return 1;
+
+    *red = palette[regno].red;
+    *green = palette[regno].green;
+    *blue = palette[regno].blue;
+    *transp = palette[regno].transp;
+    return 0;
+}
+
+/* Set one color register */
+static int via_setcolreg(unsigned regno, unsigned red, unsigned green,
+                 unsigned blue, unsigned transp,
+                 struct fb_info *info)
+{
+    struct viafb_info * i = (struct viafb_info *)info;
+    int bpp = i->currentmode.bpp;
+    u8 sr15,sr1a,sr1b,cr67,cr6a;
+
+    DEBUG_MSG(KERN_INFO "via_setcolreg!\n" );
+    /* The kernle don't have 256color cmap, so it can't pass regno>=256 */
+    if(regno >= 16)
+        return 1;
+
+    palette[regno].red = red;
+    palette[regno].green = green;
+    palette[regno].blue = blue;
+    palette[regno].transp = transp;
+
+    if (bpp==8) {
+        outb(0x1A,0x3C4);
+        sr1a = inb(0x3C5);
+        outb(0x1B,0x3C4);
+        sr1b = inb(0x3C5);
+        outb(0x67,0x3D4);
+        cr67 = inb(0x3D5);
+        outb(0x6A,0x3D4);
+        cr6a = inb(0x3D5);
+
+        outb(0x1A,0x3C4);
+        outb(sr1a | 0x01,0x3C5); /* Map the 3C6/7/8/9 to the IGA2 */
+        outb(0x1B,0x3C4);
+        outb(sr1b | 0x80,0x3C5); /* Second Display Engine colck always on */
+        outb(0x67,0x3D4);
+        outb(cr67 & 0x3F,0x3D5); /* Second Display Color Depth 8 */
+        outb(0x6A,0x3D4);
+        outb(cr6a & 0xBF,0x3D5); /* Second Display Channel Reset CR6A[6]) */
+        outb(cr6a | 0x80,0x3D5); /* Second Display Channel Enable CR6A[7] */
+        outb(cr6a | 0x40,0x3D5); /* Second Display Channel stop reset) */
+        
+        outb(0xFF,0x3c6); /* Bit mask of palette */
+        outb(regno,0x3C8); /* Write one register of IGA2 */   
+        outb(red>>10,0x3C9);
+        outb(green>>10,0x3C9);
+        outb(blue>>10,0x3C9);
+
+        outb(0x1A,0x3C4);
+        outb(sr1a & 0xFE,0x3C5); /* Map the 3C6/7/8/9 to the IGA1 */    
+
+        outb(0xFF,0x3c6); /* Bit mask of palette */
+        outb(regno,0x3C8); /* Write one register of IGA1 */
+        outb(red>>10,0x3C9);
+        outb(green>>10,0x3C9);
+        outb(blue>>10,0x3C9);
+
+        outb(0x1A,0x3C4);
+        outb(sr1a,0x3C5);
+        outb(0x1B,0x3C4);
+        outb(sr1b,0x3C5);
+        outb(0x67,0x3D4);
+        outb(cr67,0x3D5);
+        outb(0x6A,0x3D4);
+        outb(cr6a,0x3D5);
+    } else
+    if (bpp == 16)          /* RGB 565 */
+            ((u16*)info->pseudo_palette)[regno] = (red & 0xF800) |
+            ((green & 0xFC00) >> 5) | ((blue & 0xF800) >> 11);
+    else
+    if (bpp == 32)      /* ARGB 8888 */
+        ((u32*)info->pseudo_palette)[regno] =
+            ((transp & 0xFF00) <<16)    |
+            ((red & 0xFF00) << 8)       |
+            ((green & 0xFF00))      |
+            ((blue & 0xFF00)>>8);
+
+    return 0;
+}
+
+/* write 256 color registers one time */
+static int via_loadpalette(struct fb_cmap *cmap) {
+    u32 len = cmap->len;
+    u32 i;
+    u16 *pred = cmap->red;
+    u16 *pgreen = cmap->green;
+    u16 *pblue = cmap->blue;
+    u16 *ptransp = cmap->transp;
+    u8 sr1a, sr15, sr1b, cr67, cr6a;
+    if(len > 256) return 1;
+     
+    outb(0x1A,0x3C4);
+    sr1a = inb(0x3C5);
+    outb(0x1B,0x3C4);
+    sr1b = inb(0x3C5);
+    outb(0x67,0x3D4);
+    cr67 = inb(0x3D5);
+    outb(0x6A,0x3D4);
+    cr6a = inb(0x3D5);
+
+    outb(0x1A,0x3C4);
+    outb(sr1a | 0x01,0x3C5); /* Map the 3C6/7/8/9 to the IGA2 */
+    outb(0x1B,0x3C4);
+    outb(sr1b | 0x80,0x3C5); /* Second Display Engine colck always on */
+    outb(0x67,0x3D4);
+    outb(cr67 & 0x3F,0x3D5); /* Second Display Color Depth 8 */
+    outb(0x6A,0x3D4);
+    outb(cr6a & 0xBF,0x3D5); /* Second Display Channel Reset CR6A[6]) */
+    outb(cr6a | 0x80,0x3D5); /* Second Display Channel Enable CR6A[7] */
+    outb(cr6a | 0x40,0x3D5); /* Second Display Channel stop reset) */
+    
+    outb(0xFF,0x3c6); /* Bit mask of palette */
+    outb(0x00,0x3C8);
+    for (i = 0; i < len; i++)
+    {   outb((*(pred+i))>>10,0x3C9);
+        outb((*(pgreen+i))>>10,0x3C9);
+        outb((*(pblue+i))>>10,0x3C9);
+    }
+
+    outb(0x1A,0x3C4);
+    outb(sr1a & 0xFE,0x3C5); /* Map the 3C6/7/8/9 to the IGA1 */    
+
+    outb(0xFF,0x3c6); /* Bit mask of palette */
+    outb(0x00,0x3C8);
+    for (i = 0; i < len; i++)
+    {   outb((*(pred+i))>>10,0x3C9);
+        outb((*(pgreen+i))>>10,0x3C9);
+        outb((*(pblue+i))>>10,0x3C9);
+    } 
+
+    outb(0x1A,0x3C4);
+    outb(sr1a,0x3C5);
+    outb(0x1B,0x3C4);
+    outb(sr1b,0x3C5);
+    outb(0x67,0x3D4);
+    outb(cr67,0x3D5);
+    outb(0x6A,0x3D4);
+    outb(cr6a,0x3D5);
+return 0;
+}
+
+/* blank screen */
+static int via_blank(int blank_mode, struct fb_info_gen *info)
+{
+    DEBUG_MSG(KERN_INFO "via_blank!\n" );
+    /* clear DPMS setting */
+
+    switch (blank_mode) {
+    case VESA_NO_BLANKING:
+        /* Screen: On, HSync: On, VSync: On */
+        write_reg_mask(CR36, VIACR, 0x00, BIT4+BIT5);   /* control CRT monitor power management */
+        break;
+    case VESA_HSYNC_SUSPEND:
+        /* Screen: Off, HSync: Off, VSync: On */
+        write_reg_mask(CR36, VIACR, 0x10, BIT4+BIT5);   /* control CRT monitor power management */
+        break;
+    case VESA_VSYNC_SUSPEND:
+        /* Screen: Off, HSync: On, VSync: Off */
+        write_reg_mask(CR36, VIACR, 0x20, BIT4+BIT5);   /* control CRT monitor power management */
+        break;
+    case VESA_POWERDOWN:
+        /* Screen: Off, HSync: Off, VSync: Off */
+        write_reg_mask(CR36, VIACR, 0x30, BIT4+BIT5);   /* control CRT monitor power management */
+        break;
+        }
+    return 0;
+}
+
+/* Set display switch used by console */
+static void via_set_disp(const void *par, struct display *disp,
+                 struct fb_info_gen *info)
+{
+    struct viafb_info * i = (struct viafb_info *)info;
+    struct fb_info * ii = (struct fb_info *)info;
+    struct viafb_par * p = (struct viafb_par *)par;
+    int isaccel = 0;
+
+    DEBUG_MSG(KERN_INFO "via_set_disp!\n" );
+    disp->screen_base = (char *)i->fbmem_virt;
+
+#ifdef FBCON_HAS_CFB8
+    if (p->bpp == 8 ) {
+        if (isaccel)
+            disp->dispsw = &via_8bpp;
+        else
+            disp->dispsw = &fbcon_cfb8;
+    } else
+#endif
+#ifdef FBCON_HAS_CFB16
+    if (p->bpp == 16) {
+        if (isaccel){
+            disp->dispsw = &via_16bpp;
+    }else
+            disp->dispsw = &fbcon_cfb16;
+        disp->dispsw_data =ii->pseudo_palette;  /* console palette */
+    } else
+#endif
+#ifdef FBCON_HAS_CFB32
+    if (p->bpp == 32) {
+        if (isaccel)
+            disp->dispsw = &via_32bpp;
+        else
+            disp->dispsw = &fbcon_cfb32;
+        disp->dispsw_data =ii->pseudo_palette;  /* console palette */
+    } else
+#endif
+    disp->dispsw = &fbcon_dummy;
+
+    /* Fix monitor scroll would be slowly. */
+    disp->scrollmode = SCROLL_YREDRAW;
+
+}
+
+static int viafb_ioctl(struct inode *inode, struct file *file, u_int cmd,
+               u_long arg, int con, struct fb_info_gen *info)
+{
+    struct viafb_info * i = (struct viafb_info *)info;
+    struct viafb_ioctl_info viainfo;
+    struct viafb_ioctl_mode viamode;
+    struct viafb_ioctl_samm viasamm;
+    struct viafb_driver_version driver_version;
+    struct fb_var_screeninfo sec_var;
+    POSITIONVALUE SetViewSizeValue, SetViewPosValue;  
+
+    /* Only for case "SET_DEVICE_INFO" and "GET_DEVICE_INFO" */
+    struct viafb_ioctl_setting viafb_setting;  
+    memset(&viafb_setting,0,sizeof(viafb_setting));
+ 
+    u32 __user  *argp = (u32 __user *)arg;
+    u32         gpu32 = 0,ss;
+    device_t active_dev;
+    u32 video_dev_info = 0;
+    ss = sizeof(active_dev);
+    memset(&active_dev,0,ss);
+
+    DEBUG_MSG(KERN_INFO "viafb_ioctl: 0x%X !!\n", cmd);
+    DEBUG_MSG(KERN_INFO "viafb_ioctl: 0x%X !!\n", cmd);
+
+    switch (cmd)
+ { 
+        case VIAFB_GET_CHIP_INFO: /* struct chip_information        chip_info ; */
+            if(copy_to_user((void __user *)arg, &chip_info, sizeof(chip_info)))
+                return -EFAULT;
+            break;
+        case VIAFB_GET_INFO_SIZE:
+            return put_user(sizeof(viainfo), argp);
+        case VIAFB_GET_INFO:
+            return ioctl_get_viafb_info(arg);
+        case VIAFB_HOTPLUG:
+            return put_user((u32)ioctl_hotplug(i->currentmode.hres, i->currentmode.vres, i->currentmode.bpp), argp);
+            break;
+        case VIAFB_SET_HOTPLUG_FLAG:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            HotPlug = (gpu32) ? 1 : 0;
+            break;
+        case VIAFB_GET_RESOLUTION:
+            viamode.xres = (u32)HotPlug_Xres;
+            viamode.yres = (u32)HotPlug_Yres;
+            viamode.refresh = (u32)HotPlug_refresh;
+            viamode.bpp = (u32)HotPlug_bpp;
+            if(SAMM_ON==1){
+                viamode.xres_sec=second_xres;
+                viamode.yres_sec=second_yres;
+                viamode.virtual_xres_sec = second_virtual_xres;
+                viamode.virtual_yres_sec = second_virtual_yres;
+                viamode.refresh_sec=refresh1;
+                viamode.bpp_sec=bpp1;
+            }else{
+                viamode.xres_sec=0;
+                viamode.yres_sec=0;
+                viamode.virtual_xres_sec = 0;
+                viamode.virtual_yres_sec = 0;
+                viamode.refresh_sec=0;
+                viamode.bpp_sec=0;
+            }
+            if(copy_to_user((void __user *)arg, &viamode, sizeof(viamode))) {
+                return -EFAULT;
+            }
+            break;
+        case VIAFB_GET_TV_TYPE:
+            return ioctl_get_tv_type(arg);
+        case VIAFB_GET_SAMM_INFO:
+            viasamm.samm_status= SAMM_ON; /* MB0 */
+            if(SAMM_ON==1){
+                if(dual_fb) 
+                {
+                    viasamm.size_prim = viafbinfo.memsize;
+                    viasamm.size_sec = viafbinfo1.memsize;
+                }
+                else 
+                {
+                    if(second_size)
+                    {
+                        viasamm.size_prim=viafbinfo.memsize - second_size*1024*1024;
+                        viasamm.size_sec=second_size*1024*1024;
+                    }
+      else
+      {
+                        viasamm.size_prim=viafbinfo.memsize>>1;
+                        viasamm.size_sec=viafbinfo.memsize>>1;
+       }
+                } 
+                viasamm.mem_base=viafbinfo.fbmem;
+                viasamm.offset_sec=second_offset;
+            }else{
+                viasamm.size_prim=viafbinfo.memsize;
+                viasamm.size_sec=0;
+                viasamm.mem_base=viafbinfo.fbmem;
+                viasamm.offset_sec=0;
+            }
+           
+            if(copy_to_user((void __user *)arg, &viasamm, sizeof(viasamm))) 
+                return -EFAULT;
+            break;
+        case VIAFB_TURN_ON_OUTPUT_DEVICE:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            if (gpu32 & CRT_Device)
+                crt_enable();
+            if (gpu32 & DVI_Device)
+                dvi_enable();
+            if (gpu32 & TV_Device)
+                tv_enable();
+            if (gpu32 & LCD_Device)
+                lcd_enable();
+            break;
+        case VIAFB_TURN_OFF_OUTPUT_DEVICE:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            if (gpu32 & CRT_Device)
+                crt_disable();
+            if (gpu32 & DVI_Device)
+                dvi_disable();
+            if (gpu32 & TV_Device)
+                tv_disable();
+            if (gpu32 & LCD_Device)
+                lcd_disable();
+            break;
+        case VIAFB_SET_DEVICE:
+            if (copy_from_user(&active_dev, (void *)argp,ss))
+            {
+                return -EFAULT;
+            }
+            if(check_macrovision_enabled() && (active_dev.tv != TV_ON || TV_ON))
+                break;
+            viafb_set_device(active_dev);
+            via_set_par((void*)(&i->currentmode),info);
+            break;
+        case VIAFB_GET_DEVICE:
+            active_dev.crt = CRT_ON;
+            active_dev.dvi = DVI_ON;
+            active_dev.tv = TV_ON;
+            active_dev.lcd = LCD_ON;            
+            active_dev.lcd2 = LCD2_ON;
+            active_dev.samm = SAMM_ON;
+            active_dev.primary_dev = primary_dev;
+
+            active_dev.tv_system = tv_system;
+            active_dev.tv_level = tv_level;
+            active_dev.tv_out_sig = tv_out_signal;
+            active_dev.tv_dedotcrawl = tv_dedotcrawl;
+
+            active_dev.lcd_dsp_cent = lcd_dsp_method; 
+            active_dev.lcd_panel_id = lcd_panel_id;
+            active_dev.lcd_mode = lcd_mode;
+
+            active_dev.xres = HotPlug_Xres;
+            active_dev.yres = HotPlug_Yres;
+
+            active_dev.xres1 = second_xres;
+            active_dev.yres1 = second_yres;
+      
+            active_dev.bpp = bpp;
+            active_dev.bpp1 = bpp1;
+            active_dev.refresh = refresh;
+            active_dev.refresh1 = refresh1;
+            
+            active_dev.epia_dvi=EPIA_DVI;
+            active_dev.lcd_dual_edge=LCDDualEdge;
+            active_dev.bus_width=BusWidth;
+
+            if(copy_to_user((void __user *)arg, &active_dev, sizeof(device_t))) 
+                return -EFAULT;
+            break;
+        case VIAFB_SET_TV_FFILTER:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            tv_set_ffilter(STATE_ON, gpu32);
+            break;
+        case VIAFB_SET_TV_COLOR_DEFAULT:
+        {
+            u32 def_val[4];
+            tv_set_brightness(tv_setting_info.DefaultBrightness);
+            tv_set_contrast(tv_setting_info.DefaultContrast);
+            tv_set_saturation(tv_setting_info.DefaultSaturation);
+            tv_set_tint(tv_setting_info.DefaultTINT);
+            def_val[0] = tv_setting_info.DefaultBrightness;
+            def_val[1] = tv_setting_info.DefaultContrast;
+            def_val[2] = tv_setting_info.DefaultSaturation;
+            def_val[3] = tv_setting_info.DefaultTINT;
+            if(copy_to_user((void __user *)arg, &def_val, sizeof(u32)*4)) 
+                return -EFAULT;
+            break;
+        }
+        case VIAFB_SET_TV_BRIGHTNESS:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            tv_set_brightness(gpu32);
+            break;
+        case VIAFB_SET_TV_CONTRAST:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            tv_set_contrast(gpu32);
+            break;
+        case VIAFB_SET_TV_SATURATION:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            tv_set_saturation(gpu32);
+            break;
+        case VIAFB_SET_TV_TINT:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            tv_set_tint(gpu32);
+            break;
+
+        /* Add for getting driver version. */
+        case VIAFB_GET_DRIVER_VERSION:
+            driver_version.iMajorNum = VERSION_MAJOR;            
+            driver_version.iKernelNum = VERSION_KERNEL;
+            driver_version.iOSNum = VERSION_OS;
+            driver_version.iMinorNum = VERSION_MINOR;
+            
+            if(copy_to_user((void __user *)arg, &driver_version, sizeof(driver_version)))
+            {
+                return -EFAULT;
+            }
+            break;
+
+        /* Set and apply CRT,DVI,LCD,TV's setting info. */ 
+        case VIAFB_SET_DEVICE_INFO:
+            if(copy_from_user(&viafb_setting, (void *)argp,sizeof(viafb_setting)))
+            {
+                return -EFAULT;
+            }
+           if(check_macrovision_enabled() && (((viafb_setting.device_status & TV_Device) >> 2)!= TV_ON || TV_ON))
+                break;
+            if(apply_device_setting(viafb_setting, info)<0)
+            {
+                return -EINVAL;
+            }
+            break;
+
+        case VIAFB_SET_SECOND_MODE:
+            if(copy_from_user(&sec_var, (void *)argp,sizeof(sec_var)))
+            {
+                return -EFAULT;
+            }
+            apply_second_mode_setting(&sec_var);
+            break;            
+
+        /* Get current VIA framebuffer device setting info. */ 
+        case VIAFB_GET_DEVICE_INFO:
+
+            retrieve_device_setting(&viafb_setting);
+
+            if(copy_to_user((void __user *)arg, &viafb_setting, sizeof(viafb_setting)))
+            {
+                return -EFAULT;
+            }
+            break;
+        case VIAFB_SET_TV_POSITION:
+            if(copy_from_user(&SetViewPosValue, (void *)argp,sizeof(POSITIONVALUE))) {
+                return -EFAULT;
+            }
+
+            if (SetViewPosValue.dwX == 0xFFFF && SetViewPosValue.dwY == 0xFFFF)
+            {
+                 SetViewPosValue.dwX = tv_setting_info.DefaultPositionH;
+                 SetViewPosValue.dwY = tv_setting_info.DefaultPositionV;
+            }
+    
+            tv_set_position(SetViewPosValue.dwX,SetViewPosValue.dwY);
+            DEBUG_MSG(KERN_INFO "tv_set_position:  tv_setting_info.level=%d\n",  tv_setting_info.level);  
+            break;
+        case VIAFB_SET_TV_SIZE:
+            if(copy_from_user(&SetViewSizeValue, (void *)argp,sizeof(POSITIONVALUE))) {
+                return -EFAULT;
+            }
+
+            if (SetViewSizeValue.dwX == 0xFFFF && SetViewSizeValue.dwY == 0xFFFF)
+            {
+                SetViewSizeValue.dwX = tv_setting_info.DefaultScalH + 1;
+                SetViewSizeValue.dwY = tv_setting_info.DefaultScalV + 1;
+                tv_setting_info.CurrentScalH= tv_setting_info.DefaultScalH;
+                tv_setting_info.CurrentScalV= tv_setting_info.DefaultScalV;
+            }
+    
+            tv_set_size(SetViewSizeValue.dwX,SetViewSizeValue.dwY); 
+            DEBUG_MSG(KERN_INFO "tv_set_size:  tv_setting_info.level=%d\n",  tv_setting_info.level);  
+            break;  
+        case VIAFB_SET_VIDEO_DEVICE:
+            get_user(video_dev_info, argp);
+            viafb_set_video_device(video_dev_info);
+            break;
+        case VIAFB_GET_VIDEO_DEVICE:
+            viafb_get_video_device(&video_dev_info);
+            if (put_user(video_dev_info, argp))
+            {
+               return -EFAULT; 
+            }
+            break;
+
+        default:
+            return -EINVAL;
+        }
+    return 0;
+}
+
+static struct fbgen_hwswitch via_hwswitch = {
+    NULL, /* detect not needed */
+    via_encode_fix,
+    via_decode_var,
+    via_encode_var,
+    via_get_par,
+    via_set_par,
+    via_getcolreg,
+    via_setcolreg,
+    via_pan_display,
+    via_blank,
+    via_set_disp
+};
+#endif
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+static int
+viafb_get_fix(struct fb_fix_screeninfo *fix, struct fb_info *info)
+{
+    /* Modified for dual-fb. */
+    struct viafb_par *ppar;
+    ppar = info->par;
+
+    DEBUG_MSG(KERN_INFO "viafb_get_fix!\n");
+
+    memset(fix, 0, sizeof(struct fb_fix_screeninfo));
+    strcpy(fix->id, viafb_name);
+
+    fix->smem_start = ppar->fbmem;
+    fix->smem_len = ppar->fbmem_free;
+
+    fix->type = FB_TYPE_PACKED_PIXELS;
+    fix->type_aux = 0;
+
+    fix->visual = ppar->bpp==8 ? FB_VISUAL_PSEUDOCOLOR:FB_VISUAL_TRUECOLOR;
+
+    fix->xpanstep = fix->ywrapstep = 0;
+    fix->ypanstep = 1;
+    fix->line_length = ppar->linelength;
+
+    fix->mmio_start = ppar->mmio_base;
+    fix->mmio_len = ppar->mmio_len;
+
+    if(accel)
+        fix->accel = FB_ACCEL_VIA_UNICHROME;
+    else
+        fix->accel = FB_ACCEL_NONE;
+    return 0;
+}
+
+static int viafb_open(struct fb_info *info, int user)
+{
+    DEBUG_MSG(KERN_INFO "viafb_open!\n");
+    return 0;
+}
+
+static int viafb_release(struct fb_info *info, int user)
+{
+    DEBUG_MSG(KERN_INFO "viafb_release!\n");
+    return 0;
+}
+
+static int viafb_check_var(struct fb_var_screeninfo *var,
+                           struct fb_info *info)
+{
+    int vres,vfront,vback,vsync;
+    int vmode_index;
+    /* Modified for dual-fb according. */
+    struct viafb_par *ppar;
+    ppar = info->par;
+
+    DEBUG_MSG(KERN_INFO "viafb_check_var!\n");
+    vmode_index = get_mode_index(var->xres, var->yres,0);
+    if (vmode_index == VIA_RES_INVALID)
+    {
+        DEBUG_MSG(KERN_INFO "viafb: Mode %dx%dx%d not supported!!\n", var->xres, var->yres, var->bits_per_pixel);
+        return -EINVAL;
+    }
+    /* convert from picoseconds to MHz */
+    refresh = get_refresh(var->xres, var->yres, var->pixclock);
+    if(24 == var->bits_per_pixel)
+    {
+        var->bits_per_pixel = 32;
+    }
+    if((var->xres_virtual * (var->bits_per_pixel>> 3)) & 0x1F)/* Is 32 bytes alignment? */
+    {
+        var->xres_virtual = (var->xres_virtual + 31) & ~31;/* 32 pixel alignment */
+    }
+    
+    /* Fill var's time information according our table, or fbset will show wrong information */
+    fill_var_timing_info(var, refresh, vmode_index);
+    
+    ppar->var = *var;
+    ppar->bpp = var->bits_per_pixel;
+
+    if (ppar->bpp == 24)
+        ppar->bpp = 32;
+
+    ppar->linelength = ((var->xres_virtual + 7) & ~7) * ppar->bpp/8;
+
+    switch (ppar->bpp) {
+        case 8:
+            ppar->var.red.offset = 0;
+            ppar->var.green.offset = 0;
+            ppar->var.blue.offset = 0;
+            ppar->var.red.length = 6;
+            ppar->var.green.length = 6;
+            ppar->var.blue.length = 6;
+            break;
+        case 16:
+            ppar->var.red.offset = 11;
+            ppar->var.green.offset = 5;
+            ppar->var.blue.offset = 0;
+            ppar->var.red.length = 5;
+            ppar->var.green.length = 6;
+            ppar->var.blue.length = 5;
+            break;
+        case 32:
+            ppar->var.red.offset = 16;
+            ppar->var.green.offset = 8;
+            ppar->var.blue.offset = 0;
+            ppar->var.red.length = 8;
+            ppar->var.green.length = 8;
+            ppar->var.blue.length = 8;
+            break;
+        default:
+            return -EINVAL;
+    }
+
+    ppar->vclk = 1000000/var->pixclock;
+
+    if (ppar->bpp == 32)
+        ppar->vclk *=2;
+
+    ppar->hres = var->xres;
+    vres = ppar->vres = var->yres;
+
+    /* See if requested resolution fits in available memory */
+    if (ppar->hres * ppar->vres * ppar->bpp/8 > ppar->memsize) {
+        return -EINVAL;
+    }
+
+    vfront = var->upper_margin;
+    vback = var->lower_margin;
+    vsync = var->vsync_len;
+
+    /* Compute horizontal and vertical VGA CRTC timing values */
+    if (var->vmode & FB_VMODE_INTERLACED) {
+        vres /= 2;
+        vfront /=2;
+        vback /=2;
+        vsync /=2;
+    }
+
+    if (var->vmode & FB_VMODE_DOUBLE) {
+        vres *= 2;
+        vfront *=2;
+        vback *=2;
+        vsync *=2;
+    }
+
+    ppar->htotal = (ppar->hres + var->left_margin + var->right_margin + var->hsync_len)/8 - 10;
+    ppar->hdispend = ppar->hres/8 - 1;
+    ppar->hsyncstart = (ppar->hres + var->right_margin)/8;
+    ppar->hsyncend = var->hsync_len/8;
+    ppar->hblankstart = ppar->hdispend + 1;
+    ppar->hblankend = ppar->htotal + 5;
+
+    ppar->vtotal = vres + vfront + vback + vsync - 2;
+    ppar->vdispend = vres - 1;
+    ppar->vsyncstart = vres + vback;
+    ppar->vsyncend = vsync;
+    ppar->vblankstart = vres;
+    ppar->vblankend = ppar->vtotal + 2;
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,8)
+    info->var = ppar->var;
+#endif
+
+    return 0;
+}
+
+static int viafb_set_par(struct fb_info *info)
+{
+    int vmode_index;
+    int vmode_index1=0;
+
+    DEBUG_MSG(KERN_INFO "viafb_set_par!\n");
+    
+    refresh = get_refresh(info->var.xres, info->var.yres, info->var.pixclock);
+
+    update_device_setting(info->var.xres, info->var.yres, info->var.bits_per_pixel, refresh,0);
+
+    vmode_index = get_mode_index(info->var.xres, info->var.yres,0);
+    
+    if(SAMM_ON==1)
+    {
+        DEBUG_MSG(KERN_INFO "second_xres=%d, second_yres=%d, bpp=%d\n",second_xres, second_yres, bpp1);
+        vmode_index1 = get_mode_index(second_xres, second_yres,1);
+        DEBUG_MSG(KERN_INFO "->SAMM_ON: index=%d\n", vmode_index1 );
+        update_device_setting(second_xres, second_yres, bpp1, refresh1,1);
+    }
+    if (vmode_index != VIA_RES_INVALID)
+    {
+        setmode(vmode_index,info->var.xres, info->var.yres, info->var.bits_per_pixel,
+            vmode_index1,second_xres,second_yres,bpp1);
+
+        /* We should set memory offset according virtual_x */
+        /* Fix me:put this function into setmode */
+        memory_pitch_patch(info);
+        
+        viafb_check_var(&info->var, info);
+        viafb_get_fix(&info->fix, info);
+
+        bpp=info->var.bits_per_pixel;
+
+        if(accel)
+            Set_2D_Color_Depth(info->var.bits_per_pixel);
+    }
+    return 0;
+}
+
+static int
+viafb_get_cmap_len(struct fb_var_screeninfo *var)
+{
+    DEBUG_MSG(KERN_INFO "viafb_get_cmap_len!\n" );
+    return (var->bits_per_pixel == 8) ? 256 : 16;
+}
+
+
+/* Set one color register */
+static int viafb_setcolreg(unsigned regno, unsigned red, unsigned green,
+                 unsigned blue, unsigned transp,
+                 struct fb_info *info)
+{
+    u8 sr1a,sr1b,cr67,cr6a,rev = 0, shift = 10;
+    DEBUG_MSG(KERN_INFO "viafb_setcolreg!\n" );
+    if(regno >= viafb_get_cmap_len(&info->var))
+        return 1;
+    if(UNICHROME_CLE266 == chip_info.gfx_chip_name)
+    {
+        /* Read PCI bus 0, dev 0, function 0, index 0xF6 to get chip rev. */
+        outl(0x80000000 | (0xf6 & ~3), (unsigned long)0xCF8);
+        rev = (inl((unsigned long)0xCFC) >> ((0xf6 & 3) * 8)) & 0xff;
+    }
+    switch(info->var.bits_per_pixel) {
+        case 8:
+            outb(0x1A,0x3C4);
+            sr1a = inb(0x3C5);
+            outb(0x1B,0x3C4);
+            sr1b = inb(0x3C5);
+            outb(0x67,0x3D4);
+            cr67 = inb(0x3D5);
+            outb(0x6A,0x3D4);
+            cr6a = inb(0x3D5);
+
+            outb(0x1A,0x3C4);
+            outb(sr1a | 0x01,0x3C5); /* Map the 3C6/7/8/9 to the IGA2 */
+            outb(0x1B,0x3C4);
+            outb(sr1b | 0x80,0x3C5); /* Second Display Engine colck always on */
+            outb(0x67,0x3D4);
+            outb(cr67 & 0x3F,0x3D5); /* Second Display Color Depth 8 */
+            outb(0x6A,0x3D4);
+            outb(cr6a & 0xBF,0x3D5); /* Second Display Channel Reset CR6A[6]) */
+            outb(cr6a | 0x80,0x3D5); /* Second Display Channel Enable CR6A[7] */
+            outb(cr6a | 0x40,0x3D5); /* Second Display Channel stop reset) */
+            
+            outb(0xFF,0x3c6); /* Bit mask of palette */
+            outb(regno,0x3C8); /* Write one register of IGA2 */ 
+            if(UNICHROME_CLE266 == chip_info.gfx_chip_name && rev >= 15)
+            {
+                shift = 8;
+                write_reg_mask(CR6A, VIACR, BIT5, BIT5);
+                write_reg_mask(SR15, VIASR, BIT7, BIT7);
+            }
+            outb(red>>shift, 0x3C9);
+            outb(green>>shift, 0x3C9);
+            outb(blue>>shift, 0x3C9);
+
+            outb(0x1A,0x3C4);
+            outb(sr1a & 0xFE,0x3C5); /* Map the 3C6/7/8/9 to the IGA1 */    
+
+            outb(0xFF,0x3c6); /* Bit mask of palette */
+            outb(regno,0x3C8); /* Write one register of IGA1 */
+            outb(red>>shift,0x3C9);
+            outb(green>>shift,0x3C9);
+            outb(blue>>shift,0x3C9);
+
+            outb(0x1A,0x3C4);
+            outb(sr1a,0x3C5);
+            outb(0x1B,0x3C4);
+            outb(sr1b,0x3C5);
+            outb(0x67,0x3D4);
+            outb(cr67,0x3D5);
+            outb(0x6A,0x3D4);
+            outb(cr6a,0x3D5);
+            break;
+        case 16:
+            ((u32*)info->pseudo_palette)[regno] = (red & 0xF800) |
+            ((green & 0xFC00) >> 5) | ((blue & 0xF800) >> 11);
+            break;
+        case 32:
+            ((u32*)info->pseudo_palette)[regno] =
+                ((transp & 0xFF00) << 16)   |
+                ((red & 0xFF00) << 8)       |
+                ((green & 0xFF00))          |
+                ((blue & 0xFF00) >> 8);
+            break;
+    }
+   return 0;
+}
+
+/*CALLED BY: fb_set_cmap */
+/*           fb_set_var, pass 256 colors */
+/*CALLED BY: fb_set_cmap */      
+/*           fbcon_set_palette, pass 16 colors */
+static int viafb_setcmap(struct fb_cmap *cmap, struct fb_info *info) {
+    u32 len = cmap->len;
+    u32 i;
+    u16 *pred = cmap->red;
+    u16 *pgreen = cmap->green;
+    u16 *pblue = cmap->blue;
+    u16 *ptransp = cmap->transp;
+    u8 sr1a,sr1b,cr67,cr6a, rev = 0, shift = 10;
+    if(len>256) return 1;
+    if(UNICHROME_CLE266 == chip_info.gfx_chip_name)
+    {
+        /* Read PCI bus 0, dev 0, function 0, index 0xF6 to get chip rev. */
+        outl(0x80000000 | (0xf6 & ~3), (unsigned long)0xCF8);
+        rev = (inl((unsigned long)0xCFC) >> ((0xf6 & 3) * 8)) & 0xff;
+    }
+    switch(info->var.bits_per_pixel) {
+        case 8:
+        outb(0x1A,0x3C4);
+        sr1a = inb(0x3C5);
+        outb(0x1B,0x3C4);
+        sr1b = inb(0x3C5);
+        outb(0x67,0x3D4);
+        cr67 = inb(0x3D5);
+        outb(0x6A,0x3D4);
+        cr6a = inb(0x3D5);
+
+        outb(0x1A,0x3C4);
+        outb(sr1a | 0x01,0x3C5); /* Map the 3C6/7/8/9 to the IGA2 */
+        outb(0x1B,0x3C4);
+        outb(sr1b | 0x80,0x3C5); /* Second Display Engine colck always on */
+        outb(0x67,0x3D4);
+        outb(cr67 & 0x3F,0x3D5); /* Second Display Color Depth 8 */
+        outb(0x6A,0x3D4);
+        outb(cr6a & 0xBF,0x3D5); /* Second Display Channel Reset CR6A[6]) */
+        outb(cr6a | 0x80,0x3D5); /* Second Display Channel Enable CR6A[7] */
+        outb(cr6a | 0xC0,0x3D5); /* Second Display Channel stop reset) */
+
+        outb(0xFF,0x3c6); /* Bit mask of palette */
+        outb(0x00,0x3C8);
+        if(UNICHROME_CLE266 == chip_info.gfx_chip_name && rev >= 15)
+        {
+            shift = 8;
+            write_reg_mask(CR6A, VIACR, BIT5, BIT5);
+            write_reg_mask(SR15, VIASR, BIT7, BIT7);
+        }
+        for (i = 0; i < len; i++)
+        {   
+            outb((*(pred+i))>>shift,0x3C9);
+            outb((*(pgreen+i))>>shift,0x3C9);
+            outb((*(pblue+i))>>shift,0x3C9);
+        }
+
+        outb(0x1A,0x3C4);
+        outb(sr1a & 0xFE,0x3C5); /* Map the 3C6/7/8/9 to the IGA1 */    
+
+        outb(0xFF,0x3c6); /* Bit mask of palette */
+        outb(0x00,0x3C8);
+        for (i = 0; i < len; i++)
+        {   
+            outb((*(pred+i))>>shift,0x3C9);
+            outb((*(pgreen+i))>>shift,0x3C9);
+            outb((*(pblue+i))>>shift,0x3C9);
+        } 
+
+        outb(0x1A,0x3C4);
+        outb(sr1a,0x3C5);
+        outb(0x1B,0x3C4);
+        outb(sr1b,0x3C5);
+        outb(0x67,0x3D4);
+        outb(cr67,0x3D5);
+        outb(0x6A,0x3D4);
+        outb(cr6a,0x3D5);
+        break;
+        case 16:
+        if(len>17) return 0; /* Because static u32 pseudo_pal[17]; */
+        for(i=0;i<len;i++) 
+            ((u32 *)info->pseudo_palette)[i] = 
+                (*(pred+i) & 0xF800)          | 
+                ((*(pgreen+i) & 0xFC00) >> 5) | 
+                ((*(pblue+i) & 0xF800) >> 11);
+        break;
+        case 32:
+        if(len>17) return 0;
+        if(ptransp) {
+            for(i=0;i<len;i++)
+                ((u32*)info->pseudo_palette)[i] =
+                    ((*(ptransp+i) & 0xFF00) << 16)    |
+                    ((*(pred+i) & 0xFF00) << 8)        |
+                    ((*(pgreen+i) & 0xFF00))           |
+                    ((*(pblue+i) & 0xFF00) >> 8);
+        }
+        else {
+            for(i=0;i<len;i++)
+                ((u32*)info->pseudo_palette)[i] =
+                    0x00000000                         |
+                    ((*(pred+i) & 0xFF00) << 8)        |
+                    ((*(pgreen+i) & 0xFF00))           |
+                    ((*(pblue+i) & 0xFF00) >> 8);
+        }
+        break;
+    }
+return 0;
+}
+
+static int viafb_pan_display(struct fb_var_screeninfo *var,
+                 struct fb_info *info)
+{
+    unsigned int offset=0;
+    DEBUG_MSG(KERN_INFO "viafb_pan_display!\n");
+
+ if(var->xoffset > (var->xres_virtual - var->xres)) {
+  return -EINVAL;
+ }
+ if(var->yoffset > (var->yres_virtual - var->yres)) {
+  return -EINVAL;
+ }
+
+ if(var->vmode & FB_VMODE_YWRAP) return -EINVAL;
+
+ if(var->xoffset + info->var.xres > info->var.xres_virtual ||
+    var->yoffset + info->var.yres > info->var.yres_virtual) {
+  return -EINVAL;
+ }
+        /* begin add by zepeng for zerocopy mode ,switch on screen */
+        offset = (var->xoffset + (var->yoffset * var->xres)) * var->bits_per_pixel/16;
+   
+        DEBUG_MSG(KERN_INFO "\nviafb_pan_display,offset =%d ",offset);
+
+        write_reg_mask(0x48,0x3d4,((offset>>24) & 0x3),0x3);
+        write_reg_mask(0x34,0x3d4,((offset>>16) & 0xff),0xff);
+        write_reg_mask(0x0c,0x3d4,((offset>>8) & 0xff),0xff);
+        write_reg_mask(0x0d,0x3d4,(offset & 0xff),0xff);
+
+    ((struct viafb_par *)(info->par))->var.xoffset = var->xoffset;
+    ((struct viafb_par *)(info->par))->var.yoffset = var->yoffset;
+    return 0;
+}
+
+static int viafb_blank(int blank_mode, struct fb_info *info)
+{
+    DEBUG_MSG(KERN_INFO "viafb_blank!\n" );
+    /* clear DPMS setting */
+    switch (blank_mode) {
+    case VESA_NO_BLANKING:
+        /* Screen: On, HSync: On, VSync: On */
+        write_reg_mask(CR36, VIACR, 0x00, BIT4+BIT5);   /* control CRT monitor power management */
+        break;
+    case VESA_HSYNC_SUSPEND:
+        /* Screen: Off, HSync: Off, VSync: On */
+        write_reg_mask(CR36, VIACR, 0x10, BIT4+BIT5);   /* control CRT monitor power management */
+        break;
+    case VESA_VSYNC_SUSPEND:
+        /* Screen: Off, HSync: On, VSync: Off */
+        write_reg_mask(CR36, VIACR, 0x20, BIT4+BIT5);   /* control CRT monitor power management */
+        break;
+    case VESA_POWERDOWN:
+        /* Screen: Off, HSync: Off, VSync: Off */
+        write_reg_mask(CR36, VIACR, 0x30, BIT4+BIT5);   /* control CRT monitor power management */
+        break;
+        }
+    return 0;
+}
+
+/* Under FC5 and kernel after 2.6.16, the fb_ioctl's prototype is changed,*/
+#if defined FC5_2_6_15 || (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,16))
+static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
+#else
+static int viafb_ioctl(struct inode *inode, struct file *file, u_int cmd,
+               u_long arg, struct fb_info *info)
+#endif
+{
+    struct viafb_ioctl_info viainfo;
+    struct viafb_ioctl_mode viamode;
+    struct viafb_ioctl_samm viasamm;
+    struct viafb_driver_version driver_version;
+    struct fb_var_screeninfo sec_var;
+    /* Only for case "SET_DEVICE_INFO" and "GET_DEVICE_INFO" */
+    struct viafb_ioctl_setting viafb_setting;  
+    u32 state_info = 0;
+    u32 item_info =0;
+    u32 viafb_gamma_table[256];
+    char driver_name[10]="viafb\0"; /* for driver name use */
+    POSITIONVALUE view_size, view_pos;
+
+    u32 __user  *argp = (u32 __user *)arg;
+    u32         gpu32 = 0,ss;
+    device_t active_dev;
+    u32 video_dev_info = 0;
+    ss = sizeof(active_dev);
+    memset(&viafb_setting,0,sizeof(viafb_setting));
+    memset(&active_dev,0,ss);
+
+    DEBUG_MSG(KERN_INFO "viafb_ioctl: 0x%X !!\n", cmd);
+    switch (cmd) 
+    {
+        case VIAFB_GET_CHIP_INFO: /* struct chip_information        chip_info ; */
+            if(copy_to_user((void __user *)arg, &chip_info, sizeof(chip_info)))
+                return -EFAULT;
+            break;    
+        case VIAFB_GET_INFO_SIZE:
+            return put_user(sizeof(viainfo), argp);
+        case VIAFB_GET_INFO:
+            return ioctl_get_viafb_info(arg);
+        case VIAFB_HOTPLUG:
+            return put_user((u32)ioctl_hotplug(info->var.xres, info->var.yres, info->var.bits_per_pixel), argp);
+            break;
+        case VIAFB_SET_HOTPLUG_FLAG:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            HotPlug = (gpu32) ? 1 : 0;
+            break;
+        case VIAFB_GET_RESOLUTION:
+            viamode.xres = (u32)HotPlug_Xres;
+            viamode.yres = (u32)HotPlug_Yres;
+            viamode.refresh = (u32)HotPlug_refresh;
+            viamode.bpp = (u32)HotPlug_bpp;
+            if(SAMM_ON==1){
+                viamode.xres_sec=second_xres;
+                viamode.yres_sec=second_yres;
+                viamode.virtual_xres_sec = second_virtual_xres;
+                viamode.virtual_yres_sec = second_virtual_yres;
+                viamode.refresh_sec=refresh1;
+                viamode.bpp_sec=bpp1;
+            }else{
+                viamode.xres_sec=0;
+                viamode.yres_sec=0;
+                viamode.virtual_xres_sec = 0;
+                viamode.virtual_yres_sec = 0;
+                viamode.refresh_sec=0;
+                viamode.bpp_sec=0;
+            }
+            if(copy_to_user((void __user *)arg, &viamode, sizeof(viamode))) {
+                return -EFAULT;
+            }
+            break;
+        case VIAFB_GET_TV_TYPE:
+            return ioctl_get_tv_type(arg);
+        case VIAFB_GET_SAMM_INFO:
+            viasamm.samm_status= SAMM_ON;
+            if(SAMM_ON==1) {
+                if(dual_fb) 
+                {
+                    viasamm.size_prim = parinfo.fbmem_free;
+                    viasamm.size_sec = parinfo1.fbmem_free;
+                }
+                else 
+                {
+                    if(second_size)
+                    {
+                        viasamm.size_prim = parinfo.memsize - second_size*1024*1024;
+                        if(accel)
+                            viasamm.size_sec=second_size*1024*1024 - parinfo.fbmem_used;
+                        else
+                            viasamm.size_sec=second_size*1024*1024;
+                    }
+                    else
+                    {
+                        viasamm.size_prim=parinfo.memsize>>1;
+                        if(accel)
+                            viasamm.size_sec=(parinfo.memsize>>1) - parinfo.fbmem_used;
+                        else
+                            viasamm.size_sec=parinfo.memsize>>1;
+                    }
+                }
+                viasamm.mem_base=parinfo.fbmem;
+                viasamm.offset_sec=second_offset;
+            }else{
+                viasamm.size_prim=parinfo.memsize;
+                viasamm.size_sec=0;
+                viasamm.mem_base=parinfo.fbmem;
+                viasamm.offset_sec=0;
+            }
+           
+            if(copy_to_user((void __user *)arg, &viasamm, sizeof(viasamm))) 
+                return -EFAULT;
+
+            break;
+        case VIAFB_TURN_ON_OUTPUT_DEVICE:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            if (gpu32 & CRT_Device)
+                crt_enable();
+            if (gpu32 & DVI_Device)
+                dvi_enable();
+            if (gpu32 & TV_Device)
+                tv_enable();
+            if (gpu32 & LCD_Device)
+                lcd_enable();
+            break;
+        case VIAFB_TURN_OFF_OUTPUT_DEVICE:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            if (gpu32 & CRT_Device)
+                crt_disable();
+            if (gpu32 & DVI_Device)
+                dvi_disable();
+            if (gpu32 & TV_Device)
+                tv_disable();
+            if (gpu32 & LCD_Device)
+                lcd_disable();
+            break;
+        case VIAFB_SET_DEVICE:
+            if (copy_from_user(&active_dev, (void *)argp,ss))
+            {
+                return -EFAULT;
+            }
+            if(check_macrovision_enabled() && (active_dev.tv != TV_ON || TV_ON))
+                break;
+            viafb_set_device(active_dev);
+            viafb_set_par(info);
+            break;
+        case VIAFB_GET_DEVICE:
+            active_dev.crt = CRT_ON;
+            active_dev.dvi = DVI_ON;
+            active_dev.tv = TV_ON;
+            active_dev.lcd = LCD_ON;
+            active_dev.samm = SAMM_ON;
+            active_dev.primary_dev = primary_dev;
+
+            active_dev.tv_system = tv_system;
+            active_dev.tv_level = tv_level;
+            active_dev.tv_out_sig = tv_out_signal;
+            active_dev.tv_dedotcrawl = tv_dedotcrawl;
+
+            active_dev.lcd_dsp_cent = lcd_dsp_method; 
+            active_dev.lcd_panel_id = lcd_panel_id;
+            active_dev.lcd_mode = lcd_mode;
+
+            active_dev.xres = HotPlug_Xres;
+            active_dev.yres = HotPlug_Yres;
+
+            active_dev.xres1 = second_xres;
+            active_dev.yres1 = second_yres;
+      
+            active_dev.bpp = bpp;
+            active_dev.bpp1 = bpp1;
+            active_dev.refresh = refresh;
+            active_dev.refresh1 = refresh1;
+            
+            active_dev.epia_dvi=EPIA_DVI;
+            active_dev.lcd_dual_edge=LCDDualEdge;
+            active_dev.bus_width=BusWidth;
+
+            if(copy_to_user((void __user *)arg, &active_dev,ss)) 
+                return -EFAULT;
+            break;
+        case VIAFB_SET_TV_FFILTER:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            tv_set_ffilter(STATE_ON, gpu32);
+            break;
+        case VIAFB_SET_TV_COLOR_DEFAULT:
+        {
+            u32 def_val[4];
+            tv_set_brightness(tv_setting_info.DefaultBrightness);
+            tv_set_contrast(tv_setting_info.DefaultContrast);
+            tv_set_saturation(tv_setting_info.DefaultSaturation);
+            tv_set_tint(tv_setting_info.DefaultTINT);
+            def_val[0] = tv_setting_info.DefaultBrightness;
+            def_val[1] = tv_setting_info.DefaultContrast;
+            def_val[2] = tv_setting_info.DefaultSaturation;
+            def_val[3] = tv_setting_info.DefaultTINT;
+            if(copy_to_user((void __user *)arg, &def_val, sizeof(u32)*4)) 
+                return -EFAULT;
+            break;
+        }
+        case VIAFB_SET_TV_BRIGHTNESS:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            tv_set_brightness(gpu32);
+            break;
+        case VIAFB_SET_TV_CONTRAST:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            tv_set_contrast(gpu32);
+            break;
+        case VIAFB_SET_TV_SATURATION:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            tv_set_saturation(gpu32);
+            break;
+        case VIAFB_SET_TV_TINT:
+            if(copy_from_user(&gpu32, argp, sizeof(gpu32))) {
+                return -EFAULT;
+            }
+            tv_set_tint(gpu32);
+            break;
+
+        /* Add for getting driver version. */
+        case VIAFB_GET_DRIVER_VERSION:
+            driver_version.iMajorNum = VERSION_MAJOR;            
+            driver_version.iKernelNum = VERSION_KERNEL;
+            driver_version.iOSNum = VERSION_OS;
+            driver_version.iMinorNum = VERSION_MINOR;
+            
+            if(copy_to_user((void __user *)arg, &driver_version, sizeof(driver_version)))
+            {
+                return -EFAULT;
+            }
+            break;
+
+        /* Set and apply CRT,DVI,LCD,TV's setting info. */
+        case VIAFB_SET_DEVICE_INFO:
+            if(copy_from_user(&viafb_setting, (void *)argp,sizeof(viafb_setting)))
+            {
+                return -EFAULT;
+            }
+            if(check_macrovision_enabled() && (((viafb_setting.device_status & TV_Device)>> 2) != TV_ON || TV_ON))
+                break;
+            if(apply_device_setting(viafb_setting, info)<0)
+            {
+                return -EINVAL;
+            }           
+            break;
+
+        case VIAFB_SET_SECOND_MODE:
+             if(copy_from_user(&sec_var, (void *)argp,sizeof(sec_var)))
+            {
+                return -EFAULT;
+            }
+            apply_second_mode_setting(&sec_var);
+            break;
+        
+        /*  Get current VIA framebuffer device setting info. */
+        case VIAFB_GET_DEVICE_INFO:
+
+            retrieve_device_setting(&viafb_setting);
+
+            if(copy_to_user((void __user *)arg, &viafb_setting, sizeof(viafb_setting)))
+            {
+               return -EFAULT;
+            }
+            break;
+
+        case VIAFB_GET_DEVICE_SUPPORT:
+            get_device_support_state(&state_info);
+            if (put_user(state_info, argp))
+            {
+               return -EFAULT; 
+            }
+            break;
+            
+        case VIAFB_GET_DEVICE_CONNECT:
+            get_device_connect_state(&state_info);
+            if (put_user(state_info, argp))
+            {
+               return -EFAULT; 
+            }
+            break;
+            
+        case VIAFB_GET_PANEL_SUPPORT_EXPAND:
+            state_info = lcd_get_support_expand_state(info->var.xres, info->var.yres);
+            if (put_user(state_info, argp))
+            {
+               return -EFAULT; 
+            }
+            break;
+            
+        case VIAFB_GET_TV_SUPPORT_SIGNAL:
+            tv_get_support_signal(&state_info);
+            if (put_user(state_info, argp))
+            {
+               return -EFAULT; 
+            }
+            break;
+            
+        case VIAFB_GET_TV_SUPPORT_STANDARD:
+            tv_get_support_standard(&state_info);
+            if (put_user(state_info, argp))
+            {
+               return -EFAULT; 
+            }
+            break;
+            
+        case VIAFB_GET_TV_MAX_SIZE:
+            state_info = tv_get_max_size();
+            if (put_user(state_info, argp))
+            {
+               return -EFAULT; 
+            }
+            break;
+            
+        case VIAFB_GET_TV_MAX_POSITION:
+            if (put_user(TV_HOR_POSITION_MAXIMUM, argp))
+            {
+               return -EFAULT; 
+            }
+            break;
+            
+        case VIAFB_GET_TV_SUPPORT_TUNING_ITEM:
+            tv_get_support_tuning_state(&state_info);
+            if (put_user(state_info, argp))
+            {
+               return -EFAULT; 
+            }
+            break;
+            
+        case VIAFB_GET_TV_MAX_TUNING_VALUE:
+            get_user(item_info, argp);
+            tv_get_tuning_max_value(item_info, &state_info);
+            put_user(state_info, argp);
+            break;
+            
+        case VIAFB_GET_TV_SUPPORT_SETTING_ITEM:
+            tv_get_support_setting_state(&state_info);
+            if (put_user(state_info, argp))
+            {
+               return -EFAULT; 
+            }
+            break;
+
+        /* Add for setting TV position. */
+        case VIAFB_SET_TV_POSITION:
+            if(copy_from_user(&view_pos, (void *)argp, sizeof(POSITIONVALUE)))
+            {
+                return -EFAULT;
+            }
+
+            tv_set_position(view_pos.dwX, view_pos.dwY);
+            break;
+
+        /* Add for setting TV size. */
+        case VIAFB_SET_TV_SIZE:
+            if(copy_from_user(&view_size, (void *)argp, sizeof(POSITIONVALUE)))
+            {
+                return -EFAULT;
+            }
+            tv_set_size(view_size.dwX, view_size.dwY);
+            break;
+            
+        case VIAFB_GET_DRIVER_NAME:
+            if(copy_to_user((void __user *)arg, driver_name, sizeof(driver_name)))
+            {
+                return -EFAULT;
+            }
+            break;
+            
+        case VIAFB_SET_GAMMA_LUT:
+            if(copy_from_user(viafb_gamma_table, argp, sizeof(viafb_gamma_table)))
+            {
+                return -EFAULT;
+            }
+            set_gamma_table(bpp, viafb_gamma_table);            
+            break;
+            
+        case VIAFB_GET_GAMMA_LUT:
+            get_gamma_table(viafb_gamma_table);
+            if(copy_to_user((void __user *)arg, viafb_gamma_table, sizeof(viafb_gamma_table)))
+            {
+                return -EFAULT;
+            }
+            break;
+            
+        case VIAFB_GET_GAMMA_SUPPORT_STATE:
+            get_gamma_support_state(bpp, &state_info);
+            if (put_user(state_info, argp))
+            {
+               return -EFAULT; 
+            }
+            break;
+        case VIAFB_SET_VIDEO_DEVICE:
+            get_user(video_dev_info, argp);
+            viafb_set_video_device(video_dev_info);
+            break;
+        case VIAFB_GET_VIDEO_DEVICE:
+            viafb_get_video_device(&video_dev_info);
+            if (put_user(video_dev_info, argp))
+            {
+               return -EFAULT; 
+            }
+            break;
+        default:
+            return -EINVAL;
+        }
+
+    return 0;
+}
+
+static void viafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+{
+    u32 col = 0, rop = 0;
+    int pitch;
+
+    if(!accel)
+        return cfb_fillrect(info, rect);
+
+    if(!rect->width || !rect->height)
+        return;
+
+    switch (rect->rop)
+    {
+        case ROP_XOR:
+            rop = 0x5A;
+            break;
+        case ROP_COPY:
+        default:
+            rop = 0xF0;
+            break;
+    }
+
+    switch(info->var.bits_per_pixel)
+    {
+        case 8:
+            col = rect->color;
+            break;
+        case 16:
+            col = ((u32 *)(info->pseudo_palette))[rect->color];
+            break;
+        case 32:
+            col = ((u32 *)(info->pseudo_palette))[rect->color];
+            break;
+    }
+    /* BitBlt Source Address */
+    MMIO_OUT32(VIA_REG_SRCPOS, 0x0);
+    /* Source Base Address */
+    MMIO_OUT32(VIA_REG_SRCBASE, 0x0);
+    /* Destination Base Address */ 
+    MMIO_OUT32(VIA_REG_DSTBASE, ((u32)(info->screen_base) - (u32)FB_MM) >> 3);
+    /* Pitch */
+    pitch = (info->var.xres_virtual +7) & ~7;
+    MMIO_OUT32(VIA_REG_PITCH, VIA_PITCH_ENABLE | (((pitch * info->var.bits_per_pixel >> 3) >> 3) |
+                (((pitch * info->var.bits_per_pixel >> 3) >> 3) << 16)));
+    /* BitBlt Destination Address */
+    MMIO_OUT32(VIA_REG_DSTPOS, ((rect->dy << 16) | rect->dx));
+    /* Dimension: width & height */
+    MMIO_OUT32(VIA_REG_DIMENSION, (((rect->height - 1) << 16) | (rect->width - 1)));
+    /* Forground color or Destination color */
+    MMIO_OUT32(VIA_REG_FGCOLOR, col);
+    /* GE Command */
+    MMIO_OUT32(VIA_REG_GECMD, (0x01|0x2000|(rop<<24)));
+
+}
+
+static void viafb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+{
+    u32 dy = area->dy, sy = area->sy, direction = 0x0;
+    u32 sx = area->sx, dx = area->dx, width = area->width; 
+    int pitch;
+
+    DEBUG_MSG(KERN_INFO "viafb_copyarea!!\n");
+
+    if(!accel)
+        return cfb_copyarea(info, area);
+
+    if (!area->width || !area->height)
+        return;
+
+    if (area->sy < area->dy)
+    {
+        dy += area->height - 1;
+        sy += area->height - 1;
+        direction |= 0x8000;
+    }
+
+    if (sx < dx)
+    {
+        dx += width - 1;
+        sx += width - 1;
+        direction |= 0x4000;
+    }
+
+    /* Source Base Address */
+    MMIO_OUT32(VIA_REG_SRCBASE, ((u32)(info->screen_base) - (u32)FB_MM) >> 3);  
+    /* Destination Base Address */
+    MMIO_OUT32(VIA_REG_DSTBASE, ((u32)(info->screen_base) - (u32)FB_MM) >> 3);
+    /* Pitch */
+    pitch = (info->var.xres_virtual+7) & ~7;
+    MMIO_OUT32(VIA_REG_PITCH, VIA_PITCH_ENABLE | (((pitch * info->var.bits_per_pixel >> 3) >> 3) |
+                (((pitch * info->var.bits_per_pixel >> 3) >> 3) << 16)));
+    /* BitBlt Source Address */
+    MMIO_OUT32(VIA_REG_SRCPOS, ((area->sy << 16) | area->sx));
+    /* BitBlt Destination Address */
+    MMIO_OUT32(VIA_REG_DSTPOS, ((area->dy << 16) | area->dx));
+    /* Dimension: width & height */
+    MMIO_OUT32(VIA_REG_DIMENSION, (((area->height - 1) << 16) | (area->width - 1)));
+    /* GE Command */
+    MMIO_OUT32(VIA_REG_GECMD, (0x01|direction|(0xCC<<24)));
+
+}
+
+static void viafb_imageblit(struct fb_info *info, const struct fb_image *image)
+{
+    u32 size, bg_col = 0, fg_col = 0, *udata;
+    int i;
+    int pitch;
+
+    if(!accel)
+        return cfb_imageblit(info, image);
+
+    udata = (u32*)image->data;
+
+    switch(info->var.bits_per_pixel)
+    {
+        case 8:
+            bg_col = image->bg_color;
+            fg_col = image->fg_color;
+            break;
+        case 16:
+            bg_col = ((u32 *)(info->pseudo_palette))[image->bg_color];
+            fg_col = ((u32 *)(info->pseudo_palette))[image->fg_color];
+            break;
+        case 32:
+            bg_col = ((u32 *)(info->pseudo_palette))[image->bg_color];
+            fg_col = ((u32 *)(info->pseudo_palette))[image->fg_color];
+            break;
+    }
+    size = image->width * image->height;
+
+    /* Source Base Address */
+    MMIO_OUT32(VIA_REG_SRCBASE, 0x0);
+    /* Destination Base Address */
+    MMIO_OUT32(VIA_REG_DSTBASE, ((u32)(info->screen_base) - (u32)FB_MM) >> 3);
+    /* Pitch */
+    pitch = (info->var.xres_virtual+7) & ~7;
+    MMIO_OUT32(VIA_REG_PITCH, VIA_PITCH_ENABLE | (((pitch * info->var.bits_per_pixel >> 3) >> 3) |
+                (((pitch * info->var.bits_per_pixel >> 3) >> 3) << 16)));
+    /* BitBlt Source Address */
+    MMIO_OUT32(VIA_REG_SRCPOS, 0x0);
+    /* BitBlt Destination Address */
+    MMIO_OUT32(VIA_REG_DSTPOS, ((image->dy << 16) | image->dx));
+    /* Dimension: width & height */
+    MMIO_OUT32(VIA_REG_DIMENSION, (((image->height - 1) << 16) | (image->width - 1)));
+    /* fb color */
+    MMIO_OUT32(VIA_REG_FGCOLOR, fg_col);
+    /* bg color */
+    MMIO_OUT32(VIA_REG_BGCOLOR, bg_col);
+    /* GE Command */
+    MMIO_OUT32(VIA_REG_GECMD, 0xCC020142);
+
+    for(i=0;i<size/4;i++)
+    {
+        MMIO_OUT32(VIA_MMIO_BLTBASE, *udata);
+        udata++;
+    }
+}
+
+static int viafb_cursor(struct fb_info *info, struct fb_cursor *cursor)
+{
+    u8  data[CURSOR_SIZE/8];
+    u32 data_bak[CURSOR_SIZE/32];
+    u32 temp, xx, yy, bg_col = 0, fg_col = 0;
+    int size, i, j = 0;
+    /* Initial HW cursor flag */
+    static int MAX_CURS = 32;
+
+    if(!accel)
+        return soft_cursor(info, cursor);
+
+    /* For dual-fb, CLE266 only IGA1 use HW cursor. */
+    if((((struct viafb_par *)(info->par))->iga_path==IGA2) && (chip_info.gfx_chip_name==UNICHROME_CLE266)) {
+        return soft_cursor(info, cursor);
+    }
+
+    /* When duoview and using lcd , use soft cursor */
+    if(LCD_ON || ((struct viafb_par *)(info->par))->duoview){
+        return soft_cursor(info, cursor);
+    }
+
+    ShowHideHWCursor(info, HW_Cursor_OFF);
+    #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,10)
+    viacursor = *cursor;
+    #endif 
+
+    if(cursor->set & FB_CUR_SETHOT)
+    {
+        viacursor.hot = cursor->hot;
+        temp = ((viacursor.hot.x)<<16) + viacursor.hot.y;
+        MMIO_OUT32(VIA_REG_CURSOR_ORG, temp);
+    }
+
+    if(cursor->set & FB_CUR_SETPOS)
+    {
+  viacursor.image.dx = cursor->image.dx;
+  viacursor.image.dy = cursor->image.dy;
+  yy = cursor->image.dy - info->var.yoffset;
+  xx = cursor->image.dx - info->var.xoffset;
+  temp = yy & 0xFFFF;
+  temp |= (xx << 16);
+        MMIO_OUT32(VIA_REG_CURSOR_POS, temp);
+    }
+
+    if(cursor->set & FB_CUR_SETSIZE)
+    {
+        temp = MMIO_IN32(VIA_REG_CURSOR_MODE);
+
+        if((cursor->image.width <= 32)&&(cursor->image.height <= 32))
+        {
+            MAX_CURS = 32;
+            temp |= 0x2;
+        }
+        else if((cursor->image.width <= 64)&&(cursor->image.height <= 64))
+        {
+            MAX_CURS = 64;
+            temp &= 0xFFFFFFFD;
+        }
+        else
+        {
+            DEBUG_MSG(KERN_INFO "The cursor image is biger than 64x64 bits...\n");
+            return -ENXIO;
+        }
+        MMIO_OUT32(VIA_REG_CURSOR_MODE, temp);
+
+        viacursor.image.height = cursor->image.height;
+        viacursor.image.width = cursor->image.width;
+    }
+
+    if(cursor->set & FB_CUR_SETCMAP)
+    {
+        viacursor.image.fg_color = cursor->image.fg_color;
+        viacursor.image.bg_color = cursor->image.bg_color;
+
+        switch(info->var.bits_per_pixel)
+        {
+            case 8:
+                /* FIX ME:It seems that hardware cursor always work in true color mode */
+                bg_col = (viafb_256_colors.red[viacursor.image.bg_color]>>8<<16);
+                bg_col = bg_col |(viafb_256_colors.green[viacursor.image.bg_color]>>8<<8);
+                bg_col = bg_col |(viafb_256_colors.blue[viacursor.image.bg_color]>>8);
+                fg_col = (viafb_256_colors.red[viacursor.image.fg_color]>>8<<16);
+                fg_col = fg_col |(viafb_256_colors.green[viacursor.image.fg_color]>>8<<8);
+                fg_col = fg_col |(viafb_256_colors.blue[viacursor.image.fg_color]>>8);
+                break;
+            case 16:
+                bg_col = ((u32 *)(info->pseudo_palette))[viacursor.image.bg_color];
+                bg_col = (0xFF<<24)|((bg_col&0xF800)<<8)|((bg_col&0x7E0)<<5)|((bg_col&0x1F)<<3);
+                fg_col = ((u32 *)(info->pseudo_palette))[viacursor.image.fg_color];
+                fg_col = (0xFF<<24)|((fg_col&0xF800)<<8)|((fg_col&0x7E0)<<5)|((fg_col&0x1F)<<3);
+                break;
+            case 32:
+                bg_col = ((u32 *)(info->pseudo_palette))[viacursor.image.bg_color];
+                fg_col = ((u32 *)(info->pseudo_palette))[viacursor.image.fg_color];
+                break;
+        }
+        MMIO_OUT32(VIA_REG_CURSOR_BG, bg_col);
+        MMIO_OUT32(VIA_REG_CURSOR_FG, fg_col);
+    }
+
+    if(cursor->set & FB_CUR_SETSHAPE)
+    {
+        size = ((viacursor.image.width + 7) >> 3) * viacursor.image.height;
+
+        if(MAX_CURS == 32)
+        {
+            for(i=0;i<(CURSOR_SIZE/32);i++)
+            {
+                data_bak[i] = 0x0;
+                data_bak[i+1] = 0xFFFFFFFF;
+                i += 1;
+            }
+        }
+        else if(MAX_CURS == 64)
+        {
+            for(i=0;i<(CURSOR_SIZE/32);i++)
+            {
+                data_bak[i] = 0x0;
+                data_bak[i+1] = 0x0;
+                data_bak[i+2] = 0xFFFFFFFF;
+                data_bak[i+3] = 0xFFFFFFFF;
+                i += 3;
+            }
+        }
+        switch (viacursor.rop)
+        {
+        /* The kernel always send ROP_XOR. */
+        /* But for via's HW, we only need to copy the mask[i] to data[i], */
+            case ROP_XOR:
+                for (i = 0; i <size; i++)
+                {
+                    data[i] = viacursor.mask[i];
+                }
+                break;
+            case ROP_COPY:
+            
+                for (i = 0; i < size; i++)
+                {
+                    data[i] = viacursor.mask[i]; 
+                }
+                break;
+            default:
+                break;
+        }
+
+        if(MAX_CURS == 32)
+        {
+            for(i=0;i<size;i++)
+            {
+                data_bak[j] = (u32)data[i];
+                data_bak[j+1] = ~data_bak[j];
+                j += 2;
+            }
+        }
+        else if(MAX_CURS == 64)
+        {
+            for(i=0;i<size;i++)
+            {
+                data_bak[j] = (u32)data[i];
+                data_bak[j+1] = 0x0;
+                data_bak[j+2] = ~data_bak[j];
+                data_bak[j+3] = ~data_bak[j+1];
+                j += 4;
+            }
+        }
+        memcpy(((struct viafb_par *)(info->par))->fbmem_virt+((struct viafb_par *)(info->par))->cursor_start, data_bak, CURSOR_SIZE);
+    }
+
+    if (viacursor.enable)
+        ShowHideHWCursor(info, HW_Cursor_ON);
+ return 0;
+}
+
+static int viafb_sync(struct fb_info *info)
+{
+    if(accel)
+        WaitEngineIdle();
+    return 0;
+}
+
+#endif
+
+int get_mode_index(int hres, int vres,int flag)
+{
+    DEBUG_MSG(KERN_INFO "get_mode_index!\n" );
+    if(flag==0){
+    if (hres==640 && vres==480) {
+        resMode = VIA_RES_640X480;
+        mode = "640x480";
+    } else if (hres==800 && vres==480) {
+        resMode = VIA_RES_800X480;
+        mode = "800x480";
+    } else if (hres==800 && vres==600) {
+        resMode = VIA_RES_800X600;
+        mode = "800x600";
+    } else if (hres==1024 && vres==768) {
+        resMode = VIA_RES_1024X768;
+        mode = "1024x768";
+    } else if (hres==1152 && vres==864) {
+        resMode = VIA_RES_1152X864;
+        mode = "1152x864";
+    } else if (hres==1280 && vres==1024) {
+        resMode = VIA_RES_1280X1024;
+        mode = "1280x1024";
+    } else if (hres==1600 && vres==1200) {
+        resMode = VIA_RES_1600X1200;
+        mode = "1600x1200";
+    } else if (hres==1440 && vres==1050) {
+        resMode = VIA_RES_1440X1050;
+        mode = "1440x1050";
+    } else if (hres==1280 && vres==768) {
+        resMode = VIA_RES_1280X768;
+        mode = "1280x768";
+    } else if (hres==1280 && vres==800) {
+        resMode = VIA_RES_1280X800;
+        mode = "1280x800";
+ } else if (hres==1280 && vres==960) {
+        resMode = VIA_RES_1280X960;
+        mode = "1280x960";
+    } else if (hres==1920 && vres==1440) {
+        resMode = VIA_RES_1920X1440;
+        mode = "1920x1440";
+    } else if (hres==848 && vres==480) {
+        resMode = VIA_RES_848X480;
+        mode = "848x480";
+    } else if (hres==1400 && vres==1050) {
+        resMode = VIA_RES_1400X1050;
+        mode = "1400x1050";
+    } else if (hres==720 && vres==480) {
+        resMode = VIA_RES_720X480;
+        mode = "720x480";
+    } else if (hres==720 && vres==576) {
+        resMode = VIA_RES_720X576;
+        mode = "720x576";
+    } else if (hres==1024 && vres==512) {
+        resMode = VIA_RES_1024X512;
+        mode = "1024x512";
+    } else if (hres==856 && vres==480) {
+        resMode = VIA_RES_856X480;
+        mode = "856x480";
+    } else if (hres==1024 && vres==576) {
+        resMode = VIA_RES_1024X576;
+        mode = "1024x576";
+    } else if (hres==1024 && vres==600){
+     resMode = VIA_RES_1024X600; 
+        mode = "1024x600";
+    } else if (hres==1280 && vres==720) {
+        resMode = VIA_RES_1280X720;
+        mode = "1280x720";
+    } else if (hres==1920 && vres==1080) {
+        resMode = VIA_RES_1920X1080;
+        mode = "1920x1080";
+    } else if (hres==1366 && vres==768){
+      resMode = VIA_RES_1368X768; 
+        mode = "1368x768";
+    } else {
+        resMode = VIA_RES_INVALID;
+        mode = "640x480";
+    }
+    }else{
+         if (hres==640 && vres==480) {
+            resMode = VIA_RES_640X480;
+            mode1 = "640x480";
+        } else if (hres==800 && vres==480) {
+            resMode = VIA_RES_800X480;
+            mode1 = "800x480";
+        } else if (hres==800 && vres==600) {
+            resMode = VIA_RES_800X600;
+            mode1 = "800x600";
+        } else if (hres==1024 && vres==768) {
+            resMode = VIA_RES_1024X768;
+            mode1 = "1024x768";
+        } else if (hres==1152 && vres==864) {
+            resMode = VIA_RES_1152X864;
+            mode1 = "1152x864";
+        } else if (hres==1280 && vres==1024) {
+            resMode = VIA_RES_1280X1024;
+            mode1 = "1280x1024";
+        }else if (hres==1600 && vres==1200) {
+            resMode = VIA_RES_1600X1200;
+            mode = "1600x1200";
+        } else if (hres==1440 && vres==1050) {
+            resMode = VIA_RES_1440X1050;
+            mode1 = "1440x1050";
+        } else if (hres==1280 && vres==768) {
+            resMode = VIA_RES_1280X768;
+            mode1 = "1280x768";
+        } else if (hres==1280 && vres==800) {
+            resMode = VIA_RES_1280X800;
+            mode1 = "1280x800";
+  } else if (hres==1280 && vres==960) {
+            resMode = VIA_RES_1280X960;
+            mode1 = "1280x960";
+        } else if (hres==1920 && vres==1440) {
+            resMode = VIA_RES_1920X1440;
+            mode1 = "1920x1440";
+        } else if (hres==848 && vres==480) {
+            resMode = VIA_RES_848X480;
+            mode1 = "848x480";
+        } else if (hres==1400 && vres==1050) {
+            resMode = VIA_RES_1400X1050;
+            mode1 = "1400x1050";
+        } else if (hres==720 && vres==480) {
+            resMode = VIA_RES_720X480;
+            mode1 = "720x480";
+        } else if (hres==720 && vres==576) {
+            resMode = VIA_RES_720X576;
+            mode1 = "720x576";
+        } else if (hres==1024 && vres==512) {
+            resMode = VIA_RES_1024X512;
+            mode1 = "1024x512";
+        } else if (hres==856 && vres==480) {
+            resMode = VIA_RES_856X480;
+            mode1 = "856x480";
+        } else if (hres==1024 && vres==576) {
+            resMode = VIA_RES_1024X576;
+            mode1 = "1024x576";            
+        } else if (hres==1024 && vres==600){
+         resMode = VIA_RES_1024X600; 
+            mode1 = "1024x600";
+        } else if (hres==1280 && vres==720) {
+            resMode = VIA_RES_1280X720;
+            mode1 = "1280x720";
+         } else if (hres==1920 && vres==1080) {
+            resMode = VIA_RES_1920X1080;
+            mode1 = "1920x1080";
+        } else if (hres==1366 && vres==768){
+          resMode = VIA_RES_1368X768; 
+            mode1 = "1368x768";
+      }else {
+            resMode = VIA_RES_INVALID;
+            mode1 = "640x480";
+        }
+    }
+    return(resMode);
+}

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
