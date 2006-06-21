From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 2.6.17-1] radeonfb: use generic ddc read
	functionality
Date: Wed, 21 Jun 2006 16:52:06 -0400
Message-ID: <08F6FAE0-AA73-44C4-B9B8-CB76508D24FF@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ft9cs-000677-DX for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 13:48:38 -0700
Received: from mail5.sea5.speakeasy.net ([69.17.117.7])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ft9co-0005Ha-2w
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 13:48:35 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Eric Hustvedt <ehustvedt@cecropia.com>

hello --

here is that patch i promised in my last email.  This simply changes  
the radeonfb driver from using it's current method of reading the  
EDID block to using the new functionality that I put into fbmon.c.   
I've been able to test it on a radeon card I have here, and it  
appears to work just fine.  Again, I would like to get some feedback  
from other people that I haven't broke it for their configuration.

while i'm thinking of it, there are other drivers that appear to have  
their own code to handle reading the EDID over DDC.  I would modify  
these in the same manor as the radeonfb driver, but I don't have any  
of the cards to even test with.  It should be a straightforward  
modification if anyone wants to try it out.  The drivers are:  i810,  
matrox, riva, savage, and possibly sis.  There are a few drivers that  
setup DDC busses, but in my quick scan, I couldn't tell if they  
actually use them or not.

dennis

---

From: Dennis Munsie <dmunsie@cecropia.com>

Uses the generic ddc read functionality in fbmon.c instead of the
previous functionality.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

drivers/video/aty/radeon_i2c.c |  104  
-----------------------------------------
1 file changed, 1 insertion(+), 103 deletions(-)

diff -Naurp -X linux-2.6.17.1-patched/Documentation/dontdiff  
linux-2.6.17.1-patched/drivers/video/aty/radeon_i2c.c linux/drivers/ 
video/aty/radeon_i2c.c
--- linux-2.6.17.1-patched/drivers/video/aty/radeon_i2c.c	2006-03-20  
00:53:29.000000000 -0500
+++ linux/drivers/video/aty/radeon_i2c.c	2006-06-21  
15:45:53.000000000 -0500
@@ -17,8 +17,6 @@
#include "radeonfb.h"
#include "../edid.h"
-#define RADEON_DDC 	0x50
-
static void radeon_gpio_setscl(void* data, int state)
{
	struct radeon_i2c_chan 	*chan = data;
@@ -139,109 +137,9 @@ void radeon_delete_i2c_busses(struct rad
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
int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn,  
u8 **out_edid)
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
-
+	u8 *edid = fb_ddc_read(&rinfo->i2c[conn-1].adapter);
	if (out_edid)
		*out_edid = edid;
	if (!edid) {


All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
