From: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH]: EDID parser
Date: 01 Apr 2003 23:32:04 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049210343.1009.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190NoN-0001Yg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Apr 2003 07:36:31 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi James,

Attached is a diff against 2.5.66.  It includes a reasonably complete
EDID parser and also includes some new functions that can be used by
fbdev drivers (for mode selection purposes)

1. fb_create_modedb()

creates a mode database which can be fed to fb_find_mode().  This means
that fb_find_mode() should not be __init anymore.

2. fb_destroy_modedb()

destroy mode database created by fb_create_modedb()

3. fb_get_monitor_limits()

gets monitor operating limits (max and min hscan, max and min refresh,
max pixclock, DPMS and GTF capability)

useful for validating video modes and calculating mode timings (if GTF
capable)

4. show_edid()

just prints EDID data into human-readable format.

All of of the above depends on valid EDID data.

Tony

diff -Naur linux-2.5.66-orig/drivers/video/edid.h linux-2.5.66-fbdev/drivers/video/edid.h
--- linux-2.5.66-orig/drivers/video/edid.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.5.66-fbdev/drivers/video/edid.h	2003-04-01 14:30:14.000000000 +0000
@@ -0,0 +1,128 @@
+/* 
+ * drivers/video/edid.h - EDID parser definitions
+ *
+ * portions of this file were based on the EDID parser by
+ * John Fremlin <vii@users.sourceforge.net> and Ani Joshi <ajoshi@unixbox.com>
+ */
+
+#ifndef __EDID_H__
+#define __EDID_H__
+
+#define EDID_LENGTH				0x80
+#define EDID_HEADER				0x00
+#define EDID_HEADER_END				0x07
+
+#define ID_MANUFACTURER_NAME			0x08
+#define ID_MANUFACTURER_NAME_END		0x09
+#define ID_MODEL				0x0a
+
+#define ID_SERIAL_NUMBER			0x0c
+
+#define MANUFACTURE_WEEK			0x10
+#define MANUFACTURE_YEAR			0x11
+
+#define EDID_STRUCT_VERSION			0x12
+#define EDID_STRUCT_REVISION			0x13
+
+#define EDID_STRUCT_DISPLAY                     0x14
+
+#define DPMS_FLAGS				0x18
+#define ESTABLISHED_TIMING_1			0x23
+#define ESTABLISHED_TIMING_2			0x24
+#define MANUFACTURERS_TIMINGS			0x25
+
+/* standard timings supported */
+#define STD_TIMING                              8
+#define STD_TIMING_DESCRIPTION_SIZE             2
+#define STD_TIMING_DESCRIPTIONS_START           0x26
+
+#define DETAILED_TIMING_DESCRIPTIONS_START	0x36
+#define DETAILED_TIMING_DESCRIPTION_SIZE	18
+#define NO_DETAILED_TIMING_DESCRIPTIONS		4
+
+#define DETAILED_TIMING_DESCRIPTION_1		0x36
+#define DETAILED_TIMING_DESCRIPTION_2		0x48
+#define DETAILED_TIMING_DESCRIPTION_3		0x5a
+#define DETAILED_TIMING_DESCRIPTION_4		0x6c
+
+#define DESCRIPTOR_DATA				5
+
+#define UPPER_NIBBLE( x ) \
+        (((128|64|32|16) & (x)) >> 4)
+
+#define LOWER_NIBBLE( x ) \
+        ((1|2|4|8) & (x))
+
+#define COMBINE_HI_8LO( hi, lo ) \
+        ( (((unsigned)hi) << 8) | (unsigned)lo )
+
+#define COMBINE_HI_4LO( hi, lo ) \
+        ( (((unsigned)hi) << 4) | (unsigned)lo )
+
+#define PIXEL_CLOCK_LO     (unsigned)block[ 0 ]
+#define PIXEL_CLOCK_HI     (unsigned)block[ 1 ]
+#define PIXEL_CLOCK	   (COMBINE_HI_8LO( PIXEL_CLOCK_HI,PIXEL_CLOCK_LO )*10000)
+#define H_ACTIVE_LO        (unsigned)block[ 2 ]
+#define H_BLANKING_LO      (unsigned)block[ 3 ]
+#define H_ACTIVE_HI        UPPER_NIBBLE( (unsigned)block[ 4 ] )
+#define H_ACTIVE           COMBINE_HI_8LO( H_ACTIVE_HI, H_ACTIVE_LO )
+#define H_BLANKING_HI      LOWER_NIBBLE( (unsigned)block[ 4 ] )
+#define H_BLANKING         COMBINE_HI_8LO( H_BLANKING_HI, H_BLANKING_LO )
+
+#define V_ACTIVE_LO        (unsigned)block[ 5 ]
+#define V_BLANKING_LO      (unsigned)block[ 6 ]
+#define V_ACTIVE_HI        UPPER_NIBBLE( (unsigned)block[ 7 ] )
+#define V_ACTIVE           COMBINE_HI_8LO( V_ACTIVE_HI, V_ACTIVE_LO )
+#define V_BLANKING_HI      LOWER_NIBBLE( (unsigned)block[ 7 ] )
+#define V_BLANKING         COMBINE_HI_8LO( V_BLANKING_HI, V_BLANKING_LO )
+
+#define H_SYNC_OFFSET_LO   (unsigned)block[ 8 ]
+#define H_SYNC_WIDTH_LO    (unsigned)block[ 9 ]
+
+#define V_SYNC_OFFSET_LO   UPPER_NIBBLE( (unsigned)block[ 10 ] )
+#define V_SYNC_WIDTH_LO    LOWER_NIBBLE( (unsigned)block[ 10 ] )
+
+#define V_SYNC_WIDTH_HI    ((unsigned)block[ 11 ] & (1|2))
+#define V_SYNC_OFFSET_HI   (((unsigned)block[ 11 ] & (4|8)) >> 2)
+
+#define H_SYNC_WIDTH_HI    (((unsigned)block[ 11 ] & (16|32)) >> 4)
+#define H_SYNC_OFFSET_HI   (((unsigned)block[ 11 ] & (64|128)) >> 6)
+
+#define V_SYNC_WIDTH       COMBINE_HI_4LO( V_SYNC_WIDTH_HI, V_SYNC_WIDTH_LO )
+#define V_SYNC_OFFSET      COMBINE_HI_4LO( V_SYNC_OFFSET_HI, V_SYNC_OFFSET_LO )
+
+#define H_SYNC_WIDTH       COMBINE_HI_4LO( H_SYNC_WIDTH_HI, H_SYNC_WIDTH_LO )
+#define H_SYNC_OFFSET      COMBINE_HI_4LO( H_SYNC_OFFSET_HI, H_SYNC_OFFSET_LO )
+
+#define H_SIZE_LO          (unsigned)block[ 12 ]
+#define V_SIZE_LO          (unsigned)block[ 13 ]
+
+#define H_SIZE_HI          UPPER_NIBBLE( (unsigned)block[ 14 ] )
+#define V_SIZE_HI          LOWER_NIBBLE( (unsigned)block[ 14 ] )
+
+#define H_SIZE             COMBINE_HI_8LO( H_SIZE_HI, H_SIZE_LO )
+#define V_SIZE             COMBINE_HI_8LO( V_SIZE_HI, V_SIZE_LO )
+
+#define H_BORDER           (unsigned)block[ 15 ]
+#define V_BORDER           (unsigned)block[ 16 ]
+
+#define FLAGS              (unsigned)block[ 17 ]
+
+#define INTERLACED         (FLAGS&128)
+#define SYNC_TYPE          (FLAGS&3<<3)	/* bits 4,3 */
+#define SYNC_SEPARATE      (3<<3)
+#define HSYNC_POSITIVE     (FLAGS & 4)
+#define VSYNC_POSITIVE     (FLAGS & 2)
+
+#define V_MIN_RATE              block[ 5 ]
+#define V_MAX_RATE              block[ 6 ]
+#define H_MIN_RATE              block[ 7 ]
+#define H_MAX_RATE              block[ 8 ]
+#define MAX_PIXEL_CLOCK         (((int)block[ 9 ]) * 10)
+#define GTF_SUPPORT		block[10]
+
+#define DPMS_ACTIVE_OFF		(1 << 5)
+#define DPMS_SUSPEND		(1 << 6)
+#define DPMS_STANDBY		(1 << 7)
+
+#endif /* __EDID_H__ */
diff -Naur linux-2.5.66-orig/drivers/video/fbmon.c linux-2.5.66-fbdev/drivers/video/fbmon.c
--- linux-2.5.66-orig/drivers/video/fbmon.c	2003-03-29 12:37:03.000000000 +0000
+++ linux-2.5.66-fbdev/drivers/video/fbmon.c	2003-04-01 15:14:42.000000000 +0000
@@ -11,12 +11,10 @@
 #include <linux/tty.h>
 #include <linux/fb.h>
 #include <linux/module.h>
