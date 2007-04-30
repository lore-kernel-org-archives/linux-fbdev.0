From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 11/12] viafb: Framebuffer driver for VIA
 UniChrome/Chrome9 HC (fwd)
Date: Mon, 30 Apr 2007 10:37:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704301037540.27246@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiROY-0006d8-Rh for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:38:07 -0700
Received: from hoboe2bl1.telenet-ops.be ([195.130.137.73])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiROX-0002AY-Ka
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:38:06 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hoboe2bl1.telenet-ops.be (Postfix) with SMTP id 3AF5C124014
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:38:03 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by hoboe2bl1.telenet-ops.be (Postfix) with ESMTP id 0D83212400F
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:38:00 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l3U8bxo7020455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:59 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l3U8bxkW020452
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:59 +0200
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
Date: Mon, 30 Apr 2007 13:20:59 +0800
From: EddyFu@via.com.tw
To: linux-fbdev-devel-bounces@lists.sourceforge.net
Subject: [Linux-fbdev-devel] [PATCH 11/12] viafb: Framebuffer driver for VIA
    UniChrome/Chrome9 HC

Dear All, 
 
Here is the part 11/12 of viafb.
 
Best Regards,
Eddy Fu 
 
diff -Nur linux-2.6.21-rc7/drivers/video/via/tv.c linux-2.6.21-rc7.viafb/drivers/video/via/tv.c
--- linux-2.6.21-rc7/drivers/video/via/tv.c 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tv.c 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,1567 @@
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
+#include "tv.h"
+#include "chip.h"
+#include "share.h"
+#include "debug.h"
+#include "ioctl.h"
+#include "IntegratedTV.h"
+
+/* TV Encoder Extern Function */
+extern void vt1622_tv_disable(void);
+extern void vt1622_tv_enable(void);
+extern void load_vt1622_regs(int TVModeIndex);
+extern int  vt1622_tv_encoder_identify(void);
+extern int vt1622_sense(void);
+extern int vt1622_auto_sense(void);
+
+extern void vt1622a_tv_disable(void);
+extern void vt1622a_tv_enable(void);
+extern void load_vt1622a_regs(int TVModeIndex);
+extern int  vt1622a_tv_encoder_identify(void);
+extern int vt1622a_sense(void);
+extern int vt1622a_auto_sense(void);
+
+extern void vt1625_tv_disable(void);
+extern void vt1625_tv_enable(void);
+extern void load_vt1625_regs(int TVModeIndex);
+extern int  vt1625_tv_encoder_identify(void);
+extern int vt1625_sense(void);
+extern int vt1625_auto_sense(void);
+extern void init_tv_vt1625(void);
+
+extern int integrated_tv_encoder_identify(void);
+extern void integrated_tv_enable(void);
+extern void integrated_tv_disable(void);
+extern void set_integrated_tv_mode(int tv_mode_index);
+extern void get_integrated_tv_default_status(void);
+extern int get_integrated_tv_ffilter_status(int filter_type, int* filter_state);
+extern void get_integrated_tv_pos(u32* current_hpos, u32* current_vpos);
+extern void set_integrated_tv_ffilter_status(int filter_type, int filter_on_off, u32 desired_value);
+extern void set_integrated_tv_hue(u32 desired_value);
+extern void set_integrated_tv_brightness(u32 desired_value);
+extern void set_integrated_tv_pos(u32 desired_hpos, u32 desired_vpos);
+extern void set_integrated_tv_size(u32 desired_hsize, u32 desired_vsize);
+extern int integrated_tv_sense(void);
+
+
+extern void SetVCLK(u32 CLK, int set_iga);
+extern inline void write_reg(u8 index, u16 io_port, u8 data);
+extern void write_reg_mask(u8 index, int io_port, u8 data, u8 mask);
+extern int i2cWriteByte(u8 bSlaveAddress, u8 bIndex, u8 bData);
+extern int i2cReadByte(u8 bSlaveAddress, u8 bIndex, u8 *pbData);
+extern void set_output_path(int device, int set_iga, int output_interface);
+extern inline u8 read_reg(int io_port, u8 index);
+extern void load_FIFO_reg(int set_iga, int hor_active, int ver_active);
+extern void set_color_depth(int bpp_byte, int set_iga);
+extern void set_integrated_tv_contrast(u32 desired_value);
+extern void set_integrated_tv_saturation(u32 desired_value);
+
+bool  is_tv_mode(struct tv_chip_information* ptv_chip_info, struct tv_setting_information* ptv_setting_info,
+                             int video_index);
+bool is_vt1625_mode(struct tv_chip_information* ptv_chip_info, struct tv_setting_information* ptv_setting_info,
+                             int video_index);
+
+/* extern struct */
+extern struct chip_information      chip_info;
+extern struct tv_setting_information    tv_setting_info;
+
+extern int HotPlug_TV;
+
+extern long tv_ffilter;
+extern long tv_brightness;
+extern long tv_contrast;
+extern long tv_saturation;
+extern long tv_tint;
+extern long tv_pos_hor_current;
+extern long tv_pos_ver_current;
+
+int tv_encoder_identify(void)
+{
+    chip_info.tv_chip_info.tv_chip_name = VT1622;
+    chip_info.tv_chip_info.tv_chip_slave_addr = VT1622_TV_I2C_ADDR;
+
+    if (vt1622_tv_encoder_identify()!= FAIL)
+    {
+        DEBUG_MSG(KERN_INFO "\n VT1622 VT1622 ! \n");
+        DEBUG_MSG(KERN_INFO "\n %2d", chip_info.tv_chip_info.tv_chip_name);
+        DEBUG_MSG(KERN_INFO "\n %2d", chip_info.tv_chip_info.tv_chip_name);
+        return(OK);
+    }
+
+    chip_info.tv_chip_info.tv_chip_name = VT1622A;
+    chip_info.tv_chip_info.tv_chip_slave_addr = VT1622A_TV_I2C_ADDR;
+
+    if (vt1622a_tv_encoder_identify()!= FAIL)
+    {
+        DEBUG_MSG(KERN_INFO "\n VT1622A VT1622A ! \n");
+        DEBUG_MSG(KERN_INFO "\n %2d", chip_info.tv_chip_info.tv_chip_name);
+        DEBUG_MSG(KERN_INFO "\n %2d", chip_info.tv_chip_info.tv_chip_name);
+        return(OK);
+    }
+
+    chip_info.tv_chip_info.tv_chip_name = VT1625;
+    chip_info.tv_chip_info.tv_chip_slave_addr = VT1625_TV_I2C_ADDR;
+
+    if (vt1625_tv_encoder_identify()!= FAIL)
+    {
+        DEBUG_MSG(KERN_INFO "\n VT1625 VT1625 ! \n");
+        DEBUG_MSG(KERN_INFO "\n %2d", chip_info.tv_chip_info.tv_chip_name);
+        DEBUG_MSG(KERN_INFO "\n %2d", chip_info.tv_chip_info.tv_chip_name);
+        return(OK);
+    }
+
+    /* Check for VT3324 integrated TV. */
+    chip_info.tv_chip_info.tv_chip_name = INTEGRATED_TV;
+
+    if (integrated_tv_encoder_identify() != FAIL)
+    {
+        chip_info.tv_chip_info.output_interface = INTERFACE_NONE;
+        DEBUG_MSG(KERN_INFO "\n Found Integrated TV ! \n");
+        return OK;
+    }    
+
+    
+
+    chip_info.tv_chip_info.tv_chip_name = NON_TV_ENCODER;
+    chip_info.tv_chip_info.tv_chip_slave_addr = NON_TV_ENCODER;
+    return(FAIL);
+}
+
+void tv_disable(void)
+{
+    /* Disable HW Reset */
+    outb(0x6b,VIACR);
+    outb(0,VIACR+1);      /* clear CR6B=0 */
+    outb(0x6c,VIACR);
+    outb(0,VIACR+1);      /* clear CR6C=0 */
+
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+            vt1622_tv_disable();
+            break;
+
+        case VT1622A:
+            vt1622a_tv_disable();
+            break;
+
+        case VT1625:
+            vt1625_tv_disable();
+            break;
+
+        case INTEGRATED_TV:
+            integrated_tv_disable();
+            break;
+                
+    }
+}
+
+void tv_load_timing_init(void)
+{
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+            break;
+
+        case VT1622A:
+            break;
+
+        case VT1625:
+            init_tv_vt1625();
+            break;
+            
+    }
+}
+
+void VIAPitchAlignmentPatch(void)
+{
+    unsigned char      cr13, cr35, cr65, cr66, cr67;
+    unsigned long     dwScreenPitch= 0;
+    unsigned long     dwPitch;
+
+    dwPitch = tv_setting_info.h_active * (tv_setting_info.bpp >> 3);
+    dwPitch = tv_setting_info.h_active *(tv_setting_info.bpp>> 3);
+    if (dwPitch & 0x1F) 
+   {   /* Is 32 Byte Alignment ? */
+        dwScreenPitch = ((dwPitch + 31) & ~31) >> 3;
+        if ( tv_setting_info.iga_path==IGA2)
+        {
+            if(tv_setting_info.bpp>8) {     
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
+            if(tv_setting_info.bpp>8) {     
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
+void tv_load_timing(int TVModeIndex)
+{
+    unsigned char cr65, cr66, cr67;
+    unsigned char  cr13, cr35, sr1c, sr1d;
+    int                   countWidthByQWord, offsetWidthByQWord;
+
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+            load_vt1622_regs(TVModeIndex);
+            break;
+
+        case VT1622A:
+            load_vt1622a_regs(TVModeIndex);
+            break;
+
+        case VT1625:
+            load_vt1625_regs(TVModeIndex);
+            break;
+
+        case INTEGRATED_TV:
+            set_integrated_tv_mode(TVModeIndex);
+            break;
+
+    }
+
+    /* Set Quadword offset,counter of primary and secondary screen.Fix colorkey   
+       problem when using CRT+TV SAMM state. Not consider using virtual desktop */
+    offsetWidthByQWord = (tv_setting_info.h_active*(tv_setting_info.bpp>> 3)) >> 3;
+    countWidthByQWord = (tv_setting_info.h_active *(tv_setting_info.bpp>> 3)) >> 3;
+
+    if(tv_setting_info.iga_path==IGA2)
+    {  
+        cr67 = read_reg(VIACR, CR67) & 0xFC;
+        cr66 = offsetWidthByQWord & 0xFF;
+        cr67 |= (offsetWidthByQWord & 0x300) >> 8;
+
+        write_reg(CR66, VIACR, cr66);
+        write_reg(CR67, VIACR, cr67);
+
+        cr67 = read_reg(VIACR, CR67) & 0xF3;
+
+        cr67 |= (countWidthByQWord & 0x600) >> 7;
+        cr65 = (countWidthByQWord >> 1) & 0xff;
+
+        write_reg(CR65, VIACR, cr65);
+        write_reg(CR67, VIACR, cr67);
+
+        /* We also should set FIFO related registers if TV use IGA2, or TV display may incorrect.*/
+        if((chip_info.gfx_chip_name != UNICHROME_CLE266) && (chip_info.gfx_chip_name != UNICHROME_K400)) { /* Because load_FIFO_reg() will load incorrect regs for CLE266&K400 */
+            load_FIFO_reg(IGA2, tv_setting_info.h_active, tv_setting_info.v_active);
+        }
+
+        set_color_depth(tv_setting_info.bpp >> 3, IGA2);
+  
+        /* Patch for non 32bit alignment mode */
+        VIAPitchAlignmentPatch();
+    }  
+    else
+    {
+        cr35 = read_reg(VIACR, CR35) & 0x1F;
+        cr13 = offsetWidthByQWord & 0xFF;
+        cr35 |= (offsetWidthByQWord & 0x700) >> 3;        /* bit 7:5: offset 10:8 */
+
+        sr1d = read_reg(VIASR, SR1D);
+
+        /* Patch for non 32bit alignment mode */
+        VIAPitchAlignmentPatch();
+
+        /* Enable Refresh to avoid data lose when enter screen saver */
+        /* Refresh disable & 128-bit alignment */
+        sr1d = (sr1d & 0xFC) | (countWidthByQWord >> 9);
+        sr1c = ((countWidthByQWord >> 1) + 1) & 0xFF;
+        /* sr1d = ((sr1d & 0xFC) | (widthByQWord >> 8)) | 0x80; */
+        /* sr1c = widthByQWord & 0xFF; */
+
+        write_reg(CR13, VIACR, cr13);
+        write_reg(CR35, VIACR, cr35);
+        write_reg(SR1C, VIASR, sr1c);
+        write_reg(SR1D, VIASR, sr1d);
+    }  
+}
+
+void tv_load_timing_modify(void)
+{
+     switch(chip_info.tv_chip_info.tv_chip_name) {
+        case VT1622:
+                break;
+        case VT1622A:
+                break;
+        case VT1625:
+                break;
+
+    }
+}
+
+void tv_patch(int tv_mode_index)
+{
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622A:
+        case VT1623:
+            switch(chip_info.gfx_chip_name)
+            {
+                case UNICHROME_K800:
+                    tv_patch_skew_K800();
+                    break;
+                default:
+                    break;
+            }
+            break;
+
+        case VT1625:
+            switch(tv_setting_info.out_signal)
+            {
+                case TV_OUTPUT_SVIDEO:
+                case TV_OUTPUT_COMPOSITE_SVIDEO:
+                    /* Set TV.65h = 51h, SVideo Luma Value. */
+                    tv_register_write(0x65, 0x51);
+                    break;
+                default:
+                    break;
+            }
+
+            switch(chip_info.gfx_chip_name)
+            {
+                case UNICHROME_P880:
+                    tv_patch_skew_p880(tv_mode_index);
+                    break;
+                    
+                case UNICHROME_CN900:
+                    tv_patch_skew_cn900(tv_mode_index);
+                    break;
+
+                case UNICHROME_CX700:
+                    tv_patch_skew_cx700(tv_mode_index);
+                    break;
+
+                /* Add to support VT3327 VT3336 VT3364 */
+                case UNICHROME_K8M890:
+                    tv_patch_skew_k8m890(tv_mode_index);
+                    break;
+                    
+                case UNICHROME_P4M890:
+                    tv_patch_skew_p4m890(tv_mode_index);
+                    break;
+
+                case UNICHROME_P4M900:
+                     tv_patch_skew_p4m900(tv_mode_index);
+                    break;
+                    
+                default:
+                    break;
+            }
+            
+            break;
+
+        default:
+            break;
+    }
+}
+
+void tv_enable(void)
+{
+    switch(tv_setting_info.iga_path)
+    {
+        case IGA1:
+            set_output_path(DEVICE_TV, IGA1, chip_info.tv_chip_info.output_interface);
+            break;
+
+        case IGA2:
+            set_output_path(DEVICE_TV, IGA2, chip_info.tv_chip_info.output_interface);
+            break;
+
+        case IGA1_IGA2:
+            break;
+    }
+
+
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+            vt1622_tv_enable();
+            break;
+
+        case VT1622A:
+            vt1622a_tv_enable();
+            break;
+
+        case VT1625:
+            vt1625_tv_enable();
+            break;
+
+        case INTEGRATED_TV:
+            integrated_tv_enable();
+            break;
+
+     }
+
+    /* For hot-plug issue:
+       If switch to TV, it would use TV auto-sense function to sense TV. */
+    if(HotPlug_TV == 1)
+    {
+        if(chip_info.tv_chip_info.tv_chip_name == VT1625)
+        {
+            tv_register_write(0x1C, tv_register_read(0x1C) | BIT6);
+            tv_register_write(0x0E, 0x00);
+        }
+        else
+        {
+            tv_register_write(0x0E, 0x40);
+        }
+    }
+
+}
+
+void tv_register_write(int index, u8 data)
+{
+    i2cWriteByte(chip_info.tv_chip_info.tv_chip_slave_addr, index, data);
+}
+
+int tv_register_read(int index)
+{
+    u8 data = 0; /* Fix me:should need another parameter to indicate whether read is successful */
+    int status;
+
+    status = i2cReadByte(chip_info.tv_chip_info.tv_chip_slave_addr, index, &data);
+    return(data);
+}
+
+void load_tv_output_signal(u16 *tv_func_reg)
+{
+    int i=0;
+
+    while(tv_func_reg[i]!= 0xFFFF)
+    {
+        tv_register_write(GET_LOW_BYTE(tv_func_reg[i]),GET_HIGH_BYTE(tv_func_reg[i]));
+        i++;
+    }
+
+}
+
+void write_tv_patch_table(u16 *tv_func_reg)
+{
+    int i=0;
+
+    while(tv_func_reg[i]!= 0xFFFF)
+    {
+        tv_register_write(GET_LOW_BYTE(tv_func_reg[i]),GET_HIGH_BYTE(tv_func_reg[i]));
+        i++;
+    }
+}
+
+bool is_tv_mode(struct tv_chip_information* ptv_chip_info, struct tv_setting_information* ptv_setting_info,
+                             int video_index)
+{
+    bool re = FALSE;
+    switch(ptv_chip_info->tv_chip_name)
+    {
+        case VT1621:
+            if(VIA_RES_640X480  == video_index || VIA_RES_800X600 == video_index)
+            {
+                WARN_MSG(KERN_WARNING "The specified tv mode is not valid for currently used  tv encoder\n");
+                re = TRUE;
+            }
+            break;
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+            if (VIA_RES_640X480 == video_index ||VIA_RES_800X600 == video_index ||
+                VIA_RES_1024X768 == video_index || VIA_RES_720X480 == video_index ||
+                VIA_RES_720X576== video_index || VIA_RES_848X480 == video_index)
+            {
+                WARN_MSG(KERN_WARNING "The specified tv mode is not valid for currently used  tv encoder\n");
+                re = TRUE;
+            }
+            break;
+        case VT1625:           
+            re = is_vt1625_mode(ptv_chip_info, ptv_setting_info, video_index);
+            break;
+        case INTEGRATED_TV:
+            if(CX700_REVISION_700 == chip_info.gfx_chip_revision)
+            {
+                switch(ptv_setting_info->system)
+                {
+                    case TVTYPE_480P:
+                    case TVTYPE_576P:
+                    case TVTYPE_720P:
+                    case TVTYPE_1080I:
+                        WARN_MSG(KERN_WARNING "HDTV is not supported for currently used  tv encoder\n");
+                        re = FALSE;
+                        return re;
+                        break;
+                    default:
+                        break;
+                }
+            }
+            if (VIA_RES_640X480 == video_index ||VIA_RES_800X600 == video_index ||
+                VIA_RES_1024X768 == video_index || VIA_RES_720X480 == video_index ||
+                VIA_RES_720X576== video_index || VIA_RES_1280X720 == video_index ||
+                VIA_RES_1920X1080 == video_index)
+            {
+                WARN_MSG(KERN_WARNING "The specified tv mode is not valid for currently used  tv encoder\n");
+                re = TRUE;
+            }
+            break;
+    }
+    return re;
+}
+/* TV Set Mode */
+void tv_set_mode(int video_index)
+{
+    if(is_tv_mode(&chip_info.tv_chip_info, &tv_setting_info, video_index))
+    {
+        tv_encoder_identify();
+        tv_disable();
+        tv_load_timing_init();
+        tv_load_timing(video_index);
+        tv_load_timing_modify();
+        tv_patch(video_index);
+        tv_enable();
+        tv_set_color();
+    }
+    else
+    {
+        WARN_MSG(KERN_WARNING "TV will not be enabled\n");
+    }
+}
+
+/* Sense function only support VIA TV encoder */
+int tv_sense(void)
+{
+    int ret;
+
+    DEBUG_MSG(KERN_INFO "tv_sense!!\n");
+
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+            ret = vt1622_sense();
+            break;
+
+        case VT1622A:
+            ret = vt1622a_sense();
+            break;
+
+        case VT1625:
+            ret = vt1625_sense();
+            break;
+
+        /* Add for VT3324 Integrated TV. */
+        case INTEGRATED_TV:
+            ret = integrated_tv_sense();
+            break;
+            
+        default:
+            ret = TV_OUTPUT_NONE;
+            break;
+    }
+
+    return ret;
+}
+
+/* Auto sense function only support VIA TV encoder */
+int tv_auto_sense(void)
+{
+    int ret;
+
+    DEBUG_MSG(KERN_INFO "tv_auto_sense!!\n");
+
+    switch(chip_info.tv_chip_info.tv_chip_name) {
+        case VT1622:
+            ret = vt1622_auto_sense();
+            break;
+        case VT1622A:
+            ret = vt1622a_auto_sense();
+            break;
+        case VT1625:
+            ret = vt1625_auto_sense();
+            break;
+        default:
+            ret = TV_OUTPUT_NONE;
+            break;
+     }
+
+    return ret;
+}
+
+void tv_patch_skew_K800(void)
+{
+    switch(chip_info.tv_chip_info.output_interface)
+    {
+        case INTERFACE_DVP0:
+            write_reg_mask(CR96, VIACR, 0x07, BIT0+BIT1+BIT2);
+            break;
+        case INTERFACE_DVP1:
+            write_reg_mask(CR9B, VIACR, 0x07, BIT0+BIT1+BIT2);
+            break;
+        case INTERFACE_DFP_HIGH:
+            write_reg_mask(CR97, VIACR, 0x07, BIT0+BIT1+BIT2);
+            break;
+        case INTERFACE_DFP_LOW:
+            write_reg_mask(CR99, VIACR, 0x07, BIT0+BIT1+BIT2);
+            break;
+    }
+}
+
+/* For VT3314 */
+void tv_patch_skew_cn900(int tv_mode_index)
+{
+    u8 data;
+    
+    switch(chip_info.tv_chip_info.output_interface)
+    {
+        case INTERFACE_DVP0:
+            /* Reset clock and data driving first: */
+            write_reg_mask(SR2A, VIASR, 0, BIT4+BIT5);
+            write_reg_mask(SR1E, VIASR, 0, BIT2);
+            write_reg_mask(SR1B, VIASR, 0, BIT1);
+            
+            /* For TV display incorrect color */
+            /* with VT5907A (VT1625-AMR) on VN800.*/            
+            if (tv_setting_info.system == TVTYPE_PAL)
+            {
+                /* It still has a little bit problem in this mode. */
+                if ((tv_mode_index == VIA_RES_1024X768) && (tv_setting_info.level == TV_SIZE_OVER_SCAN))
+                {
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR2A, VIASR, BIT4, BIT4);
+                    write_reg_mask(SR1E, VIASR, BIT2, BIT2);
+                }                
+            }
+            else if (tv_setting_info.system == TVTYPE_576P)
+            {
+                /* It still has a little bit problem in this mode. */
+                if ((tv_mode_index == VIA_RES_1024X768) && (tv_setting_info.level == TV_SIZE_OVER_SCAN))
+                {
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR2A, VIASR, BIT4, BIT4);
+                    write_reg_mask(SR1E, VIASR, BIT2, BIT2);
+                }                
+            }
+            else if (tv_setting_info.system == TVTYPE_720P)
+            {
+                if ((tv_mode_index == VIA_RES_1024X768) && (tv_setting_info.level == TV_SIZE_NORMAL_SCAN))
+                {
+                    /* Adjust data driving: */
+                    write_reg_mask(SR2A, VIASR, BIT5, BIT5);
+                    write_reg_mask(SR1B, VIASR, BIT1, BIT1);
+                    
+                    write_reg_mask(CR96, VIACR, 0x07, BIT0+BIT1+BIT2+BIT3);
+                    
+                    data = tv_register_read(0x05);
+                    data = (data & 0xE0) | 0x1E;
+                    tv_register_write(0x05, data);
+                }
+            }
+            else if (tv_setting_info.system == TVTYPE_1080I)
+            {
+                if ((tv_mode_index == VIA_RES_1024X768) && (tv_setting_info.level == TV_SIZE_NORMAL_SCAN))
+                {
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR2A, VIASR, BIT4, BIT4);
+                    write_reg_mask(SR1E, VIASR, BIT2, BIT2);
+                    
+                    /* Adjust data driving: */
+                    write_reg_mask(SR2A, VIASR, BIT5, BIT5);
+                    write_reg_mask(SR1B, VIASR, BIT1, BIT1);
+
+                    
+                    write_reg_mask(CR96, VIACR, 0x07, BIT0+BIT1+BIT2+BIT3);
+                    
+                    data = tv_register_read(0x05);
+                    data = (data & 0xF0) | 0x09;
+                    tv_register_write(0x05, data);
+                }
+                else if ((tv_mode_index == VIA_RES_1024X768) && (tv_setting_info.level == TV_SIZE_OVER_SCAN))
+                {
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR2A, VIASR, BIT4, BIT4);
+                    write_reg_mask(SR1E, VIASR, BIT2, BIT2);
+                }
+                else if(tv_mode_index == VIA_RES_1920X1080)
+                {
+                    /* For both normal scan and over scan */
+                    /* It still has a little bit problem in this mode. */
+                    
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR2A, VIASR, BIT4, BIT4);
+                    write_reg_mask(SR1E, VIASR, BIT2, BIT2);
+                    
+                    /* Adjust data driving: */
+                    write_reg_mask(SR2A, VIASR, 0, BIT5);
+                    write_reg_mask(SR1B, VIASR, BIT1, BIT1);
+                    
+                    data = tv_register_read(0x05);
+                    data = (data & 0xF0);
+                    tv_register_write(0x05, data);
+                }
+            }            
+            
+            break;
+
+        case INTERFACE_DVP1:
+            break;
+
+        case INTERFACE_DFP_HIGH:
+            break;
+
+        case INTERFACE_DFP_LOW:
+            break;
+    }
+} 
+
+/* For VT3324 */
+void tv_patch_skew_cx700(int tv_mode_index)
+{
+    switch(chip_info.tv_chip_info.output_interface)
+    {
+        case INTERFACE_DVP0:
+            /* For TV display incorrect color */
+            /* with VT5907A (VT1625-AMR) on CX700.*/            
+            if (tv_setting_info.system == TVTYPE_720P)
+            {
+                if ((tv_mode_index == VIA_RES_1024X768) && (tv_setting_info.level == TV_SIZE_NORMAL_SCAN))
+                {
+                    write_reg_mask(CR96, VIACR, 0x0F, BIT0+BIT1+BIT2+BIT3);
+                }
+            }
+
+            break;
+
+        case INTERFACE_DVP1:
+            if (tv_setting_info.system == TVTYPE_720P)
+            {
+                if ((tv_mode_index == VIA_RES_1024X768) && (tv_setting_info.level == TV_SIZE_NORMAL_SCAN))
+                {
+                    write_reg_mask(CR9B, VIACR, 0x02, BIT0+BIT1);
+                }
+            }else if (tv_setting_info.system == TVTYPE_1080I)
+            {
+                if ((tv_mode_index == VIA_RES_1024X768) && (tv_setting_info.level == TV_SIZE_NORMAL_SCAN))
+                {
+                    write_reg_mask(CR9B, VIACR, 0x02, BIT0+BIT1);
+                }
+            }
+            break;
+    }
+} 
+
+/* For VT3259 */
+void tv_patch_skew_p880(int tv_mode_index)
+{
+    u8 data;
+    
+    switch(chip_info.tv_chip_info.output_interface)
+    {
+        case INTERFACE_DVP0:
+            /* Reset clock and data driving first: */
+            write_reg_mask(SR2A, VIASR, 0, BIT4+BIT5);
+            write_reg_mask(SR1E, VIASR, 0, BIT2);
+            write_reg_mask(SR1B, VIASR, 0, BIT1);
+
+            /* For TV display incorrect color */
+            /* with VT5907A (VT1625-AMR) on CN400.*/
+            if (tv_setting_info.system == TVTYPE_PAL)
+            {
+                if ((tv_mode_index == VIA_RES_1024X768) && (tv_setting_info.level == TV_SIZE_OVER_SCAN))
+                {
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR1E, VIASR, BIT2, BIT2);
+                }
+            }
+            else if (tv_setting_info.system == TVTYPE_576P)
+            {
+                if ((tv_mode_index == VIA_RES_1024X768) && (tv_setting_info.level == TV_SIZE_OVER_SCAN))
+                {
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR2A, VIASR, BIT4, BIT4);
+                }
+            }
+            else if (tv_setting_info.system == TVTYPE_720P)
+            {
+                if ((tv_mode_index == VIA_RES_1024X768) && (tv_setting_info.level == TV_SIZE_NORMAL_SCAN))
+                {
+                    write_reg_mask(CR96, VIACR, BIT3, BIT0+BIT1+BIT2+BIT3);
+                    
+                    data = tv_register_read(0x05);
+                    data = (data & 0xF0) | 0x0E;
+                    tv_register_write(0x05, data);
+                }
+            }
+            else if (tv_setting_info.system == TVTYPE_1080I)
+            {
+                if ((tv_mode_index == VIA_RES_1024X768) && (tv_setting_info.level == TV_SIZE_OVER_SCAN))
+                {
+                    /* Adjust clock driving: */
+                    write_reg_mask(SR1E, VIASR, BIT2, BIT2);
+                }
+            }
+            
+            break;
+
+        case INTERFACE_DVP1:
+            break;
+
+        case INTERFACE_DFP_HIGH:
+            break;
+
+        case INTERFACE_DFP_LOW:
+            break;
+    }
+}
+
+/* Add for support VT3327 VT3336 VT3364.
+ * Modified from X driver's code.
+ */
+void tv_patch_skew_k8m890(int tv_mode_index)
+{
+    switch(chip_info.tv_chip_info.output_interface)
+    {
+        case INTERFACE_DVP0:
+            /* Fix TV display incorrect color when set 1080i TV mode */
+            /* with VT5907A (VT1625-AMR) on VT3336. */
+            if (tv_setting_info.system == TVTYPE_1080I)
+            {
+                if (tv_mode_index == VIA_RES_1024X768)
+                {
+                    write_reg_mask(CR96, VIACR, 0x04, BIT0+BIT1+BIT2);
+                }
+                else if(tv_mode_index == VIA_RES_1920X1080)
+                {
+                    write_reg_mask(CR96, VIACR, 0x00, BIT0+BIT1+BIT2);
+                }
+            }
+            
+            break;
+        case INTERFACE_DVP1:
+            break;
+        case INTERFACE_DFP_HIGH:
+            break;
+        case INTERFACE_DFP_LOW:
+            break;
+    }
+}
+
+
+void tv_patch_skew_p4m890(int tv_mode_index)
+{
+
+    switch(chip_info.tv_chip_info.output_interface)
+    {
+        case INTERFACE_DVP0:
+            /* For TV display incorrect color */
+            /* with VT5907A (VT1625-AMR) on P4M890.*/            
+            if (tv_setting_info.system == TVTYPE_1080I)
+            {
+                if (tv_mode_index == VIA_RES_1024X768)
+                {
+                    write_reg_mask(CR96, VIACR, 0x04, BIT0+BIT1+BIT2);
+                }
+            }
+            
+            /* For TV display incorrect color */
+            /* VT1625-AMR on P4M890.*/   
+            if (tv_setting_info.system == TVTYPE_720P)
+            {
+                if (tv_mode_index == VIA_RES_1024X768)
+                {
+                    write_reg_mask(CR96, VIACR, 0x07, BIT0+BIT1+BIT2);
+                }
+            }
+
+            break;
+    }
+} 
+
+void tv_patch_skew_p4m900(int tv_mode_index)
+{
+
+    switch(chip_info.tv_chip_info.output_interface)
+    {
+        case INTERFACE_DVP0:
+            /* For TV display incorrect color */
+            /* with VT5907A (VT1625-AMR) on P4M900.*/            
+            if (tv_setting_info.system == TVTYPE_1080I)
+            {
+                if (tv_mode_index == VIA_RES_1024X768)
+                {
+                    write_reg_mask(CR96, VIACR, 0x04, BIT0+BIT1+BIT2);
+                }
+            }
+
+            if (tv_setting_info.system == TVTYPE_720P)
+            {
+                if (tv_mode_index == VIA_RES_1024X768)
+                {
+                    write_reg_mask(CR96, VIACR, 0x04, BIT0+BIT1+BIT2);
+                }
+            }
+            break;
+    }
+} 
+
+
+void tv_set_color()
+{
+    /* Get TV color default, current value and level*/
+    switch(chip_info.tv_chip_info.tv_chip_name) {
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+        case VT1625:
+            tv_setting_info.DefaultFFilter = tv_register_read(0x03) & 0x03;
+            tv_setting_info.CurrentFFilter = tv_setting_info.DefaultFFilter;
+            if (chip_info.tv_chip_info.tv_chip_name == VT1625)
+                tv_setting_info.FFilterLevel = 3;
+            else
+                tv_setting_info.FFilterLevel = 2;
+
+            tv_setting_info.DefaultBrightness = tv_register_read(0x0B);
+            tv_setting_info.CurrentBrightness = tv_setting_info.DefaultBrightness;
+            tv_setting_info.BrightnessLevel = 255;
+            if (tv_setting_info.out_signal == TV_OUTPUT_RGB) {
+                tv_setting_info.DefaultContrast = tv_register_read(0x65);
+                tv_setting_info.CurrentContrast = tv_setting_info.DefaultContrast;
+                tv_setting_info.ContrastLevel = 250;
+                tv_setting_info.DefaultSaturation = (tv_register_read(0x66) << 8) + tv_register_read(0x67);
+                tv_setting_info.CurrentSaturation = tv_setting_info.DefaultSaturation;
+                tv_setting_info.SaturationLevel = 65535;
+                tv_setting_info.DefaultTINT = 0;
+                tv_setting_info.CurrentTINT = tv_setting_info.DefaultTINT;
+                tv_setting_info.TINTLevel = 0;
+            } else if (tv_setting_info.out_signal == TV_OUTPUT_YPBPR) {
+                tv_setting_info.DefaultContrast = tv_register_read(0x65);
+                tv_setting_info.CurrentContrast = tv_setting_info.DefaultContrast;
+                tv_setting_info.ContrastLevel = 255;
+                tv_setting_info.DefaultSaturation = (tv_register_read(0x66) << 8) + tv_register_read(0x67);
+                tv_setting_info.CurrentSaturation = tv_setting_info.DefaultSaturation;
+                tv_setting_info.SaturationLevel = 65535;
+                tv_setting_info.DefaultTINT = 0;
+                tv_setting_info.CurrentTINT = tv_setting_info.DefaultTINT;
+                tv_setting_info.TINTLevel = 0;
+            } else {
+                tv_setting_info.DefaultContrast = tv_register_read(0x0C);
+                tv_setting_info.CurrentContrast = tv_setting_info.DefaultContrast;
+                tv_setting_info.ContrastLevel = 255;
+                tv_setting_info.DefaultSaturation = (tv_register_read(0x0D) << 8) + tv_register_read(0x0A);
+                tv_setting_info.CurrentSaturation = tv_setting_info.DefaultSaturation;
+                tv_setting_info.SaturationLevel = 65535;
+                tv_setting_info.DefaultTINT = tv_register_read(0x10) + ((tv_register_read(0x11) & 0x07) << 8);
+                tv_setting_info.CurrentTINT = tv_setting_info.DefaultTINT;
+                tv_setting_info.TINTLevel = 2047;
+            }
+            break;
+
+        /* Add for VT3324 Integrated TV. */
+        case INTEGRATED_TV:
+            get_integrated_tv_default_status();
+            break;
+            
+        default:
+            break;
+     }
+
+    /* Set to user parameter*/
+    if(tv_ffilter != 0)
+        tv_set_ffilter(STATE_ON, tv_ffilter);
+    if(tv_brightness != 0)
+        tv_set_brightness(tv_brightness);
+    if(tv_contrast!= 0)
+        tv_set_contrast(tv_contrast);
+    if(tv_saturation != 0)
+        tv_set_saturation(tv_saturation);
+    if(tv_tint != 0)
+        tv_set_tint(tv_tint);
+}
+
+/* Set TV Brightness function only support VIA TV encoder */
+void tv_set_brightness(u32 value)
+{
+    DEBUG_MSG(KERN_INFO "tv_set_brightness!!\n");
+
+    switch(chip_info.tv_chip_info.tv_chip_name) {
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+        case VT1625:
+            tv_register_write(0x0B, (u8) value);
+            tv_setting_info.CurrentBrightness = value;
+            break;
+
+        /* Add for VT3324 Integrated TV. */
+        case INTEGRATED_TV:
+            set_integrated_tv_brightness(value);
+            break;
+            
+        default:
+            break;
+     }
+}
+
+/* Set TV Contrast function only support VIA TV encoder */
+void tv_set_contrast(u32 value)
+{
+    u32 tmp;
+
+    DEBUG_MSG(KERN_INFO "tv_set_contrast!!\n");
+
+    switch(chip_info.tv_chip_info.tv_chip_name) {
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+        case VT1625:
+            tmp = (value - tv_setting_info.CurrentContrast);
+            if (tv_setting_info.out_signal == TV_OUTPUT_RGB) {
+                tv_register_write(0x65, (u8)(tv_register_read(0x65) + tmp));
+                tv_register_write(0x66, (u8)(tv_register_read(0x66) + tmp));
+                tv_register_write(0x67, (u8)(tv_register_read(0x67) + tmp));
+            } else if (tv_setting_info.out_signal == TV_OUTPUT_YPBPR) {
+                tv_register_write(0x65, (u8)(tv_register_read(0x65) + tmp));
+            } else {
+                tv_register_write(0x0C, (u8)(tv_register_read(0x0C) + tmp));
+                tv_register_write(0x65, (u8)(value));  /* for VT1625 S-Video output */
+            }
+            tv_setting_info.CurrentContrast = value;
+            break;
+            
+        case INTEGRATED_TV:
+            set_integrated_tv_contrast(value);
+            break;
+     }
+}
+
+/* Set TV Saturation function only support VIA TV encoder */
+void tv_set_saturation(u32 value)
+{
+    DEBUG_MSG(KERN_INFO "tv_set_saturation!!\n");
+
+    switch(chip_info.tv_chip_info.tv_chip_name) {
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+        case VT1625:
+            tv_register_write(0x66, (u8)((value >> 8) & 0xFF));
+            tv_register_write(0x67, (u8)(value & 0xFF));
+            tv_register_write(0x0D, (u8)((value >> 8) & 0xFF));
+            tv_register_write(0x0A, (u8)(value & 0xFF));
+            tv_setting_info.CurrentSaturation = value;
+            break;
+
+        case INTEGRATED_TV:
+            set_integrated_tv_saturation(value);
+            break;
+     }
+}
+
+/* Set TV TINT function only support VIA TV encoder */
+void tv_set_tint(u32 value)
+{
+    DEBUG_MSG(KERN_INFO "tv_set_tint!!\n");
+
+    if ((tv_setting_info.out_signal == TV_OUTPUT_RGB) ||
+        (tv_setting_info.out_signal == TV_OUTPUT_YPBPR))
+    {
+        return;
+    }
+
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+        case VT1625:            
+            tv_register_write(0x10, (u8)(value & 0xFF));
+            tv_register_write(0x11, (u8)((tv_register_read(0x11) & ~0x07) | (u8)((value >> 8) & 0xFF)));
+            tv_setting_info.CurrentTINT = value;
+            break;
+
+        /* Add for VT3324 Integrated TV. */
+        case INTEGRATED_TV:
+            set_integrated_tv_hue(value);
+            break;
+            
+        default:
+            break;
+     }
+}
+
+/* Set TV Flicker Filter function only support VIA TV encoder */
+void tv_set_ffilter(u32 state, u32 value)
+{
+    DEBUG_MSG(KERN_INFO "tv_set_ffilter!!\n");
+    
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+        case VT1625:
+            if (state == STATE_ON)
+            {
+                if ((value < 0) || (value > 3))
+                    break;
+                
+                if ((value == 3) && (chip_info.tv_chip_info.tv_chip_name != VT1625))
+                    break;
+            
+                /* Turn off adaptive ffilter. Adaptive ffilter is exclusive with ffilter */
+                tv_register_write(0x62, (u8)(tv_register_read(0x62) & ~0x03));                                           
+
+                /* Tuning the value of flicker filter. */
+                if (value)
+                {
+                    tv_register_write(0x03, (u8)((tv_register_read(0x03) & ~0x03) | (u8)(value)));
+                    tv_setting_info.CurrentFFilter = value;
+                }
+                else /* value should be more than 0. */
+                {
+                    tv_register_write(0x03, (u8)((tv_register_read(0x03) & ~0x03) | (u8)(value+1)));
+                    tv_setting_info.CurrentFFilter = value+1;
+                }
+            }
+            else /* turn off */
+            {
+                tv_register_write(0x03, (u8)((tv_register_read(0x03) & ~0x03)));
+                tv_setting_info.CurrentFFilter = STATE_OFF;
+            }
+           
+            break;
+
+        /* Add for VT3324 Integrated TV. */
+        case INTEGRATED_TV:
+            if (state == STATE_ON)
+            {
+                set_integrated_tv_ffilter_status(ITV_FILTER_TYPE_NORMAL, ITV_FILTER_ON, value);
+            }
+            else
+            {
+                set_integrated_tv_ffilter_status(ITV_FILTER_TYPE_NORMAL, ITV_FILTER_OFF, value);
+            }
+            break;
+            
+        default:
+            break;
+     }
+}
+
+
+
+/* 
+ *  Purpose:
+ *      Set status of TV Adaptive Flicker Filter and its degree. 
+ *      Currently, it only support VIA TV encoder.
+ *  Parameter:
+ *      status: ON/OFF tv adaptive flicker filter function.
+ *      value: Degree of adaptive flicker filter.
+ */
+void tv_set_adaptive_ffilter(u32 status,u32 value)
+{
+    /* Adaptive FFilter ON */
+    if (status == STATE_ON)
+    {
+        switch(chip_info.tv_chip_info.tv_chip_name)
+        {
+            case VT1622:
+            case VT1622A:
+            case VT1623: 
+                /* Turn off normal flicker filter before turn on adaptive ffilter */
+                tv_set_ffilter(STATE_OFF, 0);
+
+                /* Turn on adaptive flicker filter before change the value of deflicker threshold. */
+                tv_register_write(0x62, (u8)((tv_register_read(0x62) & ~0x03)| 0x01));
+                
+                /* Apply the value to deflicker threshold. */             
+                tv_register_write(0x61, (u8)value);
+                
+                /* Change adaptive ffilter state */
+                tv_setting_info.AdaptiveFFilterOn = TRUE;
+                
+                break;
+            
+            case VT1625:
+                /* Turn off normal flicker filter before turn on adaptive ffilter */
+                tv_set_ffilter(STATE_OFF, 0);
+                
+                /* VT1625 only use 62[7:2] to control ffilter threshold */
+                if ((value > 0) && (value < 64))
+                {
+                    /* Turn on adaptive flicker filter and assign value */
+                    tv_register_write(0x62, (u8)(value<<2) | 0x01);
+                }
+
+                /* Change adaptive ffilter state */
+                tv_setting_info.AdaptiveFFilterOn = TRUE;
+                
+                break;
+
+            /* Add for VT3324 Integrated TV. */
+            case INTEGRATED_TV:
+                set_integrated_tv_ffilter_status(ITV_FILTER_TYPE_ADAPTIVE, ITV_FILTER_ON, value);
+                break;
+        }
+    }
+    else  /* Adaptive FFilter OFF */
+    {
+        switch(chip_info.tv_chip_info.tv_chip_name)
+        {
+            case VT1622:
+            case VT1622A:
+            case VT1623:
+            case VT1625:
+                /* Turn off adaptive flicker filter and assign value */
+                tv_register_write(0x62, (u8)(tv_register_read(0x62) & ~0x03));
+                tv_setting_info.AdaptiveFFilterOn = FALSE;
+                break;
+
+            /* Add for VT3324 Integrated TV. */
+            case INTEGRATED_TV:
+                set_integrated_tv_ffilter_status(ITV_FILTER_TYPE_ADAPTIVE, ITV_FILTER_OFF, 0);
+                break;
+        }
+    }
+}
+
+
+
+/*
+*   Purpose:
+*       Get flicker filter value
+*   Parameter:
+*       ffilter_type: which type of flicker filter we want to get.
+*       ffilter_state: this can be used to receive the current ffilter state.
+*   Return:
+*       the value of flicker filter.
+*   
+*/
+int tv_get_ffilter(int ffilter_type, int* ffilter_state)
+{
+    int ffilter_value = 0;
+    int tmp_ffilter_state = 0;
+    
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+        case VT1625:
+            if (ffilter_type == TV_FFILTER_TYPE_NORMAL)
+            {
+                ffilter_value = (tv_register_read(0x03) & 0x03);
+
+                /* flicker filter use 03[1:0]. */
+                if (ffilter_value > 0)
+                {
+                    *ffilter_state = STATE_ON;
+                }
+                else
+                {
+                    *ffilter_state = STATE_OFF;
+                }
+            }
+            
+            if (ffilter_type == TV_FFILTER_TYPE_ADAPTIVE)
+            {
+                if (chip_info.tv_chip_info.tv_chip_name == VT1625)
+                {
+                    /* VT1625 use 62[7:2] to save the value of deflicker threshold. */
+                    ffilter_value = (tv_register_read(0x62) & ~0x03)>>2;
+                    tmp_ffilter_state= tv_register_read(0x62) & 0x03;
+                }
+                else
+                {
+                    ffilter_value = tv_register_read(0x61);
+                    tmp_ffilter_state= tv_register_read(0x62) & 0x03;
+                }
+
+                if (tmp_ffilter_state > 0)
+                {
+                    *ffilter_state = STATE_ON;
+                }
+                else
+                {
+                    *ffilter_state = STATE_OFF;
+                }
+            }
+            break;                       
+
+        /* Add for VT3324 Integrated TV. */
+        case INTEGRATED_TV:
+            if (ffilter_type == TV_FFILTER_TYPE_NORMAL)
+            {
+                ffilter_value = get_integrated_tv_ffilter_status(ITV_FILTER_TYPE_NORMAL, ffilter_state);
+            }            
+            else if (ffilter_type == TV_FFILTER_TYPE_ADAPTIVE)
+            {
+                ffilter_value = get_integrated_tv_ffilter_status(ITV_FILTER_TYPE_ADAPTIVE, ffilter_state);
+            }
+            break;
+    }
+    
+    return ffilter_value;
+}
+
+
+
+/* 
+ *   Purpose:
+ *       Set position of TV's screen.
+ *   Parameter:
+ *       HPos: Horizontal position of screen.
+ *       VPos: Verticle position of screen.
+ */
+void tv_set_position(u32 HPos, u32 VPos)
+{
+    /* Registers of horizontal position : TV06[3:0] + TV08[7:0]
+       Registers of Vertical position: TV1C[3:1] + TV09[7:0] */
+    int new_hor_pos;
+    int new_ver_pos;
+    unsigned char high_bytes;
+    unsigned char low_bytes;
+    
+    if (chip_info.tv_chip_info.tv_chip_name == INTEGRATED_TV)
+    {
+        /* Add for VT3324 Integrated TV. */
+        set_integrated_tv_pos(HPos, VPos);
+    }
+    else /* VIA's TV encoder */
+    { 
+        /* First to get current postion */
+        tv_get_position(&new_hor_pos, &new_ver_pos);
+
+        switch(chip_info.tv_chip_info.tv_chip_name)
+        {
+            case VT1622:
+            case VT1622A:
+            case VT1623:
+                /* Origin position of vt1623 is at down-left corner
+                   New position is current position + shift */
+                new_hor_pos += HPos - tv_setting_info.CurrentPositionH;
+                new_ver_pos += VPos - tv_setting_info.CurrentPositionV;
+            
+                /* Write new value of horizontal position to register. */
+                high_bytes = ((new_hor_pos >> 8) & 0x0F) | tv_register_read(0x06);
+                low_bytes = new_hor_pos & 0xFF;
+                tv_register_write(0x06, high_bytes);
+                tv_register_write(0x08, low_bytes);
+        
+                /* Write new value of vertical position to register. */
+                high_bytes = (((new_ver_pos >> 8) & 0x07) << 1) | tv_register_read(0x1C);
+                low_bytes = new_ver_pos & 0xFF;
+                tv_register_write(0x1C, high_bytes);
+                tv_register_write(0x09, low_bytes);
+                break;
+
+            case VT1625:
+                /* Origin position of vt1625 is at down-right corner
+                   New position is current position + shift */
+                new_hor_pos -= HPos - tv_setting_info.CurrentPositionH;
+                new_ver_pos += VPos - tv_setting_info.CurrentPositionV;
+
+                /* Write new value of horizontal position to register. */
+                high_bytes = ((new_hor_pos >> 8) & 0x0F) | tv_register_read(0x06);
+                low_bytes = new_hor_pos & 0xFF;
+                tv_register_write(0x06, high_bytes);
+                tv_register_write(0x08, low_bytes);
+        
+                /* Write new value of vertical position to register. */
+                high_bytes = (((new_ver_pos >> 8) & 0x07) << 1) | tv_register_read(0x1C);
+                low_bytes = new_ver_pos & 0xFF;
+                tv_register_write(0x1C, high_bytes);
+                tv_register_write(0x09, low_bytes);
+                break;
+
+        
+        }
+    
+        /* Save the value of current position */
+        tv_setting_info.CurrentPositionH = HPos;
+        tv_setting_info.CurrentPositionV = VPos;
+    }
+}
+
+
+
+/* 
+*   Purpose:
+*       Get position of TV's screen.
+*   Parameter:
+*       HPos: Horizontal position of screen.
+*       VPos: Verticle position of screen.
+*/
+void tv_get_position(u32* HPos, u32* VPos)
+{
+    if (chip_info.tv_chip_info.tv_chip_name == INTEGRATED_TV)
+    {
+        get_integrated_tv_pos(HPos, VPos);
+    }
+    else
+    {
+        *HPos = (((tv_register_read(0x06)&0x0F)<<8) | tv_register_read(0x08)) & 0x0FFF;
+        *VPos = (((tv_register_read(0x1C)&0x0E)<<7) | tv_register_read(0x09)) & 0x0FFF;
+    }
+
+}
+
+/* Set TV Flicker Filter function only support VIA TV encoder */
+void tv_set_size(u32 HPos, u32 VPos)
+{
+ 
+    DEBUG_MSG(KERN_INFO "tv_set_size\n");    
+    DEBUG_MSG(KERN_INFO "tv_set_size: pSetViewSizeValue->dwX=%d\n", HPos); 
+    DEBUG_MSG(KERN_INFO "tv_set_size: pSetViewSizeValue->dwY=%d\n", VPos);     
+
+    /* Add for VT3324 Integrated TV. */
+    if (chip_info.tv_chip_info.tv_chip_name == INTEGRATED_TV)
+    {
+        set_integrated_tv_size(HPos, VPos);
+        return;
+    }
+
+    tv_setting_info.CurrentScalH=HPos-1;
+    tv_setting_info.CurrentScalV=VPos-1; 
+
+    switch (chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1621:
+        case VT1622:
+        case VT1622A:
+        case VT1623:     
+            tv_setting_info.level = VPos - 1;
+            break;
+ 
+        case VT1625:     
+            if (VPos == 2)
+                tv_setting_info.level = 2;
+            else
+                tv_setting_info.level = VPos - 1;
+            break;
+            
+
+        default:
+            tv_setting_info.CurrentPositionH = 0;
+            tv_setting_info.CurrentPositionV = 0;
+            break;
+    }
+
+    DEBUG_MSG(KERN_INFO "tv_set_size:After set size, tv_setting_info.level=%d\n", tv_setting_info.level);     
+}
+
+/* Add this function to control TV clock source by case. */
+void set_tv_clock_source(void)
+{
+    if (chip_info.tv_chip_info.tv_chip_name == INTEGRATED_TV)
+    {
+        /* From TVPLL. */
+        if (tv_setting_info.iga_path == IGA1)
+        {
+            write_reg(CR6C, VIACR, 0x50);
+        }
+        else
+        {
+            write_reg(CR6C, VIACR, 0x05);
+        }
+    }
+    else
+    {
+        /* External TV: */
+        if ((chip_info.gfx_chip_name == UNICHROME_CLE266) && 
+            (chip_info.gfx_chip_revision == CLE266_REVISION_AX))
+        {
+            write_reg_mask(CR6C, VIACR, 0x01, BIT0);
+        }
+        else if (chip_info.gfx_chip_name == UNICHROME_CX700)
+        {
+            /* From DVP0 TV clock. */
+            if (tv_setting_info.iga_path == IGA1)
+            {
+                write_reg(CR6C, VIACR, 0xb0);
+            }
+            else
+            {
+                write_reg(CR6C, VIACR, 0x0b);
+            }
+        }
+        else
+        {
+            write_reg_mask(CR6C, VIACR, BIT5+BIT0, BIT5+BIT0);
+        }
+    }
+}
+/*check_macrovision_enabled: to check if MV is enabled 
+*                          according to TV encoder's registers 0x0F and 0x30
+*                          Currently only support VT1622 and VT1623 VT1625
+*                          AlZhang[2006.04.24]
+*/
+int check_macrovision_enabled(void)
+{
+    u8 tv_r0f = 0,tv_r30 = 0;
+    switch(chip_info.tv_chip_info.tv_chip_name)
+    {
+
+    case VT1622:
+    case VT1622A:
+    case VT1623:
+    case VT1625:
+        tv_r0f = (u8)tv_register_read(0x0f);
+        tv_r30 = (u8)tv_register_read(0x30);
+        
+        break;
+    default:
+        break;
+
+    }
+    if((tv_r0f&0x80) && (tv_r30&0x30))
+        return TRUE;
+    else
+        return FALSE;
+}
diff -Nur linux-2.6.21-rc7/drivers/video/via/vt1625.c linux-2.6.21-rc7.viafb/drivers/video/via/vt1625.c
--- linux-2.6.21-rc7/drivers/video/via/vt1625.c 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/vt1625.c 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,521 @@
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
+
+#include "tv.h"
+#include "tbl1625.h"
+#include "share.h"
+#include "chip.h"
+#include "debug.h"
+
+extern inline void lock_crt(void);
+extern inline void unlock_crt(void);
+extern inline void write_reg(u8 index, u16 io_port, u8 data);
+extern void write_reg_mask(u8 index, int io_port, u8 data, u8 mask);
+extern void load_crtc_timing(struct display_timing device_timing, int set_iga);
+extern void write_tv_patch_table(u16 *tv_func_reg);
+extern void plus_vck_to_iga1_timing(unsigned long h_total);
+
+extern struct tv_setting_information    tv_setting_info;
+extern struct chip_information          chip_info;
+
+int  vt1625_tv_encoder_identify(void)
+{
+    int ver;
+
+    ver = tv_register_read(VT1625_VERSION_REG);
+    if (ver == VT1625_VERSION)
+    {
+        DEBUG_MSG(KERN_INFO "\nFind VT1625 TV Encoder \n");
+        return(OK);
+    }
+    else
+        return(FAIL);
+}
+
+void vt1625_tv_disable(void)
+{
+    /* turn off TV's DAC */
+    tv_register_write(0x0E, 0x3F);
+    /* reset TV */
+    tv_register_write(0x1D, 0x00);
+    /* disable reset TV */
+    tv_register_write(0x1D, 0x80);
+}
+
+void write_vt1625_patch_table(vt1625_func_table *func_table, int func_index)
+{
+    u16 *tv_func_reg = NULL;
+    
+    if (tv_setting_info.level == TV_SIZE_NORMAL_SCAN)
+    {
+        tv_func_reg = func_table[func_index].tv_underscan;
+    }
+    else if (tv_setting_info.level == TV_SIZE_FIT_SCAN)
+    {
+        tv_func_reg = func_table[func_index].tv_fitscan;
+    }
+    else if (tv_setting_info.level == TV_SIZE_OVER_SCAN)
+    {
+        tv_func_reg = func_table[func_index].tv_overscan;
+    }
+
+    if (tv_func_reg != NULL)
+    {
+        write_tv_patch_table(tv_func_reg);
+    }
+}
+
+void load_vt1625_regs(int TVModeIndex)
+{
+    int i, index;
+    u8  tmp;
+    vt1625_func_table            *vt1625_func;
+    struct display_timing         tv_crtc_reg;
+    u16                          *tv_reg = NULL;
+
+    for(i=0;i<NUM_TOTAL_VT1625_TABLE;i++)
+    {
+        index = i;
+
+        if(vt1625_tbl[i].tv_index == TVModeIndex)
+            break;
+    }
+
+    switch (tv_setting_info.system)
+    {
+        case TVTYPE_NTSC:
+        case TVTYPE_480P:
+        {
+            /* For 480P, we use NTSC's mode table, and then do some patches later. */
+            vt1625_func = vt1625_tbl[index].tv_mode_ntsc;
+            break;
+        }
+            
+        case TVTYPE_PAL:
+        case TVTYPE_576P:
+        {
+            /* For 576P, we use PAL's mode table, and then do some patches later. */
+            vt1625_func = vt1625_tbl[index].tv_mode_pal;
+            break;
+        }
+
+        case TVTYPE_720P:
+        {
+            vt1625_func = vt1625_tbl[index].tv_mode_720p;
+            break;
+        }
+
+        case TVTYPE_1080I:
+        {
+            vt1625_func = vt1625_tbl[index].tv_mode_1080i;
+            break;
+        }
+
+        default:
+        {
+            vt1625_func = vt1625_tbl[index].tv_mode_ntsc;
+            break;
+        }
+    }
+
+
+    if (tv_setting_info.level == TV_SIZE_NORMAL_SCAN)
+    {
+        tv_reg = vt1625_func[0].tv_underscan;
+    }
+    
+    if (tv_setting_info.level == TV_SIZE_FIT_SCAN)
+    {
+        tv_reg = vt1625_func[0].tv_fitscan;
+    }
+    
+    if (tv_setting_info.level == TV_SIZE_OVER_SCAN)
+    {
+        tv_reg = vt1625_func[0].tv_overscan;
+    }
+
+    /* unlock CRTC Register */
+    unlock_crt();
+
+    /* update starting address */
+    write_reg(CR0C, VIACR, 0x00);
+    write_reg(CR0D, VIACR, 0x00);
+
+    write_reg_mask(CR48, VIACR, 0x00, BIT0+BIT1);
+
+    /* Load TV Encoder Regsiters */
+    for (i=0;i<NUM_TOTAL_VT1625_REG;i++)
+    {
+        tv_register_write(GET_LOW_BYTE(tv_reg[i]),GET_HIGH_BYTE(tv_reg[i]));
+    }
+
+    /* Load GFX CRTC timing when TV work on IGA1 */
+    for (i=0; i< NUM_CRTC_TIMING; i++)
+    {
+        switch(i)
+        {
+            case H_TOTAL_INDEX:
+                tv_crtc_reg.hor_total = tv_reg[i+NUM_TOTAL_VT1625_REG];
+                break;
+            case H_ADDR_INDEX:
+                tv_crtc_reg.hor_addr = tv_reg[i+NUM_TOTAL_VT1625_REG];
+                break;
+            case H_BLANK_START_INDEX:
+                tv_crtc_reg.hor_blank_start = tv_reg[i+NUM_TOTAL_VT1625_REG];
+                break;
+            case H_BLANK_END_INDEX:
+                tv_crtc_reg.hor_blank_end = tv_reg[i+NUM_TOTAL_VT1625_REG];
+                break;
+            case H_SYNC_START_INDEX:
+                tv_crtc_reg.hor_sync_start = tv_reg[i+NUM_TOTAL_VT1625_REG];
+                break;
+            case H_SYNC_END_INDEX:
+                tv_crtc_reg.hor_sync_end = tv_reg[i+NUM_TOTAL_VT1625_REG];
+                break;
+            case V_TOTAL_INDEX:
+                tv_crtc_reg.ver_total = tv_reg[i+NUM_TOTAL_VT1625_REG];
+                break;
+            case V_ADDR_INDEX:
+                tv_crtc_reg.ver_addr = tv_reg[i+NUM_TOTAL_VT1625_REG];
+                break;
+            case V_BLANK_START_INDEX:
+                tv_crtc_reg.ver_blank_start = tv_reg[i+NUM_TOTAL_VT1625_REG];
+                break;
+            case V_BLANK_END_INDEX:
+                tv_crtc_reg.ver_blank_end = tv_reg[i+NUM_TOTAL_VT1625_REG];
+                break;
+            case V_SYNC_START_INDEX:
+                tv_crtc_reg.ver_sync_start = tv_reg[i+NUM_TOTAL_VT1625_REG];
+                break;
+            case V_SYNC_END_INDEX:
+                tv_crtc_reg.ver_sync_end = tv_reg[i+NUM_TOTAL_VT1625_REG];
+                break;
+        }
+    }
+
+    if (tv_setting_info.iga_path == IGA1)
+    {
+        load_crtc_timing(tv_crtc_reg, IGA1);
+
+        /* patch TV IGA1 horizontal total can't be divided by 8 */        
+        if ((chip_info.tv_chip_info.tv_chip_name == VT1625) && 
+            ((chip_info.gfx_chip_name == UNICHROME_P880) || (chip_info.gfx_chip_name == UNICHROME_CN900)))
+        {
+            plus_vck_to_iga1_timing(tv_crtc_reg.hor_total);
+        }
+    }
+    else
+    {
+        load_crtc_timing(tv_crtc_reg, IGA2);
+        write_reg(CR65, VIACR, 0x80);
+        write_reg(CR66, VIACR, 0x00);
+        write_reg(CR67, VIACR, 0x41);
+    }
+
+    /* Load CGMS registers */
+    for (i=0;i<NUM_TOTAL_VT1625_CGMS_TBL;i++)
+    {
+        tv_register_write(GET_LOW_BYTE(VT1625_CGMS_TBL[i]),GET_HIGH_BYTE(VT1625_CGMS_TBL[i]));
+    }
+
+    DEBUG_MSG(KERN_INFO "\n tv_out_signal = %2d \n", tv_setting_info.out_signal);
+
+    /* Patch for RGB/YPbPr connector */
+    if (tv_setting_info.out_signal & (TV_OUTPUT_RGB | TV_OUTPUT_RGB_COMPOSITE | TV_OUTPUT_RGB_COMPOSITE_SVIDEO))
+    {
+        write_vt1625_patch_table(vt1625_func, TV_RGB_FUNC);
+    }
+    else if (tv_setting_info.out_signal & (TV_OUTPUT_YPBPR | TV_OUTPUT_YPBPR_COMPOSITE | TV_OUTPUT_YPBPR_COMPOSITE_SVIDEO))
+    {
+        write_vt1625_patch_table(vt1625_func, TV_YPBPR_FUNC);
+    }
+
+    /* Patch for SDTV */
+    if ((tv_setting_info.system == TVTYPE_480P) || (tv_setting_info.system == TVTYPE_576P))
+    {
+        if (tv_setting_info.out_signal == TV_OUTPUT_RGB)
+        {
+            write_vt1625_patch_table(vt1625_func, TV_SDTV_RGB_FUNC);
+        }
+        else if (tv_setting_info.out_signal == TV_OUTPUT_YPBPR)
+        {
+            write_vt1625_patch_table(vt1625_func, TV_SDTV_YPBPR_FUNC);
+        }
+    }
+
+    /* Patch for DeDotCrawl function */
+    if ((tv_setting_info.dedotcrawl == 1) && 
+        (tv_setting_info.out_signal== TV_OUTPUT_COMPOSITE) && 
+        (tv_setting_info.system == TVTYPE_NTSC))
+    {
+        tmp = (u8) tv_register_read(VT1625_DEDOTCRAWL_REG);
+        tv_register_write(VT1625_DEDOTCRAWL_REG, tmp | BIT3);
+        
+        write_vt1625_patch_table(vt1625_func, TV_DeDotCrawl_FUNC);
+    }
+     
+    lock_crt();
+}
+
+void vt1625_tv_enable(void)
+{
+    u8  data;
+
+    data = (u8)tv_register_read(VT1625_DAC_REG);
+
+    /*  turn on TV's DAC */
+    switch(tv_setting_info.out_signal)
+    {
+        case TV_OUTPUT_COMPOSITE:
+            data = (data & 0xC0)|((~VT1625_DAC_C)&0x3F);
+            break;
+        case TV_OUTPUT_SVIDEO:
+            data = (data & 0xC0)|((~(VT1625_DAC_A+VT1625_DAC_B))&0x3F);
+            break;
+        case TV_OUTPUT_COMPOSITE_SVIDEO:
+            data = (data & 0xC0)|((~(VT1625_DAC_A+VT1625_DAC_B+VT1625_DAC_C))&0x3F);
+            break;
+        case TV_OUTPUT_RGB_COMPOSITE:
+        case TV_OUTPUT_YPBPR_COMPOSITE:
+            data = (data & 0xC0)|((~(VT1625_DAC_C+VT1625_DAC_D+VT1625_DAC_E+VT1625_DAC_F))&0x3F);
+            break;
+        case TV_OUTPUT_RGB:
+        case TV_OUTPUT_YPBPR:
+            data = (data & 0xC0)|((~(VT1625_DAC_D+VT1625_DAC_E+VT1625_DAC_F))&0x3F);
+            break;
+        case TV_OUTPUT_RGB_COMPOSITE_SVIDEO:
+        case TV_OUTPUT_YPBPR_COMPOSITE_SVIDEO:
+            data = (data & 0xC0)|((~(VT1625_DAC_A+VT1625_DAC_B+VT1625_DAC_C+VT1625_DAC_D+VT1625_DAC_E+VT1625_DAC_F))&0x3F);
+            break;
+        default:
+            data = (data & 0xC0)|((~(VT1625_DAC_A+VT1625_DAC_B+VT1625_DAC_C))&0x3F);
+            break;
+    }
+
+    tv_register_write(VT1625_DAC_REG, data);
+}
+
+
+/* Sense VT1625 TV Encoder */
+int vt1625_sense(void)
+{
+    u8  Reg_TV0E, Reg_TV1C,  Reg_TV0F = 0;
+    int ret;
+
+    DEBUG_MSG(KERN_INFO "vt1625_sense!!\n");
+
+    /* Fill sense data */
+    tv_register_write(0x69, 0x90);
+    tv_register_write(0x6A, 0x02);
+
+    Reg_TV0E = (u8)tv_register_read(0x0E);
+    tv_register_write(0x0E, 0x0);
+    Reg_TV1C = (u8)tv_register_read(0x1C);
+    tv_register_write(0x1C, 0x80);
+    tv_register_write(0x1C, Reg_TV1C);
+    Reg_TV0F = (u8)tv_register_read(0x0F);
+    tv_register_write(0x0E, Reg_TV0E);
+
+    switch (Reg_TV0F&0x3F)
+    {
+        case 0x03:  /* DAC A, B, C, D (?)*/
+            ret = TV_OUTPUT_RGB;
+            break;
+        case 0x07:  /* DAC A, B, C */
+            ret = TV_OUTPUT_COMPOSITE_SVIDEO;
+            break;
+        case 0x0F:  /* DAC A, B */
+            ret = TV_OUTPUT_SVIDEO;
+            break;
+        case 0x38:  /* DAC D, E, F */
+            ret = TV_OUTPUT_YPBPR;
+            break;
+        case 0x37:  /* DAC C */
+            ret = TV_OUTPUT_COMPOSITE;
+            break;
+        case 0x0:  /* DAC A, B, C, D, E, F */
+        case 0x10:  /* S-Video C may not be detected. */
+            ret = TV_OUTPUT_YPBPR_COMPOSITE_SVIDEO;
+            break;
+        case 0x3F:
+            ret = TV_OUTPUT_NONE;
+            break;
+        default:
+            ret = TV_OUTPUT_COMPOSITE_SVIDEO;
+            break;
+    }
+    
+    return ret;
+}
+
+/* Auto-sense VT1625 TV Encoder */
+int vt1625_auto_sense(void)
+{
+    u8  reg_tv1c, status = 0x0;
+    int ret;
+
+    DEBUG_MSG(KERN_INFO "vt1625_auto_sense!!\n");
+
+    /* Enable TV auto sense. */
+    reg_tv1c = (u8)tv_register_read(0x1C) | 0x40;
+    tv_register_write(0x1C, reg_tv1c);
+
+    /* Fill sense data */
+    tv_register_write(0x69, 0x90);
+    tv_register_write(0x6A, 0x02);
+
+    status = (u8)tv_register_read(0x0F);
+
+    /* Disable TV auto sense. */
+    reg_tv1c = (u8)tv_register_read(0x1C) & 0xBF;
+    tv_register_write(0x1C, reg_tv1c);
+
+    switch (status&0x3F)
+    {
+        case 0x03:  /* DAC A, B, C, D (?)*/
+            ret = TV_OUTPUT_RGB;
+            break;
+        case 0x07:  /* DAC A, B, C */
+            ret = TV_OUTPUT_COMPOSITE_SVIDEO;
+            break;
+        case 0x0F:  /* DAC A, B */
+            ret = TV_OUTPUT_SVIDEO;
+            break;
+        case 0x38:  /* DAC D, E, F */
+            ret = TV_OUTPUT_YPBPR;
+            break;
+        case 0x37:  /* DAC C */
+            ret = TV_OUTPUT_COMPOSITE;
+            break;
+        case 0x0:  /* DAC A, B, C, D, E, F */
+        case 0x10:  /* S-Video C may not be detected. */
+            ret = TV_OUTPUT_YPBPR_COMPOSITE_SVIDEO;
+            break;
+        case 0x3F:
+            ret = TV_OUTPUT_NONE;
+            break;
+        default:
+            ret = TV_OUTPUT_COMPOSITE_SVIDEO;
+            break;
+    }
+
+    return ret;
+}
+
+void init_tv_vt1625(void)
+{
+    /* TV 5 init value */
+    tv_register_write(0x4A, 0xC5);   /* DAC A/B/C/D select */
+    tv_register_write(0x4B, 0x0F);   /* DAC E/F select */
+    tv_register_write(0x69, 0x90);   /* init sense data */
+    tv_register_write(0x6A, 0x02);   /* init sense data */
+    tv_register_write(0x1C, 0);
+}
+bool is_vt1625_mode(struct tv_chip_information* ptv_chip_info, struct tv_setting_information* ptv_setting_info,
+                             int video_index)
+{
+    vt1625_func_table    *vt1625_func;
+    u16  *tv_reg = NULL;
+    int i, index;
+    if (VIA_RES_640X480 == video_index ||VIA_RES_800X600 == video_index ||
+        VIA_RES_1024X768 == video_index || VIA_RES_720X480 == video_index ||
+        VIA_RES_720X576 == video_index || VIA_RES_1280X720 == video_index ||
+        VIA_RES_1920X1080 == video_index)
+        {
+            for(i=0;i<NUM_TOTAL_VT1625_TABLE;i++)
+            {
+                index = i;
+
+                if(vt1625_tbl[i].tv_index == video_index)
+                    break;
+            }
+
+            switch (ptv_setting_info->system)
+            {
+                case TVTYPE_NTSC:
+                case TVTYPE_480P:
+                {
+                    /* For 480P, we use NTSC's mode table, and then do some patches later. */
+                    vt1625_func = vt1625_tbl[index].tv_mode_ntsc;
+                    break;
+                }
+                    
+                case TVTYPE_PAL:
+                case TVTYPE_576P:
+                {
+                    /* For 576P, we use PAL's mode table, and then do some patches later. */
+                    vt1625_func = vt1625_tbl[index].tv_mode_pal;
+                    break;
+                }
+
+                case TVTYPE_720P:
+                {
+                    vt1625_func = vt1625_tbl[index].tv_mode_720p;
+                    break;
+                }
+
+                case TVTYPE_1080I:
+                {
+                    vt1625_func = vt1625_tbl[index].tv_mode_1080i;
+                    break;
+                }
+
+                default:
+                {
+                    vt1625_func = vt1625_tbl[index].tv_mode_ntsc;
+                    break;
+                }
+            }
+            if(IS_VT1625_NULL_TBL(vt1625_func))
+            {
+                WARN_MSG(KERN_WARNING "The specified tv mode is not valid under specified tv system\n");
+                return FALSE;
+            }
+            if (ptv_setting_info->level == TV_SIZE_NORMAL_SCAN)
+            {
+                tv_reg = vt1625_func[0].tv_underscan;
+            }
+            
+            if (ptv_setting_info->level == TV_SIZE_FIT_SCAN)
+            {
+                tv_reg = vt1625_func[0].tv_fitscan;
+            }
+            
+            if (ptv_setting_info->level == TV_SIZE_OVER_SCAN)
+            {
+                tv_reg = vt1625_func[0].tv_overscan;
+            }
+            if(IS_VT1625_NULL_FUNC(tv_reg))
+            {
+                WARN_MSG(KERN_WARNING "The specified tv level is not valid under spcified combination of tv mode and system\n");
+                return FALSE;
+            }
+            return TRUE;
+        }
+        WARN_MSG(KERN_WARNING "The specified tv mode is not valid for currently used  tv encoder\n");
+        return FALSE;
+}

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
