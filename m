From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: Re: [macro@ds2.pg.gda.pl: Re: PMAG-A support?]
Date: Tue, 12 Aug 2003 08:37:07 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030812063707.GC23104@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030811163833.GA765@excalibur.cologne.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19mSn4-0004tL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 11 Aug 2003 23:37:54 -0700
Content-Disposition: inline
In-Reply-To: <20030811163833.GA765@excalibur.cologne.de>
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
Content-Transfer-Encoding: 7bit
To: Karsten Merker <karsten@excalibur.cologne.de>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, Martin Schulze <joey@infodrom.org>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-fbdev-devel@lists.sourceforge.net

Karsten Merker wrote:
> ----- Forwarded message from "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> -----
[snip]
> > What's missing is support *in* XFree86.  That where I lost time.
> 
>  That's the second step anyway.

The PMAG-AA basically works for me, but it is not too useful without
working keyboard support. XFree86 preprocesses the xkbd input in order
to handle PC keyboard's key sequences, this breaks the LK keyboard
support.

> > Thiemo said that he had a more recent patch which will more likely be
> > accepted upstream, iirc.
> 
>  Could one of you as the authors please resend the most recent patch to
> the <linux-fbdev-devel@lists.sourceforge.net> list?  I'm subscribed there,
> so I'll see comments and reply if needed. 

I already sent some parts earlier, but I don't know if they got lost
(is there an up-to-date CVS for fbdev?).

Anyway, the AA driver is appended as a diff against current linux-mips
CVS. I hope it doesn't deviate too much from whatever fbdev uses.

The bootlogo stuff needs one more patch, I'll follow up on this one.


Thiemo


diff -urpNX /bigdisk/src/dontdiff linux-orig/drivers/video/Config.in linux/drivers/video/Config.in
--- linux-orig/drivers/video/Config.in	Mon Aug  4 02:31:00 2003
+++ linux/drivers/video/Config.in	Tue Aug 12 04:15:33 2003
@@ -218,6 +218,7 @@ if [ "$CONFIG_FB" = "y" ]; then
       tristate '  HD64461 Frame Buffer support' CONFIG_FB_HIT
    fi
    if [ "$CONFIG_DECSTATION" = "y" ]; then
+      dep_bool '  PMAG-AA TURBOchannel framebuffer support' CONFIG_FB_PMAG_AA $CONFIG_TC
       dep_bool '  PMAG-BA TURBOchannel framebuffer support' CONFIG_FB_PMAG_BA $CONFIG_TC
       dep_bool '  PMAGB-B TURBOchannel framebuffer support' CONFIG_FB_PMAGB_B $CONFIG_TC
       dep_bool '  Maxine (Personal DECstation) onboard framebuffer support' CONFIG_FB_MAXINE $CONFIG_TC
@@ -297,7 +298,8 @@ if [ "$CONFIG_FB" = "y" ]; then
 	   "$CONFIG_FB_SGIVW" = "y" -o "$CONFIG_FB_CYBER2000" = "y" -o \
 	   "$CONFIG_FB_SA1100" = "y" -o "$CONFIG_FB_3DFX" = "y" -o \
 	   "$CONFIG_FB_PMAG_BA" = "y" -o "$CONFIG_FB_PMAGB_B" = "y" -o \
-	   "$CONFIG_FB_MAXINE" = "y" -o "$CONFIG_FB_TX3912" = "y" -o \
+	   "$CONFIG_FB_MAXINE" = "y" -o "$CONFIG_FB_PMAG_AA" = "y" -o \
+	   "$CONFIG_FB_TX3912" = "y" -o \
 	   "$CONFIG_FB_SIS" = "y" -o "$CONFIG_FB_NEOMAGIC" = "y" -o \
 	   "$CONFIG_FB_STI" = "y" -o "$CONFIG_FB_HP300" = "y" -o \
 	   "$CONFIG_FB_INTEL" = "y" ]; then
diff -urpNX /bigdisk/src/dontdiff linux-orig/drivers/video/Makefile linux/drivers/video/Makefile
--- linux-orig/drivers/video/Makefile	Mon Aug  4 02:31:00 2003
+++ linux/drivers/video/Makefile	Tue Aug 12 04:15:33 2003
@@ -81,6 +81,7 @@ obj-$(CONFIG_FB_TCX)              += tcx
 obj-$(CONFIG_FB_CGFOURTEEN)       += cgfourteenfb.o sbusfb.o
 obj-$(CONFIG_FB_P9100)            += p9100fb.o sbusfb.o
 obj-$(CONFIG_FB_LEO)              += leofb.o sbusfb.o
