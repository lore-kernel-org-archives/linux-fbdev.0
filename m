From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 12/12] viafb: Framebuffer driver for VIA
 UniChrome/Chrome9 HC (fwd)
Date: Mon, 30 Apr 2007 10:38:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704301038020.27246@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiROf-0006dJ-4J for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:38:13 -0700
Received: from assei1bl6.telenet-ops.be ([195.130.133.68])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiROd-0002Fz-Jl
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:38:13 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by assei1bl6.telenet-ops.be (Postfix) with SMTP id B2C7E2200B7
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:38:10 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by assei1bl6.telenet-ops.be (Postfix) with ESMTP id 058F52200B9
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:38:07 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l3U8c7A7020486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:38:07 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l3U8c75x020483
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:38:07 +0200
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
Date: Mon, 30 Apr 2007 13:21:02 +0800
From: EddyFu@via.com.tw
To: linux-fbdev-devel-bounces@lists.sourceforge.net
Subject: [Linux-fbdev-devel] [PATCH 12/12] viafb: Framebuffer driver for VIA
    UniChrome/Chrome9 HC

Dear All, 
 
Here is the part 12/12 of viafb.
 
Best Regards,
Eddy Fu 
 
diff -Nur linux-2.6.21-rc7/drivers/video/via/via_utility.c linux-2.6.21-rc7.viafb/drivers/video/via/via_utility.c
--- linux-2.6.21-rc7/drivers/video/via/via_utility.c 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/via_utility.c 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,645 @@
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
+#include <linux/version.h>
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
+#include <linux/config.h>
+#endif
+#include <linux/ioport.h>
+#include <linux/fb.h>
+#include <asm/io.h>
+
+
+#include "share.h"
+#include "chip.h"
+#include "lcd.h"
+#include "tv.h"
+#include "ioctl.h"
+#include "debug.h"
+
+/* Extern variable */
+extern int CRT_ON, TV_ON, DVI_ON, LCD_ON,SAMM_ON;
+extern int lcd_panel_id;
+extern long tv_out_signal;
+extern long tv_system;
+extern int DeviceStatus;
+
+/* Extern struct */
+extern struct chip_information chip_info;
+extern struct tv_setting_information tv_setting_info;
+
+/* Extern function */
+extern void write_reg_mask(u8 index, int io_port, u8 data, u8 mask);
+extern u8 read_reg(int io_port, u8 index);
+extern void write_reg(u8 index, u16 io_port, u8 data);
+extern int tv_sense(void);
+extern int dvi_sense(void);
+extern bool lcd_get_mobile_state(bool* mobile);
+
+
+
+
+/*  
+ *   Purpose:
+ *       Get device support state.
+ *   Parameter:
+ *       support_state: a bitwise value used to indicate which device can be supported.
+ */
+void get_device_support_state(u32* support_state)
+{  
+    *support_state = CRT_Device;
+    if ((chip_info.tv_chip_info.tv_chip_name == VT1622A) ||
+        (chip_info.tv_chip_info.tv_chip_name == VT1623) ||
+        (chip_info.tv_chip_info.tv_chip_name == VT1625) ||
+        (chip_info.tv_chip_info.tv_chip_name == INTEGRATED_TV))
+    {
+        *support_state |= (TV_Device | HDTV_Device);
+    }
+    
+    if (chip_info.tmds_chip_info.tmds_chip_name == VT1632_TMDS)
+    {
+        *support_state |= DVI_Device;
+    }
+    
+    if (chip_info.lvds_chip_info.lvds_chip_name == VT1631_LVDS)
+    {
+        *support_state |= LCD_Device;
+    }
+}
+
+
+
+/* 
+ *    Purpose:
+ *        Get device connect state.
+ *    Parameter:
+ *        connect_state: a bitwise value used to indicate which device are connected.
+ */
+void get_device_connect_state(u32* connect_state)
+{   
+    bool mobile = FALSE;
+    
+    *connect_state = CRT_Device; /* default CRT always connect */
+    
+    if (tv_sense())
+    {        
+        *connect_state |= (TV_Device | HDTV_Device);
+    }
+    
+    if (dvi_sense())
+    {
+        *connect_state |= DVI_Device;
+    }
+    
+    lcd_get_mobile_state(&mobile); /* read BIOS */
+    if (mobile)
+    {
+        *connect_state |= LCD_Device;
+    }
+}
+
+
+
+/* 
+ *    Purpose:
+ *       To know if lcd can support expand function.
+ *    Parameter:
+ *       xres: horizontal resolution.
+ *       yres: vertical resolution.
+ *    Return:
+ *       A boolean value used to indicate if expand function can be support.
+ */
+bool lcd_get_support_expand_state(u32 xres, u32 yres)
+{
+    unsigned int support_state = 0;
+    
+    switch (lcd_panel_id)
+    {
+        case LCD_PANEL_ID0_640X480:
+            if ((xres < 640) && (yres < 480))
+            {
+                support_state = TRUE;
+            }
+            break;
+            
+        case LCD_PANEL_ID1_800X600:
+            if ((xres < 800) && (yres < 600))
+            {
+                support_state = TRUE;
+            }            
+            break;
+            
+        case LCD_PANEL_ID2_1024X768:
+            if ((xres < 1024) && (yres < 768))
+            {
+                support_state = TRUE;
+            }
+            break;
+            
+        case LCD_PANEL_ID3_1280X768:
+            if ((xres < 1280) && (yres < 768))
+            {
+                support_state = TRUE;
+            }
+            break;
+            
+        case LCD_PANEL_ID4_1280X1024:
+            if ((xres < 1280) && (yres < 1024))
+            {
+                support_state = TRUE;
+            }
+            break;
+            
+        case LCD_PANEL_ID5_1400X1050:
+            if ((xres < 1400) && (yres < 1050))
+            {
+                support_state = TRUE;
+            }
+            break;
+            
+        case LCD_PANEL_ID6_1600X1200:
+            if ((xres < 1600) && (yres < 1200))
+            {
+                support_state = TRUE;
+            }
+            break;
+            
+        case LCD_PANEL_ID7_1366X768:
+            if ((xres < 1366) && (yres < 768))
+            {
+                support_state = TRUE;
+            }
+            break;
+            
+        default:
+            support_state = FALSE;
+            break;
+    }
+
+    return support_state;
+}
+
+
+/*=======================================================================================*/
+/*                      TV Function Implementation                                       */
+/*=======================================================================================*/
+
+/* 
+ *    Purpose:
+ *        To know which tv standard we can support.
+ *    Parameter:
+ *        support_state: a bitwise value used to indicate which tv standard we can support.
+ */
+void tv_get_support_standard(u32* support_state)
+{
+    switch (chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622A:
+        case VT1623:
+            *support_state = TVTYPE_NTSC | TVTYPE_PAL | TVTYPE_480P | TVTYPE_576P;
+            break;
+        case VT1625:
+        case INTEGRATED_TV:
+            *support_state = TVTYPE_NTSC | TVTYPE_PAL | TVTYPE_480P | TVTYPE_576P | TVTYPE_720P | TVTYPE_1080I;
+            break;
+    }
+}
+
+
+/* 
+ *    Purpose:
+ *        To know which tv signal we can support.
+ *    Parameter:
+ *        support_state: a bitwise value used to indicate which tv signal we can support.
+ */
+void tv_get_support_signal(u32* support_state)
+{
+    switch (chip_info.tv_chip_info.tv_chip_name)
+    {
+            case VT1621:
+                *support_state = TV_OUTPUT_COMPOSITE | TV_OUTPUT_SVIDEO;
+                break;
+            
+            case VT1622:
+            case VT1622A:
+            case VT1623:
+            case VT1625:
+            case INTEGRATED_TV:
+                *support_state = TV_OUTPUT_COMPOSITE | TV_OUTPUT_SVIDEO | TV_OUTPUT_RGB | TV_OUTPUT_YPBPR
+                                | TV_OUTPUT_COMPOSITE_SVIDEO | TV_OUTPUT_RGB_COMPOSITE | TV_OUTPUT_YPBPR_COMPOSITE
+                                | TV_OUTPUT_RGB_COMPOSITE_SVIDEO| TV_OUTPUT_YPBPR_COMPOSITE_SVIDEO;
+                break;
+            
+            default:
+                *support_state = 0;
+                break;
+    }
+}
+
+
+
+/* 
+ *    Purpose:
+ *        To know what max degree of tv size is.
+ *    Return:
+ *        Max value of tv size.
+ */
+int tv_get_max_size(void)
+{
+    int max_size;
+    switch (chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622A:
+        case VT1623:
+        case VT1625:
+            max_size = TV_SIZE_LEVEL_MAXIMUM;
+            break;
+            
+        case INTEGRATED_TV:
+            max_size = 20;
+            break;
+            
+        default:
+            max_size = 0;
+            break;
+    }
+    return max_size;
+}
+
+
+
+/* 
+ *    Purpose:
+ *        To know which tv tuning operations we can support.
+ *    Parameter:
+ *        support_state: a bitwise value used to indicate which tv tuning operations we can support.
+ */
+void tv_get_support_tuning_state(u32* support_state)
+{
+    switch (chip_info.tv_chip_info.tv_chip_name)
+    {
+        case VT1622A:
+        case VT1623:
+        case VT1625:
+        case INTEGRATED_TV:
+            *support_state = OP_TV_TUNING_FFILTER | OP_TV_TUNING_ADAPTIVE_FFILTER |
+                OP_TV_BRIGHTNESS | OP_TV_CONTRAST | OP_TV_SATURATION;
+            if ((tv_out_signal != TV_OUTPUT_NONE) && !(tv_out_signal & (TV_OUTPUT_RGB | TV_OUTPUT_YPBPR)))
+            {
+                *support_state |= OP_TV_TINT;
+            }
+            break;
+        
+        default:
+            *support_state = 0;
+            break;
+    }
+}
+
+
+
+/* 
+ *    Purpose:
+ *        To get the max value of tv tuning item.
+ *    Parameter:
+ *        item: indicate which tuning item we want to get.
+ *        value: A pointer to max value of tuning item.
+ */
+void tv_get_tuning_max_value(u32 item, u32* value)
+{
+    switch (item)
+    {
+        case OP_TV_BRIGHTNESS:
+            *value = TV_BRIGHTNESS_MAXIMUM;
+            break;
+        
+        case OP_TV_CONTRAST:
+            if (chip_info.tv_chip_info.tv_chip_name == INTEGRATED_TV)
+            {
+                *value = 0x1FF; /* integrated TV use 9 bits to set contrast. */
+            }
+            else
+            {
+                *value = TV_CONTRAST_MAXIMUM;
+            }            
+            break;
+        
+        case OP_TV_SATURATION:
+            if (chip_info.tv_chip_info.tv_chip_name == INTEGRATED_TV)
+            {
+                *value = 0x3FFFF; /* integrated TV use 18 bits to set saturation. */
+            }
+            else
+            {
+                *value = TV_SATURATION_MAXIMUM;
+            }
+            break;
+        
+        case OP_TV_TINT:
+            *value = TV_TINT_MAXIMUM;
+            break;
+        
+        case OP_TV_TUNING_FFILTER:
+            if (chip_info.tv_chip_info.tv_chip_name == VT1625)
+            {
+                *value = TV_FFILTER_MAXIMUM;
+            }
+            else if (chip_info.tv_chip_info.tv_chip_name == INTEGRATED_TV)
+            {
+                *value = 1;
+            }
+            else
+            {
+                *value = TV_FFILTER_MAXIMUM- 1;
+            }
+            break;
+        
+        case OP_TV_TUNING_ADAPTIVE_FFILTER:
+            if (chip_info.tv_chip_info.tv_chip_name == VT1625)
+            {
+                *value = 63; /* VT1625 only use 6 bits to set threshold */
+            }
+            else if (chip_info.tv_chip_info.tv_chip_name == INTEGRATED_TV)
+            {
+                *value = 1023; /* Integrated tv use 10 bit to set threshold. */
+            }
+            else
+            {
+                *value = TV_ADAPTIVE_FFILTER_MAXIMUM;
+            }
+            break;
+        
+        default:
+            *value = 0;
+            break;
+    }
+    
+}
+
+
+
+/* 
+ *    Purpose:
+ *        To know which tv setting operations we can support.
+ *    Parameter:
+ *        support_state: a bitwise value used to indicate which tv setting operations we can support.
+ */
+void tv_get_support_setting_state(u32* support_state)
+{
+    *support_state |= OP_TV_SETTING_FFILTER;
+    switch (chip_info.tv_chip_info.tv_chip_name){
+        case VT1622:
+        case VT1622A:
+        case VT1623:
+        case VT1625:
+            *support_state |= OP_TV_SETTING_ADAPTIVE_FFILTER;
+            if (tv_system == TVTYPE_NTSC && (tv_out_signal & TV_OUTPUT_COMPOSITE))
+            {
+                *support_state |= OP_TV_DEDOTCRAWL;
+            }
+            break;
+            
+        default:
+            *support_state = 0;
+        break;
+    }
+}
+
+
+
+
+/*=======================================================================================*/
+/*                      Gamma Function Implementation                                    */
+/*=======================================================================================*/
+
+/* 
+ *      Purpose:
+ *          Set gamma table to adjust screen color.
+ *      Parameter:
+ *          bpp: bits per pixel, 8 bpp mode can't adjust gamma.
+ *          gamma_table: an array that save the color value of RGB.
+ */
+void set_gamma_table(int bpp, unsigned int* gamma_table)
+{
+    int i, sr1a;
+    int active_device_amount = 0;
+    int device_status = DeviceStatus;
+    unsigned char color_r[256];
+    unsigned char color_g[256];
+    unsigned char color_b[256];
+
+    for (i=0; i<sizeof(DeviceStatus)*8; i++)
+    {
+        if (device_status & 1)
+        {
+            active_device_amount++;
+        }
+        device_status >>= 1;
+    }
+    
+    for (i=0; i<256; i++)
+    {
+        color_r[i] = gamma_table[i] >> 16;
+        color_g[i] = (gamma_table[i] >> 8) & 0x00FF;
+        color_b[i] = gamma_table[i] & 0x000000FF;
+    }
+
+    
+    /* 8 bpp mode can't adjust gamma */
+    if (!(bpp == 8))
+    {
+        /* Enable Gamma */
+        switch (chip_info.gfx_chip_name)
+        {
+            case UNICHROME_CLE266:
+            case UNICHROME_K400:
+                write_reg_mask(SR16, VIASR, 0x80, BIT7);
+                break;
+                
+            case UNICHROME_K800:
+            case UNICHROME_P880:
+            case UNICHROME_CN900:
+            case UNICHROME_CX700:
+            case UNICHROME_K8M890:
+            case UNICHROME_P4M890:
+            case UNICHROME_P4M900:
+                write_reg_mask(CR33, VIACR, 0x80, BIT7);
+                break;
+        }
+        sr1a = read_reg(VIASR, SR1A);
+        write_reg_mask(SR1A, VIASR, 0x0, BIT0); /* map to IGA1 LUT */
+        
+        /* Fill IGA1 Gamma Table */
+        outb(0, LUT_INDEX_WRITE);
+        for (i = 0; i < 256; i++)
+        {
+            outb(color_r[i], LUT_DATA);
+            outb(color_g[i], LUT_DATA);
+            outb(color_b[i], LUT_DATA);
+        }
+        
+        /* If adjust Gamma value in SAMM, fill IGA1,IGA2 Gamma table simultanous.*/
+        /* Switch to IGA2 Gamma Table */
+        if ((active_device_amount>1) &&
+            !((chip_info.gfx_chip_name == UNICHROME_CLE266) &&
+              (chip_info.gfx_chip_revision <15)))
+        {
+            write_reg_mask(SR1A, VIASR, 0x01, BIT0);  /* map to IGA2 LUT */    
+            write_reg_mask(CR6A, VIACR, 0x02, BIT1);  /* LCD GAMMA Enable */
+                    
+            /* Fill IGA2 Gamma Table */
+            outb(0, LUT_INDEX_WRITE);
+            for (i = 0; i < 256; i++)
+            {
+                outb(color_r[i], LUT_DATA);
+                outb(color_g[i], LUT_DATA);
+                outb(color_b[i], LUT_DATA);
+            }
+        }
+        write_reg(SR1A, VIASR, sr1a);        
+    }
+}
+
+
+
+/* 
+ *      Purpose:
+ *          Get current gamma table.
+ *      Parameter:
+ *          gamma_table: an array which save the color value.
+ */
+void get_gamma_table(unsigned int* gamma_table)
+{
+    unsigned char color_r[256];
+    unsigned char color_g[256];
+    unsigned char color_b[256];
+    unsigned char sr1a = 0;
+    int i;
+
+    /* Enable Gamma */
+        switch (chip_info.gfx_chip_name)
+        {
+            case UNICHROME_CLE266:
+            case UNICHROME_K400:
+                write_reg_mask(SR16, VIASR, 0x80, BIT7);
+                break;
+                
+            case UNICHROME_K800:
+            case UNICHROME_P880:
+            case UNICHROME_CN900:
+            case UNICHROME_CX700:
+            case UNICHROME_K8M890:
+            case UNICHROME_P4M890:
+            case UNICHROME_P4M900:
+                write_reg_mask(CR33, VIACR, 0x80, BIT7);
+                break;
+        }
+        sr1a = read_reg(VIASR, SR1A);
+        write_reg_mask(SR1A, VIASR, 0x0, BIT0);
+        
+    /* Reading gamma table to get color value */
+    outb(0, LUT_INDEX_READ);
+    for (i = 0; i < 256; i++)
+    {
+        color_r[i] = inb(LUT_DATA);
+        color_g[i] = inb(LUT_DATA);
+        color_b[i] = inb(LUT_DATA);
+        gamma_table[i] = ((((u32)color_r[i])<<16) | (((u16)color_g[i])<<8)) | color_b[i];
+    }
+    write_reg(SR1A, VIASR, sr1a);
+}
+
+
+/* 
+ *      Purpose:
+ *          To know which device we can support for gamma operation.
+ *      Parameter:
+ *          bpp: bits per pixel, 8 bpp mode can't adjust gamma on any device.
+ *          support_state: indicate which device we can support for gamma operation.
+ */
+void get_gamma_support_state(int bpp, unsigned int* support_state)
+{
+    if (bpp == 8)
+    {
+        *support_state = None_Device;
+    }
+    else
+    {
+        *support_state = CRT_Device | TV_Device| DVI_Device| LCD_Device;
+    }
+}
+
+/*
+ *     Purpose: convert a serial number into bitwise value.
+ */
+int input_parameter_converter(int parameter_value)
+{    
+    int result;
+
+    switch (parameter_value)
+    {                    
+        case 1:
+            result = 0x01;
+            break;
+
+        case 2:
+            result = 0x02;
+            break;            
+
+        case 3:
+            result = 0x04;
+            break;
+            
+        case 4:
+            result = 0x08;
+            break;
+            
+        case 5:
+            result = 0x10;
+            break;
+            
+        case 6:
+            result = 0x20;
+            break;
+
+        case 7:
+            result = 0x40;
+            break;
+            
+        case 8:
+            result = 0x80;
+            break;
+
+        case 9:
+            result = 0x100;
+            break;
+
+        default:
+            result = 0x01;
+            break;
+    }
+
+    return result;
+}
diff -Nur linux-2.6.21-rc7/drivers/video/via/via_utility.h linux-2.6.21-rc7.viafb/drivers/video/via/via_utility.h
--- linux-2.6.21-rc7/drivers/video/via/via_utility.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/via_utility.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,49 @@
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
+#ifndef __VIAUTILITY_H__
+#define __VIAUTILITY_H__
+ 
+/* These functions are used to get infomation about device's state */
+void get_device_support_state(u32* support_state);
+void get_device_connect_state(u32* connect_state);
+bool lcd_get_support_expand_state(u32 xres, u32 yres);
+
+/* These functions are used to get infomation about tv's setting */
+void tv_get_support_standard(u32* support_state);
+void tv_get_support_signal(u32* support_state);
+int tv_get_max_size(void);
+void tv_get_support_tuning_state(u32* support_state);
+void tv_get_tuning_max_value(u32 item, u32* value);
+void tv_get_support_setting_state(u32* support_state);
+
+/* These function are used to access gamma table */
+void set_gamma_table(int bpp, unsigned int* gamma_table);
+void get_gamma_table(unsigned int* gamma_table);
+void get_gamma_support_state(int bpp, unsigned int* support_state);
+
+int input_parameter_converter(int parameter_value);
+
+#endif /* __VIAUTILITY_H__ */
diff -Nur linux-2.6.21-rc7/drivers/video/via/vt1622a.c linux-2.6.21-rc7.viafb/drivers/video/via/vt1622a.c
--- linux-2.6.21-rc7/drivers/video/via/vt1622a.c 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/vt1622a.c 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,364 @@
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
+#include "tbl1622a.h"
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
+
+extern struct tv_setting_information    tv_setting_info;
+
+int  vt1622a_tv_encoder_identify(void)
+{
+    int ver;
+
+    ver = tv_register_read(VT1622A_VERSION_REG);
+    if (ver == VT1622A_VERSION)
+    {
+        DEBUG_MSG(KERN_INFO "\nFind VT1622A TV Encoder \n");
+        return(OK);
+    }
+    else
+        return(FAIL);
+}
+
+void vt1622a_tv_disable(void)
+{
+    /* turn off TV's DAC */
+    tv_register_write(0x0e, 0x0f);
+}
+
+void write_vt1622a_patch_table(vt1622a_func_table *func_table, int func_index)
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
+void load_vt1622a_regs(int TVModeIndex)
+{
+    int i, index;
+    u8  tmp;
+    vt1622a_func_table           *vt1622a_func;
+    struct display_timing         tv_crtc_reg;
+    u16                          *tv_reg=NULL;
+
+
+    for(i=0;i<NUM_TOTAL_VT1622A_TABLE;i++)
+    {
+        index = i;
+
+        if (vt1622a_tbl[i].tv_index == TVModeIndex)
+            break;
+    }
+
+    switch (tv_setting_info.system)
+    {
+        case TVTYPE_NTSC:
+        case TVTYPE_480P:
+        {
+            /* For 480P, we use NTSC's mode table, and then do some patches later. */
+            vt1622a_func = vt1622a_tbl[index].tv_mode_ntsc;
+            break;
+        }
+            
+        case TVTYPE_PAL:
+        case TVTYPE_576P:
+        {
+            /* For 576P, we use PAL's mode table, and then do some patches later. */
+            vt1622a_func = vt1622a_tbl[index].tv_mode_pal;
+            break;
+        }
+
+        default:
+        {
+            vt1622a_func = vt1622a_tbl[index].tv_mode_ntsc;
+            break;
+        }
+    }   
+
+    if (tv_setting_info.level == TV_SIZE_NORMAL_SCAN)
+        tv_reg = vt1622a_func[0].tv_underscan;
+    if (tv_setting_info.level == TV_SIZE_FIT_SCAN)
+        tv_reg = vt1622a_func[0].tv_fitscan;
+    if (tv_setting_info.level == TV_SIZE_OVER_SCAN)
+        tv_reg = vt1622a_func[0].tv_overscan;
+
+
+
+    /* unlock CRTC Register */
+    unlock_crt();
+
+    /* update starting address */
+    write_reg(CR0C, VIACR, 0x00);
+    write_reg(CR0D, VIACR, 0x00);
+    write_reg_mask(CR48, VIACR, 0x00, BIT0+BIT1);
+
+    /* Load TV Encoder Regsiters */
+    for (i=0;i<NUM_TOTAL_VT1622A_REG;i++)
+    {
+        tv_register_write(GET_LOW_BYTE(tv_reg[i]),GET_HIGH_BYTE(tv_reg[i]));
+    }
+
+    /* Load GFX CRTC timing when TV work on IGA1 */
+    for (i=0; i< NUM_CRTC_TIMING; i++)
+    {
+        switch(i) {
+            case H_TOTAL_INDEX:
+                tv_crtc_reg.hor_total = tv_reg[i+NUM_TOTAL_VT1622A_REG];
+                break;
+            case H_ADDR_INDEX:
+                tv_crtc_reg.hor_addr = tv_reg[i+NUM_TOTAL_VT1622A_REG];
+                break;
+            case H_BLANK_START_INDEX:
+                tv_crtc_reg.hor_blank_start = tv_reg[i+NUM_TOTAL_VT1622A_REG];
+                break;
+            case H_BLANK_END_INDEX:
+                tv_crtc_reg.hor_blank_end = tv_reg[i+NUM_TOTAL_VT1622A_REG];
+                break;
+            case H_SYNC_START_INDEX:
+                tv_crtc_reg.hor_sync_start = tv_reg[i+NUM_TOTAL_VT1622A_REG];
+                break;
+            case H_SYNC_END_INDEX:
+                tv_crtc_reg.hor_sync_end = tv_reg[i+NUM_TOTAL_VT1622A_REG];
+                break;
+            case V_TOTAL_INDEX:
+                tv_crtc_reg.ver_total = tv_reg[i+NUM_TOTAL_VT1622A_REG];
+                break;
+            case V_ADDR_INDEX:
+                tv_crtc_reg.ver_addr = tv_reg[i+NUM_TOTAL_VT1622A_REG];
+                break;
+            case V_BLANK_START_INDEX:
+                tv_crtc_reg.ver_blank_start = tv_reg[i+NUM_TOTAL_VT1622A_REG];
+                break;
+            case V_BLANK_END_INDEX:
+                tv_crtc_reg.ver_blank_end = tv_reg[i+NUM_TOTAL_VT1622A_REG];
+                break;
+            case V_SYNC_START_INDEX:
+                tv_crtc_reg.ver_sync_start = tv_reg[i+NUM_TOTAL_VT1622A_REG];
+                break;
+            case V_SYNC_END_INDEX:
+                tv_crtc_reg.ver_sync_end = tv_reg[i+NUM_TOTAL_VT1622A_REG];
+                break;
+          }
+
+    }
+
+    if ( tv_setting_info.iga_path == IGA1)
+        load_crtc_timing(tv_crtc_reg, IGA1);
+    else
+    {
+        load_crtc_timing(tv_crtc_reg, IGA2);
+        write_reg(CR65, VIACR, 0x80);
+        write_reg(CR66, VIACR, 0x00);
+        write_reg(CR67, VIACR, 0x41);
+    }
+    
+    DEBUG_MSG(KERN_INFO "\n tv_out_signal = %2d \n", tv_setting_info.out_signal);
+
+    /* Patch for RGB/YPbPr connector */
+    if (tv_setting_info.out_signal & (TV_OUTPUT_RGB | TV_OUTPUT_RGB_COMPOSITE))
+    {
+        write_vt1622a_patch_table(vt1622a_func, TV_RGB_FUNC);
+    }
+    else if (tv_setting_info.out_signal & (TV_OUTPUT_YPBPR | TV_OUTPUT_YPBPR_COMPOSITE))
+    {
+        write_vt1622a_patch_table(vt1622a_func, TV_YPBPR_FUNC);
+    }
+
+    /* Patch for SDTV */
+    if ((tv_setting_info.system == TVTYPE_480P) || (tv_setting_info.system == TVTYPE_576P))
+    {
+        if (tv_setting_info.out_signal == TV_OUTPUT_RGB)
+        {
+            write_vt1622a_patch_table(vt1622a_func, TV_SDTV_RGB_FUNC);
+        }
+        else if (tv_setting_info.out_signal == TV_OUTPUT_YPBPR)
+        {
+            write_vt1622a_patch_table(vt1622a_func, TV_SDTV_YPBPR_FUNC);
+        }
+    }
+
+    /* Patch for DeDotCrawl function */
+    if ((tv_setting_info.dedotcrawl == 1) && 
+        (tv_setting_info.out_signal == TV_OUTPUT_COMPOSITE) && 
+        (tv_setting_info.system == TVTYPE_NTSC))
+    {
+        tmp = (u8) tv_register_read(VT1622A_DEDOTCRAWL_REG);
+        tv_register_write(VT1622A_DEDOTCRAWL_REG, tmp | BIT3);
+
+        write_vt1622a_patch_table(vt1622a_func, TV_DeDotCrawl_FUNC);
+    }
+    
+    lock_crt();
+}
+
+void vt1622a_tv_enable(void)
+{
+    u8  data;
+
+    data = (u8)tv_register_read(VT1622A_DAC_REG);
+
+    /*  turn on TV's DAC */
+    switch(tv_setting_info.out_signal)
+    {
+        case TV_OUTPUT_COMPOSITE:
+            data = (data & 0xF0)|((~VT1622A_DAC_A)&0x0F);
+            break;
+            
+        case TV_OUTPUT_SVIDEO:
+            data = (data & 0xF0)|((~(VT1622A_DAC_B+VT1622A_DAC_C))&0x0F);
+            break;
+            
+        case TV_OUTPUT_COMPOSITE_SVIDEO:
+            data = (data & 0xF0)|((~(VT1622A_DAC_A+VT1622A_DAC_B+VT1622A_DAC_C))&0x0F);
+            break;
+            
+        case TV_OUTPUT_RGB:
+        case TV_OUTPUT_RGB_COMPOSITE:
+        case TV_OUTPUT_YPBPR_COMPOSITE:
+            data = (data & 0xF0)|((~(VT1622A_DAC_A+VT1622A_DAC_B+VT1622A_DAC_C+VT1622A_DAC_D))&0x0F);
+            break;
+            
+        case TV_OUTPUT_YPBPR:
+            data = (data & 0xF0)|((~(VT1622A_DAC_B+VT1622A_DAC_C+VT1622A_DAC_D))&0x0F);
+            break;
+
+        default:
+            data = (data & 0xF0)|((~(VT1622A_DAC_B+VT1622A_DAC_C+VT1622A_DAC_D))&0x0F);
+
+    }
+
+    tv_register_write(VT1622A_DAC_REG, data);
+}
+
+
+/* Sense VT1622A TV Encoder */
+int vt1622a_sense(void)
+{
+    u8  value, status = 0;
+    int ret;
+
+    DEBUG_MSG(KERN_INFO "vt1622a_sense!!\n");
+
+    value = (u8)tv_register_read(0x0E);
+    tv_register_write(0x0E, 0x0);
+    tv_register_write(0x0E, 0x80);
+    tv_register_write(0x0E, 0x0);
+    status = (u8)tv_register_read(0x0F);
+    tv_register_write(0x0E, value);
+
+    switch (status&0x0F)
+    {
+        case 0x0:   /* DAC A, B, C, D */
+            ret = TV_OUTPUT_RGB;
+            break;
+        case 0x01:  /* DAC A, B, C */
+            ret = TV_OUTPUT_COMPOSITE_SVIDEO;
+            break;
+        case 0x07:  /* DAC A */
+            ret = TV_OUTPUT_COMPOSITE;
+            break;
+        case 0x08:  /* DAC B, C, D */
+            ret = TV_OUTPUT_YPBPR;
+            break;
+        case 0x09:  /* DAC B, C */
+            ret = TV_OUTPUT_SVIDEO;
+            break;
+        case 0x0F:
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
+/* Auto-sense VT1622A TV Encoder */
+int vt1622a_auto_sense(void)
+{
+    u8  status = 0x0;
+    int ret;
+
+    DEBUG_MSG(KERN_INFO "vt1622a_auto_sense!!\n");
+
+    status = (u8)tv_register_read(0x0F);
+
+    switch (status&0x0F)
+    {
+        case 0x0:   /* DAC A, B, C, D */
+            ret = TV_OUTPUT_RGB;
+            break;
+        case 0x01:  /* DAC A, B, C */
+            ret = TV_OUTPUT_COMPOSITE_SVIDEO;
+            break;
+        case 0x07:  /* DAC A */
+            ret = TV_OUTPUT_COMPOSITE;
+            break;
+        case 0x08:  /* DAC B, C, D */
+            ret = TV_OUTPUT_YPBPR;
+            break;
+        case 0x09:  /* DAC B, C */
+            ret = TV_OUTPUT_SVIDEO;
+            break;
+        case 0x0F:
+            ret = TV_OUTPUT_NONE;
+            break;
+        default:
+            ret = TV_OUTPUT_COMPOSITE_SVIDEO;
+            break;
+    }
+
+    return ret;
+}
diff -Nur linux-2.6.21-rc7/drivers/video/via/vt1622.c linux-2.6.21-rc7.viafb/drivers/video/via/vt1622.c
--- linux-2.6.21-rc7/drivers/video/via/vt1622.c 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/vt1622.c 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,361 @@
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
+#include "tbl1622.h"
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
+
+extern struct tv_setting_information    tv_setting_info;
+
+int  vt1622_tv_encoder_identify(void)
+{
+    int ver;
+
+    ver = tv_register_read(VT1622_VERSION_REG);
+    if (ver == VT1622_VERSION)
+    {
+        DEBUG_MSG(KERN_INFO "\nFind VT1622 TV Encoder \n");
+        return(OK);
+    }
+    else
+        return(FAIL);
+}
+
+void vt1622_tv_disable(void)
+{
+    /* turn off TV's DAC */
+    tv_register_write(0x0e, 0x0f);
+}
+
+void write_vt1622_patch_table(vt1622_func_table *func_table, int func_index)
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
+void load_vt1622_regs(int TVModeIndex)
+{
+    int i, index;
+    u8  tmp;
+    vt1622_func_table            *vt1622_func;
+    struct display_timing         tv_crtc_reg;
+    u16                          *tv_reg=NULL;
+
+
+    for(i=0;i<NUM_TOTAL_VT1622_TABLE;i++)
+    {
+       index = i;
+
+       if (vt1622_tbl[i].tv_index == TVModeIndex)
+       break;
+    }
+
+    switch (tv_setting_info.system)
+    {
+        case TVTYPE_NTSC:
+        case TVTYPE_480P:
+        {
+            /* For 480P, we use NTSC's mode table, and then do some patches later. */
+            vt1622_func = vt1622_tbl[index].tv_mode_ntsc;
+            break;
+        }
+            
+        case TVTYPE_PAL:
+        case TVTYPE_576P:
+        {
+            /* For 576P, we use PAL's mode table, and then do some patches later. */
+            vt1622_func = vt1622_tbl[index].tv_mode_pal;
+            break;
+        }
+
+        default:
+        {
+            vt1622_func = vt1622_tbl[index].tv_mode_ntsc;
+            break;
+        }
+    }
+
+    if (tv_setting_info.level == TV_SIZE_NORMAL_SCAN)
+        tv_reg = vt1622_func[0].tv_underscan;
+    if (tv_setting_info.level == TV_SIZE_FIT_SCAN)
+        tv_reg = vt1622_func[0].tv_fitscan;
+    if (tv_setting_info.level == TV_SIZE_OVER_SCAN)
+        tv_reg = vt1622_func[0].tv_overscan;
+
+
+
+    /* unlock CRTC Register */
+    unlock_crt();
+
+    /* update starting address */
+    write_reg(CR0C, VIACR, 0x00);
+    write_reg(CR0D, VIACR, 0x00);
+    /* write_reg(CR34, VIACR, 0x00); */
+    write_reg_mask(CR48, VIACR, 0x00, BIT0+BIT1);
+    /* Load TV Encoder Regsiters */
+    for (i=0;i<NUM_TOTAL_VT1622_REG;i++)
+    {
+        tv_register_write(GET_LOW_BYTE(tv_reg[i]),GET_HIGH_BYTE(tv_reg[i]));
+    }
+
+    /* Load GFX CRTC timing when TV work on IGA1 */
+    for (i=0; i< NUM_CRTC_TIMING; i++)
+    {
+        switch(i) {
+            case H_TOTAL_INDEX:
+                tv_crtc_reg.hor_total = tv_reg[i+NUM_TOTAL_VT1622_REG];
+                break;
+            case H_ADDR_INDEX:
+                tv_crtc_reg.hor_addr = tv_reg[i+NUM_TOTAL_VT1622_REG];
+                break;
+            case H_BLANK_START_INDEX:
+                tv_crtc_reg.hor_blank_start = tv_reg[i+NUM_TOTAL_VT1622_REG];
+                break;
+            case H_BLANK_END_INDEX:
+                tv_crtc_reg.hor_blank_end = tv_reg[i+NUM_TOTAL_VT1622_REG];
+                break;
+            case H_SYNC_START_INDEX:
+                tv_crtc_reg.hor_sync_start = tv_reg[i+NUM_TOTAL_VT1622_REG];
+                break;
+            case H_SYNC_END_INDEX:
+                tv_crtc_reg.hor_sync_end = tv_reg[i+NUM_TOTAL_VT1622_REG];
+                break;
+            case V_TOTAL_INDEX:
+                tv_crtc_reg.ver_total = tv_reg[i+NUM_TOTAL_VT1622_REG];
+                break;
+            case V_ADDR_INDEX:
+                tv_crtc_reg.ver_addr = tv_reg[i+NUM_TOTAL_VT1622_REG];
+                break;
+            case V_BLANK_START_INDEX:
+                tv_crtc_reg.ver_blank_start = tv_reg[i+NUM_TOTAL_VT1622_REG];
+                break;
+            case V_BLANK_END_INDEX:
+                tv_crtc_reg.ver_blank_end = tv_reg[i+NUM_TOTAL_VT1622_REG];
+                break;
+            case V_SYNC_START_INDEX:
+                tv_crtc_reg.ver_sync_start = tv_reg[i+NUM_TOTAL_VT1622_REG];
+                break;
+            case V_SYNC_END_INDEX:
+                tv_crtc_reg.ver_sync_end = tv_reg[i+NUM_TOTAL_VT1622_REG];
+                break;
+          }
+
+    }
+
+    if ( tv_setting_info.iga_path == IGA1)
+        load_crtc_timing(tv_crtc_reg, IGA1);
+    else
+    {
+        load_crtc_timing(tv_crtc_reg, IGA2);
+        write_reg(CR65, VIACR, 0x80);
+        write_reg(CR66, VIACR, 0x00);
+        write_reg(CR67, VIACR, 0x41);
+    }
+    DEBUG_MSG(KERN_INFO "\n tv_out_signal = %2d \n", tv_setting_info.out_signal);
+
+    /* Patch for RGB/YPbPr connector */
+    if (tv_setting_info.out_signal & (TV_OUTPUT_RGB | TV_OUTPUT_RGB_COMPOSITE))
+    {
+        write_vt1622_patch_table(vt1622_func, TV_RGB_FUNC);
+    }
+    else if (tv_setting_info.out_signal & (TV_OUTPUT_YPBPR | TV_OUTPUT_YPBPR_COMPOSITE))
+    {
+        write_vt1622_patch_table(vt1622_func, TV_YPBPR_FUNC);
+    }
+
+    /* Patch for SDTV */
+    if ((tv_setting_info.system == TVTYPE_480P) || (tv_setting_info.system == TVTYPE_576P))
+    {
+        if (tv_setting_info.out_signal == TV_OUTPUT_RGB)
+        {
+            write_vt1622_patch_table(vt1622_func, TV_SDTV_RGB_FUNC);
+        }
+        else if (tv_setting_info.out_signal == TV_OUTPUT_YPBPR)
+        {
+            write_vt1622_patch_table(vt1622_func, TV_SDTV_YPBPR_FUNC);
+        }
+    }
+    
+    if ((tv_setting_info.dedotcrawl == 1) && 
+        (tv_setting_info.out_signal == TV_OUTPUT_COMPOSITE) && 
+        (tv_setting_info.system == TVTYPE_NTSC))
+    {
+        tmp = (u8) tv_register_read(VT1622_DEDOTCRAWL_REG);
+        tv_register_write(VT1622_DEDOTCRAWL_REG, tmp | BIT3);
+        
+        write_vt1622_patch_table(vt1622_func, TV_DeDotCrawl_FUNC);
+    }
+
+    lock_crt();
+}
+
+void vt1622_tv_enable(void)
+{
+    u8  data=0;
+
+    data = (u8)tv_register_read(VT1622_DAC_REG);
+
+    /* turn on TV's DAC */
+    switch(tv_setting_info.out_signal)
+    {
+        case TV_OUTPUT_COMPOSITE:
+            data = (data & 0xF0)|((~VT1622_DAC_A)&0x0F);
+            break;
+            
+        case TV_OUTPUT_SVIDEO:
+            data = (data & 0xF0)|((~(VT1622_DAC_B+VT1622_DAC_C))&0x0F);
+            break;
+            
+        case TV_OUTPUT_COMPOSITE_SVIDEO:
+            data = (data & 0xF0)|((~(VT1622_DAC_A+VT1622_DAC_B+VT1622_DAC_C))&0x0F);
+            break;
+            
+        case TV_OUTPUT_RGB:
+        case TV_OUTPUT_RGB_COMPOSITE:
+        case TV_OUTPUT_YPBPR_COMPOSITE:
+            data = (data & 0xF0)|((~(VT1622_DAC_A+VT1622_DAC_B+VT1622_DAC_C+VT1622_DAC_D))&0x0F);
+            break;
+            
+        case TV_OUTPUT_YPBPR:
+            data = (data & 0xF0)|((~(VT1622_DAC_B+VT1622_DAC_C+VT1622_DAC_D))&0x0F);
+            break;
+
+        default:
+            data = (data & 0xF0)|((~(VT1622_DAC_B+VT1622_DAC_C+VT1622_DAC_D))&0x0F);
+
+    }
+
+    tv_register_write(VT1622_DAC_REG, data);
+}
+
+/* Sense VT1622 TV Encoder */
+int vt1622_sense(void)
+{
+    u8  value, status = 0;
+    int ret;
+
+    DEBUG_MSG(KERN_INFO "vt1622_sense!!\n");
+
+    value = (u8)tv_register_read(0x0E);
+    tv_register_write(0x0E, 0x0);
+    tv_register_write(0x0E, 0x80);
+    tv_register_write(0x0E, 0x0);
+    status = (u8)tv_register_read(0x0F);
+    tv_register_write(0x0E, value);
+
+    switch (status&0x0F)
+    {
+        case 0x0:   /* DAC A, B, C, D */
+            ret = TV_OUTPUT_RGB;
+            break;
+        case 0x01:  /* DAC A, B, C */
+            ret = TV_OUTPUT_COMPOSITE_SVIDEO;
+            break;
+        case 0x07:  /* DAC A */
+            ret = TV_OUTPUT_COMPOSITE;
+            break;
+        case 0x08:  /* DAC B, C, D */
+            ret = TV_OUTPUT_YPBPR;
+            break;
+        case 0x09:  /* DAC B, C */
+            ret = TV_OUTPUT_SVIDEO;
+            break;
+        case 0x0F:
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
+/* Auto-sense VT1622 TV Encoder */
+int vt1622_auto_sense(void)
+{
+    u8  status = 0x0;
+    int ret;
+
+    DEBUG_MSG(KERN_INFO "vt1622_auto_sense!!\n");
+
+    status = (u8)tv_register_read(0x0F);
+
+    switch (status&0x0F)
+    {
+        case 0x0:   /* DAC A, B, C, D */
+            ret = TV_OUTPUT_RGB;
+            break;
+        case 0x01:  /* DAC A, B, C */
+            ret = TV_OUTPUT_COMPOSITE_SVIDEO;
+            break;
+        case 0x07:  /* DAC A */
+            ret = TV_OUTPUT_COMPOSITE;
+            break;
+        case 0x08:  /* DAC B, C, D */
+            ret = TV_OUTPUT_YPBPR;
+            break;
+        case 0x09:  /* DAC B, C */
+            ret = TV_OUTPUT_SVIDEO;
+            break;
+        case 0x0F:
+            ret = TV_OUTPUT_NONE;
+            break;
+        default:
+            ret = TV_OUTPUT_COMPOSITE_SVIDEO;
+            break;
+    }
+
+    return ret;
+}
diff -Nur linux-2.6.21-rc7/drivers/video/via/via_i2c.c linux-2.6.21-rc7.viafb/drivers/video/via/via_i2c.c
--- linux-2.6.21-rc7/drivers/video/via/via_i2c.c 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/via_i2c.c 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,478 @@
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
+#include <linux/ioport.h>
+#include <asm/io.h>
+
+#include "chip.h"
+#include "debug.h"
+#include "via_i2c.h"
+#include "share.h"
+
+extern inline void write_reg(u8 index, u16 io_port, u8 data);
+extern inline u8 read_reg(int io_port, u8 index);
+
+extern struct chip_information          chip_info;
+extern struct tv_setting_information    tv_setting_info;
+
+/* i2c delay for microsecond */
+void delays(int count)
+{
+    volatile u8 data;
+    while (count--)
+    {
+        /* delay 1 us */
+        data = inb(DELAYPORT);
+        data = inb(DELAYPORT);
+        data = inb(DELAYPORT);
+        data = inb(DELAYPORT);
+        data = inb(DELAYPORT);
+    }
+
+}
+
+/*  Write I2C BUS SDA And SCL */
+void i2cWriteSdaScl(u8 sda, u8 scl)
+{
+    u8      data;
+    u16     port_addr;
+
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot == TV_ON_AMR)
+    {
+
+        data = ((scl << 1) | sda) << 4;
+        data = data | BIT0;                             /* enable I2C port */
+
+        port_addr = TVI2CPORT;
+        write_reg(TVI2CPORTINDEX, port_addr, data); /* Write Register Value */
+    }
+    else
+    {
+        if (chip_info.tv_chip_info.tv_chip_on_slot == TV_ON_AGP)
+        {
+            data = ((scl << 1) | sda) << 4;
+            data = data | (BIT6+BIT7);                      /* enable GPIO write port */
+            port_addr = TVGPIOPORT;
+            write_reg (TVGPIOPORTINDEX, port_addr, data);   /* Write Register Value */
+
+        }
+    }
+}
+
+void i2cWriteScl(u8 scl)
+{
+    u8      data;
+    u16     port_addr;
+
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot == TV_ON_AMR)
+    {
+
+        data = (scl << 1)<< 4;
+        data = data | BIT0;                             /* enable I2C port */
+
+        port_addr = TVI2CPORT;
+        write_reg(TVI2CPORTINDEX, port_addr, data); /* Write Register Value */
+    }
+    else
+    {
+        if (chip_info.tv_chip_info.tv_chip_on_slot == TV_ON_AGP)
+        {
+            data = (scl << 1) << 4;
+
+            data = data & 0xBF;                     /* enable GPIO write clock */
+            port_addr = TVGPIOPORT;
+            write_reg (TVGPIOPORTINDEX, port_addr, data);   /* Write Register Value */
+        }
+    }
+}
+
+void i2cReadSdaScl(u8 *pSda, u8 *pScl)
+{
+    u8      data;
+    u16     port_addr;
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot == TV_ON_AMR)
+    {
+        port_addr = TVI2CPORT;
+        data = read_reg(port_addr, TVI2CPORTINDEX);
+        *pSda = (data >> 2) & BIT0;     /* get sda */
+        *pScl = (data >> 3) & BIT0;     /* get scl */
+    }
+    else
+    {
+        if (chip_info.tv_chip_info.tv_chip_on_slot == TV_ON_AGP)
+        {
+            port_addr = TVGPIOPORT;
+            data =  read_reg(port_addr, TVGPIOPORTINDEX);
+            *pSda = (data >> 2) & BIT0;     /* get sda */
+            *pScl = (data >> 3) & BIT0;     /* get scl */
+        }
+    }
+}
+
+void i2cWriteSdaSclDelay(u8 sda, u8 scl)
+{
+    i2cWriteSdaScl(sda, scl);
+    delays(16);                 /* Wait 16 uS */
+}
+
+void i2cStartSignal(void)
+{
+    i2cWriteSdaSclDelay(1,1);
+    i2cWriteSdaSclDelay(0,1);
+    i2cWriteSdaSclDelay(0,0);
+}
+
+void i2cStopSignal(void)
+{
+    u8      data;
+    u16     port_addr;
+
+    i2cWriteSdaSclDelay(0,0);
+    i2cWriteSdaSclDelay(0,1);
+    i2cWriteSdaSclDelay(1,1);
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot == TV_ON_AGP)
+    {
+        data = 0x3c;                                    /* disable GPIO write port */
+        port_addr = TVGPIOPORT;
+        write_reg (TVGPIOPORTINDEX, port_addr, data);   /* Write Register Value */
+    }
+    delays(2);
+
+}
+
+void disableSdaGPIO(void)
+{
+    u8      data;
+    u16     port_addr;
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot == TV_ON_AGP)
+    {
+            port_addr = TVGPIOPORT;
+            data = read_reg(port_addr, TVGPIOPORTINDEX);
+            data = data & (~BIT6);                      /* disable GPIO write port */
+            write_reg (TVGPIOPORTINDEX, port_addr, data);   /* Write Register Value */
+    }
+}
+
+void enableSdaGPIO(void)
+{
+    u8  data;
+    u16 port_addr;
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot == TV_ON_AGP)
+    {
+            port_addr = TVGPIOPORT;
+            data = read_reg(port_addr, TVGPIOPORTINDEX);
+            data = data | (BIT6);                           /* disable GPIO write port */
+            write_reg (TVGPIOPORTINDEX, port_addr, data);   /* Write Register Value */
+    }
+}
+
+void writeSclGPIO(u8 scl)
+{
+    u8      data;
+    u16     port_addr;
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot == TV_ON_AGP)
+    {
+        port_addr = TVGPIOPORT;
+        data = read_reg(port_addr, TVGPIOPORTINDEX);
+        data = data & (~BIT5);
+        data = (data | (scl<<5)) & (~BIT6);             /* write data to clock */
+
+        write_reg (TVGPIOPORTINDEX, port_addr, data);       /* Write Register Value */
+    }
+}
+
+void writeSdaGPIO(u8 sda)
+{
+    u8      data;
+    u16     port_addr;
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot == TV_ON_AGP)
+    {
+        port_addr = TVGPIOPORT;
+        data = read_reg(port_addr, TVGPIOPORTINDEX);
+
+        data = data & (~BIT4);
+        data = (data | (sda<<4)) & (~BIT7);             /* write data to clock */
+        write_reg (TVGPIOPORTINDEX, port_addr, data);       /* Write Register Value */
+    }
+}
+
+void enableGPIO(void)
+{
+    u8  data;
+    u16 port_addr;
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot == TV_ON_AGP)
+    {
+        port_addr = TVGPIOPORT;
+        data = read_reg(port_addr, TVGPIOPORTINDEX);
+        data = data | (BIT4+BIT5+BIT6+BIT7);                /* enable GPIO write port */
+        write_reg (TVGPIOPORTINDEX, port_addr, data);       /* Write Register Value */
+    }
+}
+
+void releaseGPIO(void)
+{
+    u8      data;
+    u16     port_addr;
+
+    if (chip_info.tv_chip_info.tv_chip_on_slot == TV_ON_AGP)
+    {
+        port_addr = TVGPIOPORT;
+        port_addr = port_addr + 1;
+
+        data = read_reg(port_addr, TVGPIOPORTINDEX);
+        data = data & 0x3c;                         /* disable GPIO write port */ 
+        port_addr = TVGPIOPORT;
+        write_reg (TVGPIOPORTINDEX, port_addr, data);   /* Write Register Value */
+    }
+}
+
+int i2CWaitForSlave(void)
+{
+    int time_out = 20000;
+    u8 sda, scl;
+
+    while (time_out--)
+    {
+        i2cReadSdaScl(&sda, &scl);
+        if (scl)
+        return (OK);            /* Successful stall */
+        delays(1);              /* wait 1 uS */
+    }
+    return (FAIL);              /* Slave fail */
+}
+
+int i2cOutByte(u8 data)
+{
+    u8 sda, scl;
+    u8 out_byte;
+    int bit_count = 8;
+    int status;
+
+    out_byte = data;
+    while (bit_count--)
+    {
+        sda = (out_byte >> 7) & 1;      /* Load MSB */
+        out_byte = out_byte << 1;       /* next bit. */
+        i2cWriteSdaSclDelay(sda, 0);
+        i2cWriteSdaSclDelay(sda, 1);
+
+        status = i2CWaitForSlave();
+        if (status == FAIL)
+        {
+            return (status);
+        }
+
+        i2cWriteSdaSclDelay(sda, 0);
+
+    }
+
+    if ((chip_info.tv_chip_info.tv_chip_on_slot == TV_ON_AGP))
+    {
+
+        writeSclGPIO(0);
+        disableSdaGPIO();
+        delays(2);
+        writeSclGPIO(1);
+        delays(2);
+        i2cReadSdaScl(&sda, &scl);
+        writeSclGPIO(0);
+        delays(2);
+        if (sda == 0)
+        {
+            status = OK;
+        }
+        else
+        {
+            status = FAIL;
+        }
+
+    }
+    else
+    {
+        i2cWriteSdaSclDelay(1,0);
+        i2cWriteSdaSclDelay(1,1);
+        status = i2CWaitForSlave();
+        if (status == FAIL)
+        {
+            return (status);
+        }
+
+        i2cReadSdaScl(&sda, &scl);
+        if (sda == 0)
+        {
+            i2cWriteSdaSclDelay(1,0);
+            status = OK;
+        }
+        else
+        {
+
+            i2cWriteSdaSclDelay(1,0);
+            status = FAIL;
+        }
+    }
+    return (status);
+}
+
+int i2cInputByte(u8 *pInByte, int ack)
+{
+
+    int     bit_count = 8;
+    u8      sda, scl;
+    u8      data = 0;
+    int     status;
+
+    disableSdaGPIO();
+
+    while (bit_count--)
+    {
+        if ((chip_info.tv_chip_info.tv_chip_on_slot == TV_ON_AGP))
+        {
+
+            writeSclGPIO(1);
+            delays(2);
+            status = i2CWaitForSlave();
+            if (status == FAIL)
+                return (FAIL);
+            i2cReadSdaScl(&sda, &scl);
+            data = data << 1;
+            data |= sda;
+            writeSclGPIO(0);
+            delays(2);
+
+        }
+        else
+        {
+            i2cWriteSdaSclDelay(1,1);
+            status = i2CWaitForSlave();
+            if (status == FAIL)
+                return(FAIL);
+            i2cReadSdaScl(&sda, &scl);
+            data = data << 1;
+            data |= sda;
+            i2cWriteSdaSclDelay(1, 0);
+        }
+    }
+    *pInByte = data;
+
+    if (ack)
+    {
+        i2cWriteSdaSclDelay(0, 0);
+        i2cWriteSdaSclDelay(0, 1);
+        status = i2CWaitForSlave();
+    if (status == FAIL)
+        return(status);
+        i2cWriteSdaSclDelay(0, 0);
+    }
+    else
+    {
+        i2cWriteSdaSclDelay(1, 0);
+        i2cWriteSdaSclDelay(1, 1);
+        status = i2CWaitForSlave();
+        if (status == FAIL)
+            return(status);
+    }
+    i2cWriteSdaSclDelay(1, 0);
+
+    return(OK);
+}
+
+int i2cReadByte(u8 slave_addr, u8 index, u8 *pData)
+{
+
+    int     status;
+
+    i2cStartSignal();
+
+    status = i2cOutByte(slave_addr);
+    if (status == FAIL)
+    {
+        i2cStopSignal();
+        return(FAIL);
+    }
+    status = i2cOutByte(index);
+
+    if (status == FAIL)
+    {
+        i2cStopSignal();
+        return (FAIL);
+    }
+
+    i2cStartSignal();
+    status = i2cOutByte(slave_addr | BIT0);
+    if (status == FAIL)
+    {
+        i2cStopSignal();
+        return (FAIL);
+    }
+    status = i2cInputByte(pData, 0);
+    if (status == FAIL)
+    {
+        i2cStopSignal();
+        return (FAIL);
+    }
+
+    i2cStopSignal();
+    return(OK);
+}
+
+int i2cWriteByte(u8 slave_addr, u8 index, u8 data)
+{
+
+    int     status;
+
+    i2cStartSignal();
+    status = i2cOutByte(slave_addr);
+    if (status == FAIL)
+    {
+        i2cStopSignal();
+        return(FAIL);
+    }
+    status = i2cOutByte(index);
+    if (status == FAIL)
+    {
+        i2cStopSignal();
+        return(FAIL);
+    }
+    status = i2cOutByte(data);
+    if (status == FAIL)
+    {
+        i2cStopSignal();
+        return(FAIL);
+    }
+    i2cStopSignal();
+    return(OK);
+}
diff -Nur linux-2.6.21-rc7/drivers/video/via/via_i2c.h linux-2.6.21-rc7.viafb/drivers/video/via/via_i2c.h
--- linux-2.6.21-rc7/drivers/video/via/via_i2c.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/via_i2c.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,38 @@
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
+#ifndef __VIA_I2C_H__
+#define __VIA_I2C_H__
+
+#define TVI2CPORT           0x3c4
+#define TVI2CPORTINDEX      0x31
+#define TVGPIOPORT          0x3C4
+#define TVGPIOPORTINDEX     0x2C
+#define I2C_BUS             1
+#define GPIO_BUS            2
+#define DELAYPORT           0x3C3
+
+#endif /* __VIA_I2C_H__ */
diff -Nur linux-2.6.21-rc7/drivers/video/via/vt1636.h linux-2.6.21-rc7.viafb/drivers/video/via/vt1636.h
--- linux-2.6.21-rc7/drivers/video/via/vt1636.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/vt1636.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,36 @@
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
+#ifndef _VT1636_H_
+#define _VT1636_H_ 1
+#include "chip.h"
+bool lvds_identify_vt1636(void);
+void init_lvds_vt1636(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+void enable_lvds_vt1636(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+void disable_lvds_vt1636(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+void vt1636_patch_skew_on_vt3324(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+void vt1636_patch_skew_on_vt3327(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+void vt1636_patch_skew_on_vt3364(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+    
+#endif

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
