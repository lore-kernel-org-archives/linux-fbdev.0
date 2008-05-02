From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] tridentfb: replace macros with functions
Date: Fri, 02 May 2008 11:22:45 +0200
Message-ID: <481add6589c4d@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part481add658c35d"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JrrTe-0000CY-7y for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 May 2008 02:22:50 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JrrTd-0002Ac-28
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 May 2008 02:22:50 -0700
Received: from poczta-19.free.wp-sa.pl (HELO localhost) ([10.1.1.98])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 2 May 2008 11:22:45 +0200
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

This is a multi-part message in MIME format.

--part481add658c35d
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch replaces macros with static functions and
puts tridentfb_par pointer as the first argument of
these functions. These is a step toward multihead
support.

Additionally, bogus TRIDENT_MMIO define is removed as
the driver supports graphics cards only through the mmio mode.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
If the patch below is mangled another copy should be attached (only web=20
client here at the moment).

diff -urp linux-old/drivers/video/tridentfb.c=20
linux-pc/drivers/video/tridentfb.c
--- linux-old/drivers/video/tridentfb.c	2008-05-01 23:44:39.000000000=20
+0200
+++ linux-pc/drivers/video/tridentfb.c	2008-05-01 23:55:02.000000000 +020=
0
@@ -137,28 +137,34 @@ static int iscyber(int id)
=20
 #define CRT 0x3D0		/* CRTC registers offset for color display */
=20
-#ifndef TRIDENT_MMIO
-	#define TRIDENT_MMIO 1
-#endif
-
-#if TRIDENT_MMIO
-	#define t_outb(val, reg)	writeb(val,((struct tridentfb_par=20
*)(fb_info.par))->io_virt + reg)
-	#define t_inb(reg)	readb(((struct=20
tridentfb_par*)(fb_info.par))->io_virt + reg)
-#else
-	#define t_outb(val, reg) outb(val, reg)
-	#define t_inb(reg) inb(reg)
-#endif
+static void t_outb(struct tridentfb_par *p, u8 val, u16 reg)
+{
+	fb_writeb(val, p->io_virt + reg);
+}
=20
+static u8 t_inb(struct tridentfb_par *p, u16 reg)
+{
+	return fb_readb(p->io_virt + reg);
+}
=20
 static struct accel_switch {
-	void (*init_accel) (int, int);
-	void (*wait_engine) (void);
-	void (*fill_rect) (u32, u32, u32, u32, u32, u32);
-	void (*copy_rect) (u32, u32, u32, u32, u32, u32);
+	void (*init_accel) (struct tridentfb_par *, int, int);
+	void (*wait_engine) (struct tridentfb_par *);
+	void (*fill_rect)
+		(struct tridentfb_par *par, u32, u32, u32, u32, u32, u32);
+	void (*copy_rect)
+		(struct tridentfb_par *par, u32, u32, u32, u32, u32, u32);
 } *acc;
=20
-#define writemmr(r, v)	writel(v, ((struct tridentfb_par=20
*)fb_info.par)->io_virt + r)
-#define readmmr(r)	readl(((struct tridentfb_par *)fb_info.par)->io_virt=20
+ r)
+static void writemmr(struct tridentfb_par *par, u16 r, u32 v)
+{
+	fb_writel(v, par->io_virt + r);
+}
+
+static u32 readmmr(struct tridentfb_par *par, u16 r)
+{
+	return fb_readl(par->io_virt + r);
+}
=20
 /*
  * Blade specific acceleration.
@@ -176,7 +182,7 @@ static struct accel_switch {
=20
 #define ROP_S	0xCC
=20
-static void blade_init_accel(int pitch, int bpp)
+static void blade_init_accel(struct tridentfb_par *par, int pitch, int=20
bpp)
 {
 	int v1 =3D (pitch >> 3) << 20;
 	int tmp =3D 0, v2;
@@ -196,33 +202,35 @@ static void blade_init_accel(int pitch,
 		break;
 	}
 	v2 =3D v1 | (tmp << 29);
-	writemmr(0x21C0, v2);
-	writemmr(0x21C4, v2);
-	writemmr(0x21B8, v2);
-	writemmr(0x21BC, v2);
-	writemmr(0x21D0, v1);
-	writemmr(0x21D4, v1);
-	writemmr(0x21C8, v1);
-	writemmr(0x21CC, v1);
-	writemmr(0x216C, 0);
+	writemmr(par, 0x21C0, v2);
+	writemmr(par, 0x21C4, v2);
+	writemmr(par, 0x21B8, v2);
+	writemmr(par, 0x21BC, v2);
+	writemmr(par, 0x21D0, v1);
+	writemmr(par, 0x21D4, v1);
+	writemmr(par, 0x21C8, v1);
+	writemmr(par, 0x21CC, v1);
+	writemmr(par, 0x216C, 0);
 }
=20
-static void blade_wait_engine(void)
+static void blade_wait_engine(struct tridentfb_par *par)
 {
-	while (readmmr(STA) & 0xFA800000) ;
+	while (readmmr(par, STA) & 0xFA800000) ;
 }
=20
-static void blade_fill_rect(u32 x, u32 y, u32 w, u32 h, u32 c, u32 rop)
+static void blade_fill_rect(struct tridentfb_par *par,
+			    u32 x, u32 y, u32 w, u32 h, u32 c, u32 rop)
 {
-	writemmr(CLR, c);
-	writemmr(ROP, rop ? 0x66 : ROP_S);
-	writemmr(CMD, 0x20000000 | 1 << 19 | 1 << 4 | 2 << 2);
+	writemmr(par, CLR, c);
+	writemmr(par, ROP, rop ? 0x66 : ROP_S);
+	writemmr(par, CMD, 0x20000000 | 1 << 19 | 1 << 4 | 2 << 2);
=20
-	writemmr(DR1, point(x, y));
-	writemmr(DR2, point(x + w - 1, y + h - 1));
+	writemmr(par, DR1, point(x, y));
+	writemmr(par, DR2, point(x + w - 1, y + h - 1));
 }
=20
-static void blade_copy_rect(u32 x1, u32 y1, u32 x2, u32 y2, u32 w, u32 h=
)
+static void blade_copy_rect(struct tridentfb_par *par,
+			    u32 x1, u32 y1, u32 x2, u32 y2, u32 w, u32 h)
 {
 	u32 s1, s2, d1, d2;
 	int direction =3D 2;
@@ -234,13 +242,13 @@ static void blade_copy_rect(u32 x1, u32
 	if ((y1 > y2) || ((y1 =3D=3D y2) && (x1 > x2)))
 		direction =3D 0;
=20
-	writemmr(ROP, ROP_S);
-	writemmr(CMD, 0xE0000000 | 1 << 19 | 1 << 4 | 1 << 2 | direction);
+	writemmr(par, ROP, ROP_S);
+	writemmr(par, CMD, 0xE0000000 | 1 << 19 | 1 << 4 | 1 << 2 | direction);
=20
-	writemmr(SR1, direction ? s2 : s1);
-	writemmr(SR2, direction ? s1 : s2);
-	writemmr(DR1, direction ? d2 : d1);
-	writemmr(DR2, direction ? d1 : d2);
+	writemmr(par, SR1, direction ? s2 : s1);
+	writemmr(par, SR2, direction ? s1 : s2);
+	writemmr(par, DR1, direction ? d2 : d1);
+	writemmr(par, DR2, direction ? d1 : d2);
 }
=20
 static struct accel_switch accel_blade =3D {
@@ -257,7 +265,7 @@ static struct accel_switch accel_blade =3D
 #define ROP_P 0xF0
 #define masked_point(x, y) ((y & 0xffff)<<16|(x & 0xffff))
=20
-static void xp_init_accel(int pitch, int bpp)
+static void xp_init_accel(struct tridentfb_par *par, int pitch, int bpp)
 {
 	int tmp =3D 0, v1;
 	unsigned char x =3D 0;
@@ -293,7 +301,7 @@ static void xp_init_accel(int pitch, int
 		break;
 	}
=20
-	t_outb(x, 0x2125);
+	t_outb(par, x, 0x2125);
=20
 	eng_oper =3D x | 0x40;
=20
@@ -313,12 +321,12 @@ static void xp_init_accel(int pitch, int
=20
 	v1 =3D pitch << tmp;
=20
-	writemmr(0x2154, v1);
-	writemmr(0x2150, v1);
-	t_outb(3, 0x2126);
+	writemmr(par, 0x2154, v1);
+	writemmr(par, 0x2150, v1);
+	t_outb(par, 3, 0x2126);
 }
=20
-static void xp_wait_engine(void)
+static void xp_wait_engine(struct tridentfb_par *par)
 {
 	int busy;
 	int count, timeout;
@@ -326,7 +334,7 @@ static void xp_wait_engine(void)
 	count =3D 0;
 	timeout =3D 0;
 	for (;;) {
-		busy =3D t_inb(STA) & 0x80;
+		busy =3D t_inb(par, STA) & 0x80;
 		if (busy !=3D 0x80)
 			return;
 		count++;
@@ -336,25 +344,27 @@ static void xp_wait_engine(void)
 			timeout++;
 			if (timeout =3D=3D 8) {
 				/* Reset engine */
-				t_outb(0x00, 0x2120);
+				t_outb(par, 0x00, 0x2120);
 				return;
 			}
 		}
 	}
 }
=20
-static void xp_fill_rect(u32 x, u32 y, u32 w, u32 h, u32 c, u32 rop)
+static void xp_fill_rect(struct tridentfb_par *par,
+			 u32 x, u32 y, u32 w, u32 h, u32 c, u32 rop)
 {
-	writemmr(0x2127, ROP_P);
-	writemmr(0x2158, c);
-	writemmr(0x2128, 0x4000);
-	writemmr(0x2140, masked_point(h, w));
-	writemmr(0x2138, masked_point(y, x));
-	t_outb(0x01, 0x2124);
-	t_outb(eng_oper, 0x2125);
+	writemmr(par, 0x2127, ROP_P);
+	writemmr(par, 0x2158, c);
+	writemmr(par, 0x2128, 0x4000);
+	writemmr(par, 0x2140, masked_point(h, w));
+	writemmr(par, 0x2138, masked_point(y, x));
+	t_outb(par, 0x01, 0x2124);
+	t_outb(par, eng_oper, 0x2125);
 }
=20
-static void xp_copy_rect(u32 x1, u32 y1, u32 x2, u32 y2, u32 w, u32 h)
+static void xp_copy_rect(struct tridentfb_par *par,
+			 u32 x1, u32 y1, u32 x2, u32 y2, u32 w, u32 h)
 {
 	int direction;
 	u32 x1_tmp, x2_tmp, y1_tmp, y2_tmp;
@@ -379,12 +389,12 @@ static void xp_copy_rect(u32 x1, u32 y1,
 		y2_tmp =3D y2;
 	}
=20
-	writemmr(0x2128, direction);
-	t_outb(ROP_S, 0x2127);
-	writemmr(0x213C, masked_point(y1_tmp, x1_tmp));
-	writemmr(0x2138, masked_point(y2_tmp, x2_tmp));
-	writemmr(0x2140, masked_point(h, w));
-	t_outb(0x01, 0x2124);
+	writemmr(par, 0x2128, direction);
+	t_outb(par, ROP_S, 0x2127);
+	writemmr(par, 0x213C, masked_point(y1_tmp, x1_tmp));
+	writemmr(par, 0x2138, masked_point(y2_tmp, x2_tmp));
+	writemmr(par, 0x2140, masked_point(h, w));
+	t_outb(par, 0x01, 0x2124);
 }
