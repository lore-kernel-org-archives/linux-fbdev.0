From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 2.6.17-rc5-mm1] EDID cleanup
Date: Wed, 31 May 2006 11:08:24 -0400
Message-ID: <AFBA4E6B-73B8-46EA-A7F6-A233BC78CE93@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlSIG-0004FT-Ve
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 08:07:32 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FlSIG-0004bI-Nt
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 08:07:32 -0700
Received: from mail4.sea5.speakeasy.net ([69.17.117.6])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FlSIF-0005RA-Dq
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 08:07:32 -0700
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
Cc: Dave Airlie <airlied@skynet.ie>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, Eric Hustvedt <ehustvedt@cecropia.com>

Just a small patch to remove a hard buffer size.

---

From: Dennis Munsie <dmunsie@cecropia.com>

Removed hard coded EDID buffer size.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

drivers/video/intelfb/intelfbdrv.c |    4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff -Naurp -X linux-2.6.17-rc5-mm1/Documentation/dontdiff  
linux-2.6.17-rc5-mm1/drivers/video/intelfb/intelfbdrv.c linux-2.6.17- 
rc5-edid-cleanup/drivers/video/intelfb/intelfbdrv.c
--- linux-2.6.17-rc5-mm1/drivers/video/intelfb/intelfbdrv.c	 
2006-05-31 10:11:12.000000000 -0500
+++ linux-2.6.17-rc5-edid-cleanup/drivers/video/intelfb/intelfbdrv.c	 
2006-05-31 10:10:55.000000000 -0500
@@ -1036,10 +1036,10 @@ intelfb_init_var(struct intelfb_info *di
		u8 *edid_d = NULL;
		if (edid_s) {
-			edid_d = kmalloc(128, GFP_KERNEL);
+			edid_d = kmalloc(EDID_LENGTH, GFP_KERNEL);
			if (edid_d) {
-				memcpy(edid_d, edid_s, 128);
+				memcpy(edid_d, edid_s, EDID_LENGTH);
				fb_edid_to_monspecs(edid_d,
						    &dinfo->info->monspecs);
				kfree(edid_d);





-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
