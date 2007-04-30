From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/12] viafb: Framebuffer driver for VIA
 UniChrome/Chrome9 HC (fwd)
Date: Mon, 30 Apr 2007 10:36:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704301036260.27246@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiRNA-0006R0-Iv for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:36:40 -0700
Received: from hoboe1bl1.telenet-ops.be ([195.130.137.72])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiRN9-0001R1-8w
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:36:40 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hoboe1bl1.telenet-ops.be (Postfix) with SMTP id BD0B1D406F
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:36:37 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by hoboe1bl1.telenet-ops.be (Postfix) with ESMTP id 620AED4067
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:36:33 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l3U8aX6j020353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:36:33 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l3U8aXgO020350
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:36:33 +0200
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
Date: Mon, 30 Apr 2007 13:20:11 +0800
From: EddyFu@via.com.tw
To: linux-fbdev-devel-bounces@lists.sourceforge.net
Subject: [Linux-fbdev-devel] [PATCH 3/12] viafb: Framebuffer driver for VIA
    UniChrome/Chrome9 HC

Dear All, 
 
Here is the part 3/12 of viafb.
 
Best Regards,
Eddy Fu 
 
diff -Nur linux-2.6.21-rc7/drivers/video/via/dvi.c linux-2.6.21-rc7.viafb/drivers/video/via/dvi.c
--- linux-2.6.21-rc7/drivers/video/via/dvi.c 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/dvi.c 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,445 @@
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
+#include "debug.h"
+#include "dvi.h"
+#include "chip.h"
+#include "share.h"
+#include "via_i2c.h"
+
+/* extern function */
+extern int i2cWriteByte(u8 slave_addr, u8 index, u8 data);
+extern int i2cReadByte(u8 slave_addr, u8 index, u8 *pData);
+extern void set_output_path(int device, int set_iga, int output_interface);
+extern void fill_crtc_timing(struct crt_mode_table *crt_table, int mode_index, int bpp_byte, int set_iga);
+extern void write_reg_mask(u8 index, int io_port, u8 data, u8 mask);
+extern inline u8 read_reg(int io_port, u8 index);
+extern inline void write_reg(u8 index, u16 io_port, u8 data);
+
+extern struct chip_information      chip_info;
+extern struct tmds_setting_information  tmds_setting_info;
+
+extern int EPIA_DVI;
+extern int LCDDualEdge;
+extern int BusWidth;
+
+int tmds_register_read(int index);
+void tmds_register_write(int index, u8 data);
+int dvi_sense(void);
+int dvi_query_EDID(void);
+void dvi_disable(void);
+void dvi_enable(void);
+
+extern int display_hardware_layout;
+
+int check_tmds_chip(int device_id_subaddr, int device_id)
+{
+    if (tmds_register_read(device_id_subaddr) == device_id)
+        return(OK);
+    else
+        return(FAIL);
+}
+
+void init_dvi_size(void)
+{
+    switch(tmds_setting_info.get_dvi_size_method) {
+        case GET_DVI_SIZE_BY_SYSTEM_BIOS:
+            break;
+        case GET_DVI_SZIE_BY_HW_STRAPPING:
+            break;
+        case GET_DVI_SIZE_BY_VGA_BIOS:
+            break;
+    }
+
+}
+
+int tmds_trasmitter_identify(void)
+{
+    unsigned char   sr2a = 0, sr1e = 0, sr3e = 0;
+    
+    /* Check for VT3324 integrated TMDS. */
+    chip_info.tmds_chip_info.tmds_chip_name = INTEGRATED_TMDS;
+
+    /* Not always support intergrated TMDS now,
+       we should check support by hardware layout. */
+    if ((chip_info.gfx_chip_name == UNICHROME_CX700) &&
+        ((display_hardware_layout == HW_LAYOUT_DVI_ONLY) ||
+         (display_hardware_layout == HW_LAYOUT_LCD_DVI)))
+    {
+        DEBUG_MSG(KERN_INFO "\n Integrated TMDS ! \n");
+        return(OK);
+    }
+
+    /* Turn on ouputting pad */
+    /* Modified form X driver's code to support VT3327 VT3336 VT3364 */
+    switch (chip_info.gfx_chip_name)
+    {
+        case UNICHROME_K8M890:
+            /* DFP Low Pad on */
+            sr2a = read_reg(VIASR, SR2A);
+            write_reg_mask(SR2A, VIASR, 0x03, BIT0+BIT1);
+            break;
+
+        case UNICHROME_P4M900:
+        case UNICHROME_P4M890:
+            /* DFP Low Pad on */
+            sr2a = read_reg(VIASR, SR2A);
+            write_reg_mask(SR2A, VIASR, 0x03, BIT0+BIT1);
+
+            /* VT3364 also supports DVI on AMR, so we need to sense DVP0, too. */
+            /* DVP0 Pad on */
+            sr1e = read_reg(VIASR, SR1E);
+            write_reg_mask(SR1E, VIASR, 0xC0, BIT6+BIT7);
+            break;
+               
+        default:
+            /* DVP0/DVP1 Pad on */
+            sr1e = read_reg(VIASR, SR1E);
+            write_reg_mask(SR1E, VIASR, 0xF0, BIT4+BIT5+BIT6+BIT7);
+            /* SR3E[1]Multi-function selection:0 = Emulate I2C and DDC bus by GPIO2/3/4. */
+            sr3e = read_reg(VIASR, SR3E);
+            write_reg_mask(SR3E, VIASR, 0x0, BIT5);
+            break;
+    }
+
+    /* Check for VT1632: */
+    chip_info.tmds_chip_info.tmds_chip_name = VT1632_TMDS;
+    chip_info.tmds_chip_info.tmds_chip_slave_addr = VT1632_TMDS_I2C_ADDR;
+    chip_info.tmds_chip_info.i2c_port = TVI2CPORTINDEX;
+    if (check_tmds_chip(VT1632_DEVICE_ID_REG, VT1632_DEVICE_ID)!= FAIL)
+    {
+        /* Currently only support 12bits, dual edge,add 24bits mode later */
+        tmds_register_write(0x08, 0x3b);
+        
+        DEBUG_MSG(KERN_INFO "\n VT1632 TMDS ! \n");
+        DEBUG_MSG(KERN_INFO "\n %2d", chip_info.tmds_chip_info.tmds_chip_name);
+        DEBUG_MSG(KERN_INFO "\n %2d", chip_info.tmds_chip_info.i2c_port);
+        return(OK);
+    }else
+    {
+        chip_info.tmds_chip_info.i2c_port = TVGPIOPORTINDEX;
+        if (check_tmds_chip(VT1632_DEVICE_ID_REG, VT1632_DEVICE_ID)!= FAIL)
+        {
+            /* Currently only support 12bits, dual edge,add 24bits mode later */
+            tmds_register_write(0x08, 0x3b);
+            
+            DEBUG_MSG(KERN_INFO "\n VT1632 TMDS ! \n");
+            DEBUG_MSG(KERN_INFO "\n %2d", chip_info.tmds_chip_info.tmds_chip_name);
+            DEBUG_MSG(KERN_INFO "\n %2d", chip_info.tmds_chip_info.i2c_port);
+            return(OK);
+        }
+    }
+
+    /* Check for SII164: */
+    chip_info.tmds_chip_info.tmds_chip_name = SII164_TMDS;
+    chip_info.tmds_chip_info.tmds_chip_slave_addr = SII164_TMDS_I2C_ADDR;
+    if (check_tmds_chip(SII164_DEVICE_ID_REG, SII164_DEVICE_ID)!= FAIL)
+    {
+        return(OK);
+    }
+
+
+    /* Restore status */
+    switch (chip_info.gfx_chip_name)
+    {
+        case UNICHROME_K8M890:
+            write_reg(SR2A, VIASR, sr2a);
+            break;
+
+        case UNICHROME_P4M900:
+        case UNICHROME_P4M890:
+            write_reg(SR2A, VIASR, sr2a);
+            write_reg(SR1E, VIASR, sr1e);
+            break;
+
+        default: 
+            write_reg(SR1E, VIASR, sr1e);
+            write_reg(SR3E, VIASR, sr3e);
+            break;
+    }
+
+    chip_info.tmds_chip_info.tmds_chip_name = NON_TMDS_TRANSMITTER;
+    chip_info.tmds_chip_info.tmds_chip_slave_addr = VT1632_TMDS_I2C_ADDR;
+    return(FAIL);
+}
+
+void tmds_register_write(int index, u8 data)
+{
+    u8  tmp;
+
+    tmp = chip_info.tv_chip_info.tv_chip_on_slot;
+    switch(chip_info.tmds_chip_info.i2c_port)
+    {
+        case TVI2CPORTINDEX:
+            chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AMR;
+            break;
+            
+        case TVGPIOPORTINDEX:
+        default:
+            chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AGP;
+            break;
+    }
+
+
+    i2cWriteByte(chip_info.tmds_chip_info.tmds_chip_slave_addr, index, data);
+
+    chip_info.tv_chip_info.tv_chip_on_slot = tmp;
+
+}
+
+int tmds_register_read(int index)
+{
+    u8 data;
+    int status;
+    u8  tmp;
+
+    tmp = chip_info.tv_chip_info.tv_chip_on_slot;
+    switch(chip_info.tmds_chip_info.i2c_port)
+    {
+        case TVI2CPORTINDEX:
+            chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AMR;
+            break;
+            
+        case TVGPIOPORTINDEX:
+        default:
+            chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AGP;
+            break;
+    }
+
+
+    status = i2cReadByte((u8)chip_info.tmds_chip_info.tmds_chip_slave_addr, (u8)index, &data);
+    chip_info.tv_chip_info.tv_chip_on_slot = tmp;
+    return(data);
+}
+
+/* DVI Set Mode */
+void dvi_set_mode(struct crt_mode_table *dvi_crt_timing, int video_index, int mode_bpp, int set_iga)
+{
+    fill_crtc_timing(dvi_crt_timing, video_index, mode_bpp/8, set_iga);
+    set_output_path(DEVICE_DVI, set_iga, chip_info.tmds_chip_info.output_interface);
+}
+
+/* Sense DVI Connector */
+int dvi_sense(void)
+{
+    u8  RegSR1E=0, RegSR3E=0, RegCR6B=0, RegCR91=0, RegCR93=0, RegCR9B=0, data;
+    int ret = FALSE;
+
+    DEBUG_MSG(KERN_INFO "dvi_sense!!\n");
+
+    if (chip_info.gfx_chip_name == UNICHROME_CLE266)
+    {
+        /* DI1 Pad on */
+        RegSR1E = read_reg(VIASR, SR1E);
+        write_reg(SR1E, VIASR, RegSR1E|0x30);
+
+        /* CR6B[0]VCK Input Selection: 1 = External clock. */
+        RegCR6B = read_reg(VIACR, CR6B);
+        write_reg(CR6B, VIACR, RegCR6B|0x08);
+
+        /* CR91[4] VDD On [3] Data On [2] VEE On [1] Back Light Off
+           [0] Software Control Power Sequence */
+        RegCR91 = read_reg(VIACR, CR91);
+        write_reg(CR91, VIACR, 0x1D);
+
+        /* CR93[7] DI1 Data Source Selection: 1 = DSP2.
+           CR93[5] DI1 Clock Source: 1 = internal.
+           CR93[4] DI1 Clock Polarity.
+           CR93[3:1] DI1 Clock Adjust. CR93[0] DI1 enable */
+        RegCR93 = read_reg(VIACR, CR93);
+        write_reg(CR93, VIACR, 0x01);
+    }
+    else
+    {
+        /* DVP0/DVP1 Pad on */
+        RegSR1E = read_reg(VIASR, SR1E);
+        write_reg(SR1E, VIASR, RegSR1E|0xF0);
+
+        /* SR3E[1]Multi-function selection:
+                    0 = Emulate I2C and DDC bus by GPIO2/3/4. */
+        RegSR3E = read_reg(VIASR, SR3E);
+        write_reg(SR3E, VIASR, RegSR3E&(~0x20));
+
+        /* CR91[4] VDD On [3] Data On [2] VEE On [1] Back Light Off
+               [0] Software Control Power Sequence */
+        RegCR91 = read_reg(VIACR, CR91);
+        write_reg(CR91, VIACR, 0x1D);
+
+        /* CR9B[4] DVP1 Data Source Selection: 1 = From secondary display.
+             CR9B[2:0] DVP1 Clock Adjust */
+        RegCR9B = read_reg(VIACR, CR9B);
+        write_reg(CR9B, VIACR, 0x01);
+    }
+
+    data = (u8)tmds_register_read(0x09);
+    if(data & 0x04)
+        ret = TRUE;
+
+    if (ret == FALSE)
+    {
+        if(dvi_query_EDID())
+        {
+            ret = TRUE;
+        }
+    }
+
+    /* Restore status */
+    if (chip_info.gfx_chip_name == UNICHROME_CLE266)
+    {
+        write_reg(SR1E, VIASR, RegSR1E);
+        write_reg(CR6B, VIACR, RegCR6B);
+        write_reg(CR91, VIACR, RegCR91);
+        write_reg(CR93, VIACR, RegCR93);
+    }
+    else
+    {
+        write_reg(SR1E, VIASR, RegSR1E);
+        write_reg(SR3E, VIASR, RegSR3E);
+        write_reg(CR91, VIACR, RegCR91);
+        write_reg(CR9B, VIACR, RegCR9B);
+    }
+
+    return ret;
+}
+
+/* Query Flat Panel's EDID Table Version Through DVI Connector */
+int dvi_query_EDID(void)
+{
+    u8  data0, data1;
+
+    DEBUG_MSG(KERN_INFO "dvi_query_EDID!!\n");
+
+    data0 = (u8)tmds_register_read(0x00);
+    data1 = (u8)tmds_register_read(0x01);
+    if ((data0 == 0) && (data1 == 0xFF))
+        return EDID_VERSION_1; /* Found EDID1 Table */
+
+    data0 = (u8)tmds_register_read(0x00);
+    if (data0 == 0x20)
+        return EDID_VERSION_2; /* Found EDID2 Table */
+    else
+        return 0;
+}
+
+/* If Disable DVI, turn off pad */
+void dvi_disable(void)
+{
+    if (chip_info.tmds_chip_info.output_interface == INTERFACE_DVP0)
+    {
+        write_reg(SR1E, VIASR, read_reg(VIASR, SR1E) & (~0xC0));
+    }
+
+    if (chip_info.tmds_chip_info.output_interface == INTERFACE_DVP1)
+    {
+        write_reg(SR1E, VIASR, read_reg(VIASR, SR1E) & (~0x30));
+    }
+
+    if (chip_info.tmds_chip_info.output_interface == INTERFACE_DFP_HIGH)
+    {
+        write_reg(SR2A, VIASR, read_reg(VIASR, SR2A) & (~0x0C));
+    }
+
+    if (chip_info.tmds_chip_info.output_interface == INTERFACE_DFP_LOW)
+    {
+        write_reg(SR2A, VIASR, read_reg(VIASR, SR2A) & (~0x03));
+    }
+
+    /* Add for VT3324 integrated TMDS. */
+    if (chip_info.tmds_chip_info.output_interface == INTERFACE_TMDS)
+    {
+        write_reg(CRD2, VIACR, read_reg(VIACR, CRD2) | 0x08);   /* Turn off TMDS power. */
+    }
+}
+
+/* If Enable DVI, turn off pad */
+void dvi_enable(void)
+{
+    if (chip_info.tmds_chip_info.output_interface == INTERFACE_DVP0)
+    {
+        write_reg(SR1E, VIASR, read_reg(VIASR, SR1E) | 0xC0);
+        if(chip_info.gfx_chip_name == UNICHROME_CLE266)
+            tmds_register_write(0x88,0x3b);
+        else
+            /* Clear CR91[5] to direct on display period in the secondary diplay path */
+            write_reg(CR91,VIACR,read_reg(VIACR,CR91) & 0xDF);
+    }
+
+    if (chip_info.tmds_chip_info.output_interface == INTERFACE_DVP1)
+    {
+        write_reg(SR1E, VIASR, read_reg(VIASR, SR1E) | 0x30);
+
+        /* Fix dvi cann't be enabled with MB VT5718C4 */
+        if(chip_info.gfx_chip_name == UNICHROME_CLE266)
+        {   
+            tmds_register_write(0x88,0x3b);
+        }
+        else
+        {
+            /* Clear CR91[5] to direct on display period in the secondary diplay path */
+            write_reg(CR91,VIACR,read_reg(VIACR,CR91) & 0xDF);
+        }
+        
+        /* Fix DVI cannot enable on EPIA-M board */
+        if(EPIA_DVI==1)
+        {
+                write_reg_mask(CR91,VIACR,0x1f,0x1f);
+                write_reg_mask(CR88,VIACR,0x00,BIT6+BIT0);                
+           if(BusWidth==24)
+           {
+             if(LCDDualEdge==1)
+                 i2cWriteByte(chip_info.tmds_chip_info.tmds_chip_slave_addr, 0x08, 0x3F);
+             else
+                 i2cWriteByte(chip_info.tmds_chip_info.tmds_chip_slave_addr, 0x08, 0x37);
+            }
+        }
+    }
+    
+    if (chip_info.tmds_chip_info.output_interface == INTERFACE_DFP_HIGH)
+    {
+        write_reg(SR2A, VIASR, read_reg(VIASR, SR2A) | 0x0C);
+        
+        /* Fix can't light on DVI problem
+           clear CR91[5] to direct on display period in the secondary diplay path */
+        write_reg(CR91,VIACR,read_reg(VIACR,CR91) & 0xDF);
+    }
+
+    if (chip_info.tmds_chip_info.output_interface == INTERFACE_DFP_LOW)
+    {
+        write_reg(SR2A, VIASR, read_reg(VIASR, SR2A) | 0x03);
+        
+        /* Fix can't light on DVI problem
+           clear CR91[5] to direct on display period in the secondary diplay path */
+        write_reg(CR91,VIACR,read_reg(VIACR,CR91) & 0xDF);
+    }
+
+    /* Add for VT3324 integrated TMDS. */
+    if (chip_info.tmds_chip_info.output_interface == INTERFACE_TMDS)
+    {
+        /* Turn on Display period in the panel path. */
+        write_reg_mask(CR91, VIACR, 0, BIT7);
+
+        /* Turn on TMDS power. */
+        write_reg_mask(CRD2, VIACR, 0, BIT3);
+    }
+}
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/dvi.h linux-2.6.21-rc7.viafb/drivers/video/via/dvi.h
--- linux-2.6.21-rc7/drivers/video/via/dvi.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/dvi.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,56 @@
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
+
+#ifndef __DVI_H__
+#define __DVI_H__
+
+/* Definition TMDS Device ID register */
+#define     VT1632_DEVICE_ID_REG        0x02
+#define     VT1632_DEVICE_ID            0x92
+
+#define     SII164_DEVICE_ID_REG        0x02
+#define     SII164_DEVICE_ID            0x06
+
+
+
+#define     GET_DVI_SIZE_BY_SYSTEM_BIOS     0x01
+#define     GET_DVI_SIZE_BY_VGA_BIOS        0x02
+#define     GET_DVI_SZIE_BY_HW_STRAPPING    0x03
+
+/* Definition DVI Panel ID */
+#define     DVI_PANEL_ID0_640X480       0x00        /* Resolution: 640x480,   Channel: single, Dithering: Enable */
+#define     DVI_PANEL_ID1_800x600       0x01        /* Resolution: 800x600,   Channel: single, Dithering: Enable */
+#define     DVI_PANEL_ID1_1024x768      0x02        /* Resolution: 1024x768,  Channel: single, Dithering: Enable */
+#define     DVI_PANEL_ID1_1280x768      0x03        /* Resolution: 1280x768,  Channel: single, Dithering: Enable */
+#define     DVI_PANEL_ID1_1280x1024     0x04        /* Resolution: 1280x1024, Channel: dual,   Dithering: Enable */
+#define     DVI_PANEL_ID1_1400x1050     0x05        /* Resolution: 1400x1050, Channel: dual,   Dithering: Enable */
+#define     DVI_PANEL_ID1_1600x1200     0x06        /* Resolution: 1600x1200, Channel: dual,   Dithering: Enable */
+
+/* Define the version of EDID */
+#define     EDID_VERSION_1      1
+#define     EDID_VERSION_2      2
+
+#endif /* __DVI_H__ */
diff -Nur linux-2.6.21-rc7/drivers/video/via/hwcfig.h linux-2.6.21-rc7.viafb/drivers/video/via/hwcfig.h
--- linux-2.6.21-rc7/drivers/video/via/hwcfig.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/hwcfig.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,399 @@
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
+#ifndef __HWCFIG_H__
+#define __HWCFIG_H__
+
+#include <linux/ioport.h>
+#include <asm/io.h>
+
+#include "share.h"
+#include "hw.h"
+
+static struct pll_map pll_value[] = {
+    {CLK_25_175M,  CLE266_PLL_25_175M,  K800_PLL_25_175M,  CX700_25_175M},
+    {CLK_29_581M,  CLE266_PLL_29_581M,  K800_PLL_29_581M,  CX700_29_581M},
+    {CLK_26_880M,  CLE266_PLL_26_880M,  K800_PLL_26_880M,  CX700_26_880M},
+    {CLK_31_490M,  CLE266_PLL_31_490M,  K800_PLL_31_490M,  CX700_31_490M},
+    {CLK_31_500M,  CLE266_PLL_31_500M,  K800_PLL_31_500M,  CX700_31_500M},
+    {CLK_31_728M,  CLE266_PLL_31_728M,  K800_PLL_31_728M,  CX700_31_728M},
+    {CLK_32_668M,  CLE266_PLL_32_668M,  K800_PLL_32_668M,  CX700_32_668M},
+    {CLK_36_000M,  CLE266_PLL_36_000M,  K800_PLL_36_000M,  CX700_36_000M},
+    {CLK_40_000M,  CLE266_PLL_40_000M,  K800_PLL_40_000M,  CX700_40_000M},
+    {CLK_41_291M,  CLE266_PLL_41_291M,  K800_PLL_41_291M,  CX700_41_291M},
+    {CLK_43_163M,  CLE266_PLL_43_163M,  K800_PLL_43_163M,  CX700_43_163M},
+    {CLK_48_875M,  CLE266_PLL_48_875M,  K800_PLL_48_875M,  CX700_48_875M},
+    {CLK_49_500M,  CLE266_PLL_49_500M,  K800_PLL_49_500M,  CX700_49_500M},
+    {CLK_52_406M,  CLE266_PLL_52_406M,  K800_PLL_52_406M,  CX700_52_406M},
+    {CLK_56_250M,  CLE266_PLL_56_250M,  K800_PLL_56_250M,  CX700_56_250M},
+    {CLK_65_000M,  CLE266_PLL_65_000M,  K800_PLL_65_000M,  CX700_65_000M},
+    {CLK_68_179M,  CLE266_PLL_68_179M,  K800_PLL_68_179M,  CX700_68_179M},
+    {CLK_78_750M,  CLE266_PLL_78_750M,  K800_PLL_78_750M,  CX700_78_750M},
+    {CLK_80_136M,  CLE266_PLL_80_136M,  K800_PLL_80_136M,  CX700_80_136M},
+    {CLK_83_375M,  CLE266_PLL_83_375M,  K800_PLL_83_375M,  CX700_83_375M},
+    {CLK_83_950M,  CLE266_PLL_83_950M,  K800_PLL_83_950M,  CX700_83_950M},
+    {CLK_85_860M,  CLE266_PLL_85_860M,  K800_PLL_85_860M,  CX700_85_860M},
+    {CLK_94_500M,  CLE266_PLL_94_500M,  K800_PLL_94_500M,  CX700_94_500M},
+    {CLK_108_000M, CLE266_PLL_108_000M, K800_PLL_108_000M, CX700_108_000M},
+    {CLK_125_104M, CLE266_PLL_125_104M, K800_PLL_125_104M, CX700_125_104M},
+    {CLK_133_308M, CLE266_PLL_133_308M, K800_PLL_133_308M, CX700_133_308M},
+    {CLK_135_000M, CLE266_PLL_135_000M, K800_PLL_135_000M, CX700_135_000M},
+    {CLK_157_500M, CLE266_PLL_157_500M, K800_PLL_157_500M, CX700_157_500M},
+    {CLK_162_000M, CLE266_PLL_162_000M, K800_PLL_162_000M, CX700_162_000M},
+    {CLK_202_500M, CLE266_PLL_202_500M, K800_PLL_202_500M, CX700_202_500M},
+    {CLK_234_000M, CLE266_PLL_234_000M, K800_PLL_234_000M, CX700_234_000M},
+    {CLK_297_500M, CLE266_PLL_297_500M, K800_PLL_297_500M, CX700_297_500M},
+    {CLK_74_481M,  CLE266_PLL_74_481M,  K800_PLL_74_481M,  CX700_74_481M},
+    {CLK_172_798M, CLE266_PLL_172_798M, K800_PLL_172_798M, CX700_172_798M},
+    {CLK_122_614M, CLE266_PLL_122_614M, K800_PLL_122_614M, CX700_122_614M}
+    
+};
+
+#define NUM_TOTAL_PLL_TABLE ARRAY_SIZE(pll_value)
+
+static struct fifo_depth_select display_fifo_depth_reg= {
+    /* IGA1 FIFO Depth_Select */
+    {IGA1_FIFO_DEPTH_SELECT_REG_NUM, {{SR17,0,7}}},
+    /* IGA2 FIFO Depth_Select */
+    {IGA2_FIFO_DEPTH_SELECT_REG_NUM, {{CR68,4,7}, {CR94,7,7}, {CR95,7,7}}}
+};
+
+static struct fifo_threshold_select fifo_threshold_select_reg= {
+    /* IGA1 FIFO Threshold Select */
+    {IGA1_FIFO_THRESHOLD_REG_NUM, {{SR16,0,5},{SR16,7,7}}},
+    /* IGA2 FIFO Threshold Select */
+    {IGA2_FIFO_THRESHOLD_REG_NUM, {{CR68,0,3}, {CR95,4,6}}}
+};
+
+static struct fifo_high_threshold_select fifo_high_threshold_select_reg= {
+    /* IGA1 FIFO High Threshold Select */
+    {IGA1_FIFO_HIGH_THRESHOLD_REG_NUM, {{SR18,0,5},{SR18,7,7}}},
+    /* IGA2 FIFO High Threshold Select */
+    {IGA2_FIFO_HIGH_THRESHOLD_REG_NUM, {{CR92,0,3}, {CR95,0,2}}}
+};
+
+static struct display_queue_expire_num display_queue_expire_num_reg= {
+    /* IGA1 Display Queue Expire Num */
+    {IGA1_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM, {{SR22,0,4}}},
+    /* IGA2 Display Queue Expire Num */
+    {IGA2_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM, {{CR94,0,6}}}
+};
+
+/* Definition Offset Registers */
+static struct offset offset_reg = {
+    /* IGA1 Offset Register */
+    {IGA1_OFFSET_REG_NUM, {{CR13,0,7},{CR35,5,7}}},
+    /* IGA2 Offset Register */
+    {IGA2_OFFSET_REG_NUM, {{CR66,0,7},{CR67,0,1}}}
+};
+
+/* Definition Fetch Count Registers */
+static struct fetch_count fetch_count_reg = {
+    /* IGA1 Fetch Count Register */
+    {IGA1_FETCH_COUNT_REG_NUM, {{SR1C,0,7},{SR1D,0,1}}},
+    /* IGA2 Fetch Count Register */
+    {IGA2_FETCH_COUNT_REG_NUM, {{CR65,0,7},{CR67,2,3}}}
+};
+
+#define IGA1_STARTING_ADDR_REG_NUM      4           /* location: {CR0C,0,7},{CR0D,0,7},{CR34,0,7},{CR48,0,1} */
+#define IGA2_STARTING_ADDR_REG_NUM      3           /* location: {CR62,1,7},{CR63,0,7},{CR64,0,7} */
+
+static struct iga1_crtc_timing iga1_crtc_reg = {
+    /* IGA1 Horizontal Total */
+    {IGA1_HOR_TOTAL_REG_NUM, {{CR00,0,7}, {CR36,3,3}}},
+    /* IGA1 Horizontal Addressable Video */
+    {IGA1_HOR_ADDR_REG_NUM, {{CR01,0,7}}},
+    /* IGA1 Horizontal Blank Start */
+    {IGA1_HOR_BLANK_START_REG_NUM, {{CR02,0,7}}},
+    /* IGA1 Horizontal Blank End */
+    {IGA1_HOR_BLANK_END_REG_NUM, {{CR03,0,4}, {CR05,7,7}, {CR33,5,5}}},
+    /* IGA1 Horizontal Sync Start */
+    {IGA1_HOR_SYNC_START_REG_NUM, {{CR04,0,7}, {CR33,4,4}}},
+    /* IGA1 Horizontal Sync End */
+    {IGA1_HOR_SYNC_END_REG_NUM, {{CR05,0,4}}},
+    /* IGA1 Vertical Total */
+    {IGA1_VER_TOTAL_REG_NUM, {{CR06,0,7}, {CR07,0,0}, {CR07,5,5}, {CR35,0,0}}},
+    /* IGA1 Vertical Addressable Video */
+    {IGA1_VER_ADDR_REG_NUM, {{CR12,0,7}, {CR07,1,1}, {CR07,6,6}, {CR35,2,2}}},
+    /* IGA1 Vertical Blank Start */
+    {IGA1_VER_BLANK_START_REG_NUM, {{CR15,0,7}, {CR07,3,3}, {CR09,5,5}, {CR35,3,3}}},
+    /* IGA1 Vertical Blank End */
+    {IGA1_VER_BLANK_END_REG_NUM, {{CR16,0,7}}},
+    /* IGA1 Vertical Sync Start */
+    {IGA1_VER_SYNC_START_REG_NUM, {{CR10,0,7}, {CR07,2,2}, {CR07,7,7}, {CR35,1,1}}},
+    /* IGA1 Vertical Sync End */
+    {IGA1_VER_SYNC_END_REG_NUM, {{CR11,0,3}}}
+};
+
+static struct iga2_shadow_crtc_timing iga2_shadow_crtc_reg = {
+    /* IGA2 Shadow Horizontal Total */
+    {IGA2_SHADOW_HOR_TOTAL_REG_NUM, {{CR6D,0,7}, {CR71,3,3}}},
+    /* IGA2 Shadow Horizontal Blank End */
+    {IGA2_SHADOW_HOR_BLANK_END_REG_NUM, {{CR6E,0,7}}},
+    /* IGA2 Shadow Vertical Total */
+    {IGA2_SHADOW_VER_TOTAL_REG_NUM, {{CR6F,0,7}, {CR71,0,2}}},
+    /* IGA2 Shadow Vertical Addressable Video */
+    {IGA2_SHADOW_VER_ADDR_REG_NUM, {{CR70,0,7}, {CR71,4,6}}},
+    /* IGA2 Shadow Vertical Blank Start */
+    {IGA2_SHADOW_VER_BLANK_START_REG_NUM, {{CR72,0,7}, {CR74,4,6}}},
+    /* IGA2 Shadow Vertical Blank End */
+    {IGA2_SHADOW_VER_BLANK_END_REG_NUM, {{CR73,0,7}, {CR74,0,2}}},
+    /* IGA2 Shadow Vertical Sync Start */
+    {IGA2_SHADOW_VER_SYNC_START_REG_NUM, {{CR75,0,7}, {CR76,4,6}}},
+    /* IGA2 Shadow Vertical Sync End */
+    {IGA2_SHADOW_VER_SYNC_END_REG_NUM, {{CR76,0,3}}}
+};
+
+static struct iga2_crtc_timing iga2_crtc_reg = {
+    /* IGA2 Horizontal Total */
+    {IGA2_HOR_TOTAL_REG_NUM, {{CR50,0,7}, {CR55,0,3}}},
+    /* IGA2 Horizontal Addressable Video */
+    {IGA2_HOR_ADDR_REG_NUM, {{CR51,0,7}, {CR55,4,6}}},
+    /* IGA2 Horizontal Blank Start */
+    {IGA2_HOR_BLANK_START_REG_NUM, {{CR52,0,7}, {CR54,0,2}}},
+    /* IGA2 Horizontal Blank End */
+    {IGA2_HOR_BLANK_END_REG_NUM, {{CR53,0,7}, {CR54,3,5}, {CR5D,6,6}}},
+    /* IGA2 Horizontal Sync Start */
+    {IGA2_HOR_SYNC_START_REG_NUM, {{CR56,0,7}, {CR54,6,7}, {CR5C,7,7}, {CR5D,7,7}}},
+    /* IGA2 Horizontal Sync End */
+    {IGA2_HOR_SYNC_END_REG_NUM, {{CR57,0,7}, {CR5C,6,6}}},
+    /* IGA2 Vertical Total */
+    {IGA2_VER_TOTAL_REG_NUM, {{CR58,0,7}, {CR5D,0,2}}},
+    /* IGA2 Vertical Addressable Video */
+    {IGA2_VER_ADDR_REG_NUM, {{CR59,0,7}, {CR5D,3,5}}},
+    /* IGA2 Vertical Blank Start */
+    {IGA2_VER_BLANK_START_REG_NUM, {{CR5A,0,7}, {CR5C,0,2}}},
+    /* IGA2 Vertical Blank End */
+    {IGA2_VER_BLANK_END_REG_NUM, {{CR5B,0,7}, {CR5C,3,5}}},
+    /* IGA2 Vertical Sync Start */
+    {IGA2_VER_SYNC_START_REG_NUM, {{CR5E,0,7}, {CR5F,5,7}}},
+    /* IGA2 Vertical Sync End */
+    {IGA2_VER_SYNC_END_REG_NUM, {{CR5F,0,4}}}
+};
+
+static struct _lcd_scaling_factor lcd_scaling_factor = {
+    /* LCD Horizontal Scaling Factor Register */
+    {LCD_HOR_SCALING_FACTOR_REG_NUM, {{CR9F,0,1}, {CR77,0,7}, {CR79,4,5}}},
+    /* LCD Vertical Scaling Factor Register */
+    {LCD_VER_SCALING_FACTOR_REG_NUM, {{CR79,3,3}, {CR78,0,7}, {CR79,6,7}}}
+};
+static struct _lcd_scaling_factor lcd_scaling_factor_CLE = {
+    /* LCD Horizontal Scaling Factor Register */
+    {LCD_HOR_SCALING_FACTOR_REG_NUM_CLE, {{CR77,0,7}, {CR79,4,5}}},
+    /* LCD Vertical Scaling Factor Register */
+    {LCD_VER_SCALING_FACTOR_REG_NUM_CLE, {{CR78,0,7}, {CR79,6,7}}}
+};
+
+static struct rgbLUT palLUT_table[]= {
+    /* {R,G,B} */
+    /* Index 0x00~0x03 */
+    {0x00, 0x00, 0x00}, {0x00, 0x00, 0x2A}, {0x00, 0x2A, 0x00}, {0x00, 0x2A, 0x2A},
+    /* Index 0x04~0x07 */
+    {0x2A, 0x00, 0x00}, {0x2A, 0x00, 0x2A}, {0x2A, 0x15, 0x00}, {0x2A, 0x2A, 0x2A},
+    /* Index 0x08~0x0B */
+    {0x15, 0x15, 0x15}, {0x15, 0x15, 0x3F}, {0x15, 0x3F, 0x15}, {0x15, 0x3F, 0x3F},
+    /* Index 0x0C~0x0F */
+    {0x3F, 0x15, 0x15}, {0x3F, 0x15, 0x3F}, {0x3F, 0x3F, 0x15}, {0x3F, 0x3F, 0x3F},
+    /* Index 0x10~0x13 */
+    {0x00, 0x00, 0x00}, {0x05, 0x05, 0x05}, {0x08, 0x08, 0x08}, {0x0B, 0x0B, 0x0B},
+    /* Index 0x14~0x17 */
+    {0x0E, 0x0E, 0x0E}, {0x11, 0x11, 0x11}, {0x14, 0x14, 0x14}, {0x18, 0x18, 0x18},
+    /* Index 0x18~0x1B */
+    {0x1C, 0x1C, 0x1C}, {0x20, 0x20, 0x20}, {0x24, 0x24, 0x24}, {0x28, 0x28, 0x28},
+    /* Index 0x1C~0x1F */
+    {0x2D, 0x2D, 0x2D}, {0x32, 0x32, 0x32}, {0x38, 0x38, 0x38}, {0x3F, 0x3F, 0x3F},
+    /* Index 0x20~0x23 */
+    {0x00, 0x00, 0x3F}, {0x10, 0x00, 0x3F}, {0x1F, 0x00, 0x3F}, {0x2F, 0x00, 0x3F},
+    /* Index 0x24~0x27 */
+    {0x3F, 0x00, 0x3F}, {0x3F, 0x00, 0x2F}, {0x3F, 0x00, 0x1F}, {0x3F, 0x00, 0x10},
+    /* Index 0x28~0x2B */
+    {0x3F, 0x00, 0x00}, {0x3F, 0x10, 0x00}, {0x3F, 0x1F, 0x00}, {0x3F, 0x2F, 0x00},
+    /* Index 0x2C~0x2F */
+    {0x3F, 0x3F, 0x00}, {0x2F, 0x3F, 0x00}, {0x1F, 0x3F, 0x00}, {0x10, 0x3F, 0x00},
+    /* Index 0x30~0x33 */
+    {0x00, 0x3F, 0x00}, {0x00, 0x3F, 0x10}, {0x00, 0x3F, 0x1F}, {0x00, 0x3F, 0x2F},
+    /* Index 0x34~0x37 */
+    {0x00, 0x3F, 0x3F}, {0x00, 0x2F, 0x3F}, {0x00, 0x1F, 0x3F}, {0x00, 0x10, 0x3F},
+    /* Index 0x38~0x3B */
+    {0x1F, 0x1F, 0x3F}, {0x27, 0x1F, 0x3F}, {0x2F, 0x1F, 0x3F}, {0x37, 0x1F, 0x3F},
+    /* Index 0x3C~0x3F */ 
+    {0x3F, 0x1F, 0x3F}, {0x3F, 0x1F, 0x37}, {0x3F, 0x1F, 0x2F}, {0x3F, 0x1F, 0x27},
+    /* Index 0x40~0x43 */
+    {0x3F, 0x1F, 0x1F}, {0x3F, 0x27, 0x1F}, {0x3F, 0x2F, 0x1F}, {0x3F, 0x3F, 0x1F},
+    /* Index 0x44~0x47 */
+    {0x3F, 0x3F, 0x1F}, {0x37, 0x3F, 0x1F}, {0x2F, 0x3F, 0x1F}, {0x27, 0x3F, 0x1F},
+    /* Index 0x48~0x4B */
+    {0x1F, 0x3F, 0x1F}, {0x1F, 0x3F, 0x27}, {0x1F, 0x3F, 0x2F}, {0x1F, 0x3F, 0x37},
+    /* Index 0x4C~0x4F */
+    {0x1F, 0x3F, 0x3F}, {0x1F, 0x37, 0x3F}, {0x1F, 0x2F, 0x3F}, {0x1F, 0x27, 0x3F},
+    /* Index 0x50~0x53 */
+    {0x2D, 0x2D, 0x3F}, {0x31, 0x2D, 0x3F}, {0x36, 0x2D, 0x3F}, {0x3A, 0x2D, 0x3F},
+    /* Index 0x54~0x57 */
+    {0x3F, 0x2D, 0x3F}, {0x3F, 0x2D, 0x3A}, {0x3F, 0x2D, 0x36}, {0x3F, 0x2D, 0x31},
+    /* Index 0x58~0x5B */
+    {0x3F, 0x2D, 0x2D}, {0x3F, 0x31, 0x2D}, {0x3F, 0x36, 0x2D}, {0x3F, 0x3A, 0x2D},
+    /* Index 0x5C~0x5F */
+    {0x3F, 0x3F, 0x2D}, {0x3A, 0x3F, 0x2D}, {0x36, 0x3F, 0x2D}, {0x31, 0x3F, 0x2D},
+    /* Index 0x60~0x63 */
+    {0x2D, 0x3F, 0x2D}, {0x2D, 0x3F, 0x31}, {0x2D, 0x3F, 0x36}, {0x2D, 0x3F, 0x3A},
+    /* Index 0x64~0x67 */
+    {0x2D, 0x3F, 0x3F}, {0x2D, 0x3A, 0x3F}, {0x2D, 0x36, 0x3F}, {0x2D, 0x31, 0x3F},
+    /* Index 0x68~0x6B */
+    {0x00, 0x00, 0x1C}, {0x07, 0x00, 0x1C}, {0x0E, 0x00, 0x1C}, {0x15, 0x00, 0x1C},
+    /* Index 0x6C~0x6F */
+    {0x1C, 0x00, 0x1C}, {0x1C, 0x00, 0x15}, {0x1C, 0x00, 0x0E}, {0x1C, 0x00, 0x07},
+    /* Index 0x70~0x73 */
+    {0x1C, 0x00, 0x00}, {0x1C, 0x07, 0x00}, {0x1C, 0x0E, 0x00}, {0x1C, 0x15, 0x00},
+    /* Index 0x74~0x77 */
+    {0x1C, 0x1C, 0x00}, {0x15, 0x1C, 0x00}, {0x0E, 0x1C, 0x00}, {0x07, 0x1C, 0x00},
+    /* Index 0x78~0x7B */
+    {0x00, 0x1C, 0x00}, {0x00, 0x1C, 0x07}, {0x00, 0x1C, 0x0E}, {0x00, 0x1C, 0x15},
+    /* Index 0x7C~0x7F */
+    {0x00, 0x1C, 0x1C}, {0x00, 0x15, 0x1C}, {0x00, 0x0E, 0x1C}, {0x00, 0x07, 0x1C},
+    /* Index 0x80~0x83 */
+    {0x0E, 0x0E, 0x1C}, {0x11, 0x0E, 0x1C}, {0x15, 0x0E, 0x1C}, {0x18, 0x0E, 0x1C},
+    /* Index 0x84~0x87 */
+    {0x1C, 0x0E, 0x1C}, {0x1C, 0x0E, 0x18}, {0x1C, 0x0E, 0x15}, {0x1C, 0x0E, 0x11},
+    /* Index 0x88~0x8B */
+    {0x1C, 0x0E, 0x0E}, {0x1C, 0x11, 0x0E}, {0x1C, 0x15, 0x0E}, {0x1C, 0x18, 0x0E},
+    /* Index 0x8C~0x8F */
+    {0x1C, 0x1C, 0x0E}, {0x18, 0x1C, 0x0E}, {0x15, 0x1C, 0x0E}, {0x11, 0x1C, 0x0E},
+    /* Index 0x90~0x93 */
+    {0x0E, 0x1C, 0x0E}, {0x0E, 0x1C, 0x11}, {0x0E, 0x1C, 0x15}, {0x0E, 0x1C, 0x18},
+    /* Index 0x94~0x97 */
+    {0x0E, 0x1C, 0x1C}, {0x0E, 0x18, 0x1C}, {0x0E, 0x15, 0x1C}, {0x0E, 0x11, 0x1C},
+    /* Index 0x98~0x9B */
+    {0x14, 0x14, 0x1C}, {0x16, 0x14, 0x1C}, {0x18, 0x14, 0x1C}, {0x1A, 0x14, 0x1C},
+    /* Index 0x9C~0x9F */
+    {0x1C, 0x14, 0x1C}, {0x1C, 0x14, 0x1A}, {0x1C, 0x14, 0x18}, {0x1C, 0x14, 0x16},
+    /* Index 0xA0~0xA3 */
+    {0x1C, 0x14, 0x14}, {0x1C, 0x16, 0x14}, {0x1C, 0x18, 0x14}, {0x1C, 0x1A, 0x14},
+    /* Index 0xA4~0xA7 */
+    {0x1C, 0x1C, 0x14}, {0x1A, 0x1C, 0x14}, {0x18, 0x1C, 0x14}, {0x16, 0x1C, 0x14},
+    /* Index 0xA8~0xAB */
+    {0x14, 0x1C, 0x14}, {0x14, 0x1C, 0x16}, {0x14, 0x1C, 0x18}, {0x14, 0x1C, 0x1A},
+    /* Index 0xAC~0xAF */
+    {0x14, 0x1C, 0x1C}, {0x14, 0x1A, 0x1C}, {0x14, 0x18, 0x1C}, {0x14, 0x16, 0x1C},
+    /* Index 0xB0~0xB3 */
+    {0x00, 0x00, 0x10}, {0x04, 0x00, 0x10}, {0x08, 0x00, 0x10}, {0x0C, 0x00, 0x10},
+    /* Index 0xB4~0xB7 */
+    {0x10, 0x00, 0x10}, {0x10, 0x00, 0x0C}, {0x10, 0x00, 0x08}, {0x10, 0x00, 0x04},
+    /* Index 0xB8~0xBB */
+    {0x10, 0x00, 0x00}, {0x10, 0x04, 0x00}, {0x10, 0x08, 0x00}, {0x10, 0x0C, 0x00},
+    /* Index 0xBC~0xBF */
+    {0x10, 0x10, 0x00}, {0x0C, 0x10, 0x00}, {0x08, 0x10, 0x00}, {0x04, 0x10, 0x00},
+    /* Index 0xC0~0xC3 */
+    {0x00, 0x10, 0x00}, {0x00, 0x10, 0x04}, {0x00, 0x10, 0x08}, {0x00, 0x10, 0x0C},
+    /* Index 0xC4~0xC7 */
+    {0x00, 0x10, 0x10}, {0x00, 0x0C, 0x10}, {0x00, 0x08, 0x10}, {0x00, 0x04, 0x10},
+    /* Index 0xC8~0xCB */
+    {0x08, 0x08, 0x10}, {0x0A, 0x08, 0x10}, {0x0C, 0x08, 0x10}, {0x0E, 0x08, 0x10},
+    /* Index 0xCC~0xCF */
+    {0x10, 0x08, 0x10}, {0x10, 0x08, 0x0E}, {0x10, 0x08, 0x0C}, {0x10, 0x08, 0x0A},
+    /* Index 0xD0~0xD3 */
+    {0x10, 0x08, 0x08}, {0x10, 0x0A, 0x08}, {0x10, 0x0C, 0x08}, {0x10, 0x0E, 0x08},
+    /* Index 0xD4~0xD7 */
+    {0x10, 0x10, 0x08}, {0x0E, 0x10, 0x08}, {0x0C, 0x10, 0x08}, {0x0A, 0x10, 0x08},
+    /* Index 0xD8~0xDB */
+    {0x08, 0x10, 0x08}, {0x08, 0x10, 0x0A}, {0x08, 0x10, 0x0C}, {0x08, 0x10, 0x0E},
+    /* Index 0xDC~0xDF */
+    {0x08, 0x10, 0x10}, {0x08, 0x0E, 0x10}, {0x08, 0x0C, 0x10}, {0x08, 0x0A, 0x10},
+    /* Index 0xE0~0xE3 */
+    {0x0B, 0x0B, 0x10}, {0x0C, 0x0B, 0x10}, {0x0D, 0x0B, 0x10}, {0x0F, 0x0B, 0x10},
+    /* Index 0xE4~0xE7 */
+    {0x10, 0x0B, 0x10}, {0x10, 0x0B, 0x0F}, {0x10, 0x0B, 0x0D}, {0x10, 0x0B, 0x0C},
+    /* Index 0xE8~0xEB */
+    {0x10, 0x0B, 0x0B}, {0x10, 0x0C, 0x0B}, {0x10, 0x0D, 0x0B}, {0x10, 0x0F, 0x0B},
+    /* Index 0xEC~0xEF */
+    {0x10, 0x10, 0x0B}, {0x0F, 0x10, 0x0B}, {0x0D, 0x10, 0x0B}, {0x0C, 0x10, 0x0B},
+    /* Index 0xF0~0xF3 */
+    {0x0B, 0x10, 0x0B}, {0x0B, 0x10, 0x0C}, {0x0B, 0x10, 0x0D}, {0x0B, 0x10, 0x0F},
+    /* Index 0xF4~0xF7 */
+    {0x0B, 0x10, 0x10}, {0x0B, 0x0F, 0x10}, {0x0B, 0x0D, 0x10}, {0x0B, 0x0C, 0x10},
+    /* Index 0xF8~0xFB */
+    {0x00, 0x00, 0x00}, {0x00, 0x00, 0x00}, {0x00, 0x00, 0x00}, {0x00, 0x00, 0x00},
+    /* Index 0xFC~0xFF */
+    {0x00, 0x00, 0x00}, {0x00, 0x00, 0x00}, {0x00, 0x00, 0x00}, {0x00, 0x00, 0x00}
+};
+
+static u16 red256[] = {
+0x0   ,0x0   ,0x0   ,0x0   ,0xa800,0xa800,0xa800,0xa800,0x5400,0x5400,0x5400,0x5400,0xfc00,0xfc00,0xfc00,0xfc00,
+0x0   ,0x1400,0x2000,0x2c00,0x3800,0x4400,0x5000,0x6000,0x7000,0x8000,0x9000,0xa000,0xb400,0xc800,0xe000,0xfc00,
+0x0   ,0x4000,0x7c00,0xbc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xbc00,0x7c00,0x4000,
+0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x7c00,0x9c00,0xbc00,0xdc00,0xfc00,0xfc00,0xfc00,0xfc00,
+0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xdc00,0xbc00,0x9c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,
+0xb400,0xc400,0xd800,0xe800,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xe800,0xd800,0xc400,
+0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0x0   ,0x1c00,0x3800,0x5400,0x7000,0x7000,0x7000,0x7000,
+0x7000,0x7000,0x7000,0x7000,0x7000,0x5400,0x3800,0x1c00,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
+0x3800,0x4400,0x5400,0x6000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x6000,0x5400,0x4400,
+0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x5000,0x5800,0x6000,0x6800,0x7000,0x7000,0x7000,0x7000,
+0x7000,0x7000,0x7000,0x7000,0x7000,0x6800,0x6000,0x5800,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,
+0x0   ,0x1000,0x2000,0x3000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x3000,0x2000,0x1000,
+0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x2000,0x2800,0x3000,0x3800,0x4000,0x4000,0x4000,0x4000,
+0x4000,0x4000,0x4000,0x4000,0x4000,0x3800,0x3000,0x2800,0x2000,0x2000,0x2000,0x2000,0x2000,0x2000,0x2000,0x2000,
+0x2c00,0x3000,0x3400,0x3c00,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x3c00,0x3400,0x3000,
+0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0
+};
+static u16 green256[] = {
+0x0   ,0x0   ,0xa800,0xa800,0x0   ,0x0   ,0x5400,0xa800,0x5400,0x5400,0xfc00,0xfc00,0x5400,0x5400,0xfc00,0xfc00,
+0x0   ,0x1400,0x2000,0x2c00,0x3800,0x4400,0x5000,0x6000,0x7000,0x8000,0x9000,0xa000,0xb400,0xc800,0xe000,0xfc00,
+0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x7c00,0xbc00,0xfc00,0xfc00,0xfc00,0xfc00,
+0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xbc00,0x7c00,0x4000,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,
+0x7c00,0x9c00,0xbc00,0xdc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xdc00,0xbc00,0x9c00,
+0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xc400,0xd800,0xe800,0xfc00,0xfc00,0xfc00,0xfc00,
+0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xe800,0xd800,0xc400,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
+0x0   ,0x1c00,0x3800,0x5400,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x5400,0x3800,0x1c00,
+0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x4400,0x5400,0x6000,0x7000,0x7000,0x7000,0x7000,
+0x7000,0x7000,0x7000,0x7000,0x7000,0x6000,0x5400,0x4400,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,
+0x5000,0x5800,0x6000,0x6800,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x6800,0x6000,0x5800,
+0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x1000,0x2000,0x3000,0x4000,0x4000,0x4000,0x4000,
+0x4000,0x4000,0x4000,0x4000,0x4000,0x3000,0x2000,0x1000,0x2000,0x2000,0x2000,0x2000,0x2000,0x2000,0x2000,0x2000,
+0x2000,0x2800,0x3000,0x3800,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x3800,0x3000,0x2800,
+0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x3000,0x3400,0x3c00,0x4000,0x4000,0x4000,0x4000,
+0x4000,0x4000,0x4000,0x4000,0x4000,0x3c00,0x3400,0x3000,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0
+};
+static u16 blue256[] = {
+0x0   ,0xa800,0x0   ,0xa800,0x0   ,0xa800,0x0   ,0xa800,0x5400,0xfc00,0x5400,0xfc00,0x5400,0xfc00,0x5400,0xfc00,
+0x0   ,0x1400,0x2000,0x2c00,0x3800,0x4400,0x5000,0x6000,0x7000,0x8000,0x9000,0xa000,0xb400,0xc800,0xe000,0xfc00,
+0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xbc00,0x7c00,0x4000,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
+0x0   ,0x4000,0x7c00,0xbc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xdc00,0xbc00,0x9c00,
+0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x7c00,0x9c00,0xbc00,0xdc00,0xfc00,0xfc00,0xfc00,0xfc00,
+0xfc00,0xfc00,0xfc00,0xfc00,0xfc00,0xe800,0xd800,0xc400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,0xb400,
+0xb400,0xc400,0xd800,0xe800,0xfc00,0xfc00,0xfc00,0xfc00,0x7000,0x7000,0x7000,0x7000,0x7000,0x5400,0x3800,0x1c00,
+0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x1c00,0x3800,0x5400,0x7000,0x7000,0x7000,0x7000,
+0x7000,0x7000,0x7000,0x7000,0x7000,0x6000,0x5400,0x4400,0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,0x3800,
+0x3800,0x4400,0x5400,0x6000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x7000,0x6800,0x6000,0x5800,
+0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5000,0x5800,0x6000,0x6800,0x7000,0x7000,0x7000,0x7000,
+0x4000,0x4000,0x4000,0x4000,0x4000,0x3000,0x2000,0x1000,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,
+0x0   ,0x1000,0x2000,0x3000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x4000,0x3800,0x3000,0x2800,
+0x2000,0x2000,0x2000,0x2000,0x2000,0x2000,0x2000,0x2000,0x2000,0x2800,0x3000,0x3800,0x4000,0x4000,0x4000,0x4000,
+0x4000,0x4000,0x4000,0x4000,0x4000,0x3c00,0x3400,0x3000,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,0x2c00,
+0x2c00,0x3000,0x3400,0x3c00,0x4000,0x4000,0x4000,0x4000,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0   ,0x0
+};
+#endif /* __HWCFIG_H__ */
+
+
+
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/hw.h linux-2.6.21-rc7.viafb/drivers/video/via/hw.h
--- linux-2.6.21-rc7/drivers/video/via/hw.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/hw.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,749 @@
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
+#ifndef __HW_H__
+#define __HW_H__
+
+#include <linux/ioport.h>
+#include <asm/io.h>
+
+#include "share.h"
+
+
+/***************************************************/
+/* Definition IGA1 Design Method of CRTC Registers */
+/***************************************************/
+#define IGA1_HOR_TOTAL_FORMULA(x)           ((x)/8)-5
+#define IGA1_HOR_ADDR_FORMULA(x)            ((x)/8)-1
+#define IGA1_HOR_BLANK_START_FORMULA(x)     ((x)/8)-1
+#define IGA1_HOR_BLANK_END_FORMULA(x,y)     ((x+y)/8)-1
+#define IGA1_HOR_SYNC_START_FORMULA(x)      ((x)/8)
+#define IGA1_HOR_SYNC_END_FORMULA(x,y)      ((x+y)/8)
+
+#define IGA1_VER_TOTAL_FORMULA(x)           (x)-2
+#define IGA1_VER_ADDR_FORMULA(x)            (x)-1
+#define IGA1_VER_BLANK_START_FORMULA(x)     (x)-1
+#define IGA1_VER_BLANK_END_FORMULA(x,y)     (x+y)-1
+#define IGA1_VER_SYNC_START_FORMULA(x)      (x)-1
+#define IGA1_VER_SYNC_END_FORMULA(x,y)      (x+y)-1
+
+/***************************************************/
+/* Definition IGA2 Design Method of CRTC Registers */
+/***************************************************/
+#define IGA2_HOR_TOTAL_FORMULA(x)           (x)-1
+#define IGA2_HOR_ADDR_FORMULA(x)            (x)-1
+#define IGA2_HOR_BLANK_START_FORMULA(x)     (x)-1
+#define IGA2_HOR_BLANK_END_FORMULA(x,y)     (x+y)-1
+#define IGA2_HOR_SYNC_START_FORMULA(x)      (x)-1
+#define IGA2_HOR_SYNC_END_FORMULA(x,y)      (x+y)-1
+
+#define IGA2_VER_TOTAL_FORMULA(x)           (x)-1
+#define IGA2_VER_ADDR_FORMULA(x)            (x)-1
+#define IGA2_VER_BLANK_START_FORMULA(x)     (x)-1
+#define IGA2_VER_BLANK_END_FORMULA(x,y)     (x+y)-1
+#define IGA2_VER_SYNC_START_FORMULA(x)      (x)-1
+#define IGA2_VER_SYNC_END_FORMULA(x,y)      (x+y)-1
+
+/**********************************************************/
+/* Definition IGA2 Design Method of CRTC Shadow Registers */
+/**********************************************************/
+#define IGA2_HOR_TOTAL_SHADOW_FORMULA(x)           (x/8)-5
+#define IGA2_HOR_BLANK_END_SHADOW_FORMULA(x,y)     ((x+y)/8)-1
+#define IGA2_VER_TOTAL_SHADOW_FORMULA(x)           (x)-2
+#define IGA2_VER_ADDR_SHADOW_FORMULA(x)            (x)-1
+#define IGA2_VER_BLANK_START_SHADOW_FORMULA(x)     (x)-1
+#define IGA2_VER_BLANK_END_SHADOW_FORMULA(x,y)     (x+y)-1
+#define IGA2_VER_SYNC_START_SHADOW_FORMULA(x)      (x)
+#define IGA2_VER_SYNC_END_SHADOW_FORMULA(x,y)      (x+y)
+
+/* Define Register Number for IGA1 CRTC Timing */
+#define IGA1_HOR_TOTAL_REG_NUM          2           /* location: {CR00,0,7},{CR36,3,3} */
+#define IGA1_HOR_ADDR_REG_NUM           1           /* location: {CR01,0,7} */
+#define IGA1_HOR_BLANK_START_REG_NUM    1           /* location: {CR02,0,7} */
+#define IGA1_HOR_BLANK_END_REG_NUM      3           /* location: {CR03,0,4},{CR05,7,7},{CR33,5,5} */
+#define IGA1_HOR_SYNC_START_REG_NUM     2           /* location: {CR04,0,7},{CR33,4,4} */
+#define IGA1_HOR_SYNC_END_REG_NUM       1           /* location: {CR05,0,4} */
+#define IGA1_VER_TOTAL_REG_NUM          4           /* location: {CR06,0,7},{CR07,0,0},{CR07,5,5},{CR35,0,0} */
+#define IGA1_VER_ADDR_REG_NUM           4           /* location: {CR12,0,7},{CR07,1,1},{CR07,6,6},{CR35,2,2} */
+#define IGA1_VER_BLANK_START_REG_NUM    4           /* location: {CR15,0,7},{CR07,3,3},{CR09,5,5},{CR35,3,3} */
+#define IGA1_VER_BLANK_END_REG_NUM      1           /* location: {CR16,0,7} */
+#define IGA1_VER_SYNC_START_REG_NUM     4           /* location: {CR10,0,7},{CR07,2,2},{CR07,7,7},{CR35,1,1} */
+#define IGA1_VER_SYNC_END_REG_NUM       1           /* location: {CR11,0,3} */
+
+/* Define Register Number for IGA2 Shadow CRTC Timing */
+#define IGA2_SHADOW_HOR_TOTAL_REG_NUM       2       /* location: {CR6D,0,7},{CR71,3,3} */
+#define IGA2_SHADOW_HOR_BLANK_END_REG_NUM   1       /* location: {CR6E,0,7} */
+#define IGA2_SHADOW_VER_TOTAL_REG_NUM       2       /* location: {CR6F,0,7},{CR71,0,2} */
+#define IGA2_SHADOW_VER_ADDR_REG_NUM        2       /* location: {CR70,0,7},{CR71,4,6} */
+#define IGA2_SHADOW_VER_BLANK_START_REG_NUM 2       /* location: {CR72,0,7},{CR74,4,6} */
+#define IGA2_SHADOW_VER_BLANK_END_REG_NUM   2       /* location: {CR73,0,7},{CR74,0,2} */
+#define IGA2_SHADOW_VER_SYNC_START_REG_NUM  2       /* location: {CR75,0,7},{CR76,4,6} */
+#define IGA2_SHADOW_VER_SYNC_END_REG_NUM    1       /* location: {CR76,0,3} */
+
+/* Define Register Number for IGA2 CRTC Timing */
+#define IGA2_HOR_TOTAL_REG_NUM          2           /* location: {CR50,0,7},{CR55,0,3} */
+#define IGA2_HOR_ADDR_REG_NUM           2           /* location: {CR51,0,7},{CR55,4,6} */
+#define IGA2_HOR_BLANK_START_REG_NUM    2           /* location: {CR52,0,7},{CR54,0,2} */
+#define IGA2_HOR_BLANK_END_REG_NUM      3           /* location: CLE266: {CR53,0,7},{CR54,3,5} => CLE266's CR5D[6] is reserved, so it may have problem to set 1600x1200 on IGA2. */
+                                                    /*           Others: {CR53,0,7},{CR54,3,5},{CR5D,6,6} */
+#define IGA2_HOR_SYNC_START_REG_NUM     4           /* location: {CR56,0,7},{CR54,6,7},{CR5C,7,7} */
+                                                                                     /* VT3314 and Later: {CR56,0,7},{CR54,6,7},{CR5C,7,7}, {CR5D,7,7} */
+#define IGA2_HOR_SYNC_END_REG_NUM       2           /* location: {CR57,0,7},{CR5C,6,6} */
+#define IGA2_VER_TOTAL_REG_NUM          2           /* location: {CR58,0,7},{CR5D,0,2} */ 
+#define IGA2_VER_ADDR_REG_NUM           2           /* location: {CR59,0,7},{CR5D,3,5} */
+#define IGA2_VER_BLANK_START_REG_NUM    2           /* location: {CR5A,0,7},{CR5C,0,2} */
+#define IGA2_VER_BLANK_END_REG_NUM      2           /* location: {CR5E,0,7},{CR5C,3,5} */
+#define IGA2_VER_SYNC_START_REG_NUM     2           /* location: {CR5E,0,7},{CR5F,5,7} */
+#define IGA2_VER_SYNC_END_REG_NUM       1           /* location: {CR5F,0,4} */
+
+/* Define Offset and Fetch Count Register*/
+#define IGA1_OFFSET_REG_NUM             2                                 /* location: {CR13,0,7},{CR35,5,7} */
+#define IGA1_OFFSER_ALIGN_BYTE          8                                 /* 8 bytes alignment. */
+#define IGA1_OFFSET_FORMULA(x,y)        (x*y)/IGA1_OFFSER_ALIGN_BYTE      /* x: H resolution, y: color depth */
+
+#define IGA1_FETCH_COUNT_REG_NUM        2                                 /* location: {SR1C,0,7},{SR1D,0,1} */
+#define IGA1_FETCH_COUNT_ALIGN_BYTE     16                                /* 16 bytes alignment. */
+#define IGA1_FETCH_COUNT_PATCH_VALUE    4                                 /* x: H resolution, y: color depth */
+#define IGA1_FETCH_COUNT_FORMULA(x,y)   ((x*y)/IGA1_FETCH_COUNT_ALIGN_BYTE)+ IGA1_FETCH_COUNT_PATCH_VALUE
+
+#define IGA2_OFFSET_REG_NUM             2           /* location: {CR66,0,7},{CR67,0,1} */
+#define IGA2_OFFSET_ALIGN_BYTE          8
+#define IGA2_OFFSET_FORMULA(x,y)        (x*y)/IGA2_OFFSET_ALIGN_BYTE     /* x: H resolution, y: color depth */
+
+#define IGA2_FETCH_COUNT_REG_NUM        2           /* location: {CR65,0,7},{CR67,2,3} */
+#define IGA2_FETCH_COUNT_ALIGN_BYTE     16
+#define IGA2_FETCH_COUNT_PATCH_VALUE    0
+#define IGA2_FETCH_COUNT_FORMULA(x,y)   ((x*y)/IGA2_FETCH_COUNT_ALIGN_BYTE)+ IGA2_FETCH_COUNT_PATCH_VALUE
+
+/* Staring Address */
+#define IGA1_STARTING_ADDR_REG_NUM      4           /* location: {CR0C,0,7},{CR0D,0,7},{CR34,0,7},{CR48,0,1} */
+#define IGA2_STARTING_ADDR_REG_NUM      3           /* location: {CR62,1,7},{CR63,0,7},{CR64,0,7} */
+
+/* Define Display OFFSET */
+/* These value are by HW suggested value */
+#define K800_IGA1_FIFO_MAX_DEPTH                384     /* location: {SR17,0,7} */
+#define K800_IGA1_FIFO_THRESHOLD                328     /* location: {SR16,0,5},{SR16,7,7} */
+#define K800_IGA1_FIFO_HIGH_THRESHOLD           296     /* location: {SR18,0,5},{SR18,7,7} */
+#define K800_IGA1_DISPLAY_QUEUE_EXPIRE_NUM      0       /* location: {SR22,0,4}. (128/4) =64, K800 must be set zero, */
+                                                        /* because HW only 5 bits */
+
+#define K800_IGA2_FIFO_MAX_DEPTH                384     /* location: {CR68,4,7},{CR94,7,7},{CR95,7,7} */
+#define K800_IGA2_FIFO_THRESHOLD                328     /* location: {CR68,0,3},{CR95,4,6} */
+#define K800_IGA2_FIFO_HIGH_THRESHOLD           296     /* location: {CR92,0,3},{CR95,0,2} */
+#define K800_IGA2_DISPLAY_QUEUE_EXPIRE_NUM      128     /* location: {CR94,0,6} */
+
+#define P880_IGA1_FIFO_MAX_DEPTH                192     /* location: {SR17,0,7} */
+#define P880_IGA1_FIFO_THRESHOLD                128     /* location: {SR16,0,5},{SR16,7,7} */
+#define P880_IGA1_FIFO_HIGH_THRESHOLD           64      /* location: {SR18,0,5},{SR18,7,7} */
+#define P880_IGA1_DISPLAY_QUEUE_EXPIRE_NUM      0       /* location: {SR22,0,4}. (128/4) =64, K800 must be set zero, */
+                                                        /* because HW only 5 bits */
+
+#define P880_IGA2_FIFO_MAX_DEPTH                96      /* location: {CR68,4,7},{CR94,7,7},{CR95,7,7} */
+#define P880_IGA2_FIFO_THRESHOLD                64      /* location: {CR68,0,3},{CR95,4,6} */
+#define P880_IGA2_FIFO_HIGH_THRESHOLD           32      /* location: {CR92,0,3},{CR95,0,2} */
+#define P880_IGA2_DISPLAY_QUEUE_EXPIRE_NUM      128     /* location: {CR94,0,6} */
+
+/* VT3314 chipset*/
+#define CN900_IGA1_FIFO_MAX_DEPTH               96 /* location: {SR17,0,7}*/
+#define CN900_IGA1_FIFO_THRESHOLD               80 /* location: {SR16,0,5},{SR16,7,7}*/
+#define CN900_IGA1_FIFO_HIGH_THRESHOLD          64  /* location: {SR18,0,5},{SR18,7,7}*/
+#define CN900_IGA1_DISPLAY_QUEUE_EXPIRE_NUM     0   /* location: {SR22,0,4}. (128/4) =64, P800 must be set zero, because HW only 5 bits*/
+
+#define CN900_IGA2_FIFO_MAX_DEPTH               96  /* location: {CR68,4,7},{CR94,7,7},{CR95,7,7}*/
+#define CN900_IGA2_FIFO_THRESHOLD               80  /* location: {CR68,0,3},{CR95,4,6}*/
+#define CN900_IGA2_FIFO_HIGH_THRESHOLD          32  /* location: {CR92,0,3},{CR95,0,2}*/
+#define CN900_IGA2_DISPLAY_QUEUE_EXPIRE_NUM     128 /* location: {CR94,0,6}*/
+
+/* For VT3324, these values are suggested by HW */
+#define CX700_IGA1_FIFO_MAX_DEPTH               192     /* location: {SR17,0,7}*/
+#define CX700_IGA1_FIFO_THRESHOLD               128     /* location: {SR16,0,5},{SR16,7,7}*/
+#define CX700_IGA1_FIFO_HIGH_THRESHOLD          128     /* location: {SR18,0,5},{SR18,7,7} */
+#define CX700_IGA1_DISPLAY_QUEUE_EXPIRE_NUM     124     /* location: {SR22,0,4} */
+
+#define CX700_IGA2_FIFO_MAX_DEPTH               96      /* location: {CR68,4,7},{CR94,7,7},{CR95,7,7}*/
+#define CX700_IGA2_FIFO_THRESHOLD               64      /* location: {CR68,0,3},{CR95,4,6}*/
+#define CX700_IGA2_FIFO_HIGH_THRESHOLD          32      /* location: {CR92,0,3},{CR95,0,2} */
+#define CX700_IGA2_DISPLAY_QUEUE_EXPIRE_NUM     128     /* location: {CR94,0,6}*/
+
+/* VT3336 chipset*/
+#define K8M890_IGA1_FIFO_MAX_DEPTH               360 /* location: {SR17,0,7}*/
+#define K8M890_IGA1_FIFO_THRESHOLD               328 /* location: {SR16,0,5},{SR16,7,7}*/
+#define K8M890_IGA1_FIFO_HIGH_THRESHOLD          296 /* location: {SR18,0,5},{SR18,7,7}*/
+#define K8M890_IGA1_DISPLAY_QUEUE_EXPIRE_NUM     124 /* location: {SR22,0,4}.*/
+
+#define K8M890_IGA2_FIFO_MAX_DEPTH               360 /* location: {CR68,4,7},{CR94,7,7},{CR95,7,7}*/
+#define K8M890_IGA2_FIFO_THRESHOLD               328 /* location: {CR68,0,3},{CR95,4,6}*/
+#define K8M890_IGA2_FIFO_HIGH_THRESHOLD          296 /* location: {CR92,0,3},{CR95,0,2}*/
+#define K8M890_IGA2_DISPLAY_QUEUE_EXPIRE_NUM     124 /* location: {CR94,0,6}*/
+
+/* VT3327 chipset*/
+#define P4M890_IGA1_FIFO_MAX_DEPTH               96  /* location: {SR17,0,7}*/
+#define P4M890_IGA1_FIFO_THRESHOLD               76  /* location: {SR16,0,5},{SR16,7,7}*/
+#define P4M890_IGA1_FIFO_HIGH_THRESHOLD          64  /* location: {SR18,0,5},{SR18,7,7}*/
+#define P4M890_IGA1_DISPLAY_QUEUE_EXPIRE_NUM     32  /* location: {SR22,0,4}. (32/4) =8*/
+
+#define P4M890_IGA2_FIFO_MAX_DEPTH               96  /* location: {CR68,4,7},{CR94,7,7},{CR95,7,7}*/
+#define P4M890_IGA2_FIFO_THRESHOLD               76  /* location: {CR68,0,3},{CR95,4,6}*/
+#define P4M890_IGA2_FIFO_HIGH_THRESHOLD          64  /* location: {CR92,0,3},{CR95,0,2}*/
+#define P4M890_IGA2_DISPLAY_QUEUE_EXPIRE_NUM     32  /* location: {CR94,0,6}*/
+
+/* VT3364 chipset*/
+#define P4M900_IGA1_FIFO_MAX_DEPTH               96     /* location: {SR17,0,7}*/
+#define P4M900_IGA1_FIFO_THRESHOLD               76     /* location: {SR16,0,5},{SR16,7,7}*/
+#define P4M900_IGA1_FIFO_HIGH_THRESHOLD          76     /* location: {SR18,0,5},{SR18,7,7}*/
+#define P4M900_IGA1_DISPLAY_QUEUE_EXPIRE_NUM     32     /* location: {SR22,0,4}.*/
+
+#define P4M900_IGA2_FIFO_MAX_DEPTH               96     /* location: {CR68,4,7},{CR94,7,7},{CR95,7,7}*/
+#define P4M900_IGA2_FIFO_THRESHOLD               76     /* location: {CR68,0,3},{CR95,4,6}*/
+#define P4M900_IGA2_FIFO_HIGH_THRESHOLD          76     /* location: {CR92,0,3},{CR95,0,2}*/
+#define P4M900_IGA2_DISPLAY_QUEUE_EXPIRE_NUM     32     /* location: {CR94,0,6}*/
+
+#define IGA1_FIFO_DEPTH_SELECT_REG_NUM          1
+#define IGA1_FIFO_THRESHOLD_REG_NUM             2
+#define IGA1_FIFO_HIGH_THRESHOLD_REG_NUM        2
+#define IGA1_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM   1
+
+#define IGA2_FIFO_DEPTH_SELECT_REG_NUM          3
+#define IGA2_FIFO_THRESHOLD_REG_NUM             2
+#define IGA2_FIFO_HIGH_THRESHOLD_REG_NUM        2
+#define IGA2_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM   1
+
+
+#define IGA1_FIFO_DEPTH_SELECT_FORMULA(x)                   (x/2)-1
+#define IGA1_FIFO_THRESHOLD_FORMULA(x)                      (x/4)
+#define IGA1_DISPLAY_QUEUE_EXPIRE_NUM_FORMULA(x)            (x/4)
+#define IGA1_FIFO_HIGH_THRESHOLD_FORMULA(x)                 (x/4)
+#define IGA2_FIFO_DEPTH_SELECT_FORMULA(x)                   ((x/2)/4)-1
+#define IGA2_FIFO_THRESHOLD_FORMULA(x)                      (x/4)
+#define IGA2_DISPLAY_QUEUE_EXPIRE_NUM_FORMULA(x)            (x/4)
+#define IGA2_FIFO_HIGH_THRESHOLD_FORMULA(x)                 (x/4)
+
+/************************************************************************/
+/*  LCD Timing                                                          */
+/************************************************************************/
+#define LCD_POWER_SEQ_TD0               500000         /* 500 ms = 500000 us */
+#define LCD_POWER_SEQ_TD1               50000          /* 50 ms = 50000 us */
+#define LCD_POWER_SEQ_TD2               0              /* 0 us */
+#define LCD_POWER_SEQ_TD3               210000         /* 210 ms = 210000 us */
+
+#define CLE266_POWER_SEQ_UNIT           71             /* 2^10 * (1/14.31818M) = 71.475 us (K400.revA) */
+#define K800_POWER_SEQ_UNIT             142            /* 2^11 * (1/14.31818M) = 142.95 us (K400.revB) */
+#define P880_POWER_SEQ_UNIT             572            /* 2^13 * (1/14.31818M) = 572.1 us */
+
+#define CLE266_POWER_SEQ_FORMULA(x)     (x)/CLE266_POWER_SEQ_UNIT
+#define K800_POWER_SEQ_FORMULA(x)       (x)/K800_POWER_SEQ_UNIT
+#define P880_POWER_SEQ_FORMULA(x)       (x)/P880_POWER_SEQ_UNIT
+
+
+#define LCD_POWER_SEQ_TD0_REG_NUM       2   /* location: {CR8B,0,7},{CR8F,0,3} */
+#define LCD_POWER_SEQ_TD1_REG_NUM       2   /* location: {CR8C,0,7},{CR8F,4,7} */
+#define LCD_POWER_SEQ_TD2_REG_NUM       2   /* location: {CR8D,0,7},{CR90,0,3} */
+#define LCD_POWER_SEQ_TD3_REG_NUM       2   /* location: {CR8E,0,7},{CR90,4,7} */
+
+
+/* LCD Scaling factor */
+/* x: indicate setting horizontal size */
+/* y: indicate panel horizontal size */
+
+#define CLE266_LCD_HOR_SCF_FORMULA(x,y)   (((x-1)*1024)/(y-1))    /* Horizontal scaling factor 10 bits (2^10) */
+#define CLE266_LCD_VER_SCF_FORMULA(x,y)   (((x-1)*1024)/(y-1))    /* Vertical scaling factor 10 bits (2^10) */
+#define K800_LCD_HOR_SCF_FORMULA(x,y)     (((x-1)*4096)/(y-1))    /* Horizontal scaling factor 10 bits (2^12) */
+#define K800_LCD_VER_SCF_FORMULA(x,y)     (((x-1)*2048)/(y-1))    /* Vertical scaling factor 10 bits (2^11) */
+
+#define LCD_HOR_SCALING_FACTOR_REG_NUM  3   /* location: {CR9F,0,1},{CR77,0,7},{CR79,4,5} */
+#define LCD_VER_SCALING_FACTOR_REG_NUM  3   /* location: {CR79,3,3},{CR78,0,7},{CR79,6,7} */
+#define LCD_HOR_SCALING_FACTOR_REG_NUM_CLE  2               /* location: {CR77,0,7},{CR79,4,5} */
+#define LCD_VER_SCALING_FACTOR_REG_NUM_CLE  2               /* location: {CR78,0,7},{CR79,6,7} */
+
+
+
+/************************************************/
+/*      Define IGA1 Display Timing              */
+/************************************************/
+struct io_register {
+    u8      io_addr;
+    u8      start_bit;
+    u8      end_bit;
+};
+
+
+/* IGA1 Horizontal Total */
+struct iga1_hor_total
+{
+    int     reg_num;
+    struct  io_register reg[IGA1_HOR_TOTAL_REG_NUM];
+};
+
+/* IGA1 Horizontal Addressable Video */
+struct iga1_hor_addr {
+    int     reg_num;
+    struct  io_register reg[IGA1_HOR_ADDR_REG_NUM];
+};
+
+/* IGA1 Horizontal Blank Start */
+struct iga1_hor_blank_start {
+    int     reg_num;
+    struct  io_register reg[IGA1_HOR_BLANK_START_REG_NUM];
+};
+
+/* IGA1 Horizontal Blank End */
+struct iga1_hor_blank_end {
+    int     reg_num;
+    struct  io_register reg[IGA1_HOR_BLANK_END_REG_NUM];
+};
+
+/* IGA1 Horizontal Sync Start */
+struct iga1_hor_sync_start {
+    int     reg_num;
+    struct  io_register reg[IGA1_HOR_SYNC_START_REG_NUM];
+};
+
+/* IGA1 Horizontal Sync End */
+struct iga1_hor_sync_end {
+    int     reg_num;
+    struct  io_register reg[IGA1_HOR_SYNC_END_REG_NUM];
+};
+
+/* IGA1 Vertical Total */
+struct iga1_ver_total {
+    int     reg_num;
+    struct  io_register reg[IGA1_VER_TOTAL_REG_NUM];
+};
+
+/* IGA1 Vertical Addressable Video */
+struct iga1_ver_addr {
+    int     reg_num;
+    struct  io_register reg[IGA1_VER_ADDR_REG_NUM];
+};
+
+/* IGA1 Vertical Blank Start */
+struct iga1_ver_blank_start {
+    int     reg_num;
+    struct  io_register reg[IGA1_VER_BLANK_START_REG_NUM];
+};
+
+/* IGA1 Vertical Blank End */
+struct iga1_ver_blank_end {
+    int     reg_num;
+    struct  io_register reg[IGA1_VER_BLANK_END_REG_NUM];
+};
+
+/* IGA1 Vertical Sync Start */
+struct iga1_ver_sync_start {
+    int     reg_num;
+    struct  io_register reg[IGA1_VER_SYNC_START_REG_NUM];
+};
+
+/* IGA1 Vertical Sync End */
+struct iga1_ver_sync_end {
+    int     reg_num;
+    struct  io_register reg[IGA1_VER_SYNC_END_REG_NUM];
+};
+
+/************************************************/
+/*      Define IGA2 Shadow Display Timing       */
+/************************************************/
+
+/* IGA2 Shadow Horizontal Total */
+struct iga2_shadow_hor_total
+{
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_HOR_TOTAL_REG_NUM];
+};
+
+/* IGA2 Shadow Horizontal Blank End */
+struct iga2_shadow_hor_blank_end {
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_HOR_BLANK_END_REG_NUM];
+};
+
+
+/* IGA2 Shadow Vertical Total */
+struct iga2_shadow_ver_total {
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_VER_TOTAL_REG_NUM];
+};
+
+/* IGA2 Shadow Vertical Addressable Video */
+struct iga2_shadow_ver_addr {
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_VER_ADDR_REG_NUM];
+};
+
+/* IGA2 Shadow Vertical Blank Start */
+struct iga2_shadow_ver_blank_start {
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_VER_BLANK_START_REG_NUM];
+};
+
+/* IGA2 Shadow Vertical Blank End */
+struct iga2_shadow_ver_blank_end {
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_VER_BLANK_END_REG_NUM];
+};
+
+/* IGA2 Shadow Vertical Sync Start */
+struct iga2_shadow_ver_sync_start {
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_VER_SYNC_START_REG_NUM];
+};
+
+/* IGA2 Shadow Vertical Sync End */
+struct iga2_shadow_ver_sync_end {
+    int     reg_num;
+    struct  io_register reg[IGA2_SHADOW_VER_SYNC_END_REG_NUM];
+};
+
+/************************************************/
+/*      Define IGA2 Display Timing              */
+/************************************************/
+
+/* IGA2 Horizontal Total */
+struct iga2_hor_total {
+    int     reg_num;
+    struct  io_register reg[IGA2_HOR_TOTAL_REG_NUM];
+};
+
+/* IGA2 Horizontal Addressable Video */
+struct iga2_hor_addr {
+    int     reg_num;
+    struct  io_register reg[IGA2_HOR_ADDR_REG_NUM];
+};
+
+/* IGA2 Horizontal Blank Start */
+struct iga2_hor_blank_start {
+    int     reg_num;
+    struct  io_register reg[IGA2_HOR_BLANK_START_REG_NUM];
+};
+
+/* IGA2 Horizontal Blank End */
+struct iga2_hor_blank_end {
+    int     reg_num;
+    struct  io_register reg[IGA2_HOR_BLANK_END_REG_NUM];
+};
+
+/* IGA2 Horizontal Sync Start */
+struct iga2_hor_sync_start {
+    int     reg_num;
+    struct  io_register reg[IGA2_HOR_SYNC_START_REG_NUM];
+};
+
+/* IGA2 Horizontal Sync End */
+struct iga2_hor_sync_end {
+    int     reg_num;
+    struct  io_register reg[IGA2_HOR_SYNC_END_REG_NUM];
+};
+
+/* IGA2 Vertical Total */
+struct iga2_ver_total {
+    int     reg_num;
+    struct  io_register reg[IGA2_VER_TOTAL_REG_NUM];
+};
+
+/* IGA2 Vertical Addressable Video */
+struct iga2_ver_addr {
+    int     reg_num;
+    struct  io_register reg[IGA2_VER_ADDR_REG_NUM];
+};
+
+/* IGA2 Vertical Blank Start */
+struct iga2_ver_blank_start {
+    int     reg_num;
+    struct  io_register reg[IGA2_VER_BLANK_START_REG_NUM];
+};
+
+/* IGA2 Vertical Blank End */
+struct iga2_ver_blank_end {
+    int     reg_num;
+    struct  io_register reg[IGA2_VER_BLANK_END_REG_NUM];
+};
+
+/* IGA2 Vertical Sync Start */
+struct iga2_ver_sync_start {
+    int     reg_num;
+    struct  io_register reg[IGA2_VER_SYNC_START_REG_NUM];
+};
+
+/* IGA2 Vertical Sync End */
+struct iga2_ver_sync_end {
+    int     reg_num;
+    struct  io_register reg[IGA2_VER_SYNC_END_REG_NUM];
+};
+
+/* IGA1 Offset Register */
+struct iga1_offset {
+    int     reg_num;
+    struct  io_register reg[IGA1_OFFSET_REG_NUM];
+};
+
+/* IGA2 Offset Register */
+struct iga2_offset {
+    int     reg_num;
+    struct  io_register reg[IGA2_OFFSET_REG_NUM];
+};
+
+struct offset{
+    struct iga1_offset            iga1_offset_reg;
+    struct iga2_offset            iga2_offset_reg;
+};
+
+/* IGA1 Fetch Count Register */
+struct iga1_fetch_count {
+    int     reg_num;
+    struct  io_register reg[IGA1_FETCH_COUNT_REG_NUM];
+};
+
+/* IGA2 Fetch Count Register */
+struct iga2_fetch_count {
+    int     reg_num;
+    struct  io_register reg[IGA2_FETCH_COUNT_REG_NUM];
+};
+
+struct fetch_count{
+    struct iga1_fetch_count       iga1_fetch_count_reg;
+    struct iga2_fetch_count       iga2_fetch_count_reg;
+};
+
+/* Starting Address Register */
+struct iga1_starting_addr {
+    int     reg_num;
+    struct  io_register reg[IGA1_STARTING_ADDR_REG_NUM];
+};
+
+struct iga2_starting_addr {
+    int     reg_num;
+    struct  io_register reg[IGA2_STARTING_ADDR_REG_NUM];
+};
+
+struct starting_addr {
+    struct iga1_starting_addr       iga1_starting_addr_reg;
+    struct iga2_starting_addr       iga2_starting_addr_reg;
+};
+
+/* LCD Power Sequence Timer */
+struct lcd_pwd_seq_td0{
+    int     reg_num;
+    struct  io_register reg[LCD_POWER_SEQ_TD0_REG_NUM];
+};
+
+struct lcd_pwd_seq_td1{
+    int     reg_num;
+    struct  io_register reg[LCD_POWER_SEQ_TD1_REG_NUM];
+};
+
+struct lcd_pwd_seq_td2{
+    int     reg_num;
+    struct  io_register reg[LCD_POWER_SEQ_TD2_REG_NUM];
+};
+
+struct lcd_pwd_seq_td3{
+    int     reg_num;
+    struct  io_register reg[LCD_POWER_SEQ_TD3_REG_NUM];
+};
+
+struct _lcd_pwd_seq_timer{
+    struct lcd_pwd_seq_td0       td0;
+    struct lcd_pwd_seq_td1       td1;
+    struct lcd_pwd_seq_td2       td2;
+    struct lcd_pwd_seq_td3       td3;
+};
+
+/* LCD Scaling Factor */
+struct _lcd_hor_scaling_factor{
+    int     reg_num;
+    struct  io_register reg[LCD_HOR_SCALING_FACTOR_REG_NUM];
+};
+
+struct _lcd_ver_scaling_factor{
+    int     reg_num;
+    struct  io_register reg[LCD_VER_SCALING_FACTOR_REG_NUM];
+};
+
+
+struct _lcd_scaling_factor{
+    struct _lcd_hor_scaling_factor  lcd_hor_scaling_factor;
+    struct _lcd_ver_scaling_factor  lcd_ver_scaling_factor;
+};
+
+struct pll_map {
+    u32     clk;
+    u32     cle266_pll;
+    u32     k800_pll;
+    u32     cx700_pll;
+};
+
+struct rgbLUT {
+    u8     red;
+    u8     green;
+    u8     blue;
+};
+
+struct lcd_pwd_seq_timer {
+    u16     td0;
+    u16     td1;
+    u16     td2;
+    u16     td3;
+};
+
+
+/* Display FIFO Relation Registers */
+struct iga1_fifo_depth_select {
+    int     reg_num;
+    struct  io_register reg[IGA1_FIFO_DEPTH_SELECT_REG_NUM];
+};
+
+struct iga1_fifo_threshold_select {
+    int     reg_num;
+    struct  io_register reg[IGA1_FIFO_THRESHOLD_REG_NUM];
+};
+
+struct iga1_fifo_high_threshold_select {
+    int     reg_num;
+    struct  io_register reg[IGA1_FIFO_HIGH_THRESHOLD_REG_NUM];
+};
+
+struct iga1_display_queue_expire_num {
+    int     reg_num;
+    struct  io_register reg[IGA1_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM];
+};
+
+struct iga2_fifo_depth_select {
+    int     reg_num;
+    struct  io_register reg[IGA2_FIFO_DEPTH_SELECT_REG_NUM];
+};
+
+struct iga2_fifo_threshold_select {
+    int     reg_num;
+    struct  io_register reg[IGA2_FIFO_THRESHOLD_REG_NUM];
+};
+
+struct iga2_fifo_high_threshold_select {
+    int     reg_num;
+    struct  io_register reg[IGA2_FIFO_HIGH_THRESHOLD_REG_NUM];
+};
+
+struct iga2_display_queue_expire_num {
+    int     reg_num;
+    struct  io_register reg[IGA2_DISPLAY_QUEUE_EXPIRE_NUM_REG_NUM];
+};
+
+struct fifo_depth_select {
+    struct  iga1_fifo_depth_select iga1_fifo_depth_select_reg;
+    struct  iga2_fifo_depth_select iga2_fifo_depth_select_reg;
+};
+
+struct fifo_threshold_select {
+    struct  iga1_fifo_threshold_select iga1_fifo_threshold_select_reg;
+    struct  iga2_fifo_threshold_select iga2_fifo_threshold_select_reg;
+};
+
+struct fifo_high_threshold_select {
+    struct  iga1_fifo_high_threshold_select iga1_fifo_high_threshold_select_reg;
+    struct  iga2_fifo_high_threshold_select iga2_fifo_high_threshold_select_reg;
+};
+
+struct display_queue_expire_num {
+    struct  iga1_display_queue_expire_num iga1_display_queue_expire_num_reg;
+    struct  iga2_display_queue_expire_num iga2_display_queue_expire_num_reg;
+};
+
+
+
+struct iga1_crtc_timing {
+    struct iga1_hor_total         hor_total;
+    struct iga1_hor_addr          hor_addr;
+    struct iga1_hor_blank_start   hor_blank_start;
+    struct iga1_hor_blank_end     hor_blank_end;
+    struct iga1_hor_sync_start    hor_sync_start;
+    struct iga1_hor_sync_end      hor_sync_end;
+    struct iga1_ver_total         ver_total;
+    struct iga1_ver_addr          ver_addr;
+    struct iga1_ver_blank_start   ver_blank_start;
+    struct iga1_ver_blank_end     ver_blank_end;
+    struct iga1_ver_sync_start    ver_sync_start;
+    struct iga1_ver_sync_end      ver_sync_end;
+};
+
+struct iga2_shadow_crtc_timing {
+    struct iga2_shadow_hor_total        hor_total_shadow;
+    struct iga2_shadow_hor_blank_end    hor_blank_end_shadow;
+    struct iga2_shadow_ver_total        ver_total_shadow;
+    struct iga2_shadow_ver_addr         ver_addr_shadow;
+    struct iga2_shadow_ver_blank_start  ver_blank_start_shadow;
+    struct iga2_shadow_ver_blank_end    ver_blank_end_shadow;
+    struct iga2_shadow_ver_sync_start   ver_sync_start_shadow;
+    struct iga2_shadow_ver_sync_end     ver_sync_end_shadow;
+};
+
+struct iga2_crtc_timing {
+    struct iga2_hor_total         hor_total;
+    struct iga2_hor_addr          hor_addr;
+    struct iga2_hor_blank_start   hor_blank_start;
+    struct iga2_hor_blank_end     hor_blank_end;
+    struct iga2_hor_sync_start    hor_sync_start;
+    struct iga2_hor_sync_end      hor_sync_end;
+    struct iga2_ver_total         ver_total;
+    struct iga2_ver_addr          ver_addr;
+    struct iga2_ver_blank_start   ver_blank_start;
+    struct iga2_ver_blank_end     ver_blank_end;
+    struct iga2_ver_sync_start    ver_sync_start;
+    struct iga2_ver_sync_end      ver_sync_end;
+};
+
+/* Copied from X driver code */
+/* used by get video memory size */
+/* device ID */
+#define CLE266              0x3123
+#define KM400               0x3205
+#define CN400_FUNCTION2     0x2259
+#define CN400_FUNCTION3     0x3259
+/* support VT3314 chipset */
+#define CN900_FUNCTION2     0x2314
+#define CN900_FUNCTION3     0x3208
+/* VT3324 chipset */
+#define CX700_FUNCTION2     0x2324
+#define CX700_FUNCTION3     0x3324
+/* VT3204 chipset*/
+#define KM800_FUNCTION3      0x3204
+/* VT3336 chipset*/
+#define KM890_FUNCTION3      0x3336
+/* VT3327 chipset*/
+#define P4M890_FUNCTION3     0x3327
+/* VT3293 chipset*/
+#define CN750_FUNCTION3     0x3208
+/* VT3364 chipset*/
+#define P4M900_FUNCTION3    0x3364
+
+typedef struct IODATA {
+    u8   Index;
+    u8   Mask;
+    u8   Data;
+}IODATA, *IODATAPTR;
+
+#endif /* __HW_H__ */
+
+
+
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/iface.c linux-2.6.21-rc7.viafb/drivers/video/via/iface.c
--- linux-2.6.21-rc7/drivers/video/via/iface.c 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/iface.c 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,90 @@
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
+#include <linux/pci.h>
+#include <asm/io.h>
+
+#include "iface.h"
+#include "debug.h"
+#include "share.h"
+
+/* Get frame buffer size from VGA BIOS */
+extern inline u8 read_reg(int io_port, u8 index);
+extern  int memsize;
+
+unsigned int get_memsize(void)
+{
+    unsigned int m;
+
+        /* If memory size provided by user */
+    if (memsize)
+        m = memsize * Mb;
+    else
+    {
+        m = (unsigned int) read_reg(VIASR, SR39); 
+        m = m*(4*Mb);
+        
+        if((m < (16*Mb)) || (m > (64*Mb)))
+            m = 16*Mb;
+    }
+    DEBUG_MSG(KERN_INFO "framebuffer size = %d Mb\n", m/Mb);
+    return m;
+}
+
+/* Get Video Buffer Starting Physical Address(back door) */
+
+unsigned long get_videobuf_addr(void)
+{
+    struct pci_dev *pdev=NULL;
+    unsigned char  sys_mem;
+    unsigned char  video_mem;
+    unsigned long  sys_mem_size;
+    unsigned long  video_mem_size;
+    unsigned long  vmem_starting_adr = 0x0C000000; /* system memory = 256 MB, video memory 64 MB */
+
+    pdev = (struct pci_dev *)pci_find_device(VIA_K800_BRIDGE_VID, VIA_K800_BRIDGE_DID, NULL);
+    if (pdev != NULL)
+    {
+        pci_read_config_byte(pdev, VIA_K800_SYSTEM_MEMORY_REG, &sys_mem);
+        pci_read_config_byte(pdev, VIA_K800_VIDEO_MEMORY_REG, &video_mem);
+        video_mem = (video_mem & 0x70) >> 4;
+        sys_mem_size = ((unsigned long)sys_mem) << 24;
+        if (video_mem != 0)
+            video_mem_size = (1 << (video_mem)) *1024*1024;
+        else
+            video_mem_size = 0;
+
+        vmem_starting_adr = sys_mem_size - video_mem_size;
+
+    }
+
+    DEBUG_MSG(KERN_INFO "Video Memory Starting Address = %lx \n", vmem_starting_adr);
+    return vmem_starting_adr;
+}
+
+
+
+
diff -Nur linux-2.6.21-rc7/drivers/video/via/iface.h linux-2.6.21-rc7.viafb/drivers/video/via/iface.h
--- linux-2.6.21-rc7/drivers/video/via/iface.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/iface.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,15 @@
+#ifndef __IFACE_H__
+#define __IFACE_H__
+
+#define Kb  (1024)
+#define Mb  (Kb*Kb)
+
+#define VIA_K800_BRIDGE_VID         0x1106
+#define VIA_K800_BRIDGE_DID         0x3204
+
+#define VIA_K800_SYSTEM_MEMORY_REG  0x47
+#define VIA_K800_VIDEO_MEMORY_REG   0xA1
+
+#endif /* __IFACE_H__ */
diff -Nur linux-2.6.21-rc7/drivers/video/via/ioctl.c linux-2.6.21-rc7.viafb/drivers/video/via/ioctl.c
--- linux-2.6.21-rc7/drivers/video/via/ioctl.c 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/ioctl.c 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,213 @@
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
+#include <linux/fb.h>
+#include <asm/uaccess.h>
+
+#include "viafbdev.h"
+#include "chip.h"
+#include "debug.h"
+#include "ioctl.h"
+#include "share.h"
+
+extern int dvi_sense(void);
+extern int tv_sense(void);
+extern int tv_auto_sense(void);
+extern inline u8 read_reg(int io_port, u8 index);
+
+extern struct chip_information          chip_info;
+extern struct tv_setting_information    tv_setting_info;
+extern struct viafb_info                viafbinfo;
+extern int CRT_ON, TV_ON, DVI_ON, LCD_ON;
+extern int DeviceStatus;
+extern int HotPlug_TV;
+extern int refresh;
+
+int HotPlug_Xres = 640, HotPlug_Yres = 480, HotPlug_bpp = 32, HotPlug_refresh = 60, HotPlug_TVType = TVTYPE_NTSC;
+
+int ioctl_get_viafb_info(u_long arg)
+{
+    struct viafb_ioctl_info viainfo;
+
+    viainfo.viafb_id    = VIAID;
+    viainfo.vendor_id   = PCI_VIA_VENDOR_ID;
+
+    switch(chip_info.gfx_chip_name) {
+        case UNICHROME_CLE266:
+            viainfo.device_id = UNICHROME_CLE266_DID;
+            break;
+
+        case UNICHROME_K400:
+            viainfo.device_id = UNICHROME_K400_DID;
+            break;
+
+        case UNICHROME_K800:
+            viainfo.device_id = UNICHROME_K800_DID;
+            break;
+
+        case UNICHROME_P880:
+            viainfo.device_id = UNICHROME_P880_DID;
+            break;
+
+        case UNICHROME_CN900:
+            viainfo.device_id = UNICHROME_CN900_DID;
+            break;
+            
+        /* Add for VT3324. */
+        case UNICHROME_CX700:
+            viainfo.device_id = UNICHROME_CX700_DID;
+            break;
+
+        /* Add for VT3327 VT3336 VT3364 */
+        case UNICHROME_K8M890:
+            viainfo.device_id = UNICHROME_K8M890_DID;
+            break;
+
+        case UNICHROME_P4M890:
+            viainfo.device_id = UNICHROME_P4M890_DID;
+            break;
+
+        case UNICHROME_P4M900:
+            viainfo.device_id = UNICHROME_P4M900_DID;
+            break;
+    }
+    
+    viainfo.version = VERSION_MAJOR;
+    viainfo.revision = VERSION_MINOR;
+
+    if(copy_to_user((void __user *)arg, &viainfo, sizeof(viainfo))) {
+        return -EFAULT;
+    }
+
+    return 0;
+}
+
+/* Hot-Plug Priority: DVI > TV > CRT */
+int ioctl_hotplug(int hres, int vres, int bpp)
+{
+    int TVsense, DVIsense, status = 0;
+    u8  TVType = 0;
+
+    DEBUG_MSG(KERN_INFO "ioctl_hotplug!!\n");
+
+    if(chip_info.tmds_chip_info.tmds_chip_name != NON_TMDS_TRANSMITTER) {
+        DVIsense = dvi_sense();
+
+        if(DVIsense) {
+            DEBUG_MSG(KERN_INFO "DVI Attached...\n");
+            if(DeviceStatus != DVI_Device) {
+                DVI_ON = 1;
+                CRT_ON = TV_ON = LCD_ON = 0;
+
+                if(DeviceStatus == TV_Device) {
+                    tv_setting_info.system = HotPlug_TVType;
+                }
+
+                DeviceStatus = DVI_Device;
+                return DeviceStatus;
+            }
+            status = 1;
+        }
+        else
+            DEBUG_MSG(KERN_INFO "DVI De-attached...\n");
+    }
+    
+    if((chip_info.tv_chip_info.tv_chip_name != NON_TV_ENCODER)&&(status == 0)) {
+        /* If TV not ON, using TV manual sense function.  
+           If TV ON, using TV auto sense function. 
+           This is avoid the display flick to use TV manual sense function when TV ON. */
+        if(DeviceStatus != TV_Device) {
+            TVsense = tv_sense();
+        }
+        else {
+            TVsense = tv_auto_sense();
+        }
+
+        if(TVsense != TV_OUTPUT_NONE) {
+            DEBUG_MSG(KERN_INFO "TV Attached: TVsense = %d\n", TVsense);
+    
+            if(DeviceStatus != TV_Device) {
+                TV_ON = 1;
+                CRT_ON = DVI_ON = LCD_ON = 0;
+
+                HotPlug_TVType = tv_setting_info.system;
+
+                if((chip_info.gfx_chip_name == UNICHROME_CLE266) && (chip_info.gfx_chip_revision == CLE266_REVISION_AX)) {
+                    TVType = read_reg(VIACR, 0x3C) & 0x0F;
+                }
+                else {
+                    TVType = read_reg(VIACR, 0x4E) & 0x0F;
+                }
+
+                if(!TVType) {
+                    tv_setting_info.system = TVTYPE_NTSC;
+                }
+                else {
+                    tv_setting_info.system = TVTYPE_PAL;
+                }
+
+                tv_setting_info.out_signal = TVsense;
+
+                HotPlug_TV = 1;
+                DeviceStatus = TV_Device;
+                return DeviceStatus;
+            }
+            status = 1;
+        }
+        else {
+            DEBUG_MSG(KERN_INFO "TV De-attached...\n");
+            HotPlug_TV = 0;
+        }
+    }
+    
+    if((DeviceStatus != CRT_Device)&&(status == 0)) {
+        CRT_ON = 1;
+        TV_ON = DVI_ON = LCD_ON = 0;
+
+        if(DeviceStatus == TV_Device) {
+            tv_setting_info.system = HotPlug_TVType;
+        }
+
+        DeviceStatus = CRT_Device;
+        return DeviceStatus;
+    }
+
+    return 0;
+}
+
+int ioctl_get_tv_type(u_long arg)
+{
+    u8          TVType = 0;
+    u32 __user  *argp = (u32 __user *)arg;
+
+    if((chip_info.gfx_chip_name == UNICHROME_CLE266) && (chip_info.gfx_chip_revision == CLE266_REVISION_AX)) {
+        TVType = read_reg(VIACR, 0x3C) & 0x0F;
+    }
+    else {
+        TVType = read_reg(VIACR, 0x4E) & 0x0F;
+    }
+
+    return put_user((u32)TVType, argp);
+}
diff -Nur linux-2.6.21-rc7/drivers/video/via/ioctl.h linux-2.6.21-rc7.viafb/drivers/video/via/ioctl.h
--- linux-2.6.21-rc7/drivers/video/via/ioctl.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/ioctl.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,264 @@
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
+#ifndef __IOCTL_H__
+#define __IOCTL_H__
+
+#ifndef __user
+#define __user
+#endif 
+
+/* VIAFB IOCTL definition */
+#define VIAFB_GET_INFO_SIZE     0x56494101 /* 'VIA\01' */
+#define VIAFB_GET_INFO          0x56494102 /* 'VIA\02' */
+#define VIAFB_HOTPLUG           0x56494103 /* 'VIA\03' */
+#define VIAFB_SET_HOTPLUG_FLAG  0x56494104 /* 'VIA\04' */
+#define VIAFB_GET_RESOLUTION    0x56494105 /* 'VIA\05' */
+#define VIAFB_GET_TV_TYPE       0x56494106 /* 'VIA\06' */
+#define VIAFB_GET_SAMM_INFO       0x56494107 /* 'VIA\07' */
+#define VIAFB_TURN_ON_OUTPUT_DEVICE       0x56494108 /* 'VIA\08' */
+#define VIAFB_TURN_OFF_OUTPUT_DEVICE       0x56494109 /* 'VIA\09' */
+#define VIAFB_SET_DEVICE        0x5649410A 
+#define VIAFB_GET_DEVICE        0x5649410B 
+#define VIAFB_SET_TV_COLOR_DEFAULT  0x5649410C /* 'VIA\0C' */
+#define VIAFB_SET_TV_BRIGHTNESS     0x5649410D /* 'VIA\0D' */
+#define VIAFB_SET_TV_CONTRAST       0x5649410E /* 'VIA\0E' */
+#define VIAFB_SET_TV_SATURATION     0x5649410F /* 'VIA\0F' */
+#define VIAFB_SET_TV_TINT           0x56494110 /* 'VIA\10' */
+#define VIAFB_SET_TV_FFILTER        0x56494111 /* 'VIA\11' */
+#define VIAFB_GET_DRIVER_VERSION    0x56494112 /* 'VIA\12' */
+#define VIAFB_GET_CHIP_INFO   0x56494113 /* 'VIA\13' */
+#define VIAFB_SET_DEVICE_INFO               0x56494114 /* 'VIA\14' */
+#define VIAFB_GET_DEVICE_INFO               0x56494115 /* 'VIA\15' */
+#define VIAFB_SET_TV_POSITION               0x56494116 
+#define VIAFB_SET_TV_SIZE                   0x56494117 
+#define VIAFB_GET_DEVICE_SUPPORT            0x56494118 
+#define VIAFB_GET_DEVICE_CONNECT            0x56494119 
+#define VIAFB_GET_PANEL_SUPPORT_EXPAND      0x5649411A 
+#define VIAFB_GET_TV_SUPPORT_SIGNAL         0x5649411B 
+#define VIAFB_GET_TV_SUPPORT_STANDARD       0x5649411C 
+#define VIAFB_GET_TV_MAX_SIZE               0x5649411D 
+#define VIAFB_GET_TV_MAX_POSITION           0x5649411E 
+#define VIAFB_GET_TV_SUPPORT_TUNING_ITEM    0x5649411F 
+#define VIAFB_GET_TV_MAX_TUNING_VALUE       0x56494120 
+#define VIAFB_GET_TV_SUPPORT_SETTING_ITEM   0x56494121 
+#define VIAFB_GET_DRIVER_NAME               0x56494122 
+#define VIAFB_GET_DEVICE_SUPPORT_STATE      0x56494123 
+#define VIAFB_GET_GAMMA_LUT                 0x56494124 
+#define VIAFB_SET_GAMMA_LUT                 0x56494125 
+#define VIAFB_GET_GAMMA_SUPPORT_STATE       0x56494126 
+#define VIAFB_SET_VIDEO_DEVICE              0x56494127 
+#define VIAFB_GET_VIDEO_DEVICE              0x56494128 
+#define VIAFB_SET_SECOND_MODE               0x56494129 
+
+/* Re-define value to sync with xserver driver. (Bitwise) */
+#define None_Device 0x00
+#define CRT_Device  0x01
+#define LCD_Device  0x02
+#define TV_Device   0x04
+#define DVI_Device  0x08
+#define CRT2_Device 0x10
+#define HDTV_Device 0x20
+#define LCD2_Device 0x40
+
+/* Flags which are used to control operations of TV. (Bitwise) */
+#define OP_TV_SYSTEM                     0x0001
+#define OP_TV_LEVEL                      0x0002
+#define OP_TV_OUT_SIGNAL                 0x0004
+#define OP_TV_DEDOTCRAWL                 0x0008
+#define OP_TV_BRIGHTNESS                 0x0010   
+#define OP_TV_CONTRAST                   0x0020   
+#define OP_TV_SATURATION                 0x0040  
+#define OP_TV_TINT                       0x0080  
+#define OP_TV_POSITION                   0x0100
+#define OP_TV_SETTING_FFILTER            0x0200   
+#define OP_TV_TUNING_FFILTER             0x0400   
+#define OP_TV_SETTING_ADAPTIVE_FFILTER   0x0800
+#define OP_TV_TUNING_ADAPTIVE_FFILTER    0x1000
+
+
+
+/* Flags which are used to control operations of LCD. (Bitwise) */
+#define OP_LCD_CENTERING   0x01
+#define OP_LCD_PANEL_ID    0x02
+#define OP_LCD_MODE        0x03
+
+/* SAMM operation flag */
+#define OP_SAMM            0x80
+ 
+/* Define maximum value of tv/lcd items. */
+/* The setting value of tv/lcd must be smaller than corresponding maximum value */
+#define TV_STANDARD_MAXIMUM           0x20    
+#define TV_SIZE_LEVEL_MAXIMUM         0x02          
+#define TV_OUT_SIGNAL_MAXIMUM         0x100
+#define TV_FFILTER_MAXIMUM            3
+#define TV_BRIGHTNESS_MAXIMUM         255
+#define TV_CONTRAST_MAXIMUM           255
+#define TV_ADAPTIVE_FFILTER_MAXIMUM   255
+#define TV_SATURATION_MAXIMUM         65535
+#define TV_TINT_MAXIMUM               2047
+#define TV_HOR_POSITION_MAXIMUM       15
+#define TV_VER_POSITION_MAXIMUM       15
+#define LCD_PANEL_ID_MAXIMUM          19
+
+ 
+#define STATE_ON            0x1
+#define STATE_OFF           0x0
+#define STATE_DEFAULT       0xFFFF
+
+#define MAX_ACTIVE_DEV_NUM  2
+
+
+typedef struct{
+  unsigned short crt:1;
+  unsigned short dvi:1;
+  unsigned short tv:1;
+  unsigned short lcd:1;
+  unsigned short samm:1;
+  unsigned short primary_dev;
+
+  unsigned short lcd_dsp_cent:1;
+  unsigned char lcd_panel_id;
+  unsigned char lcd_mode:1;
+
+  unsigned char tv_out_sig;
+  unsigned short tv_level:2;
+  unsigned short tv_system;
+  unsigned short tv_dedotcrawl:1;
+  unsigned short xres,yres;
+  unsigned short xres1,yres1;
+  unsigned short refresh;
+  unsigned short bpp;
+  unsigned short refresh1;
+  unsigned short bpp1;
+  unsigned short sequence;
+  
+  unsigned short epia_dvi:1;
+  unsigned short lcd_dual_edge:1;
+  unsigned short bus_width;
+  unsigned short lcd2:1;
+} device_t;
+
+
+struct viafb_ioctl_info {
+    u32     viafb_id;               /* for identifying viafb */
+#define VIAID       0x56494146      /* Identify myself with 'VIAF' */
+    u16     vendor_id;
+    u16     device_id;
+    u8      version;
+    u8      revision;
+    u8      reserved[246];          /* for future use */
+};
+
+struct viafb_ioctl_mode {
+    u32     xres;
+    u32     yres;
+    u32     refresh;
+    u32     bpp;
+    u32     xres_sec;
+    u32     yres_sec;
+    u32     virtual_xres_sec;
+    u32     virtual_yres_sec;
+    u32     refresh_sec;
+    u32     bpp_sec;
+};
+struct viafb_ioctl_samm {
+    u32     samm_status;
+    u32     size_prim; 
+    u32     size_sec;
+    u32     mem_base;
+    u32     offset_sec; 
+};
+
+struct viafb_driver_version {
+    int     iMajorNum;
+    int     iKernelNum;
+    int     iOSNum;
+    int     iMinorNum;
+};
+
+/* This structure contains variable attributes of TV. */
+struct viafb_ioctl_tv_attribute {
+    unsigned int system;
+    unsigned int level;
+    unsigned int out_signal;
+    unsigned int dedotcrawl; 
+    unsigned int ffilter;
+    unsigned int adaptive_ffilter;
+    unsigned int brightness;
+    unsigned int contrast;
+    unsigned int saturation;
+    unsigned int tint;
+    unsigned int horizontal_pos;
+    unsigned int vertical_pos;
+    unsigned int CurrentScalH;
+    unsigned int CurrentScalV;
+    unsigned int ScalHLevel;
+    unsigned int ScalVLevel;
+    unsigned int DefaultScalH;
+    unsigned int DefaultScalV;
+    unsigned int PositionHLevel;
+    unsigned int PositionVLevel;
+    unsigned int DefaultPositionH;
+    unsigned int DefaultPositionV;
+    unsigned int ffilter_state;     
+    unsigned int adaptive_ffilter_state; 
+};
+
+/* This structure contains variable attributes of LCD. */
+struct viafb_ioctl_lcd_attribute {
+    unsigned int panel_id;
+    unsigned int display_center;
+    unsigned int lcd_mode;
+};
+
+/* This structure contains all setting information of devices. */
+struct viafb_ioctl_setting {
+    unsigned short device_flag;           /* Enable or disable active devices */
+    unsigned short device_status;         /* Indicate which device should be turn on or turn off. */
+    unsigned int   tv_operation_flag;     /* Indicate which TV's attribute can be changed. */
+    unsigned short lcd_operation_flag;    /* Indicate which LCD's attribute can be changed. */
+    unsigned short samm_status;           /* 1: SAMM ON  0: SAMM OFF */
+
+    unsigned short first_dev_hor_res;     /* horizontal resolution of first device */
+    unsigned short first_dev_ver_res;     /* vertical resolution of first device */
+    unsigned short second_dev_hor_res;    /* horizontal resolution of second device */
+    unsigned short second_dev_ver_res;    /* vertical resolution of second device */
+    unsigned short first_dev_refresh;     /* refresh rate of first device */
+    unsigned short first_dev_bpp;         /* bpp of first device */
+    unsigned short second_dev_refresh;    /* refresh rate of second device */
+    unsigned short second_dev_bpp;        /* bpp of second device */
+
+    unsigned int primary_device;          /* Indicate which device are primary display device. */
+    unsigned int video_device_status;     /* Indicate which device will show video. only valid in duoview mode */
+    struct viafb_ioctl_tv_attribute tv_attributes;
+    struct viafb_ioctl_lcd_attribute lcd_attributes;
+};
+
+typedef struct _POSITIONVALUE
+{
+    unsigned int dwX;
+    unsigned int dwY;
+}POSITIONVALUE;
+#endif /* __IOCTL_H__ */

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
