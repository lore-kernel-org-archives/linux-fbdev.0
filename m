From: Antonino Daplas <adaplas@pol.net>
Subject: Reading the EDID block for x86 machines
Date: 11 Mar 2003 20:49:46 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047386934.1113.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Jn5jj8Oc5LQ68XZpXonL"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sjFb-0007ny-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 04:52:59 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-Jn5jj8Oc5LQ68XZpXonL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I was wondering how to get the EDID block, and my first thought was to
implement DDC.  But it is tricky to implement, so why not just get the
EDID using an int 0x10 BIOS call?

The EDID block can be read before the kernel goes into protected mode
(just a short assembly code in arch/i386/boot/video.S) and this can be
saved later on as struct edid_info during the kernel's setup routine.  

One catch though is that that the "empty_zero_page" is becoming too
tight, so it will just use the same offset used by the EDD (BIOS
Enhanced Disk Drive).  So EDID reading will be disabled if EDD is
enabled under the "Processor Type and Features"  option.

Then, we can also make EDID parsing more powerful.  I've added some code
in fbmon.c to parse the EDID block in more detail.  It should be able to
parse almost everything (except the color point).  Currently, it just
prints all the information it can find.  However, I haven't tested if
parsing the Detailed Monitor information is correct since the EDID block
of the monitor I'm using is incomplete.

One of the goals is to build a video data structure that also includes a
database of video mode in fb_videomode format.  This can be dynamically
created per device using the supported VESA modes, manufacturer's mode
and detailed timings mode information in the EDID block. The EDID block
also contain information on GTF capability.  With these types of
displays, a video mode mode database may not be needed since all
possible supported modelines can be calculated.

The advantage of the above is that the driver can switch to different
modes without relying on user input (of course, user-entered modelines
are still preferred).

Anyway, I need help in testing the code (especially the Detailed
Information part).  Just apply the attached patch, disable Enhanced Disk
Driver support (under Processor Type and Features), and enable EDID
support (under Graphics option).  Finally, add the following line to the
fbdev driver that you use (anywhere, but a good place is the init code):

show_edid(get_EDID(pci_dev))

If using an x86 machine

show_edid(get_EDID(NULL)) 

should also work.

Reboot, check dmesg, and kindly post the ouput.  Thanks.

Tony

PS:  The patch is against linux-2.5.64 + fbdev.diff.gz



--=-Jn5jj8Oc5LQ68XZpXonL
Content-Disposition: attachment; filename=edid.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=edid.diff; charset=ANSI_X3.4-1968

diff -Naur linux-2.5.64-fbdev/arch/i386/boot/compressed/misc.c linux-2.5.64=
/arch/i386/boot/compressed/misc.c
--- linux-2.5.64-fbdev/arch/i386/boot/compressed/misc.c	2003-02-16 00:47:53=
.000000000 +0000
+++ linux-2.5.64/arch/i386/boot/compressed/misc.c	2003-03-11 02:39:51.00000=
0000 +0000
@@ -91,6 +91,7 @@
 #define ALT_MEM_K   (*(unsigned long *)(real_mode + 0x1e0))
 #endif
 #define SCREEN_INFO (*(struct screen_info *)(real_mode+0))
+#define EDID_INFO   (*(struct edid_info   *)(real_mode+0x600))
=20
 extern char input_data[];
 extern int input_len;
diff -Naur linux-2.5.64-fbdev/arch/i386/boot/video.S linux-2.5.64/arch/i386=
/boot/video.S
--- linux-2.5.64-fbdev/arch/i386/boot/video.S	2002-12-16 02:07:50.000000000=
 +0000
+++ linux-2.5.64/arch/i386/boot/video.S	2003-03-11 02:39:53.000000000 +0000
@@ -135,6 +135,7 @@
 #endif /* CONFIG_VIDEO_RETAIN */
 #endif /* CONFIG_VIDEO_SELECT */
 	call	mode_params			# Store mode parameters
+	call	store_edid
 	popw	%ds				# Restore original DS
 	ret
=20
@@ -1887,6 +1888,50 @@
 	popw	%ax
 	ret
