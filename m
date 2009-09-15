From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/2] fbdev: use both register sets for display panning
Date: Tue, 15 Sep 2009 14:00:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0909151357590.4640@axis700.grange>
References: <Pine.LNX.4.64.0909151354340.4640@axis700.grange>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0909151354340.4640@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, linux-fbdev-devel@lists.sourceforge.net

From: Phil Edworthy <phil.edworthy@renesas.com>

Switch to using both register sets - side A and side B for display panning.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/board-ap325rxa.c      |    2 +-
 arch/sh/boards/mach-ecovec24/setup.c |    2 +-
 arch/sh/boards/mach-kfr2r09/setup.c  |    2 +-
 arch/sh/boards/mach-migor/setup.c    |    2 +-
 arch/sh/boards/mach-se/7724/setup.c  |    2 +-
 drivers/video/sh_mobile_lcdcfb.c     |   47 +++++++++++++++++++++++++++++++--
 6 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/arch/sh/boards/board-ap325rxa.c b/arch/sh/boards/board-ap325rxa.c
index 9c97301..6675763 100644
--- a/arch/sh/boards/board-ap325rxa.c
+++ b/arch/sh/boards/board-ap325rxa.c
@@ -211,7 +211,7 @@ static struct resource lcdc_resources[] = {
 	[0] = {
 		.name	= "LCDC",
 		.start	= 0xfe940000, /* P4-only space */
-		.end	= 0xfe941fff,
+		.end	= 0xfe942fff,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 428d118..08627bd 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -235,7 +235,7 @@ static struct resource lcdc_resources[] = {
 	[0] = {
 		.name	= "LCDC",
 		.start	= 0xfe940000,
-		.end	= 0xfe941fff,
+		.end	= 0xfe942fff,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 7155be0..c08d33f 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -162,7 +162,7 @@ static struct resource kfr2r09_sh_lcdc_resources[] = {
 	[0] = {
 		.name	= "LCDC",
 		.start	= 0xfe940000, /* P4-only space */
-		.end	= 0xfe941fff,
+		.end	= 0xfe942fff,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index be8f0d9..6ed1fd3 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -279,7 +279,7 @@ static struct resource migor_lcdc_resources[] = {
 	[0] = {
 		.name	= "LCDC",
 		.start	= 0xfe940000, /* P4-only space */
-		.end	= 0xfe941fff,
+		.end	= 0xfe942fff,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 1876c83..00973e0 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -166,7 +166,7 @@ static struct resource lcdc_resources[] = {
 	[0] = {
 		.name	= "LCDC",
 		.start	= 0xfe940000,
-		.end	= 0xfe941fff,
+		.end	= 0xfe942fff,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 7f30cb3..3ad5157 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -23,6 +23,8 @@
 #include <asm/atomic.h>
 
 #define PALETTE_NR 16
+#define SIDE_B_OFFSET 0x1000
+#define MIRROR_OFFSET 0x2000
 
 /* shared registers */
 #define _LDDCKR 0x410
@@ -100,6 +102,10 @@ static unsigned long lcdc_offs_sublcd[NR_CH_REGS] = {
 #define LDINTR_FS	0x00000004
 #define LDINTR_VSS	0x00000002
 #define LDINTR_VES	0x00000001
+#define LDRCNTR_SRS	0x00020000
+#define LDRCNTR_SRC	0x00010000
+#define LDRCNTR_MRS	0x00000002
+#define LDRCNTR_MRC	0x00000001
 
 struct sh_mobile_lcdc_priv;
 struct sh_mobile_lcdc_chan {
@@ -132,10 +138,39 @@ struct sh_mobile_lcdc_priv {
 	int started;
 };
 
+static bool banked(int reg_nr)
+{
+	switch (reg_nr) {
+	case LDMT1R:
+	case LDMT2R:
+	case LDMT3R:
+	case LDDFR:
+	case LDSM1R:
+	case LDSA1R:
+	case LDMLSR:
+	case LDHCNR:
+	case LDHSYNR:
+	case LDVLNR:
+	case LDVSYNR:
+		return true;
+	}
+	return false;
+}
+
 static void lcdc_write_chan(struct sh_mobile_lcdc_chan *chan,
 			    int reg_nr, unsigned long data)
 {
 	iowrite32(data, chan->lcdc->base + chan->reg_offs[reg_nr]);
+	if (banked(reg_nr))
+		iowrite32(data, chan->lcdc->base + chan->reg_offs[reg_nr] +
+			  SIDE_B_OFFSET);
+}
+
+static void lcdc_write_chan_mirror(struct sh_mobile_lcdc_chan *chan,
+			    int reg_nr, unsigned long data)
+{
+	iowrite32(data, chan->lcdc->base + chan->reg_offs[reg_nr] +
+		  MIRROR_OFFSET);
 }
 
 static unsigned long lcdc_read_chan(struct sh_mobile_lcdc_chan *chan,
@@ -308,10 +343,16 @@ static irqreturn_t sh_mobile_lcdc_irq(int irq, void *data)
 
 		/* VSYNC End */
 		if (ldintr & LDINTR_VES) {
+			unsigned long ldrcntr = lcdc_read(priv, _LDRCNTR);
 			/* Set the source address for the next refresh */
-			lcdc_write_chan(ch, LDSA1R, ch->dma_handle +
-					ch->new_pan_offset);
-			lcdc_write(ch->lcdc, _LDRCNTR, 0);
+			lcdc_write_chan_mirror(ch, LDSA1R, ch->dma_handle +
+					       ch->new_pan_offset);
+			if (lcdc_chan_is_sublcd(ch))
+				lcdc_write(ch->lcdc, _LDRCNTR,
+					   ldrcntr ^ LDRCNTR_SRS);
+			else
+				lcdc_write(ch->lcdc, _LDRCNTR,
+					   ldrcntr ^ LDRCNTR_MRS);
 			ch->pan_offset = ch->new_pan_offset;
 		}
 	}
-- 
1.6.2.4

