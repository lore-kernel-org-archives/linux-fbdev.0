From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/12] viafb: Framebuffer driver for VIA
 UniChrome/Chrome9 HC (fwd)
Date: Mon, 30 Apr 2007 10:36:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704301036130.27246@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiRN3-0006Qf-7c for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:36:33 -0700
Received: from astra.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiRN1-0001Na-MC
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:36:33 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by astra.telenet-ops.be (Postfix) with SMTP id BF4A238114
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:36:27 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by astra.telenet-ops.be (Postfix) with ESMTP id B61163811A
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:36:22 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l3U8aM28020334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:36:22 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l3U8aMwr020330
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:36:22 +0200
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
Date: Mon, 30 Apr 2007 13:20:06 +0800
From: EddyFu@via.com.tw
To: linux-fbdev-devel-bounces@lists.sourceforge.net
Subject: [Linux-fbdev-devel] [PATCH 2/12] viafb: Framebuffer driver for VIA
    UniChrome/Chrome9 HC

Dear All, 
 
Here is the part 2/12 of viafb.
 
Best Regards,
Eddy Fu 
 
diff -Nur linux-2.6.21-rc7/drivers/video/via/hw.c linux-2.6.21-rc7.viafb/drivers/video/via/hw.c
--- linux-2.6.21-rc7/drivers/video/via/hw.c 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/hw.c 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,3098 @@
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
+#include <linux/version.h>
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
+#include <linux/config.h>
+#endif
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <linux/fb.h>
+
+
+#include "viafbdev.h"
+#include "hw.h"
+#include "hwcfig.h"
+#include "share.h"
+#include "debug.h"
+#include "chip.h"
+#include "viamode.h"
+#include "lcd.h"
+#include "ioctl.h"
+#include "accel.h"
+
+/* External Function */
+extern int tmds_trasmitter_identify(void);
+extern void init_dvi_size(void);
+extern int lvds_trasmitter_identify(void);
+extern void init_lcd_size(void);
+extern void tv_set_mode(int video_index);
+extern void lcd_set_mode(struct crt_mode_table *mode_crt_table, struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+extern void dvi_set_mode(struct crt_mode_table *dvi_crt_timing, int video_index, int mode_bpp, int set_iga);
+extern void dvi_disable(void);
+extern void dvi_enable(void);
+extern void lcd_disable(void);
+extern void lcd_enable(void);
+extern void init_lvds_output_interface(struct lvds_chip_information *plvds_chip_info, struct lvds_setting_information* plvds_setting_info);
+extern unsigned int get_memsize(void);
+extern bool lcd_get_mobile_state(bool* mobile);
+
+/* External struct */
+
+extern struct chip_information      chip_info;
+extern struct crt_setting_information   crt_setting_info;
+extern struct tv_setting_information    tv_setting_info;
+extern struct tmds_setting_information  tmds_setting_info;
+extern struct lvds_setting_information  lvds_setting_info;
+extern struct lvds_setting_information  lvds_setting_info2;
+
+static struct VPITTable VPIT = {
+    /* Msic */
+    0xC7,
+    /* Sequencer */
+    {0x01,0x0F,0x00,0x0E },
+    /* Graphic Controller */
+    {0x00,0x00,0x00,0x00,0x00,0x00,0x05,0x0F,0xFF},
+    /* Attribute Controller */
+    {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,
+     0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,
+     0x01,0x00,0x0F,0x00}
+};
+
+/* Mode:1024X768 */
+static struct io_reg PM1024x768[] = {
+  {VIASR,0x16,0xBF,0x0C},
+  {VIASR,0x18,0xFF,0x4C}
+};
+
+static struct patch_table res_patch_table[]= {
+  {VIA_RES_1024X768, ARRAY_SIZE(PM1024x768), PM1024x768}
+};
+#define NUM_TOTAL_PATCH_MODE ARRAY_SIZE(res_patch_table)
+
+static struct res_map_refresh res_map_refresh_tbl[] = {
+/*hres, vres, vclock, vmode_refresh */
+  {640, 480, RES_640X480_60HZ_PIXCLOCK,   60},
+  {640, 480, RES_640X480_75HZ_PIXCLOCK,   75},
+  {640, 480, RES_640X480_85HZ_PIXCLOCK,   85},
+  {640, 480, RES_640X480_100HZ_PIXCLOCK,  100},
+  {640, 480, RES_640X480_120HZ_PIXCLOCK,  120},
+  {720, 480, RES_720X480_60HZ_PIXCLOCK,   60},
+  {720, 576, RES_720X576_60HZ_PIXCLOCK,   60},
+  {800, 480, RES_800X480_60HZ_PIXCLOCK,   60},
+  {800, 600, RES_800X600_60HZ_PIXCLOCK,   60},
+  {800, 600, RES_800X600_75HZ_PIXCLOCK,   75},
+  {800, 600, RES_800X600_85HZ_PIXCLOCK,   85},
+  {800, 600, RES_800X600_100HZ_PIXCLOCK,  100},
+  {800, 600, RES_800X600_120HZ_PIXCLOCK,  120},
+  {848, 480, RES_848X480_60HZ_PIXCLOCK,   60},
+  {856, 480, RES_856X480_60HZ_PIXCLOCK,   60},
+  {1024,512, RES_1024X512_60HZ_PIXCLOCK,  60},
+  {1024,768, RES_1024X768_60HZ_PIXCLOCK,  60},
+  {1024,768, RES_1024X768_75HZ_PIXCLOCK,  75},
+  {1024,768, RES_1024X768_85HZ_PIXCLOCK,  85},
+  {1024,768, RES_1024X768_100HZ_PIXCLOCK, 100},
+  {1152,864, RES_1152X864_70HZ_PIXCLOCK,  70},
+  {1152,864, RES_1152X864_75HZ_PIXCLOCK,  75},
+  {1280,768, RES_1280X768_60HZ_PIXCLOCK,  60},
+  {1280,960, RES_1280X960_60HZ_PIXCLOCK,  60},
+  {1280,1024,RES_1280X1024_60HZ_PIXCLOCK, 60},
+  {1280,1024,RES_1280X1024_75HZ_PIXCLOCK, 75},
+  {1280,1024,RES_1280X768_85HZ_PIXCLOCK,  85},
+  {1440,1050,RES_1440X1050_60HZ_PIXCLOCK, 60},
+  {1600,1200,RES_1600X1200_60HZ_PIXCLOCK, 60},
+  {1600,1200,RES_1600X1200_75HZ_PIXCLOCK, 75},
+  {1280,720, RES_1280X720_60HZ_PIXCLOCK,  60},
+  {1920,1080,RES_1920X1080_60HZ_PIXCLOCK, 60},
+  {1400,1050,RES_1400X1050_60HZ_PIXCLOCK, 60},
+  {1368,768, RES_1368X768_60HZ_PIXCLOCK,60}
+};
+#define NUM_TOTAL_RES_MAP_REFRESH ARRAY_SIZE(res_map_refresh_tbl)
+
+/* Video Mode Table */
+/* Common Setting for Video Mode */
+static struct io_reg CLE266_ModeXregs[] = {
+  {VIASR,SR1E,0xF0,0xF0},
+  {VIASR,SR2A,0x0F,0x0F},
+  {VIASR,SR15,0x02,0x02},
+  {VIASR,SR16,0xBF,0x08},
+  {VIASR,SR17,0xFF,0x1F},
+  {VIASR,SR18,0xFF,0x4E},
+  {VIASR,SR1A,0xFB,0x08},
+
+  {VIACR,CR32,0xFF,0x00},
+/*  {VIACR,CR33,0xFF,0x08}, for K800 prefetch mode */
+  {VIACR,CR34,0xFF,0x00},
+  {VIACR,CR35,0xFF,0x00},
+  {VIACR,CR36,0x08,0x00},
+  {VIACR,CR6A,0xFF,0x80},
+  {VIACR,CR6A,0xFF,0xC0},
+
+  {VIACR,CR55,0x80,0x00},
+  {VIACR,CR5D,0x80,0x00},
+
+  {VIAGR,GR20,0xFF,0x00},
+  {VIAGR,GR21,0xFF,0x00},
+  {VIAGR,GR22,0xFF,0x00},
+                            /* LCD Parameters */
+  {VIACR,CR7A,0xFF,0x01},   /* LCD Parameter 1 */
+  {VIACR,CR7B,0xFF,0x02},   /* LCD Parameter 2 */
+  {VIACR,CR7C,0xFF,0x03},   /* LCD Parameter 3 */
+  {VIACR,CR7D,0xFF,0x04},   /* LCD Parameter 4 */
+  {VIACR,CR7E,0xFF,0x07},   /* LCD Parameter 5 */
+  {VIACR,CR7F,0xFF,0x0A},   /* LCD Parameter 6 */
+  {VIACR,CR80,0xFF,0x0D},   /* LCD Parameter 7 */
+  {VIACR,CR81,0xFF,0x13},   /* LCD Parameter 8 */
+  {VIACR,CR82,0xFF,0x16},   /* LCD Parameter 9 */
+  {VIACR,CR83,0xFF,0x19},   /* LCD Parameter 10 */
+  {VIACR,CR84,0xFF,0x1C},   /* LCD Parameter 11 */
+  {VIACR,CR85,0xFF,0x1D},   /* LCD Parameter 12 */
+  {VIACR,CR86,0xFF,0x1E},   /* LCD Parameter 13 */
+  {VIACR,CR87,0xFF,0x1F},   /* LCD Parameter 14 */
+
+};
+
+static struct io_reg KM400_ModeXregs[] = {
+    {VIASR, SR10, 0xFF, 0x01},          /* Unlock Register                     */
+    {VIASR, SR16, 0xFF, 0x08},          /* Display FIFO threshold Control      */
+    {VIASR, SR17, 0xFF, 0x1F},          /* Display FIFO Control                */
+    {VIASR, SR18, 0xFF, 0x4E},          /* GFX PREQ threshold                  */
+    {VIASR, SR1A, 0xFF, 0x0a},          /* GFX PREQ threshold                  */
+    {VIASR, SR1F, 0xFF, 0x00},          /* Memory Control 0                    */
+    {VIASR, SR1B, 0xFF, 0xF0},          /* Power Management Control 0          */
+    {VIASR, SR1E, 0x0F, 0x01},          /* Power Management Control            */
+    {VIASR, SR20, 0xFF, 0x00},          /* Sequencer Arbiter Control 0         */
+    {VIASR, SR21, 0xFF, 0x00},          /* Sequencer Arbiter Control 1         */
+    {VIASR, SR22, 0xFF, 0x1F},          /* Display Arbiter Control 1           */
+    {VIASR, SR2A, 0xF0, 0x00},          /* Power Management Control 5          */
+    {VIASR, SR2D, 0xFF, 0xFF},          /* Power Management Control 1          */
+    {VIASR, SR2E, 0xFF, 0xFF},          /* Power Management Control 2          */
+    {VIACR, CR0A, 0xFF, 0x1E},          /* Cursor Start                        */
+    {VIACR, CR0B, 0xFF, 0x00},          /* Cursor End                          */
+    {VIACR, CR0E, 0xFF, 0x00},          /* Cursor Location High                */
+    {VIACR, CR0F, 0xFF, 0x00},          /* Cursor Localtion Low                */
+    {VIACR, CR33, 0xFF, 0x00},
+    {VIACR, CR55, 0x80, 0x00},
+    {VIACR, CR5D, 0x80, 0x00},
+    {VIACR, CR36, 0xFF, 0x01},          /* Power Mangement 3                   */
+    {VIACR, CR62, 0xFF, 0x00},          /* Secondary Display Starting Address  */
+    {VIACR, CR63, 0xFF, 0x00},          /* Secondary Display Starting Address  */
+    {VIACR, CR64, 0xFF, 0x00},          /* Secondary Display Starting Address  */
+    {VIACR, CR68, 0xFF, 0x67},          /* Default FIFO For IGA2               */
+    {VIACR, CR6A, 0x20, 0x20},          /* Extended FIFO On                    */
+    {VIACR, CR7A, 0xFF, 0x01},          /* LCD Scaling Parameter 1             */
+    {VIACR, CR7B, 0xFF, 0x02},          /* LCD Scaling Parameter 2             */
+    {VIACR, CR7C, 0xFF, 0x03},          /* LCD Scaling Parameter 3             */
+    {VIACR, CR7D, 0xFF, 0x04},          /* LCD Scaling Parameter 4             */
+    {VIACR, CR7E, 0xFF, 0x07},          /* LCD Scaling Parameter 5             */
+    {VIACR, CR7F, 0xFF, 0x0A},          /* LCD Scaling Parameter 6             */
+    {VIACR, CR80, 0xFF, 0x0D},          /* LCD Scaling Parameter 7             */
+    {VIACR, CR81, 0xFF, 0x13},          /* LCD Scaling Parameter 8             */
+    {VIACR, CR82, 0xFF, 0x16},          /* LCD Scaling Parameter 9             */
+    {VIACR, CR83, 0xFF, 0x19},          /* LCD Scaling Parameter 10            */
+    {VIACR, CR84, 0xFF, 0x1C},          /* LCD Scaling Parameter 11            */
+    {VIACR, CR85, 0xFF, 0x1D},          /* LCD Scaling Parameter 12            */
+    {VIACR, CR86, 0xFF, 0x1E},          /* LCD Scaling Parameter 13            */
+    {VIACR, CR87, 0xFF, 0x1F},          /* LCD Scaling Parameter 14            */
+    {VIACR, CR88, 0xFF, 0x40},          /* LCD Panel Type                      */
+    {VIACR, CR89, 0xFF, 0x00},          /* LCD Timing Control 0                */
+    {VIACR, CR8A, 0xFF, 0x88},          /* LCD Timing Control 1                */
+    {VIACR, CR8B, 0xFF, 0x2D},          /* LCD Power Sequence Control 0        */
+    {VIACR, CR8C, 0xFF, 0x2D},          /* LCD Power Sequence Control 1        */
+    {VIACR, CR8D, 0xFF, 0xC8},          /* LCD Power Sequence Control 2        */
+    {VIACR, CR8E, 0xFF, 0x36},          /* LCD Power Sequence Control 3        */
+    {VIACR, CR8F, 0xFF, 0x00},          /* LCD Power Sequence Control 4        */
+    {VIACR, CR90, 0xFF, 0x10},          /* LCD Power Sequence Control 5        */
+    {VIACR, CR91, 0xFF, 0xA0},          /* 24/12 bit LVDS Data off             */
+    {VIACR, CR96, 0xFF, 0x03},          /* TV on DVP0        ; DVP0 Clock Skew */
+    {VIACR, CR97, 0xFF, 0x03},          /* TV on DFP high    ; DFPH Clock Skew */
+    {VIACR, CR99, 0xFF, 0x03},          /* DFP low           ; DFPL Clock Skew */
+    {VIACR, CR9B, 0xFF, 0x07}           /* DVI on DVP1       ; DVP1 Clock Skew */
+};
+#define NUM_TOTAL_KM400_ModeXregs ARRAY_SIZE(KM400_ModeXregs)
+
+static struct io_reg CN400_ModeXregs[] = {
+    {VIASR, SR10, 0xFF, 0x01},
+    {VIASR, SR15, 0x02, 0x02},
+    {VIASR, SR16, 0xBF, 0x08},
+    {VIASR, SR17, 0xFF, 0x1F},
+    {VIASR, SR18, 0xFF, 0x4E},
+    {VIASR, SR1A, 0xFB, 0x08},
+    {VIASR, SR1E, 0x0F, 0x01},
+    {VIASR, SR2A, 0xF0, 0x00},
+    {VIACR, CR0A, 0xFF, 0x1E},          /* Cursor Start                        */
+    {VIACR, CR0B, 0xFF, 0x00},          /* Cursor End                          */
+    {VIACR, CR0E, 0xFF, 0x00},          /* Cursor Location High                */
+    {VIACR, CR0F, 0xFF, 0x00},          /* Cursor Localtion Low                */
+    {VIACR, CR32, 0xFF, 0x00},
+    {VIACR, CR33, 0xFF, 0x00},
+    {VIACR, CR34, 0xFF, 0x00},
+    {VIACR, CR35, 0xFF, 0x00},
+    {VIACR, CR36, 0x08, 0x00},
+    {VIACR, CR62, 0xFF, 0x00},          /* Secondary Display Starting Address  */
+    {VIACR, CR63, 0xFF, 0x00},          /* Secondary Display Starting Address  */
+    {VIACR, CR64, 0xFF, 0x00},          /* Secondary Display Starting Address  */
+    {VIACR, CR69, 0xFF, 0x00},
+    {VIACR, CR6A, 0xFF, 0x40},
+    {VIACR, CR6B, 0xFF, 0x00},
+    {VIACR, CR6C, 0xFF, 0x00},
+    {VIACR, CR7A, 0xFF, 0x01},          /* LCD Scaling Parameter 1             */
+    {VIACR, CR7B, 0xFF, 0x02},          /* LCD Scaling Parameter 2             */
+    {VIACR, CR7C, 0xFF, 0x03},          /* LCD Scaling Parameter 3             */
+    {VIACR, CR7D, 0xFF, 0x04},          /* LCD Scaling Parameter 4             */
+    {VIACR, CR7E, 0xFF, 0x07},          /* LCD Scaling Parameter 5             */
+    {VIACR, CR7F, 0xFF, 0x0A},          /* LCD Scaling Parameter 6             */
+    {VIACR, CR80, 0xFF, 0x0D},          /* LCD Scaling Parameter 7             */
+    {VIACR, CR81, 0xFF, 0x13},          /* LCD Scaling Parameter 8             */
+    {VIACR, CR82, 0xFF, 0x16},          /* LCD Scaling Parameter 9             */
+    {VIACR, CR83, 0xFF, 0x19},          /* LCD Scaling Parameter 10            */
+    {VIACR, CR84, 0xFF, 0x1C},          /* LCD Scaling Parameter 11            */
+    {VIACR, CR85, 0xFF, 0x1D},          /* LCD Scaling Parameter 12            */
+    {VIACR, CR86, 0xFF, 0x1E},          /* LCD Scaling Parameter 13            */
+    {VIACR, CR87, 0xFF, 0x1F},          /* LCD Scaling Parameter 14            */
+    {VIACR, CR88, 0xFF, 0x40},          /* LCD Panel Type                      */
+    {VIACR, CR89, 0xFF, 0x00},          /* LCD Timing Control 0                */
+    {VIACR, CR8A, 0xFF, 0x88},          /* LCD Timing Control 1                */
+    {VIACR, CR8B, 0xFF, 0x69},          /* LCD Power Sequence Control 0        */
+    {VIACR, CR8C, 0xFF, 0x57},          /* LCD Power Sequence Control 1        */
+    {VIACR, CR8D, 0xFF, 0x00},          /* LCD Power Sequence Control 2        */
+    {VIACR, CR8E, 0xFF, 0x7B},          /* LCD Power Sequence Control 3        */
+    {VIACR, CR8F, 0xFF, 0x03},          /* LCD Power Sequence Control 4        */
+    {VIACR, CR90, 0xFF, 0x30},          /* LCD Power Sequence Control 5        */
+    {VIACR, CR91, 0xFF, 0xA0},          /* 24/12 bit LVDS Data off             */
+    {VIACR, CR96, 0xFF, 0x00},
+    {VIACR, CR97, 0xFF, 0x00},
+    {VIACR, CR99, 0xFF, 0x00},
+    {VIACR, CR9B, 0xFF, 0x00}
+};
+#define NUM_TOTAL_CN400_ModeXregs ARRAY_SIZE(CN400_ModeXregs)
+
+/* Video Mode Table for VT3314 chipset*/
+/* Common Setting for Video Mode */
+static struct io_reg CN900_ModeXregs[] = {
+  {VIASR,SR10,0xFF,0x01},
+  {VIASR,SR15,0x02,0x02},
+  {VIASR,SR16,0xBF,0x08},
+  {VIASR,SR17,0xFF,0x1F},
+  {VIASR,SR18,0xFF,0x4E},
+  {VIASR,SR1A,0xFB,0x82},
+  {VIASR,SR1B,0xFF,0xF0},
+  {VIASR,SR1F,0xFF,0x00},
+  {VIASR,SR1E,0xFF,0xF1},
+  {VIASR,SR22,0xFF,0x1F},
+  {VIASR,SR2A,0x0F,0x0F},
+  {VIASR,SR2E,0xFF,0xFF},
+  {VIASR,SR3F,0xFF,0xFF},
+  {VIASR,SR40,0xFF,0x00},  
+  {VIASR,CR30,0xFF,0x04},
+  {VIACR,CR32,0xFF,0x00},
+  {VIACR,CR33,0x7F,0x00},
+  {VIACR,CR34,0xFF,0x00},
+  {VIACR,CR35,0xFF,0x00},
+  {VIACR,CR36,0xFF,0x31},
+  {VIACR,CR41,0xFF,0x80},
+  {VIACR,CR42,0xFF,0x00},
+  {VIACR,CR55,0x80,0x00},
+  {VIACR,CR5D,0x80,0x00},                                      /*Horizontal Retrace Start bit[11] should be 0*/
+  {VIACR,CR62,0xFF,0x00},                                      /* Secondary Display Starting Address*/
+  {VIACR,CR63,0xFF,0x00},                                      /* Secondary Display Starting Address*/
+  {VIACR,CR64,0xFF,0x00},                                      /* Secondary Display Starting Address*/
+  {VIACR,CR68,0xFF,0x67},                                      /* Default FIFO For IGA2 */ 
+  {VIACR,CR69,0xFF,0x00},
+  {VIACR,CR6A,0xFD,0x40},
+  {VIACR,CR6B,0xFF,0x00},
+  {VIACR,CR6C,0xFF,0x00},  
+  {VIACR,CR77,0xFF,0x00},                                      /* LCD scaling Factor*/
+  {VIACR,CR78,0xFF,0x00},                                      /* LCD scaling Factor */
+  {VIACR,CR79,0xFF,0x00},                                      /* LCD scaling Factor*/
+  {VIACR,CR9F,0x03,0x00},                                      /* LCD scaling Factor */
+  {VIACR,CR7A,0xFF,0x01},                                      /* LCD Scaling Parameter 1*/
+  {VIACR,CR7B,0xFF,0x02},                                      /* LCD Scaling Parameter 2*/
+  {VIACR,CR7C,0xFF,0x03},                                      /* LCD Scaling Parameter 3 */
+  {VIACR,CR7D,0xFF,0x04},                                      /* LCD Scaling Parameter 4*/
+  {VIACR,CR7E,0xFF,0x07},                                      /* LCD Scaling Parameter 5*/
+  {VIACR,CR7F,0xFF,0x0A},                                      /* LCD Scaling Parameter 6*/
+  {VIACR,CR80,0xFF,0x0D},                                      /* LCD Scaling Parameter 7*/
+  {VIACR,CR81,0xFF,0x13},                                      /* LCD Scaling Parameter 8*/
+  {VIACR,CR82,0xFF,0x16},                                      /* LCD Scaling Parameter 9*/
+  {VIACR,CR83,0xFF,0x19},                                      /* LCD Scaling Parameter 10*/
+  {VIACR,CR84,0xFF,0x1C},                                      /* LCD Scaling Parameter 11*/
+  {VIACR,CR85,0xFF,0x1D},                                      /* LCD Scaling Parameter 12*/
+  {VIACR,CR86,0xFF,0x1E},                                      /* LCD Scaling Parameter 13*/
+  {VIACR,CR87,0xFF,0x1F},                                      /* LCD Scaling Parameter 14*/
+  {VIACR,CR88,0xFF,0x40},                                      /* LCD Panel Type */
+  {VIACR,CR89,0xFF,0x00},                                      /* LCD Timing Control 0 */
+  {VIACR,CR8A,0xFF,0x88},                                      /* LCD Timing Control 1*/
+  {VIACR,CR8B,0xFF,0x5D},                                      /* LCD Power Sequence Control 0*/
+  {VIACR,CR8C,0xFF,0x2B},                                      /* LCD Power Sequence Control 1*/
+  {VIACR,CR8D,0xFF,0x6F},                                      /* LCD Power Sequence Control 2*/
+  {VIACR,CR8E,0xFF,0x2B},                                      /* LCD Power Sequence Control 3*/
+  {VIACR,CR8F,0xFF,0x01},                                      /* LCD Power Sequence Control 4*/
+  {VIACR,CR90,0xFF,0x01},                                      /* LCD Power Sequence Control 5*/
+  {VIACR,CR91,0xFF,0xA0},                                      /* 24/12 bit LVDS Data off*/
+  {VIACR,CR96,0xFF,0x00},
+  {VIACR,CR97,0xFF,0x00},
+  {VIACR,CR99,0xFF,0x00},
+  {VIACR,CR9B,0xFF,0x00},
+  {VIACR,CR9D,0xFF,0x80},
+  {VIACR,CR9E,0xFF,0x80}
+};
+#define NUM_TOTAL_CN900_ModeXregs ARRAY_SIZE(CN900_ModeXregs)
+
+/* For VT3324: Common Setting for Video Mode */
+static struct io_reg CX700_ModeXregs [] = {
+    {VIASR, SR10, 0xFF, 0x01},
+    {VIASR, SR15, 0x02, 0x02},
+    {VIASR, SR16, 0xBF, 0x08},
+    {VIASR, SR17, 0xFF, 0x1F},
+    {VIASR, SR18, 0xFF, 0x4E},
+    {VIASR, SR1A, 0xFB, 0x08},
+    {VIASR, SR1B, 0xFF, 0xF0},
+    {VIASR, SR1E, 0x0F, 0x01},
+    {VIASR, SR2A, 0xF0, 0x00},
+    {VIACR, CR0A, 0xFF, 0x1E},          /* Cursor Start                        */
+    {VIACR, CR0B, 0xFF, 0x00},          /* Cursor End                          */
+    {VIACR, CR0E, 0xFF, 0x00},          /* Cursor Location High                */
+    {VIACR, CR0F, 0xFF, 0x00},          /* Cursor Localtion Low                */
+    {VIACR, CR32, 0xFF, 0x00},
+    {VIACR, CR33, 0xFF, 0x00},
+    {VIACR, CR34, 0xFF, 0x00},
+    {VIACR, CR35, 0xFF, 0x00},
+    {VIACR, CR36, 0x08, 0x00},
+    {VIACR, CR47, 0xC8, 0x00},          /* Clear VCK Plus. */
+    {VIACR, CR62, 0xFF, 0x00},          /* Secondary Display Starting Address  */
+    {VIACR, CR63, 0xFF, 0x00},          /* Secondary Display Starting Address  */
+    {VIACR, CR64, 0xFF, 0x00},          /* Secondary Display Starting Address  */
+    {VIACR, CRA3, 0xFF, 0x00},          /* Secondary Display Starting Address  */
+    {VIACR, CR69, 0xFF, 0x00},
+    {VIACR, CR6A, 0xFF, 0x40},
+    {VIACR, CR6B, 0xFF, 0x00},
+    {VIACR, CR6C, 0xFF, 0x00},
+    {VIACR, CR7A, 0xFF, 0x01},          /* LCD Scaling Parameter 1             */
+    {VIACR, CR7B, 0xFF, 0x02},          /* LCD Scaling Parameter 2             */
+    {VIACR, CR7C, 0xFF, 0x03},          /* LCD Scaling Parameter 3             */
+    {VIACR, CR7D, 0xFF, 0x04},          /* LCD Scaling Parameter 4             */
+    {VIACR, CR7E, 0xFF, 0x07},          /* LCD Scaling Parameter 5             */
+    {VIACR, CR7F, 0xFF, 0x0A},          /* LCD Scaling Parameter 6             */
+    {VIACR, CR80, 0xFF, 0x0D},          /* LCD Scaling Parameter 7             */
+    {VIACR, CR81, 0xFF, 0x13},          /* LCD Scaling Parameter 8             */
+    {VIACR, CR82, 0xFF, 0x16},          /* LCD Scaling Parameter 9             */
+    {VIACR, CR83, 0xFF, 0x19},          /* LCD Scaling Parameter 10            */
+    {VIACR, CR84, 0xFF, 0x1C},          /* LCD Scaling Parameter 11            */
+    {VIACR, CR85, 0xFF, 0x1D},          /* LCD Scaling Parameter 12            */
+    {VIACR, CR86, 0xFF, 0x1E},          /* LCD Scaling Parameter 13            */
+    {VIACR, CR87, 0xFF, 0x1F},          /* LCD Scaling Parameter 14            */
+    {VIACR, CR88, 0xFF, 0x40},          /* LCD Panel Type                      */
+    {VIACR, CR89, 0xFF, 0x00},          /* LCD Timing Control 0                */
+    {VIACR, CR8A, 0xFF, 0x88},          /* LCD Timing Control 1                */
+    {VIACR, CRD4, 0xFF, 0x81},          /* Second power sequence control       */
+    {VIACR, CR8B, 0xFF, 0x5D},          /* LCD Power Sequence Control 0        */
+    {VIACR, CR8C, 0xFF, 0x2B},          /* LCD Power Sequence Control 1        */
+    {VIACR, CR8D, 0xFF, 0x6F},          /* LCD Power Sequence Control 2        */
+    {VIACR, CR8E, 0xFF, 0x2B},          /* LCD Power Sequence Control 3        */
+    {VIACR, CR8F, 0xFF, 0x01},          /* LCD Power Sequence Control 4        */
+    {VIACR, CR90, 0xFF, 0x01},          /* LCD Power Sequence Control 5        */
+    {VIACR, CR91, 0xFF, 0x80},          /* 24/12 bit LVDS Data off             */
+    {VIACR, CR96, 0xFF, 0x00},
+    {VIACR, CR97, 0xFF, 0x00},
+    {VIACR, CR99, 0xFF, 0x00},
+    {VIACR, CR9B, 0xFF, 0x00},
+    {VIACR, CRD2, 0xFF, 0xFF}           /* TMDS/LVDS control register.         */
+};
+#define NUM_TOTAL_CX700_ModeXregs ARRAY_SIZE(CX700_ModeXregs)
+
+extern int refresh;
+extern int tv_level;
+extern int tv_system;
+extern int tv_out_signal;
+extern int tv_dedotcrawl;
+extern int lcd_dsp_method;
+extern int lcd_mode;
+extern int second_virtual_xres;
+extern int bpp1;
+
+extern int accel;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0) 
+extern struct viafb_info viafbinfo;
+extern struct viafb_info viafbinfo1;
+#endif 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+extern struct viafb_par parinfo;
+extern struct viafb_par parinfo1;
+#endif
+
+extern int CRT_ON, TV_ON, DVI_ON, LCD_ON, LCD2_ON, SAMM_ON,dual_fb;
+extern int lcd_panel_id;
+extern int HotPlug, DeviceStatus;
+extern int HotPlug_Xres, HotPlug_Yres, HotPlug_bpp, HotPlug_refresh;
+extern unsigned int second_offset;
+extern int second_size;
+extern int primary_dev;
+extern int display_hardware_layout;
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
+    extern void __iomem *FB_MM;
+#else
+    extern unsigned long FB_MM;
+#endif
+
+/* Access I/O Function */
+inline void write_reg(u8 index, u16 io_port, u8 data);
+void write_reg_mask(u8 index, int io_port, u8 data, u8 mask);
+inline u8 read_reg(int io_port, u8 index);
+inline void lock_crt(void);
+inline void unlock_crt(void);
+
+void set_crt_output_path(int set_iga);
+void set_tv_output_path(int set_iga, int output_interface);
+void set_dvi_output_path(int set_iga, int output_interface);
+void set_lcd_output_path(int set_iga, int output_interface);
+void SetVCLK( u32 CLK, int set_iga );
+void init_gfx_chip_info(void);
+void init_tv_chip_info(void);
+void init_tmds_chip_info(void);
+void init_lvds_chip_info(void);
+void load_reg(int timing_value, int load_reg_num, struct io_register *reg, int io_type);
+void device_off(void);
+void device_on(void);
+void crt_disable(void);
+void crt_enable(void);
+void enable_second_display_channel(void);
+void disable_second_display_channel(void);
+void lcd_patch_skew(struct lvds_setting_information *plvds_setting_info, struct lvds_chip_information *plvds_chip_info);
+int get_fb_size_from_pci(void);
+
+
+
+inline void write_reg(u8 index, u16 io_port, u8 data)
+{
+    outb(index, io_port);
+    outb(data, io_port+1);
+}
+
+void write_reg_mask(u8 index, int io_port, u8 data, u8 mask)
+{
+    u8 tmp;
+
+    outb(index, io_port);
+    tmp = inb(io_port+1);
+    outb((data & mask) | (tmp & (~mask)), io_port+1);
+}
+
+void write_dac_reg(u8 index, u8 r, u8 g, u8 b)
+{
+    outb(index, LUT_INDEX_WRITE);
+    outb(r, LUT_DATA);
+    outb(g, LUT_DATA);
+    outb(b, LUT_DATA);
+}
+
+inline u8 read_reg(int io_port, u8 index)
+{
+    outb(index, io_port);
+    return(inb(io_port+1));
+}
+
+inline void lock_crt(void)
+{
+    write_reg_mask(CR11, VIACR, BIT7, BIT7);
+}
+
+inline void unlock_crt(void)
+{
+    write_reg_mask(CR11, VIACR, 0, BIT7);
+    write_reg_mask(CR47, VIACR, 0, BIT0);
+}
+
+/* Set IGA path for each device */
+void set_iga_path(void)
+{
+
+    if (SAMM_ON == 1)
+    {
+        /* We can specify iga path by device order: 
+           primary device uses IGA1, secondary device uses IGA2. */
+        
+        if (CRT_ON)
+        {
+            if (primary_dev == CRT_Device)
+            {
+                crt_setting_info.iga_path = IGA1;
+            }
+            else
+            {
+                crt_setting_info.iga_path = IGA2;
+            }
+        }
+    
+        if (TV_ON)
+        {
+            if (primary_dev == TV_Device)
+            {
+                tv_setting_info.iga_path = IGA1;
+            }
+            else
+            {
+                tv_setting_info.iga_path = IGA2;
+            }
+        }
+    
+        if (DVI_ON)
+        {
+            if (primary_dev == DVI_Device)
+            {
+                tmds_setting_info.iga_path = IGA1;
+            }
+            else
+            {
+                tmds_setting_info.iga_path = IGA2;
+            }
+        }
+    
+        if (LCD_ON)
+        {
+            if (primary_dev == LCD_Device)
+            {
+                /* Primary device LCD still use IGA2 on CLE266. */
+                if(dual_fb && (chip_info.gfx_chip_name==UNICHROME_CLE266)) {
+                    lvds_setting_info.iga_path = IGA2;
+                    crt_setting_info.iga_path = IGA1;
+                    tv_setting_info.iga_path = IGA1;
+                    tmds_setting_info.iga_path = IGA1;
+                }
+                else 
+                    lvds_setting_info.iga_path = IGA1;
+            }
+            else
+            {
+                lvds_setting_info.iga_path = IGA2;
+            }
+        }
+        if(LCD2_ON)
+        {
+            if(LCD2_Device == primary_dev)
+            {
+                lvds_setting_info2.iga_path = IGA1;
+            }else
+            {
+                lvds_setting_info2.iga_path = IGA2;
+            }
+        }
+    }
+    else
+    {
+        /* Use DuoView instead of Simultaneous. */
+
+        SAMM_ON =0;
+
+        if (CRT_ON && LCD_ON)
+        {
+            crt_setting_info.iga_path = IGA1;
+            lvds_setting_info.iga_path = IGA2;
+        }
+        else if (CRT_ON && DVI_ON)
+        {
+            crt_setting_info.iga_path = IGA1;
+            tmds_setting_info.iga_path = IGA2;
+        }
+        else if (CRT_ON && TV_ON)
+        {
+            crt_setting_info.iga_path = IGA1;
+            tv_setting_info.iga_path = IGA2;
+        }
+        else if (DVI_ON && TV_ON)
+        {
+            tmds_setting_info.iga_path = IGA1;
+            tv_setting_info.iga_path = IGA2;
+        }
+        else if (LCD_ON && TV_ON)
+        {
+            tv_setting_info.iga_path = IGA1;
+            lvds_setting_info.iga_path = IGA2;
+        }
+        else if (LCD_ON && DVI_ON)
+        {
+            tmds_setting_info.iga_path = IGA1;
+            lvds_setting_info.iga_path = IGA2;
+        }else if(LCD_ON&&LCD2_ON)
+        {
+            lvds_setting_info.iga_path = IGA2;
+            lvds_setting_info2.iga_path = IGA2;
+        }
+        else if (CRT_ON)
+        {
+            crt_setting_info.iga_path = IGA1;
+        }
+        else if (TV_ON)
+        {
+            tv_setting_info.iga_path = IGA1;
+        }
+        else if (LCD_ON)
+        {
+            lvds_setting_info.iga_path = IGA2;
+        }
+        else if (DVI_ON)
+        {
+            tmds_setting_info.iga_path = IGA1;
+        }
+    }
+}
+
+void set_start_addr(void)
+{
+    DEBUG_MSG(KERN_INFO "set_start_addr!\n" );
+    unlock_crt();
+
+    /* Update starting address */
+    write_reg(CR0C, VIACR, 0x00); /* Initial starting address */
+    write_reg(CR0D, VIACR, 0x00);
+    write_reg(CR34, VIACR, 0x00);
+    write_reg_mask(CR48, VIACR, 0x00, BIT0+BIT1);
+
+    #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+    if(dual_fb) {
+    /* This setting is for HW accel in dual-fb */
+        parinfo.iga_path = IGA1;
+        parinfo1.iga_path = IGA2;
+    }  
+    #endif  
+     
+    if(SAMM_ON==1)
+    {
+        unsigned long offset,tmp,size;
+        unsigned long length;
+    if(!dual_fb) { 
+    /* When no dual-fb, can dynamic set second_size */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)  
+        if(second_size && (second_size*1024*1024 >= (viafbinfo.memsize - (16*1024*1024))))
+            second_size = (viafbinfo.memsize>>20) - 16;
+
+        if(second_size && (second_size*1024*1024 <= (16*1024*1024)) && (second_size > 0))
+            second_size = 16;
+
+        if(second_size)
+        {
+            second_offset = viafbinfo.memsize - second_size*1024*1024; 
+            size=second_size*1024*1024;
+        }
+        else
+        {
+            second_offset = viafbinfo.memsize >> 1;
+            size== viafbinfo.memsize >> 1;
+        }
+#else
+        if(second_size && (second_size*1024*1024 >= (parinfo.memsize - (16*1024*1024))))
+            second_size = (parinfo.memsize>>20) - 16;
+
+        if(second_size && (second_size *1024*1024<= (16*1024*1024)) && (second_size > 0))
+            second_size = 16;
+
+        if(second_size)
+        {
+            second_offset = parinfo.memsize - second_size*1024*1024;
+            size=second_size*1024*1024;
+        }
+        else
+        {
+            second_offset = parinfo.memsize >> 1;
+            size=parinfo.memsize >> 1; 
+        }
+#endif
+       }
+       else { /* dual-fb is enabled */
+           #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)  
+           size = viafbinfo1.memsize;
+           #else
+           size = parinfo1.memsize;
+           #endif
+       }
+        offset = second_offset;
+        DEBUG_MSG(KERN_INFO"second_size=%x, second start_adddress=%x\n",size,offset);
+        offset=offset>>3;
+  
+        tmp = read_reg(VIACR, 0x62) & 0x01;
+        tmp |= (offset & 0x7F) << 1;
+        write_reg(CR62, VIACR, tmp);
+        write_reg(CR63, VIACR, ((offset & 0x7F80) >> 7));
+        write_reg(CR64, VIACR, ((offset & 0x7F8000) >> 15));
+        write_reg(CRA3, VIACR, ((offset & 0x3800000) >> 23));
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+        length =size;
+#else
+        if(accel) {
+            if(!dual_fb)
+                length = size - parinfo.fbmem_used;
+            else 
+                length = size - parinfo1.fbmem_used;
+            } 
+        else
+            length = size;
+#endif
+
+        offset=(unsigned long)(void *)FB_MM+second_offset;
+        memset_io((void *)offset, 0, length); 
+    }
+    else
+    {
+        /* Update starting address */
+        write_reg(CR62, VIACR, 0x00);
+        write_reg(CR63, VIACR, 0x00);
+        write_reg(CR64, VIACR, 0x00);
+        write_reg(CRA3, VIACR, 0x00);
+    }
+
+    lock_crt();
+}
+
+void set_output_path(int device, int set_iga, int output_interface)
+{
+    switch(device) {
+        case DEVICE_CRT:
+            set_crt_output_path(set_iga);
+            break;
+        case DEVICE_TV:
+            set_tv_output_path(set_iga, output_interface);
+            break;
+        case DEVICE_DVI:
+            set_dvi_output_path(set_iga, output_interface);
+            break;
+        case DEVICE_LCD:
+            set_lcd_output_path(set_iga, output_interface);
+            break;
+    }
+}
+
+void set_crt_output_path(int set_iga)
+{
+    write_reg_mask(CR36, VIACR, 0x00, BIT4+BIT5);
+
+    switch(set_iga) {
+        case IGA1:
+            write_reg_mask(SR16, VIASR, 0x00, BIT6);
+            break;
+        case IGA2:
+        case IGA1_IGA2:
+            write_reg_mask(CR6A, VIACR, 0xC0, BIT6+BIT7);
+            write_reg_mask(SR16, VIASR, 0x40, BIT6);
+            if (set_iga == IGA1_IGA2)
+                write_reg_mask(CR6B, VIACR, 0x08, BIT3);
+            break;
+    }
+}
+
+void set_tv_output_path(int set_iga, int output_interface)
+{
+    DEBUG_MSG(KERN_INFO "set_tv_output_path, iga:%d,out_interface:%d\n", set_iga, output_interface);
+    switch(set_iga)
+    {
+        case IGA1:
+            /* Set IGA1 display channel to normal case beside CLE266.AX chip
+               and disable simultaneous display. */
+            if ((chip_info.gfx_chip_name == UNICHROME_CLE266) && (chip_info.gfx_chip_revision == CLE266_REVISION_AX))
+            {
+                SetVCLK(0x471c, IGA1);
+                write_reg_mask(CR6B, VIACR, 0xC0, BIT3+BIT6+BIT7);
+            }
+            else
+            {
+                write_reg_mask(CR6B, VIACR, 0x00, BIT3+BIT6+BIT7);
+            }
+
+            /* TV path selection: */
+            write_reg_mask(CR6C, VIACR, 0x00, BIT7);
+
+            break;
+        case IGA2:
+            /* Set IGA2 display channel to normal case beside CLE266.AX chip
+               and disable simultaneous display. Modify for sequence issue. */
+            enable_second_display_channel();
+
+            if (chip_info.gfx_chip_name == UNICHROME_CLE266 && chip_info.gfx_chip_revision == CLE266_REVISION_AX)
+            {
+                write_reg_mask(CR6B, VIACR, 0x30, BIT3+BIT4+BIT5);
+            }
+            else
+            {
+                write_reg_mask(CR6B, VIACR, 0x00, BIT3+BIT6+BIT7);
+            }
+
+            /* Disable LCD Scaling */
+            write_reg_mask(CR79, VIACR, 0x00, BIT0);
+
+            /* TV path selection: */
+            write_reg_mask(CR6C, VIACR, 0x80, BIT7);
+            
+            break;
+        case IGA1_IGA2:
+            /* Set IGA1_IGA2 display channel to normal case beside CLE266.AX chip
+               and enable simultaneous display. Modify for sequence issue. */
+            enable_second_display_channel();
+
+            if (chip_info.gfx_chip_name == UNICHROME_CLE266 && chip_info.gfx_chip_revision == CLE266_REVISION_AX)
+            {
+                write_reg_mask(CR6B, VIACR, 0xC0, BIT3+BIT6+BIT7);
+            }
+            else
+            {
+                write_reg_mask(CR6B, VIACR, 0x00, BIT3+BIT6+BIT7);
+            }
+
+            /* TV path selection: */
+            write_reg_mask(CR6C, VIACR, 0x80, BIT7);
+            
+            break;
+    }
+
+    switch(output_interface)
+    {
+        case INTERFACE_DVP0:
+            if (set_iga == IGA1)
+            {
+                /* Except CLE266, we also need to set CR96[4] for DVP0 Data Source Selection. */
+                if (chip_info.gfx_chip_name != UNICHROME_CLE266)
+                {
+                    write_reg_mask(CR96, VIACR, 0x00, BIT4);
+                }
+            }
+            else
+            {
+          write_reg(CR91, VIACR, 0x00);
+
+                /* Except CLE266, we also need to set CR96[4] for DVP0 Data Source Selection. */
+                if (chip_info.gfx_chip_name != UNICHROME_CLE266)
+                {
+                    write_reg_mask(CR96, VIACR, 0x10, BIT4);
+                }
+            }  
+
+            if (chip_info.gfx_chip_name == UNICHROME_CLE266 && chip_info.gfx_chip_revision == CLE266_REVISION_AX)
+            {
+                write_reg_mask(CR6B, VIACR, 0x01, BIT0);
+            }
+            else
+            {
+                write_reg_mask(CR6B, VIACR, 0x00, BIT0);
+            }
+            
+            write_reg_mask(SR1E, VIASR, 0xC0, BIT6+BIT7);
+            break;
+
+        case INTERFACE_DVP1:
+            if (set_iga== IGA1)
+            {
+                write_reg_mask(CR9B, VIACR, 0x00, BIT4);
+            }
+            else
+            {
+                write_reg(CR91, VIACR, 0x00);
+                write_reg_mask(CR9B, VIACR, 0x10, BIT4);
+            }
+            
+            write_reg_mask(SR1E, VIASR, 0x30, BIT4+BIT5);
+            break;
+            
+        case INTERFACE_DFP_HIGH:
+            if (set_iga== IGA1)
+            {
+                write_reg_mask(CR96, VIACR, 0x00, BIT4);
+                write_reg_mask(CR97, VIACR, 0x00, BIT4);
+            }
+            else
+            {
+                write_reg(CR91, VIACR, 0x00);
+                write_reg_mask(CR96, VIACR, 0x10, BIT4);
+                write_reg_mask(CR97, VIACR, 0x10, BIT4);
+            }
+            
+            write_reg_mask(SR2A, VIASR, 0x0C, BIT2+BIT3);
+            break;
+            
+        case INTERFACE_DFP_LOW:
+            if (set_iga== IGA1)
+            {
+                write_reg_mask(CR9B, VIACR, 0x00, BIT4);
+                write_reg_mask(CR99, VIACR, 0x00, BIT4);
+            }
+            else
+            {
+                write_reg(CR91, VIACR, 0x00);
+                write_reg_mask(CR9B, VIACR, 0x10, BIT4);
+                write_reg_mask(CR99, VIACR, 0x10, BIT4);
+            }
+            
+            write_reg_mask(SR2A, VIASR, 0x03, BIT0+BIT1);
+            break;
+    }
+
+    set_tv_clock_source();
+}
+
+/* Add for adjusting clock skew. Modified from X driver code */
+void dvi_patch_skew_dvp0(void)
+{
+    /* Reset data driving first: */
+    write_reg_mask(SR1B, VIASR, 0, BIT1);
+    write_reg_mask(SR2A, VIASR, 0, BIT4);
+
+    switch (chip_info.gfx_chip_name)
+    {
+        case UNICHROME_P4M890:
+        {
+            if(( tmds_setting_info.h_active == 1600)&&( tmds_setting_info.v_active == 1200))
+                write_reg_mask(CR96, VIACR, 0x03, BIT0+BIT1+BIT2);
+            else
+                write_reg_mask(CR96, VIACR, 0x07, BIT0+BIT1+BIT2);
+            break;
+        }
+
+        case UNICHROME_P4M900:
+        {
+            write_reg_mask(CR96, VIACR, 0x07, BIT0+BIT1+BIT2+BIT3);
+            write_reg_mask(SR1B, VIASR, 0x02, BIT1);
+            write_reg_mask(SR2A, VIASR, 0x10, BIT4);
+            break;
+        }
+
+        default:
+        {
+           break;
+        }
+    }
+}
+
+void dvi_patch_skew_dvp_low(void)
+{
+    switch (chip_info.gfx_chip_name)
+    {
+        case UNICHROME_K8M890:
+        {
+            write_reg_mask(CR99, VIACR, 0x03, BIT0+BIT1);
+            break;
+        }
+        
+        case UNICHROME_P4M900:        
+        {
+            write_reg_mask(CR99, VIACR, 0x08, BIT0+BIT1+BIT2+BIT3);
+            break;
+        }
+
+        case UNICHROME_P4M890:        
+        {
+            write_reg_mask(CR99, VIACR, 0x0F, BIT0+BIT1+BIT2+BIT3);
+            break;
+        }
+
+        default:
+        {
+           break;
+        }
+    }
+}
+
+void set_dvi_output_path(int set_iga, int output_interface)
+{
+    switch(output_interface)
+    {
+        case INTERFACE_DVP0:
+            write_reg_mask(CR6B, VIACR, 0x01, BIT0);
+            
+            if (set_iga== IGA1)
+            {
+                write_reg_mask(CR96, VIACR, 0x00, BIT4);
+                write_reg_mask(CR6C, VIACR, 0x21, BIT0+BIT5+BIT7);
+            }
+            else
+            {
+                write_reg_mask(CR96, VIACR, 0x10, BIT4);
+                write_reg_mask(CR6C, VIACR, 0xA1, BIT0+BIT5+BIT7);
+            }
+
+            write_reg_mask(SR1E, VIASR, 0xC0, BIT7+BIT6);
+
+            /* Adjust clock skew to meet VT1632 chip. */
+            dvi_patch_skew_dvp0();
+            break;
+
+        case INTERFACE_DVP1:
+            if (chip_info.gfx_chip_name == UNICHROME_CLE266)
+            {
+                if (set_iga== IGA1)
+                    write_reg_mask(CR93, VIACR, 0x21, BIT0+BIT5+BIT7);
+                else
+                    write_reg_mask(CR93, VIACR, 0xA1, BIT0+BIT5+BIT7);
+            }
+            else
+            {
+                if (set_iga== IGA1)
+                    write_reg_mask(CR9B, VIACR, 0x00, BIT4);
+                else
+                    write_reg_mask(CR9B, VIACR, 0x10, BIT4);
+            }
+            
+            write_reg_mask(SR1E, VIASR, 0x30, BIT4+BIT5);
+            break;
+        /* Add to support VT3327 VT3336 VT3364*/
+        case INTERFACE_DFP_HIGH:
+            if (chip_info.gfx_chip_name != UNICHROME_CLE266)
+            {
+                if (set_iga== IGA1)
+                {
+                    write_reg_mask(CR96, VIACR, 0x00, BIT4);
+                    write_reg_mask(CR97, VIACR, 0x03, BIT0+BIT1+BIT4);
+                }
+                else
+                {
+                    write_reg_mask(CR96, VIACR, 0x10, BIT4);
+                    write_reg_mask(CR97, VIACR, 0x13, BIT0+BIT1+BIT4);
+                }
+            }        
+            write_reg_mask(SR2A, VIASR, 0x0C, BIT2+BIT3);
+            break;
+
+        case INTERFACE_DFP_LOW:
+            if (chip_info.gfx_chip_name == UNICHROME_CLE266)
+            {
+                break;
+            }
+
+            if (set_iga == IGA1)
+            {
+                write_reg_mask(CR99, VIACR, 0x00, BIT4);
+                write_reg_mask(CR9B, VIACR, 0x00, BIT4);
+            }
+            else
+            {                
+                write_reg_mask(CR99, VIACR, 0x10, BIT4);
+                write_reg_mask(CR9B, VIACR, 0x10, BIT4);
+            }
+
+            write_reg_mask(SR2A, VIASR, 0x03, BIT0+BIT1);
+            dvi_patch_skew_dvp_low();
+            break;
+
+        case INTERFACE_TMDS:
+            if (set_iga == IGA1)
+            {
+                write_reg_mask(CR99, VIACR, 0x00, BIT4);
+            }
+            else
+            {
+                write_reg_mask(CR99, VIACR, 0x10, BIT4);
+            }
+            break;
+    }
+
+    if (set_iga == IGA2)
+    {
+        enable_second_display_channel();
+        /* Disable LCD Scaling */
+        write_reg_mask(CR79, VIACR, 0x00, BIT0);
+    }
+}
+
+void set_lcd_output_path(int set_iga, int output_interface)
+{
+    DEBUG_MSG(KERN_INFO "set_lcd_output_path, iga:%d,out_interface:%d\n", set_iga, output_interface);
+    switch(set_iga)
+    {
+        case IGA1:
+            write_reg_mask(CR6B, VIACR, 0x00, BIT3);
+            write_reg_mask(CR6A, VIACR, 0x08, BIT3);
+            
+            /* Modify for sequence issue. */
+            disable_second_display_channel();
+            break;
+
+        case IGA2:
+            write_reg_mask(CR6B, VIACR, 0x00, BIT3);
+            write_reg_mask(CR6A, VIACR, 0x08, BIT3);
+            
+            /* Modify for sequence issue. */
+            enable_second_display_channel();
+            break;
+
+        case IGA1_IGA2:
+            write_reg_mask(CR6B, VIACR, 0x08, BIT3);
+            write_reg_mask(CR6A, VIACR, 0x08, BIT3);
+            
+            /* Modify for sequence issue. */
+            disable_second_display_channel();
+            break;
+    }
+
+    switch(output_interface)
+    {
+        case INTERFACE_DVP0:
+            if (set_iga == IGA1)
+            {
+                write_reg_mask(CR96, VIACR, 0x00, BIT4);
+            }
+            else
+            {
+                write_reg(CR91, VIACR, 0x00);
+                write_reg_mask(CR96, VIACR, 0x10, BIT4);
+            }
+            break;
+
+        case INTERFACE_DVP1:
+            if (set_iga== IGA1)
+                write_reg_mask(CR9B, VIACR, 0x00, BIT4);
+            else
+            {
+                write_reg(CR91, VIACR, 0x00);
+                write_reg_mask(CR9B, VIACR, 0x10, BIT4);
+            }
+            break;
+
+        case INTERFACE_DFP_HIGH:
+            if (set_iga== IGA1)
+                write_reg_mask(CR97, VIACR, 0x00, BIT4);
+            else
+            {
+                write_reg(CR91, VIACR, 0x00);
+                write_reg_mask(CR97, VIACR, 0x10, BIT4);
+                write_reg_mask(CR96, VIACR, 0x10, BIT4);
+            }
+            break;
+
+        case INTERFACE_DFP_LOW:
+            if (set_iga== IGA1)
+                write_reg_mask(CR99, VIACR, 0x00, BIT4);
+            else
+            {
+                write_reg(CR91, VIACR, 0x00);
+                write_reg_mask(CR99, VIACR, 0x10, BIT4);
+                write_reg_mask(CR9B, VIACR, 0x10, BIT4);
+            }
+           
+            break;
+
+        case INTERFACE_DFP:
+            if((UNICHROME_K8M890 == chip_info.gfx_chip_name) ||(UNICHROME_P4M890 == chip_info.gfx_chip_name)) 
+               write_reg_mask(CR97, VIACR, 0x84, BIT7+BIT2+BIT1+BIT0);
+            if (set_iga== IGA1)
+            {
+                write_reg_mask(CR97, VIACR, 0x00, BIT4);
+                write_reg_mask(CR99, VIACR, 0x00, BIT4);
+            }
+            else
+            {
+                write_reg(CR91, VIACR, 0x00);
+                write_reg_mask(CR97, VIACR, 0x10, BIT4);
+                write_reg_mask(CR99, VIACR, 0x10, BIT4);
+            }
+            break;
+
+        /* Add for VT3324 integrated LVDS. */
+        case INTERFACE_LVDS0:
+        case INTERFACE_LVDS0LVDS1:
+            if (set_iga == IGA1)
+            {
+                write_reg_mask(CR99, VIACR, 0x00, BIT4);
+            }
+            else
+            {
+                write_reg_mask(CR99, VIACR, 0x10, BIT4);
+            }
+            
+            break;
+            
+        case INTERFACE_LVDS1:
+            if (set_iga == IGA1)
+            {
+                write_reg_mask(CR97, VIACR, 0x00, BIT4);
+            }
+            else
+            {
+                write_reg_mask(CR97, VIACR, 0x10, BIT4);
+            }
+
+            break;
+    }
+}
+
+/* Search Mode Index */
+int SearchModeSetting(int ModeInfoIndex)
+{
+   int i=0;
+
+   while ( ( i<NUM_TOTAL_MODETABLE ) && ( ModeInfoIndex != CLE266Modes[i].ModeIndex) ){i++;}
+   if( ( i >= NUM_TOTAL_MODETABLE ) ) i=0;
+   return i;
+
+}
+
+void load_fix_bit_crtc_reg(void)
+{
+     write_reg_mask(CR03, VIACR, 0x80, BIT7);   /* always set to 1 */
+     write_reg(CR18, VIACR, 0xff);                              /* line compare should set all bits = 1 (extend modes) */
+     write_reg_mask(CR07, VIACR, 0x10, BIT4);                   /* line compare should set all bits = 1 (extend modes) */
+     write_reg_mask(CR09, VIACR, 0x40, BIT6);                   /* line compare should set all bits = 1 (extend modes) */
+     write_reg_mask(CR35, VIACR, 0x10, BIT4);                   /* line compare should set all bits = 1 (extend modes) */
+     write_reg_mask(CR33, VIACR, 0x06, BIT0+BIT1+BIT2);         /* line compare should set all bits = 1 (extend modes) */
+     write_reg(CR17, VIACR, 0xe3);                              /* extend mode always set to e3h */
+     write_reg(CR08, VIACR, 0x00);                              /* extend mode always set to 0h */
+     write_reg(CR14, VIACR, 0x00);                              /* extend mode always set to 0h */
+
+    /* If K8M800, enable Prefetch Mode. */
+    if((chip_info.gfx_chip_name == UNICHROME_K800) || (chip_info.gfx_chip_name == UNICHROME_K8M890))
+    {
+        write_reg_mask(CR33, VIACR, 0x08, BIT3);
+    }
+    /* Fix the bug: linux video driver conflict with via frame buffer diver on EPIA-M board */
+    if ((chip_info.gfx_chip_name == UNICHROME_CLE266) && (chip_info.gfx_chip_revision == CLE266_REVISION_AX))
+        write_reg_mask(SR1A, VIASR, 0x02, BIT1);
+
+}
+
+void load_reg(int timing_value, int load_reg_num, struct io_register *reg, int io_type)
+{
+    int reg_mask;
+    int bit_num=0;
+    int data;
+    int i,j;
+    int shift_next_reg;
+    int start_index, end_index, cr_index;
+    u16 get_bit;
+
+
+
+    for (i=0; i<load_reg_num; i++)
+    {
+        reg_mask = 0;
+        data=0;
+        start_index = reg[i].start_bit;
+        end_index = reg[i].end_bit;
+        cr_index = reg[i].io_addr;
+
+        shift_next_reg = bit_num;
+        for(j=start_index;j<=end_index;j++)
+        {
+            reg_mask = reg_mask | (BIT0 << j);
+            get_bit = (timing_value & (BIT0 << bit_num));
+            data = data | ((get_bit >> shift_next_reg)<< start_index);
+            bit_num ++;
+        }
+        if (io_type == VIACR)
+        {
+            write_reg_mask(cr_index, VIACR, data, reg_mask);
+
+        }
+        else
+        {
+            write_reg_mask(cr_index, VIASR, data, reg_mask);
+        }
+
+    }
+
+}
+
+/* Write Registers */
+void write_regx(struct io_reg RegTable[],int ItemNum)
+{
+   int               i;
+   unsigned char     RegTemp;
+
+   for( i=0; i< ItemNum; i++ ){
+       outb( RegTable[i].index, RegTable[i].port );
+       RegTemp = inb(RegTable[i].port+1 );
+       RegTemp = ( RegTemp & ( ~RegTable[i].mask ) ) | RegTable[i].value ;
+       outb( RegTemp, RegTable[i].port+1 );
+   }
+}
+
+void load_offset_reg(int h_addr, int bpp_byte, int set_iga)
+{
+    int reg_value;
+    int load_reg_num;
+    struct io_register *reg;
+
+
+    switch(set_iga) {
+        case IGA1_IGA2:
+        case IGA1:
+            reg_value = IGA1_OFFSET_FORMULA(h_addr, bpp_byte);
+            load_reg_num = offset_reg.iga1_offset_reg.reg_num;
+            reg = offset_reg.iga1_offset_reg.reg;
+            load_reg(reg_value, load_reg_num, reg, VIACR);
+            if (set_iga == IGA1)
+                break;
+        case IGA2:
+            reg_value = IGA2_OFFSET_FORMULA(h_addr, bpp_byte);
+            load_reg_num = offset_reg.iga2_offset_reg.reg_num;
+            reg = offset_reg.iga2_offset_reg.reg;
+            load_reg(reg_value, load_reg_num, reg, VIACR);
+            break;
+    }
+}
+
+void load_fetch_count_reg(int h_addr, int bpp_byte, int set_iga)
+{
+    int reg_value;
+    int load_reg_num;
+    struct io_register *reg=NULL;
+
+    switch(set_iga) {
+        case IGA1_IGA2:
+        case IGA1:
+            reg_value = IGA1_FETCH_COUNT_FORMULA(h_addr, bpp_byte);
+            load_reg_num = fetch_count_reg.iga1_fetch_count_reg.reg_num;
+            reg = fetch_count_reg.iga1_fetch_count_reg.reg;
+            load_reg(reg_value, load_reg_num, reg, VIASR);
+            if (set_iga == IGA1)
+                break;
+        case IGA2:
+            reg_value = IGA2_FETCH_COUNT_FORMULA(h_addr, bpp_byte);
+            load_reg_num = fetch_count_reg.iga2_fetch_count_reg.reg_num;
+            reg = fetch_count_reg.iga2_fetch_count_reg.reg;
+            load_reg(reg_value, load_reg_num, reg, VIACR);
+            break;
+    }
+
+}
+
+
+void load_FIFO_reg(int set_iga, int hor_active, int ver_active)
+{
+    int reg_value;
+    int load_reg_num;
+    struct io_register *reg=NULL;
+    int iga1_fifo_max_depth=0, iga1_fifo_threshold=0, iga1_fifo_high_threshold=0, iga1_display_queue_expire_num=0;
+    int iga2_fifo_max_depth=0, iga2_fifo_threshold=0, iga2_fifo_high_threshold=0, iga2_display_queue_expire_num=0;
+
+
+    if (set_iga == IGA1)
+    {
+        if (chip_info.gfx_chip_name == UNICHROME_K800)
+        {
+            iga1_fifo_max_depth = K800_IGA1_FIFO_MAX_DEPTH;
+            iga1_fifo_threshold = K800_IGA1_FIFO_THRESHOLD;
+            iga1_fifo_high_threshold = K800_IGA1_FIFO_HIGH_THRESHOLD;
+            /* If resolution > 1280x1024, expire length = 64, else  expire length = 128 */
+            if ((hor_active > 1280) && (ver_active > 1024))
+                iga1_display_queue_expire_num = 16;
+            else
+                iga1_display_queue_expire_num = K800_IGA1_DISPLAY_QUEUE_EXPIRE_NUM;
+
+        }
+
+        if (chip_info.gfx_chip_name == UNICHROME_P880)
+        {
+            iga1_fifo_max_depth = P880_IGA1_FIFO_MAX_DEPTH;
+            iga1_fifo_threshold = P880_IGA1_FIFO_THRESHOLD;
+            iga1_fifo_high_threshold = P880_IGA1_FIFO_HIGH_THRESHOLD;
+            iga1_display_queue_expire_num = P880_IGA1_DISPLAY_QUEUE_EXPIRE_NUM;
+
+            /* If resolution > 1280x1024, expire length = 64, else  expire length = 128 */
+            if ((hor_active > 1280) && (ver_active > 1024))
+                iga1_display_queue_expire_num = 16;
+            else
+                iga1_display_queue_expire_num = P880_IGA1_DISPLAY_QUEUE_EXPIRE_NUM;
+        }
+        
+        if (chip_info.gfx_chip_name == UNICHROME_CN900)
+        {
+            iga1_fifo_max_depth = CN900_IGA1_FIFO_MAX_DEPTH;
+            iga1_fifo_threshold = CN900_IGA1_FIFO_THRESHOLD;
+            iga1_fifo_high_threshold = CN900_IGA1_FIFO_HIGH_THRESHOLD;
+
+            /* If resolution > 1280x1024, expire length = 64, else expire length = 128 */
+            if ((hor_active > 1280) && (ver_active > 1024))
+                iga1_display_queue_expire_num = 16;
+            else
+                iga1_display_queue_expire_num = CN900_IGA1_DISPLAY_QUEUE_EXPIRE_NUM;
+        }
+
+        /* Add for VT3324. */
+        if (chip_info.gfx_chip_name == UNICHROME_CX700)
+        {
+            iga1_fifo_max_depth = CX700_IGA1_FIFO_MAX_DEPTH;
+            iga1_fifo_threshold = CX700_IGA1_FIFO_THRESHOLD;
+            iga1_fifo_high_threshold = CX700_IGA1_FIFO_HIGH_THRESHOLD;
+            iga1_display_queue_expire_num = CX700_IGA1_DISPLAY_QUEUE_EXPIRE_NUM;
+        }
+
+        /*  Add for VT3327 VT3336 VT3364 */
+        if (chip_info.gfx_chip_name == UNICHROME_K8M890)
+        {
+            iga1_fifo_max_depth = K8M890_IGA1_FIFO_MAX_DEPTH;
+            iga1_fifo_threshold = K8M890_IGA1_FIFO_THRESHOLD;
+            iga1_fifo_high_threshold = K8M890_IGA1_FIFO_HIGH_THRESHOLD;
+            iga1_display_queue_expire_num = K8M890_IGA1_DISPLAY_QUEUE_EXPIRE_NUM;
+        }
+
+        if (chip_info.gfx_chip_name == UNICHROME_P4M890)
+        {
+            iga1_fifo_max_depth = P4M890_IGA1_FIFO_MAX_DEPTH;
+            iga1_fifo_threshold = P4M890_IGA1_FIFO_THRESHOLD;
+            iga1_fifo_high_threshold = P4M890_IGA1_FIFO_HIGH_THRESHOLD;
+            iga1_display_queue_expire_num = P4M890_IGA1_DISPLAY_QUEUE_EXPIRE_NUM;
+        }
+        
+        if (chip_info.gfx_chip_name == UNICHROME_P4M900)
+        {
+            iga1_fifo_max_depth = P4M900_IGA1_FIFO_MAX_DEPTH;
+            iga1_fifo_threshold =P4M900_IGA1_FIFO_THRESHOLD;
+            iga1_fifo_high_threshold = P4M900_IGA1_FIFO_HIGH_THRESHOLD;
+            iga1_display_queue_expire_num = P4M900_IGA1_DISPLAY_QUEUE_EXPIRE_NUM;
+        }
+        
+        /* Set Display FIFO Depath Select */
+        reg_value = IGA1_FIFO_DEPTH_SELECT_FORMULA(iga1_fifo_max_depth);
+        load_reg_num = display_fifo_depth_reg.iga1_fifo_depth_select_reg.reg_num;
+        reg = display_fifo_depth_reg.iga1_fifo_depth_select_reg.reg;
+        load_reg(reg_value, load_reg_num, reg, VIASR);
+
+        /* Set Display FIFO Threshold Select */
+        reg_value = IGA1_FIFO_THRESHOLD_FORMULA(iga1_fifo_threshold);
+        load_reg_num = fifo_threshold_select_reg.iga1_fifo_threshold_select_reg.reg_num;
+        reg = fifo_threshold_select_reg.iga1_fifo_threshold_select_reg.reg;
+        load_reg(reg_value, load_reg_num, reg, VIASR);
+
+        /* Set FIFO High Threshold Select */
+        reg_value = IGA1_FIFO_HIGH_THRESHOLD_FORMULA(iga1_fifo_high_threshold);
+        load_reg_num = fifo_high_threshold_select_reg.iga1_fifo_high_threshold_select_reg.reg_num;
+        reg = fifo_high_threshold_select_reg.iga1_fifo_high_threshold_select_reg.reg;
+        load_reg(reg_value, load_reg_num, reg, VIASR);
+
+        /* Set Display Queue Expire Num */
+        reg_value = IGA1_DISPLAY_QUEUE_EXPIRE_NUM_FORMULA(iga1_display_queue_expire_num);
+        load_reg_num = display_queue_expire_num_reg.iga1_display_queue_expire_num_reg.reg_num;
+        reg = display_queue_expire_num_reg.iga1_display_queue_expire_num_reg.reg;
+        load_reg(reg_value, load_reg_num, reg, VIASR);
+
+    }
+    else
+    {
+        if (chip_info.gfx_chip_name == UNICHROME_K800)
+        {
+            iga2_fifo_max_depth = K800_IGA2_FIFO_MAX_DEPTH;
+            iga2_fifo_threshold = K800_IGA2_FIFO_THRESHOLD;
+            iga2_fifo_high_threshold = K800_IGA2_FIFO_HIGH_THRESHOLD;
+
+            /* If resolution > 1280x1024, expire length = 64, else  expire length = 128 */
+            if ((hor_active > 1280) && (ver_active > 1024))
+                iga2_display_queue_expire_num = 16;
+            else
+                iga2_display_queue_expire_num = K800_IGA2_DISPLAY_QUEUE_EXPIRE_NUM;
+        }
+
+        if (chip_info.gfx_chip_name == UNICHROME_P880)
+        {
+            iga2_fifo_max_depth = P880_IGA2_FIFO_MAX_DEPTH;
+            iga2_fifo_threshold = P880_IGA2_FIFO_THRESHOLD;
+            iga2_fifo_high_threshold = P880_IGA2_FIFO_HIGH_THRESHOLD;
+
+            /* If resolution > 1280x1024, expire length = 64, else  expire length = 128 */
+            if ((hor_active > 1280) && (ver_active > 1024))
+                iga2_display_queue_expire_num = 16;
+            else
+                iga2_display_queue_expire_num = P880_IGA2_DISPLAY_QUEUE_EXPIRE_NUM;
+        }
+
+        if (chip_info.gfx_chip_name == UNICHROME_CN900)
+        {
+            iga2_fifo_max_depth = CN900_IGA2_FIFO_MAX_DEPTH;
+            iga2_fifo_threshold = CN900_IGA2_FIFO_THRESHOLD;
+            iga2_fifo_high_threshold = CN900_IGA2_FIFO_HIGH_THRESHOLD;
+
+            /* If resolution > 1280x1024, expire length = 64, else expire length = 128 */
+            if ((hor_active > 1280) && (ver_active > 1024))
+                iga2_display_queue_expire_num = 16;
+            else
+                iga2_display_queue_expire_num = CN900_IGA2_DISPLAY_QUEUE_EXPIRE_NUM;
+        }
+
+        /* Add for VT3324. */
+        if (chip_info.gfx_chip_name == UNICHROME_CX700)
+        {
+            iga2_fifo_max_depth = CX700_IGA2_FIFO_MAX_DEPTH;
+            iga2_fifo_threshold = CX700_IGA2_FIFO_THRESHOLD;
+            iga2_fifo_high_threshold = CX700_IGA2_FIFO_HIGH_THRESHOLD;
+            iga2_display_queue_expire_num = CX700_IGA2_DISPLAY_QUEUE_EXPIRE_NUM;
+        }
+
+         /* Add for VT3327 VT3336 VT3364 */
+        if (chip_info.gfx_chip_name == UNICHROME_K8M890)
+        {
+            iga2_fifo_max_depth = K8M890_IGA2_FIFO_MAX_DEPTH;
+            iga2_fifo_threshold = K8M890_IGA2_FIFO_THRESHOLD;
+            iga2_fifo_high_threshold = K8M890_IGA2_FIFO_HIGH_THRESHOLD;
+            iga2_display_queue_expire_num = K8M890_IGA2_DISPLAY_QUEUE_EXPIRE_NUM;
+        }
+
+        if (chip_info.gfx_chip_name == UNICHROME_P4M890)
+        {
+            iga2_fifo_max_depth = P4M890_IGA2_FIFO_MAX_DEPTH;
+            iga2_fifo_threshold = P4M890_IGA2_FIFO_THRESHOLD;
+            iga2_fifo_high_threshold = P4M890_IGA2_FIFO_HIGH_THRESHOLD;
+            iga2_display_queue_expire_num = P4M890_IGA2_DISPLAY_QUEUE_EXPIRE_NUM;
+        }
+
+        if (chip_info.gfx_chip_name == UNICHROME_P4M900)
+        {
+            iga2_fifo_max_depth = P4M900_IGA2_FIFO_MAX_DEPTH;
+            iga2_fifo_threshold = P4M900_IGA2_FIFO_THRESHOLD;
+            iga2_fifo_high_threshold = P4M900_IGA2_FIFO_HIGH_THRESHOLD;
+            iga2_display_queue_expire_num = P4M900_IGA2_DISPLAY_QUEUE_EXPIRE_NUM;
+        }        
+        
+        if (chip_info.gfx_chip_name == UNICHROME_K800)
+        {
+            /* Set Display FIFO Depath Select */
+            reg_value = IGA2_FIFO_DEPTH_SELECT_FORMULA(iga2_fifo_max_depth)-1; /* Patch LCD in IGA2 case */
+            load_reg_num = display_fifo_depth_reg.iga2_fifo_depth_select_reg.reg_num;
+            reg = display_fifo_depth_reg.iga2_fifo_depth_select_reg.reg;
+            load_reg(reg_value, load_reg_num, reg, VIACR);
+        }
+        else
+        {
+
+            /* Set Display FIFO Depath Select */
+            reg_value = IGA2_FIFO_DEPTH_SELECT_FORMULA(iga2_fifo_max_depth);
+            load_reg_num = display_fifo_depth_reg.iga2_fifo_depth_select_reg.reg_num;
+            reg = display_fifo_depth_reg.iga2_fifo_depth_select_reg.reg;
+            load_reg(reg_value, load_reg_num, reg, VIACR);
+        }
+
+        /* Set Display FIFO Threshold Select */
+        reg_value = IGA2_FIFO_THRESHOLD_FORMULA(iga2_fifo_threshold);
+        load_reg_num = fifo_threshold_select_reg.iga2_fifo_threshold_select_reg.reg_num;
+        reg = fifo_threshold_select_reg.iga2_fifo_threshold_select_reg.reg;
+        load_reg(reg_value, load_reg_num, reg, VIACR);
+
+        /* Set FIFO High Threshold Select */
+        reg_value = IGA2_FIFO_HIGH_THRESHOLD_FORMULA(iga2_fifo_high_threshold);
+        load_reg_num = fifo_high_threshold_select_reg.iga2_fifo_high_threshold_select_reg.reg_num;
+        reg = fifo_high_threshold_select_reg.iga2_fifo_high_threshold_select_reg.reg;
+        load_reg(reg_value, load_reg_num, reg, VIACR);
+
+        /* Set Display Queue Expire Num */
+        reg_value = IGA2_DISPLAY_QUEUE_EXPIRE_NUM_FORMULA(iga2_display_queue_expire_num);
+        load_reg_num = display_queue_expire_num_reg.iga2_display_queue_expire_num_reg.reg_num;
+        reg = display_queue_expire_num_reg.iga2_display_queue_expire_num_reg.reg;
+        load_reg(reg_value, load_reg_num, reg, VIACR);
+
+    }
+
+}
+
+u32 get_clk_value(int clk)
+{
+    int i;
+
+    for(i=0; i<NUM_TOTAL_PLL_TABLE; i++)
+    {
+        if(clk==pll_value[i].clk)
+        {
+            switch(chip_info.gfx_chip_name) 
+            {
+                case UNICHROME_CLE266:
+                case UNICHROME_K400:
+                    return(pll_value[i].cle266_pll);
+
+                case UNICHROME_K800:
+                case UNICHROME_P880:
+                case UNICHROME_CN900:
+                    return(pll_value[i].k800_pll);
+
+                /* Add for VT3324 VT3327 VT3336 VT3364 */
+                case UNICHROME_CX700:
+                case UNICHROME_K8M890:
+                case UNICHROME_P4M890:
+                case UNICHROME_P4M900:
+                    return (pll_value[i].cx700_pll);
+            }
+        }
+    }
+    
+    DEBUG_MSG(KERN_INFO "Can't find match PLL value\n\n");
+    return(0);
+}
+
+/* Set VCLK */
+void SetVCLK( u32 CLK, int set_iga )
+{
+    unsigned char RegTemp;
+
+    /* H.W. Reset : ON */
+    write_reg_mask(CR17, VIACR, 0x00, BIT7);
+
+    if ((set_iga==IGA1) || (set_iga==IGA1_IGA2))
+    {
+        /* Change D,N FOR VCLK */
+        switch(chip_info.gfx_chip_name)
+        {
+            case UNICHROME_CLE266:
+            case UNICHROME_K400:
+                write_reg(SR46, VIASR, CLK/0x100);
+                write_reg(SR47, VIASR, CLK%0x100);
+                break;
+
+            case UNICHROME_K800:
+            case UNICHROME_P880:
+            case UNICHROME_CN900:
+            case UNICHROME_CX700:  /* Add for VT3324 */
+            case UNICHROME_K8M890: /* Add for VT3336 */
+            case UNICHROME_P4M890: /* Add for VT3327 */
+            case UNICHROME_P4M900: /* Add for VT3364 */
+                write_reg(SR44, VIASR, CLK/0x10000);
+                DEBUG_MSG(KERN_INFO "\nSR44=%x", CLK/0x10000);
+                write_reg(SR45, VIASR, (CLK&0xFFFF)/0x100);
+                DEBUG_MSG(KERN_INFO "\nSR45=%x", (CLK&0xFFFF)/0x100);
+                write_reg(SR46, VIASR, CLK%0x100);
+                DEBUG_MSG(KERN_INFO "\nSR46=%x", CLK%0x100);
+                break;
+        }
+    }
+
+    if ((set_iga==IGA2) || (set_iga==IGA1_IGA2))
+    {
+        /* Change D,N FOR LCK */
+        switch(chip_info.gfx_chip_name)
+        {
+            case UNICHROME_CLE266:
+            case UNICHROME_K400:
+                write_reg(SR44, VIASR, CLK/0x100);
+                write_reg(SR45, VIASR, CLK%0x100);
+                break;
+
+            case UNICHROME_K800:
+            case UNICHROME_P880:
+            case UNICHROME_CN900:
+            case UNICHROME_CX700:  /* Add for VT3324 */
+            case UNICHROME_K8M890: /* Add for VT3336 */
+            case UNICHROME_P4M890: /* Add for VT3327 */
+            case UNICHROME_P4M900: /* Add for VT3364 */
+                write_reg(SR4A, VIASR, CLK/0x10000);
+                write_reg(SR4B, VIASR, (CLK&0xFFFF)/0x100);
+                write_reg(SR4C, VIASR, CLK%0x100);
+                break;
+        }
+    }
+
+    /* H.W. Reset : OFF */
+    write_reg_mask(CR17, VIACR, 0x80, BIT7);
+
+    /* Reset PLL */
+    if ((set_iga==IGA1) || (set_iga==IGA1_IGA2))
+    {
+        write_reg_mask(SR40, VIASR, 0x02, BIT1);
+        write_reg_mask(SR40, VIASR, 0x00, BIT1);
+    }
+
+    if ((set_iga==IGA2) || (set_iga==IGA1_IGA2))
+    {
+        write_reg_mask(SR40, VIASR, 0x01, BIT0);
+        write_reg_mask(SR40, VIASR, 0x00, BIT0);
+    }
+
+    /* Fire! */ 
+    RegTemp = inb(VIARMisc);
+    outb(RegTemp | (BIT2+BIT3),VIAWMisc);
+}
+
+void load_crtc_timing(struct display_timing device_timing, int set_iga)
+{
+    int i;
+    int load_reg_num=0;
+    int reg_value=0;
+    struct io_register *reg=NULL;
+    
+    unlock_crt();
+
+    for (i=0;i<12;i++)
+    {
+        if (set_iga == IGA1)
+        {
+            switch(i) {
+                case H_TOTAL_INDEX:
+                    reg_value = IGA1_HOR_TOTAL_FORMULA(device_timing.hor_total);
+                    load_reg_num = iga1_crtc_reg.hor_total.reg_num;
+                    reg = iga1_crtc_reg.hor_total.reg;
+                    break;
+                case H_ADDR_INDEX:
+                    reg_value = IGA1_HOR_ADDR_FORMULA(device_timing.hor_addr);
+                    load_reg_num = iga1_crtc_reg.hor_addr.reg_num;
+                    reg = iga1_crtc_reg.hor_addr.reg;
+                    break;
+                case H_BLANK_START_INDEX:
+                    reg_value = IGA1_HOR_BLANK_START_FORMULA(device_timing.hor_blank_start);
+                    load_reg_num = iga1_crtc_reg.hor_blank_start.reg_num;
+                    reg = iga1_crtc_reg.hor_blank_start.reg;
+                    break;
+                case H_BLANK_END_INDEX:
+                    reg_value = IGA1_HOR_BLANK_END_FORMULA(device_timing.hor_blank_start, device_timing.hor_blank_end);
+                    load_reg_num = iga1_crtc_reg.hor_blank_end.reg_num;
+                    reg = iga1_crtc_reg.hor_blank_end.reg;
+                    break;
+                case H_SYNC_START_INDEX:
+                    reg_value = IGA1_HOR_SYNC_START_FORMULA(device_timing.hor_sync_start);
+                    load_reg_num = iga1_crtc_reg.hor_sync_start.reg_num;
+                    reg = iga1_crtc_reg.hor_sync_start.reg;
+                    break;
+                case H_SYNC_END_INDEX:
+                    reg_value = IGA1_HOR_SYNC_END_FORMULA(device_timing.hor_sync_start, device_timing.hor_sync_end);
+                    load_reg_num = iga1_crtc_reg.hor_sync_end.reg_num;
+                    reg = iga1_crtc_reg.hor_sync_end.reg;
+                    break;
+                case V_TOTAL_INDEX:
+                    reg_value = IGA1_VER_TOTAL_FORMULA(device_timing.ver_total);
+                    load_reg_num = iga1_crtc_reg.ver_total.reg_num;
+                    reg = iga1_crtc_reg.ver_total.reg;
+                    break;
+                case V_ADDR_INDEX:
+                    reg_value = IGA1_VER_ADDR_FORMULA(device_timing.ver_addr);
+                    load_reg_num = iga1_crtc_reg.ver_addr.reg_num;
+                    reg = iga1_crtc_reg.ver_addr.reg;
+                    break;
+                case V_BLANK_START_INDEX:
+                    reg_value = IGA1_VER_BLANK_START_FORMULA(device_timing.ver_blank_start);
+                    load_reg_num = iga1_crtc_reg.ver_blank_start.reg_num;
+                    reg = iga1_crtc_reg.ver_blank_start.reg;
+                    break;
+                case V_BLANK_END_INDEX:
+                    reg_value = IGA1_VER_BLANK_END_FORMULA(device_timing.ver_blank_start, device_timing.ver_blank_end);
+                    load_reg_num = iga1_crtc_reg.ver_blank_end.reg_num;
+                    reg = iga1_crtc_reg.ver_blank_end.reg;
+                    break;
+                case V_SYNC_START_INDEX:
+                    reg_value = IGA1_VER_SYNC_START_FORMULA(device_timing.ver_sync_start);
+                    load_reg_num = iga1_crtc_reg.ver_sync_start.reg_num;
+                    reg = iga1_crtc_reg.ver_sync_start.reg;
+                    break;
+                case V_SYNC_END_INDEX:
+                    reg_value = IGA1_VER_SYNC_END_FORMULA(device_timing.ver_sync_start, device_timing.ver_sync_end);
+                    load_reg_num = iga1_crtc_reg.ver_sync_end.reg_num;
+                    reg = iga1_crtc_reg.ver_sync_end.reg;
+                    break;
+
+            }
+        }
+
+        if (set_iga == IGA2)
+        {
+            switch(i) {
+                case H_TOTAL_INDEX:
+                    reg_value = IGA2_HOR_TOTAL_FORMULA(device_timing.hor_total);
+                    load_reg_num = iga2_crtc_reg.hor_total.reg_num;
+                    reg = iga2_crtc_reg.hor_total.reg;
+                    break;
+                case H_ADDR_INDEX:
+                    reg_value = IGA2_HOR_ADDR_FORMULA(device_timing.hor_addr);
+                    load_reg_num = iga2_crtc_reg.hor_addr.reg_num;
+                    reg = iga2_crtc_reg.hor_addr.reg;
+                    break;
+                case H_BLANK_START_INDEX:
+                    reg_value = IGA2_HOR_BLANK_START_FORMULA(device_timing.hor_blank_start);
+                    load_reg_num = iga2_crtc_reg.hor_blank_start.reg_num;
+                    reg = iga2_crtc_reg.hor_blank_start.reg;
+                    break;
+                case H_BLANK_END_INDEX:
+                    reg_value = IGA2_HOR_BLANK_END_FORMULA(device_timing.hor_blank_start, device_timing.hor_blank_end);
+                    load_reg_num = iga2_crtc_reg.hor_blank_end.reg_num;
+                    reg = iga2_crtc_reg.hor_blank_end.reg;
+                    break;
+                case H_SYNC_START_INDEX:
+                    reg_value = IGA2_HOR_SYNC_START_FORMULA(device_timing.hor_sync_start);
+                    if(UNICHROME_CN900 <= chip_info.gfx_chip_name)
+                    {
+                        load_reg_num = iga2_crtc_reg.hor_sync_start.reg_num;
+                    }
+                    else
+                    {
+                        /* We should not set CR5D[7] for VT3123, VT3204, VT3205 and VT3259, 
+                           because HW didn't define this bit as Horizontal Retrace Start bit[11] 
+                           until VT3314 and later chip. */
+                        load_reg_num = 3;
+                    }
+                    reg = iga2_crtc_reg.hor_sync_start.reg;
+                    break;
+                case H_SYNC_END_INDEX:
+                    reg_value = IGA2_HOR_SYNC_END_FORMULA(device_timing.hor_sync_start, device_timing.hor_sync_end);
+                    load_reg_num = iga2_crtc_reg.hor_sync_end.reg_num;
+                    reg = iga2_crtc_reg.hor_sync_end.reg;
+                    break;
+                case V_TOTAL_INDEX:
+                    reg_value = IGA2_VER_TOTAL_FORMULA(device_timing.ver_total);
+                    load_reg_num = iga2_crtc_reg.ver_total.reg_num;
+                    reg = iga2_crtc_reg.ver_total.reg;
+                    break;
+                case V_ADDR_INDEX:
+                    reg_value = IGA2_VER_ADDR_FORMULA(device_timing.ver_addr);
+                    load_reg_num = iga2_crtc_reg.ver_addr.reg_num;
+                    reg = iga2_crtc_reg.ver_addr.reg;
+                    break;
+                case V_BLANK_START_INDEX:
+                    reg_value = IGA2_VER_BLANK_START_FORMULA(device_timing.ver_blank_start);
+                    load_reg_num = iga2_crtc_reg.ver_blank_start.reg_num;
+                    reg = iga2_crtc_reg.ver_blank_start.reg;
+                    break;
+                case V_BLANK_END_INDEX:
+                    reg_value = IGA2_VER_BLANK_END_FORMULA(device_timing.ver_blank_start, device_timing.ver_blank_end);
+                    load_reg_num = iga2_crtc_reg.ver_blank_end.reg_num;
+                    reg = iga2_crtc_reg.ver_blank_end.reg;
+                    break;
+                case V_SYNC_START_INDEX:
+                    reg_value = IGA2_VER_SYNC_START_FORMULA(device_timing.ver_sync_start);
+                    load_reg_num = iga2_crtc_reg.ver_sync_start.reg_num;
+                    reg = iga2_crtc_reg.ver_sync_start.reg;
+                    break;
+                case V_SYNC_END_INDEX:
+                    reg_value = IGA2_VER_SYNC_END_FORMULA(device_timing.ver_sync_start, device_timing.ver_sync_end);
+                    load_reg_num = iga2_crtc_reg.ver_sync_end.reg_num;
+                    reg = iga2_crtc_reg.ver_sync_end.reg;
+                    break;
+
+            }
+         }
+         load_reg(reg_value, load_reg_num, reg, VIACR);
+    }
+   
+    lock_crt();
+}
+
+void set_color_depth(int bpp_byte, int set_iga)
+{
+    if (set_iga == IGA1)
+    {
+        switch(bpp_byte) 
+        {
+            case MODE_8BPP:
+                write_reg_mask(SR15, VIASR, 0x22, 0x7E);
+                break;
+            case MODE_16BPP:
+                write_reg_mask(SR15, VIASR, 0xB6, 0xFE);
+                break;
+            case MODE_32BPP:
+                write_reg_mask(SR15, VIASR, 0xAE, 0xFE);
+                break;
+         }
+    }
+    else
+    {
+        switch(bpp_byte)
+        {
+            case MODE_8BPP:
+                write_reg_mask(CR67, VIACR, 0x00, BIT6+BIT7);
+                break;
+            case MODE_16BPP:
+                write_reg_mask(CR67, VIACR, 0x40, BIT6+BIT7);
+                break;
+            case MODE_32BPP:
+                write_reg_mask(CR67, VIACR, 0xC0, BIT6+BIT7);
+                break;
+        }
+    }
+}
+
+void fill_crtc_timing(struct crt_mode_table *crt_table, int mode_index, int bpp_byte, int set_iga)
+{
+    struct VideoModeTable *video_mode;
+    struct display_timing crt_reg;
+    int i;
+    int index=0;
+    int h_addr,v_addr;
+    u32 pll_D_N;
+
+
+    video_mode = &CLE266Modes[SearchModeSetting(mode_index)];
+
+    for(i=0;i<video_mode->mode_array;i++)
+    {
+        index = i;
+
+        if (crt_table[i].refresh_rate == crt_setting_info.refresh_rate)
+            break;
+    }
+
+    crt_reg = crt_table[index].crtc;
+
+    /* Mode 640x480 has border, but LCD/DFP didn't have border. */
+    /* So we would delete border. */    
+    if ((LCD_ON | DVI_ON) && (mode_index == VIA_RES_640X480) && (crt_setting_info.refresh_rate == 60))
+    {
+        /* The border is 8 pixels. */
+        crt_reg.hor_blank_start = crt_reg.hor_blank_start - 8;
+
+        /* Blanking time should add left and right borders. */
+        crt_reg.hor_blank_end = crt_reg.hor_blank_end + 16;
+    }
+    
+    h_addr = crt_reg.hor_addr;
+    v_addr = crt_reg.ver_addr;
+
+    /* update polarity for CRT timing */
+    if (crt_table[index].h_sync_polarity == NEGATIVE)
+    {
+        if (crt_table[index].v_sync_polarity == NEGATIVE)
+            outb((inb(VIARMisc) & (~(BIT6+BIT7))) | (BIT6+BIT7),VIAWMisc);
+        else
+            outb((inb(VIARMisc) & (~(BIT6+BIT7))) | (BIT6),VIAWMisc);
+    }
+    else
+    {
+        if (crt_table[index].v_sync_polarity == NEGATIVE)
+            outb((inb(VIARMisc) & (~(BIT6+BIT7))) | (BIT7),VIAWMisc);
+        else
+            outb((inb(VIARMisc) & (~(BIT6+BIT7))) ,VIAWMisc);                
+    }
+
+    if (set_iga == IGA1)
+    {
+        unlock_crt();
+        write_reg(CR09, VIACR, 0x00); /* initial CR09=0 */
+        write_reg_mask(CR11, VIACR, 0x00, BIT4+BIT5+BIT6);
+        write_reg_mask(CR17, VIACR, 0x00, BIT7);
+    }
+
+    switch(set_iga) {
+        case IGA1:
+            load_crtc_timing(crt_reg, IGA1);
+            break;
+        case IGA2:
+            load_crtc_timing(crt_reg, IGA2);
+            break;
+    }
+
+    load_fix_bit_crtc_reg();
+    lock_crt();
+    write_reg_mask(CR17, VIACR, 0x80, BIT7);
+    load_offset_reg(h_addr, bpp_byte, set_iga);
+    load_fetch_count_reg(h_addr, bpp_byte, set_iga);
+
+    /* load FIFO */
+    if ( (chip_info.gfx_chip_name != UNICHROME_CLE266) && (chip_info.gfx_chip_name != UNICHROME_K400))
+        load_FIFO_reg(set_iga, h_addr, v_addr);
+
+    /* load SR Register About Memory and Color part */
+    set_color_depth(bpp_byte, set_iga);    
+
+    pll_D_N = get_clk_value(crt_table[index].clk);
+    DEBUG_MSG( KERN_INFO "PLL=%x", pll_D_N);
+    SetVCLK(pll_D_N, set_iga);
+
+}
+
+struct display_timing get_timing_value(struct crt_mode_table *crt_table, int mode_index)
+{
+    struct VideoModeTable *video_mode;
+    struct display_timing crt_reg;
+    int i;
+    int index=0;
+
+    video_mode = &CLE266Modes[SearchModeSetting(mode_index)];
+
+    for(i=0;i<video_mode->mode_array;i++)
+    {
+       index = i;
+
+       if (crt_table[i].refresh_rate == crt_setting_info.refresh_rate)
+       break;
+    }
+
+    crt_reg = crt_table[index].crtc;
+    return(crt_reg);
+}
+
+void init_chip_info(void)
+{
+    init_gfx_chip_info();
+    init_tv_chip_info();
+    init_tmds_chip_info();
+    init_lvds_chip_info();
+
+    crt_setting_info.iga_path = IGA1;
+    crt_setting_info.refresh_rate = refresh;
+
+
+    /* Set IGA path for each device */
+    set_iga_path();
+    if(tv_level > 2)
+    {
+        tv_level = 0;
+        WARN_MSG(KERN_WARNING "Invalid tv_level value, will use defalt value 0\n");
+    }
+    tv_setting_info.level = tv_level;
+    tv_setting_info.system = tv_system;
+    tv_setting_info.out_signal = tv_out_signal;
+    tv_setting_info.dedotcrawl = tv_dedotcrawl;
+
+
+    lvds_setting_info.display_method=lcd_dsp_method;
+    lvds_setting_info.get_lcd_size_method = GET_LCD_SIZE_BY_USER_SETTING;
+    lvds_setting_info.lcd_mode=lcd_mode;
+    lvds_setting_info2.display_method = lvds_setting_info.display_method; /* default */
+    lvds_setting_info2.lcd_mode = lvds_setting_info.lcd_mode;
+
+    DEBUG_MSG(KERN_INFO "TV= %2d\n", chip_info.tv_chip_info.tv_chip_name);
+    DEBUG_MSG(KERN_INFO "TV_SLAVE_ADDR= %2d\n", chip_info.tv_chip_info.tv_chip_slave_addr);
+}
+
+void update_device_setting(int hres, int vres, int bpp, int vmode_refresh,int flag)
+{
+    if(flag==0)
+    {
+        crt_setting_info.h_active = hres;
+        crt_setting_info.v_active = vres;
+        crt_setting_info.bpp = bpp;
+        crt_setting_info.refresh_rate = vmode_refresh;
+
+        tv_setting_info.h_active = hres;
+        tv_setting_info.v_active = vres;
+        tv_setting_info.bpp = bpp;
+
+        tmds_setting_info.h_active = hres;
+        tmds_setting_info.v_active = vres;
+        tmds_setting_info.bpp = bpp;
+        tmds_setting_info.refresh_rate = vmode_refresh;
+
+        lvds_setting_info.h_active = hres;
+        lvds_setting_info.v_active = vres;
+        lvds_setting_info.bpp = bpp;
+        lvds_setting_info.refresh_rate = vmode_refresh;
+        lvds_setting_info2.h_active = hres;
+        lvds_setting_info2.v_active = vres;
+        lvds_setting_info2.bpp = bpp;
+        lvds_setting_info2.refresh_rate = vmode_refresh;
+    }
+    else
+    {
+        if(tv_setting_info.iga_path == IGA2)
+        {
+            tv_setting_info.h_active = hres;
+            tv_setting_info.v_active = vres;
+            tv_setting_info.bpp = bpp;
+        }
+    
+        if(tmds_setting_info.iga_path == IGA2)
+        {
+            tmds_setting_info.h_active = hres;
+            tmds_setting_info.v_active = vres;
+            tmds_setting_info.bpp = bpp;
+            tmds_setting_info.refresh_rate = vmode_refresh;
+        }
+
+        if(lvds_setting_info.iga_path == IGA2)
+        {
+            lvds_setting_info.h_active = hres;
+            lvds_setting_info.v_active = vres;
+            lvds_setting_info.bpp = bpp;
+            lvds_setting_info.refresh_rate = vmode_refresh;
+        }
+        if(IGA2 == lvds_setting_info2.iga_path)
+        {
+            lvds_setting_info2.h_active = hres;
+            lvds_setting_info2.v_active = vres;
+            lvds_setting_info2.bpp = bpp;
+            lvds_setting_info2.refresh_rate = vmode_refresh;
+        }
+    }
+}
+
+void init_gfx_chip_info(void)
+{
+    struct pci_dev *pdev=NULL;
+    u8     tmp;
+
+    /* Indentify GFX Chip Name */
+    pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_CLE266_DID, NULL);
+    if (pdev != NULL)
+        chip_info.gfx_chip_name = UNICHROME_CLE266;
+
+    pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_K400_DID, NULL);
+    if (pdev != NULL)
+        chip_info.gfx_chip_name = UNICHROME_K400;
+
+    pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_K800_DID, NULL);
+    if (pdev != NULL)
+        chip_info.gfx_chip_name = UNICHROME_K800;
+
+    pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_P880_DID, NULL);
+    if (pdev != NULL)
+        chip_info.gfx_chip_name = UNICHROME_P880;
+
+    pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_CN900_DID, NULL);
+    if (pdev != NULL)
+        chip_info.gfx_chip_name = UNICHROME_CN900;
+
+    /* Add for VT3324. */
+    pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_CX700_DID, NULL);
+    if (pdev != NULL)
+    {
+        chip_info.gfx_chip_name = UNICHROME_CX700;
+    }
+
+    /* Add for VT3327 VT3336 VT3364 */
+    pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_K8M890_DID, NULL);
+    if (pdev != NULL)
+    {
+        chip_info.gfx_chip_name = UNICHROME_K8M890;
+    }
+
+    pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_P4M890_DID, NULL);
+    if (pdev != NULL)
+    {
+        chip_info.gfx_chip_name = UNICHROME_P4M890;
+    }
+
+    pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_P4M900_DID, NULL);
+    if (pdev != NULL)
+    {
+        chip_info.gfx_chip_name = UNICHROME_P4M900;
+    }
+    
+    /* Check revision of CLE266 Chip */
+    if (chip_info.gfx_chip_name == UNICHROME_CLE266)
+    {
+        /* CR4F only define in CLE266.CX chip */
+        tmp = read_reg(VIACR, CR4F);
+        write_reg(CR4F, VIACR, 0x55);
+        if (read_reg(VIACR,CR4F)!=0x55)
+            chip_info.gfx_chip_revision = CLE266_REVISION_AX;
+        else
+            chip_info.gfx_chip_revision = CLE266_REVISION_CX;
+
+        write_reg(CR4F, VIACR, tmp);           /* restore orignal CR4F value */
+    }
+
+    /* Check revision of CX700 Chip */
+    if (UNICHROME_CX700 == chip_info.gfx_chip_name)
+    {
+        tmp = read_reg(VIASR, SR43);
+        DEBUG_MSG(KERN_INFO  "SR43:%X\n", tmp);
+        if(tmp & 0x02)
+        {
+            chip_info.gfx_chip_revision = CX700_REVISION_700M2;
+        }
+        else if(tmp & 0x40)
+        {
+            chip_info.gfx_chip_revision = CX700_REVISION_700M;
+        }
+        else
+        {
+            chip_info.gfx_chip_revision = CX700_REVISION_700;
+        }            
+    }
+}
+
+
+
+void init_tv_chip_info(void)
+{
+    u8      data;
+    bool    IsMobile = FALSE;
+
+    data = read_reg(VIASR, SR12) & BIT5; /* HW strapping: 0: TV on AMR 1: TV on AGP */
+    
+    if (chip_info.tv_chip_info.output_interface == INTERFACE_NONE)    
+    {        
+        /* To know if current chip are mobile. */
+        lcd_get_mobile_state(&IsMobile);
+
+        /* External TV on VT3324 uses AMR slot. */
+        if ((chip_info.gfx_chip_name == UNICHROME_CLE266) || 
+            (chip_info.gfx_chip_name == UNICHROME_CX700) ||
+            (data == 0x20))
+        {
+            chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AMR;
+            switch(chip_info.gfx_chip_name)
+            {
+             case UNICHROME_CX700:
+                         chip_info.tv_chip_info.output_interface = INTERFACE_DVP1;
+                         break;
+                    default:
+                         chip_info.tv_chip_info.output_interface = INTERFACE_DVP0;
+                         break;
+            }
+        }
+        else if(chip_info.gfx_chip_name == UNICHROME_CX700)
+        {
+            chip_info.tv_chip_info.output_interface = INTERFACE_NONE;
+        }
+        else
+        {
+            chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AGP;
+            
+            if (IsMobile)
+                chip_info.tv_chip_info.output_interface = INTERFACE_DVP1;
+            else
+                chip_info.tv_chip_info.output_interface = INTERFACE_DFP_HIGH;
+        }
+    }
+    else
+    {
+        if ((chip_info.gfx_chip_name == UNICHROME_CLE266) || 
+            (chip_info.gfx_chip_name == UNICHROME_CX700) ||
+            (data == 0x20))
+        {
+            chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AMR;
+        }
+        else
+        {
+            chip_info.tv_chip_info.tv_chip_on_slot = TV_ON_AGP;
+        }
+    }
+    
+    tv_encoder_identify();
+    DEBUG_MSG(KERN_INFO "init_tv_chip_info,  chip_name:%d,out_interface:%d\n", chip_info.tv_chip_info.tv_chip_name, chip_info.tv_chip_info.output_interface);
+}
+
+void init_tmds_chip_info(void)
+{
+    if(INTERFACE_NONE == chip_info.tmds_chip_info.output_interface)
+    {
+        switch(chip_info.gfx_chip_name)
+        {
+            /* Add for VT3324 integrated TMDS. */
+            case UNICHROME_CX700:
+                /* Not always support intergrated TMDS now,
+                   we should check support by hardware layout. */
+                if ((display_hardware_layout == HW_LAYOUT_DVI_ONLY) ||
+                    (display_hardware_layout == HW_LAYOUT_LCD_DVI))
+                {
+                    chip_info.tmds_chip_info.output_interface = INTERFACE_TMDS;
+                }
+                else
+                {
+                    chip_info.tmds_chip_info.output_interface = INTERFACE_NONE;
+                }
+                break;
+            /* Add for support VT3327 VT3336 VT3364 */
+            case UNICHROME_K8M890:
+            case UNICHROME_P4M900:
+            case UNICHROME_P4M890:
+                /* TMDS on PCIE, we set DFPLOW as default. */
+                chip_info.tmds_chip_info.output_interface = INTERFACE_DFP_LOW;
+                break;
+            default:
+                chip_info.tmds_chip_info.output_interface = INTERFACE_DVP1;
+        }
+    }
+    tmds_trasmitter_identify();
+    DEBUG_MSG(KERN_INFO "TMDS Chip = %d\n", chip_info.tmds_chip_info.tmds_chip_name);
+    init_dvi_size();
+}
+
+void init_lvds_chip_info(void)
+{
+    if(lcd_panel_id > LCD_PANEL_ID_MAXIMUM)
+        lvds_setting_info.get_lcd_size_method = GET_LCD_SIZE_BY_VGA_BIOS;    
+    else
+        lvds_setting_info.get_lcd_size_method = GET_LCD_SIZE_BY_USER_SETTING;
+  
+    lvds_trasmitter_identify();
+    init_lcd_size();
+    init_lvds_output_interface(&chip_info.lvds_chip_info, &lvds_setting_info);
+    if(chip_info.lvds_chip_info2.lvds_chip_name)
+    {
+        init_lvds_output_interface(&chip_info.lvds_chip_info2, &lvds_setting_info2);
+    }
+    /* If CX700,two singel LCD, we need to reassign LCD interface to different LVDS port */
+     if((UNICHROME_CX700 == chip_info.gfx_chip_name) && (HW_LAYOUT_LCD1_LCD2 == display_hardware_layout))
+    {
+        if((INTEGRATED_LVDS == chip_info.lvds_chip_info.lvds_chip_name) && (INTEGRATED_LVDS == chip_info.lvds_chip_info2.lvds_chip_name))
+        {
+            chip_info.lvds_chip_info.output_interface = INTERFACE_LVDS0;
+            chip_info.lvds_chip_info2.output_interface = INTERFACE_LVDS1;
+        }
+    }
+
+    DEBUG_MSG(KERN_INFO "LVDS Chip = %d\n", chip_info.lvds_chip_info.lvds_chip_name);
+    DEBUG_MSG(KERN_INFO "LVDS1 output_interface = %d\n", chip_info.lvds_chip_info.output_interface);
+    DEBUG_MSG(KERN_INFO "LVDS2 output_interface = %d\n", chip_info.lvds_chip_info2.output_interface); 
+}
+
+void init_dac(int set_iga)
+{
+    int i;
+    u8 tmp;
+
+    if (set_iga == IGA1)
+    {
+        write_reg_mask(SR1A, VIASR, 0x00, BIT0);        /* access Primary Display's LUT */
+        write_reg_mask(SR1B, VIASR, 0x00, BIT7+BIT6);   /* turn off LCK */
+        for(i=0; i<256; i++)
+        {
+            write_dac_reg(i, palLUT_table[i].red, palLUT_table[i].green, palLUT_table[i].blue);
+        }
+
+        write_reg_mask(SR1B, VIASR, 0xC0, BIT7+BIT6);   /* turn on LCK */
+    }
+    else
+    {
+        tmp=read_reg(VIACR, CR6A);
+        write_reg_mask(CR6A, VIACR, 0x40, BIT6);
+        write_reg_mask(SR1A, VIASR, 0x01, BIT0);        /* access Secondary Display's LUT */
+        for(i=0; i<256; i++)
+        {
+            write_dac_reg(i, palLUT_table[i].red, palLUT_table[i].green, palLUT_table[i].blue);
+        }
+       write_reg_mask(SR1A, VIASR, 0x00, BIT0);        /* set IGA1 DAC for default */
+       write_reg(CR6A, VIACR, tmp);
+    }
+}
+
+
+void device_screen_off(void)
+{
+    write_reg_mask(SR01, VIASR, 0x20, BIT5);   /* turn off CRT screen (IGA1) */
+}
+
+void device_screen_on(void)
+{
+    write_reg_mask(SR01, VIASR, 0x00, BIT5);   /* turn on CRT screen (IGA1) */
+}
+
+void set_display_channel(void)
+{
+    /* If LCD2_ON, on cx700, internal lvds's information is keeped on lvds_setting_info2 */
+    if(LCD2_ON && lvds_setting_info2.LCDDualEdge)
+    {
+        /* For dual channel LCD: */
+        /* Set to Dual LVDS channel. */
+        write_reg_mask(CRD2, VIACR, 0x20, BIT4+BIT5);
+    }
+    else if (LCD_ON && DVI_ON)
+    {
+        /* For LCD+DFP: */
+        /* Set to LVDS1 + TMDS channel. */
+        write_reg_mask(CRD2, VIACR, 0x10, BIT4+BIT5);
+    }
+    else if (DVI_ON)
+    {
+        /* Set to single TMDS channel. */
+        write_reg_mask(CRD2, VIACR, 0x30, BIT4+BIT5);
+    }
+    else if (LCD_ON)
+    {
+        if (lvds_setting_info.LCDDualEdge)
+        {
+            /* For dual channel LCD: */
+            /* Set to Dual LVDS channel. */
+            write_reg_mask(CRD2, VIACR, 0x20, BIT4+BIT5);
+        }
+        else
+        {
+            /* Set to LVDS0 + LVDS1 channel. */
+            write_reg_mask(CRD2, VIACR, 0x00, BIT4+BIT5);
+        }
+    }
+}
+
+#define NUM_TOTAL_CLE266_ModeXregs ARRAY_SIZE(CLE266_ModeXregs)
+
+int setmode(int vmode_index,int hor_res,int ver_res,int video_bpp,
+ int vmode_index1,int hor_res1,int ver_res1,int video_bpp1)
+{
+    int i,j;
+    int port;
+    u8 value,index,mask;
+    struct VideoModeTable  *vmode_tbl;
+    struct crt_mode_table  *crt_timing;
+    struct VideoModeTable  *vmode_tbl1=NULL;
+    struct crt_mode_table  *crt_timing1=NULL; 
+
+    DEBUG_MSG(KERN_INFO "Set Mode!!\n");
+    DEBUG_MSG(KERN_INFO "vmode_index=%d hor_res=%d ver_res=%d video_bpp=%d\n", vmode_index, hor_res, ver_res, video_bpp);
+
+    device_screen_off();
+    vmode_tbl = &CLE266Modes[SearchModeSetting(vmode_index)];
+    crt_timing = vmode_tbl->crtc;
+
+    if(SAMM_ON==1)
+    {
+        vmode_tbl1 = &CLE266Modes[SearchModeSetting(vmode_index1)];
+        crt_timing1 = vmode_tbl1->crtc;
+    }
+
+    inb(VIAStatus);
+    outb(0x00,VIAAR);
+
+    /* Write Common Setting for Video Mode */
+    switch(chip_info.gfx_chip_name)
+    {   
+        case UNICHROME_CLE266:
+            write_regx(CLE266_ModeXregs, NUM_TOTAL_CLE266_ModeXregs);
+            break;
+
+        case UNICHROME_K400:
+            write_regx(KM400_ModeXregs, NUM_TOTAL_KM400_ModeXregs);
+            break;
+
+        case UNICHROME_K800:
+        case UNICHROME_P880:
+            write_regx(CN400_ModeXregs, NUM_TOTAL_CN400_ModeXregs);
+            break;
+
+        case UNICHROME_CN900:
+        case UNICHROME_K8M890:/* Add for VT3336*/
+        case UNICHROME_P4M890:/* Add for VT3327*/
+        case UNICHROME_P4M900:/* Add for VT3364*/
+            write_regx(CN900_ModeXregs, NUM_TOTAL_CN900_ModeXregs);
+            break;
+
+        /* Add for VT3324 */
+        case UNICHROME_CX700:
+            write_regx(CX700_ModeXregs, NUM_TOTAL_CX700_ModeXregs);
+            break;            
+    }
+
+    device_off();
+    
+    /* Fill VPIT Parameters */
+    /* Write Misc Register */
+    outb(VPIT.Misc, VIAWMisc);
+
+    /* Write Sequencer */
+    for ( i=1; i<=StdSR ; i++ )
+    {
+        outb(i, VIASR);
+        outb(VPIT.SR[i-1], VIASR+1);
+    }
+
+    set_start_addr();
+    set_iga_path();
+
+    /* Write CRTC */
+    fill_crtc_timing(crt_timing, vmode_index, video_bpp/8, IGA1);
+
+    /* Write Graphic Controller */
+    for ( i=0; i<StdGR ; i++ )
+    {
+        outb(i, VIAGR);
+        outb(VPIT.GR[i], VIAGR+1);
+    }
+
+    /* Write Attribute Controller */
+    for ( i=0; i<StdAR ; i++ )
+    {
+        inb(VIAStatus);
+        outb(i, VIAAR);
+        outb(VPIT.AR[i], VIAAR);
+    }
+
+    inb(VIAStatus);
+    outb(0x20,VIAAR);
+
+    /* Update Patch Register */
+
+    if ((chip_info.gfx_chip_name == UNICHROME_CLE266) || (chip_info.gfx_chip_name == UNICHROME_K400))
+    {
+        for( i=0; i< NUM_TOTAL_PATCH_MODE; i++ )
+        {
+            if (res_patch_table[i].mode_index==vmode_index)
+            {
+                for(j=0; j<res_patch_table[i].table_length; j++)
+                {
+                    index = res_patch_table[i].io_reg_table[j].index;
+                    port = res_patch_table[i].io_reg_table[j].port;
+                    value = res_patch_table[i].io_reg_table[j].value;
+                    mask = res_patch_table[i].io_reg_table[j].mask ;
+                    write_reg_mask(index, port, value, mask);
+                }
+            }
+        }
+    }
+
+    if(SAMM_ON == 1)
+    {
+        if ((chip_info.gfx_chip_name == UNICHROME_CLE266) || (chip_info.gfx_chip_name == UNICHROME_K400))
+        {
+            for( i=0; i< NUM_TOTAL_PATCH_MODE; i++ )
+            {
+                if (res_patch_table[i].mode_index==vmode_index1)
+                {
+                    for(j=0; j<res_patch_table[i].table_length; j++)
+                    {
+                        index = res_patch_table[i].io_reg_table[j].index;
+                        port = res_patch_table[i].io_reg_table[j].port;
+                        value = res_patch_table[i].io_reg_table[j].value;
+                        mask = res_patch_table[i].io_reg_table[j].mask ;
+                        write_reg_mask(index, port, value, mask);
+                    }
+                }
+            }
+        }
+    }
+
+    /* Update Refresh Rate Setting */
+
+    /* Clear On Screen */
+    
+    /* CRT set mode */
+    if (CRT_ON)
+    {
+        if (SAMM_ON && (crt_setting_info.iga_path == IGA2))
+        {
+            fill_crtc_timing(crt_timing1, vmode_index1, video_bpp1/8, crt_setting_info.iga_path);            
+        }
+        else
+        {
+            fill_crtc_timing(crt_timing, vmode_index, video_bpp/8, crt_setting_info.iga_path);            
+        }
+        
+        set_crt_output_path(crt_setting_info.iga_path);
+
+        /* Patch if set_hres is not 8 alignment (1366) to setmode to 8 alignment (1368),
+           there is several pixels (2 pixels) on right side of screen. */
+        if (hor_res%8)
+        {
+            unlock_crt();
+            write_reg(CR02, VIACR, read_reg(VIACR, CR02)-1);
+            lock_crt();
+        }
+    }
+
+    if (TV_ON)
+    {
+        if(SAMM_ON && (tv_setting_info.iga_path == IGA2))
+        {
+            tv_set_mode(vmode_index1);
+        }
+        else
+        {
+            tv_set_mode(vmode_index);
+        }
+    }
+
+    if (DVI_ON)
+    {
+        if(SAMM_ON && (tmds_setting_info.iga_path == IGA2))
+        {
+            dvi_set_mode(crt_timing1, vmode_index1, video_bpp1, tmds_setting_info.iga_path);
+        }
+        else
+        {
+            dvi_set_mode(crt_timing, vmode_index, video_bpp, tmds_setting_info.iga_path);
+        }
+    }
+
+    if (LCD_ON)
+    {
+        if(SAMM_ON && (lvds_setting_info.iga_path == IGA2))
+        {
+            lvds_setting_info.bpp = video_bpp1;
+            lcd_set_mode(crt_timing1, &lvds_setting_info, &chip_info.lvds_chip_info);
+        }
+        else
+        {
+            /* IGA1 doesn't have LCD scaling, so set it as centering. */
+            if (lvds_setting_info.iga_path == IGA1)
+            {
+                lvds_setting_info.display_method = LCD_CENTERING;
+            }
+            lvds_setting_info.bpp = video_bpp;
+            lcd_set_mode(crt_timing, &lvds_setting_info, &chip_info.lvds_chip_info);
+        }
+    }
+    if(LCD2_ON)
+    {
+        if(SAMM_ON && (lvds_setting_info2.iga_path == IGA2))
+        {
+            lvds_setting_info2.bpp = video_bpp1;
+            lcd_set_mode(crt_timing1, &lvds_setting_info2, &chip_info.lvds_chip_info2);
+        }
+        else
+        {
+            /* IGA1 doesn't have LCD scaling, so set it as centering. */
+            if (lvds_setting_info2.iga_path == IGA1)
+            {
+                lvds_setting_info2.display_method = LCD_CENTERING;
+            }
+            lvds_setting_info2.bpp = video_bpp;
+            lcd_set_mode(crt_timing, &lvds_setting_info2, &chip_info.lvds_chip_info2);
+        }
+    }
+
+    /* Add for VT3324 */
+    if ((chip_info.gfx_chip_name == UNICHROME_CX700) && (LCD_ON || DVI_ON))
+    {
+        set_display_channel();
+    }
+
+    /* If set mode normally, save resolution information for hot-plug using. */
+    if(!HotPlug) 
+    {
+        HotPlug_Xres = hor_res;
+        HotPlug_Yres = ver_res;
+        HotPlug_bpp = video_bpp;
+        HotPlug_refresh = refresh;
+
+        if(DVI_ON) 
+        {
+            DeviceStatus = DVI_Device;
+        }
+        else if(TV_ON)
+        {
+            DeviceStatus = TV_Device;
+        }
+        else
+        {
+            DeviceStatus = CRT_Device;
+        }
+    }
+
+    device_on();
+
+    if(SAMM_ON == 1)
+    {
+     write_reg_mask(CR6A, VIACR, 0xC0, BIT6+BIT7);
+    }
+    
+    device_screen_on();
+
+    return 1;
+}
+
+int get_pixclock(int hres, int vres, int vmode_refresh)
+{
+  int i;
+
+  for(i=0; i<NUM_TOTAL_RES_MAP_REFRESH; i++)
+  {
+      if((hres==res_map_refresh_tbl[i].hres) && (vres==res_map_refresh_tbl[i].vres) && (vmode_refresh == res_map_refresh_tbl[i].vmode_refresh))
+          return(res_map_refresh_tbl[i].pixclock);
+  }
+  return(RES_640X480_60HZ_PIXCLOCK);
+
+}
+
+int get_refresh(int hres, int vres, int pixclock)
+{
+  int i;
+  for(i=0; i<NUM_TOTAL_RES_MAP_REFRESH; i++)
+  {
+      if((hres==res_map_refresh_tbl[i].hres) && (vres==res_map_refresh_tbl[i].vres) && (pixclock == res_map_refresh_tbl[i].pixclock))
+          return(res_map_refresh_tbl[i].vmode_refresh);
+  }
+  return(60);
+}
+
+void device_off(void)
+{
+    crt_disable();
+    tv_disable();
+    dvi_disable();
+    lcd_disable();
+}
+
+void device_on(void)
+{
+    if (CRT_ON==1){
+        crt_enable();
+    }
+    if (TV_ON==1){
+        tv_enable();
+    }
+    if (DVI_ON==1){
+        dvi_enable();
+    }
+    if (LCD_ON==1){
+        lcd_enable();
+    }
+}
+
+void crt_disable(void)
+{
+    write_reg_mask(CR36, VIACR, BIT5+BIT4, BIT5+BIT4);
+}
+
+void crt_enable(void)
+{
+    write_reg_mask(CR36, VIACR, 0x0, BIT5+BIT4);
+}
+
+void get_mmio_info(unsigned long *mmio_base, unsigned long *mmio_len)
+{
+    struct pci_dev *pdev = NULL;
+
+    switch(chip_info.gfx_chip_name)
+    {
+        case UNICHROME_CLE266:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_CLE266_DID, NULL);
+            break;
+
+        case UNICHROME_K400:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_K400_DID, NULL);
+            break;
+
+        case UNICHROME_K800:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_K800_DID, NULL);
+            break;
+
+        case UNICHROME_P880:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_P880_DID, NULL);
+            break;
+
+        case UNICHROME_CN900:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_CN900_DID, NULL);
+            break;
+
+        case UNICHROME_CX700:   /* Add for VT3324. */
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_CX700_DID, NULL);
+            break;
+            
+        /* Add for VT3327 VT3336 VT3364 */
+        case UNICHROME_K8M890:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_K8M890_DID, NULL);
+            break;
+            
+        case UNICHROME_P4M890:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_P4M890_DID, NULL);
+            break;
+
+        case UNICHROME_P4M900:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_P4M900_DID, NULL);
+            break;    
+    }
+
+    if(pdev != NULL)
+    {
+        *mmio_base = pci_resource_start(pdev, 1);
+        *mmio_len = pci_resource_len(pdev, 1);
+    }
+    else
+    {
+        *mmio_base = 0;
+        *mmio_len = 0;
+    }
+
+}
+
+void enable_second_display_channel(void)
+{
+    /* It's better to use the following sequence to enable second display channel. */
+    write_reg_mask(CR6A, VIACR, 0x00, BIT6);
+    write_reg_mask(CR6A, VIACR, BIT7, BIT7);
+    write_reg_mask(CR6A, VIACR, BIT6, BIT6);
+}
+
+void disable_second_display_channel(void)
+{
+    /* It's better to use the following sequence to disable second display channel. */
+    write_reg_mask(CR6A, VIACR, 0x00, BIT6);
+    write_reg_mask(CR6A, VIACR, 0x00, BIT7);
+    write_reg_mask(CR6A, VIACR, BIT6, BIT6);
+}
+
+void plus_vck_to_iga1_timing(unsigned long h_total)
+{
+    /* Clear first. */
+    write_reg_mask (CR47, VIACR, 0x00, BIT7+BIT6+BIT3);
+    
+    switch (h_total % 8)
+    {
+        case 2:
+        {
+            write_reg_mask (CR47, VIACR, BIT7, BIT7);
+            break;
+        }
+        
+        case 4:
+        {
+            write_reg_mask (CR47, VIACR, BIT6, BIT6);
+            break;
+        }
+        
+        case 6:
+        {
+            write_reg_mask (CR47, VIACR, BIT3, BIT3);
+            break;
+        }
+        
+        default:
+        {
+            break;
+        }
+    }
+}
+
+/* Add for get FB info from PCI system */
+void get_fb_info(unsigned int *fb_base, unsigned int *fb_len)
+{
+struct pci_dev *pdev = NULL;
+
+    switch(chip_info.gfx_chip_name)
+    {
+        case UNICHROME_CLE266:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_CLE266_DID, NULL);
+            break;
+
+        case UNICHROME_K400:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_K400_DID, NULL);
+            break;
+
+        case UNICHROME_K800:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_K800_DID, NULL);
+            break;
+
+        case UNICHROME_P880:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_P880_DID, NULL);
+            break;
+
+        case UNICHROME_CN900:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_CN900_DID, NULL);
+            break;
+
+        case UNICHROME_CX700: 
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_CX700_DID, NULL);
+            break;
+            
+        case UNICHROME_K8M890:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_K8M890_DID, NULL);
+            break;
+            
+        case UNICHROME_P4M890:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_P4M890_DID, NULL);
+            break;
+
+        case UNICHROME_P4M900:
+            pdev = (struct pci_dev *)pci_find_device(PCI_VIA_VENDOR_ID, UNICHROME_P4M900_DID, NULL);
+            break;    
+    }
+
+    if(pdev != NULL)
+    {
+        *fb_base =(unsigned int) pci_resource_start(pdev, 0);
+        *fb_len =get_fb_size_from_pci();
+        DEBUG_MSG(KERN_INFO "Get FB info from PCI system!\n");
+        DEBUG_MSG(KERN_INFO  "fb_base = %08x\n", *fb_base);
+        DEBUG_MSG(KERN_INFO  "fb_len = %08x\n", *fb_len);
+    }
+    else
+    {
+        *fb_base = read_reg(VIASR, SR30) << 24;
+        *fb_len = get_memsize();
+        DEBUG_MSG(KERN_INFO "Get FB info from SR30!\n");
+        DEBUG_MSG(KERN_INFO  "fb_base = %08x\n", *fb_base);
+        DEBUG_MSG(KERN_INFO  "fb_len = %08x\n", *fb_len);
+    }
+}
+
+/* Port from X code to get FB size from PCI system */
+int get_fb_size_from_pci()
+{
+    unsigned long   configid,deviceid,FBSize = 0;
+    int   VideoMemSize;
+    int   DeviceFound = FALSE;
+    
+    for ( configid = 0x80000000; configid < 0x80010800; configid += 0x100 )
+    {
+        outl(configid, (unsigned long)0xCF8);
+        deviceid = (inl((unsigned long)0xCFC)>>16) & 0xffff;
+
+        /* Add KM800 case */
+        switch (deviceid)
+        {
+            case CLE266:
+            case KM400:
+                outl(configid+0xE0, (unsigned long)0xCF8);
+                FBSize = inl((unsigned long)0xCFC);
+                DeviceFound = TRUE; /* Found device id */
+                break;
+                
+            case CN400_FUNCTION3:
+            case CN900_FUNCTION3:
+            case CX700_FUNCTION3:
+            case KM800_FUNCTION3:
+            case KM890_FUNCTION3:
+            case P4M890_FUNCTION3:
+            case P4M900_FUNCTION3:
+            /* (Need to Fix)
+                 The value of CN750_FUNCTION3 is duplicate with CN900_FUNCTION3 in VT3293_A0.
+                 This value maybe change in the next version. */
+            /*case CN750_FUNCTION3:*/
+                outl(configid+0xA0, (unsigned long)0xCF8);
+                FBSize = inl((unsigned long)0xCFC);
+                DeviceFound = TRUE; /* Found device id */
+                break;
+                
+            /* Can't set default, otherwise FBSize will be modified incorrectly */    
+            default:    
+                break;
+         }
+
+         if (DeviceFound)
+         {
+            break; /* Found device id, so exit for loop */
+         }
+    }
+
+    DEBUG_MSG(KERN_INFO  "Device ID = %x\n", deviceid);
+    
+    FBSize = FBSize & 0x00007000;
+    DEBUG_MSG(KERN_INFO "FB Size = %x\n", FBSize);
+    
+    if (chip_info.gfx_chip_name < UNICHROME_CX700)
+    {
+        switch(FBSize)
+        {
+            case 0x00004000:
+                VideoMemSize = (16 << 20);  /*16M*/              
+                break;
+
+            case 0x00005000:
+                VideoMemSize = (32 << 20);  /*32M*/                
+                break;
+
+            case 0x00006000:
+                VideoMemSize = (64 << 20);  /*64M*/                
+                break;
+
+            default:
+                VideoMemSize = (32 << 20);  /*32M*/
+                break;     
+        }
+    }
+    else
+    {
+        switch(FBSize)
+        {
+            case 0x00001000:
+                VideoMemSize = (8 << 20);   /*8M*/                
+                break;
+
+            case 0x00002000:
+                VideoMemSize = (16 << 20);  /*16M*/               
+                break;
+
+            case 0x00003000:
+                VideoMemSize = (32 << 20);  /*32M*/                
+                break;
+
+            case 0x00004000:
+                VideoMemSize = (64 << 20);  /*64M*/               
+                break;
+
+            case 0x00005000:
+                VideoMemSize = (128 << 20); /*128M*/
+                break;
+
+            case 0x00006000:
+                VideoMemSize = (256 << 20); /*256M*/
+                break;
+
+            default:
+                VideoMemSize = (32 << 20);  /*32M*/                
+                break;
+        }
+    }
+
+    return VideoMemSize;
+}
+
+void set_dpa_gfx(int output_interface, GFXDPASETTINGPTR p_gfx_dpa_setting)
+{
+    switch (output_interface)
+    {
+        case INTERFACE_DVP0:
+        {
+            /* DVP0 Clock Polarity and Adjust: */
+            write_reg_mask(CR96, VIACR, p_gfx_dpa_setting->DVP0, 0x0F);
+
+            /* DVP0 Clock and Data Pads Driving: */
+            write_reg_mask(SR1E, VIASR, p_gfx_dpa_setting->DVP0ClockDri_S, BIT2);
+            write_reg_mask(SR2A, VIASR, p_gfx_dpa_setting->DVP0ClockDri_S1, BIT4);
+            write_reg_mask(SR1B, VIASR, p_gfx_dpa_setting->DVP0DataDri_S, BIT1);
+            write_reg_mask(SR2A, VIASR, p_gfx_dpa_setting->DVP0DataDri_S1, BIT5);
+            break;
+        }
+
+        case INTERFACE_DVP1:
+        {
+            /* DVP1 Clock Polarity and Adjust: */
+            write_reg_mask(CR9B, VIACR, p_gfx_dpa_setting->DVP1, 0x0F);
+
+            /* DVP1 Clock and Data Pads Driving: */
+            write_reg_mask(SR65, VIASR, p_gfx_dpa_setting->DVP1Driving, 0x0F);
+            break;
+        }
+
+        case INTERFACE_DFP_HIGH:
+        {
+            write_reg_mask(CR97, VIACR, p_gfx_dpa_setting->DFPHigh, 0x0F);
+            break;
+        }
+
+        case INTERFACE_DFP_LOW:
+        {
+            write_reg_mask(CR99, VIACR, p_gfx_dpa_setting->DFPLow, 0x0F);
+            break;
+        }
+
+        case INTERFACE_DFP:
+        {
+            write_reg_mask(CR97, VIACR, p_gfx_dpa_setting->DFPHigh, 0x0F);
+            write_reg_mask(CR99, VIACR, p_gfx_dpa_setting->DFPLow, 0x0F);
+            break;
+        }
+    }
+}
+
+void memory_pitch_patch(struct fb_info *info)
+{
+     if(info->var.xres != info->var.xres_virtual)
+    {
+        if(SAMM_ON)
+        {
+            load_offset_reg(info->var.xres_virtual, info->var.bits_per_pixel>>3, IGA1);
+            load_offset_reg(second_virtual_xres,  bpp1>>3, IGA2);
+        }else
+        {
+            load_offset_reg(info->var.xres_virtual, info->var.bits_per_pixel>>3, IGA1);
+            load_offset_reg(info->var.xres_virtual, info->var.bits_per_pixel>>3, IGA2);
+        }   
+    }
+    
+}
+
+/* According var's xres, yres fill var's other timing information */
+/* Fix me: TV use separate timing table, this function can't cover TV case */
+void fill_var_timing_info(struct fb_var_screeninfo* var, int refresh, int mode_index)
+{
+    struct VideoModeTable  *vmode_tbl = NULL;
+    struct crt_mode_table  *crt_timing = NULL;
+    struct display_timing crt_reg;
+    int i = 0, index = 0;
+    vmode_tbl = &CLE266Modes[SearchModeSetting(mode_index)];
+    crt_timing = vmode_tbl->crtc;
+    for(i=0;i<vmode_tbl->mode_array;i++)
+    {
+        index = i;
+
+        if (crt_timing[i].refresh_rate == refresh)
+            break;
+    }
+    crt_reg = crt_timing[index].crtc;
+    var->left_margin = crt_reg.hor_total - (crt_reg.hor_sync_start + crt_reg.hor_sync_end);
+    var->right_margin = crt_reg.hor_sync_start - crt_reg.hor_addr;
+    var->hsync_len = crt_reg.hor_sync_end;
+    var->upper_margin = crt_reg.ver_total - (crt_reg.ver_sync_start + crt_reg.ver_sync_end);
+    var->lower_margin = crt_reg.ver_sync_start - crt_reg.ver_addr;
+    var->vsync_len = crt_reg.ver_sync_end;
+    var->pixclock = get_pixclock(var->xres, var->yres, refresh);
+}
+

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