=20
+#if defined(CONFIG_EDID)
+	store_edid:
+	pushw	%es				# just save all affected=20
+	pushw	%ax				# affected registers
+	pushw	%bx
+	pushw   %cx
+	pushw	%dx
+	pushw   %di
+
+	pushw	%fs                            =20
+	popw    %es
+
+	call	store_edid_magic              =20
+	call	read_edid
+
+	popw	%di				# restore all registers       =20
+	popw	%dx
+	popw	%cx
+	popw	%bx
+	popw	%ax
+	popw	%es=09
+	ret
+
+store_edid_magic:=09
+	movb	$0x13, %al=20
+	movw    $128, %cx
+	movw	$0x600, %di
+	cld
+	rep=20
+	stosb =20
+	ret
+read_edid:=09
+	movw	$0x4f15, %ax
+	movw	$0x01, %bx
+	movw	$0x00, %cx
+	movw    $0x01, %dx
+	movw	$0x600, %di
+	int	$0x10=09
+	ret
+#else
+store_edid:
+	ret
+#endif
+
 # VIDEO_SELECT-only variables
 mt_end:		.word	0	# End of video mode table if built
 edit_buf:	.space	6	# Line editor buffer
diff -Naur linux-2.5.64-fbdev/arch/i386/kernel/setup.c linux-2.5.64/arch/i3=
86/kernel/setup.c
--- linux-2.5.64-fbdev/arch/i386/kernel/setup.c	2003-03-11 02:30:07.0000000=
00 +0000
+++ linux-2.5.64/arch/i386/kernel/setup.c	2003-03-11 02:52:09.000000000 +00=
00
@@ -80,6 +80,7 @@
  */
 struct drive_info_struct { char dummy[32]; } drive_info;
 struct screen_info screen_info;