-#ifdef CONFIG_PCI
-#include <linux/pci.h>
-#endif
 #ifdef CONFIG_ALL_PPC
 #include <asm/prom.h>
 #endif
+#include "edid.h"
 
 /* 
  * EDID parser
@@ -25,110 +23,21 @@
  * John Fremlin <vii@users.sourceforge.net> and Ani Joshi <ajoshi@unixbox.com>
  */
 
-#define EDID_LENGTH				0x80
-#define EDID_HEADER				0x00
-#define EDID_HEADER_END				0x07
-
-#define ID_MANUFACTURER_NAME			0x08
-#define ID_MANUFACTURER_NAME_END		0x09
-#define ID_MODEL				0x0a
-
-#define ID_SERIAL_NUMBER			0x0c
-
-#define MANUFACTURE_WEEK			0x10
-#define MANUFACTURE_YEAR			0x11
-
-#define EDID_STRUCT_VERSION			0x12
-#define EDID_STRUCT_REVISION			0x13
-
-#define DPMS_FLAGS				0x18
-#define ESTABLISHED_TIMING_1			0x23
-#define ESTABLISHED_TIMING_2			0x24
-#define MANUFACTURERS_TIMINGS			0x25
-
-#define DETAILED_TIMING_DESCRIPTIONS_START	0x36
-#define DETAILED_TIMING_DESCRIPTION_SIZE	18
-#define NO_DETAILED_TIMING_DESCRIPTIONS		4
-
-#define DETAILED_TIMING_DESCRIPTION_1		0x36
-#define DETAILED_TIMING_DESCRIPTION_2		0x48
-#define DETAILED_TIMING_DESCRIPTION_3		0x5a
-#define DETAILED_TIMING_DESCRIPTION_4		0x6c
-
-#define DESCRIPTOR_DATA				5
-
-#define UPPER_NIBBLE( x ) \
-        (((128|64|32|16) & (x)) >> 4)
-
-#define LOWER_NIBBLE( x ) \
-        ((1|2|4|8) & (x))
-
-#define COMBINE_HI_8LO( hi, lo ) \
-        ( (((unsigned)hi) << 8) | (unsigned)lo )
-
-#define COMBINE_HI_4LO( hi, lo ) \
-        ( (((unsigned)hi) << 4) | (unsigned)lo )
-
-#define PIXEL_CLOCK_LO     (unsigned)block[ 0 ]
-#define PIXEL_CLOCK_HI     (unsigned)block[ 1 ]
-#define PIXEL_CLOCK	   (COMBINE_HI_8LO( PIXEL_CLOCK_HI,PIXEL_CLOCK_LO )*1000)
-#define H_ACTIVE_LO        (unsigned)block[ 2 ]
-#define H_BLANKING_LO      (unsigned)block[ 3 ]
-#define H_ACTIVE_HI        UPPER_NIBBLE( (unsigned)block[ 4 ] )
-#define H_ACTIVE           COMBINE_HI_8LO( H_ACTIVE_HI, H_ACTIVE_LO )
-#define H_BLANKING_HI      LOWER_NIBBLE( (unsigned)block[ 4 ] )
-#define H_BLANKING         COMBINE_HI_8LO( H_BLANKING_HI, H_BLANKING_LO )
-
-#define V_ACTIVE_LO        (unsigned)block[ 5 ]
-#define V_BLANKING_LO      (unsigned)block[ 6 ]
-#define V_ACTIVE_HI        UPPER_NIBBLE( (unsigned)block[ 7 ] )
-#define V_ACTIVE           COMBINE_HI_8LO( V_ACTIVE_HI, V_ACTIVE_LO )
-#define V_BLANKING_HI      LOWER_NIBBLE( (unsigned)block[ 7 ] )
-#define V_BLANKING         COMBINE_HI_8LO( V_BLANKING_HI, V_BLANKING_LO )
-
-#define H_SYNC_OFFSET_LO   (unsigned)block[ 8 ]
-#define H_SYNC_WIDTH_LO    (unsigned)block[ 9 ]
-
-#define V_SYNC_OFFSET_LO   UPPER_NIBBLE( (unsigned)block[ 10 ] )
-#define V_SYNC_WIDTH_LO    LOWER_NIBBLE( (unsigned)block[ 10 ] )
-
-#define V_SYNC_WIDTH_HI    ((unsigned)block[ 11 ] & (1|2))
-#define V_SYNC_OFFSET_HI   (((unsigned)block[ 11 ] & (4|8)) >> 2)
-
-#define H_SYNC_WIDTH_HI    (((unsigned)block[ 11 ] & (16|32)) >> 4)
-#define H_SYNC_OFFSET_HI   (((unsigned)block[ 11 ] & (64|128)) >> 6)
-
-#define V_SYNC_WIDTH       COMBINE_HI_4LO( V_SYNC_WIDTH_HI, V_SYNC_WIDTH_LO )
-#define V_SYNC_OFFSET      COMBINE_HI_4LO( V_SYNC_OFFSET_HI, V_SYNC_OFFSET_LO )
-
-#define H_SYNC_WIDTH       COMBINE_HI_4LO( H_SYNC_WIDTH_HI, H_SYNC_WIDTH_LO )
-#define H_SYNC_OFFSET      COMBINE_HI_4LO( H_SYNC_OFFSET_HI, H_SYNC_OFFSET_LO )
-
-#define H_SIZE_LO          (unsigned)block[ 12 ]
-#define V_SIZE_LO          (unsigned)block[ 13 ]
-
-#define H_SIZE_HI          UPPER_NIBBLE( (unsigned)block[ 14 ] )
-#define V_SIZE_HI          LOWER_NIBBLE( (unsigned)block[ 14 ] )
-
-#define H_SIZE             COMBINE_HI_8LO( H_SIZE_HI, H_SIZE_LO )
-#define V_SIZE             COMBINE_HI_8LO( V_SIZE_HI, V_SIZE_LO )
-
-#define H_BORDER           (unsigned)block[ 15 ]
-#define V_BORDER           (unsigned)block[ 16 ]
-
-#define FLAGS              (unsigned)block[ 17 ]
-
-#define INTERLACED         (FLAGS&128)
-#define SYNC_TYPE          (FLAGS&3<<3)	/* bits 4,3 */
-#define SYNC_SEPARATE      (3<<3)
-#define HSYNC_POSITIVE     (FLAGS & 4)
-#define VSYNC_POSITIVE     (FLAGS & 2)
-
 const unsigned char edid_v1_header[] = { 0x00, 0xff, 0xff, 0xff,
 	0xff, 0xff, 0xff, 0x00
 };
 const unsigned char edid_v1_descriptor_flag[] = { 0x00, 0x00 };
 