=20
 static struct accel_switch accel_xp =3D {
@@ -397,7 +407,7 @@ static struct accel_switch accel_xp =3D {
 /*
  * Image specific acceleration functions
  */
-static void image_init_accel(int pitch, int bpp)
+static void image_init_accel(struct tridentfb_par *par, int pitch, int=20
bpp)
 {
 	int tmp =3D 0;
 	switch (bpp) {
@@ -415,40 +425,42 @@ static void image_init_accel(int pitch,
 		tmp =3D 2;
 		break;
 	}
-	writemmr(0x2120, 0xF0000000);
-	writemmr(0x2120, 0x40000000 | tmp);
-	writemmr(0x2120, 0x80000000);
-	writemmr(0x2144, 0x00000000);
-	writemmr(0x2148, 0x00000000);
-	writemmr(0x2150, 0x00000000);
-	writemmr(0x2154, 0x00000000);
-	writemmr(0x2120, 0x60000000 | (pitch << 16) | pitch);
-	writemmr(0x216C, 0x00000000);
-	writemmr(0x2170, 0x00000000);
-	writemmr(0x217C, 0x00000000);
-	writemmr(0x2120, 0x10000000);
-	writemmr(0x2130, (2047 << 16) | 2047);
+	writemmr(par, 0x2120, 0xF0000000);
+	writemmr(par, 0x2120, 0x40000000 | tmp);
+	writemmr(par, 0x2120, 0x80000000);
+	writemmr(par, 0x2144, 0x00000000);
+	writemmr(par, 0x2148, 0x00000000);
+	writemmr(par, 0x2150, 0x00000000);
+	writemmr(par, 0x2154, 0x00000000);
+	writemmr(par, 0x2120, 0x60000000 | (pitch << 16) | pitch);
+	writemmr(par, 0x216C, 0x00000000);
+	writemmr(par, 0x2170, 0x00000000);
+	writemmr(par, 0x217C, 0x00000000);
+	writemmr(par, 0x2120, 0x10000000);
+	writemmr(par, 0x2130, (2047 << 16) | 2047);
 }
=20
-static void image_wait_engine(void)
+static void image_wait_engine(struct tridentfb_par *par)
 {
-	while (readmmr(0x2164) & 0xF0000000) ;
+	while (readmmr(par, 0x2164) & 0xF0000000) ;
 }
=20
-static void image_fill_rect(u32 x, u32 y, u32 w, u32 h, u32 c, u32 rop)
+static void image_fill_rect(struct tridentfb_par *par,
+			    u32 x, u32 y, u32 w, u32 h, u32 c, u32 rop)
 {
-	writemmr(0x2120, 0x80000000);
-	writemmr(0x2120, 0x90000000 | ROP_S);
+	writemmr(par, 0x2120, 0x80000000);
+	writemmr(par, 0x2120, 0x90000000 | ROP_S);
=20
-	writemmr(0x2144, c);
+	writemmr(par, 0x2144, c);
=20
-	writemmr(DR1, point(x, y));
-	writemmr(DR2, point(x + w - 1, y + h - 1));
+	writemmr(par, DR1, point(x, y));
+	writemmr(par, DR2, point(x + w - 1, y + h - 1));
=20
-	writemmr(0x2124, 0x80000000 | 3 << 22 | 1 << 10 | 1 << 9);
+	writemmr(par, 0x2124, 0x80000000 | 3 << 22 | 1 << 10 | 1 << 9);
 }
=20
-static void image_copy_rect(u32 x1, u32 y1, u32 x2, u32 y2, u32 w, u32 h=
)
+static void image_copy_rect(struct tridentfb_par *par,
+			    u32 x1, u32 y1, u32 x2, u32 y2, u32 w, u32 h)
 {
 	u32 s1, s2, d1, d2;
 	int direction =3D 2;
@@ -460,14 +472,15 @@ static void image_copy_rect(u32 x1, u32
 	if ((y1 > y2) || ((y1 =3D=3D y2) && (x1 > x2)))
 		direction =3D 0;
=20
-	writemmr(0x2120, 0x80000000);
-	writemmr(0x2120, 0x90000000 | ROP_S);
+	writemmr(par, 0x2120, 0x80000000);
+	writemmr(par, 0x2120, 0x90000000 | ROP_S);
=20
-	writemmr(SR1, direction ? s2 : s1);
-	writemmr(SR2, direction ? s1 : s2);
-	writemmr(DR1, direction ? d2 : d1);
-	writemmr(DR2, direction ? d1 : d2);
-	writemmr(0x2124, 0x80000000 | 1 << 22 | 1 << 10 | 1 << 7 | direction);
+	writemmr(par, SR1, direction ? s2 : s1);
+	writemmr(par, SR2, direction ? s1 : s2);
+	writemmr(par, DR1, direction ? d2 : d1);
+	writemmr(par, DR2, direction ? d1 : d2);
+	writemmr(par, 0x2124,
+		 0x80000000 | 1 << 22 | 1 << 10 | 1 << 7 | direction);
 }
=20
 static struct accel_switch accel_image =3D {
@@ -521,49 +534,51 @@ static void tridentfb_copyarea(struct fb
  * Hardware access functions
  */
=20
-static inline unsigned char read3X4(int reg)
+static inline unsigned char read3X4(struct tridentfb_par *par, int reg)
 {
-	struct tridentfb_par *par =3D (struct tridentfb_par *)fb_info.par;
 	writeb(reg, par->io_virt + CRT + 4);
 	return readb(par->io_virt + CRT + 5);
 }
=20
-static inline void write3X4(int reg, unsigned char val)
+static inline void write3X4(struct tridentfb_par *par, int reg,
+			    unsigned char val)
 {
-	struct tridentfb_par *par =3D (struct tridentfb_par *)fb_info.par;
 	writeb(reg, par->io_virt + CRT + 4);
 	writeb(val, par->io_virt + CRT + 5);
 }
=20
-static inline unsigned char read3C4(int reg)
+static inline unsigned char read3C4(struct tridentfb_par *par, int reg)
 {
-	t_outb(reg, 0x3C4);
-	return t_inb(0x3C5);
+	t_outb(par, reg, 0x3C4);
+	return t_inb(par, 0x3C5);
 }
=20
-static inline void write3C4(int reg, unsigned char val)
+static inline void write3C4(struct tridentfb_par *par, int reg,
+			    unsigned char val)
 {
-	t_outb(reg, 0x3C4);
-	t_outb(val, 0x3C5);
+	t_outb(par, reg, 0x3C4);
+	t_outb(par, val, 0x3C5);
 }
=20
-static inline unsigned char read3CE(int reg)
+static inline unsigned char read3CE(struct tridentfb_par *par, int reg)
 {
-	t_outb(reg, 0x3CE);
-	return t_inb(0x3CF);
+	t_outb(par, reg, 0x3CE);
+	return t_inb(par, 0x3CF);
 }
=20
-static inline void writeAttr(int reg, unsigned char val)
+static inline void writeAttr(struct tridentfb_par *par, int reg,
+			     unsigned char val)
 {
-	readb(((struct tridentfb_par *)fb_info.par)->io_virt + CRT + 0x0A);	/*=20
flip-flop to index */
-	t_outb(reg, 0x3C0);
-	t_outb(val, 0x3C0);
+	fb_readb(par->io_virt + CRT + 0x0A);	/* flip-flop to index */
+	t_outb(par, reg, 0x3C0);
+	t_outb(par, val, 0x3C0);
 }
=20
-static inline void write3CE(int reg, unsigned char val)
+static inline void write3CE(struct tridentfb_par *par, int reg,
+			    unsigned char val)
 {
-	t_outb(reg, 0x3CE);
-	t_outb(val, 0x3CF);
+	t_outb(par, reg, 0x3CE);
+	t_outb(par, val, 0x3CF);
 }
=20
 static void enable_mmio(void)
@@ -581,32 +596,35 @@ static void enable_mmio(void)
 	outb(inb(0x3D5) | 0x01, 0x3D5);
 }
=20
-static void disable_mmio(void)
+static void disable_mmio(struct tridentfb_par *par)
 {
 	/* Goto New Mode */
-	t_outb(0x0B, 0x3C4);
-	t_inb(0x3C5);
+	t_outb(par, 0x0B, 0x3C4);
+	t_inb(par, 0x3C5);
=20
 	/* Unprotect registers */
-	t_outb(NewMode1, 0x3C4);
-	t_outb(0x80, 0x3C5);
+	t_outb(par, NewMode1, 0x3C4);
+	t_outb(par, 0x80, 0x3C5);
=20
 	/* Disable MMIO */
-	t_outb(PCIReg, 0x3D4);
-	t_outb(t_inb(0x3D5) & ~0x01, 0x3D5);
+	t_outb(par, PCIReg, 0x3D4);
+	t_outb(par, t_inb(par, 0x3D5) & ~0x01, 0x3D5);
 }
=20
-#define crtc_unlock()	write3X4(CRTVSyncEnd, read3X4(CRTVSyncEnd) & 0x7F)
+static void crtc_unlock(struct tridentfb_par *par)
+{
+	write3X4(par, CRTVSyncEnd, read3X4(par, CRTVSyncEnd) & 0x7F);
+}
=20
 /*  Return flat panel's maximum x resolution */
-static int __devinit get_nativex(void)
+static int __devinit get_nativex(struct tridentfb_par *par)
 {
 	int x, y, tmp;
=20
 	if (nativex)
 		return nativex;
=20
-	tmp =3D (read3CE(VertStretch) >> 4) & 3;
+	tmp =3D (read3CE(par, VertStretch) >> 4) & 3;
=20
 	switch (tmp) {
 	case 0:
@@ -632,44 +650,45 @@ static int __devinit get_nativex(void)
 }
=20
 /* Set pitch */
-static void set_lwidth(int width)
+static void set_lwidth(struct tridentfb_par *par, int width)
 {
-	write3X4(Offset, width & 0xFF);
-	write3X4(AddColReg,
-		 (read3X4(AddColReg) & 0xCF) | ((width & 0x300) >> 4));
+	write3X4(par, Offset, width & 0xFF);
+	write3X4(par, AddColReg,
+		 (read3X4(par, AddColReg) & 0xCF) | ((width & 0x300) >> 4));
 }
=20
 /* For resolutions smaller than FP resolution stretch */
-static void screen_stretch(void)
+static void screen_stretch(struct tridentfb_par *par)
 {
 	if (chip_id !=3D CYBERBLADEXPAi1)
-		write3CE(BiosReg, 0);
+		write3CE(par, BiosReg, 0);
 	else
-		write3CE(BiosReg, 8);
-	write3CE(VertStretch, (read3CE(VertStretch) & 0x7C) | 1);
-	write3CE(HorStretch, (read3CE(HorStretch) & 0x7C) | 1);
+		write3CE(par, BiosReg, 8);
+	write3CE(par, VertStretch, (read3CE(par, VertStretch) & 0x7C) | 1);
+	write3CE(par, HorStretch, (read3CE(par, HorStretch) & 0x7C) | 1);
 }
=20
 /* For resolutions smaller than FP resolution center */
-static void screen_center(void)
+static void screen_center(struct tridentfb_par *par)
 {
-	write3CE(VertStretch, (read3CE(VertStretch) & 0x7C) | 0x80);
-	write3CE(HorStretch, (read3CE(HorStretch) & 0x7C) | 0x80);
+	write3CE(par, VertStretch, (read3CE(par, VertStretch) & 0x7C) | 0x80);
+	write3CE(par, HorStretch, (read3CE(par, HorStretch) & 0x7C) | 0x80);
 }
=20
 /* Address of first shown pixel in display memory */
-static void set_screen_start(int base)
+static void set_screen_start(struct tridentfb_par *par, int base)
 {
-	write3X4(StartAddrLow, base & 0xFF);
-	write3X4(StartAddrHigh, (base & 0xFF00) >> 8);
-	write3X4(CRTCModuleTest,
-		 (read3X4(CRTCModuleTest) & 0xDF) | ((base & 0x10000) >> 11));
-	write3X4(CRTHiOrd,
-		 (read3X4(CRTHiOrd) & 0xF8) | ((base & 0xE0000) >> 17));
+	u8 tmp;
+	write3X4(par, StartAddrLow, base & 0xFF);
+	write3X4(par, StartAddrHigh, (base & 0xFF00) >> 8);
+	tmp =3D read3X4(par, CRTCModuleTest) & 0xDF;
+	write3X4(par, CRTCModuleTest, tmp | ((base & 0x10000) >> 11));
+	tmp =3D read3X4(par, CRTHiOrd) & 0xF8;
+	write3X4(par, CRTHiOrd, tmp | ((base & 0xE0000) >> 17));
 }
=20
 /* Set dotclock frequency */
-static void set_vclk(unsigned long freq)
+static void set_vclk(struct tridentfb_par *par, unsigned long freq)
 {
 	int m, n, k;
 	unsigned long f, fi, d, di;
@@ -690,8 +709,8 @@ static void set_vclk(unsigned long freq)
 					break;
 			}
 	if (chip3D) {
-		write3C4(ClockHigh, hi);
-		write3C4(ClockLow, lo);
+		write3C4(par, ClockHigh, hi);
+		write3C4(par, ClockLow, lo);
 	} else {
 		outb(lo, 0x43C8);
 		outb(hi, 0x43C9);
@@ -700,9 +719,9 @@ static void set_vclk(unsigned long freq)
 }
=20
 /* Set number of lines for flat panels*/
-static void set_number_of_lines(int lines)
+static void set_number_of_lines(struct tridentfb_par *par, int lines)
 {
-	int tmp =3D read3CE(CyberEnhance) & 0x8F;
+	int tmp =3D read3CE(par, CyberEnhance) & 0x8F;
 	if (lines > 1024)
 		tmp |=3D 0x50;
 	else if (lines > 768)
@@ -711,24 +730,24 @@ static void set_number_of_lines(int line
 		tmp |=3D 0x20;
 	else if (lines > 480)
 		tmp |=3D 0x10;
-	write3CE(CyberEnhance, tmp);
+	write3CE(par, CyberEnhance, tmp);
 }
=20
 /*
  * If we see that FP is active we assume we have one.
  * Otherwise we have a CRT display.User can override.
  */
-static unsigned int __devinit get_displaytype(void)
+static unsigned int __devinit get_displaytype(struct tridentfb_par *par)
 {
 	if (fp)
 		return DISPLAY_FP;
 	if (crt || !chipcyber)
 		return DISPLAY_CRT;
-	return (read3CE(FPConfig) & 0x10) ? DISPLAY_FP : DISPLAY_CRT;
+	return (read3CE(par, FPConfig) & 0x10) ? DISPLAY_FP : DISPLAY_CRT;
 }
=20
 /* Try detecting the video memory size */
-static unsigned int __devinit get_memsize(void)
+static unsigned int __devinit get_memsize(struct tridentfb_par *par)
 {
 	unsigned char tmp, tmp2;
 	unsigned int k;
@@ -742,7 +761,7 @@ static unsigned int __devinit get_memsiz
 			k =3D 2560 * Kb;
 			break;
 		default:
-			tmp =3D read3X4(SPR) & 0x0F;
+			tmp =3D read3X4(par, SPR) & 0x0F;
 			switch (tmp) {
=20
 			case 0x01:
@@ -774,7 +793,7 @@ static unsigned int __devinit get_memsiz
 				break;
 			case 0x0E:		/* XP */
=20
-				tmp2 =3D read3C4(0xC1);
+				tmp2 =3D read3C4(par, 0xC1);
 				switch (tmp2) {
 				case 0x00:
 					k =3D 20 * Mb;
@@ -862,6 +881,7 @@ static int tridentfb_check_var(struct fb
 static int tridentfb_pan_display(struct fb_var_screeninfo *var,
 				 struct fb_info *info)
 {
+	struct tridentfb_par *par =3D (struct tridentfb_par *)(info->par);
 	unsigned int offset;
=20
 	debug("enter\n");
@@ -869,13 +889,20 @@ static int tridentfb_pan_display(struct
 		* var->bits_per_pixel / 32;
 	info->var.xoffset =3D var->xoffset;
 	info->var.yoffset =3D var->yoffset;
-	set_screen_start(offset);
+	set_screen_start(par, offset);
 	debug("exit\n");
 	return 0;
 }
=20
-#define shadowmode_on()  write3CE(CyberControl, read3CE(CyberControl) |=20
0x81)
-#define shadowmode_off() write3CE(CyberControl, read3CE(CyberControl) &=20
0x7E)
+static void shadowmode_on(struct tridentfb_par *par)
+{
+	write3CE(par, CyberControl, read3CE(par, CyberControl) | 0x81);
+}
+
+static void shadowmode_off(struct tridentfb_par *par)
+{
+	write3CE(par, CyberControl, read3CE(par, CyberControl) & 0x7E);
+}
=20
 /* Set the hardware to the requested video mode */
 static int tridentfb_set_par(struct fb_info *info)
@@ -905,8 +932,8 @@ static int tridentfb_set_par(struct fb_i
 	vblankstart =3D var->yres;
 	vblankend =3D vtotal + 2;
=20
-	crtc_unlock();
-	write3CE(CyberControl, 8);
+	crtc_unlock(par);
+	write3CE(par, CyberControl, 8);
=20
 	if (flatpanel && var->xres < nativex) {
 		/*
@@ -914,35 +941,36 @@ static int tridentfb_set_par(struct fb_i
 		 * than requested resolution decide whether
 		 * we stretch or center
 		 */
-		t_outb(0xEB, 0x3C2);
+		t_outb(par, 0xEB, 0x3C2);
=20
-		shadowmode_on();
+		shadowmode_on(par);
=20
 		if (center)
-			screen_center();
+			screen_center(par);
 		else if (stretch)
-			screen_stretch();
+			screen_stretch(par);
=20
 	} else {
-		t_outb(0x2B, 0x3C2);
-		write3CE(CyberControl, 8);
+		t_outb(par, 0x2B, 0x3C2);
+		write3CE(par, CyberControl, 8);
 	}
=20
 	/* vertical timing values */
-	write3X4(CRTVTotal, vtotal & 0xFF);
-	write3X4(CRTVDispEnd, vdispend & 0xFF);
-	write3X4(CRTVSyncStart, vsyncstart & 0xFF);
-	write3X4(CRTVSyncEnd, (vsyncend & 0x0F));
-	write3X4(CRTVBlankStart, vblankstart & 0xFF);
-	write3X4(CRTVBlankEnd, 0 /* p->vblankend & 0xFF */ );
+	write3X4(par, CRTVTotal, vtotal & 0xFF);
+	write3X4(par, CRTVDispEnd, vdispend & 0xFF);
+	write3X4(par, CRTVSyncStart, vsyncstart & 0xFF);
+	write3X4(par, CRTVSyncEnd, (vsyncend & 0x0F));
+	write3X4(par, CRTVBlankStart, vblankstart & 0xFF);
+	write3X4(par, CRTVBlankEnd, 0 /* p->vblankend & 0xFF */);
=20
 	/* horizontal timing values */
-	write3X4(CRTHTotal, htotal & 0xFF);
-	write3X4(CRTHDispEnd, hdispend & 0xFF);
-	write3X4(CRTHSyncStart, hsyncstart & 0xFF);
-	write3X4(CRTHSyncEnd, (hsyncend & 0x1F) | ((hblankend & 0x20) << 2));
-	write3X4(CRTHBlankStart, hblankstart & 0xFF);
-	write3X4(CRTHBlankEnd, 0 /* (p->hblankend & 0x1F) */ );
+	write3X4(par, CRTHTotal, htotal & 0xFF);
+	write3X4(par, CRTHDispEnd, hdispend & 0xFF);
+	write3X4(par, CRTHSyncStart, hsyncstart & 0xFF);
+	write3X4(par, CRTHSyncEnd,
+		 (hsyncend & 0x1F) | ((hblankend & 0x20) << 2));
+	write3X4(par, CRTHBlankStart, hblankstart & 0xFF);
+	write3X4(par, CRTHBlankEnd, 0 /* (p->hblankend & 0x1F) */);
=20
 	/* higher bits of vertical timing values */
 	tmp =3D 0x10;
@@ -954,35 +982,37 @@ static int tridentfb_set_par(struct fb_i
 	if (vtotal & 0x200) tmp |=3D 0x20;
 	if (vdispend & 0x200) tmp |=3D 0x40;
 	if (vsyncstart & 0x200) tmp |=3D 0x80;
-	write3X4(CRTOverflow, tmp);
+	write3X4(par, CRTOverflow, tmp);
=20
-	tmp =3D read3X4(CRTHiOrd) | 0x08;	/* line compare bit 10 */
+	tmp =3D read3X4(par, CRTHiOrd) | 0x08;	/* line compare bit 10 */
 	if (vtotal & 0x400) tmp |=3D 0x80;
 	if (vblankstart & 0x400) tmp |=3D 0x40;
 	if (vsyncstart & 0x400) tmp |=3D 0x20;
 	if (vdispend & 0x400) tmp |=3D 0x10;
-	write3X4(CRTHiOrd, tmp);
+	write3X4(par, CRTHiOrd, tmp);
=20
 	tmp =3D 0;
 	if (htotal & 0x800) tmp |=3D 0x800 >> 11;
 	if (hblankstart & 0x800) tmp |=3D 0x800 >> 7;
-	write3X4(HorizOverflow, tmp);
+	write3X4(par, HorizOverflow, tmp);
=20
 	tmp =3D 0x40;
 	if (vblankstart & 0x200) tmp |=3D 0x20;
 //FIXME	if (info->var.vmode & FB_VMODE_DOUBLE) tmp |=3D 0x80;  /* double=
=20
scan for 200 line modes */
-	write3X4(CRTMaxScanLine, tmp);
+	write3X4(par, CRTMaxScanLine, tmp);
=20
-	write3X4(CRTLineCompare, 0xFF);
-	write3X4(CRTPRowScan, 0);
-	write3X4(CRTModeControl, 0xC3);
+	write3X4(par, CRTLineCompare, 0xFF);
+	write3X4(par, CRTPRowScan, 0);
+	write3X4(par, CRTModeControl, 0xC3);
=20
-	write3X4(LinearAddReg, 0x20);	/* enable linear addressing */
+	write3X4(par, LinearAddReg, 0x20);	/* enable linear addressing */
=20
 	tmp =3D (info->var.vmode & FB_VMODE_INTERLACED) ? 0x84 : 0x80;
-	write3X4(CRTCModuleTest, tmp);	/* enable access extended memory */
+	/* enable access extended memory */
+	write3X4(par, CRTCModuleTest, tmp);
=20
-	write3X4(GraphEngReg, 0x80);	/* enable GE for text acceleration */
+	/* enable GE for text acceleration */
+	write3X4(par, GraphEngReg, 0x80);
=20
 #ifdef CONFIG_FB_TRIDENT_ACCEL
 	acc->init_accel(info->var.xres, bpp);
@@ -1003,49 +1033,52 @@ static int tridentfb_set_par(struct fb_i
 		break;
 	}
=20
-	write3X4(PixelBusReg, tmp);
+	write3X4(par, PixelBusReg, tmp);
=20
 	tmp =3D 0x10;
 	if (chipcyber)
 		tmp |=3D 0x20;
-	write3X4(DRAMControl, tmp);	/* both IO, linear enable */
+	write3X4(par, DRAMControl, tmp);	/* both IO, linear enable */
=20
-	write3X4(InterfaceSel, read3X4(InterfaceSel) | 0x40);
-	write3X4(Performance, 0x92);
-	write3X4(PCIReg, 0x07);		/* MMIO & PCI read and write burst enable */
+	write3X4(par, InterfaceSel, read3X4(par, InterfaceSel) | 0x40);
+	write3X4(par, Performance, 0x92);
+	/* MMIO & PCI read and write burst enable */
+	write3X4(par, PCIReg, 0x07);
=20
 	/* convert from picoseconds to kHz */
 	vclk =3D PICOS2KHZ(info->var.pixclock);
 	if (bpp =3D=3D 32)
 		vclk *=3D 2;
-	set_vclk(vclk);
+	set_vclk(par, vclk);
=20
-	write3C4(0, 3);
-	write3C4(1, 1);		/* set char clock 8 dots wide */
-	write3C4(2, 0x0F);	/* enable 4 maps because needed in chain4 mode */
-	write3C4(3, 0);
-	write3C4(4, 0x0E);	/* memory mode enable bitmaps ?? */
-
-	write3CE(MiscExtFunc, (bpp =3D=3D 32) ? 0x1A : 0x12);	/* divide clock b=
y 2=20
if 32bpp */
-							/* chain4 mode display and CPU path */
-	write3CE(0x5, 0x40);	/* no CGA compat, allow 256 col */
-	write3CE(0x6, 0x05);	/* graphics mode */
-	write3CE(0x7, 0x0F);	/* planes? */
+	write3C4(par, 0, 3);
+	write3C4(par, 1, 1);		/* set char clock 8 dots wide */
+	/* enable 4 maps because needed in chain4 mode */
+	write3C4(par, 2, 0x0F);
+	write3C4(par, 3, 0);
+	write3C4(par, 4, 0x0E);	/* memory mode enable bitmaps ?? */
+
+	/* divide clock by 2 if 32bpp chain4 mode display and CPU path */
+	write3CE(par, MiscExtFunc, (bpp =3D=3D 32) ? 0x1A : 0x12);
+	write3CE(par, 0x5, 0x40);	/* no CGA compat, allow 256 col */
+	write3CE(par, 0x6, 0x05);	/* graphics mode */
+	write3CE(par, 0x7, 0x0F);	/* planes? */
=20
 	if (chip_id =3D=3D CYBERBLADEXPAi1) {
 		/* This fixes snow-effect in 32 bpp */
-		write3X4(CRTHSyncStart, 0x84);
+		write3X4(par, CRTHSyncStart, 0x84);
 	}
=20
-	writeAttr(0x10, 0x41);	/* graphics mode and support 256 color modes */
-	writeAttr(0x12, 0x0F);	/* planes */
-	writeAttr(0x13, 0);	/* horizontal pel panning */
+	/* graphics mode and support 256 color modes */
+	writeAttr(par, 0x10, 0x41);
+	writeAttr(par, 0x12, 0x0F);	/* planes */
+	writeAttr(par, 0x13, 0);	/* horizontal pel panning */
=20
 	/* colors */
 	for (tmp =3D 0; tmp < 0x10; tmp++)
-		writeAttr(tmp, tmp);
-	readb(par->io_virt + CRT + 0x0A);	/* flip-flop to index */
-	t_outb(0x20, 0x3C0);			/* enable attr */
+		writeAttr(par, tmp, tmp);
+	fb_readb(par->io_virt + CRT + 0x0A);	/* flip-flop to index */
+	t_outb(par, 0x20, 0x3C0);		/* enable attr */
=20
 	switch (bpp) {
 	case 8:
@@ -1063,17 +1096,17 @@ static int tridentfb_set_par(struct fb_i
 		break;
 	}
=20
-	t_inb(0x3C8);
-	t_inb(0x3C6);
-	t_inb(0x3C6);
-	t_inb(0x3C6);
-	t_inb(0x3C6);
-	t_outb(tmp, 0x3C6);
-	t_inb(0x3C8);
+	t_inb(par, 0x3C8);
+	t_inb(par, 0x3C6);
+	t_inb(par, 0x3C6);
+	t_inb(par, 0x3C6);
+	t_inb(par, 0x3C6);
+	t_outb(par, tmp, 0x3C6);
+	t_inb(par, 0x3C8);
=20
 	if (flatpanel)
-		set_number_of_lines(info->var.yres);
-	set_lwidth(info->var.xres * bpp / (4 * 16));
+		set_number_of_lines(par, info->var.yres);
+	set_lwidth(par, info->var.xres * bpp / (4 * 16));
 	info->fix.visual =3D (bpp =3D=3D 8) ? FB_VISUAL_PSEUDOCOLOR :=20
FB_VISUAL_TRUECOLOR;
 	info->fix.line_length =3D info->var.xres * (bpp >> 3);
 	info->cmap.len =3D (bpp =3D=3D 8) ? 256 : 16;
@@ -1087,17 +1120,18 @@ static int tridentfb_setcolreg(unsigned
 			       struct fb_info *info)
 {
 	int bpp =3D info->var.bits_per_pixel;
+	struct tridentfb_par *par =3D (struct tridentfb_par*)info->par;
=20
 	if (regno >=3D info->cmap.len)
 		return 1;
=20
 	if (bpp =3D=3D 8) {
-		t_outb(0xFF, 0x3C6);
-		t_outb(regno, 0x3C8);
+		t_outb(par, 0xFF, 0x3C6);
+		t_outb(par, regno, 0x3C8);
=20
-		t_outb(red >> 10, 0x3C9);
-		t_outb(green >> 10, 0x3C9);
-		t_outb(blue >> 10, 0x3C9);
+		t_outb(par, red >> 10, 0x3C9);
+		t_outb(par, green >> 10, 0x3C9);
+		t_outb(par, blue >> 10, 0x3C9);
=20
 	} else if (regno < 16) {
 		if (bpp =3D=3D 16) {	/* RGB 565 */
@@ -1123,13 +1157,14 @@ static int tridentfb_setcolreg(unsigned
 static int tridentfb_blank(int blank_mode, struct fb_info *info)
 {
 	unsigned char PMCont, DPMSCont;
+	struct tridentfb_par *par =3D (struct tridentfb_par*)info->par;
=20
 	debug("enter\n");
 	if (flatpanel)
 		return 0;
-	t_outb(0x04, 0x83C8); /* Read DPMS Control */
-	PMCont =3D t_inb(0x83C6) & 0xFC;
-	DPMSCont =3D read3CE(PowerStatus) & 0xFC;
+	t_outb(par, 0x04, 0x83C8); /* Read DPMS Control */
+	PMCont =3D t_inb(par, 0x83C6) & 0xFC;
+	DPMSCont =3D read3CE(par, PowerStatus) & 0xFC;
 	switch (blank_mode) {
 	case FB_BLANK_UNBLANK:
 		/* Screen: On, HSync: On, VSync: On */
@@ -1155,9 +1190,9 @@ static int tridentfb_blank(int blank_mod
 		break;
 	}
=20
-	write3CE(PowerStatus, DPMSCont);
-	t_outb(4, 0x83C8);
-	t_outb(PMCont, 0x83C6);
+	write3CE(par, PowerStatus, DPMSCont);
+	t_outb(par, 4, 0x83C8);
+	t_outb(par, PMCont, 0x83C6);
=20
 	debug("exit\n");
=20
@@ -1265,11 +1300,11 @@ static int __devinit trident_pci_probe(s
=20
 	/* setup framebuffer memory */
 	tridentfb_fix.smem_start =3D pci_resource_start(dev, 0);
-	tridentfb_fix.smem_len =3D get_memsize();
+	tridentfb_fix.smem_len =3D get_memsize(&default_par);
=20
 	if (!request_mem_region(tridentfb_fix.smem_start,=20
tridentfb_fix.smem_len, "tridentfb")) {
 		debug("request_mem_region failed!\n");
-		disable_mmio();
+		disable_mmio(fb_info.par);
 		err =3D -1;
 		goto out_unmap1;
 	}
@@ -1284,10 +1319,10 @@ static int __devinit trident_pci_probe(s
 	}
=20
 	output("%s board found\n", pci_name(dev));
-	displaytype =3D get_displaytype();
+	displaytype =3D get_displaytype(&default_par);
=20
 	if (flatpanel)
-		nativex =3D get_nativex();
+		nativex =3D get_nativex(&default_par);
=20
 	fb_info.fix =3D tridentfb_fix;
 	fb_info.fbops =3D &tridentfb_ops;
@@ -1330,7 +1365,7 @@ out_unmap2:
 	if (fb_info.screen_base)
 		iounmap(fb_info.screen_base);
 	release_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len);
-	disable_mmio();
+	disable_mmio(fb_info.par);
 out_unmap1:
 	if (default_par.io_virt)
 		iounmap(default_par.io_virt);

----------------------------------------------------
Kobieta, W=F3dz, Kr=F3lowa... Zdobywczyni Oscara Cate Blanchet
oraz Clive Owen i Geoffrey Rush w nagrodzonym Oscarem filmie
"Elizabeth - z=B3oty wiek" Ju=BF na DVD!
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fcorto.www.wp.pl%2Fas%2Feliza.html&s=
id=3D331

--part481add658c35d
Content-Type: application/octet-stream; name="tridentfb-no-defines.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="tridentfb-no-defines.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggcmVw
bGFjZXMgbWFjcm9zIHdpdGggc3RhdGljIGZ1bmN0aW9ucyBhbmQKcHV0cyB0cmlkZW50ZmJfcGFy
IHBvaW50ZXIgYXMgdGhlIGZpcnN0IGFyZ3VtZW50IG9mCnRoZXNlIGZ1bmN0aW9ucy4gVGhlc2Ug
aXMgYSBzdGVwIHRvd2FyZCBtdWx0aWhlYWQKc3VwcG9ydC4KCkFkZGl0aW9uYWxseSwgYm9ndXMg
VFJJREVOVF9NTUlPIGRlZmluZSBpcyByZW1vdmVkIGFzCnRoZSBkcml2ZXIgc3VwcG9ydHMgZ3Jh
cGhpY3MgY2FyZHMgb25seSB0aHJvdWdoIHRoZSBtbWlvIG1vZGUuCgpTaWduZWQtb2ZmLWJ5OiBL
cnp5c3p0b2YgSGVsdCA8a3J6eXN6dG9mLmgxQHdwLnBsPgoKZGlmZiAtdXJwIGxpbnV4LW9sZC9k
cml2ZXJzL3ZpZGVvL3RyaWRlbnRmYi5jIGxpbnV4LXBjL2RyaXZlcnMvdmlkZW8vdHJpZGVudGZi
LmMKLS0tIGxpbnV4LW9sZC9kcml2ZXJzL3ZpZGVvL3RyaWRlbnRmYi5jCTIwMDgtMDUtMDEgMjM6
NDQ6MzkuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC1wYy9kcml2ZXJzL3ZpZGVvL3RyaWRlbnRm
Yi5jCTIwMDgtMDUtMDEgMjM6NTU6MDIuMDAwMDAwMDAwICswMjAwCkBAIC0xMzcsMjggKzEzNywz
NCBAQCBzdGF0aWMgaW50IGlzY3liZXIoaW50IGlkKQogCiAjZGVmaW5lIENSVCAweDNEMAkJLyog
Q1JUQyByZWdpc3RlcnMgb2Zmc2V0IGZvciBjb2xvciBkaXNwbGF5ICovCiAKLSNpZm5kZWYgVFJJ
REVOVF9NTUlPCi0JI2RlZmluZSBUUklERU5UX01NSU8gMQotI2VuZGlmCi0KLSNpZiBUUklERU5U
X01NSU8KLQkjZGVmaW5lIHRfb3V0Yih2YWwsIHJlZykJd3JpdGViKHZhbCwoKHN0cnVjdCB0cmlk
ZW50ZmJfcGFyICopKGZiX2luZm8ucGFyKSktPmlvX3ZpcnQgKyByZWcpCi0JI2RlZmluZSB0X2lu
YihyZWcpCXJlYWRiKCgoc3RydWN0IHRyaWRlbnRmYl9wYXIqKShmYl9pbmZvLnBhcikpLT5pb192
aXJ0ICsgcmVnKQotI2Vsc2UKLQkjZGVmaW5lIHRfb3V0Yih2YWwsIHJlZykgb3V0Yih2YWwsIHJl
ZykKLQkjZGVmaW5lIHRfaW5iKHJlZykgaW5iKHJlZykKLSNlbmRpZgorc3RhdGljIHZvaWQgdF9v
dXRiKHN0cnVjdCB0cmlkZW50ZmJfcGFyICpwLCB1OCB2YWwsIHUxNiByZWcpCit7CisJZmJfd3Jp
dGViKHZhbCwgcC0+aW9fdmlydCArIHJlZyk7Cit9CiAKK3N0YXRpYyB1OCB0X2luYihzdHJ1Y3Qg
dHJpZGVudGZiX3BhciAqcCwgdTE2IHJlZykKK3sKKwlyZXR1cm4gZmJfcmVhZGIocC0+aW9fdmly
dCArIHJlZyk7Cit9CiAKIHN0YXRpYyBzdHJ1Y3QgYWNjZWxfc3dpdGNoIHsKLQl2b2lkICgqaW5p
dF9hY2NlbCkgKGludCwgaW50KTsKLQl2b2lkICgqd2FpdF9lbmdpbmUpICh2b2lkKTsKLQl2b2lk
ICgqZmlsbF9yZWN0KSAodTMyLCB1MzIsIHUzMiwgdTMyLCB1MzIsIHUzMik7Ci0Jdm9pZCAoKmNv
cHlfcmVjdCkgKHUzMiwgdTMyLCB1MzIsIHUzMiwgdTMyLCB1MzIpOworCXZvaWQgKCppbml0X2Fj
Y2VsKSAoc3RydWN0IHRyaWRlbnRmYl9wYXIgKiwgaW50LCBpbnQpOworCXZvaWQgKCp3YWl0X2Vu
Z2luZSkgKHN0cnVjdCB0cmlkZW50ZmJfcGFyICopOworCXZvaWQgKCpmaWxsX3JlY3QpCisJCShz
dHJ1Y3QgdHJpZGVudGZiX3BhciAqcGFyLCB1MzIsIHUzMiwgdTMyLCB1MzIsIHUzMiwgdTMyKTsK
Kwl2b2lkICgqY29weV9yZWN0KQorCQkoc3RydWN0IHRyaWRlbnRmYl9wYXIgKnBhciwgdTMyLCB1
MzIsIHUzMiwgdTMyLCB1MzIsIHUzMik7CiB9ICphY2M7CiAKLSNkZWZpbmUgd3JpdGVtbXIociwg
dikJd3JpdGVsKHYsICgoc3RydWN0IHRyaWRlbnRmYl9wYXIgKilmYl9pbmZvLnBhciktPmlvX3Zp
cnQgKyByKQotI2RlZmluZSByZWFkbW1yKHIpCXJlYWRsKCgoc3RydWN0IHRyaWRlbnRmYl9wYXIg
KilmYl9pbmZvLnBhciktPmlvX3ZpcnQgKyByKQorc3RhdGljIHZvaWQgd3JpdGVtbXIoc3RydWN0
IHRyaWRlbnRmYl9wYXIgKnBhciwgdTE2IHIsIHUzMiB2KQoreworCWZiX3dyaXRlbCh2LCBwYXIt
PmlvX3ZpcnQgKyByKTsKK30KKworc3RhdGljIHUzMiByZWFkbW1yKHN0cnVjdCB0cmlkZW50ZmJf
cGFyICpwYXIsIHUxNiByKQoreworCXJldHVybiBmYl9yZWFkbChwYXItPmlvX3ZpcnQgKyByKTsK
K30KIAogLyoKICAqIEJsYWRlIHNwZWNpZmljIGFjY2VsZXJhdGlvbi4KQEAgLTE3Niw3ICsxODIs
NyBAQCBzdGF0aWMgc3RydWN0IGFjY2VsX3N3aXRjaCB7CiAKICNkZWZpbmUgUk9QX1MJMHhDQwog
Ci1zdGF0aWMgdm9pZCBibGFkZV9pbml0X2FjY2VsKGludCBwaXRjaCwgaW50IGJwcCkKK3N0YXRp
YyB2b2lkIGJsYWRlX2luaXRfYWNjZWwoc3RydWN0IHRyaWRlbnRmYl9wYXIgKnBhciwgaW50IHBp
dGNoLCBpbnQgYnBwKQogewogCWludCB2MSA9IChwaXRjaCA+PiAzKSA8PCAyMDsKIAlpbnQgdG1w
ID0gMCwgdjI7CkBAIC0xOTYsMzMgKzIwMiwzNSBAQCBzdGF0aWMgdm9pZCBibGFkZV9pbml0X2Fj
Y2VsKGludCBwaXRjaCwgCiAJCWJyZWFrOwogCX0KIAl2MiA9IHYxIHwgKHRtcCA8PCAyOSk7Ci0J
d3JpdGVtbXIoMHgyMUMwLCB2Mik7Ci0Jd3JpdGVtbXIoMHgyMUM0LCB2Mik7Ci0Jd3JpdGVtbXIo
MHgyMUI4LCB2Mik7Ci0Jd3JpdGVtbXIoMHgyMUJDLCB2Mik7Ci0Jd3JpdGVtbXIoMHgyMUQwLCB2
MSk7Ci0Jd3JpdGVtbXIoMHgyMUQ0LCB2MSk7Ci0Jd3JpdGVtbXIoMHgyMUM4LCB2MSk7Ci0Jd3Jp
dGVtbXIoMHgyMUNDLCB2MSk7Ci0Jd3JpdGVtbXIoMHgyMTZDLCAwKTsKKwl3cml0ZW1tcihwYXIs
IDB4MjFDMCwgdjIpOworCXdyaXRlbW1yKHBhciwgMHgyMUM0LCB2Mik7CisJd3JpdGVtbXIocGFy
LCAweDIxQjgsIHYyKTsKKwl3cml0ZW1tcihwYXIsIDB4MjFCQywgdjIpOworCXdyaXRlbW1yKHBh
ciwgMHgyMUQwLCB2MSk7CisJd3JpdGVtbXIocGFyLCAweDIxRDQsIHYxKTsKKwl3cml0ZW1tcihw
YXIsIDB4MjFDOCwgdjEpOworCXdyaXRlbW1yKHBhciwgMHgyMUNDLCB2MSk7CisJd3JpdGVtbXIo
cGFyLCAweDIxNkMsIDApOwogfQogCi1zdGF0aWMgdm9pZCBibGFkZV93YWl0X2VuZ2luZSh2b2lk
KQorc3RhdGljIHZvaWQgYmxhZGVfd2FpdF9lbmdpbmUoc3RydWN0IHRyaWRlbnRmYl9wYXIgKnBh
cikKIHsKLQl3aGlsZSAocmVhZG1tcihTVEEpICYgMHhGQTgwMDAwMCkgOworCXdoaWxlIChyZWFk
bW1yKHBhciwgU1RBKSAmIDB4RkE4MDAwMDApIDsKIH0KIAotc3RhdGljIHZvaWQgYmxhZGVfZmls
bF9yZWN0KHUzMiB4LCB1MzIgeSwgdTMyIHcsIHUzMiBoLCB1MzIgYywgdTMyIHJvcCkKK3N0YXRp
YyB2b2lkIGJsYWRlX2ZpbGxfcmVjdChzdHJ1Y3QgdHJpZGVudGZiX3BhciAqcGFyLAorCQkJICAg
IHUzMiB4LCB1MzIgeSwgdTMyIHcsIHUzMiBoLCB1MzIgYywgdTMyIHJvcCkKIHsKLQl3cml0ZW1t
cihDTFIsIGMpOwotCXdyaXRlbW1yKFJPUCwgcm9wID8gMHg2NiA6IFJPUF9TKTsKLQl3cml0ZW1t
cihDTUQsIDB4MjAwMDAwMDAgfCAxIDw8IDE5IHwgMSA8PCA0IHwgMiA8PCAyKTsKKwl3cml0ZW1t
cihwYXIsIENMUiwgYyk7CisJd3JpdGVtbXIocGFyLCBST1AsIHJvcCA/IDB4NjYgOiBST1BfUyk7
CisJd3JpdGVtbXIocGFyLCBDTUQsIDB4MjAwMDAwMDAgfCAxIDw8IDE5IHwgMSA8PCA0IHwgMiA8
PCAyKTsKIAotCXdyaXRlbW1yKERSMSwgcG9pbnQoeCwgeSkpOwotCXdyaXRlbW1yKERSMiwgcG9p
bnQoeCArIHcgLSAxLCB5ICsgaCAtIDEpKTsKKwl3cml0ZW1tcihwYXIsIERSMSwgcG9pbnQoeCwg
eSkpOworCXdyaXRlbW1yKHBhciwgRFIyLCBwb2ludCh4ICsgdyAtIDEsIHkgKyBoIC0gMSkpOwog
fQogCi1zdGF0aWMgdm9pZCBibGFkZV9jb3B5X3JlY3QodTMyIHgxLCB1MzIgeTEsIHUzMiB4Miwg
dTMyIHkyLCB1MzIgdywgdTMyIGgpCitzdGF0aWMgdm9pZCBibGFkZV9jb3B5X3JlY3Qoc3RydWN0
IHRyaWRlbnRmYl9wYXIgKnBhciwKKwkJCSAgICB1MzIgeDEsIHUzMiB5MSwgdTMyIHgyLCB1MzIg
eTIsIHUzMiB3LCB1MzIgaCkKIHsKIAl1MzIgczEsIHMyLCBkMSwgZDI7CiAJaW50IGRpcmVjdGlv
biA9IDI7CkBAIC0yMzQsMTMgKzI0MiwxMyBAQCBzdGF0aWMgdm9pZCBibGFkZV9jb3B5X3JlY3Qo
dTMyIHgxLCB1MzIgCiAJaWYgKCh5MSA+IHkyKSB8fCAoKHkxID09IHkyKSAmJiAoeDEgPiB4Mikp
KQogCQlkaXJlY3Rpb24gPSAwOwogCi0Jd3JpdGVtbXIoUk9QLCBST1BfUyk7Ci0Jd3JpdGVtbXIo
Q01ELCAweEUwMDAwMDAwIHwgMSA8PCAxOSB8IDEgPDwgNCB8IDEgPDwgMiB8IGRpcmVjdGlvbik7
CisJd3JpdGVtbXIocGFyLCBST1AsIFJPUF9TKTsKKwl3cml0ZW1tcihwYXIsIENNRCwgMHhFMDAw
MDAwMCB8IDEgPDwgMTkgfCAxIDw8IDQgfCAxIDw8IDIgfCBkaXJlY3Rpb24pOwogCi0Jd3JpdGVt
bXIoU1IxLCBkaXJlY3Rpb24gPyBzMiA6IHMxKTsKLQl3cml0ZW1tcihTUjIsIGRpcmVjdGlvbiA/
IHMxIDogczIpOwotCXdyaXRlbW1yKERSMSwgZGlyZWN0aW9uID8gZDIgOiBkMSk7Ci0Jd3JpdGVt
bXIoRFIyLCBkaXJlY3Rpb24gPyBkMSA6IGQyKTsKKwl3cml0ZW1tcihwYXIsIFNSMSwgZGlyZWN0
aW9uID8gczIgOiBzMSk7CisJd3JpdGVtbXIocGFyLCBTUjIsIGRpcmVjdGlvbiA/IHMxIDogczIp
OworCXdyaXRlbW1yKHBhciwgRFIxLCBkaXJlY3Rpb24gPyBkMiA6IGQxKTsKKwl3cml0ZW1tcihw
YXIsIERSMiwgZGlyZWN0aW9uID8gZDEgOiBkMik7CiB9CiAKIHN0YXRpYyBzdHJ1Y3QgYWNjZWxf
c3dpdGNoIGFjY2VsX2JsYWRlID0gewpAQCAtMjU3LDcgKzI2NSw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
YWNjZWxfc3dpdGNoIGFjY2VsX2JsYWRlID0KICNkZWZpbmUgUk9QX1AgMHhGMAogI2RlZmluZSBt
YXNrZWRfcG9pbnQoeCwgeSkgKCh5ICYgMHhmZmZmKTw8MTZ8KHggJiAweGZmZmYpKQogCi1zdGF0
aWMgdm9pZCB4cF9pbml0X2FjY2VsKGludCBwaXRjaCwgaW50IGJwcCkKK3N0YXRpYyB2b2lkIHhw
X2luaXRfYWNjZWwoc3RydWN0IHRyaWRlbnRmYl9wYXIgKnBhciwgaW50IHBpdGNoLCBpbnQgYnBw
KQogewogCWludCB0bXAgPSAwLCB2MTsKIAl1bnNpZ25lZCBjaGFyIHggPSAwOwpAQCAtMjkzLDcg
KzMwMSw3IEBAIHN0YXRpYyB2b2lkIHhwX2luaXRfYWNjZWwoaW50IHBpdGNoLCBpbnQKIAkJYnJl
YWs7CiAJfQogCi0JdF9vdXRiKHgsIDB4MjEyNSk7CisJdF9vdXRiKHBhciwgeCwgMHgyMTI1KTsK
IAogCWVuZ19vcGVyID0geCB8IDB4NDA7CiAKQEAgLTMxMywxMiArMzIxLDEyIEBAIHN0YXRpYyB2
b2lkIHhwX2luaXRfYWNjZWwoaW50IHBpdGNoLCBpbnQKIAogCXYxID0gcGl0Y2ggPDwgdG1wOwog
Ci0Jd3JpdGVtbXIoMHgyMTU0LCB2MSk7Ci0Jd3JpdGVtbXIoMHgyMTUwLCB2MSk7Ci0JdF9vdXRi
KDMsIDB4MjEyNik7CisJd3JpdGVtbXIocGFyLCAweDIxNTQsIHYxKTsKKwl3cml0ZW1tcihwYXIs
IDB4MjE1MCwgdjEpOworCXRfb3V0YihwYXIsIDMsIDB4MjEyNik7CiB9CiAKLXN0YXRpYyB2b2lk
IHhwX3dhaXRfZW5naW5lKHZvaWQpCitzdGF0aWMgdm9pZCB4cF93YWl0X2VuZ2luZShzdHJ1Y3Qg
dHJpZGVudGZiX3BhciAqcGFyKQogewogCWludCBidXN5OwogCWludCBjb3VudCwgdGltZW91dDsK
QEAgLTMyNiw3ICszMzQsNyBAQCBzdGF0aWMgdm9pZCB4cF93YWl0X2VuZ2luZSh2b2lkKQogCWNv
dW50ID0gMDsKIAl0aW1lb3V0ID0gMDsKIAlmb3IgKDs7KSB7Ci0JCWJ1c3kgPSB0X2luYihTVEEp
ICYgMHg4MDsKKwkJYnVzeSA9IHRfaW5iKHBhciwgU1RBKSAmIDB4ODA7CiAJCWlmIChidXN5ICE9
IDB4ODApCiAJCQlyZXR1cm47CiAJCWNvdW50Kys7CkBAIC0zMzYsMjUgKzM0NCwyNyBAQCBzdGF0
aWMgdm9pZCB4cF93YWl0X2VuZ2luZSh2b2lkKQogCQkJdGltZW91dCsrOwogCQkJaWYgKHRpbWVv
dXQgPT0gOCkgewogCQkJCS8qIFJlc2V0IGVuZ2luZSAqLwotCQkJCXRfb3V0YigweDAwLCAweDIx
MjApOworCQkJCXRfb3V0YihwYXIsIDB4MDAsIDB4MjEyMCk7CiAJCQkJcmV0dXJuOwogCQkJfQog
CQl9CiAJfQogfQogCi1zdGF0aWMgdm9pZCB4cF9maWxsX3JlY3QodTMyIHgsIHUzMiB5LCB1MzIg
dywgdTMyIGgsIHUzMiBjLCB1MzIgcm9wKQorc3RhdGljIHZvaWQgeHBfZmlsbF9yZWN0KHN0cnVj
dCB0cmlkZW50ZmJfcGFyICpwYXIsCisJCQkgdTMyIHgsIHUzMiB5LCB1MzIgdywgdTMyIGgsIHUz
MiBjLCB1MzIgcm9wKQogewotCXdyaXRlbW1yKDB4MjEyNywgUk9QX1ApOwotCXdyaXRlbW1yKDB4
MjE1OCwgYyk7Ci0Jd3JpdGVtbXIoMHgyMTI4LCAweDQwMDApOwotCXdyaXRlbW1yKDB4MjE0MCwg
bWFza2VkX3BvaW50KGgsIHcpKTsKLQl3cml0ZW1tcigweDIxMzgsIG1hc2tlZF9wb2ludCh5LCB4
KSk7Ci0JdF9vdXRiKDB4MDEsIDB4MjEyNCk7Ci0JdF9vdXRiKGVuZ19vcGVyLCAweDIxMjUpOwor
CXdyaXRlbW1yKHBhciwgMHgyMTI3LCBST1BfUCk7CisJd3JpdGVtbXIocGFyLCAweDIxNTgsIGMp
OworCXdyaXRlbW1yKHBhciwgMHgyMTI4LCAweDQwMDApOworCXdyaXRlbW1yKHBhciwgMHgyMTQw
LCBtYXNrZWRfcG9pbnQoaCwgdykpOworCXdyaXRlbW1yKHBhciwgMHgyMTM4LCBtYXNrZWRfcG9p
bnQoeSwgeCkpOworCXRfb3V0YihwYXIsIDB4MDEsIDB4MjEyNCk7CisJdF9vdXRiKHBhciwgZW5n
X29wZXIsIDB4MjEyNSk7CiB9CiAKLXN0YXRpYyB2b2lkIHhwX2NvcHlfcmVjdCh1MzIgeDEsIHUz
MiB5MSwgdTMyIHgyLCB1MzIgeTIsIHUzMiB3LCB1MzIgaCkKK3N0YXRpYyB2b2lkIHhwX2NvcHlf
cmVjdChzdHJ1Y3QgdHJpZGVudGZiX3BhciAqcGFyLAorCQkJIHUzMiB4MSwgdTMyIHkxLCB1MzIg
eDIsIHUzMiB5MiwgdTMyIHcsIHUzMiBoKQogewogCWludCBkaXJlY3Rpb247CiAJdTMyIHgxX3Rt
cCwgeDJfdG1wLCB5MV90bXAsIHkyX3RtcDsKQEAgLTM3OSwxMiArMzg5LDEyIEBAIHN0YXRpYyB2
b2lkIHhwX2NvcHlfcmVjdCh1MzIgeDEsIHUzMiB5MSwKIAkJeTJfdG1wID0geTI7CiAJfQogCi0J
d3JpdGVtbXIoMHgyMTI4LCBkaXJlY3Rpb24pOwotCXRfb3V0YihST1BfUywgMHgyMTI3KTsKLQl3
cml0ZW1tcigweDIxM0MsIG1hc2tlZF9wb2ludCh5MV90bXAsIHgxX3RtcCkpOwotCXdyaXRlbW1y
KDB4MjEzOCwgbWFza2VkX3BvaW50KHkyX3RtcCwgeDJfdG1wKSk7Ci0Jd3JpdGVtbXIoMHgyMTQw
LCBtYXNrZWRfcG9pbnQoaCwgdykpOwotCXRfb3V0YigweDAxLCAweDIxMjQpOworCXdyaXRlbW1y
KHBhciwgMHgyMTI4LCBkaXJlY3Rpb24pOworCXRfb3V0YihwYXIsIFJPUF9TLCAweDIxMjcpOwor
CXdyaXRlbW1yKHBhciwgMHgyMTNDLCBtYXNrZWRfcG9pbnQoeTFfdG1wLCB4MV90bXApKTsKKwl3
cml0ZW1tcihwYXIsIDB4MjEzOCwgbWFza2VkX3BvaW50KHkyX3RtcCwgeDJfdG1wKSk7CisJd3Jp
dGVtbXIocGFyLCAweDIxNDAsIG1hc2tlZF9wb2ludChoLCB3KSk7CisJdF9vdXRiKHBhciwgMHgw
MSwgMHgyMTI0KTsKIH0KIAogc3RhdGljIHN0cnVjdCBhY2NlbF9zd2l0Y2ggYWNjZWxfeHAgPSB7
CkBAIC0zOTcsNyArNDA3LDcgQEAgc3RhdGljIHN0cnVjdCBhY2NlbF9zd2l0Y2ggYWNjZWxfeHAg
PSB7CiAvKgogICogSW1hZ2Ugc3BlY2lmaWMgYWNjZWxlcmF0aW9uIGZ1bmN0aW9ucwogICovCi1z
dGF0aWMgdm9pZCBpbWFnZV9pbml0X2FjY2VsKGludCBwaXRjaCwgaW50IGJwcCkKK3N0YXRpYyB2
b2lkIGltYWdlX2luaXRfYWNjZWwoc3RydWN0IHRyaWRlbnRmYl9wYXIgKnBhciwgaW50IHBpdGNo
LCBpbnQgYnBwKQogewogCWludCB0bXAgPSAwOwogCXN3aXRjaCAoYnBwKSB7CkBAIC00MTUsNDAg
KzQyNSw0MiBAQCBzdGF0aWMgdm9pZCBpbWFnZV9pbml0X2FjY2VsKGludCBwaXRjaCwgCiAJCXRt
cCA9IDI7CiAJCWJyZWFrOwogCX0KLQl3cml0ZW1tcigweDIxMjAsIDB4RjAwMDAwMDApOwotCXdy
aXRlbW1yKDB4MjEyMCwgMHg0MDAwMDAwMCB8IHRtcCk7Ci0Jd3JpdGVtbXIoMHgyMTIwLCAweDgw
MDAwMDAwKTsKLQl3cml0ZW1tcigweDIxNDQsIDB4MDAwMDAwMDApOwotCXdyaXRlbW1yKDB4MjE0
OCwgMHgwMDAwMDAwMCk7Ci0Jd3JpdGVtbXIoMHgyMTUwLCAweDAwMDAwMDAwKTsKLQl3cml0ZW1t
cigweDIxNTQsIDB4MDAwMDAwMDApOwotCXdyaXRlbW1yKDB4MjEyMCwgMHg2MDAwMDAwMCB8IChw
aXRjaCA8PCAxNikgfCBwaXRjaCk7Ci0Jd3JpdGVtbXIoMHgyMTZDLCAweDAwMDAwMDAwKTsKLQl3
cml0ZW1tcigweDIxNzAsIDB4MDAwMDAwMDApOwotCXdyaXRlbW1yKDB4MjE3QywgMHgwMDAwMDAw
MCk7Ci0Jd3JpdGVtbXIoMHgyMTIwLCAweDEwMDAwMDAwKTsKLQl3cml0ZW1tcigweDIxMzAsICgy
MDQ3IDw8IDE2KSB8IDIwNDcpOworCXdyaXRlbW1yKHBhciwgMHgyMTIwLCAweEYwMDAwMDAwKTsK
Kwl3cml0ZW1tcihwYXIsIDB4MjEyMCwgMHg0MDAwMDAwMCB8IHRtcCk7CisJd3JpdGVtbXIocGFy
LCAweDIxMjAsIDB4ODAwMDAwMDApOworCXdyaXRlbW1yKHBhciwgMHgyMTQ0LCAweDAwMDAwMDAw
KTsKKwl3cml0ZW1tcihwYXIsIDB4MjE0OCwgMHgwMDAwMDAwMCk7CisJd3JpdGVtbXIocGFyLCAw
eDIxNTAsIDB4MDAwMDAwMDApOworCXdyaXRlbW1yKHBhciwgMHgyMTU0LCAweDAwMDAwMDAwKTsK
Kwl3cml0ZW1tcihwYXIsIDB4MjEyMCwgMHg2MDAwMDAwMCB8IChwaXRjaCA8PCAxNikgfCBwaXRj
aCk7CisJd3JpdGVtbXIocGFyLCAweDIxNkMsIDB4MDAwMDAwMDApOworCXdyaXRlbW1yKHBhciwg
MHgyMTcwLCAweDAwMDAwMDAwKTsKKwl3cml0ZW1tcihwYXIsIDB4MjE3QywgMHgwMDAwMDAwMCk7
CisJd3JpdGVtbXIocGFyLCAweDIxMjAsIDB4MTAwMDAwMDApOworCXdyaXRlbW1yKHBhciwgMHgy
MTMwLCAoMjA0NyA8PCAxNikgfCAyMDQ3KTsKIH0KIAotc3RhdGljIHZvaWQgaW1hZ2Vfd2FpdF9l
bmdpbmUodm9pZCkKK3N0YXRpYyB2b2lkIGltYWdlX3dhaXRfZW5naW5lKHN0cnVjdCB0cmlkZW50
ZmJfcGFyICpwYXIpCiB7Ci0Jd2hpbGUgKHJlYWRtbXIoMHgyMTY0KSAmIDB4RjAwMDAwMDApIDsK
Kwl3aGlsZSAocmVhZG1tcihwYXIsIDB4MjE2NCkgJiAweEYwMDAwMDAwKSA7CiB9CiAKLXN0YXRp
YyB2b2lkIGltYWdlX2ZpbGxfcmVjdCh1MzIgeCwgdTMyIHksIHUzMiB3LCB1MzIgaCwgdTMyIGMs
IHUzMiByb3ApCitzdGF0aWMgdm9pZCBpbWFnZV9maWxsX3JlY3Qoc3RydWN0IHRyaWRlbnRmYl9w
YXIgKnBhciwKKwkJCSAgICB1MzIgeCwgdTMyIHksIHUzMiB3LCB1MzIgaCwgdTMyIGMsIHUzMiBy
b3ApCiB7Ci0Jd3JpdGVtbXIoMHgyMTIwLCAweDgwMDAwMDAwKTsKLQl3cml0ZW1tcigweDIxMjAs
IDB4OTAwMDAwMDAgfCBST1BfUyk7CisJd3JpdGVtbXIocGFyLCAweDIxMjAsIDB4ODAwMDAwMDAp
OworCXdyaXRlbW1yKHBhciwgMHgyMTIwLCAweDkwMDAwMDAwIHwgUk9QX1MpOwogCi0Jd3JpdGVt
bXIoMHgyMTQ0LCBjKTsKKwl3cml0ZW1tcihwYXIsIDB4MjE0NCwgYyk7CiAKLQl3cml0ZW1tcihE
UjEsIHBvaW50KHgsIHkpKTsKLQl3cml0ZW1tcihEUjIsIHBvaW50KHggKyB3IC0gMSwgeSArIGgg
LSAxKSk7CisJd3JpdGVtbXIocGFyLCBEUjEsIHBvaW50KHgsIHkpKTsKKwl3cml0ZW1tcihwYXIs
IERSMiwgcG9pbnQoeCArIHcgLSAxLCB5ICsgaCAtIDEpKTsKIAotCXdyaXRlbW1yKDB4MjEyNCwg
MHg4MDAwMDAwMCB8IDMgPDwgMjIgfCAxIDw8IDEwIHwgMSA8PCA5KTsKKwl3cml0ZW1tcihwYXIs
IDB4MjEyNCwgMHg4MDAwMDAwMCB8IDMgPDwgMjIgfCAxIDw8IDEwIHwgMSA8PCA5KTsKIH0KIAot
c3RhdGljIHZvaWQgaW1hZ2VfY29weV9yZWN0KHUzMiB4MSwgdTMyIHkxLCB1MzIgeDIsIHUzMiB5
MiwgdTMyIHcsIHUzMiBoKQorc3RhdGljIHZvaWQgaW1hZ2VfY29weV9yZWN0KHN0cnVjdCB0cmlk
ZW50ZmJfcGFyICpwYXIsCisJCQkgICAgdTMyIHgxLCB1MzIgeTEsIHUzMiB4MiwgdTMyIHkyLCB1
MzIgdywgdTMyIGgpCiB7CiAJdTMyIHMxLCBzMiwgZDEsIGQyOwogCWludCBkaXJlY3Rpb24gPSAy
OwpAQCAtNDYwLDE0ICs0NzIsMTUgQEAgc3RhdGljIHZvaWQgaW1hZ2VfY29weV9yZWN0KHUzMiB4
MSwgdTMyIAogCWlmICgoeTEgPiB5MikgfHwgKCh5MSA9PSB5MikgJiYgKHgxID4geDIpKSkKIAkJ
ZGlyZWN0aW9uID0gMDsKIAotCXdyaXRlbW1yKDB4MjEyMCwgMHg4MDAwMDAwMCk7Ci0Jd3JpdGVt
bXIoMHgyMTIwLCAweDkwMDAwMDAwIHwgUk9QX1MpOworCXdyaXRlbW1yKHBhciwgMHgyMTIwLCAw
eDgwMDAwMDAwKTsKKwl3cml0ZW1tcihwYXIsIDB4MjEyMCwgMHg5MDAwMDAwMCB8IFJPUF9TKTsK
IAotCXdyaXRlbW1yKFNSMSwgZGlyZWN0aW9uID8gczIgOiBzMSk7Ci0Jd3JpdGVtbXIoU1IyLCBk
aXJlY3Rpb24gPyBzMSA6IHMyKTsKLQl3cml0ZW1tcihEUjEsIGRpcmVjdGlvbiA/IGQyIDogZDEp
OwotCXdyaXRlbW1yKERSMiwgZGlyZWN0aW9uID8gZDEgOiBkMik7Ci0Jd3JpdGVtbXIoMHgyMTI0
LCAweDgwMDAwMDAwIHwgMSA8PCAyMiB8IDEgPDwgMTAgfCAxIDw8IDcgfCBkaXJlY3Rpb24pOwor
CXdyaXRlbW1yKHBhciwgU1IxLCBkaXJlY3Rpb24gPyBzMiA6IHMxKTsKKwl3cml0ZW1tcihwYXIs
IFNSMiwgZGlyZWN0aW9uID8gczEgOiBzMik7CisJd3JpdGVtbXIocGFyLCBEUjEsIGRpcmVjdGlv
biA/IGQyIDogZDEpOworCXdyaXRlbW1yKHBhciwgRFIyLCBkaXJlY3Rpb24gPyBkMSA6IGQyKTsK
Kwl3cml0ZW1tcihwYXIsIDB4MjEyNCwKKwkJIDB4ODAwMDAwMDAgfCAxIDw8IDIyIHwgMSA8PCAx
MCB8IDEgPDwgNyB8IGRpcmVjdGlvbik7CiB9CiAKIHN0YXRpYyBzdHJ1Y3QgYWNjZWxfc3dpdGNo
IGFjY2VsX2ltYWdlID0gewpAQCAtNTIxLDQ5ICs1MzQsNTEgQEAgc3RhdGljIHZvaWQgdHJpZGVu
dGZiX2NvcHlhcmVhKHN0cnVjdCBmYgogICogSGFyZHdhcmUgYWNjZXNzIGZ1bmN0aW9ucwogICov
CiAKLXN0YXRpYyBpbmxpbmUgdW5zaWduZWQgY2hhciByZWFkM1g0KGludCByZWcpCitzdGF0aWMg
aW5saW5lIHVuc2lnbmVkIGNoYXIgcmVhZDNYNChzdHJ1Y3QgdHJpZGVudGZiX3BhciAqcGFyLCBp
bnQgcmVnKQogewotCXN0cnVjdCB0cmlkZW50ZmJfcGFyICpwYXIgPSAoc3RydWN0IHRyaWRlbnRm
Yl9wYXIgKilmYl9pbmZvLnBhcjsKIAl3cml0ZWIocmVnLCBwYXItPmlvX3ZpcnQgKyBDUlQgKyA0
KTsKIAlyZXR1cm4gcmVhZGIocGFyLT5pb192aXJ0ICsgQ1JUICsgNSk7CiB9CiAKLXN0YXRpYyBp
bmxpbmUgdm9pZCB3cml0ZTNYNChpbnQgcmVnLCB1bnNpZ25lZCBjaGFyIHZhbCkKK3N0YXRpYyBp
bmxpbmUgdm9pZCB3cml0ZTNYNChzdHJ1Y3QgdHJpZGVudGZiX3BhciAqcGFyLCBpbnQgcmVnLAor
CQkJICAgIHVuc2lnbmVkIGNoYXIgdmFsKQogewotCXN0cnVjdCB0cmlkZW50ZmJfcGFyICpwYXIg
PSAoc3RydWN0IHRyaWRlbnRmYl9wYXIgKilmYl9pbmZvLnBhcjsKIAl3cml0ZWIocmVnLCBwYXIt
PmlvX3ZpcnQgKyBDUlQgKyA0KTsKIAl3cml0ZWIodmFsLCBwYXItPmlvX3ZpcnQgKyBDUlQgKyA1
KTsKIH0KIAotc3RhdGljIGlubGluZSB1bnNpZ25lZCBjaGFyIHJlYWQzQzQoaW50IHJlZykKK3N0
YXRpYyBpbmxpbmUgdW5zaWduZWQgY2hhciByZWFkM0M0KHN0cnVjdCB0cmlkZW50ZmJfcGFyICpw
YXIsIGludCByZWcpCiB7Ci0JdF9vdXRiKHJlZywgMHgzQzQpOwotCXJldHVybiB0X2luYigweDND
NSk7CisJdF9vdXRiKHBhciwgcmVnLCAweDNDNCk7CisJcmV0dXJuIHRfaW5iKHBhciwgMHgzQzUp
OwogfQogCi1zdGF0aWMgaW5saW5lIHZvaWQgd3JpdGUzQzQoaW50IHJlZywgdW5zaWduZWQgY2hh
ciB2YWwpCitzdGF0aWMgaW5saW5lIHZvaWQgd3JpdGUzQzQoc3RydWN0IHRyaWRlbnRmYl9wYXIg
KnBhciwgaW50IHJlZywKKwkJCSAgICB1bnNpZ25lZCBjaGFyIHZhbCkKIHsKLQl0X291dGIocmVn
LCAweDNDNCk7Ci0JdF9vdXRiKHZhbCwgMHgzQzUpOworCXRfb3V0YihwYXIsIHJlZywgMHgzQzQp
OworCXRfb3V0YihwYXIsIHZhbCwgMHgzQzUpOwogfQogCi1zdGF0aWMgaW5saW5lIHVuc2lnbmVk
IGNoYXIgcmVhZDNDRShpbnQgcmVnKQorc3RhdGljIGlubGluZSB1bnNpZ25lZCBjaGFyIHJlYWQz
Q0Uoc3RydWN0IHRyaWRlbnRmYl9wYXIgKnBhciwgaW50IHJlZykKIHsKLQl0X291dGIocmVnLCAw
eDNDRSk7Ci0JcmV0dXJuIHRfaW5iKDB4M0NGKTsKKwl0X291dGIocGFyLCByZWcsIDB4M0NFKTsK
KwlyZXR1cm4gdF9pbmIocGFyLCAweDNDRik7CiB9CiAKLXN0YXRpYyBpbmxpbmUgdm9pZCB3cml0
ZUF0dHIoaW50IHJlZywgdW5zaWduZWQgY2hhciB2YWwpCitzdGF0aWMgaW5saW5lIHZvaWQgd3Jp
dGVBdHRyKHN0cnVjdCB0cmlkZW50ZmJfcGFyICpwYXIsIGludCByZWcsCisJCQkgICAgIHVuc2ln
bmVkIGNoYXIgdmFsKQogewotCXJlYWRiKCgoc3RydWN0IHRyaWRlbnRmYl9wYXIgKilmYl9pbmZv
LnBhciktPmlvX3ZpcnQgKyBDUlQgKyAweDBBKTsJLyogZmxpcC1mbG9wIHRvIGluZGV4ICovCi0J
dF9vdXRiKHJlZywgMHgzQzApOwotCXRfb3V0Yih2YWwsIDB4M0MwKTsKKwlmYl9yZWFkYihwYXIt
PmlvX3ZpcnQgKyBDUlQgKyAweDBBKTsJLyogZmxpcC1mbG9wIHRvIGluZGV4ICovCisJdF9vdXRi
KHBhciwgcmVnLCAweDNDMCk7CisJdF9vdXRiKHBhciwgdmFsLCAweDNDMCk7CiB9CiAKLXN0YXRp
YyBpbmxpbmUgdm9pZCB3cml0ZTNDRShpbnQgcmVnLCB1bnNpZ25lZCBjaGFyIHZhbCkKK3N0YXRp
YyBpbmxpbmUgdm9pZCB3cml0ZTNDRShzdHJ1Y3QgdHJpZGVudGZiX3BhciAqcGFyLCBpbnQgcmVn
LAorCQkJICAgIHVuc2lnbmVkIGNoYXIgdmFsKQogewotCXRfb3V0YihyZWcsIDB4M0NFKTsKLQl0
X291dGIodmFsLCAweDNDRik7CisJdF9vdXRiKHBhciwgcmVnLCAweDNDRSk7CisJdF9vdXRiKHBh
ciwgdmFsLCAweDNDRik7CiB9CiAKIHN0YXRpYyB2b2lkIGVuYWJsZV9tbWlvKHZvaWQpCkBAIC01
ODEsMzIgKzU5NiwzNSBAQCBzdGF0aWMgdm9pZCBlbmFibGVfbW1pbyh2b2lkKQogCW91dGIoaW5i
KDB4M0Q1KSB8IDB4MDEsIDB4M0Q1KTsKIH0KIAotc3RhdGljIHZvaWQgZGlzYWJsZV9tbWlvKHZv
aWQpCitzdGF0aWMgdm9pZCBkaXNhYmxlX21taW8oc3RydWN0IHRyaWRlbnRmYl9wYXIgKnBhcikK
IHsKIAkvKiBHb3RvIE5ldyBNb2RlICovCi0JdF9vdXRiKDB4MEIsIDB4M0M0KTsKLQl0X2luYigw
eDNDNSk7CisJdF9vdXRiKHBhciwgMHgwQiwgMHgzQzQpOworCXRfaW5iKHBhciwgMHgzQzUpOwog
CiAJLyogVW5wcm90ZWN0IHJlZ2lzdGVycyAqLwotCXRfb3V0YihOZXdNb2RlMSwgMHgzQzQpOwot
CXRfb3V0YigweDgwLCAweDNDNSk7CisJdF9vdXRiKHBhciwgTmV3TW9kZTEsIDB4M0M0KTsKKwl0
X291dGIocGFyLCAweDgwLCAweDNDNSk7CiAKIAkvKiBEaXNhYmxlIE1NSU8gKi8KLQl0X291dGIo
UENJUmVnLCAweDNENCk7Ci0JdF9vdXRiKHRfaW5iKDB4M0Q1KSAmIH4weDAxLCAweDNENSk7CisJ
dF9vdXRiKHBhciwgUENJUmVnLCAweDNENCk7CisJdF9vdXRiKHBhciwgdF9pbmIocGFyLCAweDNE
NSkgJiB+MHgwMSwgMHgzRDUpOwogfQogCi0jZGVmaW5lIGNydGNfdW5sb2NrKCkJd3JpdGUzWDQo
Q1JUVlN5bmNFbmQsIHJlYWQzWDQoQ1JUVlN5bmNFbmQpICYgMHg3RikKK3N0YXRpYyB2b2lkIGNy
dGNfdW5sb2NrKHN0cnVjdCB0cmlkZW50ZmJfcGFyICpwYXIpCit7CisJd3JpdGUzWDQocGFyLCBD
UlRWU3luY0VuZCwgcmVhZDNYNChwYXIsIENSVFZTeW5jRW5kKSAmIDB4N0YpOworfQogCiAvKiAg
UmV0dXJuIGZsYXQgcGFuZWwncyBtYXhpbXVtIHggcmVzb2x1dGlvbiAqLwotc3RhdGljIGludCBf
X2RldmluaXQgZ2V0X25hdGl2ZXgodm9pZCkKK3N0YXRpYyBpbnQgX19kZXZpbml0IGdldF9uYXRp
dmV4KHN0cnVjdCB0cmlkZW50ZmJfcGFyICpwYXIpCiB7CiAJaW50IHgsIHksIHRtcDsKIAogCWlm
IChuYXRpdmV4KQogCQlyZXR1cm4gbmF0aXZleDsKIAotCXRtcCA9IChyZWFkM0NFKFZlcnRTdHJl
dGNoKSA+PiA0KSAmIDM7CisJdG1wID0gKHJlYWQzQ0UocGFyLCBWZXJ0U3RyZXRjaCkgPj4gNCkg
JiAzOwogCiAJc3dpdGNoICh0bXApIHsKIAljYXNlIDA6CkBAIC02MzIsNDQgKzY1MCw0NSBAQCBz
dGF0aWMgaW50IF9fZGV2aW5pdCBnZXRfbmF0aXZleCh2b2lkKQogfQogCiAvKiBTZXQgcGl0Y2gg
Ki8KLXN0YXRpYyB2b2lkIHNldF9sd2lkdGgoaW50IHdpZHRoKQorc3RhdGljIHZvaWQgc2V0X2x3
aWR0aChzdHJ1Y3QgdHJpZGVudGZiX3BhciAqcGFyLCBpbnQgd2lkdGgpCiB7Ci0Jd3JpdGUzWDQo
T2Zmc2V0LCB3aWR0aCAmIDB4RkYpOwotCXdyaXRlM1g0KEFkZENvbFJlZywKLQkJIChyZWFkM1g0
KEFkZENvbFJlZykgJiAweENGKSB8ICgod2lkdGggJiAweDMwMCkgPj4gNCkpOworCXdyaXRlM1g0
KHBhciwgT2Zmc2V0LCB3aWR0aCAmIDB4RkYpOworCXdyaXRlM1g0KHBhciwgQWRkQ29sUmVnLAor
CQkgKHJlYWQzWDQocGFyLCBBZGRDb2xSZWcpICYgMHhDRikgfCAoKHdpZHRoICYgMHgzMDApID4+
IDQpKTsKIH0KIAogLyogRm9yIHJlc29sdXRpb25zIHNtYWxsZXIgdGhhbiBGUCByZXNvbHV0aW9u
IHN0cmV0Y2ggKi8KLXN0YXRpYyB2b2lkIHNjcmVlbl9zdHJldGNoKHZvaWQpCitzdGF0aWMgdm9p
ZCBzY3JlZW5fc3RyZXRjaChzdHJ1Y3QgdHJpZGVudGZiX3BhciAqcGFyKQogewogCWlmIChjaGlw
X2lkICE9IENZQkVSQkxBREVYUEFpMSkKLQkJd3JpdGUzQ0UoQmlvc1JlZywgMCk7CisJCXdyaXRl
M0NFKHBhciwgQmlvc1JlZywgMCk7CiAJZWxzZQotCQl3cml0ZTNDRShCaW9zUmVnLCA4KTsKLQl3
cml0ZTNDRShWZXJ0U3RyZXRjaCwgKHJlYWQzQ0UoVmVydFN0cmV0Y2gpICYgMHg3QykgfCAxKTsK
LQl3cml0ZTNDRShIb3JTdHJldGNoLCAocmVhZDNDRShIb3JTdHJldGNoKSAmIDB4N0MpIHwgMSk7
CisJCXdyaXRlM0NFKHBhciwgQmlvc1JlZywgOCk7CisJd3JpdGUzQ0UocGFyLCBWZXJ0U3RyZXRj
aCwgKHJlYWQzQ0UocGFyLCBWZXJ0U3RyZXRjaCkgJiAweDdDKSB8IDEpOworCXdyaXRlM0NFKHBh
ciwgSG9yU3RyZXRjaCwgKHJlYWQzQ0UocGFyLCBIb3JTdHJldGNoKSAmIDB4N0MpIHwgMSk7CiB9
CiAKIC8qIEZvciByZXNvbHV0aW9ucyBzbWFsbGVyIHRoYW4gRlAgcmVzb2x1dGlvbiBjZW50ZXIg
Ki8KLXN0YXRpYyB2b2lkIHNjcmVlbl9jZW50ZXIodm9pZCkKK3N0YXRpYyB2b2lkIHNjcmVlbl9j
ZW50ZXIoc3RydWN0IHRyaWRlbnRmYl9wYXIgKnBhcikKIHsKLQl3cml0ZTNDRShWZXJ0U3RyZXRj
aCwgKHJlYWQzQ0UoVmVydFN0cmV0Y2gpICYgMHg3QykgfCAweDgwKTsKLQl3cml0ZTNDRShIb3JT
dHJldGNoLCAocmVhZDNDRShIb3JTdHJldGNoKSAmIDB4N0MpIHwgMHg4MCk7CisJd3JpdGUzQ0Uo
cGFyLCBWZXJ0U3RyZXRjaCwgKHJlYWQzQ0UocGFyLCBWZXJ0U3RyZXRjaCkgJiAweDdDKSB8IDB4
ODApOworCXdyaXRlM0NFKHBhciwgSG9yU3RyZXRjaCwgKHJlYWQzQ0UocGFyLCBIb3JTdHJldGNo
KSAmIDB4N0MpIHwgMHg4MCk7CiB9CiAKIC8qIEFkZHJlc3Mgb2YgZmlyc3Qgc2hvd24gcGl4ZWwg
aW4gZGlzcGxheSBtZW1vcnkgKi8KLXN0YXRpYyB2b2lkIHNldF9zY3JlZW5fc3RhcnQoaW50IGJh
c2UpCitzdGF0aWMgdm9pZCBzZXRfc2NyZWVuX3N0YXJ0KHN0cnVjdCB0cmlkZW50ZmJfcGFyICpw
YXIsIGludCBiYXNlKQogewotCXdyaXRlM1g0KFN0YXJ0QWRkckxvdywgYmFzZSAmIDB4RkYpOwot
CXdyaXRlM1g0KFN0YXJ0QWRkckhpZ2gsIChiYXNlICYgMHhGRjAwKSA+PiA4KTsKLQl3cml0ZTNY
NChDUlRDTW9kdWxlVGVzdCwKLQkJIChyZWFkM1g0KENSVENNb2R1bGVUZXN0KSAmIDB4REYpIHwg
KChiYXNlICYgMHgxMDAwMCkgPj4gMTEpKTsKLQl3cml0ZTNYNChDUlRIaU9yZCwKLQkJIChyZWFk
M1g0KENSVEhpT3JkKSAmIDB4RjgpIHwgKChiYXNlICYgMHhFMDAwMCkgPj4gMTcpKTsKKwl1OCB0
bXA7CisJd3JpdGUzWDQocGFyLCBTdGFydEFkZHJMb3csIGJhc2UgJiAweEZGKTsKKwl3cml0ZTNY
NChwYXIsIFN0YXJ0QWRkckhpZ2gsIChiYXNlICYgMHhGRjAwKSA+PiA4KTsKKwl0bXAgPSByZWFk
M1g0KHBhciwgQ1JUQ01vZHVsZVRlc3QpICYgMHhERjsKKwl3cml0ZTNYNChwYXIsIENSVENNb2R1
bGVUZXN0LCB0bXAgfCAoKGJhc2UgJiAweDEwMDAwKSA+PiAxMSkpOworCXRtcCA9IHJlYWQzWDQo
cGFyLCBDUlRIaU9yZCkgJiAweEY4OworCXdyaXRlM1g0KHBhciwgQ1JUSGlPcmQsIHRtcCB8ICgo
YmFzZSAmIDB4RTAwMDApID4+IDE3KSk7CiB9CiAKIC8qIFNldCBkb3RjbG9jayBmcmVxdWVuY3kg
Ki8KLXN0YXRpYyB2b2lkIHNldF92Y2xrKHVuc2lnbmVkIGxvbmcgZnJlcSkKK3N0YXRpYyB2b2lk
IHNldF92Y2xrKHN0cnVjdCB0cmlkZW50ZmJfcGFyICpwYXIsIHVuc2lnbmVkIGxvbmcgZnJlcSkK
IHsKIAlpbnQgbSwgbiwgazsKIAl1bnNpZ25lZCBsb25nIGYsIGZpLCBkLCBkaTsKQEAgLTY5MCw4
ICs3MDksOCBAQCBzdGF0aWMgdm9pZCBzZXRfdmNsayh1bnNpZ25lZCBsb25nIGZyZXEpCiAJCQkJ
CWJyZWFrOwogCQkJfQogCWlmIChjaGlwM0QpIHsKLQkJd3JpdGUzQzQoQ2xvY2tIaWdoLCBoaSk7
Ci0JCXdyaXRlM0M0KENsb2NrTG93LCBsbyk7CisJCXdyaXRlM0M0KHBhciwgQ2xvY2tIaWdoLCBo
aSk7CisJCXdyaXRlM0M0KHBhciwgQ2xvY2tMb3csIGxvKTsKIAl9IGVsc2UgewogCQlvdXRiKGxv
LCAweDQzQzgpOwogCQlvdXRiKGhpLCAweDQzQzkpOwpAQCAtNzAwLDkgKzcxOSw5IEBAIHN0YXRp
YyB2b2lkIHNldF92Y2xrKHVuc2lnbmVkIGxvbmcgZnJlcSkKIH0KIAogLyogU2V0IG51bWJlciBv
ZiBsaW5lcyBmb3IgZmxhdCBwYW5lbHMqLwotc3RhdGljIHZvaWQgc2V0X251bWJlcl9vZl9saW5l
cyhpbnQgbGluZXMpCitzdGF0aWMgdm9pZCBzZXRfbnVtYmVyX29mX2xpbmVzKHN0cnVjdCB0cmlk
ZW50ZmJfcGFyICpwYXIsIGludCBsaW5lcykKIHsKLQlpbnQgdG1wID0gcmVhZDNDRShDeWJlckVu
aGFuY2UpICYgMHg4RjsKKwlpbnQgdG1wID0gcmVhZDNDRShwYXIsIEN5YmVyRW5oYW5jZSkgJiAw
eDhGOwogCWlmIChsaW5lcyA+IDEwMjQpCiAJCXRtcCB8PSAweDUwOwogCWVsc2UgaWYgKGxpbmVz
ID4gNzY4KQpAQCAtNzExLDI0ICs3MzAsMjQgQEAgc3RhdGljIHZvaWQgc2V0X251bWJlcl9vZl9s
aW5lcyhpbnQgbGluZQogCQl0bXAgfD0gMHgyMDsKIAllbHNlIGlmIChsaW5lcyA+IDQ4MCkKIAkJ
dG1wIHw9IDB4MTA7Ci0Jd3JpdGUzQ0UoQ3liZXJFbmhhbmNlLCB0bXApOworCXdyaXRlM0NFKHBh
ciwgQ3liZXJFbmhhbmNlLCB0bXApOwogfQogCiAvKgogICogSWYgd2Ugc2VlIHRoYXQgRlAgaXMg
YWN0aXZlIHdlIGFzc3VtZSB3ZSBoYXZlIG9uZS4KICAqIE90aGVyd2lzZSB3ZSBoYXZlIGEgQ1JU
IGRpc3BsYXkuVXNlciBjYW4gb3ZlcnJpZGUuCiAgKi8KLXN0YXRpYyB1bnNpZ25lZCBpbnQgX19k
ZXZpbml0IGdldF9kaXNwbGF5dHlwZSh2b2lkKQorc3RhdGljIHVuc2lnbmVkIGludCBfX2Rldmlu
aXQgZ2V0X2Rpc3BsYXl0eXBlKHN0cnVjdCB0cmlkZW50ZmJfcGFyICpwYXIpCiB7CiAJaWYgKGZw
KQogCQlyZXR1cm4gRElTUExBWV9GUDsKIAlpZiAoY3J0IHx8ICFjaGlwY3liZXIpCiAJCXJldHVy
biBESVNQTEFZX0NSVDsKLQlyZXR1cm4gKHJlYWQzQ0UoRlBDb25maWcpICYgMHgxMCkgPyBESVNQ
TEFZX0ZQIDogRElTUExBWV9DUlQ7CisJcmV0dXJuIChyZWFkM0NFKHBhciwgRlBDb25maWcpICYg
MHgxMCkgPyBESVNQTEFZX0ZQIDogRElTUExBWV9DUlQ7CiB9CiAKIC8qIFRyeSBkZXRlY3Rpbmcg
dGhlIHZpZGVvIG1lbW9yeSBzaXplICovCi1zdGF0aWMgdW5zaWduZWQgaW50IF9fZGV2aW5pdCBn
ZXRfbWVtc2l6ZSh2b2lkKQorc3RhdGljIHVuc2lnbmVkIGludCBfX2RldmluaXQgZ2V0X21lbXNp
emUoc3RydWN0IHRyaWRlbnRmYl9wYXIgKnBhcikKIHsKIAl1bnNpZ25lZCBjaGFyIHRtcCwgdG1w
MjsKIAl1bnNpZ25lZCBpbnQgazsKQEAgLTc0Miw3ICs3NjEsNyBAQCBzdGF0aWMgdW5zaWduZWQg
aW50IF9fZGV2aW5pdCBnZXRfbWVtc2l6CiAJCQlrID0gMjU2MCAqIEtiOwogCQkJYnJlYWs7CiAJ
CWRlZmF1bHQ6Ci0JCQl0bXAgPSByZWFkM1g0KFNQUikgJiAweDBGOworCQkJdG1wID0gcmVhZDNY
NChwYXIsIFNQUikgJiAweDBGOwogCQkJc3dpdGNoICh0bXApIHsKIAogCQkJY2FzZSAweDAxOgpA
QCAtNzc0LDcgKzc5Myw3IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgX19kZXZpbml0IGdldF9tZW1z
aXoKIAkJCQlicmVhazsKIAkJCWNhc2UgMHgwRToJCS8qIFhQICovCiAKLQkJCQl0bXAyID0gcmVh
ZDNDNCgweEMxKTsKKwkJCQl0bXAyID0gcmVhZDNDNChwYXIsIDB4QzEpOwogCQkJCXN3aXRjaCAo
dG1wMikgewogCQkJCWNhc2UgMHgwMDoKIAkJCQkJayA9IDIwICogTWI7CkBAIC04NjIsNiArODgx
LDcgQEAgc3RhdGljIGludCB0cmlkZW50ZmJfY2hlY2tfdmFyKHN0cnVjdCBmYgogc3RhdGljIGlu
dCB0cmlkZW50ZmJfcGFuX2Rpc3BsYXkoc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIsCiAJ
CQkJIHN0cnVjdCBmYl9pbmZvICppbmZvKQogeworCXN0cnVjdCB0cmlkZW50ZmJfcGFyICpwYXIg
PSAoc3RydWN0IHRyaWRlbnRmYl9wYXIgKikoaW5mby0+cGFyKTsKIAl1bnNpZ25lZCBpbnQgb2Zm
c2V0OwogCiAJZGVidWcoImVudGVyXG4iKTsKQEAgLTg2OSwxMyArODg5LDIwIEBAIHN0YXRpYyBp
bnQgdHJpZGVudGZiX3Bhbl9kaXNwbGF5KHN0cnVjdCAKIAkJKiB2YXItPmJpdHNfcGVyX3BpeGVs
IC8gMzI7CiAJaW5mby0+dmFyLnhvZmZzZXQgPSB2YXItPnhvZmZzZXQ7CiAJaW5mby0+dmFyLnlv
ZmZzZXQgPSB2YXItPnlvZmZzZXQ7Ci0Jc2V0X3NjcmVlbl9zdGFydChvZmZzZXQpOworCXNldF9z
Y3JlZW5fc3RhcnQocGFyLCBvZmZzZXQpOwogCWRlYnVnKCJleGl0XG4iKTsKIAlyZXR1cm4gMDsK
IH0KIAotI2RlZmluZSBzaGFkb3dtb2RlX29uKCkgIHdyaXRlM0NFKEN5YmVyQ29udHJvbCwgcmVh
ZDNDRShDeWJlckNvbnRyb2wpIHwgMHg4MSkKLSNkZWZpbmUgc2hhZG93bW9kZV9vZmYoKSB3cml0
ZTNDRShDeWJlckNvbnRyb2wsIHJlYWQzQ0UoQ3liZXJDb250cm9sKSAmIDB4N0UpCitzdGF0aWMg
dm9pZCBzaGFkb3dtb2RlX29uKHN0cnVjdCB0cmlkZW50ZmJfcGFyICpwYXIpCit7CisJd3JpdGUz
Q0UocGFyLCBDeWJlckNvbnRyb2wsIHJlYWQzQ0UocGFyLCBDeWJlckNvbnRyb2wpIHwgMHg4MSk7
Cit9CisKK3N0YXRpYyB2b2lkIHNoYWRvd21vZGVfb2ZmKHN0cnVjdCB0cmlkZW50ZmJfcGFyICpw
YXIpCit7CisJd3JpdGUzQ0UocGFyLCBDeWJlckNvbnRyb2wsIHJlYWQzQ0UocGFyLCBDeWJlckNv
bnRyb2wpICYgMHg3RSk7Cit9CiAKIC8qIFNldCB0aGUgaGFyZHdhcmUgdG8gdGhlIHJlcXVlc3Rl
ZCB2aWRlbyBtb2RlICovCiBzdGF0aWMgaW50IHRyaWRlbnRmYl9zZXRfcGFyKHN0cnVjdCBmYl9p
bmZvICppbmZvKQpAQCAtOTA1LDggKzkzMiw4IEBAIHN0YXRpYyBpbnQgdHJpZGVudGZiX3NldF9w
YXIoc3RydWN0IGZiX2kKIAl2YmxhbmtzdGFydCA9IHZhci0+eXJlczsKIAl2YmxhbmtlbmQgPSB2
dG90YWwgKyAyOwogCi0JY3J0Y191bmxvY2soKTsKLQl3cml0ZTNDRShDeWJlckNvbnRyb2wsIDgp
OworCWNydGNfdW5sb2NrKHBhcik7CisJd3JpdGUzQ0UocGFyLCBDeWJlckNvbnRyb2wsIDgpOwog
CiAJaWYgKGZsYXRwYW5lbCAmJiB2YXItPnhyZXMgPCBuYXRpdmV4KSB7CiAJCS8qCkBAIC05MTQs
MzUgKzk0MSwzNiBAQCBzdGF0aWMgaW50IHRyaWRlbnRmYl9zZXRfcGFyKHN0cnVjdCBmYl9pCiAJ
CSAqIHRoYW4gcmVxdWVzdGVkIHJlc29sdXRpb24gZGVjaWRlIHdoZXRoZXIKIAkJICogd2Ugc3Ry
ZXRjaCBvciBjZW50ZXIKIAkJICovCi0JCXRfb3V0YigweEVCLCAweDNDMik7CisJCXRfb3V0Yihw
YXIsIDB4RUIsIDB4M0MyKTsKIAotCQlzaGFkb3dtb2RlX29uKCk7CisJCXNoYWRvd21vZGVfb24o
cGFyKTsKIAogCQlpZiAoY2VudGVyKQotCQkJc2NyZWVuX2NlbnRlcigpOworCQkJc2NyZWVuX2Nl
bnRlcihwYXIpOwogCQllbHNlIGlmIChzdHJldGNoKQotCQkJc2NyZWVuX3N0cmV0Y2goKTsKKwkJ
CXNjcmVlbl9zdHJldGNoKHBhcik7CiAKIAl9IGVsc2UgewotCQl0X291dGIoMHgyQiwgMHgzQzIp
OwotCQl3cml0ZTNDRShDeWJlckNvbnRyb2wsIDgpOworCQl0X291dGIocGFyLCAweDJCLCAweDND
Mik7CisJCXdyaXRlM0NFKHBhciwgQ3liZXJDb250cm9sLCA4KTsKIAl9CiAKIAkvKiB2ZXJ0aWNh
bCB0aW1pbmcgdmFsdWVzICovCi0Jd3JpdGUzWDQoQ1JUVlRvdGFsLCB2dG90YWwgJiAweEZGKTsK
LQl3cml0ZTNYNChDUlRWRGlzcEVuZCwgdmRpc3BlbmQgJiAweEZGKTsKLQl3cml0ZTNYNChDUlRW
U3luY1N0YXJ0LCB2c3luY3N0YXJ0ICYgMHhGRik7Ci0Jd3JpdGUzWDQoQ1JUVlN5bmNFbmQsICh2
c3luY2VuZCAmIDB4MEYpKTsKLQl3cml0ZTNYNChDUlRWQmxhbmtTdGFydCwgdmJsYW5rc3RhcnQg
JiAweEZGKTsKLQl3cml0ZTNYNChDUlRWQmxhbmtFbmQsIDAgLyogcC0+dmJsYW5rZW5kICYgMHhG
RiAqLyApOworCXdyaXRlM1g0KHBhciwgQ1JUVlRvdGFsLCB2dG90YWwgJiAweEZGKTsKKwl3cml0
ZTNYNChwYXIsIENSVFZEaXNwRW5kLCB2ZGlzcGVuZCAmIDB4RkYpOworCXdyaXRlM1g0KHBhciwg
Q1JUVlN5bmNTdGFydCwgdnN5bmNzdGFydCAmIDB4RkYpOworCXdyaXRlM1g0KHBhciwgQ1JUVlN5
bmNFbmQsICh2c3luY2VuZCAmIDB4MEYpKTsKKwl3cml0ZTNYNChwYXIsIENSVFZCbGFua1N0YXJ0
LCB2YmxhbmtzdGFydCAmIDB4RkYpOworCXdyaXRlM1g0KHBhciwgQ1JUVkJsYW5rRW5kLCAwIC8q
IHAtPnZibGFua2VuZCAmIDB4RkYgKi8pOwogCiAJLyogaG9yaXpvbnRhbCB0aW1pbmcgdmFsdWVz
ICovCi0Jd3JpdGUzWDQoQ1JUSFRvdGFsLCBodG90YWwgJiAweEZGKTsKLQl3cml0ZTNYNChDUlRI
RGlzcEVuZCwgaGRpc3BlbmQgJiAweEZGKTsKLQl3cml0ZTNYNChDUlRIU3luY1N0YXJ0LCBoc3lu
Y3N0YXJ0ICYgMHhGRik7Ci0Jd3JpdGUzWDQoQ1JUSFN5bmNFbmQsIChoc3luY2VuZCAmIDB4MUYp
IHwgKChoYmxhbmtlbmQgJiAweDIwKSA8PCAyKSk7Ci0Jd3JpdGUzWDQoQ1JUSEJsYW5rU3RhcnQs
IGhibGFua3N0YXJ0ICYgMHhGRik7Ci0Jd3JpdGUzWDQoQ1JUSEJsYW5rRW5kLCAwIC8qIChwLT5o
YmxhbmtlbmQgJiAweDFGKSAqLyApOworCXdyaXRlM1g0KHBhciwgQ1JUSFRvdGFsLCBodG90YWwg
JiAweEZGKTsKKwl3cml0ZTNYNChwYXIsIENSVEhEaXNwRW5kLCBoZGlzcGVuZCAmIDB4RkYpOwor
CXdyaXRlM1g0KHBhciwgQ1JUSFN5bmNTdGFydCwgaHN5bmNzdGFydCAmIDB4RkYpOworCXdyaXRl
M1g0KHBhciwgQ1JUSFN5bmNFbmQsCisJCSAoaHN5bmNlbmQgJiAweDFGKSB8ICgoaGJsYW5rZW5k
ICYgMHgyMCkgPDwgMikpOworCXdyaXRlM1g0KHBhciwgQ1JUSEJsYW5rU3RhcnQsIGhibGFua3N0
YXJ0ICYgMHhGRik7CisJd3JpdGUzWDQocGFyLCBDUlRIQmxhbmtFbmQsIDAgLyogKHAtPmhibGFu
a2VuZCAmIDB4MUYpICovKTsKIAogCS8qIGhpZ2hlciBiaXRzIG9mIHZlcnRpY2FsIHRpbWluZyB2
YWx1ZXMgKi8KIAl0bXAgPSAweDEwOwpAQCAtOTU0LDM1ICs5ODIsMzcgQEAgc3RhdGljIGludCB0
cmlkZW50ZmJfc2V0X3BhcihzdHJ1Y3QgZmJfaQogCWlmICh2dG90YWwgJiAweDIwMCkgdG1wIHw9
IDB4MjA7CiAJaWYgKHZkaXNwZW5kICYgMHgyMDApIHRtcCB8PSAweDQwOwogCWlmICh2c3luY3N0
YXJ0ICYgMHgyMDApIHRtcCB8PSAweDgwOwotCXdyaXRlM1g0KENSVE92ZXJmbG93LCB0bXApOwor
CXdyaXRlM1g0KHBhciwgQ1JUT3ZlcmZsb3csIHRtcCk7CiAKLQl0bXAgPSByZWFkM1g0KENSVEhp
T3JkKSB8IDB4MDg7CS8qIGxpbmUgY29tcGFyZSBiaXQgMTAgKi8KKwl0bXAgPSByZWFkM1g0KHBh
ciwgQ1JUSGlPcmQpIHwgMHgwODsJLyogbGluZSBjb21wYXJlIGJpdCAxMCAqLwogCWlmICh2dG90
YWwgJiAweDQwMCkgdG1wIHw9IDB4ODA7CiAJaWYgKHZibGFua3N0YXJ0ICYgMHg0MDApIHRtcCB8
PSAweDQwOwogCWlmICh2c3luY3N0YXJ0ICYgMHg0MDApIHRtcCB8PSAweDIwOwogCWlmICh2ZGlz
cGVuZCAmIDB4NDAwKSB0bXAgfD0gMHgxMDsKLQl3cml0ZTNYNChDUlRIaU9yZCwgdG1wKTsKKwl3
cml0ZTNYNChwYXIsIENSVEhpT3JkLCB0bXApOwogCiAJdG1wID0gMDsKIAlpZiAoaHRvdGFsICYg
MHg4MDApIHRtcCB8PSAweDgwMCA+PiAxMTsKIAlpZiAoaGJsYW5rc3RhcnQgJiAweDgwMCkgdG1w
IHw9IDB4ODAwID4+IDc7Ci0Jd3JpdGUzWDQoSG9yaXpPdmVyZmxvdywgdG1wKTsKKwl3cml0ZTNY
NChwYXIsIEhvcml6T3ZlcmZsb3csIHRtcCk7CiAKIAl0bXAgPSAweDQwOwogCWlmICh2Ymxhbmtz
dGFydCAmIDB4MjAwKSB0bXAgfD0gMHgyMDsKIC8vRklYTUUJaWYgKGluZm8tPnZhci52bW9kZSAm
IEZCX1ZNT0RFX0RPVUJMRSkgdG1wIHw9IDB4ODA7ICAvKiBkb3VibGUgc2NhbiBmb3IgMjAwIGxp
bmUgbW9kZXMgKi8KLQl3cml0ZTNYNChDUlRNYXhTY2FuTGluZSwgdG1wKTsKKwl3cml0ZTNYNChw
YXIsIENSVE1heFNjYW5MaW5lLCB0bXApOwogCi0Jd3JpdGUzWDQoQ1JUTGluZUNvbXBhcmUsIDB4
RkYpOwotCXdyaXRlM1g0KENSVFBSb3dTY2FuLCAwKTsKLQl3cml0ZTNYNChDUlRNb2RlQ29udHJv
bCwgMHhDMyk7CisJd3JpdGUzWDQocGFyLCBDUlRMaW5lQ29tcGFyZSwgMHhGRik7CisJd3JpdGUz
WDQocGFyLCBDUlRQUm93U2NhbiwgMCk7CisJd3JpdGUzWDQocGFyLCBDUlRNb2RlQ29udHJvbCwg
MHhDMyk7CiAKLQl3cml0ZTNYNChMaW5lYXJBZGRSZWcsIDB4MjApOwkvKiBlbmFibGUgbGluZWFy
IGFkZHJlc3NpbmcgKi8KKwl3cml0ZTNYNChwYXIsIExpbmVhckFkZFJlZywgMHgyMCk7CS8qIGVu
YWJsZSBsaW5lYXIgYWRkcmVzc2luZyAqLwogCiAJdG1wID0gKGluZm8tPnZhci52bW9kZSAmIEZC
X1ZNT0RFX0lOVEVSTEFDRUQpID8gMHg4NCA6IDB4ODA7Ci0Jd3JpdGUzWDQoQ1JUQ01vZHVsZVRl
c3QsIHRtcCk7CS8qIGVuYWJsZSBhY2Nlc3MgZXh0ZW5kZWQgbWVtb3J5ICovCisJLyogZW5hYmxl
IGFjY2VzcyBleHRlbmRlZCBtZW1vcnkgKi8KKwl3cml0ZTNYNChwYXIsIENSVENNb2R1bGVUZXN0
LCB0bXApOwogCi0Jd3JpdGUzWDQoR3JhcGhFbmdSZWcsIDB4ODApOwkvKiBlbmFibGUgR0UgZm9y
IHRleHQgYWNjZWxlcmF0aW9uICovCisJLyogZW5hYmxlIEdFIGZvciB0ZXh0IGFjY2VsZXJhdGlv
biAqLworCXdyaXRlM1g0KHBhciwgR3JhcGhFbmdSZWcsIDB4ODApOwogCiAjaWZkZWYgQ09ORklH
X0ZCX1RSSURFTlRfQUNDRUwKIAlhY2MtPmluaXRfYWNjZWwoaW5mby0+dmFyLnhyZXMsIGJwcCk7
CkBAIC0xMDAzLDQ5ICsxMDMzLDUyIEBAIHN0YXRpYyBpbnQgdHJpZGVudGZiX3NldF9wYXIoc3Ry
dWN0IGZiX2kKIAkJYnJlYWs7CiAJfQogCi0Jd3JpdGUzWDQoUGl4ZWxCdXNSZWcsIHRtcCk7CisJ
d3JpdGUzWDQocGFyLCBQaXhlbEJ1c1JlZywgdG1wKTsKIAogCXRtcCA9IDB4MTA7CiAJaWYgKGNo
aXBjeWJlcikKIAkJdG1wIHw9IDB4MjA7Ci0Jd3JpdGUzWDQoRFJBTUNvbnRyb2wsIHRtcCk7CS8q
IGJvdGggSU8sIGxpbmVhciBlbmFibGUgKi8KKwl3cml0ZTNYNChwYXIsIERSQU1Db250cm9sLCB0
bXApOwkvKiBib3RoIElPLCBsaW5lYXIgZW5hYmxlICovCiAKLQl3cml0ZTNYNChJbnRlcmZhY2VT
ZWwsIHJlYWQzWDQoSW50ZXJmYWNlU2VsKSB8IDB4NDApOwotCXdyaXRlM1g0KFBlcmZvcm1hbmNl
LCAweDkyKTsKLQl3cml0ZTNYNChQQ0lSZWcsIDB4MDcpOwkJLyogTU1JTyAmIFBDSSByZWFkIGFu
ZCB3cml0ZSBidXJzdCBlbmFibGUgKi8KKwl3cml0ZTNYNChwYXIsIEludGVyZmFjZVNlbCwgcmVh
ZDNYNChwYXIsIEludGVyZmFjZVNlbCkgfCAweDQwKTsKKwl3cml0ZTNYNChwYXIsIFBlcmZvcm1h
bmNlLCAweDkyKTsKKwkvKiBNTUlPICYgUENJIHJlYWQgYW5kIHdyaXRlIGJ1cnN0IGVuYWJsZSAq
LworCXdyaXRlM1g0KHBhciwgUENJUmVnLCAweDA3KTsKIAogCS8qIGNvbnZlcnQgZnJvbSBwaWNv
c2Vjb25kcyB0byBrSHogKi8KIAl2Y2xrID0gUElDT1MyS0haKGluZm8tPnZhci5waXhjbG9jayk7
CiAJaWYgKGJwcCA9PSAzMikKIAkJdmNsayAqPSAyOwotCXNldF92Y2xrKHZjbGspOworCXNldF92
Y2xrKHBhciwgdmNsayk7CiAKLQl3cml0ZTNDNCgwLCAzKTsKLQl3cml0ZTNDNCgxLCAxKTsJCS8q
IHNldCBjaGFyIGNsb2NrIDggZG90cyB3aWRlICovCi0Jd3JpdGUzQzQoMiwgMHgwRik7CS8qIGVu
YWJsZSA0IG1hcHMgYmVjYXVzZSBuZWVkZWQgaW4gY2hhaW40IG1vZGUgKi8KLQl3cml0ZTNDNCgz
LCAwKTsKLQl3cml0ZTNDNCg0LCAweDBFKTsJLyogbWVtb3J5IG1vZGUgZW5hYmxlIGJpdG1hcHMg
Pz8gKi8KLQotCXdyaXRlM0NFKE1pc2NFeHRGdW5jLCAoYnBwID09IDMyKSA/IDB4MUEgOiAweDEy
KTsJLyogZGl2aWRlIGNsb2NrIGJ5IDIgaWYgMzJicHAgKi8KLQkJCQkJCQkvKiBjaGFpbjQgbW9k
ZSBkaXNwbGF5IGFuZCBDUFUgcGF0aCAqLwotCXdyaXRlM0NFKDB4NSwgMHg0MCk7CS8qIG5vIENH
QSBjb21wYXQsIGFsbG93IDI1NiBjb2wgKi8KLQl3cml0ZTNDRSgweDYsIDB4MDUpOwkvKiBncmFw
aGljcyBtb2RlICovCi0Jd3JpdGUzQ0UoMHg3LCAweDBGKTsJLyogcGxhbmVzPyAqLworCXdyaXRl
M0M0KHBhciwgMCwgMyk7CisJd3JpdGUzQzQocGFyLCAxLCAxKTsJCS8qIHNldCBjaGFyIGNsb2Nr
IDggZG90cyB3aWRlICovCisJLyogZW5hYmxlIDQgbWFwcyBiZWNhdXNlIG5lZWRlZCBpbiBjaGFp
bjQgbW9kZSAqLworCXdyaXRlM0M0KHBhciwgMiwgMHgwRik7CisJd3JpdGUzQzQocGFyLCAzLCAw
KTsKKwl3cml0ZTNDNChwYXIsIDQsIDB4MEUpOwkvKiBtZW1vcnkgbW9kZSBlbmFibGUgYml0bWFw
cyA/PyAqLworCisJLyogZGl2aWRlIGNsb2NrIGJ5IDIgaWYgMzJicHAgY2hhaW40IG1vZGUgZGlz
cGxheSBhbmQgQ1BVIHBhdGggKi8KKwl3cml0ZTNDRShwYXIsIE1pc2NFeHRGdW5jLCAoYnBwID09
IDMyKSA/IDB4MUEgOiAweDEyKTsKKwl3cml0ZTNDRShwYXIsIDB4NSwgMHg0MCk7CS8qIG5vIENH
QSBjb21wYXQsIGFsbG93IDI1NiBjb2wgKi8KKwl3cml0ZTNDRShwYXIsIDB4NiwgMHgwNSk7CS8q
IGdyYXBoaWNzIG1vZGUgKi8KKwl3cml0ZTNDRShwYXIsIDB4NywgMHgwRik7CS8qIHBsYW5lcz8g
Ki8KIAogCWlmIChjaGlwX2lkID09IENZQkVSQkxBREVYUEFpMSkgewogCQkvKiBUaGlzIGZpeGVz
IHNub3ctZWZmZWN0IGluIDMyIGJwcCAqLwotCQl3cml0ZTNYNChDUlRIU3luY1N0YXJ0LCAweDg0
KTsKKwkJd3JpdGUzWDQocGFyLCBDUlRIU3luY1N0YXJ0LCAweDg0KTsKIAl9CiAKLQl3cml0ZUF0
dHIoMHgxMCwgMHg0MSk7CS8qIGdyYXBoaWNzIG1vZGUgYW5kIHN1cHBvcnQgMjU2IGNvbG9yIG1v
ZGVzICovCi0Jd3JpdGVBdHRyKDB4MTIsIDB4MEYpOwkvKiBwbGFuZXMgKi8KLQl3cml0ZUF0dHIo
MHgxMywgMCk7CS8qIGhvcml6b250YWwgcGVsIHBhbm5pbmcgKi8KKwkvKiBncmFwaGljcyBtb2Rl
IGFuZCBzdXBwb3J0IDI1NiBjb2xvciBtb2RlcyAqLworCXdyaXRlQXR0cihwYXIsIDB4MTAsIDB4
NDEpOworCXdyaXRlQXR0cihwYXIsIDB4MTIsIDB4MEYpOwkvKiBwbGFuZXMgKi8KKwl3cml0ZUF0
dHIocGFyLCAweDEzLCAwKTsJLyogaG9yaXpvbnRhbCBwZWwgcGFubmluZyAqLwogCiAJLyogY29s
b3JzICovCiAJZm9yICh0bXAgPSAwOyB0bXAgPCAweDEwOyB0bXArKykKLQkJd3JpdGVBdHRyKHRt
cCwgdG1wKTsKLQlyZWFkYihwYXItPmlvX3ZpcnQgKyBDUlQgKyAweDBBKTsJLyogZmxpcC1mbG9w
IHRvIGluZGV4ICovCi0JdF9vdXRiKDB4MjAsIDB4M0MwKTsJCQkvKiBlbmFibGUgYXR0ciAqLwor
CQl3cml0ZUF0dHIocGFyLCB0bXAsIHRtcCk7CisJZmJfcmVhZGIocGFyLT5pb192aXJ0ICsgQ1JU
ICsgMHgwQSk7CS8qIGZsaXAtZmxvcCB0byBpbmRleCAqLworCXRfb3V0YihwYXIsIDB4MjAsIDB4
M0MwKTsJCS8qIGVuYWJsZSBhdHRyICovCiAKIAlzd2l0Y2ggKGJwcCkgewogCWNhc2UgODoKQEAg
LTEwNjMsMTcgKzEwOTYsMTcgQEAgc3RhdGljIGludCB0cmlkZW50ZmJfc2V0X3BhcihzdHJ1Y3Qg
ZmJfaQogCQlicmVhazsKIAl9CiAKLQl0X2luYigweDNDOCk7Ci0JdF9pbmIoMHgzQzYpOwotCXRf
aW5iKDB4M0M2KTsKLQl0X2luYigweDNDNik7Ci0JdF9pbmIoMHgzQzYpOwotCXRfb3V0Yih0bXAs
IDB4M0M2KTsKLQl0X2luYigweDNDOCk7CisJdF9pbmIocGFyLCAweDNDOCk7CisJdF9pbmIocGFy
LCAweDNDNik7CisJdF9pbmIocGFyLCAweDNDNik7CisJdF9pbmIocGFyLCAweDNDNik7CisJdF9p
bmIocGFyLCAweDNDNik7CisJdF9vdXRiKHBhciwgdG1wLCAweDNDNik7CisJdF9pbmIocGFyLCAw
eDNDOCk7CiAKIAlpZiAoZmxhdHBhbmVsKQotCQlzZXRfbnVtYmVyX29mX2xpbmVzKGluZm8tPnZh
ci55cmVzKTsKLQlzZXRfbHdpZHRoKGluZm8tPnZhci54cmVzICogYnBwIC8gKDQgKiAxNikpOwor
CQlzZXRfbnVtYmVyX29mX2xpbmVzKHBhciwgaW5mby0+dmFyLnlyZXMpOworCXNldF9sd2lkdGgo
cGFyLCBpbmZvLT52YXIueHJlcyAqIGJwcCAvICg0ICogMTYpKTsKIAlpbmZvLT5maXgudmlzdWFs
ID0gKGJwcCA9PSA4KSA/IEZCX1ZJU1VBTF9QU0VVRE9DT0xPUiA6IEZCX1ZJU1VBTF9UUlVFQ09M
T1I7CiAJaW5mby0+Zml4LmxpbmVfbGVuZ3RoID0gaW5mby0+dmFyLnhyZXMgKiAoYnBwID4+IDMp
OwogCWluZm8tPmNtYXAubGVuID0gKGJwcCA9PSA4KSA/IDI1NiA6IDE2OwpAQCAtMTA4NywxNyAr
MTEyMCwxOCBAQCBzdGF0aWMgaW50IHRyaWRlbnRmYl9zZXRjb2xyZWcodW5zaWduZWQgCiAJCQkg
ICAgICAgc3RydWN0IGZiX2luZm8gKmluZm8pCiB7CiAJaW50IGJwcCA9IGluZm8tPnZhci5iaXRz
X3Blcl9waXhlbDsKKwlzdHJ1Y3QgdHJpZGVudGZiX3BhciAqcGFyID0gKHN0cnVjdCB0cmlkZW50
ZmJfcGFyKilpbmZvLT5wYXI7CiAKIAlpZiAocmVnbm8gPj0gaW5mby0+Y21hcC5sZW4pCiAJCXJl
dHVybiAxOwogCiAJaWYgKGJwcCA9PSA4KSB7Ci0JCXRfb3V0YigweEZGLCAweDNDNik7Ci0JCXRf
b3V0YihyZWdubywgMHgzQzgpOworCQl0X291dGIocGFyLCAweEZGLCAweDNDNik7CisJCXRfb3V0
YihwYXIsIHJlZ25vLCAweDNDOCk7CiAKLQkJdF9vdXRiKHJlZCA+PiAxMCwgMHgzQzkpOwotCQl0
X291dGIoZ3JlZW4gPj4gMTAsIDB4M0M5KTsKLQkJdF9vdXRiKGJsdWUgPj4gMTAsIDB4M0M5KTsK
KwkJdF9vdXRiKHBhciwgcmVkID4+IDEwLCAweDNDOSk7CisJCXRfb3V0YihwYXIsIGdyZWVuID4+
IDEwLCAweDNDOSk7CisJCXRfb3V0YihwYXIsIGJsdWUgPj4gMTAsIDB4M0M5KTsKIAogCX0gZWxz
ZSBpZiAocmVnbm8gPCAxNikgewogCQlpZiAoYnBwID09IDE2KSB7CS8qIFJHQiA1NjUgKi8KQEAg
LTExMjMsMTMgKzExNTcsMTQgQEAgc3RhdGljIGludCB0cmlkZW50ZmJfc2V0Y29scmVnKHVuc2ln
bmVkIAogc3RhdGljIGludCB0cmlkZW50ZmJfYmxhbmsoaW50IGJsYW5rX21vZGUsIHN0cnVjdCBm
Yl9pbmZvICppbmZvKQogewogCXVuc2lnbmVkIGNoYXIgUE1Db250LCBEUE1TQ29udDsKKwlzdHJ1
Y3QgdHJpZGVudGZiX3BhciAqcGFyID0gKHN0cnVjdCB0cmlkZW50ZmJfcGFyKilpbmZvLT5wYXI7
CiAKIAlkZWJ1ZygiZW50ZXJcbiIpOwogCWlmIChmbGF0cGFuZWwpCiAJCXJldHVybiAwOwotCXRf
b3V0YigweDA0LCAweDgzQzgpOyAvKiBSZWFkIERQTVMgQ29udHJvbCAqLwotCVBNQ29udCA9IHRf
aW5iKDB4ODNDNikgJiAweEZDOwotCURQTVNDb250ID0gcmVhZDNDRShQb3dlclN0YXR1cykgJiAw
eEZDOworCXRfb3V0YihwYXIsIDB4MDQsIDB4ODNDOCk7IC8qIFJlYWQgRFBNUyBDb250cm9sICov
CisJUE1Db250ID0gdF9pbmIocGFyLCAweDgzQzYpICYgMHhGQzsKKwlEUE1TQ29udCA9IHJlYWQz
Q0UocGFyLCBQb3dlclN0YXR1cykgJiAweEZDOwogCXN3aXRjaCAoYmxhbmtfbW9kZSkgewogCWNh
c2UgRkJfQkxBTktfVU5CTEFOSzoKIAkJLyogU2NyZWVuOiBPbiwgSFN5bmM6IE9uLCBWU3luYzog
T24gKi8KQEAgLTExNTUsOSArMTE5MCw5IEBAIHN0YXRpYyBpbnQgdHJpZGVudGZiX2JsYW5rKGlu
dCBibGFua19tb2QKIAkJYnJlYWs7CiAJfQogCi0Jd3JpdGUzQ0UoUG93ZXJTdGF0dXMsIERQTVND
b250KTsKLQl0X291dGIoNCwgMHg4M0M4KTsKLQl0X291dGIoUE1Db250LCAweDgzQzYpOworCXdy
aXRlM0NFKHBhciwgUG93ZXJTdGF0dXMsIERQTVNDb250KTsKKwl0X291dGIocGFyLCA0LCAweDgz
QzgpOworCXRfb3V0YihwYXIsIFBNQ29udCwgMHg4M0M2KTsKIAogCWRlYnVnKCJleGl0XG4iKTsK
IApAQCAtMTI2NSwxMSArMTMwMCwxMSBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCB0cmlkZW50X3Bj
aV9wcm9iZShzCiAKIAkvKiBzZXR1cCBmcmFtZWJ1ZmZlciBtZW1vcnkgKi8KIAl0cmlkZW50ZmJf
Zml4LnNtZW1fc3RhcnQgPSBwY2lfcmVzb3VyY2Vfc3RhcnQoZGV2LCAwKTsKLQl0cmlkZW50ZmJf
Zml4LnNtZW1fbGVuID0gZ2V0X21lbXNpemUoKTsKKwl0cmlkZW50ZmJfZml4LnNtZW1fbGVuID0g
Z2V0X21lbXNpemUoJmRlZmF1bHRfcGFyKTsKIAogCWlmICghcmVxdWVzdF9tZW1fcmVnaW9uKHRy
aWRlbnRmYl9maXguc21lbV9zdGFydCwgdHJpZGVudGZiX2ZpeC5zbWVtX2xlbiwgInRyaWRlbnRm
YiIpKSB7CiAJCWRlYnVnKCJyZXF1ZXN0X21lbV9yZWdpb24gZmFpbGVkIVxuIik7Ci0JCWRpc2Fi
bGVfbW1pbygpOworCQlkaXNhYmxlX21taW8oZmJfaW5mby5wYXIpOwogCQllcnIgPSAtMTsKIAkJ
Z290byBvdXRfdW5tYXAxOwogCX0KQEAgLTEyODQsMTAgKzEzMTksMTAgQEAgc3RhdGljIGludCBf
X2RldmluaXQgdHJpZGVudF9wY2lfcHJvYmUocwogCX0KIAogCW91dHB1dCgiJXMgYm9hcmQgZm91
bmRcbiIsIHBjaV9uYW1lKGRldikpOwotCWRpc3BsYXl0eXBlID0gZ2V0X2Rpc3BsYXl0eXBlKCk7
CisJZGlzcGxheXR5cGUgPSBnZXRfZGlzcGxheXR5cGUoJmRlZmF1bHRfcGFyKTsKIAogCWlmIChm
bGF0cGFuZWwpCi0JCW5hdGl2ZXggPSBnZXRfbmF0aXZleCgpOworCQluYXRpdmV4ID0gZ2V0X25h
dGl2ZXgoJmRlZmF1bHRfcGFyKTsKIAogCWZiX2luZm8uZml4ID0gdHJpZGVudGZiX2ZpeDsKIAlm
Yl9pbmZvLmZib3BzID0gJnRyaWRlbnRmYl9vcHM7CkBAIC0xMzMwLDcgKzEzNjUsNyBAQCBvdXRf
dW5tYXAyOgogCWlmIChmYl9pbmZvLnNjcmVlbl9iYXNlKQogCQlpb3VubWFwKGZiX2luZm8uc2Ny
ZWVuX2Jhc2UpOwogCXJlbGVhc2VfbWVtX3JlZ2lvbih0cmlkZW50ZmJfZml4LnNtZW1fc3RhcnQs
IHRyaWRlbnRmYl9maXguc21lbV9sZW4pOwotCWRpc2FibGVfbW1pbygpOworCWRpc2FibGVfbW1p
byhmYl9pbmZvLnBhcik7CiBvdXRfdW5tYXAxOgogCWlmIChkZWZhdWx0X3Bhci5pb192aXJ0KQog
CQlpb3VubWFwKGRlZmF1bHRfcGFyLmlvX3ZpcnQpOwo=

--part481add658c35d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--part481add658c35d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part481add658c35d--