+struct edid_info   edid_info;
 struct apm_info apm_info;
 struct sys_desc_table_struct {
 	unsigned short length;
@@ -495,6 +496,23 @@
 #define copy_edd() do {} while (0)
 #endif
=20
+#if defined(CONFIG_EDID)
+/*
+ * Since empty_zero_page has a limited size, we are going to use the
+ * same offset as EDD.  Thus, copying of the EDID block will only be
+ * enabled if EDD is disabled. =20
+ */
+static inline void copy_edid(void)
+{
+	edid_info =3D EDID_INFO;
+}
+#else
+static inline void copy_edid(void)
+{
+	memset(&edid_info, 0x13, 128);
+}
+#endif
+
 /*
  * Do NOT EVER look at the BIOS memory size location.
  * It does not work on many machines.
@@ -862,6 +880,7 @@
  	ROOT_DEV =3D ORIG_ROOT_DEV;
  	drive_info =3D DRIVE_INFO;
  	screen_info =3D SCREEN_INFO;
+	copy_edid();
 	apm_info.bios =3D APM_BIOS_INFO;
 	saved_videomode =3D VIDEO_MODE;
 	printk("Video mode to be used for restore is %lx\n", saved_videomode);
diff -Naur linux-2.5.64-fbdev/drivers/video/Kconfig linux-2.5.64/drivers/vi=
deo/Kconfig
--- linux-2.5.64-fbdev/drivers/video/Kconfig	2003-03-11 02:30:31.000000000 =
+0000
+++ linux-2.5.64/drivers/video/Kconfig	2003-03-11 02:41:18.000000000 +0000
@@ -4,6 +4,10 @@
=20
 menu "Graphics support"
=20
+config EDID
+	bool "Get EDID block from VBE"
+	depends on X86 && !EDD
+         =20
 config FB
 	bool "Support for frame buffer devices"
 	---help---
diff -Naur linux-2.5.64-fbdev/drivers/video/fbmon.c linux-2.5.64/drivers/vi=
deo/fbmon.c
--- linux-2.5.64-fbdev/drivers/video/fbmon.c	2003-03-11 02:30:32.000000000 =
+0000
+++ linux-2.5.64/drivers/video/fbmon.c	2003-03-11 11:39:19.000000000 +0000
@@ -11,9 +11,6 @@
 #include <linux/tty.h>
 #include <linux/fb.h>
 #include <linux/module.h>
-#ifdef CONFIG_PCI
-#include <linux/pci.h>
-#endif
 #ifdef CONFIG_ALL_PPC
 #include <asm/prom.h>
 #endif
@@ -41,11 +38,18 @@
 #define EDID_STRUCT_VERSION			0x12
 #define EDID_STRUCT_REVISION			0x13
=20
+#define EDID_STRUCT_DISPLAY                     0x14
+
 #define DPMS_FLAGS				0x18
 #define ESTABLISHED_TIMING_1			0x23
 #define ESTABLISHED_TIMING_2			0x24
 #define MANUFACTURERS_TIMINGS			0x25
=20
+/* standard timings supported */
+#define STD_TIMING                              8
+#define STD_TIMING_DESCRIPTION_SIZE             2
+#define STD_TIMING_DESCRIPTIONS_START           0x26
+
 #define DETAILED_TIMING_DESCRIPTIONS_START	0x36
 #define DETAILED_TIMING_DESCRIPTION_SIZE	18
 #define NO_DETAILED_TIMING_DESCRIPTIONS		4
@@ -124,11 +128,32 @@
 #define HSYNC_POSITIVE     (FLAGS & 4)
 #define VSYNC_POSITIVE     (FLAGS & 2)
=20
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
 const unsigned char edid_v1_header[] =3D { 0x00, 0xff, 0xff, 0xff,
 	0xff, 0xff, 0xff, 0x00
 };
 const unsigned char edid_v1_descriptor_flag[] =3D { 0x00, 0x00 };
=20
+static void copy_string(unsigned char *c, unsigned char *s)
+{
+  int i;
+  c =3D c + 5;
+  for (i =3D 0; (i < 13 && *c !=3D 0x0A); i++)
+    *(s++) =3D *(c++);
+  *s =3D 0;
+  while (i-- && (*--s =3D=3D 0x20)) *s =3D 0;
+}
+
 static int edid_checksum(unsigned char *edid)
 {
 	unsigned char i, csum =3D 0;
@@ -157,37 +182,144 @@
 	return 1;
 }
=20
-
-static char *edid_get_vendor(unsigned char *block)
+static void parse_vendor_block(unsigned char *block)
 {
-	static char sign[4];
-	unsigned short h;
-
-	h =3D COMBINE_HI_8LO(block[0], block[1]);
-	sign[0] =3D ((h >> 10) & 0x1f) + 'A' - 1;
-	sign[1] =3D ((h >> 5) & 0x1f) + 'A' - 1;
-	sign[2] =3D (h & 0x1f) + 'A' - 1;
-	sign[3] =3D 0;
+	unsigned char c[4];
=20
-	return sign;
+	c[0] =3D ((block[0] & 0x7c) >> 2) + '@';
+	c[1] =3D ((block[0] & 0x03) << 3) + ((block[1] & 0xe0) >> 5) + '@';
+	c[2] =3D (block[1] & 0x1f) + '@';
+	c[3] =3D 0;
+	printk("   Manufacturer: %s ", c);
+	printk("Model: %x ", block[2] + (block[3] << 8));
+	printk("Serial#: %u\n", block[4] + (block[5] << 8) +=20
+	       (block[6] << 16) + (block[7] << 24));
+	printk("   Year: %u Week %u\n", block[9] + 1990, block[8]);
+}
+
+static void parse_dpms_capabilities(unsigned char flags)
+{
+	printk("      DPMS: Active %s, Suspend %s, Standby %s\n",
+	       (flags & DPMS_ACTIVE_OFF) ? "yes" : "no",
+	       (flags & DPMS_SUSPEND)    ? "yes" : "no",
+	       (flags & DPMS_STANDBY)    ? "yes" : "no");
 }
-
-static char *edid_get_monitor(unsigned char *block)
+=09
+static void parse_display_block(unsigned char *block)
 {
-	static char name[13];
-	unsigned i;
-	const unsigned char *ptr =3D block + DESCRIPTOR_DATA;
+	unsigned char c;
=20
-	for (i =3D 0; i < 13; i++, ptr++) {
-		if (*ptr =3D=3D 0xa) {
-			name[i] =3D 0x00;
-			return name;
+	c =3D (block[0] & 0x80) >> 7;
+	if (c)=20
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
-		name[i] =3D *ptr;
+		printk("\n");
 	}
-	return name;
-}
+	c =3D (block[0] & 0x10) >> 4;
+	if (c)
+		printk("      Configurable signal level\n");
+	printk("      Sync: ");
+	c =3D block[0] & 0x0f;
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
+	c =3D block[1];
+	if (c)=20
+		printk("%d\n", c);
+	else
+		printk("variable\n");
+=09
+	printk("      Max V-size in cm: ");
+	c =3D block[2];
+	if (c)
+		printk("%d\n", c);
+	else
+		printk("variable\n");
=20
+	c =3D block[3];
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
+	}
+	c =3D block[4] & 0x7;
+	if (c & 0x04)
+		printk("      Default color format is primary\n");
+	if (c & 0x02)
+		printk("      First DETAILED Timing is preferred\n");
+	if (c & 0x01)
+		printk("      Display is GTF capable\n");
+}
+
+static void parse_std_md_block(unsigned char *block)
+{
+	unsigned char c;
+
+	c =3D block[0];
+	if (c&0x80) printk("      720x400@70Hz\n");
+	if (c&0x40) printk("      720x400@88Hz\n");
+	if (c&0x20) printk("      640x480@60Hz\n");
+	if (c&0x10) printk("      640x480@67Hz\n");
+	if (c&0x08) printk("      640x480@72Hz\n");
+	if (c&0x04) printk("      640x480@75Hz\n");
+	if (c&0x02) printk("      800x600@56Hz\n");
+	if (c&0x01) printk("      800x600@60Hz\n");
+
+	c =3D block[1];
+	if (c&0x80) printk("      800x600@72Hz\n");
+	if (c&0x40) printk("      800x600@75Hz\n");
+	if (c&0x20) printk("      832x624@75Hz\n");
+	if (c&0x10) printk("      1024x768@87Hz (interlaced)\n");
+	if (c&0x08) printk("      1024x768@60Hz\n");
+	if (c&0x04) printk("      1024x768@70Hz\n");
+	if (c&0x02) printk("      1024x768@75Hz\n");
+	if (c&0x01) printk("      1280x1024@75Hz\n");
+
+	c =3D block[2];
+	if (c&0x80) printk("      1152x870@75Hz\n");
+	printk("      Manufacturer's mask: %x\n",c&0x7F);
+}
+	=09
+	=09
 static int edid_is_timing_block(unsigned char *block)
 {
 	if ((block[0] =3D=3D 0x00) && (block[1] =3D=3D 0x00))
@@ -196,6 +328,30 @@
 		return 1;
 }
