From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] Remove voodoo code from i2c
Date: Fri, 5 Mar 2004 22:52:10 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040305215210.GA23402@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AzNT0-0007fy-HJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Mar 2004 14:06:50 -0800
Received: from mailr-2.tiscali.it ([212.123.84.82])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AzMtr-0000HO-BL
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Mar 2004 13:30:31 -0800
Content-Disposition: inline
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
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi,
radeon_probe_i2c_connector contains very strange code that just send
empty start-stop sequencies on the I2C bus. I copied the code from
XFree86, but speaking with I2C gurus the general feeling is that this
code can go away without any harm. I tested it on 3 different setup (all
x86...) and it works well. I don't have any "old" monitor around to
fiddle with though.

Oh, if you think that this code should stay I'll send you another patch
to make it more readable.

===== drivers/video/aty/radeon_i2c.c 1.3 vs edited =====
--- 1.3/drivers/video/aty/radeon_i2c.c	Wed Feb 18 07:02:05 2004
+++ edited/drivers/video/aty/radeon_i2c.c	Fri Mar  5 22:44:21 2004
@@ -180,59 +180,9 @@
 	OUTREG(reg, INREG(reg) & 
 			~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));
 
-	OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
-	(void)INREG(reg);
-
 	for (i = 0; i < 3; i++) {
-		/* For some old monitors we need the
-		 * following process to initialize/stop DDC
-		 */
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
-		(void)INREG(reg);
-		wait_ms(13);
-
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
-		for (j = 0; j < 5; j++) {
-			wait_ms(10);
-			if (INREG(reg) & VGA_DDC_CLK_INPUT)
-				break;
-		}
-		if (j == 5)
-			continue;
-
-		OUTREG(reg, INREG(reg) | VGA_DDC_DATA_OUT_EN);
-		(void)INREG(reg);
-		wait_ms(15);
-		OUTREG(reg, INREG(reg) | VGA_DDC_CLK_OUT_EN);
-		(void)INREG(reg);
-		wait_ms(15);
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
-		(void)INREG(reg);
-		wait_ms(15);
-
 		/* Do the real work */
 		edid = radeon_do_probe_i2c_edid(&rinfo->i2c[conn-1]);
-
-		OUTREG(reg, INREG(reg) | 
-				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
-		wait_ms(15);
-		
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
-		for (j = 0; j < 10; j++) {
-			wait_ms(10);
-			if (INREG(reg) & VGA_DDC_CLK_INPUT)
-				break;
-		}
-
-		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
-		(void)INREG(reg);
-		wait_ms(15);
-		OUTREG(reg, INREG(reg) |
-				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
-		(void)INREG(reg);
 		if (edid)
 			break;
 	}

Luca
-- 
Home: http://kronoz.cjb.net
Runtime error 6D at f000:a12f : user incompetente


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
