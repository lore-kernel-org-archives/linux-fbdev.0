From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] radeonfb: DDC i2c fix
Date: Fri, 11 Mar 2005 16:46:10 +1100
Message-ID: <1110519970.5751.17.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9cya-0007Ft-Pw
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Mar 2005 21:46:20 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D9cyZ-00054n-4f
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Mar 2005 21:46:20 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi !

The radeonfb code for DDC probing (like it's X.org counterpart) uses to
leave the DDC clock & data lines asserted after the probing is complete.
This causes problems with some Apple monitors like the new Cinema HD
23", who will turn themselves off when that happens. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/aty/radeon_i2c.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_i2c.c	2005-01-24 17:09:44.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_i2c.c	2005-03-04 17:26:42.000000000 +1100
@@ -236,6 +236,12 @@
 		if (edid)
 			break;
 	}
+	/* Release the DDC lines when done or the Apple Cinema HD display
+	 * will switch off
+	 */
+	OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN | VGA_DDC_DATA_OUT_EN));
+	(void)INREG(reg);
+
 	if (out_edid)
 		*out_edid = edid;
 	if (!edid) {





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
