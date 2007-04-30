From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 5/12] viafb: Framebuffer driver for VIA
 UniChrome/Chrome9 HC (fwd)
Date: Mon, 30 Apr 2007 10:37:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704301037010.27246@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiRNg-0006Wq-Qv for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:37:13 -0700
Received: from europa.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiRNf-0001fD-Es
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:37:12 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by europa.telenet-ops.be (Postfix) with SMTP id 8F5DD4158
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:10 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by europa.telenet-ops.be (Postfix) with ESMTP id 277A741A1
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:07 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l3U8b7Xk020381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:07 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l3U8b6ND020377
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:06 +0200
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
Date: Mon, 30 Apr 2007 13:20:20 +0800
From: EddyFu@via.com.tw
To: linux-fbdev-devel-bounces@lists.sourceforge.net
Subject: [Linux-fbdev-devel] [PATCH 5/12] viafb: Framebuffer driver for VIA
    UniChrome/Chrome9 HC

Dear All, 
 
Here is the part 5/12 of viafb.
 
Best Regards,
Eddy Fu 
 
diff -Nur linux-2.6.21-rc7/drivers/video/via/IntegratedTV.c linux-2.6.21-rc7.viafb/drivers/video/via/IntegratedTV.c
--- linux-2.6.21-rc7/drivers/video/via/IntegratedTV.c 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/IntegratedTV.c 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,1448 @@
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
+ 
+#include <linux/ioport.h>
+#include <asm/io.h>
+#include <linux/fb.h>
+
+#include "viafbdev.h"
+#include "tv.h"
+#include "share.h"
+#include "chip.h"
+#include "debug.h"
+#include "tblIntegratedTV.h"
+#include "IntegratedTV.h"
+#include "ioctl.h"
+
+extern struct tv_setting_information    tv_setting_info;
+extern struct chip_information          chip_info;
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+extern struct viafb_info    viafbinfo;
+#else
+extern struct viafb_par     parinfo;
+#endif
+
+extern inline void write_reg(u8 index, u16 io_port, u8 data);
+extern inline u8 read_reg(int io_port, u8 index);
+extern void write_reg_mask(u8 index, int io_port, u8 data, u8 mask);
+extern void enable_second_display_channel(void);
+extern void plus_vck_to_iga1_timing(unsigned long h_total);
+extern void delays(int count);
+extern void load_crtc_timing(struct display_timing device_timing, int set_iga);
+
+bool g_first_time_to_sense = TRUE;
+
+void enable_integrated_tv_shadow_reg(void)
+{
+    int i;
+
+    /* Enable integrated TV shadow register. */
+    /* Only for A0000 now, we may modify this if need other TV shadow memory. */
+    write_reg(SR52, VIASR, 0x01);
+
+    /* Wait data ready. */
+    for (i=0; i<10; i++)
+    {
+        if (read_reg(VIASR, SR52) & BIT0)
+        {
+            break;
+        }
+    }
+}
+
+
+void disable_integrated_tv_shadow_reg(void)
+{
+    write_reg(SR52, VIASR, 0x00);
+}  
+
+
+void write_integrated_tv_reg8(unsigned char* mmio_base, u8 offset, u8 data)
+{
+    *(volatile u8 *)(mmio_base + offset) = data;
+    DEBUG_MSG(KERN_INFO "Write Integrated TV Reg (byte): Offset 0x%2x, Value 0x%2x!\n", offset, data);
+}
+
+
+void write_integrated_tv_reg32(unsigned char* mmio_base, u8 offset, u32 data)
+{
+    *(volatile u32 *)(mmio_base + offset) = data;
+    DEBUG_MSG(KERN_INFO "Write Integrated TV Reg: Offset 0x%2x, Value 0x%8x!\n", offset, data);
+}
+
+
+void write_integrated_tv_reg_mask32(unsigned char* mmio_base, u8 offset, u32 mask, u32 data)
+{
+    u32 old_data, new_data;
+
+    old_data = *(volatile u32 *)(mmio_base + offset);
+    new_data = (data & mask) | (old_data & (~mask));
+    *(volatile u32 *)(mmio_base + offset) = new_data;
+
+    DEBUG_MSG(KERN_INFO "Write Integrated TV Reg Mask: Offset 0x%2x, Value 0x%8x!\n", offset, new_data);
+}
+
+
+u32 read_integrated_tv_reg32(unsigned char* mmio_base, u8 offset)
+{
+    u32 data;
+
+    data = *(volatile u32 *)(mmio_base + offset);
+
+    return data;
+}
+
+
+void write_integrated_tv_general_table(unsigned short *tv_reg_offset_table, unsigned long *tv_reg_table)
+{
+    int i = 0;
+    unsigned char* mmio_base;
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+    mmio_base = (unsigned char*)viafbinfo.integrated_tv_map_base;
+#else
+    mmio_base = (unsigned char*)parinfo.integrated_tv_map_base;
+#endif
+
+    while(tv_reg_offset_table[i] != 0xFFFF)
+    {
+        write_integrated_tv_reg32(mmio_base, GET_LOW_BYTE(tv_reg_offset_table[i]), tv_reg_table[i]);
+        i++;
+    }
+}
+
+
+void write_integrated_tv_patch_table(u16 *tv_reg_table)
+{
+    int i = 0;
+    unsigned char* mmio_base;
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+    mmio_base = (unsigned char*)viafbinfo.integrated_tv_map_base;
+#else
+    mmio_base = (unsigned char*)parinfo.integrated_tv_map_base;
+#endif
+    
+    while(tv_reg_table[i] != 0xFFFF)
+    {
+        write_integrated_tv_reg8(mmio_base, GET_LOW_BYTE(tv_reg_table[i]), GET_HIGH_BYTE(tv_reg_table[i]));
+        i++;
+    }
+}
+
+
+u32 access_integrated_tv_regs(int reg_id, u32 value, int cmd)
+{
+    u8 offset;
+    u32 mask, set_data, get_data, shift_bits, tmp1, tmp2;
+    unsigned char* mmio_base;
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+    mmio_base = (unsigned char*)viafbinfo.integrated_tv_map_base;
+#else
+    mmio_base = (unsigned char*)parinfo.integrated_tv_map_base;
+#endif
+
+    /* Note: It's better to call enable_integrated_tv_shadow_reg() to enable integrated TV shadow register */
+    /* before access the following registers, or it may fail to access them. */
+    
+    switch (reg_id)
+    {
+        case ITV_REG_ID_PK_ENABLE:
+        {
+            /* 00[0] */
+            offset = 0x00;
+            mask = 0x00000001;
+            shift_bits = 0;
+
+            break;
+        }
+
+        case ITV_REG_ID_SRC_SEL:
+        {
+            /* 00[18] */
+            offset = 0x00;
+            mask = 0x00040000;
+            shift_bits = 18;
+            
+            break;
+        }
+
+        case ITV_REG_ID_SW_RESET:
+        {
+            /* 00[20] */
+            offset = 0x00;
+            mask = 0x00100000;
+            shift_bits = 20;
+            
+            break;
+        }
+
+        case ITV_REG_ID_SYNC_BUF_MODE:
+        {
+            /* 00[30] */
+            offset = 0x00;
+            mask = 0x40000000;
+            shift_bits = 30;
+            
+            break;
+        }
+
+        case ITV_REG_ID_SD_ENABLE:
+        {
+            /* 00[31] */
+            offset = 0x00;
+            mask = 0x80000000;
+            shift_bits = 31;
+            
+            break;
+        }
+
+        case ITV_REG_ID_SRC_VSIZE:
+        {
+            /* 18[10:0] */
+            offset = 0x18;
+            mask = 0x000007FF;
+            shift_bits = 0;
+            
+            break;
+        }
+
+        case ITV_REG_ID_SRC_HSIZE:
+        {
+            /* 18[21:11] */
+            offset = 0x18;
+            mask = 0x003FF800;
+            shift_bits = 11;
+            
+            break;
+        }
+
+        case ITV_REG_ID_DE_FLK_THRESHOLD:
+        {
+            /* 20[31:27] + 20[15:11] */
+            offset = 0x20;
+                
+            if (cmd == ITV_CMD_WRITE)
+            {
+                tmp1 = value & 0x1F;        /* bit4-bit0 */
+                tmp2 = (value >> 5) & 0x1F; /* bit9-bit5 */
+                set_data = (tmp2 << 27) | (tmp1 << 11);
+                write_integrated_tv_reg_mask32(mmio_base, offset, 0xF800F800, set_data);
+                
+                return 0;  /* 0 means nothing, just for return. */
+            }
+            else
+            {
+                get_data = read_integrated_tv_reg32(mmio_base, offset);
+                tmp1 = (get_data & 0x0000F800) >> 11;   /* bit4-bit0 */
+                tmp2 = (get_data & 0xF8000000) >> 27;   /* bit9-bit5 */
+                get_data = (tmp2 << 5) | tmp1;
+
+                return get_data;
+            }
+        }
+        
+        case ITV_REG_ID_SCL_VFAC:
+        {
+            /* 24[12:0] */
+            offset = 0x24;
+            mask = 0x00001FFF;
+            shift_bits = 0;
+            
+            break;
+        }
+
+        case ITV_REG_ID_DE_FLK_NUM:
+        {
+            /* 24[13] */
+            offset = 0x24;
+            mask = 0x00002000;
+            shift_bits = 13;
+            
+            break;
+        }
+        
+        case ITV_REG_ID_DF_WT_SEL:
+        {
+            /* 24[14] */
+            offset = 0x24;
+            mask = 0x00004000;
+            shift_bits = 14;
+            
+            break;
+        }
+
+        case ITV_REG_ID_DF_TYPE:
+        {
+            /* 24[15] */
+            offset = 0x24;
+            mask = 0x00008000;
+            shift_bits = 15;
+            
+            break;
+        }
+        
+        case ITV_REG_ID_DE_FLICKER_ENABLE:
+        {
+            /* 24[29] */
+            offset = 0x24;
+            mask = 0x20000000;
+            shift_bits = 29;
+            
+            break;
+        }
+        
+        case ITV_REG_ID_SCL_HFAC:
+        {
+            /* 24[28:16] */
+            offset = 0x24;
+            mask = 0x1FFF0000;
+            shift_bits = 16;
+            
+            break;
+        }
+
+        case ITV_REG_ID_DST_VSIZE:
+        {
+            /* 28[10:0] */
+            offset = 0x28;
+            mask = 0x000007FF;
+            shift_bits = 0;
+            
+            break;
+        }
+
+        case ITV_REG_ID_DST_HSIZE:
+        {
+            /* 28[21:11] */
+            offset = 0x28;
+            mask = 0x003FF800;
+            shift_bits = 11;
+            
+            break;
+        }
+
+        case ITV_REG_ID_TV_ENABLE:
+        {
+            /* 38[0] */
+            offset = 0x38;
+            mask = 0x00000001;
+            shift_bits = 0;
+
+            break;
+        }
+
+        case ITV_REG_ID_OUTPUT_SEL:
+        {
+            /* 38[29:28] */
+            offset = 0x38;
+            mask = 0x30000000;
+            shift_bits = 28;
+
+            break;
+        }
+
+        case ITV_REG_ID_TV_SENSE:
+        {
+            /* 3C[15:14] */
+            offset = 0x3C;
+            mask = 0x0000C000;
+            shift_bits = 14;
+            
+            break;
+        }
+        
+        case ITV_REG_ID_TV_SENSE_DATA:
+        {
+            /* 3C[31:24] */
+            offset = 0x3C;
+            mask = 0xFF000000;
+            shift_bits = 24;
+            
+            break;
+        }
+        
+        case ITV_REG_ID_DST_HSD:
+        {
+            /* 48[30:21] */
+            offset = 0x48;
+            mask = 0x7FE00000;
+            shift_bits = 21;
+
+            break;
+        }
+
+        case ITV_REG_ID_DST_VSD:
+        {
+            /* 4C[31:23] */
+            offset = 0x4C;
+            mask = 0xFF800000;
+            shift_bits = 23;
+
+            break;
+        }
+
+        case ITV_REG_ID_SATURATION:
+        {
+            /* 50[8:0] + 50[24:16] */
+            offset = 0x50;
+                
+            if (cmd == ITV_CMD_WRITE)
+            {
+                tmp1 = value & 0x1FF;        /* bit8-bit0 */
+                tmp2 = (value >> 9) & 0x1FF; /* bit24-bit16 */
+                set_data = ((tmp2 << 16) | (tmp1));
+                write_integrated_tv_reg_mask32(mmio_base, offset, 0x01FF01FF, set_data);
+                
+                return 0;  /* 0 means nothing, just for return. */
+            }
+            else
+            {
+                get_data = read_integrated_tv_reg32(mmio_base, offset);
+                tmp1 = (get_data & 0x000001FF);   /* bit8-bit0 */
+                tmp2 = (get_data & 0x01FF0000) >> 16;   /* bit24-bit16 */
+                get_data = (tmp2 << 9) | tmp1;
+
+                return get_data;
+            }
+        }
+
+        case ITV_REG_ID_CONTRAST:
+        {
+            /* 54[8:0] */
+            offset = 0x54;
+            mask = 0x000001FF;
+            shift_bits = 0;
+            break;
+        }
+        
+        case ITV_REG_ID_BLACK_LEVEL:
+        {
+            /* 54[30:23] */
+            offset = 0x54;
+            mask = 0x7F800000;
+            shift_bits = 23;
+            break;
+        }
+
+        case ITV_REG_ID_HUE:
+        {
+            /* 60[10:0] */
+            offset = 0x60;
+            mask = 0x000007FF;
+            shift_bits = 0;
+            break;
+        }
+
+        case ITV_REG_ID_PRI_DAC_SEL:
+        {
+            /* 6C[12] */
+            offset = 0x6C;
+            mask = 0x00001000;
+            shift_bits = 12;
+            
+            break;
+        }
+
+        case ITV_REG_ID_TV_SENSE_STATUS:
+        {
+            /* E4[2] */
+            offset = 0xE4;
+            mask = 0x00000004;
+            shift_bits = 2;
+            
+            break;
+        }
+
+        case ITV_REG_ID_PBPR_BLANK_LEVEL:
+        {
+            /* E8[8:0] */
+            offset = 0xE8;
+            mask = 0x000000FF;
+            shift_bits = 0; 
+            break;
+        }
+
+        case ITV_REG_ID_TV_SENSE_RGB_STATUS:
+        {
+            /* E8[30:28] */
+            offset = 0xE8;
+            mask = 0x70000000;
+            shift_bits = 28;
+            
+            break;
+        }
+        
+        default:
+        {
+            return 0;  /* 0 means nothing, just for return. */
+        }
+    }
+
+    if (cmd == ITV_CMD_WRITE)
+    {
+        set_data = value << shift_bits;
+        write_integrated_tv_reg_mask32(mmio_base, offset, mask, set_data);
+        
+        return 0;  /* 0 means nothing, just for return. */
+    }
+    else
+    {
+        get_data = read_integrated_tv_reg32(mmio_base, offset);
+        get_data = (get_data & mask) >> shift_bits;
+
+        return get_data;
+    }
+}
+
+
+void set_integrated_tv_output_signal(void)
+{
+    u8  sr5e;
+    
+    /* HDTV only can use RGB or YPbPr output. */
+    if ((tv_setting_info.system == TVTYPE_480P) || (tv_setting_info.system == TVTYPE_576P) ||
+        (tv_setting_info.system == TVTYPE_720P) || (tv_setting_info.system == TVTYPE_1080I))
+        
+    {
+        if ((tv_setting_info.out_signal != TV_OUTPUT_RGB) &&
+            (tv_setting_info.out_signal != TV_OUTPUT_YPBPR))
+        {
+            tv_setting_info.out_signal = TV_OUTPUT_RGB;
+        }
+    }
+    
+    DEBUG_MSG(KERN_INFO "set_integrated_tv_output_signal: TVOutput = %d\n", tv_setting_info.out_signal);
+
+    /* We could separate Composite and S-Video by controlling DAC R/G/B. */
+    sr5e = read_reg(VIASR, SR5E) & 0xF1;    /* Turn on DAC R/G/B. */
+
+    switch (tv_setting_info.out_signal)
+    {
+        case TV_OUTPUT_COMPOSITE:        
+        {
+            access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, ITV_VALUE_OUTPUT_SC, ITV_CMD_WRITE);
+
+            /* Turn off DAC R and G, turn on DAC B. */
+            write_reg(SR5E, VIASR, sr5e | (BIT1+BIT2));
+            break;
+        }
+
+        case TV_OUTPUT_SVIDEO:
+        {
+            access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, ITV_VALUE_OUTPUT_SC, ITV_CMD_WRITE);
+
+            /* Turn on DAC R and G, turn off DAC B. */
+            write_reg(SR5E, VIASR, sr5e | BIT3);
+            break;
+        }
+
+        case TV_OUTPUT_COMPOSITE_SVIDEO:
+        {
+            access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, ITV_VALUE_OUTPUT_SC, ITV_CMD_WRITE);
+
+            /* Turn on DAC R/G/B. */
+            write_reg(SR5E, VIASR, sr5e);
+            break;
+        }
+        
+        case TV_OUTPUT_RGB:
+        {
+            access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, ITV_VALUE_OUTPUT_RGB, ITV_CMD_WRITE);
+
+            /* Turn on DAC R/G/B. */
+            write_reg(SR5E, VIASR, sr5e);
+            break;
+        }
+            
+        case TV_OUTPUT_YPBPR:
+        {
+            access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, ITV_VALUE_OUTPUT_YPbPr, ITV_CMD_WRITE);
+
+            /* Turn on DAC R/G/B. */
+            write_reg(SR5E, VIASR, sr5e);
+            break;
+        }
+            
+        default:
+        {
+            access_integrated_tv_regs(ITV_REG_ID_OUTPUT_SEL, ITV_VALUE_OUTPUT_SC, ITV_CMD_WRITE);
+
+            /* Turn off DAC R and G, turn on DAC B. */
+            write_reg(SR5E, VIASR, sr5e | (BIT1+BIT2));
+            break;
+        }
+    }
+}
+
+
+void write_gfx_crtc_timing_for_tv(unsigned long *tv_crtc_table)
+{
+    int i;
+    struct display_timing  tv_crtc_reg;
+    
+    for (i=0; i< NUM_CRTC_TIMING; i++)
+    {
+        switch(i)
+        {
+            case H_TOTAL_INDEX:
+                tv_crtc_reg.hor_total = tv_crtc_table[i];
+                DEBUG_MSG(KERN_INFO "H_Total: %d!\n", tv_crtc_reg.hor_total);
+                break;
+                
+            case H_ADDR_INDEX:
+                tv_crtc_reg.hor_addr = tv_crtc_table[i];
+                DEBUG_MSG(KERN_INFO "H_Addr: %d!\n", tv_crtc_reg.hor_addr);
+                break;
+                
+            case H_BLANK_START_INDEX:
+                tv_crtc_reg.hor_blank_start = tv_crtc_table[i];
+                DEBUG_MSG(KERN_INFO "H_Blank_Start: %d!\n", tv_crtc_reg.hor_blank_start);
+                break;
+                
+            case H_BLANK_END_INDEX:
+                tv_crtc_reg.hor_blank_end = tv_crtc_table[i];
+                DEBUG_MSG(KERN_INFO "H_Blank_End: %d!\n", tv_crtc_reg.hor_blank_end);
+                break;
+                
+            case H_SYNC_START_INDEX:
+                tv_crtc_reg.hor_sync_start = tv_crtc_table[i];
+                DEBUG_MSG(KERN_INFO "H_Sync_Start: %d!\n", tv_crtc_reg.hor_sync_start);
+                break;
+                
+            case H_SYNC_END_INDEX:
+                tv_crtc_reg.hor_sync_end = tv_crtc_table[i];
+                DEBUG_MSG(KERN_INFO "H_Sync_End: %d!\n", tv_crtc_reg.hor_sync_end);
+                break;
+                
+            case V_TOTAL_INDEX:
+                tv_crtc_reg.ver_total = tv_crtc_table[i];
+                break;
+                
+            case V_ADDR_INDEX:
+                tv_crtc_reg.ver_addr = tv_crtc_table[i];
+                break;
+                
+            case V_BLANK_START_INDEX:
+                tv_crtc_reg.ver_blank_start = tv_crtc_table[i];
+                break;
+                
+            case V_BLANK_END_INDEX:
+                tv_crtc_reg.ver_blank_end = tv_crtc_table[i];
+                break;
+                
+            case V_SYNC_START_INDEX:
+                tv_crtc_reg.ver_sync_start = tv_crtc_table[i];
+                break;
+                
+            case V_SYNC_END_INDEX:
+                tv_crtc_reg.ver_sync_end = tv_crtc_table[i];
+                break;
+                
+        }
+    }
+
+    load_crtc_timing(tv_crtc_reg, tv_setting_info.iga_path);
+}
+
+
+void update_scaling_factor(void)
+{
+    u32 dst_hsize, dst_vsize, src_hsize, src_vsize, scal_factor = 0;
+
+    dst_hsize = access_integrated_tv_regs(ITV_REG_ID_DST_HSIZE, 0, ITV_CMD_READ) + 1;
+    dst_vsize = access_integrated_tv_regs(ITV_REG_ID_DST_VSIZE, 0, ITV_CMD_READ) + 1;
+    src_hsize = access_integrated_tv_regs(ITV_REG_ID_SRC_HSIZE, 0, ITV_CMD_READ) + 1;
+    src_vsize = access_integrated_tv_regs(ITV_REG_ID_SRC_VSIZE, 0, ITV_CMD_READ) + 1;
+
+    if ((tv_setting_info.system == TVTYPE_480P) ||
+        (tv_setting_info.system == TVTYPE_576P) ||
+        (tv_setting_info.system == TVTYPE_1080I))
+    {
+        scal_factor = (src_hsize * 2048) / dst_hsize;
+    }
+    else if (tv_setting_info.system == TVTYPE_720P)
+    {
+        /* The two modes 720x480 and 720x576 have alignment issue (alignment to 4), 
+           so the value of SRC_LINE_PITCH, DST_DQW_NUM and DST_LINE_PITCH
+           we set are greater than the desired ones, and this may cause the problem about 
+           having garbage line on the right side, so we reduce the scaling factor to avoid
+           this problem. */
+        if (((src_hsize == 720) && (src_vsize == 480)) ||
+            ((src_hsize == 720) && (src_vsize == 576)))
+        {
+            scal_factor = ((src_hsize * 2048) / dst_hsize) - 3;
+        }
+        else
+        {
+            scal_factor = (src_hsize * 2048) / dst_hsize;
+        }
+    }
+    else
+    {
+        scal_factor = (src_hsize * 2048) / (dst_hsize * 2);
+    }
+    
+    access_integrated_tv_regs(ITV_REG_ID_SCL_HFAC, scal_factor, ITV_CMD_WRITE);
+
+    scal_factor = (src_vsize * 2048) / dst_vsize;
+    access_integrated_tv_regs(ITV_REG_ID_SCL_VFAC, scal_factor, ITV_CMD_WRITE);
+}
+
+
+void set_hdtv_patch_table(int mode_index)
+{
+    switch(tv_setting_info.system)
+    {
+        case TVTYPE_480P:
+            write_integrated_tv_patch_table(ITV_HDTV_PATCH_TABLE[mode_index].std_480p);
+            break;
+            
+        case TVTYPE_576P:
+            write_integrated_tv_patch_table(ITV_HDTV_PATCH_TABLE[mode_index].std_576p);
+            break;
+            
+        case TVTYPE_720P:
+            write_integrated_tv_patch_table(ITV_HDTV_PATCH_TABLE[mode_index].std_720p);
+            break;
+            
+        case TVTYPE_1080I:
+            write_integrated_tv_patch_table(ITV_HDTV_PATCH_TABLE[mode_index].std_1080i);
+            break;
+
+        default:
+            break;
+    }
+}
+
+
+void set_tv_output_patch_table(void)
+{
+    if (tv_setting_info.out_signal == TV_OUTPUT_RGB)
+    {
+        if (tv_setting_info.system == TVTYPE_NTSC)
+        {
+            write_integrated_tv_patch_table(ITV_PATCH_TABLE_RGB_NTSC);
+        }
+        else if (tv_setting_info.system == TVTYPE_PAL)
+        {
+            write_integrated_tv_patch_table(ITV_PATCH_TABLE_RGB_PAL);
+        }
+    }
+    else if (tv_setting_info.out_signal == TV_OUTPUT_YPBPR)
+    {
+        if (tv_setting_info.system == TVTYPE_NTSC)
+        {
+            write_integrated_tv_patch_table(ITV_PATCH_TABLE_YPBPR_NTSC);
+        }
+        else if (tv_setting_info.system == TVTYPE_PAL)
+        {
+            write_integrated_tv_patch_table(ITV_PATCH_TABLE_YPBPR_PAL);
+        }
+    }
+}
+
+void patch_for_macrovision(void)
+{ 
+    /* We should do this patch for this issue:  */
+    /* The H-sync cycle of VT3324A3 integrated TV disappeared when disable TV macrovision. */
+    if (CX700_REVISION_700M2 != chip_info.gfx_chip_revision) /* Macrovision disable. */
+    {
+        switch (tv_setting_info.system)
+        {
+            case TVTYPE_NTSC:
+            case TVTYPE_480P:
+                access_integrated_tv_regs(ITV_REG_ID_PBPR_BLANK_LEVEL, 0x6D, ITV_CMD_WRITE);
+                break;
+                
+            case TVTYPE_PAL:
+            case TVTYPE_576P:
+                access_integrated_tv_regs(ITV_REG_ID_PBPR_BLANK_LEVEL, 0x71, ITV_CMD_WRITE);
+                break;
+
+            case TVTYPE_720P:
+            case TVTYPE_1080I:
+                access_integrated_tv_regs(ITV_REG_ID_PBPR_BLANK_LEVEL, 0x72, ITV_CMD_WRITE);
+                break;
+        }        
+    }
+}
+
+
+void set_integrated_tv_mode(int tv_mode_index)
+{
+    int i, mode_index;
+    unsigned long  *tv_mode_table = NULL;
+    unsigned long  *tv_crtc_table = NULL;
+
+    DEBUG_MSG(KERN_INFO "set_integrated_tv_mode!\n");
+    DEBUG_MSG(KERN_INFO "TV Mode = %d.\n", tv_mode_index);
+    DEBUG_MSG(KERN_INFO "TV Type = %d\n", tv_setting_info.system);
+    DEBUG_MSG(KERN_INFO "TV Output = %d\n", tv_setting_info.out_signal);
+    DEBUG_MSG(KERN_INFO "TV IGA = %d\n", tv_setting_info.iga_path);    
+    
+    /* Try to get the suitable mode table. */
+    for (i=0; i<NUM_TOTAL_INTEGRATEDTV_MODE_TABLE; i++)
+    {
+        mode_index = i;
+
+        if (ITV_MODE_TABLE[i].mode_index == tv_mode_index)
+        {
+            break;
+        }
+    }
+    
+    DEBUG_MSG(KERN_INFO "TV Mode Index to use is: %d.\n" , mode_index);
+
+    switch (tv_setting_info.system)
+    {
+        case TVTYPE_NTSC:
+        {
+            tv_mode_table = ITV_MODE_TABLE[mode_index].std_ntsc;
+            tv_crtc_table = ITV_CRTC_TABLE[mode_index].std_ntsc;
+            break;
+        }
+            
+        case TVTYPE_PAL:
+        {
+            tv_mode_table = ITV_MODE_TABLE[mode_index].std_pal;
+            tv_crtc_table = ITV_CRTC_TABLE[mode_index].std_pal;
+            break;
+        }
+
+        case TVTYPE_480P:
+        {
+            /* For 480P, we use NTSC's mode table, and then do some patches later. */
+            tv_mode_table = ITV_MODE_TABLE[mode_index].std_ntsc;
+            tv_crtc_table = ITV_CRTC_TABLE[mode_index].std_ntsc;
+            break;
+        }
+
+        case TVTYPE_576P:
+        {
+            /* For 576P, we use PAL's mode table, and then do some patches later. */
+            tv_mode_table = ITV_MODE_TABLE[mode_index].std_pal;
+            tv_crtc_table = ITV_CRTC_TABLE[mode_index].std_pal;
+            break;
+        }
+
+        case TVTYPE_720P:
+        {
+            tv_mode_table = ITV_MODE_TABLE[mode_index].std_720p;
+            tv_crtc_table = ITV_CRTC_TABLE[mode_index].std_720p;
+            break;
+        }
+
+        case TVTYPE_1080I:
+        {
+            tv_mode_table = ITV_MODE_TABLE[mode_index].std_1080i;
+            tv_crtc_table = ITV_CRTC_TABLE[mode_index].std_1080i;
+            break;
+        }
+
+        default:
+        {
+            tv_mode_table = ITV_MODE_TABLE[mode_index].std_ntsc;
+            tv_crtc_table = ITV_CRTC_TABLE[mode_index].std_ntsc;
+            break;
+        }
+    }
+   
+    enable_integrated_tv_shadow_reg();
+
+    /* Write TV Encoder Regsiters: */
+
+    /* Common settings by mode: */
+    write_integrated_tv_general_table(ITV_MODE_TABLE_OFFSET, tv_mode_table);
+    
+    /* Write GFX CRTC timing by TV mode. */
+    write_gfx_crtc_timing_for_tv(tv_crtc_table);
+
+    if (tv_setting_info.iga_path == IGA2)
+    {
+        access_integrated_tv_regs(ITV_REG_ID_SRC_SEL, ITV_VALUE_SRC_FROM_IGA2, ITV_CMD_WRITE);
+        
+        write_reg_mask(CR6A, VIACR, 0, BIT2);
+
+        enable_second_display_channel();
+    }
+    else
+    {
+        access_integrated_tv_regs(ITV_REG_ID_SRC_SEL, ITV_VALUE_SRC_FROM_IGA1, ITV_CMD_WRITE);
+        
+        /* For the case: TV IGA1 horizontal total can't be divided by 8. */
+        plus_vck_to_iga1_timing(tv_crtc_table[H_TOTAL_INDEX]);
+    }
+
+    /* Set TV output signal: */
+    set_integrated_tv_output_signal();
+
+    /* Patch for HDTV: */
+    set_hdtv_patch_table(mode_index);
+
+    /* We should modify some settings if use RGB/YPbPr output. */
+    set_tv_output_patch_table();
+
+    /* Update scaling factor: */
+    update_scaling_factor();
+
+    /* Ported from X to support A3*/
+    patch_for_macrovision();
+
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void integrated_tv_sw_reset(void)
+{
+    enable_integrated_tv_shadow_reg();
+
+    access_integrated_tv_regs(ITV_REG_ID_SD_ENABLE, ITV_VALUE_DISABLE, ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_SW_RESET, ITV_VALUE_ENABLE, ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_SW_RESET, ITV_VALUE_DISABLE, ITV_CMD_WRITE);
+
+    delays(50000);  /* We should delay to wait IGA1's VSync. */
+    
+    access_integrated_tv_regs(ITV_REG_ID_SD_ENABLE, ITV_VALUE_ENABLE, ITV_CMD_WRITE);
+
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void integrated_tv_enable(void)
+{
+    /* Turn on DPMS. */
+    write_reg_mask(CR36, VIACR, 0, BIT4+BIT5);
+
+    enable_integrated_tv_shadow_reg();
+
+    /* For the problem TV may crash when we repeat to switch TV type */
+    /* (NTSC->PAL->NTSC->PAL->...), to do the following sequence can help avoiding this problem. */
+    /* 1. Disable Sync Buffer Mode before set mode and disable TV. */
+    /* 2. Enable Sync Buffer Mode before enable TV. */    
+    /* Suggested by HW team. */
+
+    /* Enable Sync Buffer Mode: */
+    access_integrated_tv_regs(ITV_REG_ID_SYNC_BUF_MODE, ITV_VALUE_ENABLE, ITV_CMD_WRITE);
+   
+    /* Enable PK. */
+    access_integrated_tv_regs(ITV_REG_ID_PK_ENABLE, ITV_VALUE_ENABLE, ITV_CMD_WRITE);
+
+    /* Enable SD. */
+    access_integrated_tv_regs(ITV_REG_ID_SD_ENABLE, ITV_VALUE_ENABLE, ITV_CMD_WRITE);
+
+    /* Enable TV encoder. */
+    access_integrated_tv_regs(ITV_REG_ID_TV_ENABLE, ITV_VALUE_ENABLE, ITV_CMD_WRITE);
+
+    /* Change DAC usage. */
+    access_integrated_tv_regs(ITV_REG_ID_PRI_DAC_SEL, ITV_VALUE_DAC_FOR_TV, ITV_CMD_WRITE);
+
+    /* Disable SW Reset. */
+    access_integrated_tv_regs(ITV_REG_ID_SW_RESET, ITV_VALUE_DISABLE, ITV_CMD_WRITE);
+
+    disable_integrated_tv_shadow_reg();
+
+    integrated_tv_sw_reset();
+}
+
+
+void integrated_tv_disable(void)
+{
+    enable_integrated_tv_shadow_reg();
+
+    /* For the problem TV may crash when we repeat to switch TV type */
+    /* (NTSC->PAL->NTSC->PAL->...), to do the following sequence can help avoiding this problem. */
+    /* 1. Disable Sync Buffer Mode before set mode and disable TV. */
+    /* 2. Enable Sync Buffer Mode before enable TV. */    
+    /* Suggested by HW team. */
+
+    /* Enable SW Reset. */
+    access_integrated_tv_regs(ITV_REG_ID_SW_RESET, ITV_VALUE_ENABLE, ITV_CMD_WRITE);
+    
+    /* Disable Sync Buffer Mode: */
+    access_integrated_tv_regs(ITV_REG_ID_SYNC_BUF_MODE, ITV_VALUE_DISABLE, ITV_CMD_WRITE);
+
+    /* Disable PK. */
+    access_integrated_tv_regs(ITV_REG_ID_PK_ENABLE, ITV_VALUE_DISABLE, ITV_CMD_WRITE);
+
+    /* Disable SD. */
+    access_integrated_tv_regs(ITV_REG_ID_SD_ENABLE, ITV_VALUE_DISABLE, ITV_CMD_WRITE);
+
+    /* Disable TV encoder. */
+    access_integrated_tv_regs(ITV_REG_ID_TV_ENABLE, ITV_VALUE_DISABLE, ITV_CMD_WRITE);
+
+    /* Change DAC usage. */
+    access_integrated_tv_regs(ITV_REG_ID_PRI_DAC_SEL, ITV_VALUE_DAC_FOR_CRT, ITV_CMD_WRITE);
+
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void get_integrated_tv_default_status(void)
+{
+    static int scale_value_initialized;
+    enable_integrated_tv_shadow_reg();
+
+    /* Size: */
+    /* The scaling factor level and default value here are not absolute, they can change by request. */
+    tv_setting_info.ScalHLevel = 21;
+    tv_setting_info.ScalVLevel = 15;
+    tv_setting_info.DefaultScalH = 10;
+    tv_setting_info.DefaultScalV = 7;
+    if(!scale_value_initialized) {
+        tv_setting_info.CurrentScalH = tv_setting_info.DefaultScalH;
+        tv_setting_info.CurrentScalV = tv_setting_info.DefaultScalV;
+        scale_value_initialized=1;
+    }
+    tv_setting_info.ScalDegreeH = 5;
+    tv_setting_info.ScalDegreeV = 5;
+
+    /* Positoin: */
+    /* The position level and default value here are not absolute, they can change by request. */
+    tv_setting_info.PositionHLevel = 17;
+    tv_setting_info.PositionVLevel = 13;
+    tv_setting_info.DefaultPositionH = 9;
+    tv_setting_info.DefaultPositionV = 7;
+    tv_setting_info.CurrentPositionH = tv_setting_info.DefaultPositionH;
+    tv_setting_info.CurrentPositionV = tv_setting_info.DefaultPositionV;
+
+    tv_setting_info.DefaultFFilter = 0;
+    tv_setting_info.FFilterLevel = 1;
+    tv_setting_info.CurrentFFilter = tv_setting_info.DefaultFFilter;
+
+    tv_setting_info.DefaultAFFilter = 0;
+    tv_setting_info.AFFilterLevel = 1023;
+    
+    /* Brightness: */
+    tv_setting_info.DefaultBrightness = access_integrated_tv_regs(ITV_REG_ID_BLACK_LEVEL, 0, ITV_CMD_READ);
+    tv_setting_info.BrightnessLevel = 255;  /* 8 bits. */
+    tv_setting_info.CurrentBrightness = tv_setting_info.DefaultBrightness;
+
+    /* Contrast: */
+    tv_setting_info.DefaultContrast= access_integrated_tv_regs(ITV_REG_ID_CONTRAST, 0, ITV_CMD_READ);
+    tv_setting_info.ContrastLevel = 512;  /* 9 bits. */
+    tv_setting_info.CurrentContrast= tv_setting_info.DefaultContrast;
+
+    /* Saturation: */
+    tv_setting_info.DefaultSaturation= access_integrated_tv_regs(ITV_REG_ID_SATURATION, 0, ITV_CMD_READ);
+    tv_setting_info.SaturationLevel = 0x3FFFF;  /* 9+9 bits. */
+    tv_setting_info.CurrentSaturation= tv_setting_info.DefaultSaturation;
+
+    /* Hue: */
+    tv_setting_info.DefaultTINT = access_integrated_tv_regs(ITV_REG_ID_HUE, 0, ITV_CMD_READ);
+    tv_setting_info.TINTLevel = 2047;       /* 11 bits. */
+    tv_setting_info.CurrentTINT = tv_setting_info.DefaultTINT;
+    
+    disable_integrated_tv_shadow_reg();
+}
+
+
+int get_integrated_tv_ffilter_status(int filter_type, int* filter_state)
+{
+    int value = 0;
+    int tmp_filter_state = 0;
+    int tmp_filter_type =0;
+    
+    enable_integrated_tv_shadow_reg();
+
+    /* check if filter is enable */
+    tmp_filter_state = access_integrated_tv_regs(ITV_REG_ID_DE_FLICKER_ENABLE, 0, ITV_CMD_READ);
+ 
+    /* get current filter type */
+    tmp_filter_type = access_integrated_tv_regs(ITV_REG_ID_DE_FLK_NUM, 0, ITV_CMD_READ);
+    
+    if (filter_type == ITV_FILTER_TYPE_NORMAL)
+    {
+        if ((tmp_filter_state == STATE_ON) && (tmp_filter_type == ITV_VALUE_FLK_NUM_WHOLE_IMAGE))
+        {
+            *filter_state = STATE_ON;
+        }
+        else
+        {
+            *filter_state = STATE_OFF;
+        }
+        value = access_integrated_tv_regs(ITV_REG_ID_DF_WT_SEL, 0, ITV_CMD_READ);
+    }
+    else if (filter_type == ITV_FILTER_TYPE_ADAPTIVE)
+    {
+        if ((tmp_filter_state == STATE_ON) && (tmp_filter_type == ITV_VALUE_FLK_NUM_ONE_POINT))
+        {
+            *filter_state = STATE_ON;
+        }
+        else
+        {
+            *filter_state = STATE_OFF;
+        }
+        value = access_integrated_tv_regs(ITV_REG_ID_DE_FLK_THRESHOLD, 0, ITV_CMD_READ);
+    }
+    
+    disable_integrated_tv_shadow_reg();
+
+    return value;
+}
+
+
+
+void get_integrated_tv_pos(u32* current_hpos, u32* current_vpos)
+{        
+    enable_integrated_tv_shadow_reg();
+
+    *current_hpos = access_integrated_tv_regs(ITV_REG_ID_DST_HSD, 0, ITV_CMD_READ);
+    *current_vpos = access_integrated_tv_regs(ITV_REG_ID_DST_VSD, 0, ITV_CMD_READ);
+
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void set_integrated_tv_ffilter_status(int filter_type, int filter_on_off, u32 desired_value)
+{
+    enable_integrated_tv_shadow_reg();
+
+    if (filter_type == ITV_FILTER_TYPE_NORMAL)
+    {
+        if (filter_on_off == ITV_FILTER_ON)
+        {
+            /* Turn on FFilter: */
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLICKER_ENABLE, ITV_VALUE_ENABLE, ITV_CMD_WRITE);
+            access_integrated_tv_regs(ITV_REG_ID_DF_TYPE, ITV_FILTER_TYPE_NORMAL, ITV_CMD_WRITE);
+
+            /* Set the weighting of FFilter : */
+            if (desired_value < 0)
+            {
+                desired_value = 0;
+            }
+
+            if (desired_value > tv_setting_info.FFilterLevel)
+            {
+                desired_value = tv_setting_info.FFilterLevel;
+            }
+
+            access_integrated_tv_regs(ITV_REG_ID_DF_WT_SEL, desired_value, ITV_CMD_WRITE);
+            
+            tv_setting_info.CurrentFFilter = desired_value;
+        }
+        else
+        {
+            /* Turn off FFilter: */
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLICKER_ENABLE, ITV_VALUE_DISABLE, ITV_CMD_WRITE);
+        }
+    }
+    else if (filter_type == ITV_FILTER_TYPE_ADAPTIVE)
+    {
+        if (filter_on_off == ITV_FILTER_ON)
+        {
+            /* Turn on AFFilter: */
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLICKER_ENABLE, ITV_VALUE_ENABLE, ITV_CMD_WRITE);
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLK_NUM, ITV_VALUE_FLK_NUM_ONE_POINT, ITV_CMD_WRITE);
+
+            /* Set threshold of AFFilter : */
+            if (desired_value < 0)
+            {
+                desired_value = 0;
+            }
+            
+            if (desired_value > tv_setting_info.AFFilterLevel)
+            {
+                desired_value = tv_setting_info.AFFilterLevel;
+            }
+
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLK_THRESHOLD, desired_value, ITV_CMD_WRITE);
+        }
+        else
+        {
+            /* Turn off AFFilter: */
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLK_NUM, ITV_VALUE_FLK_NUM_WHOLE_IMAGE, ITV_CMD_WRITE);
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLK_THRESHOLD, 0, ITV_CMD_WRITE);
+            access_integrated_tv_regs(ITV_REG_ID_DE_FLICKER_ENABLE, ITV_VALUE_DISABLE, ITV_CMD_WRITE);
+        }
+    }
+
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void set_integrated_tv_hue(u32 desired_value)
+{
+    enable_integrated_tv_shadow_reg();
+    access_integrated_tv_regs(ITV_REG_ID_HUE, desired_value, ITV_CMD_WRITE);
+    tv_setting_info.CurrentTINT = desired_value;
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void set_integrated_tv_brightness(u32 desired_value)
+{
+    enable_integrated_tv_shadow_reg();
+    access_integrated_tv_regs(ITV_REG_ID_BLACK_LEVEL, desired_value, ITV_CMD_WRITE);
+    tv_setting_info.CurrentBrightness = desired_value;
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void set_integrated_tv_contrast(u32 desired_value)
+{
+    enable_integrated_tv_shadow_reg();
+    access_integrated_tv_regs(ITV_REG_ID_CONTRAST, desired_value, ITV_CMD_WRITE);
+    tv_setting_info.CurrentContrast = desired_value;
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void set_integrated_tv_saturation(u32 desired_value)
+{
+    enable_integrated_tv_shadow_reg();
+    access_integrated_tv_regs(ITV_REG_ID_SATURATION, desired_value, ITV_CMD_WRITE);
+    tv_setting_info.CurrentSaturation = desired_value;
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void set_integrated_tv_pos(u32 desired_hpos, u32 desired_vpos)
+{
+    u32 dst_hpos, dst_vpos;
+    
+    enable_integrated_tv_shadow_reg();
+
+    dst_hpos = access_integrated_tv_regs(ITV_REG_ID_DST_HSD, 0, ITV_CMD_READ);
+    dst_vpos = access_integrated_tv_regs(ITV_REG_ID_DST_VSD, 0, ITV_CMD_READ);
+
+    dst_hpos = dst_hpos + (desired_hpos - tv_setting_info.CurrentPositionH);
+    dst_vpos = dst_vpos - (desired_vpos - tv_setting_info.CurrentPositionV);
+
+    access_integrated_tv_regs(ITV_REG_ID_DST_HSD, dst_hpos, ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_DST_VSD, dst_vpos, ITV_CMD_WRITE);
+
+    tv_setting_info.CurrentPositionH = desired_hpos;
+    tv_setting_info.CurrentPositionV = desired_vpos;
+
+    disable_integrated_tv_shadow_reg();
+}
+
+
+void set_integrated_tv_size(u32 desired_hsize, u32 desired_vsize)
+{ 
+    u32 dst_hsize, dst_vsize;
+    DEBUG_MSG("set integrated TV H:%d V:%d", desired_hsize, desired_vsize);
+    
+    enable_integrated_tv_shadow_reg();
+    
+    dst_hsize = access_integrated_tv_regs(ITV_REG_ID_DST_HSIZE, 0, ITV_CMD_READ);
+    dst_vsize = access_integrated_tv_regs(ITV_REG_ID_DST_VSIZE, 0, ITV_CMD_READ);
+
+    dst_hsize = dst_hsize + tv_setting_info.ScalDegreeH * (desired_hsize - tv_setting_info.CurrentScalH);
+    dst_vsize = dst_vsize + tv_setting_info.ScalDegreeV * (desired_vsize - tv_setting_info.CurrentScalV);
+
+    access_integrated_tv_regs(ITV_REG_ID_DST_HSIZE, dst_hsize, ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_DST_VSIZE, dst_vsize, ITV_CMD_WRITE);
+
+    /* Update scaling factor: */
+    update_scaling_factor();
+    
+    tv_setting_info.CurrentScalH = desired_hsize;
+    tv_setting_info.CurrentScalV = desired_vsize;
+    disable_integrated_tv_shadow_reg();
+}
+
+
+int integrated_tv_sense(void)
+{
+    u8 cr30, cr37, cr43, rgb_dac_status;
+    u32 tv3f, rgb_status, tv_encoder_status, dac_status;
+    int sense_status;
+
+    enable_integrated_tv_shadow_reg();
+
+    if (g_first_time_to_sense)
+    {
+        /* Set TV mode (arbitrary) at least once before sense TV. */
+        write_integrated_tv_general_table(ITV_INIT_TABLE_OFFSET, ITV_INIT_TABLE_VALUE);
+        write_integrated_tv_general_table(ITV_MODE_TABLE_OFFSET, ITV_MODE_TABLE_NTSC_640x480);
+        g_first_time_to_sense = FALSE;
+    }
+
+    /* Saved for restore later: */
+    cr30 = read_reg(VIACR, CR30);
+    cr37 = read_reg(VIACR, CR37);
+    cr43 = read_reg(VIACR, CR43);
+    rgb_dac_status = read_reg(VIASR, SR5E);
+    tv3f = access_integrated_tv_regs(ITV_REG_ID_TV_SENSE_DATA, 0, ITV_CMD_READ);
+    tv_encoder_status = access_integrated_tv_regs(ITV_REG_ID_TV_ENABLE, 0, ITV_CMD_READ);
+    dac_status = access_integrated_tv_regs(ITV_REG_ID_PRI_DAC_SEL, 0, ITV_CMD_READ);
+
+    /* To sense TV, we should: */
+    /* 1. Set CR30[4:3]=01, CR37[2:0]=100, CR37[3]=0, CR43[5:4]=01 and TV.3F[7:0]=42h. */
+    /* 2. Enable TV DAC R/G/B. */
+    /* 3. Enable TV encoder. */
+    /* 4. Change primary DAC to TV. */
+    write_reg_mask(CR30, VIACR, BIT3, BIT4+BIT3);
+    write_reg_mask(CR37, VIACR, BIT2, BIT3+BIT2+BIT1+BIT0);
+    write_reg_mask(CR43, VIACR, BIT4, BIT5+BIT4);
+    write_reg_mask(SR5E, VIASR, 0, BIT3+BIT2+BIT1);
+    access_integrated_tv_regs(ITV_REG_ID_TV_SENSE_DATA, 0x42, ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_TV_ENABLE, ITV_VALUE_ENABLE, ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_PRI_DAC_SEL, ITV_VALUE_DAC_FOR_TV, ITV_CMD_WRITE);
+    
+    /* Start to sense: */
+    access_integrated_tv_regs(ITV_REG_ID_TV_SENSE, ITV_VALUE_MANUAL_SENSE, ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_TV_SENSE, ITV_VALUE_NO_SENSE, ITV_CMD_WRITE);
+
+    /* Restore: */
+    access_integrated_tv_regs(ITV_REG_ID_PRI_DAC_SEL, dac_status, ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_TV_ENABLE, tv_encoder_status, ITV_CMD_WRITE);
+    access_integrated_tv_regs(ITV_REG_ID_TV_SENSE_DATA, tv3f, ITV_CMD_WRITE);
+    write_reg(CR30, VIACR, cr30);
+    write_reg(CR37, VIACR, cr37);
+    write_reg(CR43, VIACR, cr43);
+    write_reg(SR5E, VIASR, rgb_dac_status);
+
+    /* Get sense result: */    
+    sense_status = access_integrated_tv_regs(ITV_REG_ID_TV_SENSE_STATUS, 0, ITV_CMD_READ);
+    rgb_status = access_integrated_tv_regs(ITV_REG_ID_TV_SENSE_RGB_STATUS, 0, ITV_CMD_READ);
+
+    /* Check connected TV output: */
+    if (!tv_setting_info.out_signal)
+    {
+        switch(rgb_status)
+        {
+            case ITV_VALUE_DAC_R | ITV_VALUE_DAC_G:
+            {
+                tv_setting_info.out_signal= TV_OUTPUT_SVIDEO;
+                break;
+            }
+
+            case ITV_VALUE_DAC_B:
+            {
+                tv_setting_info.out_signal = TV_OUTPUT_COMPOSITE;
+                break;
+            }
+
+            case ITV_VALUE_DAC_R | ITV_VALUE_DAC_G | ITV_VALUE_DAC_B:
+            {
+                tv_setting_info.out_signal = TV_OUTPUT_RGB;
+                break;
+            }
+
+            default:
+            {
+                tv_setting_info.out_signal = TV_OUTPUT_COMPOSITE;
+                break;
+            }
+        }
+    }
+
+    disable_integrated_tv_shadow_reg();
+
+    return sense_status;
+}
+
+
+int init_integrated_tv_regs(void)
+{
+    u32 mask = 0x1FFFFFF0;  /* [28:4] */
+    u32 buf_start_address;
+    u32 buffer_size = 0x80000;
+    u8  offset = 0;
+    unsigned char* mmio_base;
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+    buf_start_address = viafbinfo.memsize - INTEGRATED_TV_BUFFER_SIZE;
+    
+    viafbinfo.integrated_tv_map_base = (unsigned int)ioremap_nocache(viafbinfo.mmio_base  + VIA_MMIO_INTEGRATED_TV_BASE, VIA_MMIO_INTEGRATED_TV_SIZE);
+
+    if (!viafbinfo.integrated_tv_map_base)
+    {        
+        return FAIL;
+    }
+
+    mmio_base = (unsigned char*)viafbinfo.integrated_tv_map_base;
+#else
+    buf_start_address = parinfo.fbmem_free - INTEGRATED_TV_BUFFER_SIZE;
+    parinfo.fbmem_free = parinfo.fbmem_free - INTEGRATED_TV_BUFFER_SIZE;
+    parinfo.fbmem_used += INTEGRATED_TV_BUFFER_SIZE;
+
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
+    parinfo.integrated_tv_map_base = ioremap_nocache(parinfo.mmio_base + VIA_MMIO_INTEGRATED_TV_BASE, VIA_MMIO_INTEGRATED_TV_SIZE);
+#else
+    parinfo.integrated_tv_map_base = (unsigned int)ioremap_nocache(parinfo.mmio_base + VIA_MMIO_INTEGRATED_TV_BASE, VIA_MMIO_INTEGRATED_TV_SIZE);
+#endif
+
+    if (!parinfo.integrated_tv_map_base)
+    {        
+        return FAIL;
+    }
+
+    mmio_base = (unsigned char*)parinfo.integrated_tv_map_base;
+#endif
+
+    enable_integrated_tv_shadow_reg();
+
+    /* Clear all: */
+    while (offset < 0xF0)
+    {
+        write_integrated_tv_reg32(mmio_base, offset, 0);
+        offset = offset + 4;
+    }
+    
+    /* Write Source Buffer 0~3 Base Address: */
+    write_integrated_tv_reg_mask32(mmio_base, 0x04, mask, buf_start_address);
+
+    buf_start_address = buf_start_address + buffer_size;
+    write_integrated_tv_reg_mask32(mmio_base, 0x08, mask, buf_start_address);
+
+    buf_start_address = buf_start_address + buffer_size;
+    write_integrated_tv_reg_mask32(mmio_base, 0x0C, mask, buf_start_address);
+
+    buf_start_address = buf_start_address + buffer_size;
+    write_integrated_tv_reg_mask32(mmio_base, 0x10, mask, buf_start_address);
+    
+    /* Write Destination Even and Odd Buffer Base Address: */
+    buf_start_address = buf_start_address + buffer_size;
+    write_integrated_tv_reg_mask32(mmio_base, 0x2C, mask, buf_start_address);
+
+    buf_start_address = buf_start_address + buffer_size;
+    write_integrated_tv_reg_mask32(mmio_base, 0x30, mask, buf_start_address);
+
+    /* Other initialize: */
+    write_integrated_tv_general_table(ITV_INIT_TABLE_OFFSET, ITV_INIT_TABLE_VALUE);
+
+    disable_integrated_tv_shadow_reg();
+
+    return OK;
+}
+
+
+int integrated_tv_encoder_identify(void)
+{
+    if (chip_info.gfx_chip_name == UNICHROME_CX700)
+    {
+        return OK;
+    }
+    else
+    {
+        return FAIL;
+    }
+}
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/IntegratedTV.h linux-2.6.21-rc7.viafb/drivers/video/via/IntegratedTV.h
--- linux-2.6.21-rc7/drivers/video/via/IntegratedTV.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/IntegratedTV.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,107 @@
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
+
+#ifndef _INTEGRATEDTV_H_
+#define _INTEGRATEDTV_H_ 1
+
+
+/* Registers IDs: */
+/* The definition value has 4 bits: 2 bits IO address + 2 bits offset. */
+/* ex. 0x0018 means bits 18 of IO Address 00, it is TV source selection. */
+#define ITV_REG_ID_PK_ENABLE            0x0000    /* PK enable. */
+#define ITV_REG_ID_SRC_SEL              0x0018    /* Source from IGA1 or IGA2. */
+#define ITV_REG_ID_SW_RESET             0x0020    /* SW reset. */
+#define ITV_REG_ID_SYNC_BUF_MODE        0x0030    /* Synchronous mode. */
+#define ITV_REG_ID_SD_ENABLE            0x0031    /* Scaler and Deflicker enable. */
+#define ITV_REG_ID_SRC_VSIZE            0x1800    /* Source image vertical pixels. */
+#define ITV_REG_ID_SRC_HSIZE            0x1811    /* Source image horizontal pixels. */
+#define ITV_REG_ID_DE_FLK_THRESHOLD     0x2011    /* Adative flicker filter threshold. */
+#define ITV_REG_ID_SCL_VFAC             0x2400    /* Vertical scaling factor. */
+#define ITV_REG_ID_DE_FLK_NUM           0x2413    /* Adative flicker filter. */
+#define ITV_REG_ID_DF_WT_SEL            0x2414    /* De-flicker weighting selection. */
+#define ITV_REG_ID_DF_TYPE              0x2415    /* De-flicker type. */
+#define ITV_REG_ID_SCL_HFAC             0x2416    /* Horizontal scaling factor. */
+#define ITV_REG_ID_DE_FLICKER_ENABLE    0x2429    /* De-flicker enable. */
+#define ITV_REG_ID_DST_VSIZE            0x2800    /* Destination image vertical pixels. */
+#define ITV_REG_ID_DST_HSIZE            0x2811    /* Destination image horizontal pixels. */
+#define ITV_REG_ID_TV_ENABLE            0x3800    /* TV enable. */
+#define ITV_REG_ID_OUTPUT_SEL           0x3828    /* TV DAC output selection. */
+#define ITV_REG_ID_TV_SENSE             0x3C14    /* TV sense enable. */
+#define ITV_REG_ID_TV_SENSE_DATA        0x3C24    /* TV sense data. */
+#define ITV_REG_ID_DST_HSD              0x4821    /* Destination image horizontal start display */
+#define ITV_REG_ID_DST_VSD              0x4C23    /* Destination image vertical start display */
+#define ITV_REG_ID_SATURATION           0x5000    /* Saturation adjustment. */
+#define ITV_REG_ID_CONTRAST             0x5400    /* Contrast adjustment. */
+#define ITV_REG_ID_BLACK_LEVEL          0x5423    /* Brightness adjustment. */
+#define ITV_REG_ID_HUE                  0x6000    /* Hue adjustment. */
+#define ITV_REG_ID_PRI_DAC_SEL          0x6C12    /* Primary DAC for CRT or TV. */
+#define ITV_REG_ID_TV_SENSE_STATUS      0xE402    /* TV sense status. */
+#define ITV_REG_ID_PBPR_BLANK_LEVEL     0xE800    /* Blank Level for Pb and Pr. For VT3324 A3. */
+#define ITV_REG_ID_TV_SENSE_RGB_STATUS  0xE828    /* TV sense R/G/B status. */
+
+#define ITV_CMD_READ                0
+#define ITV_CMD_WRITE               1
+
+#define ITV_VALUE_DISABLE           0
+#define ITV_VALUE_ENABLE            1
+
+#define ITV_VALUE_SRC_FROM_IGA1     0
+#define ITV_VALUE_SRC_FROM_IGA2     1
+
+#define ITV_VALUE_DAC_FOR_CRT       0
+#define ITV_VALUE_DAC_FOR_TV        1
+
+#define ITV_VALUE_OUTPUT_SC         0x00    /* S-Video or Composite */
+#define ITV_VALUE_OUTPUT_RGB        0x02    /* RGB */
+#define ITV_VALUE_OUTPUT_YPbPr      0x03    /* YPbPr */
+
+#define ITV_VALUE_FLK_NUM_WHOLE_IMAGE   0
+#define ITV_VALUE_FLK_NUM_ONE_POINT     1
+
+#define ITV_VALUE_NO_SENSE          0x00
+#define ITV_VALUE_MANUAL_SENSE      0x02
+#define ITV_VALUE_AUTO_SENSE        0x03
+
+#define ITV_VALUE_TV_UNCONNECTED    0
+#define ITV_VALUE_TV_CONNECTED      1
+
+#define ITV_VALUE_DAC_R             4
+#define ITV_VALUE_DAC_G             2
+#define ITV_VALUE_DAC_B             1
+
+#define ITV_FILTER_TYPE_NORMAL      0
+#define ITV_FILTER_TYPE_IIR         1
+#define ITV_FILTER_TYPE_ADAPTIVE    2
+#define ITV_FILTER_TYPE_NONE        3
+
+#define ITV_FILTER_OFF              0
+#define ITV_FILTER_ON               1
+
+#define INTEGRATED_TV_BUFFER_SIZE   0x300000     /* bytes */ /* We reserve 3MB now. */
+
+#define VIA_MMIO_INTEGRATED_TV_BASE 0xC000
+#define VIA_MMIO_INTEGRATED_TV_SIZE 256
+
+#endif
+
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/Makefile linux-2.6.21-rc7.viafb/drivers/video/via/Makefile
--- linux-2.6.21-rc7/drivers/video/via/Makefile 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/Makefile 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,7 @@
+#
+# Makefile for the VIA framebuffer driver (for Linux Kernel 2.6)
+#
+                                                                                
+obj-$(CONFIG_FB_VIA) += viafb.o
+
+viafb-objs := viafbdev.o hw.o iface.o tv.o via_i2c.o vt1622.o vt1622a.o dvi.o lcd.o vt1625.o ioctl.o accel.o via_utility.o IntegratedTV.o vt1636.o
diff -Nur linux-2.6.21-rc7/drivers/video/via/share.h linux-2.6.21-rc7.viafb/drivers/video/via/share.h
--- linux-2.6.21-rc7/drivers/video/via/share.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/share.h 2007-04-26 19:58:40.000000000 -0400
@@ -0,0 +1,771 @@
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
+
+#ifndef __SHARE_H__
+#define __SHARE_H__
+
+#include <linux/version.h>
+
+/* Define Return Value */
+#define FAIL        -1
+#define OK          1
+
+/* Define Boolean Value */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
+#ifndef bool
+typedef int bool;
+#endif
+#endif
+
+#ifndef TRUE
+#define TRUE 1
+#endif
+
+#ifndef FALSE
+#define FALSE 0
+#endif
+
+#ifndef NULL
+#define NULL 0
+#endif
+
+/* Define Bit Field */
+#define BIT0    0x01
+#define BIT1    0x02
+#define BIT2    0x04
+#define BIT3    0x08
+#define BIT4    0x10
+#define BIT5    0x20
+#define BIT6    0x40
+#define BIT7    0x80
+
+/* Video Memory Size */
+#define VIDEO_MEMORY_SIZE_16M    0x1000000
+
+/* Definition Mode Index */
+#define     VIA_RES_640X480                 0
+#define     VIA_RES_800X600                 1
+#define     VIA_RES_1024X768                2
+#define     VIA_RES_1152X864                3
+#define     VIA_RES_1280X1024               4
+#define     VIA_RES_1600X1200               5
+#define     VIA_RES_1440X1050               6
+#define     VIA_RES_1280X768                7
+#define     VIA_RES_1280X960                8
+#define     VIA_RES_1920X1440               9
+#define     VIA_RES_848X480                 10
+#define     VIA_RES_1400X1050               11
+#define     VIA_RES_720X480                 12
+#define     VIA_RES_720X576                 13
+#define     VIA_RES_1024X512                14
+#define     VIA_RES_856X480                 15
+#define     VIA_RES_1024X576                16
+#define     VIA_RES_640X400                 17
+#define     VIA_RES_1280X720                18
+#define     VIA_RES_1920X1080               19
+#define     VIA_RES_800X480                 20
+#define     VIA_RES_1368X768                21
+#define     VIA_RES_1024X600                22
+#define     VIA_RES_1280X800                23
+#define     VIA_RES_INVALID                 255
+
+
+/* standard VGA IO port */
+#define VIARMisc    0x3CC
+#define VIAWMisc    0x3C2
+#define VIAStatus   0x3DA
+#define VIACR       0x3D4
+#define VIASR       0x3C4
+#define VIAGR       0x3CE
+#define VIAAR       0x3C0
+
+#define StdCR       0x19
+#define StdSR       0x04
+#define StdGR       0x09
+#define StdAR       0x14
+
+#define PatchCR     11
+
+/* Display path */
+#define IGA1        1
+#define IGA2        2
+#define IGA1_IGA2   3
+
+/* Define Color Depth  */
+#define MODE_8BPP       1
+#define MODE_16BPP      2
+#define MODE_32BPP      4
+
+#define GR20    0x20
+#define GR21    0x21
+#define GR22    0x22
+
+
+/* Sequencer Registers */
+#define SR01    0x01
+#define SR10    0x10
+#define SR12    0x12
+#define SR15    0x15
+#define SR16    0x16
+#define SR17    0x17
+#define SR18    0x18
+#define SR1B    0x1B
+#define SR1A    0x1A
+#define SR1C    0x1C
+#define SR1D    0x1D
+#define SR1E    0x1E
+#define SR1F    0x1F
+#define SR20    0x20
+#define SR21    0x21
+#define SR22    0x22
+#define SR2A    0x2A
+#define SR2D    0x2D
+#define SR2E    0x2E
+
+#define SR30    0x30
+#define SR39    0x39
+#define SR3D    0x3D
+#define SR3E    0x3E
+#define SR3F    0x3F
+#define SR40    0x40
+#define SR43    0x43
+#define SR44    0x44
+#define SR45    0x45
+#define SR46    0x46
+#define SR47    0x47
+#define SR48    0x48
+#define SR49    0x49
+#define SR4A    0x4A
+#define SR4B    0x4B
+#define SR4C    0x4C
+#define SR52    0x52
+#define SR5E    0x5E
+#define SR65    0x65
+
+
+/* CRT Controller Registers */
+#define CR00    0x00
+#define CR01    0x01
+#define CR02    0x02
+#define CR03    0x03
+#define CR04    0x04
+#define CR05    0x05
+#define CR06    0x06
+#define CR07    0x07
+#define CR08    0x08
+#define CR09    0x09
+#define CR0A    0x0A
+#define CR0B    0x0B
+#define CR0C    0x0C
+#define CR0D    0x0D
+#define CR0E    0x0E
+#define CR0F    0x0F
+#define CR10    0x10
+#define CR11    0x11
+#define CR12    0x12
+#define CR13    0x13
+#define CR14    0x14
+#define CR15    0x15
+#define CR16    0x16
+#define CR17    0x17
+#define CR18    0x18
+
+/* Extend CRT Controller Registers */
+#define CR30    0x30
+#define CR31    0x31
+#define CR32    0x32
+#define CR33    0x33
+#define CR34    0x34
+#define CR35    0x35
+#define CR36    0x36
+#define CR37    0x37
+#define CR38    0x38
+#define CR39    0x39
+#define CR3A    0x3A
+#define CR3B    0x3B
+#define CR3C    0x3C
+#define CR3D    0x3D
+#define CR3E    0x3E
+#define CR3F    0x3F
+#define CR40    0x40
+#define CR41    0x41
+#define CR42    0x42
+#define CR43    0x43
+#define CR44    0x44
+#define CR45    0x45
+#define CR46    0x46
+#define CR47    0x47
+#define CR48    0x48
+#define CR49    0x49
+#define CR4A    0x4A
+#define CR4B    0x4B
+#define CR4C    0x4C
+#define CR4D    0x4D
+#define CR4E    0x4E
+#define CR4F    0x4F
+#define CR50    0x50
+#define CR51    0x51
+#define CR52    0x52
+#define CR53    0x53
+#define CR54    0x54
+#define CR55    0x55
+#define CR56    0x56
+#define CR57    0x57
+#define CR58    0x58
+#define CR59    0x59
+#define CR5A    0x5A
+#define CR5B    0x5B
+#define CR5C    0x5C
+#define CR5D    0x5D
+#define CR5E    0x5E
+#define CR5F    0x5F
+#define CR60    0x60
+#define CR61    0x61
+#define CR62    0x62
+#define CR63    0x63
+#define CR64    0x64
+#define CR65    0x65
+#define CR66    0x66
+#define CR67    0x67
+#define CR68    0x68
+#define CR69    0x69
+#define CR6A    0x6A
+#define CR6B    0x6B
+#define CR6C    0x6C
+#define CR6D    0x6D
+#define CR6E    0x6E
+#define CR6F    0x6F
+#define CR70    0x70
+#define CR71    0x71
+#define CR72    0x72
+#define CR73    0x73
+#define CR74    0x74
+#define CR75    0x75
+#define CR76    0x76
+#define CR77    0x77
+#define CR78    0x78
+#define CR79    0x79
+#define CR7A    0x7A
+#define CR7B    0x7B
+#define CR7C    0x7C
+#define CR7D    0x7D
+#define CR7E    0x7E
+#define CR7F    0x7F
+#define CR80    0x80
+#define CR81    0x81
+#define CR82    0x82
+#define CR83    0x83
+#define CR84    0x84
+#define CR85    0x85
+#define CR86    0x86
+#define CR87    0x87
+#define CR88    0x88
+#define CR89    0x89
+#define CR8A    0x8A
+#define CR8B    0x8B
+#define CR8C    0x8C
+#define CR8D    0x8D
+#define CR8E    0x8E
+#define CR8F    0x8F
+#define CR90    0x90
+#define CR91    0x91
+#define CR92    0x92
+#define CR93    0x93
+#define CR94    0x94
+#define CR95    0x95
+#define CR96    0x96
+#define CR97    0x97
+#define CR98    0x98
+#define CR99    0x99
+#define CR9A    0x9A
+#define CR9B    0x9B
+#define CR9C    0x9C
+#define CR9D    0x9D
+#define CR9E    0x9E
+#define CR9F    0x9F
+#define CRA0    0xA0
+#define CRA1    0xA1
+#define CRA2    0xA2
+#define CRA3    0xA3
+#define CRD2    0xD2
+#define CRD3    0xD3
+#define CRD4    0xD4
+
+/* LUT Table*/
+#define LUT_DATA             0x3C9        /* DACDATA */
+#define LUT_INDEX_READ       0x3C7        /* DACRX */
+#define LUT_INDEX_WRITE      0x3C8        /* DACWX */
+#define DACMASK              0x3C6
+
+/* Definition Device */
+#define DEVICE_CRT  0x01
+#define DEVICE_TV   0x02
+#define DEVICE_DVI  0x03
+#define DEVICE_LCD  0x04
+
+/* Device output interface */
+#define INTERFACE_NONE          0x00
+#define INTERFACE_ANALOG_RGB    0x01
+#define INTERFACE_DVP0          0x02
+#define INTERFACE_DVP1          0x03
+#define INTERFACE_DFP_HIGH      0x04
+#define INTERFACE_DFP_LOW       0x05
+#define INTERFACE_DFP           0x06
+#define INTERFACE_LVDS0         0x07
+#define INTERFACE_LVDS1         0x08
+#define INTERFACE_LVDS0LVDS1    0x09
+#define INTERFACE_TMDS          0x0A
+
+/* Hardware layout for internal LVDS/TMDS. */
+#define HW_LAYOUT_LCD_ONLY      0x01
+#define HW_LAYOUT_DVI_ONLY      0x02
+#define HW_LAYOUT_LCD_DVI       0x03
+#define HW_LAYOUT_LCD1_LCD2     0x04
+#define HW_LAYOUT_LCD_EXTERNAL_LCD2 0x10
+
+/* Definition Refresh Rate */
+#define REFRESH_60      60
+#define REFRESH_75      75
+#define REFRESH_85      85
+#define REFRESH_100     100
+#define REFRESH_120     120
+
+/* Definition Sync Polarity */
+#define NEGATIVE        1
+#define POSITIVE        0
+
+/* 640x480@60 Sync Polarity (VESA Mode) */
+#define M640X480_R60_HSP        NEGATIVE            
+#define M640X480_R60_VSP        NEGATIVE
+
+/* 640x480@75 Sync Polarity (VESA Mode) */
+#define M640X480_R75_HSP        NEGATIVE
+#define M640X480_R75_VSP        NEGATIVE
+
+/* 640x480@85 Sync Polarity (VESA Mode) */
+#define M640X480_R85_HSP        NEGATIVE
+#define M640X480_R85_VSP        NEGATIVE
+
+/* 640x480@100 Sync Polarity (GTF Mode) */
+#define M640X480_R100_HSP       NEGATIVE
+#define M640X480_R100_VSP       POSITIVE
+
+/* 640x480@120 Sync Polarity (GTF Mode) */
+#define M640X480_R120_HSP       NEGATIVE
+#define M640X480_R120_VSP       POSITIVE
+
+/* 720x480@60 Sync Polarity  (GTF Mode) */
+#define M720X480_R60_HSP        NEGATIVE            
+#define M720X480_R60_VSP        POSITIVE
+
+/* 720x576@60 Sync Polarity  (GTF Mode) */
+#define M720X576_R60_HSP        NEGATIVE            
+#define M720X576_R60_VSP        POSITIVE
+
+/* 800x600@60 Sync Polarity (VESA Mode) */
+#define M800X600_R60_HSP        POSITIVE            
+#define M800X600_R60_VSP        POSITIVE
+
+/* 800x600@75 Sync Polarity (VESA Mode) */
+#define M800X600_R75_HSP        POSITIVE            
+#define M800X600_R75_VSP        POSITIVE
+
+/* 800x600@85 Sync Polarity (VESA Mode) */
+#define M800X600_R85_HSP        POSITIVE            
+#define M800X600_R85_VSP        POSITIVE
+
+/* 800x600@100 Sync Polarity (GTF Mode) */
+#define M800X600_R100_HSP       NEGATIVE            
+#define M800X600_R100_VSP       POSITIVE
+
+/* 800x600@120 Sync Polarity (GTF Mode) */
+#define M800X600_R120_HSP       NEGATIVE            
+#define M800X600_R120_VSP       POSITIVE
+
+/* 800x480@60 Sync Polarity  (GTF Mode) */
+#define M800X480_R60_HSP        NEGATIVE            
+#define M800X480_R60_VSP        POSITIVE
+
+/* 848x480@60 Sync Polarity  (GTF Mode) */
+#define M848X480_R60_HSP        NEGATIVE            
+#define M848X480_R60_VSP        POSITIVE
+
+/* 852x480@60 Sync Polarity  (GTF Mode) */
+#define M852X480_R60_HSP        NEGATIVE            
+#define M852X480_R60_VSP        POSITIVE
+
+/* 1024x512@60 Sync Polarity (GTF Mode) */
+#define M1024X512_R60_HSP       NEGATIVE            
+#define M1024X512_R60_VSP       POSITIVE
+
+/* 1024x600@60 Sync Polarity (GTF Mode) */
+#define M1024X600_R60_HSP       NEGATIVE            
+#define M1024X600_R60_VSP       POSITIVE
+
+
+/* 1024x768@60 Sync Polarity (VESA Mode) */ 
+#define M1024X768_R60_HSP       NEGATIVE            
+#define M1024X768_R60_VSP       NEGATIVE
+
+/* 1024x768@75 Sync Polarity (VESA Mode) */
+#define M1024X768_R75_HSP       POSITIVE            
+#define M1024X768_R75_VSP       POSITIVE
+
+/* 1024x768@85 Sync Polarity (VESA Mode) */ 
+#define M1024X768_R85_HSP       POSITIVE            
+#define M1024X768_R85_VSP       POSITIVE
+
+/* 1024x768@100 Sync Polarity (GTF Mode) */
+#define M1024X768_R100_HSP      NEGATIVE            
+#define M1024X768_R100_VSP      POSITIVE
+
+/* 1152x864@75 Sync Polarity (VESA Mode) */
+#define M1152X864_R75_HSP       POSITIVE            
+#define M1152X864_R75_VSP       POSITIVE
+
+/* 1280x720@60 Sync Polarity  (GTF Mode) */
+#define M1280X720_R60_HSP       NEGATIVE            
+#define M1280X720_R60_VSP       POSITIVE
+
+/* 1280x768@60 Sync Polarity  (GTF Mode) */
+#define M1280X768_R60_HSP       NEGATIVE            
+#define M1280X768_R60_VSP       POSITIVE
+
+/* 1280x800@60 Sync Polarity  (GTF Mode) */
+#define M1280X800_R60_HSP       NEGATIVE
+#define M1280X800_R60_VSP       POSITIVE
+
+/* 1280x960@60 Sync Polarity (VESA Mode) */
+#define M1280X960_R60_HSP       POSITIVE            
+#define M1280X960_R60_VSP       POSITIVE
+
+/* 1280x1024@60 Sync Polarity (VESA Mode) */
+#define M1280X1024_R60_HSP      POSITIVE                   
+#define M1280X1024_R60_VSP      POSITIVE
+
+/* 1368x768@60 Sync Polarity (VESA Mode) */
+#define M1368X768_R60_HSP       NEGATIVE
+#define M1368X768_R60_VSP       POSITIVE
+
+/* 1280x1024@75 Sync Polarity (VESA Mode) */
+#define M1280X1024_R75_HSP      POSITIVE                   
+#define M1280X1024_R75_VSP      POSITIVE 
+
+/* 1280x1024@85 Sync Polarity (VESA Mode) */
+#define M1280X1024_R85_HSP      POSITIVE                   
+#define M1280X1024_R85_VSP      POSITIVE
+
+/* 1440x1050@60 Sync Polarity (GTF Mode) */
+#define M1440X1050_R60_HSP      NEGATIVE                   
+#define M1440X1050_R60_VSP      POSITIVE  
+
+/* 1600x1200@60 Sync Polarity (VESA Mode) */
+#define M1600X1200_R60_HSP      POSITIVE                  
+#define M1600X1200_R60_VSP      POSITIVE       
+
+/* 1600x1200@75 Sync Polarity (VESA Mode) */    
+#define M1600X1200_R75_HSP      POSITIVE                  
+#define M1600X1200_R75_VSP      POSITIVE      
+
+/* 1920x1080@60 Sync Polarity (GTF Mode) */
+#define M1920X1080_R60_HSP      NEGATIVE            
+#define M1920X1080_R60_VSP      POSITIVE
+
+/* 1920x1440@60 Sync Polarity (VESA Mode) */
+#define M1920X1440_R60_HSP      NEGATIVE            
+#define M1920X1440_R60_VSP      POSITIVE 
+
+/* 1920x1440@75 Sync Polarity (VESA Mode) */
+#define M1920X1440_R75_HSP      NEGATIVE            
+#define M1920X1440_R75_VSP      POSITIVE
+
+#if 0
+/* 1400x1050@60 Sync Polarity (VESA Mode) */
+#define M1400X1050_R60_HSP      NEGATIVE
+#define M1400X1050_R60_VSP      NEGATIVE
+#endif
+
+/* 1400x1050@60 Sync Polarity (GTF Mode) */
+#define M1400X1050_R60_HSP      NEGATIVE
+#define M1400X1050_R60_VSP      POSITIVE
+
+
+/* define PLL index: */
+#define CLK_25_175M     25175000
+#define CLK_26_880M     26880000
+#define CLK_29_581M     29581000
+#define CLK_31_490M     31490000
+#define CLK_31_500M     31500000
+#define CLK_31_728M     31728000
+#define CLK_32_668M     32688000
+#define CLK_36_000M     36000000
+#define CLK_40_000M     40000000
+#define CLK_41_291M     41291000
+#define CLK_43_163M     43163000
+/* #define CLK_46_996M     46996000 */
+#define CLK_48_875M     48875000
+#define CLK_49_500M     49500000
+#define CLK_52_406M     52406000
+#define CLK_56_250M     56250000
+#define CLK_65_000M     65000000
+#define CLK_68_179M     68179000
+#define CLK_78_750M     78750000
+#define CLK_80_136M     80136000
+#define CLK_83_375M     83375000
+#define CLK_83_950M     83950000
+#define CLK_85_860M     85860000
+#define CLK_94_500M     94500000
+#define CLK_108_000M    108000000
+#define CLK_125_104M    125104000
+#define CLK_133_308M    133308000
+#define CLK_135_000M    135000000
+/* #define CLK_148_500M    148500000 */
+#define CLK_157_500M    157500000
+#define CLK_162_000M    162000000
+#define CLK_202_500M    202500000
+#define CLK_234_000M    234000000
+#define CLK_297_500M    297500000
+#define CLK_74_481M     74481000
+#define CLK_172_798M    172798000
+#define CLK_122_614M    122614000
+
+
+/* CLE266 PLL value */
+#define CLE266_PLL_25_175M     0x0000C763
+#define CLE266_PLL_26_880M     0x0000440F
+#define CLE266_PLL_29_581M     0x00008421
+#define CLE266_PLL_31_490M     0x00004721
+#define CLE266_PLL_31_500M     0x0000C3B5
+#define CLE266_PLL_31_728M     0x0000471F
+#define CLE266_PLL_32_668M     0x0000C449
+#define CLE266_PLL_36_000M     0x0000C5E5
+#define CLE266_PLL_40_000M     0x0000C459
+#define CLE266_PLL_41_291M     0x00004417
+#define CLE266_PLL_43_163M     0x0000C579
+/* #define CLE266_PLL_46_996M     0x0000C4E9 */
+#define CLE266_PLL_48_875M     0x00001D63
+#define CLE266_PLL_49_500M     0x00008653
+#define CLE266_PLL_52_406M     0x0000C475
+#define CLE266_PLL_56_250M     0x000047B7
+#define CLE266_PLL_65_000M     0x000086ED
+#define CLE266_PLL_68_179M     0x00000413
+#define CLE266_PLL_78_750M     0x00004321
+#define CLE266_PLL_80_136M     0x0000051C
+#define CLE266_PLL_83_375M     0x0000C25D
+#define CLE266_PLL_83_950M     0x00000729
+#define CLE266_PLL_85_860M     0x00004754
+#define CLE266_PLL_94_500M     0x00000521
+#define CLE266_PLL_108_000M    0x00008479
+#define CLE266_PLL_125_104M    0x000006B5
+#define CLE266_PLL_133_308M    0x0000465F
+#define CLE266_PLL_135_000M    0x0000455E
+/* #define CLE266_PLL_148_500M    0x0000 */
+#define CLE266_PLL_157_500M    0x000005B7
+#define CLE266_PLL_162_000M    0x00004571
+#define CLE266_PLL_202_500M    0x00000763
+#define CLE266_PLL_234_000M    0x00000662
+#define CLE266_PLL_297_500M    0x000005E6
+#define CLE266_PLL_74_481M     0x0000051A
+#define CLE266_PLL_172_798M    0x00004579
+#define CLE266_PLL_122_614M    0x0000073C
+
+/*  K800 PLL value */
+#define K800_PLL_25_175M     0x00539001
+#define K800_PLL_26_880M     0x001C8C80
+#define K800_PLL_29_581M     0x00409080
+#define K800_PLL_31_490M     0x006F9001
+#define K800_PLL_31_500M     0x008B9002
+#define K800_PLL_31_728M     0x00AF9003
+#define K800_PLL_32_668M     0x00909002
+#define K800_PLL_36_000M     0x009F9002
+#define K800_PLL_40_000M     0x00578C02
+#define K800_PLL_41_291M     0x00438C01
+#define K800_PLL_43_163M     0x00778C03
+/* #define K800_PLL_46_996M     0x00000000 */
+#define K800_PLL_48_875M     0x00508C81
+#define K800_PLL_49_500M     0x00518C01
+#define K800_PLL_52_406M     0x00738C02
+#define K800_PLL_56_250M     0x007C8C02
+#define K800_PLL_65_000M     0x006B8C01
+#define K800_PLL_68_179M     0x00708C01
+#define K800_PLL_78_750M     0x00408801
+#define K800_PLL_80_136M     0x00428801
+#define K800_PLL_83_375M     0x005B0882
+#define K800_PLL_83_950M     0x00738803
+#define K800_PLL_85_860M     0x00768883
+#define K800_PLL_94_500M     0x00828803
+#define K800_PLL_108_000M    0x00778882
+#define K800_PLL_125_104M    0x00688801
+#define K800_PLL_133_308M    0x005D8801
+#define K800_PLL_135_000M    0x001A4081
+/* #define K800_PLL_148_500M    0x0000 */
+#define K800_PLL_157_500M    0x00142080
+#define K800_PLL_162_000M    0x006F8483
+#define K800_PLL_202_500M    0x00538481
+#define K800_PLL_234_000M    0x00608401
+#define K800_PLL_297_500M    0x00A48402
+#define K800_PLL_74_481M     0x007B8C81
+#define K800_PLL_172_798M    0x00778483
+#define K800_PLL_122_614M    0x00878882
+
+/* PLL for VT3324 */
+#define CX700_25_175M     0x008B1003
+#define CX700_26_719M     0x00931003
+#define CX700_26_880M     0x00941003
+#define CX700_29_581M     0x00A49003
+#define CX700_31_490M     0x00AE1003
+#define CX700_31_500M     0x00AE1003
+#define CX700_31_728M     0x00AF1003
+#define CX700_32_668M     0x00B51003
+#define CX700_36_000M     0x00C81003
+#define CX700_40_000M     0x006E0C03
+#define CX700_41_291M     0x00710C03
+#define CX700_43_163M     0x00770C03
+#define CX700_48_875M     0x00508C81
+#define CX700_49_500M     0x00880C03
+#define CX700_52_406M     0x00730C02
+#define CX700_56_250M     0x009B0C03
+#define CX700_65_000M     0x006B0C01
+#define CX700_68_179M     0x00BC0C03
+#define CX700_74_481M     0x00CE0C03
+#define CX700_78_750M     0x006C0803
+#define CX700_80_136M     0x006E0803
+#define CX700_83_375M     0x005B0882
+#define CX700_83_950M     0x00730803
+#define CX700_85_860M     0x00760803
+#define CX700_94_500M     0x00820803
+#define CX700_108_000M    0x00950803
+#define CX700_125_104M    0x00AD0803
+#define CX700_133_308M    0x00930802
+#define CX700_135_000M    0x00950802
+#define CX700_157_500M    0x006C0403
+#define CX700_162_000M    0x006F0403
+#define CX700_172_798M    0x00770403
+#define CX700_202_500M    0x008C0403
+#define CX700_234_000M    0x00600401
+#define CX700_297_500M    0x00CE0403
+#define CX700_122_614M    0x00870802
+
+/* Definition CRTC Timing Index */
+#define H_TOTAL_INDEX               0
+#define H_ADDR_INDEX                1
+#define H_BLANK_START_INDEX         2
+#define H_BLANK_END_INDEX           3
+#define H_SYNC_START_INDEX          4
+#define H_SYNC_END_INDEX            5
+#define V_TOTAL_INDEX               6
+#define V_ADDR_INDEX                7
+#define V_BLANK_START_INDEX         8
+#define V_BLANK_END_INDEX           9
+#define V_SYNC_START_INDEX          10
+#define V_SYNC_END_INDEX            11
+#define H_TOTAL_SHADOW_INDEX        12
+#define H_BLANK_END_SHADOW_INDEX    13
+#define V_TOTAL_SHADOW_INDEX        14
+#define V_ADDR_SHADOW_INDEX         15
+#define V_BLANK_SATRT_SHADOW_INDEX  16
+#define V_BLANK_END_SHADOW_INDEX    17
+#define V_SYNC_SATRT_SHADOW_INDEX   18
+#define V_SYNC_END_SHADOW_INDEX     19
+
+/* Definition Video Mode Pixel Clock (picoseconds) */
+#define RES_640X480_60HZ_PIXCLOCK    39722
+#define RES_640X480_75HZ_PIXCLOCK    31747
+#define RES_640X480_85HZ_PIXCLOCK    27777
+#define RES_640X480_100HZ_PIXCLOCK   23168
+#define RES_640X480_120HZ_PIXCLOCK   19081
+#define RES_720X480_60HZ_PIXCLOCK    37020
+#define RES_720X576_60HZ_PIXCLOCK    30611
+#define RES_800X600_60HZ_PIXCLOCK    25000
+#define RES_800X600_75HZ_PIXCLOCK    20203
+#define RES_800X600_85HZ_PIXCLOCK    17777
+#define RES_800X600_100HZ_PIXCLOCK   14815
+#define RES_800X600_120HZ_PIXCLOCK   11912
+#define RES_800X480_60HZ_PIXCLOCK    33805
+#define RES_848X480_60HZ_PIXCLOCK    31756
+#define RES_856X480_60HZ_PIXCLOCK    31518
+#define RES_1024X512_60HZ_PIXCLOCK   24218
+#define RES_1024X600_60HZ_PIXCLOCK   20460
+#define RES_1024X768_60HZ_PIXCLOCK   15385
+#define RES_1024X768_75HZ_PIXCLOCK   12699
+#define RES_1024X768_85HZ_PIXCLOCK   10582
+#define RES_1024X768_100HZ_PIXCLOCK  9091
+#define RES_1152X864_70HZ_PIXCLOCK   10000
+#define RES_1152X864_75HZ_PIXCLOCK   9091
+#define RES_1280X768_60HZ_PIXCLOCK   12480
+#define RES_1280X800_60HZ_PIXCLOCK   11994
+#define RES_1280X960_60HZ_PIXCLOCK   9259
+#define RES_1280X1024_60HZ_PIXCLOCK  9260
+#define RES_1280X1024_75HZ_PIXCLOCK  7408
+#define RES_1280X768_85HZ_PIXCLOCK   6349
+#define RES_1440X1050_60HZ_PIXCLOCK  7993
+#define RES_1600X1200_60HZ_PIXCLOCK  6411
+#define RES_1600X1200_75HZ_PIXCLOCK  4938
+#define RES_1280X720_60HZ_PIXCLOCK   13426
+#define RES_1920X1080_60HZ_PIXCLOCK  5787
+#define RES_1400X1050_60HZ_PIXCLOCK  8156
+#define RES_1368X768_60HZ_PIXCLOCK   11647
+
+/*  LCD display method */
+#define     LCD_EXPANDSION              0x00
+#define     LCD_CENTERING               0x01
+
+/*  LCD mode */
+#define     LCD_OPENLDI               0x00
+#define     LCD_SPWG                  0x01
+
+
+/* Define display timing */
+struct display_timing {
+    u16     hor_total;
+    u16     hor_addr;
+    u16     hor_blank_start;
+    u16     hor_blank_end;
+    u16     hor_sync_start;
+    u16     hor_sync_end;
+    u16     ver_total;
+    u16     ver_addr;
+    u16     ver_blank_start;
+    u16     ver_blank_end;
+    u16     ver_sync_start;
+    u16     ver_sync_end;
+};
+
+struct crt_mode_table {
+  int                               refresh_rate;
+  unsigned long                     clk;
+  int                               h_sync_polarity;
+  int                               v_sync_polarity;
+  struct display_timing             crtc;
+};
+
+struct io_reg{
+  int   port;
+  u8    index;
+  u8    mask;
+  u8    value;
+};
+
+#endif /* __SHARE_H__ */

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
