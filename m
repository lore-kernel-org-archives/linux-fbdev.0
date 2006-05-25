From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 2.6.17-rc4-mm3] intelfb 945G/GM video fix
Date: Thu, 25 May 2006 16:38:45 -0400
Message-ID: <06E28340-802B-4587-9A76-75A59127F7F9@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FjMbK-00083a-S2
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 13:38:34 -0700
Received: from mail7.sea5.speakeasy.net ([69.17.117.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FjMbJ-0004Be-OC
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 13:38:34 -0700
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
Content-Type: text/plain; charset="us-ascii"; delsp="yes"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, Dave Airlie <airlied@skynet.ie>, Sylvain Meyer <sylvain.meyer@worldonline.fr>

Hi all,

This is a small patch that I would like others to take a look at.  We  
ran into an issue where on the motherboard we are using, Intel  
D945GTP, the video wouldn't come up in the proper state even with  
Dave Airlie's patches for 945.  I had created a 945 patch that I  
hadn't released, and that one did work.  The only difference between  
the two was that I had a one line hack to write to the DPLL register  
twice.  Now, this should be harmless on other chipsets, but I can't  
be sure without testing.  I've tried asking Intel about this, but I  
haven't gotten any information on it from them.

any feedback would be appreciated.

dennis

---

From: Dennis Munsie <dmunsie@cecropia.com>

Writes to the DPLL register twice which fixes a problem on my machine  
where the
video doesn't come up at all.  This has been tested on a Intel  
D945GTP board
and also on a Intel D915GUXL board.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

drivers/video/intelfb/intelfbhw.c |    1 +
1 file changed, 1 insertion(+)

diff -Naurp -X linux-2.6.17-rc4-intelfb-mm/Documentation/dontdiff  
linux-2.6.17-rc4-intelfb-mm/drivers/video/intelfb/intelfbhw.c  
linux-2.6.17-rc4-945_fix/drivers/video/intelfb/intelfbhw.c
--- linux-2.6.17-rc4-intelfb-mm/drivers/video/intelfb/intelfbhw.c	 
2006-05-25 15:16:44.000000000 -0500
+++ linux-2.6.17-rc4-945_fix/drivers/video/intelfb/intelfbhw.c	 
2006-05-25 15:31:45.000000000 -0500
@@ -1384,6 +1384,7 @@ intelfbhw_program_mode(struct intelfb_in
	tmp = INREG(dpll_reg);
	tmp |= DPLL_VCO_ENABLE;
	OUTREG(dpll_reg, tmp);
+	OUTREG(dpll_reg, tmp); /* twice for the 945G/GM chipsets -- others  
should ignore it */
	/* Set DVOs B/C */
	OUTREG(DVOB, hw->dvob);



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