=20
+static int edid_is_serial_block(unsigned char *block)
+{
+	if ((block[0] =3D=3D 0x00) && (block[1] =3D=3D 0x00) && (block[3] =3D=3D =
0xff))
+		return 1;
+	else
+		return 0;
+}
+
+static int edid_is_ascii_block(unsigned char *block)
+{
+	if ((block[0] =3D=3D 0x00) && (block[1] =3D=3D 0x00) && (block[3] =3D=3D =
0xfe))
+		return 1;
+	else
+		return 0;
+}
+
+static int edid_is_limits_block(unsigned char *block)
+{
+	if ((block[0] =3D=3D 0x00) && (block[1] =3D=3D 0x00) && (block[3] =3D=3D =
0xfd))
+		return 1;
+	else
+		return 0;
+}
+
 static int edid_is_monitor_block(unsigned char *block)
 {
 	if ((block[0] =3D=3D 0x00) && (block[1] =3D=3D 0x00) && (block[3] =3D=3D =
0xfc))
@@ -204,65 +360,219 @@
 		return 0;
 }
=20
-static void parse_timing_block(unsigned char *block,
-			       struct fb_var_screeninfo *var)
+static int edid_is_color_block(unsigned char *block)
+{
+	if ((block[0] =3D=3D 0x00) && (block[1] =3D=3D 0x00) && (block[3] =3D=3D =
0xfb))
+		return 1;
+	else
+		return 0;
+}
+
+static int edid_is_std_timings_block(unsigned char *block)
+{
+	if ((block[0] =3D=3D 0x00) && (block[1] =3D=3D 0x00) && (block[3] =3D=3D =
0xfa))
+		return 1;
+	else
+		return 0;
+}
+
+static void parse_serial_block(unsigned char *block)
+{
+	unsigned char c[13];
+=09
+	copy_string(block, c);
+	printk("      Serial No: %s\n", c);
+}
+
+static void parse_ascii_block(unsigned char *block)
+{
+	unsigned char c[13];
+=09
+	copy_string(block, c);
+	printk("      %s\n", c);
+}
+
+static void parse_limits_block(unsigned char *block)
+{
+	printk("      HorizSync  : %d-%d KHz\n", H_MIN_RATE, H_MAX_RATE);
+	printk("      VertRefresh: %d-%d Hz\n", V_MIN_RATE, V_MAX_RATE);
+	if (MAX_PIXEL_CLOCK !=3D 10*0xff)
+		printk("      Max Pixelclock %d MHz\n", (int) MAX_PIXEL_CLOCK);
+}
+
+static void parse_monitor_block(unsigned char *block)
+{
+	unsigned char c[13];
+=09
+	copy_string(block, c);
+	printk("      Monitor Name: %s\n", c);
+}
+
+static void parse_color_block(unsigned char *block)
+{
+	printk("      Color Point: unimplemented\n");
+}
+
+static void parse_std_timing_block(unsigned char *block)
 {
-	var->xres =3D var->xres_virtual =3D H_ACTIVE;
-	var->yres =3D var->yres_virtual =3D V_ACTIVE;
-	var->height =3D var->width =3D -1;
-	var->right_margin =3D H_SYNC_OFFSET;
-	var->left_margin =3D (H_ACTIVE + H_BLANKING) -
-	    (H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH);
-	var->upper_margin =3D V_BLANKING - V_SYNC_OFFSET - V_SYNC_WIDTH;
-	var->lower_margin =3D V_SYNC_OFFSET;
-	var->hsync_len =3D H_SYNC_WIDTH;
-	var->vsync_len =3D V_SYNC_WIDTH;
-	var->pixclock =3D PIXEL_CLOCK;
-	var->pixclock /=3D 1000;
-	var->pixclock =3D KHZ2PICOS(var->pixclock);
-
-	if (HSYNC_POSITIVE)
-		var->sync |=3D FB_SYNC_HOR_HIGH_ACT;
-	if (VSYNC_POSITIVE)
-		var->sync |=3D FB_SYNC_VERT_HIGH_ACT;
+	int xres, yres =3D 0, refresh, ratio, err =3D 1;
+=09
+	xres =3D (block[0] + 31) * 8;
+	ratio =3D (block[1] & 0xc0) >> 6;
+	switch (ratio) {
+	case 1:
+		yres =3D xres;
+		break;
+	case 2:
+		yres =3D (xres * 3)/4;
+		break;
+	case 3:
+		yres =3D (xres * 4)/5;
+		break;
+	case 4:
+		yres =3D (xres * 9)/16;
+		break;
+	}
+	refresh =3D (block[1] & 0x3f) + 60;
+	printk("      %dx%d@%dHz\n", xres, yres, refresh);
+	err =3D 0;
+}
+
+static void parse_detailed_timing_block(unsigned char *block)
+{
+	printk("      %d MHz ",  PIXEL_CLOCK);
+	printk("%d %d %d %d ", H_ACTIVE, H_ACTIVE + H_SYNC_OFFSET,=20
+	       H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH, H_ACTIVE + H_BLANKING);
+	printk("%d %d %d %d ", V_ACTIVE, V_ACTIVE + V_SYNC_OFFSET,=20
+	       V_ACTIVE + V_SYNC_OFFSET + V_SYNC_WIDTH, V_ACTIVE + V_BLANKING);
+	printk("%sHSync %sVSync\n\n", (HSYNC_POSITIVE) ? "+" : "-",=20
+	       (VSYNC_POSITIVE) ? "+" : "-");
 }