+obj-$(CONFIG_FB_PMAG_AA)          += pmag-aa-fb.o
 obj-$(CONFIG_FB_PMAG_BA)          += pmag-ba-fb.o
 obj-$(CONFIG_FB_PMAGB_B)          += pmagb-b-fb.o
 obj-$(CONFIG_FB_MAXINE)           += maxinefb.o
diff -urpNX /bigdisk/src/dontdiff linux-orig/drivers/video/bt431.h linux/drivers/video/bt431.h
--- linux-orig/drivers/video/bt431.h	Thu Jan  1 01:00:00 1970
+++ linux/drivers/video/bt431.h	Sat Apr 12 15:44:11 2003
@@ -0,0 +1,227 @@
+/*
+ *	linux/drivers/video/bt431.h
+ *
+ *	Copyright 2003  Thiemo Seufer <seufer@csv.ica.uni-stuttgart.de>
+ *
+ *	This file is subject to the terms and conditions of the GNU General
+ *	Public License. See the file COPYING in the main directory of this
+ *	archive for more details.
+ */
+#include <linux/types.h>
+#include <asm/system.h>
+
+/*
+ * Bt431 cursor generator registers, 32-bit aligned.
+ * Two twin Bt431 are used on the DECstation's PMAG-AA.
+ */
+struct bt431_regs {
+	volatile u16 addr_lo;
+	u16 pad0;
+	volatile u16 addr_hi;
+	u16 pad1;
+	volatile u16 addr_cmap;
+	u16 pad2;
+	volatile u16 addr_reg;
+	u16 pad3;
+};
+
+static inline u16 bt431_set_value(u8 val)
+{
+	return ((val << 8) | (val & 0xff)) & 0xffff;
+}
+
+static inline u8 bt431_get_value(u16 val)
+{
+	return val & 0xff;
+}
+
+/*
+ * Additional registers addressed indirectly.
+ */
+#define BT431_REG_CMD           0x0000
+#define BT431_REG_CXLO          0x0001
+#define BT431_REG_CXHI          0x0002
+#define BT431_REG_CYLO          0x0003
+#define BT431_REG_CYHI          0x0004
+#define BT431_REG_WXLO          0x0005
+#define BT431_REG_WXHI          0x0006
+#define BT431_REG_WYLO          0x0007
+#define BT431_REG_WYHI          0x0008
+#define BT431_REG_WWLO          0x0009
+#define BT431_REG_WWHI          0x000a
+#define BT431_REG_WHLO          0x000b
+#define BT431_REG_WHHI          0x000c
+
+#define BT431_REG_CRAM_BASE     0x0000
+#define BT431_REG_CRAM_END      0x01ff
+
+/*
+ * Command register.
+ */
+#define BT431_CMD_CURS_ENABLE   0x40
+#define BT431_CMD_XHAIR_ENABLE  0x20
+#define BT431_CMD_OR_CURSORS    0x10
+#define BT431_CMD_AND_CURSORS   0x00
+#define BT431_CMD_1_1_MUX       0x00
+#define BT431_CMD_4_1_MUX       0x04
+#define BT431_CMD_5_1_MUX       0x08
+#define BT431_CMD_xxx_MUX       0x0c
+#define BT431_CMD_THICK_1       0x00
+#define BT431_CMD_THICK_3       0x01
+#define BT431_CMD_THICK_5       0x02
+#define BT431_CMD_THICK_7       0x03
+
+static inline void bt431_select_reg(struct bt431_regs *regs, int ir)
+{
+	regs->addr_lo = bt431_set_value(ir & 0xff);
+	regs->addr_hi = bt431_set_value((ir >> 8) & 0xff);
+	iob();
+}
+
+/* Autoincrement read/write. */
+static inline u8 bt431_read_reg_inc(struct bt431_regs *regs)
+{
+	return bt431_get_value(regs->addr_reg);
+}
+
+static inline void bt431_write_reg_inc(struct bt431_regs *regs, u16 value)
+{
+	regs->addr_reg = bt431_set_value(value);
+	iob();
+}
+
+static inline u8 bt431_read_reg(struct bt431_regs *regs, int ir)
+{
+	bt431_select_reg(regs, ir);
+	return bt431_read_reg_inc(regs);
+}
+
+static inline void bt431_write_reg(struct bt431_regs *regs, int ir, u16 value)
+{
+	bt431_select_reg(regs, ir);
+	bt431_write_reg_inc(regs, value);
+}
+
+/* Autoincremented read/write for the colormap */
+static inline u16 bt431_read_cmap_inc(struct bt431_regs *regs)
+{
+	return regs->addr_cmap;
+}
+
+static inline void bt431_write_cmap_inc(struct bt431_regs *regs, u16 value)
+{
+	regs->addr_cmap = value;
+	iob();
+}
+
+static inline u16 bt431_read_cmap(struct bt431_regs *regs, int cr)
+{
+	bt431_select_reg(regs, cr);
+	return bt431_read_cmap_inc(regs);
+}
+
+static inline void bt431_write_cmap(struct bt431_regs *regs, int cr, u16 value)
+{
+	bt431_select_reg(regs, cr);
+	bt431_write_cmap_inc(regs, value);
+}
+
+static inline void bt431_enable_cursor(struct bt431_regs *regs)
+{
+/*	bt431_write_reg(regs, BT431_REG_CMD,
+			BT431_CMD_CURS_ENABLE | BT431_CMD_OR_CURSORS
+			| BT431_CMD_4_1_MUX | BT431_CMD_THICK_1);
+*/	bt431_write_reg(regs, BT431_REG_CMD, BT431_CMD_CURS_ENABLE);
+}
+
+static inline void bt431_erase_cursor(struct bt431_regs *regs)
+{
+	bt431_write_reg(regs, BT431_REG_CMD, BT431_CMD_4_1_MUX);
+}
+
+static inline void bt431_position_cursor(struct bt431_regs *regs, u16 x, u16 y)
+{
+        /*
+	 * Magic from the MACH sources.
+	 * 
+	 * Cx = x + D + H - P
+	 *  P = 37 if 1:1, 52 if 4:1, 57 if 5:1
+	 *  D = pixel skew between outdata and external data
+	 *  H = pixels between HSYNCH falling and active video
+	 *
+	 * Cy = y + V - 32
+	 *  V = scanlines between HSYNCH falling, two or more
+	 *      clocks after VSYNCH falling, and active video
+	 */
+	x += 412 - 52;
+	y += 68 - 32;
+
+        /* Use autoincrement. */
+	bt431_select_reg(regs, BT431_REG_CXLO);
+        bt431_write_reg_inc(regs, x & 0xff); /* BT431_REG_CXLO */
+        bt431_write_reg_inc(regs, (x >> 8) & 0x0f); /* BT431_REG_CXHI */
+        bt431_write_reg_inc(regs, y & 0xff); /* BT431_REG_CYLO */
+        bt431_write_reg_inc(regs, (y >> 8) & 0x0f); /* BT431_REG_CYHI */
+}
+
+/*u16 _bt431_default_cursor[64 * 8] = {
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0xffff, 0, 0, 0, 0, 0, 0, 0,
+	0,
+};
+*/
+static inline void bt431_load_cursor_sprite(struct bt431_regs *regs)
+{
+	int i;
+
+	bt431_select_reg(regs, BT431_REG_CRAM_BASE);
+	for (i = 0; i < 64 * 8; i++)
+	        bt431_write_reg_inc(regs, ((i < 16 * 8) && (i % 8)) ? 0xffff : 0);
+}
+
+static inline void bt431_init_cursor(struct bt431_regs *regs)
+{
+	bt431_write_reg(regs, BT431_REG_CMD,
+			BT431_CMD_CURS_ENABLE | BT431_CMD_OR_CURSORS
+			| BT431_CMD_4_1_MUX | BT431_CMD_THICK_1);
+
+	/* home cursor */
+#if 0
+        bt431_write_reg_inc(regs, 0x0000); /* BT431_REG_CXLO */
+        bt431_write_reg_inc(regs, 0x0000); /* BT431_REG_CXHI */
+        bt431_write_reg_inc(regs, 0x0000); /* BT431_REG_CYLO */
+        bt431_write_reg_inc(regs, 0x0000); /* BT431_REG_CYHI */
+#endif
+        bt431_write_reg_inc(regs, 0x0080); /* BT431_REG_CXLO */
+        bt431_write_reg_inc(regs, 0x0000); /* BT431_REG_CXHI */
+        bt431_write_reg_inc(regs, 0x0080); /* BT431_REG_CYLO */
+        bt431_write_reg_inc(regs, 0x0000); /* BT431_REG_CYHI */
+
+	/* no crosshair window */
+        bt431_write_reg_inc(regs, 0x0000); /* BT431_REG_WXLO */
+        bt431_write_reg_inc(regs, 0x0000); /* BT431_REG_WXHI */
+        bt431_write_reg_inc(regs, 0x0000); /* BT431_REG_WYLO */
+        bt431_write_reg_inc(regs, 0x0000); /* BT431_REG_WYHI */
+//        bt431_write_reg_inc(regs, 0x0000); /* BT431_REG_WWLO */
+        bt431_write_reg_inc(regs, 0x0100); /* BT431_REG_WWLO */
+        bt431_write_reg_inc(regs, 0x0000); /* BT431_REG_WWHI */
+//        bt431_write_reg_inc(regs, 0x0000); /* BT431_REG_WHLO */
+        bt431_write_reg_inc(regs, 0x0100); /* BT431_REG_WHLO */
+        bt431_write_reg_inc(regs, 0x0000); /* BT431_REG_WHHI */
+
+	bt431_load_cursor_sprite(regs);
+}
diff -urpNX /bigdisk/src/dontdiff linux-orig/drivers/video/bt455.h linux/drivers/video/bt455.h
--- linux-orig/drivers/video/bt455.h	Thu Jan  1 01:00:00 1970
+++ linux/drivers/video/bt455.h	Sat Apr 12 15:44:11 2003
@@ -0,0 +1,95 @@
+/*
+ *	linux/drivers/video/bt455.h
+ *
+ *	Copyright 2003  Thiemo Seufer <seufer@csv.ica.uni-stuttgart.de>
+ *
+ *	This file is subject to the terms and conditions of the GNU General
+ *	Public License. See the file COPYING in the main directory of this
+ *	archive for more details.
+ */
+#include <linux/types.h>
+#include <asm/system.h>
+
+/*
+ * Bt455 byte-wide registers, 32-bit aligned.
+ */
+struct bt455_regs {
+	volatile u8 addr_cmap;
+	u8 pad0[3];
+	volatile u8 addr_cmap_data;
+	u8 pad1[3];
+	volatile u8 addr_clr;
+	u8 pad2[3];
+	volatile u8 addr_ovly;
+	u8 pad3[3];
+};
+
+static inline void bt455_select_reg(struct bt455_regs *regs, int ir)
+{
+	regs->addr_cmap = ir & 0x0f;
+	iob();
+}
+
+/*
+ * Read/write to a Bt455 color map register.
+ */
+static inline void bt455_read_cmap_entry(struct bt455_regs *regs, int cr,
+					 u8* red, u8* green, u8* blue)
+{
+	bt455_select_reg(regs, cr);
+	
+	*red = regs->addr_cmap_data & 0x0f;
+	*green = regs->addr_cmap_data & 0x0f;
+	*blue = regs->addr_cmap_data & 0x0f;
+}
+
+static inline void bt455_write_cmap_entry(struct bt455_regs *regs, int cr,
+					  u8 red, u8 green, u8 blue)
+{
+	bt455_select_reg(regs, cr);
+
+	regs->addr_cmap_data = red & 0x0f;
+	iob();
+	regs->addr_cmap_data = green & 0x0f;
+	iob();
+	regs->addr_cmap_data = blue & 0x0f;
+	iob();
+}
+
+static inline void bt455_write_ovly_entry(struct bt455_regs *regs, int cr,
+					  u8 red, u8 green, u8 blue)
+{
+	bt455_select_reg(regs, cr);
+	
+	regs->addr_ovly = red & 0x0f;
+	iob();
+	regs->addr_ovly = green & 0x0f;
+	iob();
+	regs->addr_ovly = blue & 0x0f;
+	iob();
+}
+
+static inline void bt455_set_cursor(struct bt455_regs *regs)
+{
+	regs->addr_ovly = 0x0f;
+	iob();
+	regs->addr_ovly = 0x0f;
+	iob();
+	regs->addr_ovly = 0x0f;
+	iob();
+}
+
+static inline void bt455_erase_cursor(struct bt455_regs *regs)
+{
+//	bt455_write_cmap_entry(regs, 8, 0x00, 0x00, 0x00);
+//	bt455_write_cmap_entry(regs, 9, 0x00, 0x00, 0x00);
+	bt455_write_cmap_entry(regs, 8, 0x03, 0x03, 0x03);
+	bt455_write_cmap_entry(regs, 9, 0x07, 0x07, 0x07);
+
+	regs->addr_ovly = 0x09;
+	iob();
+	regs->addr_ovly = 0x09;
+	iob();
+	regs->addr_ovly = 0x09;
+	iob();
+}
diff -urpNX /bigdisk/src/dontdiff linux-orig/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linux-orig/drivers/video/fbmem.c	Mon Aug  4 02:31:00 2003
+++ linux/drivers/video/fbmem.c	Tue Aug 12 04:15:34 2003
@@ -124,9 +124,10 @@ extern int sisfb_init(void);
 extern int sisfb_setup(char*);
 extern int stifb_init(void);
 extern int stifb_setup(char*);