+static void copy_string(unsigned char *c, unsigned char *s)
+{
+  int i;
+  c = c + 5;
+  for (i = 0; (i < 13 && *c != 0x0A); i++)
+    *(s++) = *(c++);
+  *s = 0;
+  while (i-- && (*--s == 0x20)) *s = 0;
+}
+
 static int edid_checksum(unsigned char *edid)
 {
 	unsigned char i, csum = 0;
@@ -157,37 +66,144 @@
 	return 1;
 }
 
-
-static char *edid_get_vendor(unsigned char *block)
+static void parse_vendor_block(unsigned char *block)
 {
-	static char sign[4];
-	unsigned short h;
-
-	h = COMBINE_HI_8LO(block[0], block[1]);
-	sign[0] = ((h >> 10) & 0x1f) + 'A' - 1;
-	sign[1] = ((h >> 5) & 0x1f) + 'A' - 1;
-	sign[2] = (h & 0x1f) + 'A' - 1;
-	sign[3] = 0;
+	unsigned char c[4];
 
-	return sign;
+	c[0] = ((block[0] & 0x7c) >> 2) + '@';
+	c[1] = ((block[0] & 0x03) << 3) + ((block[1] & 0xe0) >> 5) + '@';
+	c[2] = (block[1] & 0x1f) + '@';
+	c[3] = 0;
+	printk("   Manufacturer: %s ", c);
+	printk("Model: %x ", block[2] + (block[3] << 8));
+	printk("Serial#: %u\n", block[4] + (block[5] << 8) + 
+	       (block[6] << 16) + (block[7] << 24));
+	printk("   Year: %u Week %u\n", block[9] + 1990, block[8]);
 }
 
