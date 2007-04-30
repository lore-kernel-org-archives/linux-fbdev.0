From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4/12] viafb: Framebuffer driver for VIA
 UniChrome/Chrome9 HC (fwd)
Date: Mon, 30 Apr 2007 10:36:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704301036370.27246@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiRNZ-0006Sp-0W for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:37:05 -0700
Received: from europa.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiRNX-0001bt-IG
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:37:04 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by europa.telenet-ops.be (Postfix) with SMTP id 1067F41A4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:02 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by europa.telenet-ops.be (Postfix) with ESMTP id 1A2E7411E
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:36:57 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l3U8avlF020366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:36:57 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l3U8avE8020363
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:36:57 +0200
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
Date: Mon, 30 Apr 2007 13:20:16 +0800
From: EddyFu@via.com.tw
To: linux-fbdev-devel-bounces@lists.sourceforge.net
Subject: [Linux-fbdev-devel] [PATCH 4/12] viafb: Framebuffer driver for VIA
    UniChrome/Chrome9 HC

Dear All, 
 
Here is the part 4/12 of viafb.
 
Best Regards,
Eddy Fu 
 
diff -Nur linux-2.6.21-rc7/drivers/video/via/lcd.c linux-2.6.21-rc7.viafb/drivers/video/via/lcd.c
--- linux-2.6.21-rc7/drivers/video/via/lcd.c 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/lcd.c 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,1630 @@
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
+#include <linux/ioport.h>
+#include <asm/io.h>
+
+#include "debug.h"
+#include "lcd.h"
+#include "lcdtbl.h"
+#include "chip.h"
+#include "share.h"
+#include "hw.h"
+#include "viamode.h"
+#include "hwcfig.h"
+#include "via_i2c.h"
+
+/* extern function */
+extern int i2cWriteByte(u8 slave_addr, u8 index, u8 data);
+extern int i2cReadByte(u8 slave_addr, u8 index, u8 *pData);
+extern void set_output_path(int device, int set_iga, int output_interface);
+extern void fill_crtc_timing(struct crt_mode_table *crt_table, int mode_index, int bpp_byte, int set_iga);
+extern void write_reg_mask(u8 index, int io_port, u8 data, u8 mask);
+extern void load_reg(int timing_value, int load_reg_num, struct io_register *reg, int io_type);
+extern struct display_timing get_timing_value(struct crt_mode_table *crt_table, int mode_index);
+extern void load_offset_reg(int h_addr, int bpp_byte, int set_iga);
+extern void load_fetch_count_reg(int h_addr, int bpp_byte, int set_iga);
+extern void write_regx(struct io_reg RegTable[],int ItemNum);
+extern int get_mode_index(int hres, int vres,int flag);
+extern void delays(int count);
+extern inline void lock_crt(void);
+extern inline void unlock_crt(void);
+extern inline u8 read_reg(int io_port, u8 index);
+extern inline void write_reg(u8 index, u16 io_port, u8 data);
+extern int SearchModeSetting(int ModeInfoIndex);
+extern void load_FIFO_reg(int set_iga, int hor_active, int ver_active);
+extern u32 get_clk_value(int clk);
+extern void SetVCLK(u32 CLK, int set_iga);
+extern void load_crtc_timing(struct display_timing device_timing, int set_iga);
+extern void set_color_depth(int bpp_byte, int set_iga);
+extern bool lvds_identify_vt1636(void);
+extern void init_lvds_vt1636(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+void disable_lvds_vt1636(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+void enable_lvds_vt1636(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+extern void vt1636_patch_skew_on_vt3324(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+extern void vt1636_patch_skew_on_vt3327(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+extern void vt1636_patch_skew_on_vt3364(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+
+
+/* extern struct */
+extern struct chip_information              chip_info;
+extern struct lvds_setting_information      lvds_setting_info;
+extern struct lvds_setting_information      lvds_setting_info2;
+extern struct _lcd_scaling_factor           lcd_scaling_factor;
+extern struct iga1_crtc_timing              iga1_crtc_reg;
+extern struct iga1_shadow_crtc_timing       iga1_shadow_crtc_reg;
+extern struct iga2_crtc_timing              iga2_crtc_reg;
+
+extern int lcd_panel_id;
+
+extern int SAMM_ON, LCD2_ON, LCD_ON;
+extern int display_hardware_layout;
+
+int lvds_register_read(int index);
+int fp_id_to_vindex(int panel_id);
+void load_lcd_scaling(int set_hres, int set_vres, int panel_hres, int panel_vres);
+void load_lcd_k400_patch_tbl(int set_hres, int set_vres, int panel_id);
+void load_lcd_p880_patch_tbl(int set_hres, int set_vres, int panel_id);
+void load_lcd_patch_regs(int set_hres, int set_vres, int panel_id, int set_iga);
+void VIAPitchAlignmentPatchLCD(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+void lcd_disable(void);
+void lcd_enable(void);
+void LCDPowerSequenceOff(void);
+void LCDPowerSequenceOn(void);
+void fill_lcd_format(void);
+void init_lvds_output_interface(struct lvds_chip_information *plvds_chip_info, struct lvds_setting_information* plvds_setting_info);
+struct display_timing lcd_centering_timging(struct display_timing mode_crt_reg, struct display_timing panel_crt_reg);
+void load_crtc_shadow_timing(struct display_timing mode_timing, struct display_timing panel_timing);
+void load_scaling_factor_for_p4m900(int set_hres, int set_vres, int panel_hres, int panel_vres);
+
+
+
+int check_lvds_chip(int device_id_subaddr, int device_id)
+{
+    if (lvds_register_read(device_id_subaddr) == device_id)
+        return(OK);
+    else
+        return(FAIL);
+}
+
+void init_lcd_size(void)
+{
+    DEBUG_MSG(KERN_INFO "init_lcd_size()\n");
+    DEBUG_MSG(KERN_INFO "lvds_setting_info.get_lcd_size_method %d\n", lvds_setting_info.get_lcd_size_method);
+
+    switch(lvds_setting_info.get_lcd_size_method) {
+        case GET_LCD_SIZE_BY_SYSTEM_BIOS:
+            break;
+        case GET_LCD_SZIE_BY_HW_STRAPPING:
+            break;
+        case GET_LCD_SIZE_BY_VGA_BIOS:
+            DEBUG_MSG(KERN_INFO "Get LCD Size method by VGA BIOS !!\n");     
+            lvds_setting_info.lcd_panel_size =  fp_id_to_vindex(lcd_panel_id);
+            DEBUG_MSG(KERN_INFO "LCD Panel_ID = %d\n", lvds_setting_info.lcd_panel_id);
+            DEBUG_MSG(KERN_INFO "LCD Panel Size = %d\n", lvds_setting_info.lcd_panel_size);      
+            break;
+        case GET_LCD_SIZE_BY_USER_SETTING:
+            DEBUG_MSG(KERN_INFO "Get LCD Size method by user setting !!\n");
+            lvds_setting_info.lcd_panel_size = fp_id_to_vindex(lcd_panel_id);
+            DEBUG_MSG(KERN_INFO "LCD Panel_ID = %d\n", lvds_setting_info.lcd_panel_id);
+            DEBUG_MSG(KERN_INFO "LCD Panel Size = %d\n", lvds_setting_info.lcd_panel_size);
+            break;
+        default:
+            DEBUG_MSG(KERN_INFO "init_lcd_size fail\n");
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID1_800X600;
+            lvds_setting_info.lcd_panel_size = fp_id_to_vindex(LCD_PANEL_ID1_800X600);
+    }
+    lvds_setting_info2.lcd_panel_id = lvds_setting_info.lcd_panel_id;
+    lvds_setting_info2.lcd_panel_size = lvds_setting_info.lcd_panel_size;
+    lvds_setting_info2.lcd_panel_hres = lvds_setting_info.lcd_panel_hres;
+    lvds_setting_info2.lcd_panel_vres = lvds_setting_info.lcd_panel_vres;
+    lvds_setting_info2.LCDDualEdge = lvds_setting_info.LCDDualEdge;
+    lvds_setting_info2.LCDDithering = lvds_setting_info.LCDDithering;
+}
+
+bool lvds_identify_integratedlvds(void)
+{
+    if (display_hardware_layout == HW_LAYOUT_LCD_EXTERNAL_LCD2)
+    {
+        /* Two dual channel LCD (Internal LVDS + External LVDS): */
+        /* If we have an external LVDS, such as VT1636, we should have its chip ID already. */
+        if (chip_info.lvds_chip_info.lvds_chip_name)
+        {
+            chip_info.lvds_chip_info2.lvds_chip_name = INTEGRATED_LVDS;
+            DEBUG_MSG(KERN_INFO "Support two dual channel LVDS! (Internal LVDS + External LVDS)\n");
+        }
+        else
+        {
+            chip_info.lvds_chip_info.lvds_chip_name = INTEGRATED_LVDS;
+            DEBUG_MSG(KERN_INFO "Not found external LVDS, so can't support two dual channel LVDS!\n");
+        }
+    }
+    else if (display_hardware_layout == HW_LAYOUT_LCD1_LCD2)
+    {
+        /* Two single channel LCD (Internal LVDS + Internal LVDS): */
+        chip_info.lvds_chip_info.lvds_chip_name = INTEGRATED_LVDS;
+        chip_info.lvds_chip_info2.lvds_chip_name = INTEGRATED_LVDS;
+        DEBUG_MSG(KERN_INFO "Support two single channel LVDS! (Internal LVDS + Internal LVDS)\n");
+    }
+    else if (display_hardware_layout != HW_LAYOUT_DVI_ONLY)
+    {
+        /* If we have found external LVDS, just use it, otherwise, we will use internal LVDS as default. */
+        if (!chip_info.lvds_chip_info.lvds_chip_name)
+        {
+            chip_info.lvds_chip_info.lvds_chip_name = INTEGRATED_LVDS;
+            DEBUG_MSG(KERN_INFO "Found Integrated LVDS!\n");
+        }
+    }
+    else
+    {
+        chip_info.lvds_chip_info.lvds_chip_name = NON_LVDS_TRANSMITTER;
+        DEBUG_MSG(KERN_INFO "Do not support LVDS!\n");
+        return FALSE;
+    }
+
+    return TRUE;
+}
+
+int lvds_trasmitter_identify(void)
+{
+    u8 tmp;
+    tmp = chip_info.tv_chip_info.tv_chip_on_slot;
+    chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AMR;
+    if(lvds_identify_vt1636())
+    {
+        chip_info.lvds_chip_info.i2c_port = TVI2CPORTINDEX;
+        DEBUG_MSG(KERN_INFO "Found VIA VT1636 LVDS on port i2c 0x31 \n");
+    }else
+    {
+        chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AGP;
+        if(lvds_identify_vt1636())
+        {
+            chip_info.lvds_chip_info.i2c_port = TVGPIOPORTINDEX;
+            DEBUG_MSG(KERN_INFO "Found VIA VT1636 LVDS on port gpio 0x2c \n");
+        }
+    }
+    chip_info.tv_chip_info.tv_chip_on_slot = tmp;
+    
+    if (chip_info.gfx_chip_name == UNICHROME_CX700)
+    {
+        lvds_identify_integratedlvds();
+    }
+
+     if(chip_info.lvds_chip_info.lvds_chip_name)
+    {
+        return TRUE;
+    }
+    /* Check for VT1631: */
+    chip_info.lvds_chip_info.lvds_chip_name = VT1631_LVDS;
+    chip_info.lvds_chip_info.lvds_chip_slave_addr = VT1631_LVDS_I2C_ADDR;
+
+    if (check_lvds_chip(VT1631_DEVICE_ID_REG, VT1631_DEVICE_ID)!= FAIL)
+    {
+        DEBUG_MSG(KERN_INFO "\n VT1631 LVDS ! \n");
+        DEBUG_MSG(KERN_INFO "\n %2d", chip_info.lvds_chip_info.lvds_chip_name);
+        DEBUG_MSG(KERN_INFO "\n %2d", chip_info.lvds_chip_info.lvds_chip_name);
+        return(OK);
+    }
+
+
+    chip_info.lvds_chip_info.lvds_chip_name = NON_LVDS_TRANSMITTER;
+    chip_info.lvds_chip_info.lvds_chip_slave_addr = VT1631_LVDS_I2C_ADDR;
+    return(FAIL);
+}
+
+int fp_id_to_vindex(int panel_id)
+{
+    DEBUG_MSG(KERN_INFO "fp_get_panel_id()\n");
+  
+    if(panel_id > 0x13)
+         lcd_panel_id = panel_id= read_reg(VIACR, CR3F) & 0x0F;
+  
+    switch(panel_id) {
+        case 0x0:
+            lvds_setting_info.lcd_panel_hres = 640;
+            lvds_setting_info.lcd_panel_vres = 480;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID0_640X480;
+            lvds_setting_info.LCDDualEdge = 0;
+            lvds_setting_info.LCDDithering = 1;
+            return(VIA_RES_640X480);
+            break;
+        case 0x1:
+            lvds_setting_info.lcd_panel_hres = 800;
+            lvds_setting_info.lcd_panel_vres = 600;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID1_800X600;
+            lvds_setting_info.LCDDualEdge = 0;
+            lvds_setting_info.LCDDithering = 1;
+            return(VIA_RES_800X600);
+            break;
+        case 0x2:
+            lvds_setting_info.lcd_panel_hres = 1024;
+            lvds_setting_info.lcd_panel_vres = 768;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID2_1024X768;
+            lvds_setting_info.LCDDualEdge = 0;
+            lvds_setting_info.LCDDithering = 1;
+            return(VIA_RES_1024X768);
+            break;
+        case 0x3:
+            lvds_setting_info.lcd_panel_hres = 1280;
+            lvds_setting_info.lcd_panel_vres = 768;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID3_1280X768;
+            lvds_setting_info.LCDDualEdge = 0;
+            lvds_setting_info.LCDDithering = 1;
+            return(VIA_RES_1280X768);
+            break;
+        case 0x4:
+            lvds_setting_info.lcd_panel_hres = 1280;
+            lvds_setting_info.lcd_panel_vres = 1024;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID4_1280X1024;
+            lvds_setting_info.LCDDualEdge = 1;
+            lvds_setting_info.LCDDithering = 1;
+            return(VIA_RES_1280X1024);
+            break;
+        case 0x5:
+            lvds_setting_info.lcd_panel_hres = 1400;
+            lvds_setting_info.lcd_panel_vres = 1050;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID5_1400X1050;
+            lvds_setting_info.LCDDualEdge = 1;
+            lvds_setting_info.LCDDithering = 1;
+            return(VIA_RES_1400X1050);
+            break;
+        case 0x6:
+            lvds_setting_info.lcd_panel_hres = 1600;
+            lvds_setting_info.lcd_panel_vres = 1200;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID6_1600X1200;
+            lvds_setting_info.LCDDualEdge = 1;
+            lvds_setting_info.LCDDithering = 1;
+            return(VIA_RES_1600X1200);
+            break;
+        case 0x9:
+            lvds_setting_info.lcd_panel_hres = 1024;
+            lvds_setting_info.lcd_panel_vres = 768;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID2_1024X768;
+            lvds_setting_info.LCDDualEdge = 1;
+            lvds_setting_info.LCDDithering = 1;
+            return(VIA_RES_1024X768);
+            break;
+        case 0xA:
+            lvds_setting_info.lcd_panel_hres = 1024;
+            lvds_setting_info.lcd_panel_vres = 768;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID2_1024X768;
+            lvds_setting_info.LCDDualEdge = 0;
+            lvds_setting_info.LCDDithering = 0;
+            return(VIA_RES_1024X768);
+            break;
+        case 0xB:
+            lvds_setting_info.lcd_panel_hres = 1024;
+            lvds_setting_info.lcd_panel_vres = 768;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID2_1024X768;
+            lvds_setting_info.LCDDualEdge = 1;
+            lvds_setting_info.LCDDithering = 0;
+            return(VIA_RES_1024X768);
+            break;
+        case 0xC:
+            lvds_setting_info.lcd_panel_hres = 1280;
+            lvds_setting_info.lcd_panel_vres = 768;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID3_1280X768;
+            lvds_setting_info.LCDDualEdge = 0;
+            lvds_setting_info.LCDDithering = 0;
+            return(VIA_RES_1280X768);
+            break;
+        case 0xD:
+            lvds_setting_info.lcd_panel_hres = 1280;
+            lvds_setting_info.lcd_panel_vres = 1024;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID4_1280X1024;
+            lvds_setting_info.LCDDualEdge = 1;
+            lvds_setting_info.LCDDithering = 0;
+            return(VIA_RES_1280X1024);
+            break;
+        case 0xE:
+            lvds_setting_info.lcd_panel_hres = 1400;
+            lvds_setting_info.lcd_panel_vres = 1050;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID5_1400X1050;
+            lvds_setting_info.LCDDualEdge = 1;
+            lvds_setting_info.LCDDithering = 0;
+            return(VIA_RES_1400X1050);
+            break;
+        case 0xF:
+            lvds_setting_info.lcd_panel_hres = 1600;
+            lvds_setting_info.lcd_panel_vres = 1200;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID6_1600X1200;
+            lvds_setting_info.LCDDualEdge = 1;
+            lvds_setting_info.LCDDithering = 0;
+            return(VIA_RES_1600X1200);
+            break;
+        case 0x10:
+            lvds_setting_info.lcd_panel_hres = 1366;
+            lvds_setting_info.lcd_panel_vres = 768;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID7_1366X768;
+            lvds_setting_info.LCDDualEdge = 0;
+            lvds_setting_info.LCDDithering = 0;
+            return(VIA_RES_1368X768);
+            break;
+        case 0x11:         
+             lvds_setting_info.lcd_panel_hres = 1024;
+             lvds_setting_info.lcd_panel_vres = 600;
+             lvds_setting_info.lcd_panel_id = LCD_PANEL_ID8_1024X600;
+             lvds_setting_info.LCDDualEdge = 0;
+             lvds_setting_info.LCDDithering = 1;   
+             return(VIA_RES_1024X600);
+             break;
+     case 0x12:   
+            lvds_setting_info.lcd_panel_hres = 1280;
+            lvds_setting_info.lcd_panel_vres = 768;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID3_1280X768;
+            lvds_setting_info.LCDDualEdge = 1;
+            lvds_setting_info.LCDDithering = 1;
+            return(VIA_RES_1280X768);
+            break;
+        case 0x13:   
+            lvds_setting_info.lcd_panel_hres = 1280;
+            lvds_setting_info.lcd_panel_vres = 800;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID9_1280X800;
+            lvds_setting_info.LCDDualEdge = 0;
+            lvds_setting_info.LCDDithering = 1;
+            return(VIA_RES_1280X800);
+            break;
+        default:
+            lvds_setting_info.lcd_panel_hres = 800;
+            lvds_setting_info.lcd_panel_vres = 600;
+            lvds_setting_info.lcd_panel_id = LCD_PANEL_ID1_800X600;
+            lvds_setting_info.LCDDualEdge = 0;
+            lvds_setting_info.LCDDithering = 1;
+            return(VIA_RES_800X600);
+    }
+}
+
+void lvds_register_write(int index, u8 data)
+{
+    u8  tmp;
+
+    tmp = chip_info.tv_chip_info.tv_chip_on_slot;
+
+    chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AGP;
+
+    i2cWriteByte(chip_info.lvds_chip_info.lvds_chip_slave_addr, index, data);
+
+    chip_info.tv_chip_info.tv_chip_on_slot = tmp;
+
+}
+
+int lvds_register_read(int index)
+{
+    u8 data;
+    int status;
+    u8  tmp;
+
+    tmp = chip_info.tv_chip_info.tv_chip_on_slot;
+
+    chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AGP;
+    status = i2cReadByte((u8)chip_info.lvds_chip_info.lvds_chip_slave_addr, (u8)index, &data);
+
+    chip_info.tv_chip_info.tv_chip_on_slot = tmp;
+    return(data);
+}
+
+void load_lcd_scaling(int set_hres, int set_vres, int panel_hres, int panel_vres)
+{
+    int reg_value = 0;
+    int load_reg_num;
+    struct io_register *reg = NULL;
+
+    DEBUG_MSG(KERN_INFO "load_lcd_scaling()!!\n");
+
+    /* LCD Scaling Enable */
+    write_reg_mask(CR79, VIACR, 0x07, BIT0+BIT1+BIT2);
+
+    /* Modified form X driver code.P4M900_A0's scaling register has a 
+       little problem on reading it. So we use another method to access it. */
+    if (UNICHROME_P4M900 == chip_info.gfx_chip_name)
+    {
+        load_scaling_factor_for_p4m900(set_hres, set_vres, panel_hres, panel_vres);
+        return;
+    }
+
+
+    /* Check if expansion for horizontal */
+    if(set_hres != panel_hres)
+    {
+        /* Load Horizontal Scaling Factor */
+        switch(chip_info.gfx_chip_name)
+        {
+            case UNICHROME_CLE266:
+            case UNICHROME_K400:
+                reg_value = CLE266_LCD_HOR_SCF_FORMULA(set_hres, panel_hres);
+                load_reg_num = lcd_scaling_factor_CLE.lcd_hor_scaling_factor.reg_num;
+                reg = lcd_scaling_factor_CLE.lcd_hor_scaling_factor.reg;
+                load_reg(reg_value, load_reg_num, reg, VIACR);         
+                break;
+            case UNICHROME_K800:
+            case UNICHROME_P880:
+            case UNICHROME_CN900:            
+            case UNICHROME_CX700:
+            case UNICHROME_K8M890:
+            case UNICHROME_P4M890:
+                reg_value = K800_LCD_HOR_SCF_FORMULA(set_hres, panel_hres);
+                write_reg_mask(CRA2, VIACR, 0xC0, BIT7+BIT6);       /* Horizontal scaling enabled */
+                load_reg_num = lcd_scaling_factor.lcd_hor_scaling_factor.reg_num;
+                reg = lcd_scaling_factor.lcd_hor_scaling_factor.reg;
+                load_reg(reg_value, load_reg_num, reg, VIACR);
+                break;
+        }
+
+        DEBUG_MSG(KERN_INFO "Horizontal Scaling value = %d", reg_value);
+    }
+    else
+    {
+        write_reg_mask(CRA2, VIACR, 0x00, BIT7);      /* Horizontal scaling disabled */
+    }
+
+    /* Check if expansion for vertical */
+    if(set_vres != panel_vres)
+    {
+        /* Load Vertical Scaling Factor */
+        switch(chip_info.gfx_chip_name)
+        {
+            case UNICHROME_CLE266:
+            case UNICHROME_K400:
+                reg_value = CLE266_LCD_VER_SCF_FORMULA(set_vres, panel_vres);
+                load_reg_num = lcd_scaling_factor_CLE.lcd_ver_scaling_factor.reg_num;
+                reg = lcd_scaling_factor_CLE.lcd_ver_scaling_factor.reg;
+                load_reg(reg_value, load_reg_num, reg, VIACR); 
+                break;
+            case UNICHROME_K800:
+            case UNICHROME_P880:
+            case UNICHROME_CN900:     
+            case UNICHROME_CX700:
+            case UNICHROME_K8M890:
+            case UNICHROME_P4M890:
+                reg_value = K800_LCD_VER_SCF_FORMULA(set_vres, panel_vres);
+                write_reg_mask(CRA2, VIACR, 0x08, BIT3);       /* Vertical scaling enabled */
+                load_reg_num = lcd_scaling_factor.lcd_ver_scaling_factor.reg_num;
+                reg = lcd_scaling_factor.lcd_ver_scaling_factor.reg;
+                load_reg(reg_value, load_reg_num, reg, VIACR);
+                break;
+        }
+
+        DEBUG_MSG(KERN_INFO "Vertical Scaling value = %d", reg_value);
+    }
+    else
+    {
+        write_reg_mask(CRA2, VIACR, 0x00, BIT3);      /* Vertical scaling disabled */
+    }
+}
+
+void load_lcd_k400_patch_tbl(int set_hres, int set_vres, int panel_id)
+{
+    int vmode_index;
+    int reg_num=0;
+    struct io_reg *lcd_patch_reg=NULL;
+
+    if(lvds_setting_info.iga_path==IGA2)
+        vmode_index = get_mode_index(set_hres, set_vres,1);
+    else
+        vmode_index = get_mode_index(set_hres, set_vres,0);
+    switch(panel_id) {
+        /* LCD 800x600 */
+        case LCD_PANEL_ID1_800X600:
+            switch(vmode_index) {
+                case VIA_RES_640X400:
+                case VIA_RES_640X480:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_6X4_8X6;
+                    lcd_patch_reg = K400_LCD_RES_6X4_8X6;
+                    break;
+                case VIA_RES_720X480:
+                case VIA_RES_720X576:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_7X4_8X6;
+                    lcd_patch_reg = K400_LCD_RES_7X4_8X6;
+                    break;
+            }
+        break;
+
+        /* LCD 1024x768 */
+        case LCD_PANEL_ID2_1024X768:
+            switch(vmode_index) {
+                case VIA_RES_640X400:
+                case VIA_RES_640X480:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_6X4_10X7;
+                    lcd_patch_reg = K400_LCD_RES_6X4_10X7;
+                    break;
+                case VIA_RES_720X480:
+                case VIA_RES_720X576:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_7X4_10X7;
+                    lcd_patch_reg = K400_LCD_RES_7X4_10X7;
+                    break;
+                case VIA_RES_800X600:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_8X6_10X7;
+                    lcd_patch_reg = K400_LCD_RES_8X6_10X7;
+                    break;
+            }
+        break;
+
+        /* LCD 1280x1024 */
+        case LCD_PANEL_ID4_1280X1024:
+            switch(vmode_index) {
+                case VIA_RES_640X400:
+                case VIA_RES_640X480:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_6X4_12X10;
+                    lcd_patch_reg = K400_LCD_RES_6X4_12X10;
+                    break;
+                case VIA_RES_720X480:
+                case VIA_RES_720X576:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_7X4_12X10;
+                    lcd_patch_reg = K400_LCD_RES_7X4_12X10;
+                    break;
+                case VIA_RES_800X600:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_8X6_12X10;
+                    lcd_patch_reg = K400_LCD_RES_8X6_12X10;
+                    break;
+                case VIA_RES_1024X768:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_10X7_12X10;
+                    lcd_patch_reg = K400_LCD_RES_10X7_12X10;
+                    break;
+
+            }
+        break;
+
+        /* LCD 1400x1050 */
+        case LCD_PANEL_ID5_1400X1050:
+            switch(vmode_index)
+            {
+                case VIA_RES_640X480:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_6X4_14X10;
+                    lcd_patch_reg = K400_LCD_RES_6X4_14X10;
+                    break;
+                case VIA_RES_800X600:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_8X6_14X10;
+                    lcd_patch_reg = K400_LCD_RES_8X6_14X10;
+                    break;
+                case VIA_RES_1024X768:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_10X7_14X10;
+                    lcd_patch_reg = K400_LCD_RES_10X7_14X10;
+                    break;
+                case VIA_RES_1280X768:
+                case VIA_RES_1280X960:
+                case VIA_RES_1280X1024:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_12X10_14X10;
+                    lcd_patch_reg = K400_LCD_RES_12X10_14X10;
+                    break;
+            }
+            break;
+
+        /* LCD 1600x1200 */
+        case LCD_PANEL_ID6_1600X1200:
+            switch(vmode_index) {
+                case VIA_RES_640X400:
+                case VIA_RES_640X480:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_6X4_16X12;
+                    lcd_patch_reg = K400_LCD_RES_6X4_16X12;
+                    break;
+                case VIA_RES_720X480:
+                case VIA_RES_720X576:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_7X4_16X12;
+                    lcd_patch_reg = K400_LCD_RES_7X4_16X12;
+                    break;
+                case VIA_RES_800X600:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_8X6_16X12;
+                    lcd_patch_reg = K400_LCD_RES_8X6_16X12;
+                    break;
+                case VIA_RES_1024X768:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_10X7_16X12;
+                    lcd_patch_reg = K400_LCD_RES_10X7_16X12;
+                    break;
+                case VIA_RES_1280X768:
+                case VIA_RES_1280X960:
+                case VIA_RES_1280X1024:
+                    reg_num = NUM_TOTAL_K400_LCD_RES_12X10_16X12;
+                    lcd_patch_reg = K400_LCD_RES_12X10_16X12;
+                    break;
+            }
+        break;
+
+    }
+    if (reg_num != 0)
+    {
+        /* H.W. Reset : ON */
+        write_reg_mask(CR17, VIACR, 0x00, BIT7);
+
+        write_regx(lcd_patch_reg, reg_num);
+
+        /* H.W. Reset : OFF */
+        write_reg_mask(CR17, VIACR, 0x80, BIT7);
+
+        /* Reset PLL */
+        write_reg_mask(SR40, VIASR, 0x02, BIT1);
+        write_reg_mask(SR40, VIASR, 0x00, BIT1);
+
+        /* Fire! */
+        outb(inb(VIARMisc) | (BIT2+BIT3), VIAWMisc);
+    }
+}
+
+void load_lcd_p880_patch_tbl(int set_hres, int set_vres, int panel_id)
+{
+    int vmode_index;
+    int reg_num=0;
+    struct io_reg *lcd_patch_reg=NULL;
+
+    if(lvds_setting_info.iga_path==IGA2)
+        vmode_index = get_mode_index(set_hres, set_vres,1);
+    else
+        vmode_index = get_mode_index(set_hres, set_vres,0);
+
+    switch(panel_id) {
+        case LCD_PANEL_ID5_1400X1050:
+            switch(vmode_index)
+            {
+                case VIA_RES_640X480:
+                    reg_num = NUM_TOTAL_P880_LCD_RES_6X4_14X10;
+                    lcd_patch_reg = P880_LCD_RES_6X4_14X10;
+                    break;
+                case VIA_RES_800X600:
+                    reg_num = NUM_TOTAL_P880_LCD_RES_8X6_14X10;
+                    lcd_patch_reg = P880_LCD_RES_8X6_14X10;
+                    break;
+            }
+            break;
+        case LCD_PANEL_ID6_1600X1200:
+            switch(vmode_index) {
+                case VIA_RES_640X400:
+                case VIA_RES_640X480:
+                    reg_num = NUM_TOTAL_P880_LCD_RES_6X4_16X12;
+                    lcd_patch_reg = P880_LCD_RES_6X4_16X12;
+                    break;
+                case VIA_RES_720X480:
+                case VIA_RES_720X576:
+                    reg_num = NUM_TOTAL_P880_LCD_RES_7X4_16X12;
+                    lcd_patch_reg = P880_LCD_RES_7X4_16X12;
+                    break;
+                case VIA_RES_800X600:
+                    reg_num = NUM_TOTAL_P880_LCD_RES_8X6_16X12;
+                    lcd_patch_reg = P880_LCD_RES_8X6_16X12;
+                    break;
+                case VIA_RES_1024X768:
+                    reg_num = NUM_TOTAL_P880_LCD_RES_10X7_16X12;
+                    lcd_patch_reg = P880_LCD_RES_10X7_16X12;
+                    break;
+                case VIA_RES_1280X768:
+                case VIA_RES_1280X960:
+                case VIA_RES_1280X1024:
+                    reg_num = NUM_TOTAL_P880_LCD_RES_12X10_16X12;
+                    lcd_patch_reg = P880_LCD_RES_12X10_16X12;
+                    break;
+            }
+        break;
+
+     }
+    if (reg_num != 0)
+    {
+        /* H.W. Reset : ON */
+        write_reg_mask(CR17, VIACR, 0x00, BIT7);
+
+        write_regx(lcd_patch_reg, reg_num);
+
+        /* H.W. Reset : OFF */
+        write_reg_mask(CR17, VIACR, 0x80, BIT7);
+
+        /* Reset PLL */
+        write_reg_mask(SR40, VIASR, 0x02, BIT1);
+        write_reg_mask(SR40, VIASR, 0x00, BIT1);
+
+        /* Fire! */
+        outb(inb(VIARMisc) | (BIT2+BIT3), VIAWMisc);
+    }
+}
+
+void load_lcd_patch_regs(int set_hres, int set_vres, int panel_id, int set_iga)
+{
+    int vmode_index;
+
+    if(lvds_setting_info.iga_path==IGA2)
+        vmode_index = get_mode_index(set_hres, set_vres,1);
+    else
+        vmode_index = get_mode_index(set_hres, set_vres,0);
+
+    unlock_crt();
+
+    /* Patch for simultaneous & Expansion */
+    if((set_iga == IGA1_IGA2) && (lvds_setting_info.display_method == LCD_EXPANDSION))
+    {
+        switch(chip_info.gfx_chip_name) {
+            case UNICHROME_CLE266:
+            case UNICHROME_K400:
+                load_lcd_k400_patch_tbl(set_hres, set_vres, panel_id);
+                break;
+            case UNICHROME_K800:
+                break;
+            case UNICHROME_P880:
+            case UNICHROME_CN900:    
+            case UNICHROME_CX700:
+                load_lcd_p880_patch_tbl(set_hres, set_vres, panel_id);
+        }
+    }
+
+    lock_crt();
+}
+
+void VIAPitchAlignmentPatchLCD(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    unsigned char     cr13, cr35, cr65, cr66, cr67;
+    unsigned long     dwScreenPitch= 0;
+    unsigned long     dwPitch;
+
+    dwPitch = plvds_setting_info->h_active * (plvds_setting_info->bpp >> 3);
+    if (dwPitch & 0x1F) 
+   {   /* Is 32 Byte Alignment ? */
+        dwScreenPitch = ((dwPitch + 31) & ~31) >> 3;
+        if ( plvds_setting_info->iga_path==IGA2)
+        {
+            if(plvds_setting_info->bpp>8) {     
+            /* When 8bpp 720xX,848xX will not do 32Byte alignment. */
+                cr66 = (unsigned char)(dwScreenPitch & 0xFF);
+                write_reg(CR66, VIACR, cr66);
+                cr67 = read_reg(VIACR, CR67) & 0xFC;
+                cr67 |= (unsigned char)((dwScreenPitch & 0x300) >> 8);
+                write_reg(CR67, VIACR, cr67);
+            }
+
+            /* Fetch Count */
+            cr67 = read_reg(VIACR, CR67) & 0xF3;
+            cr67 |= (unsigned char)((dwScreenPitch & 0x600) >> 7);
+            write_reg(CR67, VIACR, cr67);
+            cr65 = (unsigned char)((dwScreenPitch >> 1) & 0xFF);
+            cr65 += 2;
+            write_reg(CR65, VIACR, cr65);
+        }
+        else
+        {
+            if(plvds_setting_info->bpp>8) {     
+            /* When 8bpp 720xX,848xX will not do 32Byte alignment. */
+                cr13 = (unsigned char)(dwScreenPitch & 0xFF);
+                write_reg(CR13, VIACR, cr13);
+                cr35 = read_reg(VIACR, CR35) & 0x1F;
+                cr35 |= (unsigned char)((dwScreenPitch & 0x700) >> 3);
+                write_reg(CR35, VIACR, cr35);
+            }
+        }
+    }
+}
+void lcd_patch_skew_dvp0(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    if(VT1636_LVDS == plvds_chip_info->lvds_chip_name)
+    {
+        switch(chip_info.gfx_chip_name)
+        {
+            case UNICHROME_P4M900:
+                vt1636_patch_skew_on_vt3364(plvds_setting_info, plvds_chip_info);
+                break;
+            case UNICHROME_P4M890:
+                vt1636_patch_skew_on_vt3327(plvds_setting_info, plvds_chip_info);
+                break;
+        }
+    }
+}
+void lcd_patch_skew_dvp1(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    if(VT1636_LVDS == plvds_chip_info->lvds_chip_name)
+    {
+        switch(chip_info.gfx_chip_name)
+        {
+            case UNICHROME_CX700:
+                vt1636_patch_skew_on_vt3324(plvds_setting_info, plvds_chip_info);
+                break;
+        }
+    }
+}
+void lcd_patch_skew(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    DEBUG_MSG(KERN_INFO "lcd_patch_skew\n");
+    switch (plvds_chip_info->output_interface)
+    {
+        case INTERFACE_DVP0:
+            lcd_patch_skew_dvp0(plvds_setting_info, plvds_chip_info);
+            break;
+        case INTERFACE_DVP1:
+            lcd_patch_skew_dvp1(plvds_setting_info, plvds_chip_info);
+            break;
+        case INTERFACE_DFP_LOW:
+            if (UNICHROME_P4M900 == chip_info.gfx_chip_name)
+            {
+                write_reg_mask(CR99, VIACR, 0x08, BIT0+BIT1+BIT2+BIT3);
+            }
+            break;
+    }
+}
+
+/* LCD Set Mode */
+void lcd_set_mode(struct crt_mode_table *mode_crt_table, struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    int video_index = plvds_setting_info->lcd_panel_size;
+    int set_iga = plvds_setting_info->iga_path;
+    int mode_bpp = plvds_setting_info->bpp;
+    int load_reg_num=0;
+    int reg_value=0;
+    int set_hres, set_vres;
+    int panel_hres, panel_vres;
+    u32 pll_D_N;
+    int offset;
+    struct io_register      *reg = NULL;
+    struct display_timing   mode_crt_reg, panel_crt_reg;
+    struct crt_mode_table   *panel_crt_table;
+    struct VideoModeTable   *vmode_tbl;
+
+    DEBUG_MSG(KERN_INFO "LCD_Set_Mode!, expansion:%d\n", plvds_setting_info->display_method);
+
+    mode_crt_reg = mode_crt_table->crtc;                        /* Get mode table */
+
+    vmode_tbl = &CLE266Modes[SearchModeSetting(video_index)];   /* Get panel table */
+    panel_crt_table = vmode_tbl->crtc;
+    panel_crt_reg = panel_crt_table->crtc;
+
+    set_hres = plvds_setting_info->h_active;
+    set_vres = plvds_setting_info->v_active;
+    panel_hres = plvds_setting_info->lcd_panel_hres;
+    panel_vres = plvds_setting_info->lcd_panel_vres;
+    if(VT1636_LVDS == plvds_chip_info->lvds_chip_name)
+    {
+        init_lvds_vt1636(plvds_setting_info, plvds_chip_info);
+    }
+    plvds_setting_info->vclk = panel_crt_table->clk;
+    if (set_iga == IGA1)
+    {
+        /* IGA1 doesn't have LCD scaling, so set it as centering. */
+        load_crtc_timing(lcd_centering_timging(mode_crt_reg, panel_crt_reg), IGA1);
+    }
+    else
+    {
+        /* Expansion */
+        if ((plvds_setting_info->display_method == LCD_EXPANDSION) &
+            ((set_hres != panel_hres ) || (set_vres != panel_vres)))
+        {
+            /* expansion timing IGA2 always loaded panel set timing */
+            load_crtc_timing(panel_crt_reg, IGA2);
+            load_lcd_scaling(set_hres, set_vres, panel_hres, panel_vres);
+        }
+        else /* Centering */
+        {
+            /* centering timing IGA2 always loaded panel and mode releative timing */
+            load_crtc_timing(lcd_centering_timging(mode_crt_reg, panel_crt_reg), IGA2);
+            write_reg_mask(CR79, VIACR, 0x00, BIT0+BIT1+BIT2);          /* LCD scaling disabled */
+        }
+    }
+
+    if (set_iga == IGA1_IGA2)
+    {
+        load_crtc_shadow_timing(mode_crt_reg, panel_crt_reg);       /* Fill shadow registers */
+
+        switch(plvds_setting_info->lcd_panel_id)
+        {
+            case LCD_PANEL_ID0_640X480:
+                offset = 80;
+                break;
+            case LCD_PANEL_ID1_800X600:
+                offset = 110;
+                break;
+            case LCD_PANEL_ID2_1024X768:
+                offset = 150;
+                break;
+            case LCD_PANEL_ID3_1280X768:
+            case LCD_PANEL_ID4_1280X1024:
+            case LCD_PANEL_ID5_1400X1050:
+                offset = 190;
+                break;
+            case LCD_PANEL_ID6_1600X1200:
+                offset = 250;
+                break;
+            case LCD_PANEL_ID7_1366X768:
+                offset = 212;
+                break;
+            default:
+                offset = 140;
+                break;
+        }
+
+        /* Offset for simultaneous */
+        reg_value = offset;
+        load_reg_num = offset_reg.iga2_offset_reg.reg_num;
+        reg = offset_reg.iga2_offset_reg.reg;
+        load_reg(reg_value, load_reg_num, reg, VIACR);
+
+        load_fetch_count_reg(set_hres, 4, IGA2);                        /* Fetch count for simultaneous*/
+    }
+    else  /* SAMM */
+    {
+        load_offset_reg(set_hres, mode_bpp/8, set_iga);                    /* Offset for IGA2 only */
+        load_fetch_count_reg(set_hres, mode_bpp/8, set_iga);               /* Fetch count for IGA2 only */
+
+        if((chip_info.gfx_chip_name != UNICHROME_CLE266) && (chip_info.gfx_chip_name != UNICHROME_K400))
+            load_FIFO_reg(set_iga, set_hres, set_vres);
+
+        set_color_depth(mode_bpp/8, set_iga);        
+    }
+
+    fill_lcd_format();
+
+    pll_D_N = get_clk_value(panel_crt_table[0].clk);
+    DEBUG_MSG(KERN_INFO "PLL=0x%x", pll_D_N);
+    SetVCLK(pll_D_N, set_iga);
+
+    set_output_path(DEVICE_LCD, set_iga, plvds_chip_info->output_interface);
+    lcd_patch_skew(plvds_setting_info, plvds_chip_info);
+
+    /* If K8M800, enable LCD Prefetch Mode. */
+    if((chip_info.gfx_chip_name == UNICHROME_K800) || (UNICHROME_K8M890 == chip_info.gfx_chip_name))
+    {
+        write_reg_mask(CR6A, VIACR, 0x01, BIT0);
+    }
+
+    load_lcd_patch_regs(set_hres, set_vres, plvds_setting_info->lcd_panel_id, set_iga);
+
+    /* Patch for non 32bit alignment mode */
+    VIAPitchAlignmentPatchLCD(plvds_setting_info, plvds_chip_info);
+}
+
+void integrated_lvds_disable(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    bool turn_off_first_powersequence = FALSE;
+    bool turn_off_second_powersequence = FALSE;
+   if(INTERFACE_LVDS0LVDS1 == plvds_chip_info->output_interface)
+    {
+        turn_off_first_powersequence = TRUE;
+    }
+    if(INTERFACE_LVDS0 == plvds_chip_info->output_interface)
+    {
+        turn_off_first_powersequence = TRUE;
+    }
+    if(INTERFACE_LVDS1 == plvds_chip_info->output_interface)
+    {
+        turn_off_second_powersequence = TRUE;
+    }
+    if (turn_off_second_powersequence)
+    {
+        /* Use second power sequence control: */
+
+        /* Turn off power sequence. */
+        write_reg_mask(CRD4, VIACR, 0, BIT1);
+
+        /* Turn off back light. */
+        write_reg_mask(CRD3, VIACR, 0xC0, BIT6+BIT7);
+    }
+    if(turn_off_first_powersequence)
+    {
+        /* Use first power sequence control: */
+
+        /* Turn off power sequence. */
+        write_reg_mask(CR6A, VIACR, 0, BIT3);
+
+        /* Turn off back light. */
+        write_reg_mask(CR91, VIACR, 0xC0, BIT6+BIT7);
+    }
+
+    /* Turn DFP High/Low Pad off. */
+    write_reg_mask(SR2A, VIASR, 0, BIT0+BIT1+BIT2+BIT3);
+
+    /* Power off LVDS channel. */
+    switch (plvds_chip_info->output_interface)
+    {
+        case INTERFACE_LVDS0:
+        {
+            write_reg_mask(CRD2, VIACR, 0x80, BIT7);
+            break;
+        }
+
+        case INTERFACE_LVDS1:
+        {
+            write_reg_mask(CRD2, VIACR, 0x40, BIT6);
+            break;
+        }
+
+        case INTERFACE_LVDS0LVDS1:
+        {
+            write_reg_mask(CRD2, VIACR, 0xC0, BIT6+BIT7);
+            break;
+        }
+    }
+}
+
+void integrated_lvds_enable(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info)
+{
+    bool turn_on_first_powersequence = FALSE;
+    bool turn_on_second_powersequence = FALSE;
+    DEBUG_MSG(KERN_INFO "integrated_lvds_enable, out_interface:%d\n", plvds_chip_info->output_interface);
+    /* Panel mode for VT3324 integrated LVDS. */
+    if (plvds_setting_info->lcd_mode == LCD_SPWG)
+    {            
+     write_reg_mask(CRD2, VIACR, 0x00, BIT0+BIT1);
+    }
+    else /* lcd_mode == OPEN LDI */
+    {
+     write_reg_mask(CRD2, VIACR, 0x03, BIT0+BIT1);
+    }
+    if(INTERFACE_LVDS0LVDS1 == plvds_chip_info->output_interface)
+    {
+        turn_on_first_powersequence = TRUE;
+    }
+    if(INTERFACE_LVDS0 == plvds_chip_info->output_interface)
+    {
+        turn_on_first_powersequence = TRUE;
+    }
+    if(INTERFACE_LVDS1 == plvds_chip_info->output_interface)
+    {
+        turn_on_second_powersequence = TRUE;
+    }
+    
+    if (turn_on_second_powersequence)
+    {
+        /* Use second power sequence control: */
+        
+        /* Use hardware control power sequence. */
+        write_reg_mask(CRD3, VIACR, 0, BIT0);
+
+        /* Turn on back light. */
+        write_reg_mask(CRD3, VIACR, 0, BIT6+BIT7);
+
+        /* Turn on hardware power sequence. */
+        write_reg_mask(CRD4, VIACR, 0x02, BIT1);
+    }
+    if(turn_on_first_powersequence)
+    {
+        /* Use first power sequence control: */
+        
+        /* Use hardware control power sequence. */
+        write_reg_mask(CR91, VIACR, 0, BIT0);
+
+        /* Turn on back light. */
+        write_reg_mask(CR91, VIACR, 0, BIT6+BIT7);
+
+        /* Turn on hardware power sequence. */
+        write_reg_mask(CR6A, VIACR, 0x08, BIT3);
+    }
+    
+    /* Turn DFP High/Low pad on. */
+    write_reg_mask(SR2A, VIASR, 0x0F, BIT0+BIT1+BIT2+BIT3);
+
+    /* Power on LVDS channel. */
+    switch (plvds_chip_info->output_interface)
+    {
+        case INTERFACE_LVDS0:
+        {
+            write_reg_mask(CRD2, VIACR, 0, BIT7);
+            break;
+        }
+
+        case INTERFACE_LVDS1:
+        {
+            write_reg_mask(CRD2, VIACR, 0, BIT6);
+            break;
+        }
+
+        case INTERFACE_LVDS0LVDS1:
+        {
+            write_reg_mask(CRD2, VIACR, 0, BIT6+BIT7);
+            break;
+        }
+    }
+}
+
+void lcd_disable(void)
+{
+
+    if (chip_info.gfx_chip_name == UNICHROME_CLE266)
+    {
+        LCDPowerSequenceOff();
+        write_reg_mask(SR1E, VIASR, 0x00, 0x30);        /* DI1 pad off             */
+    }
+    else if(chip_info.gfx_chip_name == UNICHROME_CX700)
+    {
+        if (LCD2_ON && (INTEGRATED_LVDS == chip_info.lvds_chip_info2.lvds_chip_name))
+        {
+            integrated_lvds_disable(&lvds_setting_info2, &chip_info.lvds_chip_info2);
+        }
+        if (INTEGRATED_LVDS == chip_info.lvds_chip_info.lvds_chip_name)
+        {
+            integrated_lvds_disable(&lvds_setting_info, &chip_info.lvds_chip_info);
+        }
+        if (VT1636_LVDS == chip_info.lvds_chip_info.lvds_chip_name)
+        {
+            disable_lvds_vt1636(&lvds_setting_info, &chip_info.lvds_chip_info);
+        }
+    }
+    else if(VT1636_LVDS == chip_info.lvds_chip_info.lvds_chip_name)
+    {
+        disable_lvds_vt1636(&lvds_setting_info, &chip_info.lvds_chip_info);
+    }
+    else
+    {
+        write_reg_mask(SR2A, VIASR, 0x00, 0x0F);        /* DFP-HL pad off          */
+        write_reg_mask(SR3D, VIASR, 0x00, 0x20);        /* Backlight off           */
+        write_reg_mask(CR91, VIACR, 0x80, 0x80);        /* 24 bit DI data paht off */
+        write_reg_mask(CR6B, VIACR, 0x00, 0x08);        /* Simultaneout disabled   */
+    }
+
+    write_reg_mask(CR79, VIACR, 0x00, 0x01);            /* Disable expansion bit   */
+    write_reg_mask(SR16, VIASR, 0x00, 0x40);            /* CRT path set to IGA1    */
+    write_reg_mask(CR6B, VIACR, 0x00, 0x08);            /* Simultaneout disabled   */
+    write_reg_mask(CR6A, VIACR, 0x00, 0x80);            /* IGA2 path disabled      */
+
+}
+
+void lcd_enable(void)
+{
+    if (chip_info.gfx_chip_name == UNICHROME_CLE266)
+    {
+        write_reg_mask(SR1E, VIASR, 0x30, 0x30);        /* DI1 pad on              */
+        LCDPowerSequenceOn();
+    }
+    else if(chip_info.gfx_chip_name == UNICHROME_CX700)
+    {
+        if (LCD2_ON && (INTEGRATED_LVDS == chip_info.lvds_chip_info2.lvds_chip_name))
+        {
+            integrated_lvds_enable(&lvds_setting_info2, &chip_info.lvds_chip_info2);
+        }
+        if (INTEGRATED_LVDS == chip_info.lvds_chip_info.lvds_chip_name)
+        {
+            integrated_lvds_enable(&lvds_setting_info, &chip_info.lvds_chip_info);
+        }
+        if (VT1636_LVDS == chip_info.lvds_chip_info.lvds_chip_name)
+        {
+            enable_lvds_vt1636(&lvds_setting_info, &chip_info.lvds_chip_info);
+        }
+    }
+    else if(VT1636_LVDS == chip_info.lvds_chip_info.lvds_chip_name)
+    {
+        enable_lvds_vt1636(&lvds_setting_info, &chip_info.lvds_chip_info);
+    }
+    else
+    {
+        write_reg_mask(SR2A, VIASR, 0x0F, 0x0F);        /* DFP-HL pad on           */
+        write_reg_mask(SR3D, VIASR, 0x20, 0x20);        /* Backlight on            */
+        write_reg_mask(CR91, VIACR, 0x00, 0x80);        /* 24 bit DI data paht on  */
+        
+        /* Set data source selection bit by iga path */
+        if (lvds_setting_info.iga_path == IGA1)
+        {
+            write_reg_mask(CR97, VIACR, 0x00, 0x10);    /* DFP-H set to IGA1       */
+            write_reg_mask(CR99, VIACR, 0x00, 0x10);    /* DFP-L set to IGA1       */
+        }
+        else
+        {
+            write_reg_mask(CR97, VIACR, 0x10, 0x10);    /* DFP-H set to IGA2       */
+            write_reg_mask(CR99, VIACR, 0x10, 0x10);    /* DFP-L set to IGA2       */
+        }
+        
+        write_reg_mask(CR6A, VIACR, 0x48, 0x48);        /* LCD enabled             */
+    }
+
+    if ((lvds_setting_info.iga_path == IGA1)||(lvds_setting_info.iga_path == IGA1_IGA2))
+    {
+        write_reg_mask(SR16, VIASR, 0x40, 0x40);        /* CRT path set to IGA2    */
+        write_reg_mask(CR6A, VIACR, 0x00, 0x80);        /* IGA2 path disabled      */
+    }
+    else    /* IGA2 */
+    {
+        write_reg_mask(CR6A, VIACR, 0x80, 0x80);        /* IGA2 path enabled       */
+    }
+
+}
+
+void LCDPowerSequenceOff(void)
+{
+    int  i, mask, data;
+
+    /* Software control power sequence */
+    write_reg_mask(CR91, VIACR, 0x11, 0x11);
+
+    for (i = 0; i < 3; i++)
+    {
+        mask = PowerSequenceOff[0][i];
+        data = PowerSequenceOff[1][i] & mask;
+        write_reg_mask(CR91, VIACR, (u8)data, (u8)mask);
+        delays(PowerSequenceOff[2][i]);
+    }
+
+    /* Disable LCD */
+    write_reg_mask(CR6A, VIACR, 0x00, 0x08);
+}
+
+void LCDPowerSequenceOn(void)
+{
+    int  i, mask, data;
+
+    /* Software control power sequence */
+    write_reg_mask(CR91, VIACR, 0x11, 0x11);
+
+    /* Enable LCD */
+    write_reg_mask(CR6A, VIACR, 0x08, 0x08);
+
+    for (i = 0; i < 3; i++)
+    {
+         mask = PowerSequenceOn[0][i];
+         data = PowerSequenceOn[1][i] & mask;
+         write_reg_mask(CR91, VIACR, (u8)data, (u8)mask);
+         delays(PowerSequenceOn[2][i]);
+     }
+
+     delays(1);
+}
+
+void fill_lcd_format(void)
+{
+    u8  bdithering = 0, bdual = 0;
+
+    if(lvds_setting_info.LCDDualEdge)
+    {
+        bdual = BIT4;
+    }
+    if(lvds_setting_info.LCDDithering)
+    {
+        bdithering = BIT0;
+    }
+
+    write_reg_mask(CR88, VIACR, (bdithering | bdual), BIT4+BIT0);   /* Dual & Dithering */
+}
+
+void check_diport_of_integrated_lvds(struct lvds_chip_information *plvds_chip_info, struct lvds_setting_information* plvds_setting_info)
+{
+    /* Determine LCD DI Port by hardware layout. */
+    switch (display_hardware_layout)
+    {
+        case HW_LAYOUT_LCD_ONLY:
+        {
+            if (plvds_setting_info->LCDDualEdge)
+            {
+                plvds_chip_info->output_interface = INTERFACE_LVDS0LVDS1;
+            }
+            else
+            {
+                plvds_chip_info->output_interface = INTERFACE_LVDS0;
+            }
+            
+            break;
+        }
+
+        case HW_LAYOUT_DVI_ONLY:
+        {
+            plvds_chip_info->output_interface = INTERFACE_NONE;            
+            break;
+        }
+
+        case HW_LAYOUT_LCD1_LCD2:
+        case HW_LAYOUT_LCD_EXTERNAL_LCD2:
+        {
+            plvds_chip_info->output_interface = INTERFACE_LVDS0LVDS1;            
+            break;
+        }
+
+        case HW_LAYOUT_LCD_DVI:
+        {
+            plvds_chip_info->output_interface = INTERFACE_LVDS1;
+            break;
+        }
+
+        default:
+        {
+            plvds_chip_info->output_interface = INTERFACE_LVDS1;
+            break;
+        }
+    }
+
+    DEBUG_MSG(KERN_INFO "Display Hardware Layout: 0x%x, LCD DI Port: 0x%x\n", display_hardware_layout, plvds_chip_info->output_interface);
+}
+
+void init_lvds_output_interface(struct lvds_chip_information *plvds_chip_info, struct lvds_setting_information* plvds_setting_info)
+{
+    if(INTERFACE_NONE != plvds_chip_info->output_interface)
+    {
+        /* Do nothing, lcd port is specified by module parameter */
+        return;
+    }
+    switch(plvds_chip_info->lvds_chip_name)
+    {
+
+        case  VT1636_LVDS:
+            switch(chip_info.gfx_chip_name)
+            {
+                case UNICHROME_CX700:
+                    plvds_chip_info->output_interface = INTERFACE_DVP1;
+                    break;
+                case UNICHROME_CN900:
+                    plvds_chip_info->output_interface = INTERFACE_DFP_LOW;
+                    break;
+                default:
+                    plvds_chip_info->output_interface = INTERFACE_DVP0;
+                    break;
+            }
+            break;
+            
+        /* Add for VT3324 integrated LVDS. */
+        case INTEGRATED_LVDS:
+            check_diport_of_integrated_lvds(plvds_chip_info, plvds_setting_info);
+            break;
+            
+        default:
+            switch(chip_info.gfx_chip_name)
+            {
+                /* Modified from X driver. For the case VT1637 (PCIE LVDS Transmitter) 
+                   on VT3336/VT3327, we should use DFP Low to enable LCD. 
+                   FixMe!! We should find a better method to do this. */
+                case UNICHROME_K8M890:
+                case UNICHROME_P4M900:
+                case UNICHROME_P4M890:
+                    plvds_chip_info->output_interface = INTERFACE_DFP_LOW;
+                    break;
+                default:
+                    plvds_chip_info->output_interface = INTERFACE_DFP;
+                    break;
+            }
+            break;
+    }
+}
+
+struct display_timing lcd_centering_timging(struct display_timing mode_crt_reg, struct display_timing panel_crt_reg)
+{
+    struct display_timing crt_reg;
+
+    crt_reg.hor_total = panel_crt_reg.hor_total;
+    crt_reg.hor_addr = mode_crt_reg.hor_addr;
+    crt_reg.hor_blank_start = (panel_crt_reg.hor_addr - mode_crt_reg.hor_addr)/2 + crt_reg.hor_addr;
+    crt_reg.hor_blank_end = panel_crt_reg.hor_blank_end;
+    crt_reg.hor_sync_start = (panel_crt_reg.hor_sync_start - panel_crt_reg.hor_blank_start) + crt_reg.hor_blank_start;
+    crt_reg.hor_sync_end = panel_crt_reg.hor_sync_end;
+
+    crt_reg.ver_total = panel_crt_reg.ver_total;
+    crt_reg.ver_addr = mode_crt_reg.ver_addr;
+    crt_reg.ver_blank_start = (panel_crt_reg.ver_addr - mode_crt_reg.ver_addr)/2 + crt_reg.ver_addr;
+    crt_reg.ver_blank_end = panel_crt_reg.ver_blank_end;
+    crt_reg.ver_sync_start = (panel_crt_reg.ver_sync_start - panel_crt_reg.ver_blank_start) + crt_reg.ver_blank_start;
+    crt_reg.ver_sync_end = panel_crt_reg.ver_sync_end;
+
+    return crt_reg;
+}
+
+void load_crtc_shadow_timing(struct display_timing mode_timing, struct display_timing panel_timing)
+{
+    struct io_register  *reg = NULL;
+    int                 i;
+    int                 load_reg_Num = 0;
+    int                 reg_value = 0;
+
+    if(lvds_setting_info.display_method == LCD_EXPANDSION)      /* Expansion */
+    {
+       for(i=12;i<20;i++)
+       {
+          switch(i)
+          {
+           case H_TOTAL_SHADOW_INDEX:
+                reg_value = IGA2_HOR_TOTAL_SHADOW_FORMULA(panel_timing.hor_total);
+                load_reg_Num = iga2_shadow_crtc_reg.hor_total_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.hor_total_shadow.reg;
+                break;
+           case H_BLANK_END_SHADOW_INDEX:
+                reg_value = IGA2_HOR_BLANK_END_SHADOW_FORMULA(panel_timing.hor_blank_start, panel_timing.hor_blank_end);
+                load_reg_Num = iga2_shadow_crtc_reg.hor_blank_end_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.hor_blank_end_shadow.reg;
+                break;
+           case V_TOTAL_SHADOW_INDEX:
+                reg_value = IGA2_VER_TOTAL_SHADOW_FORMULA(panel_timing.ver_total);
+                load_reg_Num = iga2_shadow_crtc_reg.ver_total_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.ver_total_shadow.reg;
+                break;
+           case V_ADDR_SHADOW_INDEX:
+                reg_value = IGA2_VER_ADDR_SHADOW_FORMULA(panel_timing.ver_addr);
+                load_reg_Num = iga2_shadow_crtc_reg.ver_addr_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.ver_addr_shadow.reg;
+                break;
+           case V_BLANK_SATRT_SHADOW_INDEX:
+                reg_value = IGA2_VER_BLANK_START_SHADOW_FORMULA(panel_timing.ver_blank_start);
+                load_reg_Num = iga2_shadow_crtc_reg.ver_blank_start_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.ver_blank_start_shadow.reg;
+                break;
+           case V_BLANK_END_SHADOW_INDEX:
+                reg_value = IGA2_VER_BLANK_END_SHADOW_FORMULA(panel_timing.ver_blank_start, panel_timing.ver_blank_end);
+                load_reg_Num = iga2_shadow_crtc_reg.ver_blank_end_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.ver_blank_end_shadow.reg;
+                break;
+           case V_SYNC_SATRT_SHADOW_INDEX:
+                reg_value = IGA2_VER_SYNC_START_SHADOW_FORMULA(panel_timing.ver_sync_start);
+                load_reg_Num = iga2_shadow_crtc_reg.ver_sync_start_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.ver_sync_start_shadow.reg;
+                break;
+           case V_SYNC_END_SHADOW_INDEX:
+                reg_value = IGA2_VER_SYNC_END_SHADOW_FORMULA(panel_timing.ver_sync_start, panel_timing.ver_sync_end);
+                load_reg_Num = iga2_shadow_crtc_reg.ver_sync_end_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.ver_sync_end_shadow.reg;
+                break;
+          }
+          load_reg(reg_value, load_reg_Num, reg, VIACR);
+       }
+    }
+    else    /* Centering */
+    {
+       for(i=12;i<20;i++)
+       {
+          switch(i)
+          {
+           case H_TOTAL_SHADOW_INDEX:
+                reg_value = IGA2_HOR_TOTAL_SHADOW_FORMULA(panel_timing.hor_total);
+                load_reg_Num = iga2_shadow_crtc_reg.hor_total_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.hor_total_shadow.reg;
+                break;
+           case H_BLANK_END_SHADOW_INDEX:
+                reg_value = IGA2_HOR_BLANK_END_SHADOW_FORMULA(panel_timing.hor_blank_start, panel_timing.hor_blank_end);
+                load_reg_Num = iga2_shadow_crtc_reg.hor_blank_end_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.hor_blank_end_shadow.reg;
+                break;
+           case V_TOTAL_SHADOW_INDEX:
+                reg_value = IGA2_VER_TOTAL_SHADOW_FORMULA(panel_timing.ver_total);
+                load_reg_Num = iga2_shadow_crtc_reg.ver_total_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.ver_total_shadow.reg;
+                break;
+           case V_ADDR_SHADOW_INDEX:
+                reg_value = IGA2_VER_ADDR_SHADOW_FORMULA(mode_timing.ver_addr);
+                load_reg_Num = iga2_shadow_crtc_reg.ver_addr_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.ver_addr_shadow.reg;
+                break;
+           case V_BLANK_SATRT_SHADOW_INDEX:
+                reg_value = IGA2_VER_BLANK_START_SHADOW_FORMULA(mode_timing.ver_blank_start);
+                load_reg_Num = iga2_shadow_crtc_reg.ver_blank_start_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.ver_blank_start_shadow.reg;
+                break;
+           case V_BLANK_END_SHADOW_INDEX:
+                reg_value = IGA2_VER_BLANK_END_SHADOW_FORMULA(panel_timing.ver_blank_start, panel_timing.ver_blank_end);
+                load_reg_Num = iga2_shadow_crtc_reg.ver_blank_end_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.ver_blank_end_shadow.reg;
+                break;
+           case V_SYNC_SATRT_SHADOW_INDEX:
+                reg_value = IGA2_VER_SYNC_START_SHADOW_FORMULA((panel_timing.ver_sync_start - panel_timing.ver_blank_start) + (panel_timing.ver_addr - mode_timing.ver_addr)/2 + mode_timing.ver_addr);
+                load_reg_Num = iga2_shadow_crtc_reg.ver_sync_start_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.ver_sync_start_shadow.reg;
+                break;
+           case V_SYNC_END_SHADOW_INDEX:
+                reg_value = IGA2_VER_SYNC_END_SHADOW_FORMULA((panel_timing.ver_sync_start - panel_timing.ver_blank_start) + (panel_timing.ver_addr - mode_timing.ver_addr)/2 + mode_timing.ver_addr, panel_timing.ver_sync_end);
+                load_reg_Num = iga2_shadow_crtc_reg.ver_sync_end_shadow.reg_num;
+                reg = iga2_shadow_crtc_reg.ver_sync_end_shadow.reg;
+                break;
+          }
+          load_reg(reg_value, load_reg_Num, reg, VIACR);
+       }
+    }
+}
+
+
+ 
+/*    Purpose:
+ *        To know if current chip are mobile.
+ *    Parameter:
+ *        mobile: a pointer to a boolean value which is used to received the mobile status. 
+ */
+bool lcd_get_mobile_state(bool* mobile)
+{
+    unsigned char *romptr, *tableptr;   
+    u8 core_base;
+    unsigned char* biosptr;
+    u32 romaddr = 0x000C0000; /* Rom address */
+    u16 start_pattern = (u16)NULL;
+    
+    biosptr=ioremap(romaddr,0x10000);
+    
+    memcpy(&start_pattern, biosptr, 2);
+    if (start_pattern == 0xAA55) /* Compare pattern */
+    {
+        /* Get the start of Table */
+        romptr = biosptr + 0x1B; /* 0x1B means BIOS offset position */
+        tableptr = biosptr + *((u16 *)romptr);
+
+        /* Get the start of biosver structure */
+        romptr = tableptr + 18; /* 18 means BIOS version position. */
+        romptr = biosptr + *((u16 *)romptr);
+
+        /* The offset should be 44, but the actual image is less three char. */
+        romptr += 41;
+
+        core_base = *romptr++;        
+    
+        if (core_base & 0x8)
+        {
+            *mobile = FALSE;            
+        }
+        else
+        {
+            *mobile = TRUE;            
+        }
+        
+        iounmap(biosptr); /* release memory */
+        
+        return TRUE;    
+    }
+    else
+    {
+        iounmap(biosptr);
+        return FALSE;
+    }
+}
+
+/* Modified form X driver code to support P4M900 */
+void load_scaling_factor_for_p4m900(int set_hres, int set_vres, int panel_hres, int panel_vres)
+{
+    int     h_scaling_factor;
+    int     v_scaling_factor;
+    u8   cra2 = 0;
+    u8   cr77 = 0;
+    u8   cr78 = 0;
+    u8   cr79 = 0;
+    u8   cr9f = 0;
+        /* Check if expansion for horizontal */
+    if(set_hres < panel_hres)
+    {
+        /* Load Horizontal Scaling Factor */
+    
+        /* For VIA_K8M800 or later chipsets. */
+        h_scaling_factor = K800_LCD_HOR_SCF_FORMULA(set_hres, panel_hres);
+        cr9f = h_scaling_factor & 0x0003; /* HSCaleFactor[1:0] at CR9F[1:0] */        
+        cr77 = (h_scaling_factor & 0x03FC)>>2; /* HSCaleFactor[9:2] at CR77[7:0] */        
+        cr79 = (h_scaling_factor & 0x0C00)>>10; /* HSCaleFactor[11:10] at CR79[5:4] */
+        cr79 <<= 4;
+        
+        /* Horizontal scaling enabled */
+        cra2 = 0xC0;
+        
+        DEBUG_MSG(KERN_INFO "Horizontal Scaling value = %d\n", h_scaling_factor);
+    }
+    else
+    {
+        /* Horizontal scaling disabled */
+        cra2 = 0x00;        
+    }
+
+    
+    /* Check if expansion for vertical */
+    if(set_vres < panel_vres)
+    {
+        /* Load Vertical Scaling Factor */
+        
+        /* For VIA_K8M800 or later chipsets. */
+        v_scaling_factor = K800_LCD_VER_SCF_FORMULA(set_vres, panel_vres);
+        
+        /* Vertical scaling enabled */
+        cra2 |= 0x08;
+        cr79 |= ((v_scaling_factor & 0x0001)<<3); /* VSCaleFactor[0] at CR79[3] */                
+        cr78 |= (v_scaling_factor & 0x01FE) >> 1; /* VSCaleFactor[8:1] at CR78[7:0] */        
+        cr79 |= ((v_scaling_factor & 0x0600) >> 9) << 6; /* VSCaleFactor[10:9] at CR79[7:6] */
+        
+        DEBUG_MSG(KERN_INFO "Vertical Scaling value = %d\n", v_scaling_factor);
+    }
+    else
+    {
+        /* Vertical scaling disabled */
+        cra2 |= 0x00;      
+    }
+
+    write_reg_mask(CRA2, VIACR, cra2, BIT3+BIT6+BIT7);
+    write_reg_mask(CR77, VIACR, cr77, 0xFF);
+    write_reg_mask(CR78, VIACR, cr78, 0xFF);
+    write_reg_mask(CR79, VIACR, cr79, 0xF8);
+    write_reg_mask(CR9F, VIACR, cr9f, BIT0+BIT1);
+}
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/lcd.h linux-2.6.21-rc7.viafb/drivers/video/via/lcd.h
--- linux-2.6.21-rc7/drivers/video/via/lcd.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/lcd.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,57 @@
+ /*
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
+ 
+
+#ifndef __LCD_H__
+#define __LCD_H__
+
+/* Definition TMDS Device ID register */
+#define     VT1631_DEVICE_ID_REG        0x02
+#define     VT1631_DEVICE_ID            0x92
+
+
+#define     VT3271_DEVICE_ID_REG        0x02
+#define     VT3271_DEVICE_ID            0x71
+
+
+#define     GET_LCD_SIZE_BY_SYSTEM_BIOS     0x01
+#define     GET_LCD_SIZE_BY_VGA_BIOS        0x02
+#define     GET_LCD_SZIE_BY_HW_STRAPPING    0x03
+#define     GET_LCD_SIZE_BY_USER_SETTING    0x04
+
+
+
+/* Definition DVI Panel ID */
+#define     LCD_PANEL_ID0_640X480       0x00        /* Resolution: 640x480,   Channel: single, Dithering: Enable */
+#define     LCD_PANEL_ID1_800X600       0x01        /* Resolution: 800x600,   Channel: single, Dithering: Enable */
+#define     LCD_PANEL_ID2_1024X768      0x02        /* Resolution: 1024x768,  Channel: single, Dithering: Enable */
+#define     LCD_PANEL_ID3_1280X768      0x03        /* Resolution: 1280x768,  Channel: single, Dithering: Enable */
+#define     LCD_PANEL_ID4_1280X1024     0x04        /* Resolution: 1280x1024, Channel: dual,   Dithering: Enable */
+#define     LCD_PANEL_ID5_1400X1050     0x05        /* Resolution: 1400x1050, Channel: dual,   Dithering: Enable */
+#define     LCD_PANEL_ID6_1600X1200     0x06        /* Resolution: 1600x1200, Channel: dual,   Dithering: Enable */
+#define     LCD_PANEL_ID7_1366X768      0x07        /* Resolution: 1366x768,  Channel: single, Dithering: Disable */
+#define     LCD_PANEL_ID8_1024X600      0x08        /* Resolution: 1024x600,  Channel: single, Dithering: Enable */  
+#define     LCD_PANEL_ID9_1280X800      0x09        /* Resolution: 1280x800,  Channel: single, Dithering: Enable */  
+
+#endif /* __LCD_H__ */
diff -Nur linux-2.6.21-rc7/drivers/video/via/lcdtbl.h linux-2.6.21-rc7.viafb/drivers/video/via/lcdtbl.h
--- linux-2.6.21-rc7/drivers/video/via/lcdtbl.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/lcdtbl.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,303 @@
+ /*
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
+ 
+
+#ifndef __LCDTBL_H__
+#define __LCDTBL_H__
+
+#include "share.h"
+
+/* CLE266 Software Power Sequence */
+/* {Mask}, {Data}, {Delay} */
+int PowerSequenceOn[3][3] = {{0x10, 0x08, 0x06}, {0x10, 0x08, 0x06}, {0x19, 0x1FE, 0x01}};
+int PowerSequenceOff[3][3] = {{0x06, 0x08, 0x10}, {0x00, 0x00, 0x00}, {0xD2, 0x19, 0x01}};
+
+/* ++++++ P880 ++++++ */
+/*   Panel 1600x1200   */
+struct io_reg P880_LCD_RES_6X4_16X12[]  = {
+  {VIACR,CR50,0xFF,0x73},{VIACR,CR55,0x0F,0x08},                       /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x73},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},/* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x5A},{VIACR,CR71,0x08,0x00},                       /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x5E},                                              /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xD6},{VIACR,CR67,0x03,0x00},                       /* IGA2 Offset                      */
+  {VIASR,SR44,0xFF,0x7D},{VIASR,SR45,0xFF,0x8C},{VIASR,SR46,0xFF,0x02} /* VCLK                             */
+};
+#define NUM_TOTAL_P880_LCD_RES_6X4_16X12 ARRAY_SIZE(P880_LCD_RES_6X4_16X12)
+
+struct io_reg P880_LCD_RES_7X4_16X12[]  = {
+  {VIACR,CR50,0xFF,0x67},{VIACR,CR55,0x0F,0x08},                       /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x67},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},/* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x74},{VIACR,CR71,0x08,0x00},                       /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x78},                                              /* IGA2 Horizontal Blank End Shadow */ 
+  {VIACR,CR66,0xFF,0xF5},{VIACR,CR67,0x03,0x00},                       /* IGA2 Offset                      */
+  {VIASR,SR44,0xFF,0x78},{VIASR,SR45,0xFF,0x8C},{VIASR,SR46,0xFF,0x01} /* VCLK                             */
+};
+#define NUM_TOTAL_P880_LCD_RES_7X4_16X12 ARRAY_SIZE(P880_LCD_RES_7X4_16X12)
+
+struct io_reg P880_LCD_RES_8X6_16X12[]  = {
+  {VIACR,CR50,0xFF,0x65},{VIACR,CR55,0x0F,0x08},                       /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x65},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},/* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x00},                       /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x83},                                              /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xE1},{VIACR,CR67,0x03,0x00},                       /* IGA2 Offset                      */
+  {VIASR,SR44,0xFF,0x6D},{VIASR,SR45,0xFF,0x88},{VIASR,SR46,0xFF,0x03} /* VCLK                             */
+};
+#define NUM_TOTAL_P880_LCD_RES_8X6_16X12 ARRAY_SIZE(P880_LCD_RES_8X6_16X12)
+
+struct io_reg P880_LCD_RES_10X7_16X12[]  = {
+  {VIACR,CR50,0xFF,0x65},{VIACR,CR55,0x0F,0x08},                       /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x65},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},/* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0xAB},{VIACR,CR71,0x08,0x00},                       /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0xAF},                                              /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xF0},{VIACR,CR67,0x03,0x00},                       /* IGA2 Offset                      */
+  {VIASR,SR44,0xFF,0x92},{VIASR,SR45,0xFF,0x88},{VIASR,SR46,0xFF,0x03} /* VCLK                             */
+};
+#define NUM_TOTAL_P880_LCD_RES_10X7_16X12 ARRAY_SIZE(P880_LCD_RES_10X7_16X12)
+
+struct io_reg P880_LCD_RES_12X10_16X12[]  = {
+  {VIACR,CR50,0xFF,0x7D},{VIACR,CR55,0x0F,0x08},                       /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x7D},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},/* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0xD0},{VIACR,CR71,0x08,0x00},                       /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0xD4},                                              /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xFA},{VIACR,CR67,0x03,0x00},                       /* IGA2 Offset                      */
+  {VIASR,SR44,0xFF,0xF6},{VIASR,SR45,0xFF,0x88},{VIASR,SR46,0xFF,0x05} /* VCLK                             */
+};
+#define NUM_TOTAL_P880_LCD_RES_12X10_16X12 ARRAY_SIZE(P880_LCD_RES_12X10_16X12)
+
+/*   Panel 1400x1050   */
+static struct io_reg P880_LCD_RES_6X4_14X10[]    = {                    /* 640x480                          */
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x56},                        /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x5F},{VIACR,CR71,0x08,0x44},                        /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x63},                                               /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xB4},{VIACR,CR67,0x03,0x00},                        /* IGA2 Offset                      */
+  {VIASR,SR44,0xFF,0xC6},{VIASR,SR45,0xFF,0x8C},{VIASR,SR46,0xFF,0x05}  /* VCLK                             */
+};
+#define NUM_TOTAL_P880_LCD_RES_6X4_14X10 ARRAY_SIZE(P880_LCD_RES_6X4_14X10)
+
+static struct io_reg P880_LCD_RES_8X6_14X10[]    = {                    /* 800x600                          */
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x56},                        /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x44},                        /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x83},                                               /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xBE},{VIACR,CR67,0x03,0x00},                        /* IGA2 Offset                      */
+  {VIASR,SR44,0xFF,0x06},{VIASR,SR45,0xFF,0x8D},{VIASR,SR46,0xFF,0x05}  /* VCLK                             */
+};
+#define NUM_TOTAL_P880_LCD_RES_8X6_14X10 ARRAY_SIZE(P880_LCD_RES_8X6_14X10)
+
+
+/* ++++++ K400 ++++++ */
+/*   Panel 1600x1200   */
+struct io_reg K400_LCD_RES_6X4_16X12[]  = {
+  {VIACR,CR50,0xFF,0x73},{VIACR,CR55,0x0F,0x08},                         /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x73},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},  /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x5A},{VIACR,CR71,0x08,0x00},                         /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x5E},                                                /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xDA},{VIACR,CR67,0x03,0x00},                         /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0xC4},{VIASR,SR47,0xFF,0x7F}                          /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_6X4_16X12 ARRAY_SIZE(K400_LCD_RES_6X4_16X12)
+
+struct io_reg K400_LCD_RES_7X4_16X12[]  = {
+  {VIACR,CR50,0xFF,0x67},{VIACR,CR55,0x0F,0x08},                         /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x67},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},  /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x74},{VIACR,CR71,0x08,0x00},                         /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x78},                                                /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xF5},{VIACR,CR67,0x03,0x00},                         /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x46},{VIASR,SR47,0xFF,0x3D}                          /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_7X4_16X12 ARRAY_SIZE(K400_LCD_RES_7X4_16X12)
+
+struct io_reg K400_LCD_RES_8X6_16X12[]  = {
+  {VIACR,CR50,0xFF,0x65},{VIACR,CR55,0x0F,0x08},                         /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x65},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},  /* IGA2 Horizontal Blank End        */ 
+  {VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x00},                         /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x83},                                                /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xE1},{VIACR,CR67,0x03,0x00},                         /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x85},{VIASR,SR47,0xFF,0x6F}                          /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_8X6_16X12 ARRAY_SIZE(K400_LCD_RES_8X6_16X12)
+
+struct io_reg K400_LCD_RES_10X7_16X12[]  = {
+  {VIACR,CR50,0xFF,0x65},{VIACR,CR55,0x0F,0x08},                         /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x65},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},  /* IGA2 Horizontal Blank End        */ 
+  {VIACR,CR6D,0xFF,0xAB},{VIACR,CR71,0x08,0x00},                         /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0xAF},                                                /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xF0},{VIACR,CR67,0x03,0x00},                         /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x45},{VIASR,SR47,0xFF,0x4A}                          /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_10X7_16X12 ARRAY_SIZE(K400_LCD_RES_10X7_16X12)
+
+struct io_reg K400_LCD_RES_12X10_16X12[]  = {
+  {VIACR,CR50,0xFF,0x7D},{VIACR,CR55,0x0F,0x08},                         /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x7D},{VIACR,CR54,0x38,0x00},{VIACR,CR5D,0x40,0x40},  /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0xD0},{VIACR,CR71,0x08,0x00},                         /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0xD4},                                                /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xFA},{VIACR,CR67,0x03,0x00},                         /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x47},{VIASR,SR47,0xFF,0x7C}                          /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_12X10_16X12 ARRAY_SIZE(K400_LCD_RES_12X10_16X12)
+
+/*   Panel 1400x1050   */
+static struct io_reg K400_LCD_RES_6X4_14X10[]  = {                      /* 640x400                          */
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x56},                        /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x5F},{VIACR,CR71,0x08,0x44},                        /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x63},                                               /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xB4},{VIACR,CR67,0x03,0x00},                        /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x07},{VIASR,SR47,0xFF,0x19}    /* VCLK        */
+};
+#define NUM_TOTAL_K400_LCD_RES_6X4_14X10 ARRAY_SIZE(K400_LCD_RES_6X4_14X10)
+
+static struct io_reg K400_LCD_RES_8X6_14X10[]  = {                      /* 800x600                          */
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x56},                        /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x44},                        /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x83},                                               /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xBE},{VIACR,CR67,0x03,0x00},                        /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x07},{VIASR,SR47,0xFF,0x21}                         /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_8X6_14X10 ARRAY_SIZE(K400_LCD_RES_8X6_14X10)
+
+static struct io_reg K400_LCD_RES_10X7_14X10[]  = {                     /* 1024x768                         */
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x56},                        /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0xA3},{VIACR,CR71,0x08,0x44},                        /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0xA7},                                               /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xC3},{VIACR,CR67,0x03,0x04},                        /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x05},{VIASR,SR47,0xFF,0x1E}                         /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_10X7_14X10 ARRAY_SIZE(K400_LCD_RES_10X7_14X10)
+
+static struct io_reg K400_LCD_RES_12X10_14X10[]  = {                    /* 1280x768, 1280x960, 1280x1024    */
+  {VIACR,CR50,0xFF,0x97},{VIACR,CR55,0x0F,0x56},                        /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x97},{VIACR,CR54,0x38,0x75},{VIACR,CR5D,0x40,0x24}, /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0xCE},{VIACR,CR71,0x08,0x44},                        /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0xD2},                                               /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xC9},{VIACR,CR67,0x03,0x04},                        /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x84},{VIASR,SR47,0xFF,0x79}                         /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_12X10_14X10 ARRAY_SIZE(K400_LCD_RES_12X10_14X10)
+
+
+/* ++++++ K400 ++++++ */
+/*   Panel 1280x1024   */
+struct io_reg K400_LCD_RES_6X4_12X10[]  = {
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x46},                         /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x74},{VIACR,CR5D,0x40,0x1C},  /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x5F},{VIACR,CR71,0x08,0x34},                         /* IGA2 Horizontal Total Shadow     */ 
+  {VIACR,CR6E,0xFF,0x63},                                                /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xAA},{VIACR,CR67,0x03,0x00},                         /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x07},{VIASR,SR47,0xFF,0x19}                          /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_6X4_12X10 ARRAY_SIZE(K400_LCD_RES_6X4_12X10)
+
+struct io_reg K400_LCD_RES_7X4_12X10[]  = {
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x46},                         /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x74},{VIACR,CR5D,0x40,0x1C},  /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x68},{VIACR,CR71,0x08,0x34},                         /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x6C},                                                /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xA8},{VIACR,CR67,0x03,0x00},                         /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x87},{VIASR,SR47,0xFF,0xED}                          /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_7X4_12X10 ARRAY_SIZE(K400_LCD_RES_7X4_12X10)
+
+struct io_reg K400_LCD_RES_8X6_12X10[]  = {
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x46},                         /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x74},{VIACR,CR5D,0x40,0x1C},  /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x34},                         /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x83},                                                /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xBE},{VIACR,CR67,0x03,0x00},                         /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x07},{VIASR,SR47,0xFF,0x21}                          /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_8X6_12X10 ARRAY_SIZE(K400_LCD_RES_8X6_12X10)
+
+struct io_reg K400_LCD_RES_10X7_12X10[]  = {
+  {VIACR,CR50,0xFF,0x9D},{VIACR,CR55,0x0F,0x46},                         /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x9D},{VIACR,CR54,0x38,0x74},{VIACR,CR5D,0x40,0x1C},  /* IGA2 Horizontal Blank End        */ 
+  {VIACR,CR6D,0xFF,0xA3},{VIACR,CR71,0x08,0x34},                         /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0xA7},                                                /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0xBE},{VIACR,CR67,0x03,0x04},                         /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x05},{VIASR,SR47,0xFF,0x1E}                          /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_10X7_12X10 ARRAY_SIZE(K400_LCD_RES_10X7_12X10)
+
+
+/* ++++++ K400 ++++++ */
+/*   Panel 1024x768    */
+struct io_reg K400_LCD_RES_6X4_10X7[]  = {
+  {VIACR,CR50,0xFF,0x47},{VIACR,CR55,0x0F,0x35},                         /* IGA2 Horizontal Total      */
+  {VIACR,CR53,0xFF,0x47},{VIACR,CR54,0x38,0x2B},{VIACR,CR5D,0x40,0x13},  /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x60},{VIACR,CR71,0x08,0x23},                         /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x64},                                                /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0x8C},{VIACR,CR67,0x03,0x00},                         /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x87},{VIASR,SR47,0xFF,0x4C}                          /* VCLK                             */
+};
+
+#define NUM_TOTAL_K400_LCD_RES_6X4_10X7 ARRAY_SIZE(K400_LCD_RES_6X4_10X7)
+
+struct io_reg K400_LCD_RES_7X4_10X7[]  = {
+  {VIACR,CR50,0xFF,0x3B},{VIACR,CR55,0x0F,0x35},                         /* IGA2 Horizontal Total            */ 
+  {VIACR,CR53,0xFF,0x3B},{VIACR,CR54,0x38,0x2B},{VIACR,CR5D,0x40,0x13},  /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x71},{VIACR,CR71,0x08,0x23},                         /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x75},                                                /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0x96},{VIACR,CR67,0x03,0x00},                         /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x05},{VIASR,SR47,0xFF,0x10}                          /* VCLK                             */
+};
+
+#define NUM_TOTAL_K400_LCD_RES_7X4_10X7 ARRAY_SIZE(K400_LCD_RES_7X4_10X7)
+
+struct io_reg K400_LCD_RES_8X6_10X7[]  = {
+  {VIACR,CR50,0xFF,0x37},{VIACR,CR55,0x0F,0x35},                         /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x37},{VIACR,CR54,0x38,0x2B},{VIACR,CR5D,0x40,0x13},  /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x7E},{VIACR,CR71,0x08,0x23},                         /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x82},                                                /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0x8C},{VIACR,CR67,0x03,0x00},                         /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x84},{VIASR,SR47,0xFF,0xB9}                          /* VCLK        */ 
+};
+#define NUM_TOTAL_K400_LCD_RES_8X6_10X7 ARRAY_SIZE(K400_LCD_RES_8X6_10X7)
+
+/* ++++++ K400 ++++++ */
+/*   Panel 800x600     */
+struct io_reg K400_LCD_RES_6X4_8X6[]  = {
+  {VIACR,CR50,0xFF,0x1A},{VIACR,CR55,0x0F,0x34},                         /* IGA2 Horizontal Total            */ 
+  {VIACR,CR53,0xFF,0x1A},{VIACR,CR54,0x38,0xE3},{VIACR,CR5D,0x40,0x12},  /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x5F},{VIACR,CR71,0x08,0x22},                         /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x63},                                                /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0x6E},{VIACR,CR67,0x03,0x00},                         /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0x86},{VIASR,SR47,0xFF,0xB3}                          /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_6X4_8X6 ARRAY_SIZE(K400_LCD_RES_6X4_8X6)
+
+struct io_reg K400_LCD_RES_7X4_8X6[]  = {
+  {VIACR,CR50,0xFF,0x1F},{VIACR,CR55,0x0F,0x34},                         /* IGA2 Horizontal Total            */
+  {VIACR,CR53,0xFF,0x1F},{VIACR,CR54,0x38,0xE3},{VIACR,CR5D,0x40,0x12},  /* IGA2 Horizontal Blank End        */
+  {VIACR,CR6D,0xFF,0x7F},{VIACR,CR71,0x08,0x22},                         /* IGA2 Horizontal Total Shadow     */
+  {VIACR,CR6E,0xFF,0x83},                                                /* IGA2 Horizontal Blank End Shadow */
+  {VIACR,CR66,0xFF,0x78},{VIACR,CR67,0x03,0x00},                         /* IGA2 Offset                      */
+  {VIASR,SR46,0xFF,0xC4},{VIASR,SR47,0xFF,0x59}                          /* VCLK                             */
+};
+#define NUM_TOTAL_K400_LCD_RES_7X4_8X6 ARRAY_SIZE(K400_LCD_RES_7X4_8X6)
+
+#endif /* __LCDTBL_H__ */

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
