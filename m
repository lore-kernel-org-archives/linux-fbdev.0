From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: [PATCH] Remove voodoo code from i2c
Date: Sat, 6 Mar 2004 01:47:47 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040306004747.GA3218@dreamland.darkstar.lan>
References: <20040305215210.GA23402@dreamland.darkstar.lan> <1078530914.5700.127.camel@gaston>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AzQD0-0006mq-Qr
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Mar 2004 17:02:30 -0800
Received: from mailr-2.tiscali.it ([212.123.84.82])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AzPyc-0003jQ-J7
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Mar 2004 16:47:38 -0800
Content-Disposition: inline
In-Reply-To: <1078530914.5700.127.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Sat, Mar 06, 2004 at 10:55:14AM +1100, Benjamin Herrenschmidt ha scritto: 
> On Sat, 2004-03-06 at 08:52, Kronos wrote:
> > Hi,
> > radeon_probe_i2c_connector contains very strange code that just send
> > empty start-stop sequencies on the I2C bus. I copied the code from
> > XFree86, but speaking with I2C gurus the general feeling is that this
> > code can go away without any harm. I tested it on 3 different setup (all
> > x86...) and it works well. I don't have any "old" monitor around to
> > fiddle with though.
> > 
> > Oh, if you think that this code should stay I'll send you another patch
> > to make it more readable.
> 
> I'd rather keep the code as close to XFree as possible at this point..

Ok, what about this (cosmetic) patch:

--- linux-2.6/drivers/video/aty/radeon_i2c.c.orig	Sat Feb 28 18:11:42 2004
+++ linux-2.6/drivers/video/aty/radeon_i2c.c	Sat Feb 28 18:49:31 2004
@@ -174,65 +174,59 @@
 int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid)
 {
 	u32 reg = rinfo->i2c[conn-1].ddc_reg;
+	struct radeon_i2c_chan *chan = &rinfo->i2c[conn-1];
 	u8 *edid = NULL;
 	int i, j;
 
 	OUTREG(reg, INREG(reg) & 
 			~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));
 
-	OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
-	(void)INREG(reg);
+	radeon_gpio_setscl(chan, 1);
 
 	for (i = 0; i < 3; i++) {
 		/* For some old monitors we need the
 		 * following process to initialize/stop DDC
 		 */
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
-		(void)INREG(reg);
+		radeon_gpio_setsda(chan, 1);
 		wait_ms(13);
 
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
+		radeon_gpio_setscl(chan, 1);
 		for (j = 0; j < 5; j++) {
+			/* Wait for ack */
 			wait_ms(10);
-			if (INREG(reg) & VGA_DDC_CLK_INPUT)
+			if (radeon_gpio_getscl(chan))
 				break;
 		}
 		if (j == 5)
 			continue;
 
-		OUTREG(reg, INREG(reg) | VGA_DDC_DATA_OUT_EN);
-		(void)INREG(reg);
+		radeon_gpio_setsda(chan, 0);
 		wait_ms(15);
-		OUTREG(reg, INREG(reg) | VGA_DDC_CLK_OUT_EN);
-		(void)INREG(reg);
+		radeon_gpio_setscl(chan, 0);
 		wait_ms(15);
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
-		(void)INREG(reg);
+		radeon_gpio_setsda(chan, 1);
 		wait_ms(15);
 
 		/* Do the real work */
-		edid = radeon_do_probe_i2c_edid(&rinfo->i2c[conn-1]);
+		edid = radeon_do_probe_i2c_edid(chan);
 
-		OUTREG(reg, INREG(reg) | 
-				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
+		radeon_gpio_setsda(chan, 0);
+		radeon_gpio_setscl(chan, 0);
 		wait_ms(15);
-		
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
+	
+		radeon_gpio_setscl(chan, 1);
 		for (j = 0; j < 10; j++) {
+			/* Wait for ack */
 			wait_ms(10);
-			if (INREG(reg) & VGA_DDC_CLK_INPUT)
+			if (radeon_gpio_getscl(chan))
 				break;
 		}
 
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
-		(void)INREG(reg);
+		radeon_gpio_setsda(chan, 1);
 		wait_ms(15);
-		OUTREG(reg, INREG(reg) |
-				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
+
+		radeon_gpio_setsda(chan, 0);
+		radeon_gpio_setscl(chan, 0);
 		if (edid)
 			break;
 	}

In this way it clearer what's going on.

Luca
-- 
Home: http://kronoz.cjb.net
"Sei l'unica donna della mia vita".
(Adamo)


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