-static char *edid_get_monitor(unsigned char *block)
+static void parse_dpms_capabilities(unsigned char flags)
+{
+	printk("      DPMS: Active %s, Suspend %s, Standby %s\n",
+	       (flags & DPMS_ACTIVE_OFF) ? "yes" : "no",
+	       (flags & DPMS_SUSPEND)    ? "yes" : "no",
+	       (flags & DPMS_STANDBY)    ? "yes" : "no");
+}
+	
+static void parse_display_block(unsigned char *block)
 {
-	static char name[13];
-	unsigned i;
-	const unsigned char *ptr = block + DESCRIPTOR_DATA;
+	unsigned char c;
 
-	for (i = 0; i < 13; i++, ptr++) {
-		if (*ptr == 0xa) {
-			name[i] = 0x00;
-			return name;
+	c = (block[0] & 0x80) >> 7;
+	if (c) 
+		printk("      Digital Display Input");
+	else {
+		printk("      Analog Display Input: Input Voltage - ");
+		switch ((block[0] & 0x60) >> 5) {
+		case 0:
+			printk("0.700V/0.300V");
+			break;
+		case 1:
+			printk("0.714V/0.286V");
+			break;
+		case 2:
+			printk("1.000V/0.400V");
+			break;
+		case 3:
+			printk("0.700V/0.000V");
+			break;
+		default:
+			printk("unknown");
 		}
-		name[i] = *ptr;
+		printk("\n");
+	}
+	c = (block[0] & 0x10) >> 4;
+	if (c)
+		printk("      Configurable signal level\n");
+	printk("      Sync: ");
+	c = block[0] & 0x0f;
+	if (c & 0x08)
+		printk("Separate ");
+	if (c & 0x04)
+		printk("Composite ");
+	if (c & 0x02)
+		printk("Sync on Green ");
+	if (c & 0x01)
+		printk("Serration on ");
+	printk("\n");
+
+	printk("      Max H-size in cm: ");
+	c = block[1];
+	if (c) 
+		printk("%d\n", c);
+	else
+		printk("variable\n");
+	
+	printk("      Max V-size in cm: ");
+	c = block[2];
+	if (c)
+		printk("%d\n", c);
+	else
+		printk("variable\n");
+
+	c = block[3];
+	printk("      Gamma: ");
+	printk("%d.%d\n", (c + 100)/100, (c+100) % 100);
+
+	parse_dpms_capabilities(block[4]);
+
+	switch ((block[4] & 0x18) >> 3) {
+	case 0:
+		printk("      Monochrome/Grayscale\n");
+		break;
+	case 1:
+		printk("      RGB Color Display\n");
+		break;
+	case 2:
+		printk("      Non-RGB Multicolor Display\n");
+		break;
+	default:
+		printk("      Unknown\n");
+		break;
 	}
-	return name;
+	c = block[4] & 0x7;
+	if (c & 0x04)
+		printk("      Default color format is primary\n");
+	if (c & 0x02)
+		printk("      First DETAILED Timing is preferred\n");
+	if (c & 0x01)
+		printk("      Display is GTF capable\n");
 }
 
+static void parse_std_md_block(unsigned char *block)
+{
+	unsigned char c;
+
+	c = block[0];
+	if (c&0x80) printk("      720x400@70Hz\n");
+	if (c&0x40) printk("      720x400@88Hz\n");
+	if (c&0x20) printk("      640x480@60Hz\n");
+	if (c&0x10) printk("      640x480@67Hz\n");
+	if (c&0x08) printk("      640x480@72Hz\n");
+	if (c&0x04) printk("      640x480@75Hz\n");
+	if (c&0x02) printk("      800x600@56Hz\n");
+	if (c&0x01) printk("      800x600@60Hz\n");
+
+	c = block[1];
+	if (c&0x80) printk("      800x600@72Hz\n");
+	if (c&0x40) printk("      800x600@75Hz\n");
+	if (c&0x20) printk("      832x624@75Hz\n");
+	if (c&0x10) printk("      1024x768@87Hz (interlaced)\n");
+	if (c&0x08) printk("      1024x768@60Hz\n");
+	if (c&0x04) printk("      1024x768@70Hz\n");
+	if (c&0x02) printk("      1024x768@75Hz\n");
+	if (c&0x01) printk("      1280x1024@75Hz\n");
+
+	c = block[2];
+	if (c&0x80) printk("      1152x870@75Hz\n");
+	printk("      Manufacturer's mask: %x\n",c&0x7F);
+}
+		
+		
 static int edid_is_timing_block(unsigned char *block)
 {
 	if ((block[0] == 0x00) && (block[1] == 0x00))
@@ -196,6 +212,30 @@
 		return 1;
 }
 
+static int edid_is_serial_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) && (block[1] == 0x00) && (block[3] == 0xff))
+		return 1;
+	else
+		return 0;
+}
+
+static int edid_is_ascii_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) && (block[1] == 0x00) && (block[3] == 0xfe))
+		return 1;
+	else
+		return 0;
+}
+
+static int edid_is_limits_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) && (block[1] == 0x00) && (block[3] == 0xfd))
+		return 1;
+	else
+		return 0;
+}
+
 static int edid_is_monitor_block(unsigned char *block)
 {
 	if ((block[0] == 0x00) && (block[1] == 0x00) && (block[3] == 0xfc))
@@ -204,75 +244,475 @@
 		return 0;
 }
 
-static void parse_timing_block(unsigned char *block,
-			       struct fb_var_screeninfo *var)
+static int edid_is_color_block(unsigned char *block)
 {
-	var->xres = var->xres_virtual = H_ACTIVE;
-	var->yres = var->yres_virtual = V_ACTIVE;
-	var->height = var->width = -1;
-	var->right_margin = H_SYNC_OFFSET;
-	var->left_margin = (H_ACTIVE + H_BLANKING) -
-	    (H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH);
-	var->upper_margin = V_BLANKING - V_SYNC_OFFSET - V_SYNC_WIDTH;
-	var->lower_margin = V_SYNC_OFFSET;
-	var->hsync_len = H_SYNC_WIDTH;
-	var->vsync_len = V_SYNC_WIDTH;
-	var->pixclock = PIXEL_CLOCK;
-	var->pixclock /= 1000;
-	var->pixclock = KHZ2PICOS(var->pixclock);
+	if ((block[0] == 0x00) && (block[1] == 0x00) && (block[3] == 0xfb))
+		return 1;
+	else
+		return 0;
+}
 
