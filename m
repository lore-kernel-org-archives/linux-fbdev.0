From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/video/radeonfb.c: fix an array overflow
Date: Sun, 27 Mar 2005 22:31:53 +0200
Message-ID: <20050327203153.GS4285@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DFeRE-0003hO-AL
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 27 Mar 2005 12:32:48 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5] helo=mailout.stusta.mhn.de)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DFeRD-00086G-M3
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 27 Mar 2005 12:32:48 -0800
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: ajoshi@shell.unixbox.com
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net, linux-kernel@vger.kernel.org

This patch fixes an array overflow found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/video/radeonfb.c.old	2005-03-23 01:50:14.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/video/radeonfb.c	2005-03-23 01:50:30.000000000 +0100
@@ -2107,7 +2107,7 @@ static void radeon_write_mode (struct ra
 
 
 	if (rinfo->arch == RADEON_M6) {
-		for (i=0; i<8; i++)
+		for (i=0; i<7; i++)
 			OUTREG(common_regs_m6[i].reg, common_regs_m6[i].val);
 	} else {
 		for (i=0; i<9; i++)



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