=20
 int parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 {
-	unsigned char *block, *vendor, *monitor =3D NULL;
 	int i;
+	unsigned char *block;
+
+	if (edid =3D=3D NULL || var =3D=3D NULL)
+		return 1;
=20
 	if (!(edid_checksum(edid)))
-		return 0;
+		return 1;
=20
 	if (!(edid_check_header(edid)))
-		return 0;
-
-	printk("EDID ver %d rev %d\n", (int) edid[EDID_STRUCT_VERSION],
-	       (int) edid[EDID_STRUCT_REVISION]);
-
-	vendor =3D edid_get_vendor(edid + ID_MANUFACTURER_NAME);
+		return 1;
=20
 	block =3D edid + DETAILED_TIMING_DESCRIPTIONS_START;
=20
 	for (i =3D 0; i < 4; i++, block +=3D DETAILED_TIMING_DESCRIPTION_SIZE) {
-		if (edid_is_monitor_block(block)) {
-			monitor =3D edid_get_monitor(block);
+		if (edid_is_timing_block(block)) {
+			var->xres =3D var->xres_virtual =3D H_ACTIVE;
+			var->yres =3D var->yres_virtual =3D V_ACTIVE;
+			var->height =3D var->width =3D -1;
+			var->right_margin =3D H_SYNC_OFFSET;
+			var->left_margin =3D (H_ACTIVE + H_BLANKING) -
+				(H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH);
+			var->upper_margin =3D V_BLANKING - V_SYNC_OFFSET -=20
+				V_SYNC_WIDTH;
+			var->lower_margin =3D V_SYNC_OFFSET;
+			var->hsync_len =3D H_SYNC_WIDTH;
+			var->vsync_len =3D V_SYNC_WIDTH;
+			var->pixclock =3D PIXEL_CLOCK;
+			var->pixclock /=3D 1000;
+			var->pixclock =3D KHZ2PICOS(var->pixclock);
+
+			if (HSYNC_POSITIVE)
+				var->sync |=3D FB_SYNC_HOR_HIGH_ACT;
+			if (VSYNC_POSITIVE)
+				var->sync |=3D FB_SYNC_VERT_HIGH_ACT;
+			return 0;
 		}
 	}
+	return 1;
+}
=20
-	printk("EDID: detected %s %s\n", vendor, monitor);
+int get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs)
+{
+	int i;
+	unsigned char *block;
+
+	if (edid =3D=3D NULL || specs =3D=3D NULL)
+		return 1;
+
+	if (!(edid_checksum(edid)))
+		return 1;
+
+	if (!(edid_check_header(edid)))
+		return 1;
=20
 	block =3D edid + DETAILED_TIMING_DESCRIPTIONS_START;
=20
 	for (i =3D 0; i < 4; i++, block +=3D DETAILED_TIMING_DESCRIPTION_SIZE) {
-		if (edid_is_timing_block(block)) {
-			parse_timing_block(block, var);
+		if (edid_is_limits_block(block)) {
+			specs->hfmin =3D H_MIN_RATE * 1000;
+			specs->hfmax =3D H_MAX_RATE * 1000;
+			specs->vfmin =3D V_MIN_RATE;
+			specs->vfmax =3D V_MAX_RATE;
+			specs->dclkmax =3D (MAX_PIXEL_CLOCK !=3D 10*0xff) ?
+				MAX_PIXEL_CLOCK * 1000000 : 0;
+			specs->gtf =3D (GTF_SUPPORT) ? 1 : 0;
+			specs->dpms =3D edid[DPMS_FLAGS];
+			return 0;
 		}
 	}
 	return 1;
 }
=20
+void show_edid(unsigned char *edid)
+{
+	unsigned char *block;
+	int i;
+
+	if (edid =3D=3D NULL)
+		return;
+
+	if (!(edid_checksum(edid)))
+		return;
+
+	if (!(edid_check_header(edid)))
+		return;
+	printk("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
+	printk("Display Information (EDID)\n");
+	printk("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
+	printk("   EDID Version %d.%d\n", (int) edid[EDID_STRUCT_VERSION],
+	       (int) edid[EDID_STRUCT_REVISION]);
+
+	parse_vendor_block(edid + ID_MANUFACTURER_NAME);
+
+	printk("   Display Characteristics:\n");
+	parse_display_block(edid + EDID_STRUCT_DISPLAY);
+
+	printk("   Supported VESA Modes\n");
+	parse_std_md_block(edid + ESTABLISHED_TIMING_1);
+
+	printk("   Detailed Monitor Information\n");
+	block =3D edid + DETAILED_TIMING_DESCRIPTIONS_START;
+	for (i =3D 0; i < 4; i++, block +=3D DETAILED_TIMING_DESCRIPTION_SIZE) {
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
+			parse_std_timing_block(block);
+		} else if (edid_is_timing_block(block)) {
+			parse_detailed_timing_block(block);
+		}
+	}
+	printk("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
+}
+
 #ifdef CONFIG_PCI
 char *get_EDID(struct pci_dev *pdev)
 {
@@ -273,6 +583,8 @@
 	struct device_node *dp;
 	int i;
=20
+	if (pdev =3D=3D NULL)
+		return NULL;
 	dp =3D pci_device_to_OF_node(pdev);
 	while (dp !=3D NULL) {
 		for (i =3D 0; propnames[i] !=3D NULL; ++i) {
@@ -286,6 +598,9 @@
 		dp =3D dp->child;
 	}
 	return pedid;
+#elif defined (CONFIG_EDID)
+	return (edid_checksum((char *) &edid_info)) ?
+		(char *) &edid_info : NULL;
 #else
 	return NULL;
 #endif
@@ -576,6 +891,10 @@
 			timings.vfreq =3D vfmax;
 			fb_timings_vfreq(&timings);
 		}
+		if (timings.dclk > dclkmax) {
+			timings.dclk =3D dclkmax;
+			fb_timings_dclk(&timings);
+		}
 		break;
 	case FB_VSYNCTIMINGS: /* vrefresh driven */
 		timings.vfreq =3D val;
@@ -669,13 +988,17 @@
 	vfreq =3D hfreq/vtotal;
=20
 	return (vfreq < vfmin || vfreq > vfmax ||=20
-		hfreq < hfmin || hfreq > hfmax) ?
+		hfreq < hfmin || hfreq > hfmax ||
+		pixclock < dclkmin || pixclock > dclkmax) ?
 		-EINVAL : 0;
 }
=20
 EXPORT_SYMBOL(parse_edid);
+EXPORT_SYMBOL(show_edid);
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL(get_EDID);
 #endif
+
+EXPORT_SYMBOL(get_monitor_limits);
 EXPORT_SYMBOL(fb_get_mode);
 EXPORT_SYMBOL(fb_validate_mode);
diff -Naur linux-2.5.64-fbdev/include/asm-i386/setup.h linux-2.5.64/include=
/asm-i386/setup.h
--- linux-2.5.64-fbdev/include/asm-i386/setup.h	2002-12-16 02:08:12.0000000=
00 +0000
+++ linux-2.5.64/include/asm-i386/setup.h	2003-03-11 02:39:51.000000000 +00=
00
@@ -39,6 +39,8 @@
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
+/* Note: EDID_INFO uses the same offset as EDD_BUF */
+#define EDID_INFO   (*(struct edid_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE ((char *) (PARAM+2048))
 #define COMMAND_LINE_SIZE 256
=20
diff -Naur linux-2.5.64-fbdev/include/linux/fb.h linux-2.5.64/include/linux=
/fb.h
--- linux-2.5.64-fbdev/include/linux/fb.h	2003-03-11 02:30:33.000000000 +00=
00
+++ linux-2.5.64/include/linux/fb.h	2003-03-11 11:39:05.000000000 +0000
@@ -486,6 +486,10 @@
 extern int num_registered_fb;
=20
 /* drivers/video/fbmon.c */
+#ifdef CONFIG_PCI
+#include <linux/pci.h>
+#endif
+
 #define FB_MAXTIMINGS       0
 #define FB_VSYNCTIMINGS     1
 #define FB_HSYNCTIMINGS     2
@@ -499,6 +503,10 @@
 		       struct fb_info *info);
 extern int fb_validate_mode(struct fb_var_screeninfo *var,
 			    struct fb_info *info);
+extern int parse_edid(unsigned char *edid, struct fb_var_screeninfo *var);
+extern char *get_EDID(struct pci_dev *pdev);
+extern void show_edid(unsigned char *edid);
+extern int get_monitor_limits(unsigned char *edid, struct fb_monspecs *spe=
cs);
=20
 /* drivers/video/fbcmap.c */
 extern int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp);
diff -Naur linux-2.5.64-fbdev/include/linux/tty.h linux-2.5.64/include/linu=
x/tty.h
--- linux-2.5.64-fbdev/include/linux/tty.h	2003-02-16 00:48:02.000000000 +0=
000
+++ linux-2.5.64/include/linux/tty.h	2003-03-11 02:39:50.000000000 +0000
@@ -93,7 +93,12 @@
 						/* 0x36 -- 0x3f reserved for future expansion */
 };
=20
+struct edid_info {
+	 unsigned char data[128];
+};
+
 extern struct screen_info screen_info;
+extern struct edid_info   edid_info;
=20
 #define ORIG_X			(screen_info.orig_x)
 #define ORIG_Y			(screen_info.orig_y)

--=-Jn5jj8Oc5LQ68XZpXonL--




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
