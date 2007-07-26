From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 33/33] tdfxfb: palette fixes
Date: Thu, 26 Jul 2007 20:52:50 +0800
Message-ID: <46A89922.9010002@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2x3-0001QF-6L for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 06:00:21 -0700
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2x2-0000Ts-S0
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 06:00:21 -0700
Received: by wa-out-1112.google.com with SMTP id k22so615223waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 06:00:20 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes:
- palette setting in 8-bit mode (aka 'funky penguin')
- grayscale handling
- adds proper barriers in xxx_inb/outb functions

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/tdfxfb.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index 2566683..c032f6f 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -35,7 +35,6 @@
  * driver by Ilario Nardinocchi, which in turn is based on skeletonfb.
  *
  * TODO:
- * - support for 16/32 bpp needs fixing (funky bootup penguin)
  * - multihead support (basically need to support an array of fb_infos)
  * - support other architectures (PPC, Alpha); does the fact that the VGA
  *   core can be accessed only thru I/O (not memory mapped) complicate
@@ -184,30 +183,38 @@ #endif
 static inline void gra_outb(struct tdfx_par *par, u32 idx, u8 val)
 {
 	vga_outb(par, GRA_I, idx);
+	wmb();
 	vga_outb(par, GRA_D, val);
+	wmb();
 }
 
 static inline void seq_outb(struct tdfx_par *par, u32 idx, u8 val)
 {
 	vga_outb(par, SEQ_I, idx);
+	wmb();
 	vga_outb(par, SEQ_D, val);
+	wmb();
 }
 
 static inline u8 seq_inb(struct tdfx_par *par, u32 idx)
 {
 	vga_outb(par, SEQ_I, idx);
+	mb();
 	return vga_inb(par, SEQ_D);
 }
 
 static inline void crt_outb(struct tdfx_par *par, u32 idx, u8 val)
 {
 	vga_outb(par, CRT_I, idx);
+	wmb();
 	vga_outb(par, CRT_D, val);
+	wmb();
 }
 
 static inline u8 crt_inb(struct tdfx_par *par, u32 idx)
 {
 	vga_outb(par, CRT_I, idx);
+	mb();
 	return vga_inb(par, CRT_D);
 }
 
@@ -243,6 +250,7 @@ static inline void vga_enable_video(stru
 static inline void vga_enable_palette(struct tdfx_par *par)
 {
 	vga_inb(par, IS1_R);
+	mb();
 	vga_outb(par, ATT_IW, 0x20);
 }
 
@@ -286,6 +294,8 @@ static inline void do_setpalentry(struct
 {  
 	banshee_make_room(par, 2);
 	tdfx_outl(par, DACADDR, regno);
+	/* read after write makes it working */
+	tdfx_inl(par, DACADDR);
 	tdfx_outl(par, DACDATA, c);
 }
 
@@ -771,6 +781,12 @@ static int tdfxfb_setcolreg(unsigned reg
 	if (regno >= info->cmap.len || regno > 255)
 		return 1;
 
+	/* grayscale works only partially under directcolor */
+	if (info->var.grayscale) {
+		/* grayscale = 0.30*R + 0.59*G + 0.11*B */
+		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
+	}
+
 	switch (info->fix.visual) {
 	case FB_VISUAL_PSEUDOCOLOR:
 		rgbcol =(((u32)red   & 0xff00) << 8) |


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
