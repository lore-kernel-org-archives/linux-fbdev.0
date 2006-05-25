From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 2.6.17-rc4-mm3] intelfb use default modedb table
Date: Thu, 25 May 2006 17:30:58 -0400
Message-ID: <C9EC694F-679D-4487-A715-42D80ABAA539@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FjNPn-0005xx-Hq
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 14:30:43 -0700
Received: from mail2.sea5.speakeasy.net ([69.17.117.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FjNPn-0001Et-CW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 14:30:43 -0700
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

This changes the intelfb driver to use the default modedb table  
instead of the VESA mode table.

regards,
dennis

---

From: Dennis Munsie <dmunsie@cecropia.com>

intelfb driver -- use the regular modedb table instead of the VESA  
modedb
table.  Ideally, the 9xx stride patch should be applied first, since  
there
are modes in the VESA table that won't work without that patch.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

drivers/video/intelfb/intelfbdrv.c |    6 ++----
1 file changed, 2 insertions(+), 4 deletions(-)

diff -Naurp -X linux-2.6.17-rc4-9xx-stride/Documentation/dontdiff  
linux-2.6.17-rc4-9xx-stride/drivers/video/intelfb/intelfbdrv.c  
linux-2.6.17-rc4-use-default-modedb-table/drivers/video/intelfb/ 
intelfbdrv.c
--- linux-2.6.17-rc4-9xx-stride/drivers/video/intelfb/intelfbdrv.c	 
2006-05-25 16:18:15.000000000 -0500
+++ linux-2.6.17-rc4-use-default-modedb-table/drivers/video/intelfb/ 
intelfbdrv.c	2006-05-25 16:19:51.000000000 -0500
@@ -1059,8 +1059,7 @@ intelfb_init_var(struct intelfb_info *di
				       "intelfb: looking for mode in global "
				       "database ");
				msrc = fb_find_mode(var, dinfo->info, mode,
-						    vesa_modes,
-						    VESA_MODEDB_SIZE, NULL, 0);
+						    NULL, 0, NULL, 0);
				if (msrc)
					msrc |= 8;
@@ -1070,8 +1069,7 @@ intelfb_init_var(struct intelfb_info *di
		if (!msrc) {
			msrc = fb_find_mode(var, dinfo->info, PREFERRED_MODE,
-					    vesa_modes, VESA_MODEDB_SIZE,
-					    NULL, 0);
+					    NULL, 0, NULL, 0);
		}
	}



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