-	if (HSYNC_POSITIVE)
-		var->sync |= FB_SYNC_HOR_HIGH_ACT;
-	if (VSYNC_POSITIVE)
-		var->sync |= FB_SYNC_VERT_HIGH_ACT;
+static int edid_is_std_timings_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) && (block[1] == 0x00) && (block[3] == 0xfa))
+		return 1;
+	else
+		return 0;
+}
+
+static void parse_serial_block(unsigned char *block)
+{
+	unsigned char c[13];
+	
+	copy_string(block, c);
+	printk("      Serial No     : %s\n", c);
+}
+
+static void parse_ascii_block(unsigned char *block)
+{
+	unsigned char c[13];
+	
+	copy_string(block, c);
+	printk("      %s\n", c);
+}
+
+static void parse_limits_block(unsigned char *block)
+{
+	printk("      HorizSync     : %d-%d KHz\n", H_MIN_RATE, H_MAX_RATE);
+	printk("      VertRefresh   : %d-%d Hz\n", V_MIN_RATE, V_MAX_RATE);
+	if (MAX_PIXEL_CLOCK != 10*0xff)
+		printk("      Max Pixelclock: %d MHz\n", (int) MAX_PIXEL_CLOCK);
+}
+
+static void parse_monitor_block(unsigned char *block)
+{
+	unsigned char c[13];
+	
+	copy_string(block, c);
+	printk("      Monitor Name  : %s\n", c);
+}
+
+static void parse_color_block(unsigned char *block)
+{
+	printk("      Color Point    : unimplemented\n");
+}
+
+static void parse_std_timing_block(unsigned char *block)
+{
+	int xres, yres = 0, refresh, ratio, err = 1;
+	
+	xres = (block[0] + 31) * 8;
+	if (xres <= 256)
+		return;
+
+	ratio = (block[1] & 0xc0) >> 6;
+	switch (ratio) {
+	case 0:
+		yres = xres;
+		break;
+	case 1:
+		yres = (xres * 3)/4;
+		break;
+	case 2:
+		yres = (xres * 4)/5;
+		break;
+	case 3:
+		yres = (xres * 9)/16;
+		break;
+	}
+	refresh = (block[1] & 0x3f) + 60;
+	printk("      %dx%d@%dHz\n", xres, yres, refresh);
+	err = 0;
+}
+
+static void parse_dst_timing_block(unsigned char *block)
+{
+	int i;
+
+	block += 5;
+	for (i = 0; i < 5; i++, block += STD_TIMING_DESCRIPTION_SIZE)
+		parse_std_timing_block(block);
+}
+
+static void parse_detailed_timing_block(unsigned char *block)
+{
+	printk("      %d MHz ",  PIXEL_CLOCK/1000000);
+	printk("%d %d %d %d ", H_ACTIVE, H_ACTIVE + H_SYNC_OFFSET, 
+	       H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH, H_ACTIVE + H_BLANKING);
+	printk("%d %d %d %d ", V_ACTIVE, V_ACTIVE + V_SYNC_OFFSET, 
+	       V_ACTIVE + V_SYNC_OFFSET + V_SYNC_WIDTH, V_ACTIVE + V_BLANKING);
+	printk("%sHSync %sVSync\n\n", (HSYNC_POSITIVE) ? "+" : "-", 
+	       (VSYNC_POSITIVE) ? "+" : "-");
 }
 
 int parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 {
-	unsigned char *block, *vendor, *monitor = NULL;
 	int i;
+	unsigned char *block;
+
+	if (edid == NULL || var == NULL)
+		return 1;
 
 	if (!(edid_checksum(edid)))
-		return 0;
+		return 1;
 
 	if (!(edid_check_header(edid)))
+		return 1;
+
+	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+
+	for (i = 0; i < 4; i++, block += DETAILED_TIMING_DESCRIPTION_SIZE) {
+		if (edid_is_timing_block(block)) {
+			var->xres = var->xres_virtual = H_ACTIVE;
+			var->yres = var->yres_virtual = V_ACTIVE;
+			var->height = var->width = -1;
+			var->right_margin = H_SYNC_OFFSET;
+			var->left_margin = (H_ACTIVE + H_BLANKING) -
+				(H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH);
+			var->upper_margin = V_BLANKING - V_SYNC_OFFSET - 
+				V_SYNC_WIDTH;
+			var->lower_margin = V_SYNC_OFFSET;
+			var->hsync_len = H_SYNC_WIDTH;
+			var->vsync_len = V_SYNC_WIDTH;
+			var->pixclock = PIXEL_CLOCK;
+			var->pixclock /= 1000;
+			var->pixclock = KHZ2PICOS(var->pixclock);
+
+			if (HSYNC_POSITIVE)
+				var->sync |= FB_SYNC_HOR_HIGH_ACT;
+			if (VSYNC_POSITIVE)
+				var->sync |= FB_SYNC_VERT_HIGH_ACT;
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static void calc_mode_timings(int xres, int yres, int refresh, struct fb_videomode *mode)
+{
+	struct fb_var_screeninfo var;
+	struct fb_info info;
+	
+	var.xres = xres;
+	var.yres = yres;
+	fb_get_mode(FB_VSYNCTIMINGS | FB_IGNOREMON, 
+		    refresh, &var, &info);
+	mode->xres = xres;
+	mode->yres = yres;
+	mode->pixclock = var.pixclock;
+	mode->refresh = refresh;
+	mode->left_margin = var.left_margin;
+	mode->right_margin = var.right_margin;
+	mode->upper_margin = var.upper_margin;
+	mode->lower_margin = var.lower_margin;
+	mode->hsync_len = var.hsync_len;
+	mode->vsync_len = var.vsync_len;
+	mode->vmode = 0;
+	mode->sync = 0;
+}
+
+static int get_est_timing(unsigned char *block, struct fb_videomode *mode)
+{
+	int num = 0;
+	unsigned char c;
+
+	c = block[0];
+	if (c&0x80) 
+		calc_mode_timings(720, 400, 70, &mode[num++]);
+	if (c&0x40) 
+		calc_mode_timings(720, 400, 88, &mode[num++]);
+	if (c&0x20)
+		mode[num++] = vesa_modes[3];
+	if (c&0x10)
+		calc_mode_timings(640, 480, 67, &mode[num++]);
+	if (c&0x08)
+		mode[num++] = vesa_modes[4];
+	if (c&0x04)
+		mode[num++] = vesa_modes[5];
+	if (c&0x02)
+		mode[num++] = vesa_modes[7];
+	if (c&0x01)
+		mode[num++] = vesa_modes[8];
+
+	c = block[1];
+	if (c&0x80)
+ 		mode[num++] = vesa_modes[9];
+	if (c&0x40)
+ 		mode[num++] = vesa_modes[10];
+	if (c&0x20)
+		calc_mode_timings(832, 624, 75, &mode[num++]);
+	if (c&0x10)
+		mode[num++] = vesa_modes[12];
+	if (c&0x08)
+		mode[num++] = vesa_modes[13];
+	if (c&0x04)
+		mode[num++] = vesa_modes[14];
+	if (c&0x02)
+		mode[num++] = vesa_modes[15];
+	if (c&0x01)
+		mode[num++] = vesa_modes[21];
+
+	c = block[2];
+	if (c&0x80)
+		mode[num++] = vesa_modes[17];
+
+	return num;
+}
+
+static int get_std_timing(unsigned char *block, struct fb_videomode *mode)
+{
+	int xres, yres = 0, refresh, ratio, i;
+	
+	xres = (block[0] + 31) * 8;
+	if (xres <= 256)
 		return 0;
 
-	printk("EDID ver %d rev %d\n", (int) edid[EDID_STRUCT_VERSION],
-	       (int) edid[EDID_STRUCT_REVISION]);
+	ratio = (block[1] & 0xc0) >> 6;
+	switch (ratio) {
+	case 0:
+		yres = xres;
+		break;
+	case 1:
+		yres = (xres * 3)/4;
+		break;
+	case 2:
+		yres = (xres * 4)/5;
+		break;
+	case 3:
+		yres = (xres * 9)/16;
+		break;
+	}
+	refresh = (block[1] & 0x3f) + 60;
 
-	vendor = edid_get_vendor(edid + ID_MANUFACTURER_NAME);
+	for (i = 0; i < VESA_MODEDB_SIZE; i++) {
+		if (vesa_modes[i].xres == xres && 
+		    vesa_modes[i].yres == yres &&
+		    vesa_modes[i].refresh == refresh) {
+			*mode = vesa_modes[i];
+			break;
+		} else {
+			calc_mode_timings(xres, yres, refresh, mode);
+			break;
+		}
+	}
+	return 1;
+}
 
-	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+static int get_dst_timing(unsigned char *block,
+			  struct fb_videomode *mode)
+{
+	int j, num = 0;
 
-	for (i = 0; i < 4; i++, block += DETAILED_TIMING_DESCRIPTION_SIZE) {
-		if (edid_is_monitor_block(block)) {
-			monitor = edid_get_monitor(block);
+	for (j = 0; j < 5; j++, block+= STD_TIMING_DESCRIPTION_SIZE) 
+		num += get_std_timing(block, &mode[num]);
+
+	return num;
+}
+
+static void get_detailed_timing(unsigned char *block, 
+				struct fb_videomode *mode)
+{
+	mode->xres = H_ACTIVE;
+	mode->yres = V_ACTIVE;
+	mode->pixclock = PIXEL_CLOCK;
+	mode->pixclock /= 1000;
+	mode->pixclock = KHZ2PICOS(mode->pixclock);
+	mode->right_margin = H_SYNC_OFFSET;
+	mode->left_margin = (H_ACTIVE + H_BLANKING) -
+		(H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH);
+	mode->upper_margin = V_BLANKING - V_SYNC_OFFSET - 
+		V_SYNC_WIDTH;
+	mode->lower_margin = V_SYNC_OFFSET;
+	mode->hsync_len = H_SYNC_WIDTH;
+	mode->vsync_len = V_SYNC_WIDTH;
+	if (HSYNC_POSITIVE)
+		mode->sync |= FB_SYNC_HOR_HIGH_ACT;
+	if (VSYNC_POSITIVE)
+		mode->sync |= FB_SYNC_VERT_HIGH_ACT;
+	mode->refresh = PIXEL_CLOCK/((H_ACTIVE + H_BLANKING) *
+				     (V_ACTIVE + V_BLANKING));
+	mode->vmode = 0;
+}
+
+/**
+ * fb_create_modedb - create video mode database
+ * @edid: EDID data
+ * @dbsize: database size
+ *
+ * RETURNS: struct fb_videomode, @dbsize contains length of database
+ *
+ * DESCRIPTION:
+ * This function builds a mode database using the contents of the EDID
+ * data
+ */
+struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
+{
+	struct fb_videomode *mode, *m;
+	unsigned char *block;
+	int num = 0, i;
+
+	mode = kmalloc(50 * sizeof(struct fb_videomode), GFP_KERNEL);
+	if (mode == NULL)
+		return NULL;
+	memset(mode, 0, 50 * sizeof(struct fb_videomode));
+
+	if (edid == NULL || !edid_checksum(edid) || 
+	    !edid_check_header(edid))
+		return NULL;
+	
+	*dbsize = 0;
+
+	block = edid + ESTABLISHED_TIMING_1;
+	num += get_est_timing(block, &mode[num]);
+
+	block = edid + STD_TIMING_DESCRIPTIONS_START;
+	for (i = 0; i < STD_TIMING; i++, block += STD_TIMING_DESCRIPTION_SIZE) 
+		num += get_std_timing(block, &mode[num]);
+
+	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+	for (i = 0; i < 4; i++, block+= DETAILED_TIMING_DESCRIPTION_SIZE) {
+		if (block[0] == 0x00 && block[1] == 0x00) {
+			if (block[3] == 0xfa) {
+				num += get_dst_timing(block + 5, &mode[num]);
+			}
+		} else  {
+			get_detailed_timing(block, &mode[num]);
+			num++;
 		}
 	}
+	
+	if (!num)
+		return NULL;
+
+	*dbsize = num;
+	m = kmalloc(num * sizeof(struct fb_videomode), GFP_KERNEL);
+	if (!m)
+		return mode;
+	memmove(m, mode, num * sizeof(struct fb_videomode));
+	kfree(mode);
+	return m;
+}
+
+/**
+ * fb_destroy_modedb - destroys mode database
+ * @modedb: mode database to destroy
+ *
+ * DESCRIPTION:
+ * Destroy mode database created by fb_create_modedb
+ */
+void fb_destroy_modedb(struct fb_videomode *modedb)
+{
+	kfree(modedb);
+}
+
+/**
+ * fb_get_monitor_limits - get monitor operating limits
+ * @edid: EDID data
+ * @specs: fb_monspecs structure pointer
+ *
+ * DESCRIPTION:
+ * Gets monitor operating limits from EDID data and places them in 
+ * @specs
+ */
+int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs)
+{
+	int i;
+	unsigned char *block;
 
-	printk("EDID: detected %s %s\n", vendor, monitor);
+	if (edid == NULL || specs == NULL)
+		return 1;
+
+	if (!(edid_checksum(edid)))
+		return 1;
 
+	if (!(edid_check_header(edid)))
+		return 1;
+
+	memset(specs, 0, sizeof(struct fb_monspecs));
 	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
 
 	for (i = 0; i < 4; i++, block += DETAILED_TIMING_DESCRIPTION_SIZE) {
-		if (edid_is_timing_block(block)) {
-			parse_timing_block(block, var);
+		if (edid_is_limits_block(block)) {
+			specs->hfmin = H_MIN_RATE * 1000;
+			specs->hfmax = H_MAX_RATE * 1000;
+			specs->vfmin = V_MIN_RATE;
+			specs->vfmax = V_MAX_RATE;
+			specs->dclkmax = (MAX_PIXEL_CLOCK != 10*0xff) ?
+				MAX_PIXEL_CLOCK * 1000000 : 0;
+			specs->gtf = (GTF_SUPPORT) ? 1 : 0;
+			specs->dpms = edid[DPMS_FLAGS];
+			return 0;
 		}
 	}
 	return 1;
 }
 
+void show_edid(unsigned char *edid)
+{
+	unsigned char *block;
+	int i;
+
+	if (edid == NULL)
+		return;
+
+	if (!(edid_checksum(edid)))
+		return;
+
+	if (!(edid_check_header(edid)))
+		return;
+	printk("========================================\n");
+	printk("Display Information (EDID)\n");
+	printk("========================================\n");
+	printk("   EDID Version %d.%d\n", (int) edid[EDID_STRUCT_VERSION],
+	       (int) edid[EDID_STRUCT_REVISION]);
+
+	parse_vendor_block(edid + ID_MANUFACTURER_NAME);
+
+	printk("   Display Characteristics:\n");
+	parse_display_block(edid + EDID_STRUCT_DISPLAY);
+
+	printk("   Standard Timings\n");
+	block = edid + STD_TIMING_DESCRIPTIONS_START;
+	for (i = 0; i < STD_TIMING; i++, block += STD_TIMING_DESCRIPTION_SIZE) 
+		parse_std_timing_block(block);
+
+	printk("   Supported VESA Modes\n");
+	parse_std_md_block(edid + ESTABLISHED_TIMING_1);
+
+	printk("   Detailed Monitor Information\n");
+	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+	for (i = 0; i < 4; i++, block += DETAILED_TIMING_DESCRIPTION_SIZE) {
+		if (edid_is_serial_block(block)) {
+			parse_serial_block(block);
+		} else if (edid_is_ascii_block(block)) {
+			parse_ascii_block(block);
+		} else if (edid_is_limits_block(block)) {
+			parse_limits_block(block);
+		} else if (edid_is_monitor_block(block)) {
+			parse_monitor_block(block);
+		} else if (edid_is_color_block(block)) {
+			parse_color_block(block);
+		} else if (edid_is_std_timings_block(block)) {
+			parse_dst_timing_block(block);
+		} else if (edid_is_timing_block(block)) {
+			parse_detailed_timing_block(block);
+		}
+	}
+	printk("========================================\n");
+}
+
 #ifdef CONFIG_PCI
 char *get_EDID(struct pci_dev *pdev)
 {
+	unsigned char *pedid = NULL;
 #ifdef CONFIG_ALL_PPC
 	static char *propnames[] =
 	    { "DFP,EDID", "LCD,EDID", "EDID", "EDID1", NULL };
-	unsigned char *pedid = NULL;
 	struct device_node *dp;
 	int i;
 
+	if (pdev == NULL)
+		return NULL;
 	dp = pci_device_to_OF_node(pdev);
 	while (dp != NULL) {
 		for (i = 0; propnames[i] != NULL; ++i) {
@@ -285,10 +725,9 @@
 		}
 		dp = dp->child;
 	}
-	return pedid;
-#else
-	return NULL;
 #endif
+	show_edid(pedid);
+	return pedid;
 }
 #endif
 
@@ -679,8 +1118,12 @@
 }
 
 EXPORT_SYMBOL(parse_edid);
+EXPORT_SYMBOL(show_edid);
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL(get_EDID);
 #endif
+EXPORT_SYMBOL(fb_get_monitor_limits);
 EXPORT_SYMBOL(fb_get_mode);
 EXPORT_SYMBOL(fb_validate_mode);
+EXPORT_SYMBOL(fb_create_modedb);
+EXPORT_SYMBOL(fb_destroy_modedb);
diff -Naur linux-2.5.66-orig/drivers/video/modedb.c linux-2.5.66-fbdev/drivers/video/modedb.c
--- linux-2.5.66-orig/drivers/video/modedb.c	2003-03-29 12:37:03.000000000 +0000
+++ linux-2.5.66-fbdev/drivers/video/modedb.c	2003-04-01 14:30:19.000000000 +0000
@@ -251,6 +251,110 @@
     },
 };
 
+const struct fb_videomode vesa_modes[] = {
+	/* 0 640x350-85 VESA */
+	{ NULL, 85, 640, 350, 31746,  96, 32, 60, 32, 64, 3,
+	  FB_SYNC_HOR_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 1 640x400-85 VESA */
+	{ NULL, 85, 640, 400, 31746,  96, 32, 41, 01, 64, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 2 720x400-85 VESA */
+	{ NULL, 85, 721, 400, 28169, 108, 36, 42, 01, 72, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 3 640x480-60 VESA */
+	{ NULL, 60, 640, 480, 39682,  48, 16, 33, 10, 96, 2, 
+	  0, FB_VMODE_NONINTERLACED },
+	/* 4 640x480-72 VESA */
+	{ NULL, 72, 640, 480, 31746, 128, 24, 29, 9, 40, 2, 
+	  0, FB_VMODE_NONINTERLACED },
+	/* 5 640x480-75 VESA */
+	{ NULL, 75, 640, 480, 31746, 120, 16, 16, 01, 64, 3,
+	  0, FB_VMODE_NONINTERLACED },
+	/* 6 640x480-85 VESA */
+	{ NULL, 85, 640, 480, 27777, 80, 56, 25, 01, 56, 3,
+	  0, FB_VMODE_NONINTERLACED },
+	/* 7 800x600-56 VESA */
+	{ NULL, 56, 800, 600, 27777, 128, 24, 22, 01, 72, 2,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 8 800x600-60 VESA */
+	{ NULL, 60, 800, 600, 25000, 88, 40, 23, 01, 128, 4,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 9 800x600-72 VESA */
+	{ NULL, 72, 800, 600, 20000, 64, 56, 23, 37, 120, 6,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 10 800x600-75 VESA */
+	{ NULL, 75, 800, 600, 20202, 160, 16, 21, 01, 80, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 11 800x600-85 VESA */
+	{ NULL, 85, 800, 600, 17761, 152, 32, 27, 01, 64, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+        /* 12 1024x768i-43 VESA */
+	{ NULL, 53, 1024, 768, 22271, 56, 8, 41, 0, 176, 8,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_INTERLACED },
+	/* 13 1024x768-60 VESA */
+	{ NULL, 60, 1024, 768, 15384, 160, 24, 29, 3, 136, 6,
+	  0, FB_VMODE_NONINTERLACED },
+	/* 14 1024x768-70 VESA */
+	{ NULL, 70, 1024, 768, 13333, 144, 24, 29, 3, 136, 6,
+	  0, FB_VMODE_NONINTERLACED },
+	/* 15 1024x768-75 VESA */
+	{ NULL, 75, 1024, 768, 12690, 176, 16, 28, 1, 96, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 16 1024x768-85 VESA */
+	{ NULL, 85, 1024, 768, 10582, 208, 48, 36, 1, 96, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 17 1152x864-75 VESA */
+	{ NULL, 75, 1153, 864, 9259, 256, 64, 32, 1, 128, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 18 1280x960-60 VESA */
+	{ NULL, 60, 1280, 960, 9259, 312, 96, 36, 1, 112, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 19 1280x960-85 VESA */
+	{ NULL, 85, 1280, 960, 6734, 224, 64, 47, 1, 160, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 20 1280x1024-60 VESA */
+	{ NULL, 60, 1280, 1024, 9259, 248, 48, 38, 1, 112, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 21 1280x1024-75 VESA */
+	{ NULL, 75, 1280, 1024, 7407, 248, 16, 38, 1, 144, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 22 1280x1024-85 VESA */
+	{ NULL, 85, 1280, 1024, 6349, 224, 64, 44, 1, 160, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 23 1600x1200-60 VESA */
+	{ NULL, 60, 1600, 1200, 6172, 304, 64, 46, 1, 192, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 24 1600x1200-65 VESA */
+	{ NULL, 65, 1600, 1200, 5698, 304,  64, 46, 1, 192, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 25 1600x1200-70 VESA */
+	{ NULL, 70, 1600, 1200, 5291, 304, 64, 46, 1, 192, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 26 1600x1200-75 VESA */
+	{ NULL, 75, 1600, 1200, 4938, 304, 64, 46, 1, 192, 3, 
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 27 1600x1200-85 VESA */
+	{ NULL, 85, 1600, 1200, 4357, 304, 64, 46, 1, 192, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 28 1792x1344-60 VESA */
+	{ NULL, 60, 1792, 1344, 4882, 328, 128, 46, 1, 200, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 29 1792x1344-75 VESA */
+	{ NULL, 75, 1792, 1344, 3831, 352, 96, 69, 1, 216, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 30 1856x1392-60 VESA */
+	{ NULL, 60, 1856, 1392, 4580, 352, 96, 43, 1, 224, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 31 1856x1392-75 VESA */
+	{ NULL, 75, 1856, 1392, 3472, 352, 128, 104, 1, 224, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 32 1920x1440-60 VESA */
+	{ NULL, 60, 1920, 1440, 4273, 344, 128, 56, 1, 200, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 33 1920x1440-75 VESA */
+	{ NULL, 60, 1920, 1440, 3367, 352, 144, 56, 1, 224, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+};
 
 static int __init my_atoi(const char *name)
 {
@@ -432,3 +536,4 @@
 }
 
 EXPORT_SYMBOL(__fb_try_mode);
+EXPORT_SYMBOL(vesa_modes);
diff -Naur linux-2.5.66-orig/include/linux/fb.h linux-2.5.66-fbdev/include/linux/fb.h
--- linux-2.5.66-orig/include/linux/fb.h	2003-03-29 21:09:54.000000000 +0000
+++ linux-2.5.66-fbdev/include/linux/fb.h	2003-04-01 14:32:40.000000000 +0000
@@ -505,6 +505,16 @@
 		       struct fb_info *info);
 extern int fb_validate_mode(struct fb_var_screeninfo *var,
 			    struct fb_info *info);
+extern int parse_edid(unsigned char *edid, struct fb_var_screeninfo *var);
+extern char *get_EDID(struct pci_dev *pdev);
+extern void show_edid(unsigned char *edid);
+extern int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs);
+extern struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize);
+extern void fb_destroy_modedb(struct fb_videomode *modedb);
+
+/* drivers/video/modedb.c */
+#define VESA_MODEDB_SIZE 34
+extern const struct fb_videomode vesa_modes[];
 
 /* drivers/video/fbcmap.c */
 extern int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp);





-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
