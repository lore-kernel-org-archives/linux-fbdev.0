From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 6/12] viafb: Framebuffer driver for VIA
 UniChrome/Chrome9 HC (fwd)
Date: Mon, 30 Apr 2007 10:37:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704301037090.27246@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiRNp-0006X1-OM for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:37:21 -0700
Received: from europa.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiRNo-0001iE-CB
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 01:37:21 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by europa.telenet-ops.be (Postfix) with SMTP id 8441B4183
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:19 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by europa.telenet-ops.be (Postfix) with ESMTP id 26BF24192
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:15 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l3U8bFnH020392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:15 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l3U8bE31020389
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Apr 2007 10:37:14 +0200
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
Date: Mon, 30 Apr 2007 13:20:26 +0800
From: EddyFu@via.com.tw
To: linux-fbdev-devel-bounces@lists.sourceforge.net
Subject: [Linux-fbdev-devel] [PATCH 6/12] viafb: Framebuffer driver for VIA
    UniChrome/Chrome9 HC

Dear All, 
 
Here is the part 6/12 of viafb.
 
Best Regards,
Eddy Fu 
 
diff -Nur linux-2.6.21-rc7/drivers/video/via/tbl1622a.h linux-2.6.21-rc7.viafb/drivers/video/via/tbl1622a.h
--- linux-2.6.21-rc7/drivers/video/via/tbl1622a.h 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.21-rc7.viafb/drivers/video/via/tbl1622a.h 2007-04-26 19:52:32.000000000 -0400
@@ -0,0 +1,2039 @@
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
+#ifndef __TBL1622A_H__
+#define __TBL1622A_H__
+
+#include "share.h"
+
+/***************************/
+/* VT1622A TV Encoder Table*/
+/***************************/
+typedef struct _vt1622a_func_table {
+    int     tv_func_index;
+    u16     *tv_underscan;
+    u16     *tv_fitscan;
+    u16     *tv_overscan;
+} vt1622a_func_table;
+
+struct vt1622a_table {
+    int     tv_index;
+    vt1622a_func_table   *tv_mode_ntsc;
+    vt1622a_func_table   *tv_mode_pal;
+};
+
+
+/* Underscan table */
+static u16 VT1622A_N640x480_VN[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x2707, 0x9A08, 0x0C09,     /* Tv.05-09 */
+    0x550A, 0x000B, 0x520C, 0x3B0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF812, 0x3E13,     /* TV.0F-13 */
+    0x8114, 0x5615, 0xF116, 0x9117, 0x2418,     /* TV.14-18 */
+    0x2519,                                     /* TV.19 */
+    0x101B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x111F, 0x1520, 0x0C21, 0x5F22,     /* TV.1E-22 */
+    0x7523, 0x0824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3B4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x0F50, 0x7F51, 0x2352, 0x5753, 0x0254,     /* TV.50-54 */
+    0x0F55, 0x2756, 0x7357, 0x6358, 0x8659,     /* TV.55-59 */
+    0xC45A, 0xDD5B, 0xD35C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x925E, 0xA45F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x7F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    784, 640, 640, 144, 688, 56,  600, 480, 480, 120, 488, 7
+};
+
+#define NUM_TOTAL_VT1622A_REG ARRAY_SIZE(VT1622A_N640x480_VN) -NUM_CRTC_TIMING
+
+static u16 VT1622A_N800x600_VN[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x5707, 0xD408, 0x0909,     /* TV.05-09 */
+    0x520A, 0x000B, 0x510C, 0x3B0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x6A12, 0x0D13,     /* TV.0F-13 */
+    0x4C14, 0x1C15, 0x9616, 0x5017, 0x5E18,     /* TV.14-18 */
+    0x1B19,                                     /* TV.19 */
+    0x101B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x441F, 0x1020, 0x0A21, 0x9C22,     /* TV.1E-22 */
+    0x7523, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x2750, 0x1F51, 0x3452, 0xED53, 0x0254,     /* TV.50-54 */
+    0x2755, 0xF556, 0x9D57, 0x6458, 0xB759,     /* TV.55-59 */
+    0x0D5A, 0x215B, 0xF15C, 0x575D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xB65E, 0x3B5F, 0x0560, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xEF63, 0x0564,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1064,800, 800, 264, 840, 136, 750, 600, 600, 150, 606, 16
+};
+
+static u16 VT1622A_N1024x768_VN[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4707, 0x1208, 0x0809,     /* TV.05-09 */
+    0x500A, 0x000B, 0x500C, 0x3A0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xEF12, 0x3713,     /* TV.0F-13 */
+    0x7714, 0x2A15, 0xD616, 0x6617, 0xEB18,     /* TV.14-18 */
+    0x1419,                                     /* TV.19 */
+    0x101B, 0x051C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x771F, 0x0D20, 0x0521, 0xEF22,     /* TV.1E-22 */
+    0x7323, 0x0C24,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x394F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x8750, 0xFF51, 0x3452, 0xB053, 0x0354,     /* TV.50-54 */
+    0x6F55, 0xDC56, 0xCD57, 0x3558, 0xF159,     /* TV.55-59 */
+    0x5E5A, 0x9A5B, 0x705C, 0x5A5D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x335E, 0x265F, 0x0760, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x2763, 0x0864,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1160,1024,1024,136, 1040,56,  945, 768, 768, 177, 789, 6
+};
+
+static u16 VT1622A_N848x480_VN[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0xa707, 0xc108, 0x0709,     /* TV.05-09 */
+    0x500A, 0x000B, 0x500C, 0x390D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF012, 0x2913,     /* TV.0F-13 */
+    0x6714, 0x3115, 0x6316, 0xA817, 0x3C18,     /* TV.14-18 */
+    0x1D19,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x331F, 0x1120, 0x0821, 0x4722,     /* TV.1E-22 */
+    0x7323, 0x0C24,                             /* TV.23-24 */
+ 
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x394F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x4F51, 0x3452, 0x4453, 0x0254,     /* TV.50-54 */
+    0xE355, 0xBF56, 0x9357, 0x6358, 0xAD59,     /* TV.55-59 */
+    0xFD5A, 0x1B5B, 0x6F5C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x6D5E, 0xD45F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x2F63, 0x0564,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,848, 848, 352, 968, 64,  581, 480, 480, 101, 496, 13
+};
+
+static u16 VT1622A_N720x480_VN[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x3F07, 0xB608, 0x0709,     /* TV.05-09 */
+    0x520A, 0x000B, 0x510C, 0x3A0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xED12, 0x3113,     /* TV.0F-13 */
+    0x5014, 0x3515, 0x1816, 0x5517, 0x5518,     /* TV.14-18 */
+    0x1E19,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x331F, 0x1220, 0x0821, 0x5722,     /* TV.1E-22 */
+    0x7523, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x4750, 0xCF51, 0x2352, 0x5753, 0x0254,     /* TV.50-54 */
+    0xBF55, 0xAD56, 0x8D57, 0x6358, 0xA459,     /* TV.55-59 */
+    0xF35A, 0x1E5B, 0x285C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x925E, 0x335F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0xBF63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    840, 720, 720, 120, 728, 48,  600, 480, 480, 120, 512, 7
+};
+
+static u16 VT1622A_P640x480_VN[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0xBF07, 0x9F08, 0x3709,     /* TV.05-09 */
+    0x5D0A, 0x000B, 0x4F0C, 0x420D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xAC12, 0x1513,     /* TV.0F-13 */
+    0x6E14, 0x2815, 0x2D16, 0x7717, 0x6618,     /* TV.14-18 */
+    0x2D19,                                     /* TV.19 */
+    0x101B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x991F, 0x1720, 0x0C21, 0x3122,     /* TV.1E-22 */
+    0x7A23, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x434F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x7F51, 0x2352, 0x5753, 0x0254,     /* TV.50-54 */
+    0x1F55, 0x2F56, 0x7557, 0x6358, 0x8A59,     /* TV.55-59 */
+    0xC85A, 0xDB5B, 0xF55C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xD75E, 0x8E5F, 0x0360, 0x7F61, 0xCF62,     /* TV.5E-62 */
+    0xBF63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,640, 640, 360, 736, 72,  600, 480, 480, 120, 521, 5
+};
+
+static u16 VT1622A_P800x600_VN[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0004,     /* TV.00-04 */ 
+    0x0005, 0x2006, 0x2707, 0xB808, 0x0D09,     /* TV.05-09 */
+    0x5C0A, 0x000B, 0x4E0C, 0x400D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xEC12, 0x2A13,     /* TV.0F-13 */
+    0xFD14, 0x2815, 0xE416, 0x7D17, 0x7A18,     /* TV.14-18 */
+    0x2719,                                     /* TV.19 */
+    0x101B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xAA1F, 0x1320, 0x0C21, 0x9F22,     /* TV.1E-22 */
+    0x7923, 0x0C24,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x414F,                                     /* TV.4F */
+ 
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x9750, 0x1F51, 0x3352, 0xED53, 0x0254,     /* TV.50-54 */
+    0x9755, 0x8756, 0x8757, 0x6358, 0x9F59,     /* TV.55-59 */
+    0xE75A, 0xF35B, 0xE15C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xCC5E, 0xF35F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x4F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    920, 800, 800, 120, 816, 64,  750, 600, 600, 150, 606, 16
+};
+
+static u16 VT1622A_P1024x768_VN[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x5707, 0x2508, 0x4009,     /* TV.05-09 */
+    0x5A0A, 0x000B, 0x4D0C, 0x400D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE812, 0x2313,     /* TV.0F-13 */
+    0xD114, 0x1815, 0x7216, 0xC317, 0x8C18,     /* TV.14-18 */
+    0x1A19,                                     /* TV.19 */
+    0x101B, 0x071C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xFF1F, 0x0F20, 0x0C21, 0x8722,     /* TV.1E-22 */
+    0x7923, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0xFF51, 0x3452, 0xB553, 0x0354,     /* TV.50-54 */
+    0x5755, 0xA856, 0xC857, 0x3558, 0xEC59,     /* TV.55-59 */
+    0x4C5A, 0x9A5B, 0x415C, 0x5A5D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x145E, 0x5C5F, 0x0660, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1F63, 0x0764,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1040,80,  950, 768, 768, 182, 802, 3
+};
+
+static u16 VT1622A_P848x480_VN[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0xa707, 0xE608, 0x0609,     /* TV.05-09 */ 
+    0x5C0A, 0x000B, 0x4E0C, 0x410D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE612, 0x2313,     /* TV.0F-13 */
+    0x8414, 0x1815, 0x1816, 0x2817, 0x8718,     /* TV.14-18 */
+    0x1F19,                                     /* TV.19 */
+    0x101B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xCC1F, 0x0F20, 0x0C21, 0x6022,     /* TV.1E-22 */
+    0x7923, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x4F51, 0x3452, 0x5753, 0x0254,     /* TV.50-54 */
+    0x7F55, 0x3156, 0xA957, 0x7458, 0xD159,     /* TV.55-59 */
+    0x2B5A, 0x415B, 0xA55C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xD75E, 0x265F, 0x0360, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x7F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,848, 848, 352, 976, 56,  600, 480, 480, 120, 499, 11
+};
+
+static u16 VT1622A_P720x576_VN[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4907, 0xCC08, 0x0609,     /* TV.05-09 */
+    0x5C0A, 0x000B, 0x4D0C, 0x410D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF012, 0x2413,     /* TV.0F-13 */
+    0x3F14, 0x3915, 0x6016, 0x9017, 0xC818,     /* TV.14-18 */
+    0x2319,                                     /* TV.19 */
+    0x101B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xBB1F, 0x1420, 0x0C21, 0xD922,     /* TV.1E-22 */
+    0x7923, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x414F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0xCF51, 0x2352, 0xD453, 0x0254,     /* TV.50-54 */
+    0xF655, 0xCF56, 0x9557, 0x6358, 0xAE59,     /* TV.55-59 */
+    0xF55A, 0x1C5B, 0x965C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xA45E, 0x005F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x8763, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,720, 720, 280, 840, 96,  725, 576, 576, 149, 602, 9
+};
+
+
+/* Fit Industry TV Screen Mode */
+
+static u16 VT1622A_N640x480_VF[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x2E07, 0x8208, 0x0609,     /* TV.05-09 */
+    0x560A, 0x050B, 0x500C, 0x3B0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF812, 0x2713,     /* TV.0F-13 */
+    0x9E14, 0x5515, 0x4216, 0x8517, 0x2C18,     /* TV.14-18 */
+    0x2419,                                     /* TV.19 */
+    0x101B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x111F, 0x1720, 0x0C21, 0xD522,     /* TV.1E-22 */
+    0x7323, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x4750, 0x8151, 0x2352, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x2455, 0x6756, 0x7757, 0x6358, 0x8859,     /* TV.55-59 */
+    0xCB5A, 0xDA5B, 0x005C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x625E, 0x2C5F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x9763, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    840, 640, 640, 200, 736, 56,  575, 480, 480, 95,  499, 7
+};
+
+static u16 VT1622A_N800x600_VF[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x8707, 0x9608, 0xFA09,     /* TV.05-09 */
+    0x560A, 0x000B, 0x500C, 0x3B0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xED12, 0x1913,     /* TV.0F-13 */
+    0xA014, 0x1C15, 0xBE16, 0xFF17, 0x7F18,     /* TV.14-18 */
+    0x2019,                                     /* TV.19 */
+    0x101B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x221F, 0x1120, 0x0A21, 0xDE22,     /* TV.1E-22 */
+    0x7323, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x1F51, 0x3452, 0xD753, 0x0254,     /* TV.50-54 */
+    0x7F55, 0xA956, 0x8457, 0x2358, 0x9859,     /* TV.55-59 */
+    0xE35A, 0xE45B, 0xAE5C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x8C5E, 0xB65F, 0x0560, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x7F63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,800, 800, 400, 848, 216, 728, 600, 600, 128, 656, 9
+};
+
+static u16 VT1622A_N1024x768_VF[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4E07, 0xDB08, 0x0C09,     /* TV.05-09 */
+    0x520A, 0x000B, 0x4F0C, 0x3A0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x6812, 0x0D13,     /* TV.0F-13 */
+    0x4A14, 0x1415, 0x3216, 0x8A17, 0x7C18,     /* TV.14-18 */
+    0x1619,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x661F, 0x0D20, 0x0521, 0x2422,     /* TV.1E-22 */
+    0x7323, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x394F,                                     /* TV.4F */ 
+ 
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x9750, 0xFF51, 0x3452, 0x9C53, 0x0354,     /* TV.50-54 */
+    0x0E55, 0xDE56, 0xBF57, 0x3558, 0xDD59,     /* TV.55-59 */
+    0x495A, 0x7B5B, 0xB35C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x0C5E, 0x235F, 0x0760, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1763, 0x0864,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1176,1024,1024,152, 1040,64,  925, 768, 768, 157, 779, 12
+};
+
+static u16 VT1622A_N848x480_VF[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4707, 0xB508, 0x0B09,     /* TV.05-09 */
+    0x530A, 0x000B, 0x500C, 0x3A0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xED12, 0x2313,     /* TV.0F-13 */
+    0x0E14, 0x3515, 0x8416, 0x8417, 0xF618,     /* TV.14-18 */
+    0x1A19,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */ 
+    0x001E, 0x441F, 0x1120, 0x0A21, 0x7822,     /* TV.1E-22 */
+    0x7323, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x394F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x4F51, 0x3352, 0x3653, 0x0254,     /* TV.50-54 */
+    0x3755, 0x3956, 0x9F57, 0x7458, 0xB759,     /* TV.55-59 */
+    0x125A, 0x3A5B, 0x125C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x525E, 0x1A5F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x3763, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,848, 848, 152, 872, 56,  567, 480, 480, 87,  485, 7
+};
+
+static u16 VT1622A_N720x480_VF[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x3F07, 0x9808, 0x0A09,     /* TV.05-09 */
+    0x530A, 0x000B, 0x500C, 0x3B0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF512, 0x2713,     /* TV.0F-13 */
+    0x9E14, 0x5515, 0x9A16, 0xF417, 0xA618,     /* TV.14-18 */
+    0x1F19,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x221F, 0x1620, 0x0821, 0xF622,     /* TV.1E-22 */
+    0x7323, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x084E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x4750, 0xCF51, 0x2352, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x9755, 0xBE56, 0x8857, 0x6358, 0x9C59,     /* TV.55-59 */
+    0xE95A, 0xE15B, 0xDC5C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x625E, 0x175F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x9763, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    840, 720, 720, 120, 728, 48,  575, 480, 480, 95,  484, 15
+};
+
+static u16 VT1622A_P640x480_VF[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4E07, 0x8A08, 0x3009,     /* Tv.05-09 */
+    0x5D0A, 0x000B, 0x4D0C, 0x410D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF812, 0x1813,     /* TV.0F-13 */
+    0xFD14, 0x5415, 0xBC16, 0x4617, 0x1E18,     /* TV.14-18 */
+    0x2D19,                                     /* TV.19 */
+    0x101B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x991F, 0x1B20, 0x0C21, 0x8722,     /* TV.1E-22 */
+    0x7923, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x434F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x7F51, 0x2352, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x2455, 0x5D56, 0x7657, 0x6358, 0x8959,     /* TV.55-59 */
+    0xC25A, 0x145B, 0x1C5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xAE5E, 0x3A5F, 0x0360, 0x0061, 0x0062,     /* TV.5E-62 */
+    0xBF63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,640, 640, 360, 840, 80,  575, 480, 480, 95,  501, 3
+};
+
+static u16 VT1622A_P800x600_VF[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4607, 0xB308, 0x0F09,     /* TV.05-09 */
+    0x5C0A, 0x000B, 0x4D0C, 0x410D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF012, 0x2413,     /* TV.0F-13 */
+    0x3F14, 0x3915, 0x6016, 0x9017, 0xC818,     /* TV.14-18 */
+    0x2319,                                     /* TV.19 */
+    0x101B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xBB1F, 0x1420, 0x0C21, 0xD922,     /* TV.1E-22 */
+    0x7923, 0x0024,                             /* TV.23-24 */
+ 
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x414F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x2151, 0x3352, 0xD453, 0x0254,     /* TV.50-54 */
+    0xF655, 0xFD56, 0x9557, 0x6358, 0xAE59,     /* TV.55-59 */
+    0xF55A, 0x1C5B, 0x965C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xA45E, 0x315F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x8763, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,800, 800, 200, 848, 80,  725, 600, 600, 125, 602, 1
+};
+
+static u16 VT1622A_P1024x768_VF[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x5707, 0xF208, 0x4009,     /* TV.05-09 */
+    0x5B0A, 0x000B, 0x4E0C, 0x400D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xF012, 0x2313,     /* TV.0F-13 */
+    0x9714, 0x3115, 0xB416, 0x7517, 0x4418,     /* TV.14-18 */
+    0x1B19,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xEE1F, 0x0D20, 0x0C21, 0x8722,     /* TV.1E-22 */
+    0x7923, 0x0024,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0xFF51, 0x3452, 0x9C53, 0x0354,     /* TV.50-54 */
+    0x3355, 0xE656, 0xC357, 0x3558, 0xE959,     /* TV.55-59 */
+    0x515A, 0x7F5B, 0x015C, 0x5A5D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xEB5E, 0x195F, 0x0560, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xEF63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1040,72,  925, 768, 768, 157, 782, 13
+};
+
+static u16 VT1622A_P848x480_VF[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4A07, 0xC808, 0x3909,     /* TV.05-09 */
+    0x5B0A, 0x000B, 0x4D0C, 0x3F0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xEA12, 0x2A13,     /* TV.0F-13 */
+    0xFD14, 0x3015, 0x9316, 0x1317, 0xE618,     /* TV.14-18 */
+    0x2019,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xCC1F, 0x1220, 0x0C21, 0x2922,     /* TV.1E-22 */
+    0x7923, 0x0824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x4F51, 0x3352, 0x3E53, 0x0254,     /* TV.50-54 */
+    0x4F55, 0x3856, 0xA257, 0x7458, 0xBE59,     /* TV.55-59 */
+    0x0B5A, 0x3C5B, 0x475C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xAE5E, 0x1C5F, 0x0360, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x9763, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,848, 848, 152, 856, 72,  575, 480, 480, 95,  486, 3
+};
+
+static u16 VT1622A_P720x576_VF[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x2707, 0xAF08, 0x3309,     /* TV.05-09 */
+    0x620A, 0x000B, 0x4D0C, 0x440D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x0912, 0x0713,     /* TV.0F-13 */
+    0x2114, 0x2815, 0x5016, 0x6317, 0xD518,     /* TV.14-18 */
+    0x2519,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xAA1F, 0x1720, 0x0C21, 0xF322,     /* TV.1E-22 */
+    0x7923, 0x4824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x424F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x1F50, 0xCF51, 0x2352, 0xA253, 0x0254,     /* TV.50-54 */
+    0xBF55, 0xC956, 0x8D57, 0x2358, 0xA559,     /* TV.55-59 */
+    0xE85A, 0x1B5B, 0x2C5C, 0x175D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x525E, 0x085F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x5F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    800, 720, 720, 80,  728, 32,  675, 576, 576, 99,  602, 9
+};
+
+/* TV Overscan Table */
+
+static u16 VT1622A_N640x480_VO[] = {
+                                                  
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x2F07, 0x6408, 0xFA09,     /* TV.05-09 */
+    0x5E0A, 0x170B, 0x500C, 0x3F0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x7012, 0x0D13,     /* TV.0F-13 */
+    0x5014, 0x3815, 0x4516, 0x9917, 0x9918,     /* TV.14-18 */
+    0x2919,                                     /* TV.19 */
+    0x101B, 0x001C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x001F, 0x1720, 0x0C21, 0x4822,     /* TV.1E-22 */
+    0x7423, 0x0824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3B4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x1F50, 0x7F51, 0x2352, 0x0C53, 0x0254,     /* TV.50-54 */
+    0xBB55, 0x3356, 0x6757, 0x6258, 0x7659,     /* TV.55-59 */
+    0xB05A, 0xA15B, 0x2F5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x005E, 0x945F, 0x8460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x1F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    800, 640, 640, 160, 656, 96,  525, 480, 480, 45,  495, 11
+};
+
+static u16 VT1622A_N800x600_VO[] = {
+                                                  
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4607, 0x8108, 0xFE09,     /* TV.05-09 */
+    0x570A, 0x000B, 0x500C, 0x3D0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x4A12, 0x0D13,     /* TV.0F-13 */
+    0x3E14, 0x1C15, 0xD116, 0x6217, 0x8C18,     /* TV.14-18 */
+    0x2119,                                     /* TV.19 */
+    0x101B, 0x011C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x221F, 0x1120, 0x0A21, 0xB422,     /* TV.1E-22 */
+    0x7323, 0x0824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x394F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xEF50, 0x1F51, 0x3352, 0x8A53, 0x0254,     /* TV.50-54 */
+    0x6355, 0xDE56, 0x8057, 0x6358, 0x9359,     /* TV.55-59 */
+    0xDC5A, 0xE05B, 0x7F5C, 0x065D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0xF65E, 0x9B5F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xD763, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,800, 800, 200, 832, 96,  651, 600, 600, 51,  608, 12
+};
+
+static u16 VT1622A_N1024x768_VO[] = {
+                                                  
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0304,     /* TV.00-04 */ 
+    0x0005, 0x2006, 0x2F07, 0xB608, 0x0409,     /* TV.05-09 */
+    0x540A, 0x000B, 0x500C, 0x3C0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x6A12, 0x0D13,     /* TV.0F-13 */
+    0x5814, 0x1C15, 0x8A16, 0xE817, 0xA218,     /* TV.14-18 */
+    0x1719,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x551F, 0x0F20, 0x0521, 0x7222,     /* TV.1E-22 */
+    0x7323, 0x0824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x394F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x5F50, 0xFF51, 0x3452, 0x3853, 0x0354,     /* TV.50-54 */
+    0xCF55, 0xE056, 0xB657, 0x3458, 0xD259,     /* TV.55-59 */
+    0x395A, 0x5C5B, 0x415C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x495E, 0x235F, 0x0660, 0x0061, 0x0162,     /* TV.5E-62 */
+    0xDF63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1120,1024,1024,96,  1040,40,  825, 768, 768, 57,  770, 6
+};
+
+static u16 VT1622A_N848x480_VO[] = {
+                                                  
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4E07, 0x9E08, 0x0709,     /* TV.05-09 */
+    0x510A, 0x000B, 0x500C, 0x3A0D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xED12, 0x2313,     /* TV.0F-13 */
+    0x0814, 0x3515, 0xA116, 0x6417, 0x9318,     /* TV.14-18 */
+    0x1B19,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x441F, 0x1120, 0x0A21, 0xF022,     /* TV.1E-22 */
+    0x7323, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x394F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xEF50, 0x5151, 0x3352, 0x2553, 0x0254,     /* TV.50-54 */
+    0x1F55, 0x4756, 0x9C57, 0x7458, 0xB559,     /* TV.55-59 */
+    0x0C5A, 0x3D5B, 0xF15C, 0x575D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x305E, 0x0C5F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1008,848, 848, 160, 856, 72,  550, 480, 480, 70,  491, 5
+};
+
+static u16 VT1622A_N720x480_VO[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0304,     /* TV.00-04 */
+    0x0005, 0x2006, 0x2807, 0x5208, 0x0809,     /* TV.05-09 */
+    0x5B0A, 0x000B, 0x500C, 0x400D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x2D12, 0x0713,     /* TV.0F-13 */
+    0x2814, 0x3415, 0x1D16, 0x6617, 0x6618,     /* TV.14-18 */
+    0x2419,                                     /* TV.19 */
+    0x101B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x111F, 0x1620, 0x0821, 0xDF22,     /* TV.1E-22 */
+    0x7623, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x084E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x1F50, 0xCF51, 0x2352, 0x0C53, 0x0254,     /* TV.50-54 */
+    0x1F55, 0xCE56, 0x7657, 0x2358, 0x8859,     /* TV.55-59 */
+    0xC95A, 0xEF5B, 0xFF5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x005E, 0x005F, 0x0060, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x1F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    800, 720, 720, 80,  728, 32,  525, 480, 480, 45,  482, 1
+};
+
+static u16 VT1622A_P640x480_VO[] = {
+                                                  
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4F07, 0x7008, 0x2E09,     /* Tv.05-09 */
+    0x670A, 0x000B, 0x4D0C, 0x460D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0x4A12, 0x0E13,     /* TV.0F-13 */
+    0x3714, 0x2415, 0xC016, 0xD917, 0x7118,     /* TV.14-18 */
+    0x3219,                                     /* TV.19 */
+    0x101B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x881F, 0x1B20, 0x0C21, 0xEF22,     /* TV.1E-22 */
+    0x7923, 0x0424,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x444F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x7F51, 0x2352, 0xF353, 0x0154,     /* TV.50-54 */
+    0xCF55, 0xB756, 0x6957, 0x3258, 0x7A59,     /* TV.55-59 */
+    0xAD5A, 0xBF5B, 0x5F5C, 0x055D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x335E, 0x865F, 0x0360, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x1F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,640, 640, 360, 800, 120, 500, 480, 480, 20,  485, 6
+};
+
+static u16 VT1622A_P800x600_VO[] = {
+                                                  
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x4707, 0x9108, 0x3109,     /* TV.05-09 */
+    0x610A, 0x000B, 0x4D0C, 0x430D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xED12, 0x1513,     /* TV.0F-13 */
+    0x8F14, 0x3015, 0x5016, 0x6317, 0xD518,     /* TV.14-18 */
+    0x2519,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xAA1F, 0x1420, 0x0C21, 0x7922,     /* TV.1E-22 */
+    0x7923, 0x0824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x414F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xE750, 0x2151, 0x3352, 0x8953, 0x0254,     /* TV.50-54 */
+    0xBF55, 0xFD56, 0x8D57, 0x2358, 0xA559,     /* TV.55-59 */
+    0xE85A, 0xE95B, 0x325C, 0x075D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x295E, 0x325F, 0x0460, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x0F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1000,800, 800, 200, 872, 56,  650, 600, 600, 50,  608, 12
+};
+
+static u16 VT1622A_P1024x768_VO[] = {
+                                                  
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x3707, 0xBD08, 0x3709,     /* TV.05-09 */
+    0x5E0A, 0x000B, 0x4D0C, 0x420D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xC912, 0x1413,     /* TV.0F-13 */
+    0x7914, 0x1C15, 0x3816, 0x0E17, 0x7B18,     /* TV.14-18 */
+    0x1D19,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xDD1F, 0x0F20, 0x0C21, 0xC022,     /* TV.1E-22 */
+    0x7923, 0x0824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x404F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0xFF51, 0x3452, 0x3853, 0x0354,     /* TV.50-54 */
+    0xCF55, 0xE356, 0xB457, 0x3458, 0xD459,     /* TV.55-59 */
+    0x2B5A, 0x405B, 0x525C, 0x595D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x485E, 0x215F, 0x0560, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x2F63, 0x0664,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,1024,1024,176, 1088,56,  825, 768, 768, 57,  771, 5
+};
+
+static u16 VT1622A_P848x480_VO[] = {
+                                                
+    0x8400, 0x0001, 0x0002, 0x0403, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0xA507, 0xA108, 0x3809,     /* TV.05-09 */
+    0x5E0A, 0x000B, 0x4D0C, 0x410D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xC712, 0x1E13,     /* TV.0F-13 */
+    0x7914, 0x1C15, 0xEC16, 0xE517, 0x6418,     /* TV.14-18 */
+    0x2219,                                     /* TV.19 */
+    0x101B, 0x031C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0xBB1F, 0x1220, 0x0C21, 0x5A22,     /* TV.1E-22 */
+    0x7923, 0x0C24,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0xAF50, 0x4F51, 0x3452, 0x2553, 0x0254,     /* TV.50-54 */
+    0x1F55, 0x4F56, 0x9B57, 0x7458, 0xB759,     /* TV.55-59 */
+    0x0A5A, 0x3F5B, 0xF05C, 0x585D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x855E, 0x005F, 0x0360, 0x0061, 0x0162,     /* TV.5E-62 */
+    0x1F63, 0x0464,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    1200,848, 848, 352, 864, 176, 550, 480, 480, 70,  491, 5
+};
+
+static u16 VT1622A_P720x576_VO[] = {
+                                                
+    0x0400, 0x0001, 0x0002, 0x0603, 0x0004,     /* TV.00-04 */
+    0x0005, 0x2006, 0x3F07, 0x8908, 0x3909,     /* TV.05-09 */
+    0x630A, 0x000B, 0x500C, 0x450D, 0x0F0E,     /* TV.0A-0E */
+    0x000F, 0x0010, 0x0011, 0xE812, 0x2313,     /* TV.0F-13 */
+    0x8414, 0x2015, 0xCB16, 0x8A17, 0x0918,     /* TV.14-18 */
+    0x2A19,                                     /* TV.19 */
+    0x101B, 0x021C, 0x801D,                     /* TV.1B-1D */
+    0x001E, 0x991F, 0x1720, 0x0C21, 0x6F22,     /* TV.1E-22 */
+    0x7923, 0x4824,                             /* TV.23-24 */
+
+                                                /* Filter registers */
+    0x004A, 0x004B, 0x004C, 0x044D, 0x004E,     /* TV.4A-4E */
+    0x3A4F,                                     /* TV.4F */
+
+                                                /* Set Video Timing (TV Timing Regsiter ) */
+    0x5F50, 0xCF51, 0x2352, 0x7053, 0x0254,     /* TV.50-54 */
+    0x5F55, 0xBF56, 0x7E57, 0x2358, 0x9459,     /* TV.55-59 */
+    0xD05A, 0x275B, 0x8F5C, 0x165D,             /* TV.5A-5D */
+                                                /* Set Video Timing (TV CRTC Regsiter ) */
+    0x005E, 0x005F, 0x0460, 0x0061, 0x0062,     /* TV.5E-62 */
+    0x5F63, 0x0364,                             /* TV.63-64 */
+
+    /* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
+    864, 720, 720, 144, 760, 40,  625, 576, 576, 49,  577, 3
+};
+
+/***********************************/
+/* VT1622A output RGB Table        */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622A_N640x480_RGB_VN[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B, 0x272C,     
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_RGB_VN[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,             
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_RGB_VN[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,             
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_RGB_VN[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,             
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_RGB_VN[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,             
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_RGB_VF[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B, 0x272C,     
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_RGB_VF[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,              
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_RGB_VF[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,              
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_RGB_VF[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,             
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_RGB_VF[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,             
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_RGB_VO[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_RGB_VO[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_RGB_VO[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_RGB_VO[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_RGB_VO[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+
+
+/* PAL */
+
+
+static u16 VT1622A_P640x480_RGB_VN[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B, 0x272C,     
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_RGB_VN[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,                
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_RGB_VN[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,                
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_RGB_VN[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,               
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_RGB_VN[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,               
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_RGB_VF[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B, 0x272C,       
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_RGB_VF[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,               
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_RGB_VF[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,               
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_RGB_VF[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,               
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_RGB_VF[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0x9127, 0x9C2B,               
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_RGB_VO[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_RGB_VO[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_RGB_VO[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_RGB_VO[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_RGB_VO[] = {
+    0x2A02,                     /* output RGB type (SCART Connector) */
+    0x8265, 0x8066, 0x8167,     /* adjust RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+/***********************************/
+/* VT1622A output YPBPR Table      */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622A_N640x480_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622A_N720x480_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+
+/* PAL */
+
+static u16 VT1622A_P640x480_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_YPBPR_VN[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_YPBPR_VF[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_YPBPR_VO[] = {
+    0x0302,                     /* output YPBPR type */
+    0x5065, 0x4B66, 0x4D67,     /* adjust YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+/***********************************/
+/* VT1622A output SDTV_RGB Table   */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622A_N640x480_SDTV_RGB_VN[] = {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x8A08, 0x1809, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_SDTV_RGB_VN[] = {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0xC408, 0x1209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_SDTV_RGB_VN[] = {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x0C08, 0x0E09, 0x051C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_SDTV_RGB_VN[] = {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0xB508, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_SDTV_RGB_VN[] = {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0xA908, 0x0109, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_SDTV_RGB_VF[] = {
+    0x2A02, 0X0B04,             /* output SDTV_RGB type */
+    0x7E08, 0x0109, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_SDTV_RGB_VF[] = {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x8B08, 0xF509, 0x031C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_SDTV_RGB_VF[]={
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0xD408, 0x0909, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_SDTV_RGB_VF[] = {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0xA808, 0x0609, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_SDTV_RGB_VF[] = {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x8C08, 0x0509, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_SDTV_RGB_VO[] = {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x5708, 0xF109, 0x021C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_SDTV_RGB_VO[] = {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x7208, 0xF809, 0x031C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_SDTV_RGB_VO[] = {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0xAE08, 0x0209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_SDTV_RGB_VO[] = {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x9708, 0x0009, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_SDTV_RGB_VO[] = {
+    0x2A02, 0x0B04,             /* output SDTV_RGB type */
+    0x3E08, 0xFF09, 0x021C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+
+/* PAL */
+
+static u16 VT1622A_P640x480_SDTV_RGB_VN[] = {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x9508, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622A_P800x600_SDTV_RGB_VN[] = {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0xAE08, 0x1B09, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622A_P1024x768_SDTV_RGB_VN[] = {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x1C08, 0x0D09, 0x051C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_SDTV_RGB_VN[] = {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0xDE08, 0x0F09, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_SDTV_RGB_VN[] = { 
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x9708, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_SDTV_RGB_VF[] = {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x8B08, 0x0109, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_SDTV_RGB_VF[] = {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0xA908, 0x1D09, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_SDTV_RGB_VF[] = {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0xE908, 0x1009, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+
+};
+
+static u16 VT1622A_P848x480_SDTV_RGB_VF[] = {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0xBC08, 0x1209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_SDTV_RGB_VF[] = {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0xA208, 0x0009, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_SDTV_RGB_VO[] = {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x6808, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_SDTV_RGB_VO[] = {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x9108, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_SDTV_RGB_VO[] = {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0xBC08, 0x0009, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_SDTV_RGB_VO[] = {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x9208, 0x0309, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_SDTV_RGB_VO[] = {
+    0x2A02, 0x0804,             /* output SDTV_RGB type */
+    0x8108, 0x0009, 0x001C,     /* adjust TV's Position */ 
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x8265, 0x8066, 0x8167,     /* adjust SDTV_RGB Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+/***********************************/
+/* VT1622A output SDTV_YPBPR Table */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622A_N640x480_SDTV_YPBPR_VN[] = {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x8C08, 0x1409, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_SDTV_YPBPR_VN[] = {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0xC408, 0x1209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_SDTV_YPBPR_VN[] = {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x0C08, 0x0E09, 0x051C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_SDTV_YPBPR_VN[] = {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0xB508, 0x0009, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_SDTV_YPBPR_VN[] = {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0xA908, 0x0109, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_SDTV_YPBPR_VF[] = {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x7B08, 0x0109, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_SDTV_YPBPR_VF[] = {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x8B08, 0xFA09, 0x031C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_SDTV_YPBPR_VF[] = {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0xD408, 0x0D09, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_SDTV_YPBPR_VF[] = {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0xA808, 0x0609, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_SDTV_YPBPR_VF[] = {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x8C08, 0x0809, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_SDTV_YPBPR_VO[] = {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */ 
+    0x5708, 0xF109, 0x021C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_SDTV_YPBPR_VO[] = {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x7208, 0xF809, 0x031C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_SDTV_YPBPR_VO[] = {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0xAE08, 0x0209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_SDTV_YPBPR_VO[] = {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x9708, 0x1209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_SDTV_YPBPR_VO[] = {
+    0x0B02, 0x0B04,             /* output SDTV_YPBPR type */
+    0x3E08, 0xFF09, 0x021C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+
+
+/* PAL */
+
+
+static u16 VT1622A_P640x480_SDTV_YPBPR_VN[] = {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x9508, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_SDTV_YPBPR_VN[] = {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0xAE08, 0x1B09, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_SDTV_YPBPR_VN[] = {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x1E08, 0x0C09, 0x051C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_SDTV_YPBPR_VN[] = { 
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0xDE08, 0x0F09, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_SDTV_YPBPR_VN[] = {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x9708, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_SDTV_YPBPR_VF[] = {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x8B08, 0x0109, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_SDTV_YPBPR_VF[] = {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0xA908, 0x2309, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_SDTV_YPBPR_VF[] = {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0xE908, 0x1209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_SDTV_YPBPR_VF[] = {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0xBC08, 0x1209, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_SDTV_YPBPR_VF[] = {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0xA208, 0x0009, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P640x480_SDTV_YPBPR_VO[] = {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x6808, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P800x600_SDTV_YPBPR_VO[] = {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x9508, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P1024x768_SDTV_YPBPR_VO[] = {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0xBC08, 0x0009, 0x011C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P848x480_SDTV_YPBPR_VO[] = {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x9208, 0x0309, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_P720x576_SDTV_YPBPR_VO[] = {
+    0x0B02, 0x0804,             /* output SDTV_YPBPR type */
+    0x9508, 0x0009, 0x001C,     /* adjust TV's Position */
+    0x0400, 0x0003,             /* disable de-flicker function */
+    0x004D,                     /* Y_DELAY = 0 */
+    0x5065, 0x4D66, 0x4D67,     /* adjust SDTV_YPBPR Amplitude factor */
+    0xFFFF                      /* End symbol */
+};
+
+/***********************************/
+/* VT1622A DeDotCrawl Table        */
+/***********************************/
+
+/* NTSC */
+
+static u16 VT1622A_N640x480_DeDotCrawl_VN[] = {
+    0xBE16, 0x8717,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_DeDotCrawl_VN[] = {
+    0x1216, 0x4917,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_DeDotCrawl_VN[] = {
+    0x1816, 0x6117,             /* adjust TV FSCI */ 
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_DeDotCrawl_VN[] = {
+    0x5B16, 0xA017,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_DeDotCrawl_VN[] = {
+    0xC316, 0x4C17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_DeDotCrawl_VF[] = {
+    0x5016, 0x7B17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_DeDotCrawl_VF[] = {
+    0xD116, 0xF617,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_DeDotCrawl_VF[] = {
+    0x0616, 0x8417,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_DeDotCrawl_VF[] = {
+    0x1C16, 0x7D17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_DeDotCrawl_VF[] = {
+    0xE816, 0xEB17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N640x480_DeDotCrawl_VO[] = {
+    0xE516, 0xA017,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N800x600_DeDotCrawl_VO[] = {
+    0xA116, 0x5917,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N1024x768_DeDotCrawl_VO[] = {
+    0x1116, 0xE217,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N848x480_DeDotCrawl_VO[] = {
+    0x6716, 0x3017,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+static u16 VT1622A_N720x480_DeDotCrawl_VO[] = {
+    0x1E16, 0x5C17,             /* adjust TV FSCI */
+    0xFFFF                      /* End symbol */
+};
+
+
+static vt1622a_func_table vt1622a_ntsc_640x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1622A_N640x480_VN,            VT1622A_N640x480_VF,            VT1622A_N640x480_VO},
+    {TV_RGB_FUNC,          VT1622A_N640x480_RGB_VN,        VT1622A_N640x480_RGB_VF,        VT1622A_N640x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_N640x480_YPBPR_VN,      VT1622A_N640x480_YPBPR_VF,      VT1622A_N640x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_N640x480_SDTV_RGB_VN,   VT1622A_N640x480_SDTV_RGB_VF,   VT1622A_N640x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_N640x480_SDTV_YPBPR_VN, VT1622A_N640x480_SDTV_YPBPR_VF, VT1622A_N640x480_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622A_N640x480_DeDotCrawl_VN, VT1622A_N640x480_DeDotCrawl_VF, VT1622A_N640x480_DeDotCrawl_VO}
+};
+
+static vt1622a_func_table vt1622a_ntsc_800x600_tbl[] = {
+    {TV_BASE_FUNC,         VT1622A_N800x600_VN,            VT1622A_N800x600_VF,            VT1622A_N800x600_VO},
+    {TV_RGB_FUNC,          VT1622A_N800x600_RGB_VN,        VT1622A_N800x600_RGB_VF,        VT1622A_N800x600_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_N800x600_YPBPR_VN,      VT1622A_N800x600_YPBPR_VF,      VT1622A_N800x600_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_N800x600_SDTV_RGB_VN,   VT1622A_N800x600_SDTV_RGB_VF,   VT1622A_N800x600_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_N800x600_SDTV_YPBPR_VN, VT1622A_N800x600_SDTV_YPBPR_VF, VT1622A_N800x600_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622A_N800x600_DeDotCrawl_VN, VT1622A_N800x600_DeDotCrawl_VF, VT1622A_N800x600_DeDotCrawl_VO}
+};
+
+static vt1622a_func_table vt1622a_ntsc_1024x768_tbl[]= {
+    {TV_BASE_FUNC,         VT1622A_N1024x768_VN,            VT1622A_N1024x768_VF,            VT1622A_N1024x768_VO},
+    {TV_RGB_FUNC,          VT1622A_N1024x768_RGB_VN,        VT1622A_N1024x768_RGB_VF,        VT1622A_N1024x768_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_N1024x768_YPBPR_VN,      VT1622A_N1024x768_YPBPR_VF,      VT1622A_N1024x768_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_N1024x768_SDTV_RGB_VN,   VT1622A_N1024x768_SDTV_RGB_VF,   VT1622A_N1024x768_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_N1024x768_SDTV_YPBPR_VN, VT1622A_N1024x768_SDTV_YPBPR_VF, VT1622A_N1024x768_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622A_N1024x768_DeDotCrawl_VN, VT1622A_N1024x768_DeDotCrawl_VF, VT1622A_N1024x768_DeDotCrawl_VO}
+};
+
+static vt1622a_func_table vt1622a_ntsc_848x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1622A_N848x480_VN,             VT1622A_N848x480_VF,             VT1622A_N848x480_VO},
+    {TV_RGB_FUNC,          VT1622A_N848x480_RGB_VN,         VT1622A_N848x480_RGB_VF,         VT1622A_N848x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_N848x480_YPBPR_VN,       VT1622A_N848x480_YPBPR_VF,       VT1622A_N848x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_N848x480_SDTV_RGB_VN,    VT1622A_N848x480_SDTV_RGB_VF,    VT1622A_N848x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_N848x480_SDTV_YPBPR_VN,  VT1622A_N848x480_SDTV_YPBPR_VF,  VT1622A_N848x480_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622A_N848x480_DeDotCrawl_VN,  VT1622A_N848x480_DeDotCrawl_VF,  VT1622A_N848x480_DeDotCrawl_VO}
+};
+
+static vt1622a_func_table vt1622a_ntsc_720x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1622A_N720x480_VN,             VT1622A_N720x480_VF,             VT1622A_N720x480_VO},
+    {TV_RGB_FUNC,          VT1622A_N720x480_RGB_VN,         VT1622A_N720x480_RGB_VF,         VT1622A_N720x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_N720x480_YPBPR_VN,       VT1622A_N720x480_YPBPR_VF,       VT1622A_N720x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_N720x480_SDTV_RGB_VN,    VT1622A_N720x480_SDTV_RGB_VF,    VT1622A_N720x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_N720x480_SDTV_YPBPR_VN,  VT1622A_N720x480_SDTV_YPBPR_VF,  VT1622A_N720x480_SDTV_YPBPR_VO},
+    {TV_DeDotCrawl_FUNC,   VT1622A_N720x480_DeDotCrawl_VN,  VT1622A_N720x480_DeDotCrawl_VF,  VT1622A_N720x480_DeDotCrawl_VO}
+};
+
+static vt1622a_func_table vt1622a_pal_640x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1622A_P640x480_VN,             VT1622A_P640x480_VF,             VT1622A_P640x480_VO},
+    {TV_RGB_FUNC,          VT1622A_P640x480_RGB_VN,         VT1622A_P640x480_RGB_VF,         VT1622A_P640x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_P640x480_YPBPR_VN,       VT1622A_P640x480_YPBPR_VF,       VT1622A_P640x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_P640x480_SDTV_RGB_VN,    VT1622A_P640x480_SDTV_RGB_VF,    VT1622A_P640x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_P640x480_SDTV_YPBPR_VN,  VT1622A_P640x480_SDTV_YPBPR_VF,  VT1622A_P640x480_SDTV_YPBPR_VO}
+};
+
+static vt1622a_func_table vt1622a_pal_800x600_tbl[] = {
+    {TV_BASE_FUNC,         VT1622A_P800x600_VN,             VT1622A_P800x600_VF,             VT1622A_P800x600_VO},
+    {TV_RGB_FUNC,          VT1622A_P800x600_RGB_VN,         VT1622A_P800x600_RGB_VF,         VT1622A_P800x600_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_P800x600_YPBPR_VN,       VT1622A_P800x600_YPBPR_VF,       VT1622A_P800x600_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_P800x600_SDTV_RGB_VN,    VT1622A_P800x600_SDTV_RGB_VF,    VT1622A_P800x600_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_P800x600_SDTV_YPBPR_VN,  VT1622A_P800x600_SDTV_YPBPR_VF,  VT1622A_P800x600_SDTV_YPBPR_VO}
+};
+
+static vt1622a_func_table vt1622a_pal_1024x768_tbl[] = {
+    {TV_BASE_FUNC,         VT1622A_P1024x768_VN,             VT1622A_P1024x768_VF,             VT1622A_P1024x768_VO},
+    {TV_RGB_FUNC,          VT1622A_P1024x768_RGB_VN,         VT1622A_P1024x768_RGB_VF,         VT1622A_P1024x768_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_P1024x768_YPBPR_VN,       VT1622A_P1024x768_YPBPR_VF,       VT1622A_P1024x768_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_P1024x768_SDTV_RGB_VN,    VT1622A_P1024x768_SDTV_RGB_VF,    VT1622A_P1024x768_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_P1024x768_SDTV_YPBPR_VN,  VT1622A_P1024x768_SDTV_YPBPR_VF,  VT1622A_P1024x768_SDTV_YPBPR_VO}
+};
+
+static vt1622a_func_table vt1622a_pal_848x480_tbl[] = {
+    {TV_BASE_FUNC,         VT1622A_P848x480_VN,             VT1622A_P848x480_VF,             VT1622A_P848x480_VO},
+    {TV_RGB_FUNC,          VT1622A_P848x480_RGB_VN,         VT1622A_P848x480_RGB_VF,         VT1622A_P848x480_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_P848x480_YPBPR_VN,       VT1622A_P848x480_YPBPR_VF,       VT1622A_P848x480_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_P848x480_SDTV_RGB_VN,    VT1622A_P848x480_SDTV_RGB_VF,    VT1622A_P848x480_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_P848x480_SDTV_YPBPR_VN,  VT1622A_P848x480_SDTV_YPBPR_VF,  VT1622A_P848x480_SDTV_YPBPR_VO}
+};
+
+static vt1622a_func_table vt1622a_pal_720x576_tbl[] = {
+    {TV_BASE_FUNC,         VT1622A_P720x576_VN,             VT1622A_P720x576_VF,             VT1622A_P720x576_VO},
+    {TV_RGB_FUNC,          VT1622A_P720x576_RGB_VN,         VT1622A_P720x576_RGB_VF,         VT1622A_P720x576_RGB_VO},
+    {TV_YPBPR_FUNC,        VT1622A_P720x576_YPBPR_VN,       VT1622A_P720x576_YPBPR_VF,       VT1622A_P720x576_YPBPR_VO},
+    {TV_SDTV_RGB_FUNC,     VT1622A_P720x576_SDTV_RGB_VN,    VT1622A_P720x576_SDTV_RGB_VF,    VT1622A_P720x576_SDTV_RGB_VO},
+    {TV_SDTV_YPBPR_FUNC,   VT1622A_P720x576_SDTV_YPBPR_VN,  VT1622A_P720x576_SDTV_YPBPR_VF,  VT1622A_P720x576_SDTV_YPBPR_VO}
+};
+
+
+static struct vt1622a_table vt1622a_tbl[] = {
+    {VIA_RES_640X480,             vt1622a_ntsc_640x480_tbl,    vt1622a_pal_640x480_tbl},
+    {VIA_RES_800X600,             vt1622a_ntsc_800x600_tbl,    vt1622a_pal_800x600_tbl},
+    {VIA_RES_1024X768,            vt1622a_ntsc_1024x768_tbl,   vt1622a_pal_1024x768_tbl},
+    {VIA_RES_848X480,             vt1622a_ntsc_848x480_tbl,    vt1622a_pal_848x480_tbl},
+    {VIA_RES_720X480,             vt1622a_ntsc_720x480_tbl,    vt1622a_ntsc_720x480_tbl},
+    {VIA_RES_720X576,             vt1622a_pal_720x576_tbl,     vt1622a_pal_720x576_tbl}
+};
+
+#define NUM_TOTAL_VT1622A_TABLE ARRAY_SIZE(vt1622a_tbl)
+
+#endif /* __TBL1622A_H__ */

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
