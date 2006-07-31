From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 13/13] radeonfb: Use generic DDC reading
Date: Tue, 01 Aug 2006 07:40:02 +0800
Message-ID: <44CE94D2.1000907@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7i6s-0007NX-Be for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 17:27:46 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7hP1-0004Mn-3e
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:42:27 -0700
Received: by py-out-1112.google.com with SMTP id d42so802545pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 31 Jul 2006 16:42:26 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dennis Munsie <dmunsie@cecropia.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Dennis Munsie <dmunsie@cecropia.com>

Uses the generic ddc read functionality in fbmon.c instead of the
previous functionality.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/Kconfig          |    1 
 drivers/video/aty/radeon_i2c.c |  106 +---------------------------------------
 2 files changed, 4 insertions(+), 103 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index efc6912..522cb37 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1018,6 +1018,7 @@ config FB_RADEON
 	depends on FB && PCI
 	select I2C_ALGOBIT if FB_RADEON_I2C
 	select I2C if FB_RADEON_I2C
+	select FB_DDC if FB_RADEON_I2C
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/drivers/video/aty/radeon_i2c.c b/drivers/video/aty/radeon_i2c.c
index 9aaca58..6767545 100644
--- a/drivers/video/aty/radeon_i2c.c
+++ b/drivers/video/aty/radeon_i2c.c
@@ -16,8 +16,6 @@ #include <video/radeon.h>
 #include "radeonfb.h"
 #include "../edid.h"
 
-#define RADEON_DDC 	0x50
-
 static void radeon_gpio_setscl(void* data, int state)
 {
 	struct radeon_i2c_chan 	*chan = data;
@@ -138,108 +136,10 @@ void radeon_delete_i2c_busses(struct rad
 	rinfo->i2c[3].rinfo = NULL;
 }
 
-
-static u8 *radeon_do_probe_i2c_edid(struct radeon_i2c_chan *chan)
-{
-	u8 start = 0x0;
-	struct i2c_msg msgs[] = {
-		{
-			.addr	= RADEON_DDC,
-			.len	= 1,
-			.buf	= &start,
-		}, {
-			.addr	= RADEON_DDC,
-			.flags	= I2C_M_RD,
-			.len	= EDID_LENGTH,
-		},
-	};
-	u8 *buf;
-
-	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
-	if (!buf) {
-		dev_warn(&chan->rinfo->pdev->dev, "Out of memory!\n");
-		return NULL;
-	}
-	msgs[1].buf = buf;
-
-	if (i2c_transfer(&chan->adapter, msgs, 2) == 2)
-		return buf;
-	dev_dbg(&chan->rinfo->pdev->dev, "Unable to read EDID block.\n");
-	kfree(buf);
-	return NULL;
-}
-
-
-int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid)
+int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn,
+			       u8 **out_edid)
 {
-	u32 reg = rinfo->i2c[conn-1].ddc_reg;
-	u8 *edid = NULL;
-	int i, j;
-
-	OUTREG(reg, INREG(reg) & 
-			~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));
-
-	OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
-	(void)INREG(reg);
-
-	for (i = 0; i < 3; i++) {
-		/* For some old monitors we need the
-		 * following process to initialize/stop DDC
-		 */
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
-		(void)INREG(reg);
-		msleep(13);
-
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
-		for (j = 0; j < 5; j++) {
-			msleep(10);
-			if (INREG(reg) & VGA_DDC_CLK_INPUT)
-				break;
-		}
-		if (j == 5)
-			continue;
-
-		OUTREG(reg, INREG(reg) | VGA_DDC_DATA_OUT_EN);
-		(void)INREG(reg);
-		msleep(15);
-		OUTREG(reg, INREG(reg) | VGA_DDC_CLK_OUT_EN);
-		(void)INREG(reg);
-		msleep(15);
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
-		(void)INREG(reg);
-		msleep(15);
-
-		/* Do the real work */
-		edid = radeon_do_probe_i2c_edid(&rinfo->i2c[conn-1]);
-
-		OUTREG(reg, INREG(reg) | 
-				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
-		msleep(15);
-		
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
-		for (j = 0; j < 10; j++) {
-			msleep(10);
-			if (INREG(reg) & VGA_DDC_CLK_INPUT)
-				break;
-		}
-
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
-		(void)INREG(reg);
-		msleep(15);
-		OUTREG(reg, INREG(reg) |
-				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
-		if (edid)
-			break;
-	}
-	/* Release the DDC lines when done or the Apple Cinema HD display
-	 * will switch off
-	 */
-	OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN | VGA_DDC_DATA_OUT_EN));
-	(void)INREG(reg);
+	u8 *edid = fb_ddc_read(&rinfo->i2c[conn-1].adapter);
 
 	if (out_edid)
 		*out_edid = edid;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
