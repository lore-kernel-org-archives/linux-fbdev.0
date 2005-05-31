From: sylvain.meyer@worldonline.fr
Subject: [patch 1/2] intelfb fix accel detection when changing video modes
Date: Tue, 31 May 2005 19:34:05 +0200
Message-ID: <20050531173405.4CC4D10000AA@mwinf0703.wanadoo.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DdAd7-0004N8-1e
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 31 May 2005 10:34:17 -0700
Received: from smtp7.wanadoo.fr ([193.252.22.24])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DdAd5-0000Ub-Dm
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 31 May 2005 10:34:16 -0700
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0703.wanadoo.fr (SMTP Server) with ESMTP id 022401000047
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 31 May 2005 19:34:06 +0200 (CEST)
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@osdl.org, adaplas@pol.net, sylvain.meyer@worldonline.fr


From: Sylvain Meyer <sylvain.meyer@worldonline.fr>

Changed the tests in intelfb_set_par to check also the parameter var.accel_flags. If null, do nothing about ring buffers.
Now, the DirectFB i830 driver could nicely work even if intelfb is hw accelerated. Just change the /etc/fb.modes file to disable console hw acceleration when starting a DirectFB app.

Signed-off-by: Sylvain Meyer <sylvain.meyer@worldonline.fr>
---

 linux-2.6.12-rc4-root/drivers/video/intelfb/intelfbdrv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/video/intelfb/intelfbdrv.c~intelfb-accel-fix drivers/video/intelfb/intelfbdrv.c
--- linux-2.6.12-rc4/drivers/video/intelfb/intelfbdrv.c~intelfb-accel-fix	2005-05-31 18:57:12.000000000 +0200
+++ linux-2.6.12-rc4-root/drivers/video/intelfb/intelfbdrv.c	2005-05-31 18:57:12.000000000 +0200
@@ -1301,7 +1301,7 @@ intelfb_set_par(struct fb_info *info)
 
 	intelfb_blank(FB_BLANK_POWERDOWN, info);
 
-	if (dinfo->accel)
+	if (ACCEL(dinfo, info))
 		intelfbhw_2d_stop(dinfo);
 
  	memcpy(hw, &dinfo->save_state, sizeof(*hw));
@@ -1317,7 +1317,7 @@ intelfb_set_par(struct fb_info *info)
 
 	update_dinfo(dinfo, &info->var);
 
-	if (dinfo->accel)
+	if (ACCEL(dinfo, info))
 		intelfbhw_2d_start(dinfo);
 
 	intelfb_pan_display(&info->var, info);
_



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