+extern int pmagaafb_init(void);
 extern int pmagbafb_init(void);
 extern int pmagbbfb_init(void);
-extern void maxinefb_init(void);
+extern int maxinefb_init(void);
 extern int tx3912fb_init(void);
 extern int radeonfb_init(void);
 extern int radeonfb_setup(char*);
@@ -312,6 +313,9 @@ static struct {
 #endif
 #ifdef CONFIG_FB_PVR2
 	{ "pvr2", pvr2fb_init, pvr2fb_setup },
+#endif
+#ifdef CONFIG_FB_PMAG_AA
+	{ "pmagaafb", pmagaafb_init, NULL },
 #endif
 #ifdef CONFIG_FB_PMAG_BA
 	{ "pmagbafb", pmagbafb_init, NULL },
diff -urpNX /bigdisk/src/dontdiff linux-orig/drivers/video/pmag-aa-fb.c linux/drivers/video/pmag-aa-fb.c
--- linux-orig/drivers/video/pmag-aa-fb.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/video/pmag-aa-fb.c	Sat Apr 12 15:44:11 2003
@@ -0,0 +1,339 @@
+/*
+ *	linux/drivers/video/pmag-aa-fb.c
+ *	Copyright 2002 Karsten Merker <merker@debian.org>
+ *
+ *	PMAG-AA TurboChannel framebuffer card support ... derived from
+ *	pmag-ba-fb.c, which is Copyright (C) 1999, 2000, 2001 by
+ *	Michael Engel <engel@unix-ag.org>, Karsten Merker <merker@debian.org>
+ *	and Harald Koerfgen <hkoerfg@web.de>, which itself is derived from
+ *	"HP300 Topcat framebuffer support (derived from macfb of all things)
+ *	Phil Blundell <philb@gnu.org> 1998"
+ *
+ *	This file is subject to the terms and conditions of the GNU General
+ *	Public License.  See the file COPYING in the main directory of this
+ *	archive for more details.
+ *
+ *	Version 0.01 2002/09/28 first try to get a PMAG-AA running
+ * 
+ *	2003/02/24  Thiemo Seufer  <seufer@csv.ica.uni-stuttgart.de>
+ *		Code cleanup.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/fb.h>
+
+#include <asm/bootinfo.h>
+#include <asm/dec/machtype.h>
+#include <asm/dec/tc.h>
+
+#include <video/fbcon.h>
+#include <video/fbcon-mfb.h>
+#include <video/fbcon-cfb8.h>
+
+#include "bt455.h"
+#include "bt431.h"
+
+/* Version information */
+#define DRIVER_VERSION "v0.02"
+#define DRIVER_AUTHOR "Karsten Merker <merker@linuxtag.org>"
+#define DRIVER_DESC "PMAG-AA Framebuffer Driver"
+
+/*
+ * Bt455 RAM DAC register base offset (rel. to TC slot base address).
+ */
+#define PMAG_AA_BT455_OFFSET		0x100000
+
+/*
+ * Bt431 cursor generator offset (rel. to TC slot base address).
+ */
+#define PMAG_AA_BT431_OFFSET		0x180000
+
+/*
+ * Begin of PMAG-AA framebuffer memory relative to TC slot address,
+ * resolution is 1280x1024x1 (8 bits deep, but only LSB is used).
+ */
+#define PMAG_AA_ONBOARD_FBMEM_OFFSET    0x200000
+
+struct aafb_info {
+	struct fb_info info;
+	struct display disp;
+	struct bt455_regs *bt455;
+	struct bt431_regs *bt431;
+	unsigned long fb_start;
+	unsigned long fb_size;
+	unsigned long fb_line_length;
+};
+
+/*
+ * Max 3 TURBOchannel slots -> max 3 PMAG-AA.
+ */
+static struct aafb_info my_fb_info[3];
+
+static struct aafb_par {
+} current_par;
+
+static int currcon = 0;
+
+static void aafb_get_par(struct aafb_par *par)
+{
+	*par = current_par;
+}
+
+static void aafb_encode_fix(struct fb_fix_screeninfo *fix,
+			    struct aafb_par *par, struct aafb_info *info)
+{
+	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
+	strcpy(fix->id, "PMAG-AA");
+
+	fix->smem_start = info->fb_start;
+	fix->smem_len = info->fb_size;
+	fix->type = FB_TYPE_PACKED_PIXELS;
+	fix->visual = FB_VISUAL_MONO10;
+	fix->line_length = info->fb_line_length;
+	fix->accel = FB_ACCEL_NONE;
+}
+
+static int aafb_get_fix(struct fb_fix_screeninfo *fix, int con,
+			struct fb_info *info)
+{
+	struct aafb_par par;
+
+	aafb_get_par(&par);
+	aafb_encode_fix(fix, &par, (struct aafb_info *) info);
+
+	return 0;
+}
+
+static void aafb_set_disp(int con, struct fb_info *info)
+{
+	struct fb_fix_screeninfo fix;
+	struct display *disp = (con < 0) ? info->disp : (fb_display + con);
+
+	aafb_get_fix(&fix, con, info);
+
+	disp->screen_base = (char *) fix.smem_start;
+	disp->visual = fix.visual;
+	disp->type = fix.type;
+	disp->type_aux = fix.type_aux;
+	disp->ypanstep = fix.ypanstep;
+	disp->ywrapstep = fix.ywrapstep;
+//	disp->line_length = fix.line_length;
+	disp->next_line = fix.line_length;
+	disp->can_soft_blank = 1;
+	disp->inverse = 0;
+//	disp->scrollmode = SCROLL_YREDRAW;
+	disp->dispsw = &fbcon_cfb8;
+}
+
+static int aafb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
+			 struct fb_info *info)
+{
+	static u16 color[2] = {0x0000, 0x000f};
+	static struct fb_cmap aafb_cmap = {0, 2, color, color, color, NULL};
+
+	fb_copy_cmap(&aafb_cmap, cmap, kspc ? 0 : 2);
+	return 0;
+}
+
+static int aafb_set_cmap(struct fb_cmap *cmap, int kspc, int con,
+			 struct fb_info *info)
+{
+	return -EINVAL;
+}
+
+static int aafb_switch(int con, struct fb_info *info)
+{
+	/* Set the current console. */
+	currcon = con;
+	aafb_set_disp(con, info);
+
+	return 0;
+}
+
+static void aafb_encode_var(struct fb_var_screeninfo *var,
+			    struct aafb_par *par)
+{
+	var->xres = 1280;
+	var->yres = 1024;
+	var->xres_virtual = 2048;
+	var->yres_virtual = 1024;
+	var->xoffset = 0;
+	var->yoffset = 0;
+	var->bits_per_pixel = 8;
+	var->grayscale = 1;
+	var->red.offset = 0;
+	var->red.length = 0;
+	var->red.msb_right = 0;
+	var->green.offset = 0;
+	var->green.length = 1;
+	var->green.msb_right = 0;
+	var->blue.offset = 0;
+	var->blue.length = 0;
+	var->blue.msb_right = 0;
+	var->transp.offset = 0;
+	var->transp.length = 0;
+	var->transp.msb_right = 0;
+	var->nonstd = 0;
+	var->activate &= ~FB_ACTIVATE_MASK & FB_ACTIVATE_NOW;
+	var->accel_flags = 0;
+	var->sync = FB_SYNC_ON_GREEN;
+	var->vmode &= ~FB_VMODE_MASK & FB_VMODE_NONINTERLACED;
+}
+
+static int aafb_get_var(struct fb_var_screeninfo *var, int con,
+			struct fb_info *info)
+{
+	if (con < 0) {
+		struct aafb_par par;
+
+		memset(var, 0, sizeof(struct fb_var_screeninfo));
+		aafb_get_par(&par);
+		aafb_encode_var(var, &par);
+	} else
+		*var = info->var;
+
+	return 0;
+}
+
+static int aafb_set_var(struct fb_var_screeninfo *var, int con,
+			struct fb_info *info)
+{
+	struct aafb_par par;
+
+	aafb_get_par(&par);
+	aafb_encode_var(var, &par);
+	info->var = *var;
+
+	return 0;
+}
+
+static int aafb_update_var(int con, struct fb_info *info)
+{
+	return 0;
+}
+
+/* 0 unblanks, any other blanks. */
+
+static void aafb_blank(int blank, struct fb_info *info)
+{
+	struct aafb_info *ip = (struct aafb_info *)info;
+	u8 val = blank ? 0x00 : 0x0f;
+
+	bt455_write_cmap_entry(ip->bt455, 1, val, val, val);
+}
+
+static struct fb_ops aafb_ops = {
+	owner:THIS_MODULE,
+	fb_get_fix:aafb_get_fix,
+	fb_get_var:aafb_get_var,
+	fb_set_var:aafb_set_var,
+	fb_get_cmap:aafb_get_cmap,
+	fb_set_cmap:aafb_set_cmap
+};
+
+static int __init init_one(int slot)
+{
+	unsigned long base_addr = get_tc_base_addr(slot);
+	struct aafb_info *ip = &my_fb_info[slot];
+
+	memset(ip, 0, sizeof(struct aafb_info));
+
+	/*
+	 * Framebuffer display memory base address and friends.
+	 */
+	ip->bt455 = (struct bt455_regs *) (base_addr + PMAG_AA_BT455_OFFSET);
+	ip->bt431 = (struct bt431_regs *) (base_addr + PMAG_AA_BT431_OFFSET);
+	ip->fb_start = base_addr + PMAG_AA_ONBOARD_FBMEM_OFFSET;
+	ip->fb_size = 2048 * 1024; /* fb_fix_screeninfo.smem_length
+				      seems to be physical */
+	ip->fb_line_length = 2048;
+
+	/*
+	 * Configure the RAM DACs.
+	 */
+// TODO
+//	bt455_erase_cursor(ip->bt455);
+//	bt455_set_cursor(ip->bt455);
+//	bt431_erase_cursor(ip->bt431);
+//	bt431_init_cursor(ip->bt431);
+//	bt431_position_cursor(ip->bt431, 16, 16);
+
+	/* Init colormap. */
+	bt455_write_cmap_entry(ip->bt455, 0, 0x00, 0x00, 0x00);
+	bt455_write_cmap_entry(ip->bt455, 1, 0x0f, 0x0f, 0x0f);
+
+	/*
+	 * Let there be consoles..
+	 */
+	strcpy(ip->info.modename, "PMAG-AA");
+	ip->info.node = -1;
+	ip->info.flags = FBINFO_FLAG_DEFAULT;
+	ip->info.fbops = &aafb_ops;
+	ip->info.disp = &ip->disp;
+	ip->info.changevar = NULL;
+	ip->info.switch_con = &aafb_switch;
+	ip->info.updatevar = &aafb_update_var;
+	ip->info.blank = &aafb_blank;
+
+	aafb_set_disp(-1, &ip->info);
+	aafb_set_var(&ip->disp.var, -1, &ip->info);
+
+	/* Clear the screen. */
+	memset ((void *)ip->fb_start, 0, ip->fb_size);
+
+	if (register_framebuffer(&ip->info) < 0)
+		return -EINVAL;
+
+	printk(KERN_INFO "fb%d: %s frame buffer device in TC slot %d\n",
+	       GET_FB_IDX(ip->info.node), ip->info.modename, slot);
+
+	return 0;
+}
+
+static int __exit exit_one(int slot)
+{
+	struct aafb_info *ip = &my_fb_info[slot];
+
+	if (unregister_framebuffer(&ip->info) < 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* 
+ * Initialise the framebuffer.
+ */
+int __init pmagaafb_init(void)
+{
+	int sid;
+	int found = 0;
+
+	while ((sid = search_tc_card("PMAG-AA")) >= 0) {
+		found = 1;
+		claim_tc_card(sid);
+		init_one(sid);
+	}
+
+	return found ? 0 : -ENODEV;
+}
+
+static void __exit pmagaafb_exit(void)
+{
+	int sid;
+
+	while ((sid = search_tc_card("PMAG-AA")) >= 0) {
+		exit_one(sid);
+		release_tc_card(sid);
+	}
+}
+
+MODULE_LICENSE("GPL");


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
